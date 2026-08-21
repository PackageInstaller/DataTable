return {
	Play317151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317151001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K09h"

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
				local var_4_5 = arg_1_1.bgs_.K09h

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
					if iter_4_0 ~= "K09h" then
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
			local var_4_23 = 0.433333333333333

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

			local var_4_28 = 0.533333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

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
			local var_4_35 = 0.675

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

				local var_4_37 = arg_1_1:GetWordFromCfg(317151001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 27
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
	Play317151002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317151002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317151003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.075

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

				local var_12_2 = arg_9_1:GetWordFromCfg(317151002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 43
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
	Play317151003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317151003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317151004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.075

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(317151003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 3
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317151004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317151004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317151005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.225

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

				local var_20_2 = arg_17_1:GetWordFromCfg(317151004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 49
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
	Play317151005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317151005
		arg_21_1.duration_ = 8.37

		local var_21_0 = {
			zh = 8.366,
			ja = 6.533
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
				arg_21_0:Play317151006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10053ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["10053ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10053ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(-0.7, -1.12, -5.99)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10053ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["10053ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10053ui_story == nil then
				arg_21_1.var_.characterEffect10053ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect10053ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10053ui_story then
				arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = 0
			local var_24_21 = 1

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_22 = arg_21_1:FormatText(StoryNameCfg[477].name)

				arg_21_1.leftNameTxt_.text = var_24_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_23 = arg_21_1:GetWordFromCfg(317151005)
				local var_24_24 = arg_21_1:FormatText(var_24_23.content)

				arg_21_1.text_.text = var_24_24

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_25 = 40
				local var_24_26 = utf8.len(var_24_24)
				local var_24_27 = var_24_25 <= 0 and var_24_21 or var_24_21 * (var_24_26 / var_24_25)

				if var_24_27 > 0 and var_24_21 < var_24_27 then
					arg_21_1.talkMaxDuration = var_24_27

					if var_24_27 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_20
					end
				end

				arg_21_1.text_.text = var_24_24
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151005", "story_v_out_317151.awb") ~= 0 then
					local var_24_28 = manager.audio:GetVoiceLength("story_v_out_317151", "317151005", "story_v_out_317151.awb") / 1000

					if var_24_28 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_20
					end

					if var_24_23.prefab_name ~= "" and arg_21_1.actors_[var_24_23.prefab_name] ~= nil then
						local var_24_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_23.prefab_name].transform, "story_v_out_317151", "317151005", "story_v_out_317151.awb")

						arg_21_1:RecordAudio("317151005", var_24_29)
						arg_21_1:RecordAudio("317151005", var_24_29)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317151", "317151005", "story_v_out_317151.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317151", "317151005", "story_v_out_317151.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_30 = math.max(var_24_21, arg_21_1.talkMaxDuration)

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_30 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_30

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_30 and arg_21_1.time_ < var_24_20 + var_24_30 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317151006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317151006
		arg_25_1.duration_ = 3.07

		local var_25_0 = {
			zh = 3.066,
			ja = 2.733
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
				arg_25_0:Play317151007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1049ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1049ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1049ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0.7, -1.2, -6)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1049ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["1049ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect1049ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_20 = arg_25_1.actors_["10053ui_story"]
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 and not isNil(var_28_20) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = var_28_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_22 = 0.200000002980232

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 and not isNil(var_28_20) then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22

				if arg_25_1.var_.characterEffect10053ui_story and not isNil(var_28_20) then
					local var_28_24 = Mathf.Lerp(0, 0.5, var_28_23)

					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_24
				end
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 and not isNil(var_28_20) and arg_25_1.var_.characterEffect10053ui_story then
				local var_28_25 = 0.5

				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_25
			end

			local var_28_26 = 0
			local var_28_27 = 0.35

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_28 = arg_25_1:FormatText(StoryNameCfg[551].name)

				arg_25_1.leftNameTxt_.text = var_28_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_29 = arg_25_1:GetWordFromCfg(317151006)
				local var_28_30 = arg_25_1:FormatText(var_28_29.content)

				arg_25_1.text_.text = var_28_30

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_31 = 14
				local var_28_32 = utf8.len(var_28_30)
				local var_28_33 = var_28_31 <= 0 and var_28_27 or var_28_27 * (var_28_32 / var_28_31)

				if var_28_33 > 0 and var_28_27 < var_28_33 then
					arg_25_1.talkMaxDuration = var_28_33

					if var_28_33 + var_28_26 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_33 + var_28_26
					end
				end

				arg_25_1.text_.text = var_28_30
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151006", "story_v_out_317151.awb") ~= 0 then
					local var_28_34 = manager.audio:GetVoiceLength("story_v_out_317151", "317151006", "story_v_out_317151.awb") / 1000

					if var_28_34 + var_28_26 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_26
					end

					if var_28_29.prefab_name ~= "" and arg_25_1.actors_[var_28_29.prefab_name] ~= nil then
						local var_28_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_29.prefab_name].transform, "story_v_out_317151", "317151006", "story_v_out_317151.awb")

						arg_25_1:RecordAudio("317151006", var_28_35)
						arg_25_1:RecordAudio("317151006", var_28_35)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317151", "317151006", "story_v_out_317151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317151", "317151006", "story_v_out_317151.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_36 = math.max(var_28_27, arg_25_1.talkMaxDuration)

			if var_28_26 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_36 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_26) / var_28_36

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_26 + var_28_36 and arg_25_1.time_ < var_28_26 + var_28_36 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317151007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317151007
		arg_29_1.duration_ = 5.53

		local var_29_0 = {
			zh = 5.533,
			ja = 5.2
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
				arg_29_0:Play317151008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10053ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10053ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10053ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10053ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10053ui_story == nil then
				arg_29_1.var_.characterEffect10053ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10053ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10053ui_story then
				arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_15 = arg_29_1.actors_["1049ui_story"].transform
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.var_.moveOldPos1049ui_story = var_32_15.localPosition
			end

			local var_32_17 = 0.001

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Vector3.New(0.7, -1.2, -6)

				var_32_15.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1049ui_story, var_32_19, var_32_18)

				local var_32_20 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_20.x, var_32_20.y, var_32_20.z)

				local var_32_21 = var_32_15.localEulerAngles

				var_32_21.z = 0
				var_32_21.x = 0
				var_32_15.localEulerAngles = var_32_21
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				var_32_15.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_32_22 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_22.x, var_32_22.y, var_32_22.z)

				local var_32_23 = var_32_15.localEulerAngles

				var_32_23.z = 0
				var_32_23.x = 0
				var_32_15.localEulerAngles = var_32_23
			end

			local var_32_24 = arg_29_1.actors_["1049ui_story"]
			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect1049ui_story == nil then
				arg_29_1.var_.characterEffect1049ui_story = var_32_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_26 = 0.200000002980232

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_26 and not isNil(var_32_24) then
				local var_32_27 = (arg_29_1.time_ - var_32_25) / var_32_26

				if arg_29_1.var_.characterEffect1049ui_story and not isNil(var_32_24) then
					local var_32_28 = Mathf.Lerp(0, 0.5, var_32_27)

					arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_28
				end
			end

			if arg_29_1.time_ >= var_32_25 + var_32_26 and arg_29_1.time_ < var_32_25 + var_32_26 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect1049ui_story then
				local var_32_29 = 0.5

				arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_29
			end

			local var_32_30 = 0
			local var_32_31 = 0.45

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[477].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_33 = arg_29_1:GetWordFromCfg(317151007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 18
				local var_32_36 = utf8.len(var_32_34)
				local var_32_37 = var_32_35 <= 0 and var_32_31 or var_32_31 * (var_32_36 / var_32_35)

				if var_32_37 > 0 and var_32_31 < var_32_37 then
					arg_29_1.talkMaxDuration = var_32_37

					if var_32_37 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_30
					end
				end

				arg_29_1.text_.text = var_32_34
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151007", "story_v_out_317151.awb") ~= 0 then
					local var_32_38 = manager.audio:GetVoiceLength("story_v_out_317151", "317151007", "story_v_out_317151.awb") / 1000

					if var_32_38 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_38 + var_32_30
					end

					if var_32_33.prefab_name ~= "" and arg_29_1.actors_[var_32_33.prefab_name] ~= nil then
						local var_32_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_33.prefab_name].transform, "story_v_out_317151", "317151007", "story_v_out_317151.awb")

						arg_29_1:RecordAudio("317151007", var_32_39)
						arg_29_1:RecordAudio("317151007", var_32_39)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317151", "317151007", "story_v_out_317151.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317151", "317151007", "story_v_out_317151.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_40 = math.max(var_32_31, arg_29_1.talkMaxDuration)

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_40 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_30) / var_32_40

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_30 + var_32_40 and arg_29_1.time_ < var_32_30 + var_32_40 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play317151008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317151008
		arg_33_1.duration_ = 3.53

		local var_33_0 = {
			zh = 2.133,
			ja = 3.533
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
				arg_33_0:Play317151009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10053ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10053ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_5
			end

			local var_36_6 = arg_33_1.actors_["1049ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1049ui_story == nil then
				arg_33_1.var_.characterEffect1049ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect1049ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1049ui_story then
				arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_11 = 0
			local var_36_12 = 0.25

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[551].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(317151008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 10
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151008", "story_v_out_317151.awb") ~= 0 then
					local var_36_19 = manager.audio:GetVoiceLength("story_v_out_317151", "317151008", "story_v_out_317151.awb") / 1000

					if var_36_19 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_11
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_317151", "317151008", "story_v_out_317151.awb")

						arg_33_1:RecordAudio("317151008", var_36_20)
						arg_33_1:RecordAudio("317151008", var_36_20)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317151", "317151008", "story_v_out_317151.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317151", "317151008", "story_v_out_317151.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_21 and arg_33_1.time_ < var_36_11 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play317151009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317151009
		arg_37_1.duration_ = 11.93

		local var_37_0 = {
			zh = 11.5,
			ja = 11.933
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
				arg_37_0:Play317151010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10053ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10053ui_story == nil then
				arg_37_1.var_.characterEffect10053ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10053ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10053ui_story then
				arg_37_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_40_5 = arg_37_1.actors_["1049ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.200000002980232

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect1049ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1049ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1049ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1049ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 1.125

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[477].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(317151009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 45
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151009", "story_v_out_317151.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_317151", "317151009", "story_v_out_317151.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_317151", "317151009", "story_v_out_317151.awb")

						arg_37_1:RecordAudio("317151009", var_40_20)
						arg_37_1:RecordAudio("317151009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317151", "317151009", "story_v_out_317151.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317151", "317151009", "story_v_out_317151.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317151010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317151010
		arg_41_1.duration_ = 8.63

		local var_41_0 = {
			zh = 8.633,
			ja = 4.4
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
				arg_41_0:Play317151011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.9

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[477].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(317151010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 36
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151010", "story_v_out_317151.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151010", "story_v_out_317151.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_317151", "317151010", "story_v_out_317151.awb")

						arg_41_1:RecordAudio("317151010", var_44_9)
						arg_41_1:RecordAudio("317151010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317151", "317151010", "story_v_out_317151.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317151", "317151010", "story_v_out_317151.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317151011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317151011
		arg_45_1.duration_ = 5.47

		local var_45_0 = {
			zh = 3.466,
			ja = 5.466
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
				arg_45_0:Play317151012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10053ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story == nil then
				arg_45_1.var_.characterEffect10053ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10053ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10053ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10053ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["1049ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1049ui_story == nil then
				arg_45_1.var_.characterEffect1049ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1049ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1049ui_story then
				arg_45_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_11 = 0
			local var_48_12 = 0.325

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[551].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(317151011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 13
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151011", "story_v_out_317151.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_317151", "317151011", "story_v_out_317151.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_317151", "317151011", "story_v_out_317151.awb")

						arg_45_1:RecordAudio("317151011", var_48_20)
						arg_45_1:RecordAudio("317151011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317151", "317151011", "story_v_out_317151.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317151", "317151011", "story_v_out_317151.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play317151012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317151012
		arg_49_1.duration_ = 10.87

		local var_49_0 = {
			zh = 10.6,
			ja = 10.866
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
				arg_49_0:Play317151013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1049ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1049ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1049ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1049ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1049ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["10053ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10053ui_story == nil then
				arg_49_1.var_.characterEffect10053ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect10053ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10053ui_story then
				arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_52_10 = 0
			local var_52_11 = 1.075

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[477].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(317151012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 43
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151012", "story_v_out_317151.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_317151", "317151012", "story_v_out_317151.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_317151", "317151012", "story_v_out_317151.awb")

						arg_49_1:RecordAudio("317151012", var_52_19)
						arg_49_1:RecordAudio("317151012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317151", "317151012", "story_v_out_317151.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317151", "317151012", "story_v_out_317151.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play317151013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317151013
		arg_53_1.duration_ = 13.4

		local var_53_0 = {
			zh = 13.4,
			ja = 9.8
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
				arg_53_0:Play317151014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.025

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[477].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(317151013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151013", "story_v_out_317151.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151013", "story_v_out_317151.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_317151", "317151013", "story_v_out_317151.awb")

						arg_53_1:RecordAudio("317151013", var_56_9)
						arg_53_1:RecordAudio("317151013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317151", "317151013", "story_v_out_317151.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317151", "317151013", "story_v_out_317151.awb")
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
	Play317151014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317151014
		arg_57_1.duration_ = 6.57

		local var_57_0 = {
			zh = 6.566,
			ja = 4.766
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
				arg_57_0:Play317151015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.625

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[477].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(317151014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151014", "story_v_out_317151.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151014", "story_v_out_317151.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_317151", "317151014", "story_v_out_317151.awb")

						arg_57_1:RecordAudio("317151014", var_60_9)
						arg_57_1:RecordAudio("317151014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317151", "317151014", "story_v_out_317151.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317151", "317151014", "story_v_out_317151.awb")
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
	Play317151015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317151015
		arg_61_1.duration_ = 9.97

		local var_61_0 = {
			zh = 9.966,
			ja = 6.2
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
				arg_61_0:Play317151016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.7

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[477].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(317151015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151015", "story_v_out_317151.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151015", "story_v_out_317151.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_317151", "317151015", "story_v_out_317151.awb")

						arg_61_1:RecordAudio("317151015", var_64_9)
						arg_61_1:RecordAudio("317151015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317151", "317151015", "story_v_out_317151.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317151", "317151015", "story_v_out_317151.awb")
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
	Play317151016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317151016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317151017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10053ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10053ui_story == nil then
				arg_65_1.var_.characterEffect10053ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10053ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10053ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10053ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10053ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.4

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

				local var_68_8 = arg_65_1:GetWordFromCfg(317151016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 56
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
	Play317151017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317151017
		arg_69_1.duration_ = 6.2

		local var_69_0 = {
			zh = 1.999999999999,
			ja = 6.2
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
				arg_69_0:Play317151018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1049ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1049ui_story == nil then
				arg_69_1.var_.characterEffect1049ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1049ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1049ui_story then
				arg_69_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_5 = 0
			local var_72_6 = 0.2

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_7 = arg_69_1:FormatText(StoryNameCfg[551].name)

				arg_69_1.leftNameTxt_.text = var_72_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(317151017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151017", "story_v_out_317151.awb") ~= 0 then
					local var_72_13 = manager.audio:GetVoiceLength("story_v_out_317151", "317151017", "story_v_out_317151.awb") / 1000

					if var_72_13 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_5
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_317151", "317151017", "story_v_out_317151.awb")

						arg_69_1:RecordAudio("317151017", var_72_14)
						arg_69_1:RecordAudio("317151017", var_72_14)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317151", "317151017", "story_v_out_317151.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317151", "317151017", "story_v_out_317151.awb")
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
	Play317151018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317151018
		arg_73_1.duration_ = 2.63

		local var_73_0 = {
			zh = 2.633,
			ja = 1.999999999999
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
				arg_73_0:Play317151019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10053ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10053ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10053ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["10053ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10053ui_story == nil then
				arg_73_1.var_.characterEffect10053ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10053ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10053ui_story then
				arg_73_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_2")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_15 = arg_73_1.actors_["1049ui_story"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos1049ui_story = var_76_15.localPosition
			end

			local var_76_17 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Vector3.New(0.7, -1.2, -6)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1049ui_story, var_76_19, var_76_18)

				local var_76_20 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_20.x, var_76_20.y, var_76_20.z)

				local var_76_21 = var_76_15.localEulerAngles

				var_76_21.z = 0
				var_76_21.x = 0
				var_76_15.localEulerAngles = var_76_21
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_76_22 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_22.x, var_76_22.y, var_76_22.z)

				local var_76_23 = var_76_15.localEulerAngles

				var_76_23.z = 0
				var_76_23.x = 0
				var_76_15.localEulerAngles = var_76_23
			end

			local var_76_24 = arg_73_1.actors_["1049ui_story"]
			local var_76_25 = 0

			if var_76_25 < arg_73_1.time_ and arg_73_1.time_ <= var_76_25 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = var_76_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_26 = 0.200000002980232

			if var_76_25 <= arg_73_1.time_ and arg_73_1.time_ < var_76_25 + var_76_26 and not isNil(var_76_24) then
				local var_76_27 = (arg_73_1.time_ - var_76_25) / var_76_26

				if arg_73_1.var_.characterEffect1049ui_story and not isNil(var_76_24) then
					local var_76_28 = Mathf.Lerp(0, 0.5, var_76_27)

					arg_73_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1049ui_story.fillRatio = var_76_28
				end
			end

			if arg_73_1.time_ >= var_76_25 + var_76_26 and arg_73_1.time_ < var_76_25 + var_76_26 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1049ui_story then
				local var_76_29 = 0.5

				arg_73_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1049ui_story.fillRatio = var_76_29
			end

			local var_76_30 = 0
			local var_76_31 = 0.1

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_32 = arg_73_1:FormatText(StoryNameCfg[477].name)

				arg_73_1.leftNameTxt_.text = var_76_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_33 = arg_73_1:GetWordFromCfg(317151018)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 4
				local var_76_36 = utf8.len(var_76_34)
				local var_76_37 = var_76_35 <= 0 and var_76_31 or var_76_31 * (var_76_36 / var_76_35)

				if var_76_37 > 0 and var_76_31 < var_76_37 then
					arg_73_1.talkMaxDuration = var_76_37

					if var_76_37 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_37 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_34
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151018", "story_v_out_317151.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_317151", "317151018", "story_v_out_317151.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_317151", "317151018", "story_v_out_317151.awb")

						arg_73_1:RecordAudio("317151018", var_76_39)
						arg_73_1:RecordAudio("317151018", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317151", "317151018", "story_v_out_317151.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317151", "317151018", "story_v_out_317151.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_40 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_40 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_40

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_40 and arg_73_1.time_ < var_76_30 + var_76_40 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317151019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317151019
		arg_77_1.duration_ = 6.17

		local var_77_0 = {
			zh = 4.433,
			ja = 6.166
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
				arg_77_0:Play317151020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10053ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10053ui_story == nil then
				arg_77_1.var_.characterEffect10053ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10053ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10053ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10053ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10053ui_story.fillRatio = var_80_5
			end

			local var_80_6 = arg_77_1.actors_["1049ui_story"]
			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1049ui_story == nil then
				arg_77_1.var_.characterEffect1049ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 and not isNil(var_80_6) then
				local var_80_9 = (arg_77_1.time_ - var_80_7) / var_80_8

				if arg_77_1.var_.characterEffect1049ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1049ui_story then
				arg_77_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_80_10 = 0
			local var_80_11 = 0.425

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[551].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(317151019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 17
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151019", "story_v_out_317151.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_317151", "317151019", "story_v_out_317151.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_317151", "317151019", "story_v_out_317151.awb")

						arg_77_1:RecordAudio("317151019", var_80_19)
						arg_77_1:RecordAudio("317151019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317151", "317151019", "story_v_out_317151.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317151", "317151019", "story_v_out_317151.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play317151020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317151020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317151021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1049ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1049ui_story == nil then
				arg_81_1.var_.characterEffect1049ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1049ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1049ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1049ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1049ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.6

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(317151020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 24
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_7 or var_84_7 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_7 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_13 and arg_81_1.time_ < var_84_6 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play317151021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317151021
		arg_85_1.duration_ = 3.6

		local var_85_0 = {
			zh = 3.6,
			ja = 2.7
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
				arg_85_0:Play317151022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10053ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10053ui_story == nil then
				arg_85_1.var_.characterEffect10053ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10053ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10053ui_story then
				arg_85_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_88_4 = 0

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action9_1")
			end

			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_6 = 0
			local var_88_7 = 0.25

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[477].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(317151021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151021", "story_v_out_317151.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_317151", "317151021", "story_v_out_317151.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_317151", "317151021", "story_v_out_317151.awb")

						arg_85_1:RecordAudio("317151021", var_88_15)
						arg_85_1:RecordAudio("317151021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317151", "317151021", "story_v_out_317151.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317151", "317151021", "story_v_out_317151.awb")
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
	Play317151022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317151022
		arg_89_1.duration_ = 18.97

		local var_89_0 = {
			zh = 14.033,
			ja = 18.966
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
				arg_89_0:Play317151023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10053ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10053ui_story == nil then
				arg_89_1.var_.characterEffect10053ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10053ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10053ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10053ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10053ui_story.fillRatio = var_92_5
			end

			local var_92_6 = arg_89_1.actors_["1049ui_story"]
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1049ui_story == nil then
				arg_89_1.var_.characterEffect1049ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 and not isNil(var_92_6) then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8

				if arg_89_1.var_.characterEffect1049ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1049ui_story then
				arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_92_10 = 0
			local var_92_11 = 1.2

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_12 = arg_89_1:FormatText(StoryNameCfg[551].name)

				arg_89_1.leftNameTxt_.text = var_92_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(317151022)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_15 = 48
				local var_92_16 = utf8.len(var_92_14)
				local var_92_17 = var_92_15 <= 0 and var_92_11 or var_92_11 * (var_92_16 / var_92_15)

				if var_92_17 > 0 and var_92_11 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17

					if var_92_17 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_10
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151022", "story_v_out_317151.awb") ~= 0 then
					local var_92_18 = manager.audio:GetVoiceLength("story_v_out_317151", "317151022", "story_v_out_317151.awb") / 1000

					if var_92_18 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_10
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_317151", "317151022", "story_v_out_317151.awb")

						arg_89_1:RecordAudio("317151022", var_92_19)
						arg_89_1:RecordAudio("317151022", var_92_19)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317151", "317151022", "story_v_out_317151.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317151", "317151022", "story_v_out_317151.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_20 = math.max(var_92_11, arg_89_1.talkMaxDuration)

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_20 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_10) / var_92_20

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_10 + var_92_20 and arg_89_1.time_ < var_92_10 + var_92_20 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play317151023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317151023
		arg_93_1.duration_ = 21.2

		local var_93_0 = {
			zh = 21.2,
			ja = 13.066
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
				arg_93_0:Play317151024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.725

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[551].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(317151023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 69
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151023", "story_v_out_317151.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151023", "story_v_out_317151.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_317151", "317151023", "story_v_out_317151.awb")

						arg_93_1:RecordAudio("317151023", var_96_9)
						arg_93_1:RecordAudio("317151023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317151", "317151023", "story_v_out_317151.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317151", "317151023", "story_v_out_317151.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317151024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317151024
		arg_97_1.duration_ = 5.5

		local var_97_0 = {
			zh = 4.166,
			ja = 5.5
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
				arg_97_0:Play317151025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10053ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10053ui_story == nil then
				arg_97_1.var_.characterEffect10053ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10053ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10053ui_story then
				arg_97_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["1049ui_story"]
			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 and not isNil(var_100_4) then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / var_100_6

				if arg_97_1.var_.characterEffect1049ui_story and not isNil(var_100_4) then
					local var_100_8 = Mathf.Lerp(0, 0.5, var_100_7)

					arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_8
				end
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1049ui_story then
				local var_100_9 = 0.5

				arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_9
			end

			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4912")
			end

			local var_100_11 = 0
			local var_100_12 = 0.45

			if var_100_11 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_13 = arg_97_1:FormatText(StoryNameCfg[477].name)

				arg_97_1.leftNameTxt_.text = var_100_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(317151024)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 18
				local var_100_17 = utf8.len(var_100_15)
				local var_100_18 = var_100_16 <= 0 and var_100_12 or var_100_12 * (var_100_17 / var_100_16)

				if var_100_18 > 0 and var_100_12 < var_100_18 then
					arg_97_1.talkMaxDuration = var_100_18

					if var_100_18 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151024", "story_v_out_317151.awb") ~= 0 then
					local var_100_19 = manager.audio:GetVoiceLength("story_v_out_317151", "317151024", "story_v_out_317151.awb") / 1000

					if var_100_19 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_19 + var_100_11
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_317151", "317151024", "story_v_out_317151.awb")

						arg_97_1:RecordAudio("317151024", var_100_20)
						arg_97_1:RecordAudio("317151024", var_100_20)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_317151", "317151024", "story_v_out_317151.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_317151", "317151024", "story_v_out_317151.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_21 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_21 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_21

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_21 and arg_97_1.time_ < var_100_11 + var_100_21 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317151025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317151025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317151026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10053ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10053ui_story == nil then
				arg_101_1.var_.characterEffect10053ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10053ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10053ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10053ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10053ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.775

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(317151025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 31
				local var_104_11 = utf8.len(var_104_9)
				local var_104_12 = var_104_10 <= 0 and var_104_7 or var_104_7 * (var_104_11 / var_104_10)

				if var_104_12 > 0 and var_104_7 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_13 and arg_101_1.time_ < var_104_6 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play317151026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317151026
		arg_105_1.duration_ = 10.7

		local var_105_0 = {
			zh = 5.066,
			ja = 10.7
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
				arg_105_0:Play317151027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1049ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story == nil then
				arg_105_1.var_.characterEffect1049ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1049ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story then
				arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_108_5 = 0
			local var_108_6 = 0.4

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_7 = arg_105_1:FormatText(StoryNameCfg[551].name)

				arg_105_1.leftNameTxt_.text = var_108_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(317151026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 16
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_6 or var_108_6 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_6 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151026", "story_v_out_317151.awb") ~= 0 then
					local var_108_13 = manager.audio:GetVoiceLength("story_v_out_317151", "317151026", "story_v_out_317151.awb") / 1000

					if var_108_13 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_5
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_317151", "317151026", "story_v_out_317151.awb")

						arg_105_1:RecordAudio("317151026", var_108_14)
						arg_105_1:RecordAudio("317151026", var_108_14)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317151", "317151026", "story_v_out_317151.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317151", "317151026", "story_v_out_317151.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_15 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_15 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_15

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_15 and arg_105_1.time_ < var_108_5 + var_108_15 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play317151027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317151027
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317151028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "YA0107"

			if arg_109_1.bgs_[var_112_0] == nil then
				local var_112_1 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_0)
				var_112_1.name = var_112_0
				var_112_1.transform.parent = arg_109_1.stage_.transform
				var_112_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_0] = var_112_1
			end

			local var_112_2 = 2

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				local var_112_3 = manager.ui.mainCamera.transform.localPosition
				local var_112_4 = Vector3.New(0, 0, 10) + Vector3.New(var_112_3.x, var_112_3.y, 0)
				local var_112_5 = arg_109_1.bgs_.YA0107

				var_112_5.transform.localPosition = var_112_4
				var_112_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_6 = var_112_5:GetComponent("SpriteRenderer")

				if var_112_6 and var_112_6.sprite then
					local var_112_7 = (var_112_5.transform.localPosition - var_112_3).z
					local var_112_8 = manager.ui.mainCameraCom_
					local var_112_9 = 2 * var_112_7 * Mathf.Tan(var_112_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_10 = var_112_9 * var_112_8.aspect
					local var_112_11 = var_112_6.sprite.bounds.size.x
					local var_112_12 = var_112_6.sprite.bounds.size.y
					local var_112_13 = var_112_10 / var_112_11
					local var_112_14 = var_112_9 / var_112_12
					local var_112_15 = var_112_14 < var_112_13 and var_112_13 or var_112_14

					var_112_5.transform.localScale = Vector3.New(var_112_15, var_112_15, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "YA0107" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_17 = 2

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Color.New(0, 0, 0)

				var_112_19.a = Mathf.Lerp(0, 1, var_112_18)
				arg_109_1.mask_.color = var_112_19
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				local var_112_20 = Color.New(0, 0, 0)

				var_112_20.a = 1
				arg_109_1.mask_.color = var_112_20
			end

			local var_112_21 = 2

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_22 = 2

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_22 then
				local var_112_23 = (arg_109_1.time_ - var_112_21) / var_112_22
				local var_112_24 = Color.New(0, 0, 0)

				var_112_24.a = Mathf.Lerp(1, 0, var_112_23)
				arg_109_1.mask_.color = var_112_24
			end

			if arg_109_1.time_ >= var_112_21 + var_112_22 and arg_109_1.time_ < var_112_21 + var_112_22 + arg_112_0 then
				local var_112_25 = Color.New(0, 0, 0)
				local var_112_26 = 0

				arg_109_1.mask_.enabled = false
				var_112_25.a = var_112_26
				arg_109_1.mask_.color = var_112_25
			end

			local var_112_27 = arg_109_1.actors_["10053ui_story"].transform
			local var_112_28 = 2

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 then
				arg_109_1.var_.moveOldPos10053ui_story = var_112_27.localPosition
			end

			local var_112_29 = 0.001

			if var_112_28 <= arg_109_1.time_ and arg_109_1.time_ < var_112_28 + var_112_29 then
				local var_112_30 = (arg_109_1.time_ - var_112_28) / var_112_29
				local var_112_31 = Vector3.New(0, 100, 0)

				var_112_27.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10053ui_story, var_112_31, var_112_30)

				local var_112_32 = manager.ui.mainCamera.transform.position - var_112_27.position

				var_112_27.forward = Vector3.New(var_112_32.x, var_112_32.y, var_112_32.z)

				local var_112_33 = var_112_27.localEulerAngles

				var_112_33.z = 0
				var_112_33.x = 0
				var_112_27.localEulerAngles = var_112_33
			end

			if arg_109_1.time_ >= var_112_28 + var_112_29 and arg_109_1.time_ < var_112_28 + var_112_29 + arg_112_0 then
				var_112_27.localPosition = Vector3.New(0, 100, 0)

				local var_112_34 = manager.ui.mainCamera.transform.position - var_112_27.position

				var_112_27.forward = Vector3.New(var_112_34.x, var_112_34.y, var_112_34.z)

				local var_112_35 = var_112_27.localEulerAngles

				var_112_35.z = 0
				var_112_35.x = 0
				var_112_27.localEulerAngles = var_112_35
			end

			local var_112_36 = arg_109_1.actors_["1049ui_story"].transform
			local var_112_37 = 2

			if var_112_37 < arg_109_1.time_ and arg_109_1.time_ <= var_112_37 + arg_112_0 then
				arg_109_1.var_.moveOldPos1049ui_story = var_112_36.localPosition
			end

			local var_112_38 = 0.001

			if var_112_37 <= arg_109_1.time_ and arg_109_1.time_ < var_112_37 + var_112_38 then
				local var_112_39 = (arg_109_1.time_ - var_112_37) / var_112_38
				local var_112_40 = Vector3.New(0, 100, 0)

				var_112_36.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1049ui_story, var_112_40, var_112_39)

				local var_112_41 = manager.ui.mainCamera.transform.position - var_112_36.position

				var_112_36.forward = Vector3.New(var_112_41.x, var_112_41.y, var_112_41.z)

				local var_112_42 = var_112_36.localEulerAngles

				var_112_42.z = 0
				var_112_42.x = 0
				var_112_36.localEulerAngles = var_112_42
			end

			if arg_109_1.time_ >= var_112_37 + var_112_38 and arg_109_1.time_ < var_112_37 + var_112_38 + arg_112_0 then
				var_112_36.localPosition = Vector3.New(0, 100, 0)

				local var_112_43 = manager.ui.mainCamera.transform.position - var_112_36.position

				var_112_36.forward = Vector3.New(var_112_43.x, var_112_43.y, var_112_43.z)

				local var_112_44 = var_112_36.localEulerAngles

				var_112_44.z = 0
				var_112_44.x = 0
				var_112_36.localEulerAngles = var_112_44
			end

			local var_112_45 = 0
			local var_112_46 = 1

			if var_112_45 < arg_109_1.time_ and arg_109_1.time_ <= var_112_45 + arg_112_0 then
				local var_112_47 = "play"
				local var_112_48 = "effect"

				arg_109_1:AudioAction(var_112_47, var_112_48, "se_story_126_01", "se_story_126_01_Portal", "")
			end

			local var_112_49 = arg_109_1.bgs_.YA0107.transform
			local var_112_50 = 2.03400000184774

			if var_112_50 < arg_109_1.time_ and arg_109_1.time_ <= var_112_50 + arg_112_0 then
				arg_109_1.var_.moveOldPosYA0107 = var_112_49.localPosition
			end

			local var_112_51 = 0.001

			if var_112_50 <= arg_109_1.time_ and arg_109_1.time_ < var_112_50 + var_112_51 then
				local var_112_52 = (arg_109_1.time_ - var_112_50) / var_112_51
				local var_112_53 = Vector3.New(0, -0.49, 1)

				var_112_49.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPosYA0107, var_112_53, var_112_52)
			end

			if arg_109_1.time_ >= var_112_50 + var_112_51 and arg_109_1.time_ < var_112_50 + var_112_51 + arg_112_0 then
				var_112_49.localPosition = Vector3.New(0, -0.49, 1)
			end

			local var_112_54 = arg_109_1.bgs_.YA0107.transform
			local var_112_55 = 2.06800000184774

			if var_112_55 < arg_109_1.time_ and arg_109_1.time_ <= var_112_55 + arg_112_0 then
				arg_109_1.var_.moveOldPosYA0107 = var_112_54.localPosition
			end

			local var_112_56 = 4.46533333148559

			if var_112_55 <= arg_109_1.time_ and arg_109_1.time_ < var_112_55 + var_112_56 then
				local var_112_57 = (arg_109_1.time_ - var_112_55) / var_112_56
				local var_112_58 = Vector3.New(0, -0.49, 1.42)

				var_112_54.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPosYA0107, var_112_58, var_112_57)
			end

			if arg_109_1.time_ >= var_112_55 + var_112_56 and arg_109_1.time_ < var_112_55 + var_112_56 + arg_112_0 then
				var_112_54.localPosition = Vector3.New(0, -0.49, 1.42)
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_59 = 4
			local var_112_60 = 1.225

			if var_112_59 < arg_109_1.time_ and arg_109_1.time_ <= var_112_59 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_61 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_61:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_62 = arg_109_1:GetWordFromCfg(317151027)
				local var_112_63 = arg_109_1:FormatText(var_112_62.content)

				arg_109_1.text_.text = var_112_63

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_64 = 49
				local var_112_65 = utf8.len(var_112_63)
				local var_112_66 = var_112_64 <= 0 and var_112_60 or var_112_60 * (var_112_65 / var_112_64)

				if var_112_66 > 0 and var_112_60 < var_112_66 then
					arg_109_1.talkMaxDuration = var_112_66
					var_112_59 = var_112_59 + 0.3

					if var_112_66 + var_112_59 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_66 + var_112_59
					end
				end

				arg_109_1.text_.text = var_112_63
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_67 = var_112_59 + 0.3
			local var_112_68 = math.max(var_112_60, arg_109_1.talkMaxDuration)

			if var_112_67 <= arg_109_1.time_ and arg_109_1.time_ < var_112_67 + var_112_68 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_67) / var_112_68

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_67 + var_112_68 and arg_109_1.time_ < var_112_67 + var_112_68 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "YA0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YA0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.46533333148559,
				className = "StoryMoveNode",
				startTime = 2.06800000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play317151028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317151028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play317151029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.85

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(317151028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 34
				local var_118_5 = utf8.len(var_118_3)
				local var_118_6 = var_118_4 <= 0 and var_118_1 or var_118_1 * (var_118_5 / var_118_4)

				if var_118_6 > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_7 and arg_115_1.time_ < var_118_0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play317151029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317151029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play317151030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = manager.ui.mainCamera.transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_0.localPosition
			end

			local var_122_2 = 1

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / 0.066
				local var_122_4, var_122_5 = math.modf(var_122_3)

				var_122_0.localPosition = Vector3.New(var_122_5 * 0.13, var_122_5 * 0.13, var_122_5 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_6 = 0
			local var_122_7 = 0.075

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

				local var_122_9 = arg_119_1:GetWordFromCfg(317151029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 3
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
	Play317151030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 317151030
		arg_123_1.duration_ = 9

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play317151031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 2

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				local var_126_1 = manager.ui.mainCamera.transform.localPosition
				local var_126_2 = Vector3.New(0, 0, 10) + Vector3.New(var_126_1.x, var_126_1.y, 0)
				local var_126_3 = arg_123_1.bgs_.YA0107

				var_126_3.transform.localPosition = var_126_2
				var_126_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_4 = var_126_3:GetComponent("SpriteRenderer")

				if var_126_4 and var_126_4.sprite then
					local var_126_5 = (var_126_3.transform.localPosition - var_126_1).z
					local var_126_6 = manager.ui.mainCameraCom_
					local var_126_7 = 2 * var_126_5 * Mathf.Tan(var_126_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_8 = var_126_7 * var_126_6.aspect
					local var_126_9 = var_126_4.sprite.bounds.size.x
					local var_126_10 = var_126_4.sprite.bounds.size.y
					local var_126_11 = var_126_8 / var_126_9
					local var_126_12 = var_126_7 / var_126_10
					local var_126_13 = var_126_12 < var_126_11 and var_126_11 or var_126_12

					var_126_3.transform.localScale = Vector3.New(var_126_13, var_126_13, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "YA0107" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_15 = 2

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_15 then
				local var_126_16 = (arg_123_1.time_ - var_126_14) / var_126_15
				local var_126_17 = Color.New(0, 0, 0)

				var_126_17.a = Mathf.Lerp(0, 1, var_126_16)
				arg_123_1.mask_.color = var_126_17
			end

			if arg_123_1.time_ >= var_126_14 + var_126_15 and arg_123_1.time_ < var_126_14 + var_126_15 + arg_126_0 then
				local var_126_18 = Color.New(0, 0, 0)

				var_126_18.a = 1
				arg_123_1.mask_.color = var_126_18
			end

			local var_126_19 = 2

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_20 = 2

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_20 then
				local var_126_21 = (arg_123_1.time_ - var_126_19) / var_126_20
				local var_126_22 = Color.New(0, 0, 0)

				var_126_22.a = Mathf.Lerp(1, 0, var_126_21)
				arg_123_1.mask_.color = var_126_22
			end

			if arg_123_1.time_ >= var_126_19 + var_126_20 and arg_123_1.time_ < var_126_19 + var_126_20 + arg_126_0 then
				local var_126_23 = Color.New(0, 0, 0)
				local var_126_24 = 0

				arg_123_1.mask_.enabled = false
				var_126_23.a = var_126_24
				arg_123_1.mask_.color = var_126_23
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_25 = 4
			local var_126_26 = 0.4

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_27 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_27:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_28 = arg_123_1:GetWordFromCfg(317151030)
				local var_126_29 = arg_123_1:FormatText(var_126_28.content)

				arg_123_1.text_.text = var_126_29

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_30 = 16
				local var_126_31 = utf8.len(var_126_29)
				local var_126_32 = var_126_30 <= 0 and var_126_26 or var_126_26 * (var_126_31 / var_126_30)

				if var_126_32 > 0 and var_126_26 < var_126_32 then
					arg_123_1.talkMaxDuration = var_126_32
					var_126_25 = var_126_25 + 0.3

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

			local var_126_33 = var_126_25 + 0.3
			local var_126_34 = math.max(var_126_26, arg_123_1.talkMaxDuration)

			if var_126_33 <= arg_123_1.time_ and arg_123_1.time_ < var_126_33 + var_126_34 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_33) / var_126_34

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_33 + var_126_34 and arg_123_1.time_ < var_126_33 + var_126_34 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play317151031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317151031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317151032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.25

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(317151031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 10
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
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play317151032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317151032
		arg_133_1.duration_ = 7.43

		local var_133_0 = {
			zh = 7.433,
			ja = 4.2
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
				arg_133_0:Play317151033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.5

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[551].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(317151032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 20
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151032", "story_v_out_317151.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151032", "story_v_out_317151.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_317151", "317151032", "story_v_out_317151.awb")

						arg_133_1:RecordAudio("317151032", var_136_9)
						arg_133_1:RecordAudio("317151032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317151", "317151032", "story_v_out_317151.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317151", "317151032", "story_v_out_317151.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play317151033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317151033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play317151034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.225

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(317151033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 9
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
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play317151034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317151034
		arg_141_1.duration_ = 14.53

		local var_141_0 = {
			zh = 14.533,
			ja = 10.866
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
				arg_141_0:Play317151035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.1

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[551].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(317151034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151034", "story_v_out_317151.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151034", "story_v_out_317151.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_317151", "317151034", "story_v_out_317151.awb")

						arg_141_1:RecordAudio("317151034", var_144_9)
						arg_141_1:RecordAudio("317151034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317151", "317151034", "story_v_out_317151.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317151", "317151034", "story_v_out_317151.awb")
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
	Play317151035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317151035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317151036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.725

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(317151035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 29
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play317151036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317151036
		arg_149_1.duration_ = 18.3

		local var_149_0 = {
			zh = 14.4,
			ja = 18.3
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
				arg_149_0:Play317151037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.05

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[551].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(317151036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 42
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151036", "story_v_out_317151.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151036", "story_v_out_317151.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_317151", "317151036", "story_v_out_317151.awb")

						arg_149_1:RecordAudio("317151036", var_152_9)
						arg_149_1:RecordAudio("317151036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317151", "317151036", "story_v_out_317151.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317151", "317151036", "story_v_out_317151.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play317151037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317151037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play317151038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.725

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(317151037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 29
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play317151038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317151038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play317151039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.075

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(317151038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 3
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
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play317151039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 317151039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play317151040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.7

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(317151039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 28
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play317151040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 317151040
		arg_165_1.duration_ = 5.37

		local var_165_0 = {
			zh = 4.733,
			ja = 5.366
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
				arg_165_0:Play317151041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.475

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[551].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(317151040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 19
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151040", "story_v_out_317151.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151040", "story_v_out_317151.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_317151", "317151040", "story_v_out_317151.awb")

						arg_165_1:RecordAudio("317151040", var_168_9)
						arg_165_1:RecordAudio("317151040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_317151", "317151040", "story_v_out_317151.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_317151", "317151040", "story_v_out_317151.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play317151041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 317151041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play317151042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.8

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

				local var_172_2 = arg_169_1:GetWordFromCfg(317151041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 32
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
	Play317151042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 317151042
		arg_173_1.duration_ = 18.23

		local var_173_0 = {
			zh = 18.233,
			ja = 13.733
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
				arg_173_0:Play317151043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.2

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[551].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(317151042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 48
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151042", "story_v_out_317151.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151042", "story_v_out_317151.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_317151", "317151042", "story_v_out_317151.awb")

						arg_173_1:RecordAudio("317151042", var_176_9)
						arg_173_1:RecordAudio("317151042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_317151", "317151042", "story_v_out_317151.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_317151", "317151042", "story_v_out_317151.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play317151043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 317151043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play317151044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.5

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(317151043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 20
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play317151044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 317151044
		arg_181_1.duration_ = 8.93

		local var_181_0 = {
			zh = 8.933,
			ja = 7.733
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play317151045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.55

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[551].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(317151044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 22
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151044", "story_v_out_317151.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151044", "story_v_out_317151.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_317151", "317151044", "story_v_out_317151.awb")

						arg_181_1:RecordAudio("317151044", var_184_9)
						arg_181_1:RecordAudio("317151044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_317151", "317151044", "story_v_out_317151.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_317151", "317151044", "story_v_out_317151.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play317151045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317151045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play317151046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.45

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

				local var_188_2 = arg_185_1:GetWordFromCfg(317151045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 18
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
	Play317151046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 317151046
		arg_189_1.duration_ = 5

		local var_189_0 = {
			zh = 5,
			ja = 3.8
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
				arg_189_0:Play317151047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[551].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(317151046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 4
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151046", "story_v_out_317151.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_317151", "317151046", "story_v_out_317151.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_317151", "317151046", "story_v_out_317151.awb")

						arg_189_1:RecordAudio("317151046", var_192_9)
						arg_189_1:RecordAudio("317151046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_317151", "317151046", "story_v_out_317151.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_317151", "317151046", "story_v_out_317151.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play317151047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 317151047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play317151048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.075

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(317151047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 43
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play317151048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 317151048
		arg_197_1.duration_ = 18.9

		local var_197_0 = {
			zh = 17.533,
			ja = 18.9
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
				arg_197_0:Play317151049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "YA0105"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 1

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.YA0105

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "YA0105" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_17 = 1

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Color.New(0, 0, 0)

				var_200_19.a = Mathf.Lerp(0, 1, var_200_18)
				arg_197_1.mask_.color = var_200_19
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				local var_200_20 = Color.New(0, 0, 0)

				var_200_20.a = 1
				arg_197_1.mask_.color = var_200_20
			end

			local var_200_21 = 1

			if var_200_21 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_22 = 1

			if var_200_21 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_22 then
				local var_200_23 = (arg_197_1.time_ - var_200_21) / var_200_22
				local var_200_24 = Color.New(0, 0, 0)

				var_200_24.a = Mathf.Lerp(1, 0, var_200_23)
				arg_197_1.mask_.color = var_200_24
			end

			if arg_197_1.time_ >= var_200_21 + var_200_22 and arg_197_1.time_ < var_200_21 + var_200_22 + arg_200_0 then
				local var_200_25 = Color.New(0, 0, 0)
				local var_200_26 = 0

				arg_197_1.mask_.enabled = false
				var_200_25.a = var_200_26
				arg_197_1.mask_.color = var_200_25
			end

			local var_200_27 = 1

			arg_197_1.isInRecall_ = false

			if var_200_27 < arg_197_1.time_ and arg_197_1.time_ <= var_200_27 + arg_200_0 then
				arg_197_1.screenFilterGo_:SetActive(true)

				arg_197_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_200_2, iter_200_3 in pairs(arg_197_1.actors_) do
					local var_200_28 = iter_200_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_200_4, iter_200_5 in ipairs(var_200_28) do
						if iter_200_5.color.r > 0.51 then
							iter_200_5.color = Color.New(1, 1, 1)
						else
							iter_200_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_200_29 = 0.0166666666666667

			if var_200_27 <= arg_197_1.time_ and arg_197_1.time_ < var_200_27 + var_200_29 then
				local var_200_30 = (arg_197_1.time_ - var_200_27) / var_200_29

				arg_197_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_200_30)
			end

			if arg_197_1.time_ >= var_200_27 + var_200_29 and arg_197_1.time_ < var_200_27 + var_200_29 + arg_200_0 then
				arg_197_1.screenFilterEffect_.weight = 1
			end

			local var_200_31 = 2

			if var_200_31 < arg_197_1.time_ and arg_197_1.time_ <= var_200_31 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_32 = 4

			if arg_197_1.time_ >= var_200_31 + var_200_32 and arg_197_1.time_ < var_200_31 + var_200_32 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_33 = 2
			local var_200_34 = 15.533
			local var_200_35 = manager.audio:GetVoiceLength("story_v_out_317122", "317122050", "story_v_out_317122.awb") / 1000

			if var_200_35 > 0 and var_200_34 < var_200_35 and var_200_35 + var_200_33 > arg_197_1.duration_ then
				local var_200_36 = var_200_35

				arg_197_1.duration_ = var_200_35 + var_200_33
			end

			if var_200_33 < arg_197_1.time_ and arg_197_1.time_ <= var_200_33 + arg_200_0 then
				local var_200_37 = "play"
				local var_200_38 = "voice"

				arg_197_1:AudioAction(var_200_37, var_200_38, "story_v_out_317122", "317122050", "story_v_out_317122.awb")
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_39 = 2
			local var_200_40 = 1.025

			if var_200_39 < arg_197_1.time_ and arg_197_1.time_ <= var_200_39 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_41 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_41:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_42 = arg_197_1:FormatText(StoryNameCfg[551].name)

				arg_197_1.leftNameTxt_.text = var_200_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_43 = arg_197_1:GetWordFromCfg(317151048)
				local var_200_44 = arg_197_1:FormatText(var_200_43.content)

				arg_197_1.text_.text = var_200_44

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_45 = 41
				local var_200_46 = utf8.len(var_200_44)
				local var_200_47 = var_200_45 <= 0 and var_200_40 or var_200_40 * (var_200_46 / var_200_45)

				if var_200_47 > 0 and var_200_40 < var_200_47 then
					arg_197_1.talkMaxDuration = var_200_47
					var_200_39 = var_200_39 + 0.3

					if var_200_47 + var_200_39 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_47 + var_200_39
					end
				end

				arg_197_1.text_.text = var_200_44
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317151", "317151048", "story_v_out_317151.awb") ~= 0 then
					local var_200_48 = manager.audio:GetVoiceLength("story_v_out_317151", "317151048", "story_v_out_317151.awb") / 1000

					if var_200_48 + var_200_39 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_48 + var_200_39
					end

					if var_200_43.prefab_name ~= "" and arg_197_1.actors_[var_200_43.prefab_name] ~= nil then
						local var_200_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_43.prefab_name].transform, "story_v_out_317151", "317151048", "story_v_out_317151.awb")

						arg_197_1:RecordAudio("317151048", var_200_49)
						arg_197_1:RecordAudio("317151048", var_200_49)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_317151", "317151048", "story_v_out_317151.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_317151", "317151048", "story_v_out_317151.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_50 = var_200_39 + 0.3
			local var_200_51 = math.max(var_200_40, arg_197_1.talkMaxDuration)

			if var_200_50 <= arg_197_1.time_ and arg_197_1.time_ < var_200_50 + var_200_51 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_50) / var_200_51

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_50 + var_200_51 and arg_197_1.time_ < var_200_50 + var_200_51 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play317151049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317151049
		arg_203_1.duration_ = 7

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play317151050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				local var_206_1 = manager.ui.mainCamera.transform.localPosition
				local var_206_2 = Vector3.New(0, 0, 10) + Vector3.New(var_206_1.x, var_206_1.y, 0)
				local var_206_3 = arg_203_1.bgs_.YA0107

				var_206_3.transform.localPosition = var_206_2
				var_206_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_4 = var_206_3:GetComponent("SpriteRenderer")

				if var_206_4 and var_206_4.sprite then
					local var_206_5 = (var_206_3.transform.localPosition - var_206_1).z
					local var_206_6 = manager.ui.mainCameraCom_
					local var_206_7 = 2 * var_206_5 * Mathf.Tan(var_206_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_8 = var_206_7 * var_206_6.aspect
					local var_206_9 = var_206_4.sprite.bounds.size.x
					local var_206_10 = var_206_4.sprite.bounds.size.y
					local var_206_11 = var_206_8 / var_206_9
					local var_206_12 = var_206_7 / var_206_10
					local var_206_13 = var_206_12 < var_206_11 and var_206_11 or var_206_12

					var_206_3.transform.localScale = Vector3.New(var_206_13, var_206_13, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "YA0107" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_15 = 1

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_15 then
				local var_206_16 = (arg_203_1.time_ - var_206_14) / var_206_15
				local var_206_17 = Color.New(0, 0, 0)

				var_206_17.a = Mathf.Lerp(0, 1, var_206_16)
				arg_203_1.mask_.color = var_206_17
			end

			if arg_203_1.time_ >= var_206_14 + var_206_15 and arg_203_1.time_ < var_206_14 + var_206_15 + arg_206_0 then
				local var_206_18 = Color.New(0, 0, 0)

				var_206_18.a = 1
				arg_203_1.mask_.color = var_206_18
			end

			local var_206_19 = 1

			if var_206_19 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_20 = 1

			if var_206_19 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_20 then
				local var_206_21 = (arg_203_1.time_ - var_206_19) / var_206_20
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = Mathf.Lerp(1, 0, var_206_21)
				arg_203_1.mask_.color = var_206_22
			end

			if arg_203_1.time_ >= var_206_19 + var_206_20 and arg_203_1.time_ < var_206_19 + var_206_20 + arg_206_0 then
				local var_206_23 = Color.New(0, 0, 0)
				local var_206_24 = 0

				arg_203_1.mask_.enabled = false
				var_206_23.a = var_206_24
				arg_203_1.mask_.color = var_206_23
			end

			local var_206_25 = 1

			arg_203_1.isInRecall_ = false

			if var_206_25 < arg_203_1.time_ and arg_203_1.time_ <= var_206_25 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(false)

				for iter_206_2, iter_206_3 in pairs(arg_203_1.actors_) do
					local var_206_26 = iter_206_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_206_4, iter_206_5 in ipairs(var_206_26) do
						if iter_206_5.color.r > 0.51 then
							iter_206_5.color = Color.New(1, 1, 1)
						else
							iter_206_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_206_27 = 0.0166666666666667

			if var_206_25 <= arg_203_1.time_ and arg_203_1.time_ < var_206_25 + var_206_27 then
				local var_206_28 = (arg_203_1.time_ - var_206_25) / var_206_27

				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_206_28)
			end

			if arg_203_1.time_ >= var_206_25 + var_206_27 and arg_203_1.time_ < var_206_25 + var_206_27 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 0
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_29 = 2
			local var_206_30 = 0.1

			if var_206_29 < arg_203_1.time_ and arg_203_1.time_ <= var_206_29 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_31 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_31:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_32 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_33 = arg_203_1:GetWordFromCfg(317151049)
				local var_206_34 = arg_203_1:FormatText(var_206_33.content)

				arg_203_1.text_.text = var_206_34

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_35 = 4
				local var_206_36 = utf8.len(var_206_34)
				local var_206_37 = var_206_35 <= 0 and var_206_30 or var_206_30 * (var_206_36 / var_206_35)

				if var_206_37 > 0 and var_206_30 < var_206_37 then
					arg_203_1.talkMaxDuration = var_206_37
					var_206_29 = var_206_29 + 0.3

					if var_206_37 + var_206_29 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_37 + var_206_29
					end
				end

				arg_203_1.text_.text = var_206_34
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_38 = var_206_29 + 0.3
			local var_206_39 = math.max(var_206_30, arg_203_1.talkMaxDuration)

			if var_206_38 <= arg_203_1.time_ and arg_203_1.time_ < var_206_38 + var_206_39 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_38) / var_206_39

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_38 + var_206_39 and arg_203_1.time_ < var_206_38 + var_206_39 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play317151050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 317151050
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
			arg_209_1.auto_ = false
		end

		function arg_209_1.playNext_(arg_211_0)
			arg_209_1.onStoryFinished_()
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "STblack"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 2

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.STblack

				var_212_5.transform.localPosition = var_212_4
				var_212_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_6 = var_212_5:GetComponent("SpriteRenderer")

				if var_212_6 and var_212_6.sprite then
					local var_212_7 = (var_212_5.transform.localPosition - var_212_3).z
					local var_212_8 = manager.ui.mainCameraCom_
					local var_212_9 = 2 * var_212_7 * Mathf.Tan(var_212_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_10 = var_212_9 * var_212_8.aspect
					local var_212_11 = var_212_6.sprite.bounds.size.x
					local var_212_12 = var_212_6.sprite.bounds.size.y
					local var_212_13 = var_212_10 / var_212_11
					local var_212_14 = var_212_9 / var_212_12
					local var_212_15 = var_212_14 < var_212_13 and var_212_13 or var_212_14

					var_212_5.transform.localScale = Vector3.New(var_212_15, var_212_15, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "STblack" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_17 = 2

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Color.New(1, 1, 1)

				var_212_19.a = Mathf.Lerp(0, 1, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(1, 1, 1)

				var_212_20.a = 1
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_21 = 2

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_22 = 2

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_22 then
				local var_212_23 = (arg_209_1.time_ - var_212_21) / var_212_22
				local var_212_24 = Color.New(1, 1, 1)

				var_212_24.a = Mathf.Lerp(1, 0, var_212_23)
				arg_209_1.mask_.color = var_212_24
			end

			if arg_209_1.time_ >= var_212_21 + var_212_22 and arg_209_1.time_ < var_212_21 + var_212_22 + arg_212_0 then
				local var_212_25 = Color.New(1, 1, 1)
				local var_212_26 = 0

				arg_209_1.mask_.enabled = false
				var_212_25.a = var_212_26
				arg_209_1.mask_.color = var_212_25
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_27 = 4
			local var_212_28 = 0.775

			if var_212_27 < arg_209_1.time_ and arg_209_1.time_ <= var_212_27 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_29 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_29:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_30 = arg_209_1:GetWordFromCfg(317151050)
				local var_212_31 = arg_209_1:FormatText(var_212_30.content)

				arg_209_1.text_.text = var_212_31

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_32 = 31
				local var_212_33 = utf8.len(var_212_31)
				local var_212_34 = var_212_32 <= 0 and var_212_28 or var_212_28 * (var_212_33 / var_212_32)

				if var_212_34 > 0 and var_212_28 < var_212_34 then
					arg_209_1.talkMaxDuration = var_212_34
					var_212_27 = var_212_27 + 0.3

					if var_212_34 + var_212_27 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_34 + var_212_27
					end
				end

				arg_209_1.text_.text = var_212_31
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_35 = var_212_27 + 0.3
			local var_212_36 = math.max(var_212_28, arg_209_1.talkMaxDuration)

			if var_212_35 <= arg_209_1.time_ and arg_209_1.time_ < var_212_35 + var_212_36 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_35) / var_212_36

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_35 + var_212_36 and arg_209_1.time_ < var_212_35 + var_212_36 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09h",
		"TextureConfig/Background/YA0107",
		"TextureConfig/Background/YA0105",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_317151.awb",
		"story_v_out_317122.awb"
	}
}
