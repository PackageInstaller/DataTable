return {
	Play1104202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104202001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST22"

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
				local var_4_5 = arg_1_1.bgs_.ST22

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
					if iter_4_0 ~= "ST22" then
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
			local var_4_23 = 0.5

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

			local var_4_28 = 1.53333333333333
			local var_4_29 = 1

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 1.999999999999
			local var_4_35 = 1.025

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

				local var_4_37 = arg_1_1:GetWordFromCfg(1104202001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 41
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
	Play1104202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104202002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.95

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

				local var_12_2 = arg_9_1:GetWordFromCfg(1104202002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 38
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
	Play1104202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104202003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.5

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

				local var_16_2 = arg_13_1:GetWordFromCfg(1104202003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 20
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
	Play1104202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104202004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.125

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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1104202004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 5
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
	Play1104202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104202005
		arg_21_1.duration_ = 2.8

		local var_21_0 = {
			ja = 2.233,
			ko = 2.8,
			zh = 2.8
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
				arg_21_0:Play1104202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "6046_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["6046_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046_story = var_24_5.localPosition

				local var_24_7 = GameObjectTools.GetOrAddComponent(var_24_5.gameObject, typeof(DynamicBoneHelper))

				if var_24_7 then
					var_24_7:EnableDynamicBone(false)
				end
			end

			local var_24_8 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_6) / var_24_8
				local var_24_10 = Vector3.New(0, -0.5, -6.3)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046_story, var_24_10, var_24_9)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_5.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_5.localEulerAngles = var_24_12
			end

			if arg_21_1.time_ >= var_24_6 + var_24_8 and arg_21_1.time_ < var_24_6 + var_24_8 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_24_13 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_13.x, var_24_13.y, var_24_13.z)

				local var_24_14 = var_24_5.localEulerAngles

				var_24_14.z = 0
				var_24_14.x = 0
				var_24_5.localEulerAngles = var_24_14

				local var_24_15 = GameObjectTools.GetOrAddComponent(var_24_5.gameObject, typeof(DynamicBoneHelper))

				if var_24_15 then
					var_24_15:EnableDynamicBone(true)
				end
			end

			local var_24_16 = arg_21_1.actors_["6046_story"]
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect6046_story == nil then
				arg_21_1.var_.characterEffect6046_story = var_24_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_18 = 0.200000002980232

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_18 and not isNil(var_24_16) then
				local var_24_19 = (arg_21_1.time_ - var_24_17) / var_24_18

				if arg_21_1.var_.characterEffect6046_story and not isNil(var_24_16) then
					arg_21_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_17 + var_24_18 and arg_21_1.time_ < var_24_17 + var_24_18 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect6046_story then
				arg_21_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_22 = 0
			local var_24_23 = 0.25

			if var_24_22 < arg_21_1.time_ and arg_21_1.time_ <= var_24_22 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_24 = arg_21_1:FormatText(StoryNameCfg[214].name)

				arg_21_1.leftNameTxt_.text = var_24_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_25 = arg_21_1:GetWordFromCfg(1104202005)
				local var_24_26 = arg_21_1:FormatText(var_24_25.content)

				arg_21_1.text_.text = var_24_26

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_27 = 10
				local var_24_28 = utf8.len(var_24_26)
				local var_24_29 = var_24_27 <= 0 and var_24_23 or var_24_23 * (var_24_28 / var_24_27)

				if var_24_29 > 0 and var_24_23 < var_24_29 then
					arg_21_1.talkMaxDuration = var_24_29

					if var_24_29 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_22
					end
				end

				arg_21_1.text_.text = var_24_26
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202005", "story_v_side_new_1104202.awb") ~= 0 then
					local var_24_30 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202005", "story_v_side_new_1104202.awb") / 1000

					if var_24_30 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_22
					end

					if var_24_25.prefab_name ~= "" and arg_21_1.actors_[var_24_25.prefab_name] ~= nil then
						local var_24_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_25.prefab_name].transform, "story_v_side_new_1104202", "1104202005", "story_v_side_new_1104202.awb")

						arg_21_1:RecordAudio("1104202005", var_24_31)
						arg_21_1:RecordAudio("1104202005", var_24_31)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202005", "story_v_side_new_1104202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202005", "story_v_side_new_1104202.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_32 = math.max(var_24_23, arg_21_1.talkMaxDuration)

			if var_24_22 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_32 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_32

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_32 and arg_21_1.time_ < var_24_22 + var_24_32 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104202006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["6046_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6046_story == nil then
				arg_25_1.var_.characterEffect6046_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect6046_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect6046_story.fillFlat = true
					arg_25_1.var_.characterEffect6046_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6046_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect6046_story.fillFlat = true
				arg_25_1.var_.characterEffect6046_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.4

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(1104202006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 16
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104202007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1104202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.575

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1104202007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 23
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1104202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104202008
		arg_33_1.duration_ = 9.1

		local var_33_0 = {
			ja = 7.633,
			ko = 9.1,
			zh = 9.1
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
				arg_33_0:Play1104202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["6046_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect6046_story == nil then
				arg_33_1.var_.characterEffect6046_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect6046_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect6046_story then
				arg_33_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = 0
			local var_36_7 = 0.875

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[214].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(1104202008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202008", "story_v_side_new_1104202.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202008", "story_v_side_new_1104202.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_side_new_1104202", "1104202008", "story_v_side_new_1104202.awb")

						arg_33_1:RecordAudio("1104202008", var_36_15)
						arg_33_1:RecordAudio("1104202008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202008", "story_v_side_new_1104202.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202008", "story_v_side_new_1104202.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1104202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104202009
		arg_37_1.duration_ = 12.13

		local var_37_0 = {
			ja = 6.233,
			ko = 12.133,
			zh = 12.133
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
				arg_37_0:Play1104202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["6046_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos6046_story = var_40_0.localPosition

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0.gameObject, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end
			end

			local var_40_3 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_3 then
				local var_40_4 = (arg_37_1.time_ - var_40_1) / var_40_3
				local var_40_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos6046_story, var_40_5, var_40_4)

				local var_40_6 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_6.x, var_40_6.y, var_40_6.z)

				local var_40_7 = var_40_0.localEulerAngles

				var_40_7.z = 0
				var_40_7.x = 0
				var_40_0.localEulerAngles = var_40_7
			end

			if arg_37_1.time_ >= var_40_1 + var_40_3 and arg_37_1.time_ < var_40_1 + var_40_3 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_40_8 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_8.x, var_40_8.y, var_40_8.z)

				local var_40_9 = var_40_0.localEulerAngles

				var_40_9.z = 0
				var_40_9.x = 0
				var_40_0.localEulerAngles = var_40_9

				local var_40_10 = GameObjectTools.GetOrAddComponent(var_40_0.gameObject, typeof(DynamicBoneHelper))

				if var_40_10 then
					var_40_10:EnableDynamicBone(true)
				end
			end

			local var_40_11 = arg_37_1.actors_["6046_story"]
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect6046_story == nil then
				arg_37_1.var_.characterEffect6046_story = var_40_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_13 = 0.200000002980232

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_13 and not isNil(var_40_11) then
				local var_40_14 = (arg_37_1.time_ - var_40_12) / var_40_13

				if arg_37_1.var_.characterEffect6046_story and not isNil(var_40_11) then
					local var_40_15 = Mathf.Lerp(0, 0.5, var_40_14)

					arg_37_1.var_.characterEffect6046_story.fillFlat = true
					arg_37_1.var_.characterEffect6046_story.fillRatio = var_40_15
				end
			end

			if arg_37_1.time_ >= var_40_12 + var_40_13 and arg_37_1.time_ < var_40_12 + var_40_13 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect6046_story then
				local var_40_16 = 0.5

				arg_37_1.var_.characterEffect6046_story.fillFlat = true
				arg_37_1.var_.characterEffect6046_story.fillRatio = var_40_16
			end

			local var_40_17 = "6045_story"

			if arg_37_1.actors_[var_40_17] == nil then
				local var_40_18 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_40_18) then
					local var_40_19 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_37_1.stage_.transform)

					var_40_19.name = var_40_17
					var_40_19.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_17] = var_40_19

					local var_40_20 = var_40_19:GetComponentInChildren(typeof(CharacterEffect))

					var_40_20.enabled = true

					local var_40_21 = GameObjectTools.GetOrAddComponent(var_40_19, typeof(DynamicBoneHelper))

					if var_40_21 then
						var_40_21:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_20.transform, false)

					arg_37_1.var_[var_40_17 .. "Animator"] = var_40_20.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_17 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_17 .. "LipSync"] = var_40_20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_22 = arg_37_1.actors_["6045_story"].transform
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.var_.moveOldPos6045_story = var_40_22.localPosition

				local var_40_24 = GameObjectTools.GetOrAddComponent(var_40_22.gameObject, typeof(DynamicBoneHelper))

				if var_40_24 then
					var_40_24:EnableDynamicBone(false)
				end
			end

			local var_40_25 = 0.001

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_25 then
				local var_40_26 = (arg_37_1.time_ - var_40_23) / var_40_25
				local var_40_27 = Vector3.New(0.7, -0.5, -6.3)

				var_40_22.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos6045_story, var_40_27, var_40_26)

				local var_40_28 = manager.ui.mainCamera.transform.position - var_40_22.position

				var_40_22.forward = Vector3.New(var_40_28.x, var_40_28.y, var_40_28.z)

				local var_40_29 = var_40_22.localEulerAngles

				var_40_29.z = 0
				var_40_29.x = 0
				var_40_22.localEulerAngles = var_40_29
			end

			if arg_37_1.time_ >= var_40_23 + var_40_25 and arg_37_1.time_ < var_40_23 + var_40_25 + arg_40_0 then
				var_40_22.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_40_30 = manager.ui.mainCamera.transform.position - var_40_22.position

				var_40_22.forward = Vector3.New(var_40_30.x, var_40_30.y, var_40_30.z)

				local var_40_31 = var_40_22.localEulerAngles

				var_40_31.z = 0
				var_40_31.x = 0
				var_40_22.localEulerAngles = var_40_31

				local var_40_32 = GameObjectTools.GetOrAddComponent(var_40_22.gameObject, typeof(DynamicBoneHelper))

				if var_40_32 then
					var_40_32:EnableDynamicBone(true)
				end
			end

			local var_40_33 = arg_37_1.actors_["6045_story"]
			local var_40_34 = 0

			if var_40_34 < arg_37_1.time_ and arg_37_1.time_ <= var_40_34 + arg_40_0 and not isNil(var_40_33) and arg_37_1.var_.characterEffect6045_story == nil then
				arg_37_1.var_.characterEffect6045_story = var_40_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_35 = 0.200000002980232

			if var_40_34 <= arg_37_1.time_ and arg_37_1.time_ < var_40_34 + var_40_35 and not isNil(var_40_33) then
				local var_40_36 = (arg_37_1.time_ - var_40_34) / var_40_35

				if arg_37_1.var_.characterEffect6045_story and not isNil(var_40_33) then
					arg_37_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_34 + var_40_35 and arg_37_1.time_ < var_40_34 + var_40_35 + arg_40_0 and not isNil(var_40_33) and arg_37_1.var_.characterEffect6045_story then
				arg_37_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_40_37 = 0

			if var_40_37 < arg_37_1.time_ and arg_37_1.time_ <= var_40_37 + arg_40_0 then
				arg_37_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_40_38 = 0

			if var_40_38 < arg_37_1.time_ and arg_37_1.time_ <= var_40_38 + arg_40_0 then
				arg_37_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_39 = 0
			local var_40_40 = 1.025

			if var_40_39 < arg_37_1.time_ and arg_37_1.time_ <= var_40_39 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_41 = arg_37_1:FormatText(StoryNameCfg[215].name)

				arg_37_1.leftNameTxt_.text = var_40_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_42 = arg_37_1:GetWordFromCfg(1104202009)
				local var_40_43 = arg_37_1:FormatText(var_40_42.content)

				arg_37_1.text_.text = var_40_43

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_44 = 41
				local var_40_45 = utf8.len(var_40_43)
				local var_40_46 = var_40_44 <= 0 and var_40_40 or var_40_40 * (var_40_45 / var_40_44)

				if var_40_46 > 0 and var_40_40 < var_40_46 then
					arg_37_1.talkMaxDuration = var_40_46

					if var_40_46 + var_40_39 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_46 + var_40_39
					end
				end

				arg_37_1.text_.text = var_40_43
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202009", "story_v_side_new_1104202.awb") ~= 0 then
					local var_40_47 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202009", "story_v_side_new_1104202.awb") / 1000

					if var_40_47 + var_40_39 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_47 + var_40_39
					end

					if var_40_42.prefab_name ~= "" and arg_37_1.actors_[var_40_42.prefab_name] ~= nil then
						local var_40_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_42.prefab_name].transform, "story_v_side_new_1104202", "1104202009", "story_v_side_new_1104202.awb")

						arg_37_1:RecordAudio("1104202009", var_40_48)
						arg_37_1:RecordAudio("1104202009", var_40_48)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202009", "story_v_side_new_1104202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202009", "story_v_side_new_1104202.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_49 = math.max(var_40_40, arg_37_1.talkMaxDuration)

			if var_40_39 <= arg_37_1.time_ and arg_37_1.time_ < var_40_39 + var_40_49 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_39) / var_40_49

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_39 + var_40_49 and arg_37_1.time_ < var_40_39 + var_40_49 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1104202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104202010
		arg_41_1.duration_ = 2.17

		local var_41_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			zh = 2.166
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
				arg_41_0:Play1104202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["6046_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect6046_story == nil then
				arg_41_1.var_.characterEffect6046_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect6046_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect6046_story then
				arg_41_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = arg_41_1.actors_["6045_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect6045_story == nil then
				arg_41_1.var_.characterEffect6045_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect6045_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect6045_story.fillFlat = true
					arg_41_1.var_.characterEffect6045_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect6045_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect6045_story.fillFlat = true
				arg_41_1.var_.characterEffect6045_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.175

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[214].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(1104202010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 7
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202010", "story_v_side_new_1104202.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202010", "story_v_side_new_1104202.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_side_new_1104202", "1104202010", "story_v_side_new_1104202.awb")

						arg_41_1:RecordAudio("1104202010", var_44_21)
						arg_41_1:RecordAudio("1104202010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202010", "story_v_side_new_1104202.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202010", "story_v_side_new_1104202.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1104202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104202011
		arg_45_1.duration_ = 15

		local var_45_0 = {
			ja = 15,
			ko = 12.233,
			zh = 12.233
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
				arg_45_0:Play1104202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.375

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[214].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(1104202011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 55
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202011", "story_v_side_new_1104202.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202011", "story_v_side_new_1104202.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_side_new_1104202", "1104202011", "story_v_side_new_1104202.awb")

						arg_45_1:RecordAudio("1104202011", var_48_9)
						arg_45_1:RecordAudio("1104202011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202011", "story_v_side_new_1104202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202011", "story_v_side_new_1104202.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1104202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104202012
		arg_49_1.duration_ = 2.5

		local var_49_0 = {
			ja = 2.033,
			ko = 2.5,
			zh = 2.5
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
				arg_49_0:Play1104202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["6045_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect6045_story == nil then
				arg_49_1.var_.characterEffect6045_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect6045_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect6045_story then
				arg_49_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_6 = arg_49_1.actors_["6046_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect6046_story == nil then
				arg_49_1.var_.characterEffect6046_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect6046_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect6046_story.fillFlat = true
					arg_49_1.var_.characterEffect6046_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect6046_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect6046_story.fillFlat = true
				arg_49_1.var_.characterEffect6046_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 0.175

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[215].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(1104202012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 7
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202012", "story_v_side_new_1104202.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202012", "story_v_side_new_1104202.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_side_new_1104202", "1104202012", "story_v_side_new_1104202.awb")

						arg_49_1:RecordAudio("1104202012", var_52_21)
						arg_49_1:RecordAudio("1104202012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202012", "story_v_side_new_1104202.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202012", "story_v_side_new_1104202.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104202013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1104202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["6045_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect6045_story == nil then
				arg_53_1.var_.characterEffect6045_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect6045_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect6045_story.fillFlat = true
					arg_53_1.var_.characterEffect6045_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect6045_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect6045_story.fillFlat = true
				arg_53_1.var_.characterEffect6045_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.575

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(1104202013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 23
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1104202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104202014
		arg_57_1.duration_ = 9.73

		local var_57_0 = {
			ja = 9.733,
			ko = 7.4,
			zh = 7.4
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
				arg_57_0:Play1104202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["6046_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos6046_story = var_60_0.localPosition

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end
			end

			local var_60_3 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_3 then
				local var_60_4 = (arg_57_1.time_ - var_60_1) / var_60_3
				local var_60_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos6046_story, var_60_5, var_60_4)

				local var_60_6 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_6.x, var_60_6.y, var_60_6.z)

				local var_60_7 = var_60_0.localEulerAngles

				var_60_7.z = 0
				var_60_7.x = 0
				var_60_0.localEulerAngles = var_60_7
			end

			if arg_57_1.time_ >= var_60_1 + var_60_3 and arg_57_1.time_ < var_60_1 + var_60_3 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_60_8 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_8.x, var_60_8.y, var_60_8.z)

				local var_60_9 = var_60_0.localEulerAngles

				var_60_9.z = 0
				var_60_9.x = 0
				var_60_0.localEulerAngles = var_60_9

				local var_60_10 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_10 then
					var_60_10:EnableDynamicBone(true)
				end
			end

			local var_60_11 = arg_57_1.actors_["6046_story"]
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.characterEffect6046_story == nil then
				arg_57_1.var_.characterEffect6046_story = var_60_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_13 = 0.200000002980232

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_13 and not isNil(var_60_11) then
				local var_60_14 = (arg_57_1.time_ - var_60_12) / var_60_13

				if arg_57_1.var_.characterEffect6046_story and not isNil(var_60_11) then
					arg_57_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_12 + var_60_13 and arg_57_1.time_ < var_60_12 + var_60_13 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.characterEffect6046_story then
				arg_57_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_17 = 0
			local var_60_18 = 0.725

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_19 = arg_57_1:FormatText(StoryNameCfg[214].name)

				arg_57_1.leftNameTxt_.text = var_60_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_20 = arg_57_1:GetWordFromCfg(1104202014)
				local var_60_21 = arg_57_1:FormatText(var_60_20.content)

				arg_57_1.text_.text = var_60_21

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_22 = 29
				local var_60_23 = utf8.len(var_60_21)
				local var_60_24 = var_60_22 <= 0 and var_60_18 or var_60_18 * (var_60_23 / var_60_22)

				if var_60_24 > 0 and var_60_18 < var_60_24 then
					arg_57_1.talkMaxDuration = var_60_24

					if var_60_24 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_17
					end
				end

				arg_57_1.text_.text = var_60_21
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202014", "story_v_side_new_1104202.awb") ~= 0 then
					local var_60_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202014", "story_v_side_new_1104202.awb") / 1000

					if var_60_25 + var_60_17 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_25 + var_60_17
					end

					if var_60_20.prefab_name ~= "" and arg_57_1.actors_[var_60_20.prefab_name] ~= nil then
						local var_60_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_20.prefab_name].transform, "story_v_side_new_1104202", "1104202014", "story_v_side_new_1104202.awb")

						arg_57_1:RecordAudio("1104202014", var_60_26)
						arg_57_1:RecordAudio("1104202014", var_60_26)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202014", "story_v_side_new_1104202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202014", "story_v_side_new_1104202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = math.max(var_60_18, arg_57_1.talkMaxDuration)

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_27 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_17) / var_60_27

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_17 + var_60_27 and arg_57_1.time_ < var_60_17 + var_60_27 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1104202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104202015
		arg_61_1.duration_ = 8.33

		local var_61_0 = {
			ja = 8.333,
			ko = 7.133,
			zh = 7.133
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
				arg_61_0:Play1104202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["6045_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect6045_story == nil then
				arg_61_1.var_.characterEffect6045_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect6045_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect6045_story then
				arg_61_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_6 = arg_61_1.actors_["6046_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect6046_story == nil then
				arg_61_1.var_.characterEffect6046_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect6046_story and not isNil(var_64_6) then
					local var_64_10 = Mathf.Lerp(0, 0.5, var_64_9)

					arg_61_1.var_.characterEffect6046_story.fillFlat = true
					arg_61_1.var_.characterEffect6046_story.fillRatio = var_64_10
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect6046_story then
				local var_64_11 = 0.5

				arg_61_1.var_.characterEffect6046_story.fillFlat = true
				arg_61_1.var_.characterEffect6046_story.fillRatio = var_64_11
			end

			local var_64_12 = 0
			local var_64_13 = 0.65

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[215].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(1104202015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 26
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202015", "story_v_side_new_1104202.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202015", "story_v_side_new_1104202.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_side_new_1104202", "1104202015", "story_v_side_new_1104202.awb")

						arg_61_1:RecordAudio("1104202015", var_64_21)
						arg_61_1:RecordAudio("1104202015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202015", "story_v_side_new_1104202.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202015", "story_v_side_new_1104202.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1104202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104202016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1104202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["6045_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6045_story == nil then
				arg_65_1.var_.characterEffect6045_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect6045_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect6045_story.fillFlat = true
					arg_65_1.var_.characterEffect6045_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6045_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect6045_story.fillFlat = true
				arg_65_1.var_.characterEffect6045_story.fillRatio = var_68_5
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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(1104202016)
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
	Play1104202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1104202017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1104202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["6045_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos6045_story = var_72_0.localPosition

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end
			end

			local var_72_3 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3
				local var_72_5 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6045_story, var_72_5, var_72_4)

				local var_72_6 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_6.x, var_72_6.y, var_72_6.z)

				local var_72_7 = var_72_0.localEulerAngles

				var_72_7.z = 0
				var_72_7.x = 0
				var_72_0.localEulerAngles = var_72_7
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_8 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_8.x, var_72_8.y, var_72_8.z)

				local var_72_9 = var_72_0.localEulerAngles

				var_72_9.z = 0
				var_72_9.x = 0
				var_72_0.localEulerAngles = var_72_9

				local var_72_10 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_10 then
					var_72_10:EnableDynamicBone(true)
				end
			end

			local var_72_11 = arg_69_1.actors_["6045_story"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect6045_story == nil then
				arg_69_1.var_.characterEffect6045_story = var_72_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_13 = 0.200000002980232

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.characterEffect6045_story and not isNil(var_72_11) then
					local var_72_15 = Mathf.Lerp(0, 0.5, var_72_14)

					arg_69_1.var_.characterEffect6045_story.fillFlat = true
					arg_69_1.var_.characterEffect6045_story.fillRatio = var_72_15
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect6045_story then
				local var_72_16 = 0.5

				arg_69_1.var_.characterEffect6045_story.fillFlat = true
				arg_69_1.var_.characterEffect6045_story.fillRatio = var_72_16
			end

			local var_72_17 = arg_69_1.actors_["6046_story"].transform
			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.var_.moveOldPos6046_story = var_72_17.localPosition

				local var_72_19 = GameObjectTools.GetOrAddComponent(var_72_17.gameObject, typeof(DynamicBoneHelper))

				if var_72_19 then
					var_72_19:EnableDynamicBone(false)
				end
			end

			local var_72_20 = 0.001

			if var_72_18 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_18) / var_72_20
				local var_72_22 = Vector3.New(0, 100, 0)

				var_72_17.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6046_story, var_72_22, var_72_21)

				local var_72_23 = manager.ui.mainCamera.transform.position - var_72_17.position

				var_72_17.forward = Vector3.New(var_72_23.x, var_72_23.y, var_72_23.z)

				local var_72_24 = var_72_17.localEulerAngles

				var_72_24.z = 0
				var_72_24.x = 0
				var_72_17.localEulerAngles = var_72_24
			end

			if arg_69_1.time_ >= var_72_18 + var_72_20 and arg_69_1.time_ < var_72_18 + var_72_20 + arg_72_0 then
				var_72_17.localPosition = Vector3.New(0, 100, 0)

				local var_72_25 = manager.ui.mainCamera.transform.position - var_72_17.position

				var_72_17.forward = Vector3.New(var_72_25.x, var_72_25.y, var_72_25.z)

				local var_72_26 = var_72_17.localEulerAngles

				var_72_26.z = 0
				var_72_26.x = 0
				var_72_17.localEulerAngles = var_72_26

				local var_72_27 = GameObjectTools.GetOrAddComponent(var_72_17.gameObject, typeof(DynamicBoneHelper))

				if var_72_27 then
					var_72_27:EnableDynamicBone(true)
				end
			end

			local var_72_28 = arg_69_1.actors_["6046_story"]
			local var_72_29 = 0

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 and not isNil(var_72_28) and arg_69_1.var_.characterEffect6046_story == nil then
				arg_69_1.var_.characterEffect6046_story = var_72_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_30 = 0.200000002980232

			if var_72_29 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_30 and not isNil(var_72_28) then
				local var_72_31 = (arg_69_1.time_ - var_72_29) / var_72_30

				if arg_69_1.var_.characterEffect6046_story and not isNil(var_72_28) then
					local var_72_32 = Mathf.Lerp(0, 0.5, var_72_31)

					arg_69_1.var_.characterEffect6046_story.fillFlat = true
					arg_69_1.var_.characterEffect6046_story.fillRatio = var_72_32
				end
			end

			if arg_69_1.time_ >= var_72_29 + var_72_30 and arg_69_1.time_ < var_72_29 + var_72_30 + arg_72_0 and not isNil(var_72_28) and arg_69_1.var_.characterEffect6046_story then
				local var_72_33 = 0.5

				arg_69_1.var_.characterEffect6046_story.fillFlat = true
				arg_69_1.var_.characterEffect6046_story.fillRatio = var_72_33
			end

			local var_72_34 = 0
			local var_72_35 = 1.25

			if var_72_34 < arg_69_1.time_ and arg_69_1.time_ <= var_72_34 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_36 = arg_69_1:GetWordFromCfg(1104202017)
				local var_72_37 = arg_69_1:FormatText(var_72_36.content)

				arg_69_1.text_.text = var_72_37

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_38 = 50
				local var_72_39 = utf8.len(var_72_37)
				local var_72_40 = var_72_38 <= 0 and var_72_35 or var_72_35 * (var_72_39 / var_72_38)

				if var_72_40 > 0 and var_72_35 < var_72_40 then
					arg_69_1.talkMaxDuration = var_72_40

					if var_72_40 + var_72_34 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_40 + var_72_34
					end
				end

				arg_69_1.text_.text = var_72_37
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_41 = math.max(var_72_35, arg_69_1.talkMaxDuration)

			if var_72_34 <= arg_69_1.time_ and arg_69_1.time_ < var_72_34 + var_72_41 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_34) / var_72_41

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_34 + var_72_41 and arg_69_1.time_ < var_72_34 + var_72_41 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1104202018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104202018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104202019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.575

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(1104202018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 23
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1104202019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104202019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1104202020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.4

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(1104202019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 16
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
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1104202020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104202020
		arg_81_1.duration_ = 4.87

		local var_81_0 = {
			ja = 4.866,
			ko = 4.8,
			zh = 4.8
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
				arg_81_0:Play1104202021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["6045_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos6045_story = var_84_0.localPosition

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end
			end

			local var_84_3 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_3 then
				local var_84_4 = (arg_81_1.time_ - var_84_1) / var_84_3
				local var_84_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6045_story, var_84_5, var_84_4)

				local var_84_6 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_6.x, var_84_6.y, var_84_6.z)

				local var_84_7 = var_84_0.localEulerAngles

				var_84_7.z = 0
				var_84_7.x = 0
				var_84_0.localEulerAngles = var_84_7
			end

			if arg_81_1.time_ >= var_84_1 + var_84_3 and arg_81_1.time_ < var_84_1 + var_84_3 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_84_8 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_8.x, var_84_8.y, var_84_8.z)

				local var_84_9 = var_84_0.localEulerAngles

				var_84_9.z = 0
				var_84_9.x = 0
				var_84_0.localEulerAngles = var_84_9

				local var_84_10 = GameObjectTools.GetOrAddComponent(var_84_0.gameObject, typeof(DynamicBoneHelper))

				if var_84_10 then
					var_84_10:EnableDynamicBone(true)
				end
			end

			local var_84_11 = arg_81_1.actors_["6045_story"]
			local var_84_12 = 0

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.characterEffect6045_story == nil then
				arg_81_1.var_.characterEffect6045_story = var_84_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_13 = 0.200000002980232

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_13 and not isNil(var_84_11) then
				local var_84_14 = (arg_81_1.time_ - var_84_12) / var_84_13

				if arg_81_1.var_.characterEffect6045_story and not isNil(var_84_11) then
					arg_81_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_12 + var_84_13 and arg_81_1.time_ < var_84_12 + var_84_13 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.characterEffect6045_story then
				arg_81_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_17 = 0
			local var_84_18 = 0.325

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_19 = arg_81_1:FormatText(StoryNameCfg[215].name)

				arg_81_1.leftNameTxt_.text = var_84_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_20 = arg_81_1:GetWordFromCfg(1104202020)
				local var_84_21 = arg_81_1:FormatText(var_84_20.content)

				arg_81_1.text_.text = var_84_21

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_22 = 13
				local var_84_23 = utf8.len(var_84_21)
				local var_84_24 = var_84_22 <= 0 and var_84_18 or var_84_18 * (var_84_23 / var_84_22)

				if var_84_24 > 0 and var_84_18 < var_84_24 then
					arg_81_1.talkMaxDuration = var_84_24

					if var_84_24 + var_84_17 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_17
					end
				end

				arg_81_1.text_.text = var_84_21
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202020", "story_v_side_new_1104202.awb") ~= 0 then
					local var_84_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202020", "story_v_side_new_1104202.awb") / 1000

					if var_84_25 + var_84_17 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_25 + var_84_17
					end

					if var_84_20.prefab_name ~= "" and arg_81_1.actors_[var_84_20.prefab_name] ~= nil then
						local var_84_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_20.prefab_name].transform, "story_v_side_new_1104202", "1104202020", "story_v_side_new_1104202.awb")

						arg_81_1:RecordAudio("1104202020", var_84_26)
						arg_81_1:RecordAudio("1104202020", var_84_26)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202020", "story_v_side_new_1104202.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202020", "story_v_side_new_1104202.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_27 = math.max(var_84_18, arg_81_1.talkMaxDuration)

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_27 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_17) / var_84_27

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_17 + var_84_27 and arg_81_1.time_ < var_84_17 + var_84_27 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1104202021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104202021
		arg_85_1.duration_ = 10

		local var_85_0 = {
			ja = 5.366,
			ko = 10,
			zh = 10
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
				arg_85_0:Play1104202022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["6046_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos6046_story = var_88_0.localPosition

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end
			end

			local var_88_3 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_3 then
				local var_88_4 = (arg_85_1.time_ - var_88_1) / var_88_3
				local var_88_5 = Vector3.New(0.7, -0.5, -6.3)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos6046_story, var_88_5, var_88_4)

				local var_88_6 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_6.x, var_88_6.y, var_88_6.z)

				local var_88_7 = var_88_0.localEulerAngles

				var_88_7.z = 0
				var_88_7.x = 0
				var_88_0.localEulerAngles = var_88_7
			end

			if arg_85_1.time_ >= var_88_1 + var_88_3 and arg_85_1.time_ < var_88_1 + var_88_3 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_88_8 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_8.x, var_88_8.y, var_88_8.z)

				local var_88_9 = var_88_0.localEulerAngles

				var_88_9.z = 0
				var_88_9.x = 0
				var_88_0.localEulerAngles = var_88_9

				local var_88_10 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_10 then
					var_88_10:EnableDynamicBone(true)
				end
			end

			local var_88_11 = arg_85_1.actors_["6046_story"]
			local var_88_12 = 0

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.characterEffect6046_story == nil then
				arg_85_1.var_.characterEffect6046_story = var_88_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_13 = 0.200000002980232

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_13 and not isNil(var_88_11) then
				local var_88_14 = (arg_85_1.time_ - var_88_12) / var_88_13

				if arg_85_1.var_.characterEffect6046_story and not isNil(var_88_11) then
					arg_85_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_12 + var_88_13 and arg_85_1.time_ < var_88_12 + var_88_13 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.characterEffect6046_story then
				arg_85_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_17 = arg_85_1.actors_["6045_story"]
			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 and not isNil(var_88_17) and arg_85_1.var_.characterEffect6045_story == nil then
				arg_85_1.var_.characterEffect6045_story = var_88_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_19 = 0.200000002980232

			if var_88_18 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_19 and not isNil(var_88_17) then
				local var_88_20 = (arg_85_1.time_ - var_88_18) / var_88_19

				if arg_85_1.var_.characterEffect6045_story and not isNil(var_88_17) then
					local var_88_21 = Mathf.Lerp(0, 0.5, var_88_20)

					arg_85_1.var_.characterEffect6045_story.fillFlat = true
					arg_85_1.var_.characterEffect6045_story.fillRatio = var_88_21
				end
			end

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 and not isNil(var_88_17) and arg_85_1.var_.characterEffect6045_story then
				local var_88_22 = 0.5

				arg_85_1.var_.characterEffect6045_story.fillFlat = true
				arg_85_1.var_.characterEffect6045_story.fillRatio = var_88_22
			end

			local var_88_23 = 0
			local var_88_24 = 1.025

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[214].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(1104202021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 41
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202021", "story_v_side_new_1104202.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202021", "story_v_side_new_1104202.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_side_new_1104202", "1104202021", "story_v_side_new_1104202.awb")

						arg_85_1:RecordAudio("1104202021", var_88_32)
						arg_85_1:RecordAudio("1104202021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202021", "story_v_side_new_1104202.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202021", "story_v_side_new_1104202.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1104202022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104202022
		arg_89_1.duration_ = 4.67

		local var_89_0 = {
			ja = 4.666,
			ko = 3.3,
			zh = 3.3
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
				arg_89_0:Play1104202023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.325

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[214].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(1104202022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202022", "story_v_side_new_1104202.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202022", "story_v_side_new_1104202.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_side_new_1104202", "1104202022", "story_v_side_new_1104202.awb")

						arg_89_1:RecordAudio("1104202022", var_92_9)
						arg_89_1:RecordAudio("1104202022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202022", "story_v_side_new_1104202.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202022", "story_v_side_new_1104202.awb")
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
	Play1104202023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104202023
		arg_93_1.duration_ = 12.93

		local var_93_0 = {
			ja = 7.4,
			ko = 12.933,
			zh = 12.933
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
				arg_93_0:Play1104202024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["6045_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect6045_story == nil then
				arg_93_1.var_.characterEffect6045_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect6045_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect6045_story then
				arg_93_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_6 = arg_93_1.actors_["6046_story"]
			local var_96_7 = 0

			if var_96_7 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect6046_story == nil then
				arg_93_1.var_.characterEffect6046_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_8 and not isNil(var_96_6) then
				local var_96_9 = (arg_93_1.time_ - var_96_7) / var_96_8

				if arg_93_1.var_.characterEffect6046_story and not isNil(var_96_6) then
					local var_96_10 = Mathf.Lerp(0, 0.5, var_96_9)

					arg_93_1.var_.characterEffect6046_story.fillFlat = true
					arg_93_1.var_.characterEffect6046_story.fillRatio = var_96_10
				end
			end

			if arg_93_1.time_ >= var_96_7 + var_96_8 and arg_93_1.time_ < var_96_7 + var_96_8 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect6046_story then
				local var_96_11 = 0.5

				arg_93_1.var_.characterEffect6046_story.fillFlat = true
				arg_93_1.var_.characterEffect6046_story.fillRatio = var_96_11
			end

			local var_96_12 = 0
			local var_96_13 = 0.825

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[215].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(1104202023)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 33
				local var_96_18 = utf8.len(var_96_16)
				local var_96_19 = var_96_17 <= 0 and var_96_13 or var_96_13 * (var_96_18 / var_96_17)

				if var_96_19 > 0 and var_96_13 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202023", "story_v_side_new_1104202.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202023", "story_v_side_new_1104202.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_side_new_1104202", "1104202023", "story_v_side_new_1104202.awb")

						arg_93_1:RecordAudio("1104202023", var_96_21)
						arg_93_1:RecordAudio("1104202023", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202023", "story_v_side_new_1104202.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202023", "story_v_side_new_1104202.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_22 and arg_93_1.time_ < var_96_12 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1104202024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104202024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1104202025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["6045_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect6045_story == nil then
				arg_97_1.var_.characterEffect6045_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect6045_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect6045_story.fillFlat = true
					arg_97_1.var_.characterEffect6045_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect6045_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect6045_story.fillFlat = true
				arg_97_1.var_.characterEffect6045_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.75

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(1104202024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 30
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1104202025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104202025
		arg_101_1.duration_ = 2.2

		local var_101_0 = {
			ja = 2.033,
			ko = 2.2,
			zh = 2.2
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
				arg_101_0:Play1104202026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["6045_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos6045_story = var_104_0.localPosition

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end
			end

			local var_104_3 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_3 then
				local var_104_4 = (arg_101_1.time_ - var_104_1) / var_104_3
				local var_104_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6045_story, var_104_5, var_104_4)

				local var_104_6 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_6.x, var_104_6.y, var_104_6.z)

				local var_104_7 = var_104_0.localEulerAngles

				var_104_7.z = 0
				var_104_7.x = 0
				var_104_0.localEulerAngles = var_104_7
			end

			if arg_101_1.time_ >= var_104_1 + var_104_3 and arg_101_1.time_ < var_104_1 + var_104_3 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_104_8 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_8.x, var_104_8.y, var_104_8.z)

				local var_104_9 = var_104_0.localEulerAngles

				var_104_9.z = 0
				var_104_9.x = 0
				var_104_0.localEulerAngles = var_104_9

				local var_104_10 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_10 then
					var_104_10:EnableDynamicBone(true)
				end
			end

			local var_104_11 = arg_101_1.actors_["6045_story"]
			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.characterEffect6045_story == nil then
				arg_101_1.var_.characterEffect6045_story = var_104_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_13 = 0.200000002980232

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_13 and not isNil(var_104_11) then
				local var_104_14 = (arg_101_1.time_ - var_104_12) / var_104_13

				if arg_101_1.var_.characterEffect6045_story and not isNil(var_104_11) then
					arg_101_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_12 + var_104_13 and arg_101_1.time_ < var_104_12 + var_104_13 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.characterEffect6045_story then
				arg_101_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_104_15 = arg_101_1.actors_["6046_story"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos6046_story = var_104_15.localPosition

				local var_104_17 = GameObjectTools.GetOrAddComponent(var_104_15.gameObject, typeof(DynamicBoneHelper))

				if var_104_17 then
					var_104_17:EnableDynamicBone(false)
				end
			end

			local var_104_18 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_18 then
				local var_104_19 = (arg_101_1.time_ - var_104_16) / var_104_18
				local var_104_20 = Vector3.New(0.7, -0.5, -6.3)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6046_story, var_104_20, var_104_19)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_15.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_15.localEulerAngles = var_104_22
			end

			if arg_101_1.time_ >= var_104_16 + var_104_18 and arg_101_1.time_ < var_104_16 + var_104_18 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_104_23 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_23.x, var_104_23.y, var_104_23.z)

				local var_104_24 = var_104_15.localEulerAngles

				var_104_24.z = 0
				var_104_24.x = 0
				var_104_15.localEulerAngles = var_104_24

				local var_104_25 = GameObjectTools.GetOrAddComponent(var_104_15.gameObject, typeof(DynamicBoneHelper))

				if var_104_25 then
					var_104_25:EnableDynamicBone(true)
				end
			end

			local var_104_26 = arg_101_1.actors_["6046_story"]
			local var_104_27 = 0

			if var_104_27 < arg_101_1.time_ and arg_101_1.time_ <= var_104_27 + arg_104_0 and not isNil(var_104_26) and arg_101_1.var_.characterEffect6046_story == nil then
				arg_101_1.var_.characterEffect6046_story = var_104_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_28 = 0.200000002980232

			if var_104_27 <= arg_101_1.time_ and arg_101_1.time_ < var_104_27 + var_104_28 and not isNil(var_104_26) then
				local var_104_29 = (arg_101_1.time_ - var_104_27) / var_104_28

				if arg_101_1.var_.characterEffect6046_story and not isNil(var_104_26) then
					arg_101_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_27 + var_104_28 and arg_101_1.time_ < var_104_27 + var_104_28 + arg_104_0 and not isNil(var_104_26) and arg_101_1.var_.characterEffect6046_story then
				arg_101_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_104_30 = 0
			local var_104_31 = 0.175

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[233].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(1104202025)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 7
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202025", "story_v_side_new_1104202.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202025", "story_v_side_new_1104202.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_side_new_1104202", "1104202025", "story_v_side_new_1104202.awb")

						arg_101_1:RecordAudio("1104202025", var_104_39)
						arg_101_1:RecordAudio("1104202025", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202025", "story_v_side_new_1104202.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202025", "story_v_side_new_1104202.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play1104202026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104202026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1104202027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["6046_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect6046_story == nil then
				arg_105_1.var_.characterEffect6046_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect6046_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect6046_story.fillFlat = true
					arg_105_1.var_.characterEffect6046_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect6046_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect6046_story.fillFlat = true
				arg_105_1.var_.characterEffect6046_story.fillRatio = var_108_5
			end

			local var_108_6 = arg_105_1.actors_["6045_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect6045_story == nil then
				arg_105_1.var_.characterEffect6045_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.200000002980232

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect6045_story and not isNil(var_108_6) then
					local var_108_10 = Mathf.Lerp(0, 0.5, var_108_9)

					arg_105_1.var_.characterEffect6045_story.fillFlat = true
					arg_105_1.var_.characterEffect6045_story.fillRatio = var_108_10
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect6045_story then
				local var_108_11 = 0.5

				arg_105_1.var_.characterEffect6045_story.fillFlat = true
				arg_105_1.var_.characterEffect6045_story.fillRatio = var_108_11
			end

			local var_108_12 = 0
			local var_108_13 = 0.575

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_15 = arg_105_1:GetWordFromCfg(1104202026)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 23
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_20 and arg_105_1.time_ < var_108_12 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1104202027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1104202027
		arg_109_1.duration_ = 3

		local var_109_0 = {
			ja = 2.5,
			ko = 3,
			zh = 3
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
				arg_109_0:Play1104202028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["6046_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect6046_story == nil then
				arg_109_1.var_.characterEffect6046_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect6046_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect6046_story then
				arg_109_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_6 = 0
			local var_112_7 = 0.325

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[214].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(1104202027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 13
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202027", "story_v_side_new_1104202.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202027", "story_v_side_new_1104202.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_side_new_1104202", "1104202027", "story_v_side_new_1104202.awb")

						arg_109_1:RecordAudio("1104202027", var_112_15)
						arg_109_1:RecordAudio("1104202027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202027", "story_v_side_new_1104202.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202027", "story_v_side_new_1104202.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1104202028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1104202028
		arg_113_1.duration_ = 7.33

		local var_113_0 = {
			ja = 6.666,
			ko = 7.333,
			zh = 7.333
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
				arg_113_0:Play1104202029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["6045_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6045_story == nil then
				arg_113_1.var_.characterEffect6045_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect6045_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6045_story then
				arg_113_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action5_1")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_6 = arg_113_1.actors_["6046_story"]
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect6046_story == nil then
				arg_113_1.var_.characterEffect6046_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_8 and not isNil(var_116_6) then
				local var_116_9 = (arg_113_1.time_ - var_116_7) / var_116_8

				if arg_113_1.var_.characterEffect6046_story and not isNil(var_116_6) then
					local var_116_10 = Mathf.Lerp(0, 0.5, var_116_9)

					arg_113_1.var_.characterEffect6046_story.fillFlat = true
					arg_113_1.var_.characterEffect6046_story.fillRatio = var_116_10
				end
			end

			if arg_113_1.time_ >= var_116_7 + var_116_8 and arg_113_1.time_ < var_116_7 + var_116_8 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect6046_story then
				local var_116_11 = 0.5

				arg_113_1.var_.characterEffect6046_story.fillFlat = true
				arg_113_1.var_.characterEffect6046_story.fillRatio = var_116_11
			end

			local var_116_12 = 0
			local var_116_13 = 0.625

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_14 = arg_113_1:FormatText(StoryNameCfg[215].name)

				arg_113_1.leftNameTxt_.text = var_116_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:GetWordFromCfg(1104202028)
				local var_116_16 = arg_113_1:FormatText(var_116_15.content)

				arg_113_1.text_.text = var_116_16

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 25
				local var_116_18 = utf8.len(var_116_16)
				local var_116_19 = var_116_17 <= 0 and var_116_13 or var_116_13 * (var_116_18 / var_116_17)

				if var_116_19 > 0 and var_116_13 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_16
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202028", "story_v_side_new_1104202.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202028", "story_v_side_new_1104202.awb") / 1000

					if var_116_20 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_12
					end

					if var_116_15.prefab_name ~= "" and arg_113_1.actors_[var_116_15.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_15.prefab_name].transform, "story_v_side_new_1104202", "1104202028", "story_v_side_new_1104202.awb")

						arg_113_1:RecordAudio("1104202028", var_116_21)
						arg_113_1:RecordAudio("1104202028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202028", "story_v_side_new_1104202.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202028", "story_v_side_new_1104202.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_22 and arg_113_1.time_ < var_116_12 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1104202029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1104202029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1104202030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["6045_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect6045_story == nil then
				arg_117_1.var_.characterEffect6045_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect6045_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect6045_story.fillFlat = true
					arg_117_1.var_.characterEffect6045_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect6045_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect6045_story.fillFlat = true
				arg_117_1.var_.characterEffect6045_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.275

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(1104202029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 11
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1104202030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1104202030
		arg_121_1.duration_ = 5.5

		local var_121_0 = {
			ja = 3.8,
			ko = 5.5,
			zh = 5.5
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1104202031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["6046_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect6046_story == nil then
				arg_121_1.var_.characterEffect6046_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect6046_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect6046_story then
				arg_121_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_6 = 0
			local var_124_7 = 0.525

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[214].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(1104202030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202030", "story_v_side_new_1104202.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202030", "story_v_side_new_1104202.awb") / 1000

					if var_124_14 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_6
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_side_new_1104202", "1104202030", "story_v_side_new_1104202.awb")

						arg_121_1:RecordAudio("1104202030", var_124_15)
						arg_121_1:RecordAudio("1104202030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202030", "story_v_side_new_1104202.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202030", "story_v_side_new_1104202.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_16 and arg_121_1.time_ < var_124_6 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1104202031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1104202031
		arg_125_1.duration_ = 5.5

		local var_125_0 = {
			ja = 4.4,
			ko = 5.5,
			zh = 5.5
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
				arg_125_0:Play1104202032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["6045_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6045_story == nil then
				arg_125_1.var_.characterEffect6045_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect6045_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6045_story then
				arg_125_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_128_4 = 0

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action5_2")
			end

			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_6 = arg_125_1.actors_["6046_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect6046_story == nil then
				arg_125_1.var_.characterEffect6046_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect6046_story and not isNil(var_128_6) then
					local var_128_10 = Mathf.Lerp(0, 0.5, var_128_9)

					arg_125_1.var_.characterEffect6046_story.fillFlat = true
					arg_125_1.var_.characterEffect6046_story.fillRatio = var_128_10
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect6046_story then
				local var_128_11 = 0.5

				arg_125_1.var_.characterEffect6046_story.fillFlat = true
				arg_125_1.var_.characterEffect6046_story.fillRatio = var_128_11
			end

			local var_128_12 = 0
			local var_128_13 = 0.45

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[215].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(1104202031)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 18
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202031", "story_v_side_new_1104202.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202031", "story_v_side_new_1104202.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_side_new_1104202", "1104202031", "story_v_side_new_1104202.awb")

						arg_125_1:RecordAudio("1104202031", var_128_21)
						arg_125_1:RecordAudio("1104202031", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202031", "story_v_side_new_1104202.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202031", "story_v_side_new_1104202.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1104202032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1104202032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1104202033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["6045_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect6045_story == nil then
				arg_129_1.var_.characterEffect6045_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect6045_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect6045_story.fillFlat = true
					arg_129_1.var_.characterEffect6045_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect6045_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect6045_story.fillFlat = true
				arg_129_1.var_.characterEffect6045_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.4

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(1104202032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 16
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1104202033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1104202033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1104202034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.325

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(1104202033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 13
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
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1104202034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1104202034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1104202035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["6045_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect6045_story == nil then
				arg_137_1.var_.characterEffect6045_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect6045_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect6045_story then
				arg_137_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_6 = 0
			local var_140_7 = 0.125

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[215].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(1104202034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 5
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202034", "story_v_side_new_1104202.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202034", "story_v_side_new_1104202.awb") / 1000

					if var_140_14 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_6
					end

					if var_140_9.prefab_name ~= "" and arg_137_1.actors_[var_140_9.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_9.prefab_name].transform, "story_v_side_new_1104202", "1104202034", "story_v_side_new_1104202.awb")

						arg_137_1:RecordAudio("1104202034", var_140_15)
						arg_137_1:RecordAudio("1104202034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202034", "story_v_side_new_1104202.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202034", "story_v_side_new_1104202.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_16 and arg_137_1.time_ < var_140_6 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1104202035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1104202035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1104202036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["6045_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect6045_story == nil then
				arg_141_1.var_.characterEffect6045_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect6045_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect6045_story.fillFlat = true
					arg_141_1.var_.characterEffect6045_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect6045_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect6045_story.fillFlat = true
				arg_141_1.var_.characterEffect6045_story.fillRatio = var_144_5
			end

			local var_144_6 = 0
			local var_144_7 = 1.425

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_9 = arg_141_1:GetWordFromCfg(1104202035)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 57
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1104202036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1104202036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1104202037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.675

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(1104202036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 27
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1104202037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1104202037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1104202038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.625

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(1104202037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 25
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
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1104202038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1104202038
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1104202039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["6045_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos6045_story = var_156_0.localPosition

				local var_156_2 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(false)
				end
			end

			local var_156_3 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3
				local var_156_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos6045_story, var_156_5, var_156_4)

				local var_156_6 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_6.x, var_156_6.y, var_156_6.z)

				local var_156_7 = var_156_0.localEulerAngles

				var_156_7.z = 0
				var_156_7.x = 0
				var_156_0.localEulerAngles = var_156_7
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_156_8 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_8.x, var_156_8.y, var_156_8.z)

				local var_156_9 = var_156_0.localEulerAngles

				var_156_9.z = 0
				var_156_9.x = 0
				var_156_0.localEulerAngles = var_156_9

				local var_156_10 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_10 then
					var_156_10:EnableDynamicBone(true)
				end
			end

			local var_156_11 = arg_153_1.actors_["6045_story"]
			local var_156_12 = 0

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.characterEffect6045_story == nil then
				arg_153_1.var_.characterEffect6045_story = var_156_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_13 = 0.200000002980232

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_13 and not isNil(var_156_11) then
				local var_156_14 = (arg_153_1.time_ - var_156_12) / var_156_13

				if arg_153_1.var_.characterEffect6045_story and not isNil(var_156_11) then
					arg_153_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_12 + var_156_13 and arg_153_1.time_ < var_156_12 + var_156_13 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.characterEffect6045_story then
				arg_153_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_156_15 = arg_153_1.actors_["6046_story"].transform
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.var_.moveOldPos6046_story = var_156_15.localPosition

				local var_156_17 = GameObjectTools.GetOrAddComponent(var_156_15.gameObject, typeof(DynamicBoneHelper))

				if var_156_17 then
					var_156_17:EnableDynamicBone(false)
				end
			end

			local var_156_18 = 0.001

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_18 then
				local var_156_19 = (arg_153_1.time_ - var_156_16) / var_156_18
				local var_156_20 = Vector3.New(0.7, -0.5, -6.3)

				var_156_15.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos6046_story, var_156_20, var_156_19)

				local var_156_21 = manager.ui.mainCamera.transform.position - var_156_15.position

				var_156_15.forward = Vector3.New(var_156_21.x, var_156_21.y, var_156_21.z)

				local var_156_22 = var_156_15.localEulerAngles

				var_156_22.z = 0
				var_156_22.x = 0
				var_156_15.localEulerAngles = var_156_22
			end

			if arg_153_1.time_ >= var_156_16 + var_156_18 and arg_153_1.time_ < var_156_16 + var_156_18 + arg_156_0 then
				var_156_15.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_156_23 = manager.ui.mainCamera.transform.position - var_156_15.position

				var_156_15.forward = Vector3.New(var_156_23.x, var_156_23.y, var_156_23.z)

				local var_156_24 = var_156_15.localEulerAngles

				var_156_24.z = 0
				var_156_24.x = 0
				var_156_15.localEulerAngles = var_156_24

				local var_156_25 = GameObjectTools.GetOrAddComponent(var_156_15.gameObject, typeof(DynamicBoneHelper))

				if var_156_25 then
					var_156_25:EnableDynamicBone(true)
				end
			end

			local var_156_26 = arg_153_1.actors_["6046_story"]
			local var_156_27 = 0

			if var_156_27 < arg_153_1.time_ and arg_153_1.time_ <= var_156_27 + arg_156_0 and not isNil(var_156_26) and arg_153_1.var_.characterEffect6046_story == nil then
				arg_153_1.var_.characterEffect6046_story = var_156_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_28 = 0.200000002980232

			if var_156_27 <= arg_153_1.time_ and arg_153_1.time_ < var_156_27 + var_156_28 and not isNil(var_156_26) then
				local var_156_29 = (arg_153_1.time_ - var_156_27) / var_156_28

				if arg_153_1.var_.characterEffect6046_story and not isNil(var_156_26) then
					arg_153_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_27 + var_156_28 and arg_153_1.time_ < var_156_27 + var_156_28 + arg_156_0 and not isNil(var_156_26) and arg_153_1.var_.characterEffect6046_story then
				arg_153_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_156_30 = 0

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_156_31 = 0

			if var_156_31 < arg_153_1.time_ and arg_153_1.time_ <= var_156_31 + arg_156_0 then
				arg_153_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_156_32 = 0
			local var_156_33 = 0.05

			if var_156_32 < arg_153_1.time_ and arg_153_1.time_ <= var_156_32 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_34 = arg_153_1:FormatText(StoryNameCfg[233].name)

				arg_153_1.leftNameTxt_.text = var_156_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_35 = arg_153_1:GetWordFromCfg(1104202038)
				local var_156_36 = arg_153_1:FormatText(var_156_35.content)

				arg_153_1.text_.text = var_156_36

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_37 = 2
				local var_156_38 = utf8.len(var_156_36)
				local var_156_39 = var_156_37 <= 0 and var_156_33 or var_156_33 * (var_156_38 / var_156_37)

				if var_156_39 > 0 and var_156_33 < var_156_39 then
					arg_153_1.talkMaxDuration = var_156_39

					if var_156_39 + var_156_32 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_39 + var_156_32
					end
				end

				arg_153_1.text_.text = var_156_36
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202038", "story_v_side_new_1104202.awb") ~= 0 then
					local var_156_40 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202038", "story_v_side_new_1104202.awb") / 1000

					if var_156_40 + var_156_32 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_40 + var_156_32
					end

					if var_156_35.prefab_name ~= "" and arg_153_1.actors_[var_156_35.prefab_name] ~= nil then
						local var_156_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_35.prefab_name].transform, "story_v_side_new_1104202", "1104202038", "story_v_side_new_1104202.awb")

						arg_153_1:RecordAudio("1104202038", var_156_41)
						arg_153_1:RecordAudio("1104202038", var_156_41)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202038", "story_v_side_new_1104202.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202038", "story_v_side_new_1104202.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_42 = math.max(var_156_33, arg_153_1.talkMaxDuration)

			if var_156_32 <= arg_153_1.time_ and arg_153_1.time_ < var_156_32 + var_156_42 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_32) / var_156_42

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_32 + var_156_42 and arg_153_1.time_ < var_156_32 + var_156_42 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1104202039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1104202039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1104202040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["6046_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect6046_story == nil then
				arg_157_1.var_.characterEffect6046_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect6046_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect6046_story.fillFlat = true
					arg_157_1.var_.characterEffect6046_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect6046_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect6046_story.fillFlat = true
				arg_157_1.var_.characterEffect6046_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["6045_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect6045_story == nil then
				arg_157_1.var_.characterEffect6045_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect6045_story and not isNil(var_160_6) then
					local var_160_10 = Mathf.Lerp(0, 0.5, var_160_9)

					arg_157_1.var_.characterEffect6045_story.fillFlat = true
					arg_157_1.var_.characterEffect6045_story.fillRatio = var_160_10
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect6045_story then
				local var_160_11 = 0.5

				arg_157_1.var_.characterEffect6045_story.fillFlat = true
				arg_157_1.var_.characterEffect6045_story.fillRatio = var_160_11
			end

			local var_160_12 = 0
			local var_160_13 = 0.65

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_14 = arg_157_1:GetWordFromCfg(1104202039)
				local var_160_15 = arg_157_1:FormatText(var_160_14.content)

				arg_157_1.text_.text = var_160_15

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 26
				local var_160_17 = utf8.len(var_160_15)
				local var_160_18 = var_160_16 <= 0 and var_160_13 or var_160_13 * (var_160_17 / var_160_16)

				if var_160_18 > 0 and var_160_13 < var_160_18 then
					arg_157_1.talkMaxDuration = var_160_18

					if var_160_18 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_15
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_19 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_19 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_19

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_19 and arg_157_1.time_ < var_160_12 + var_160_19 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1104202040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1104202040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1104202041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.175

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(1104202040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 7
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1104202041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1104202041
		arg_165_1.duration_ = 16.1

		local var_165_0 = {
			ja = 16.1,
			ko = 14.166,
			zh = 14.166
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
				arg_165_0:Play1104202042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["6046_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect6046_story == nil then
				arg_165_1.var_.characterEffect6046_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect6046_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect6046_story then
				arg_165_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_168_4 = 0

			if var_168_4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_6 = 0
			local var_168_7 = 1.3

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_8 = arg_165_1:FormatText(StoryNameCfg[214].name)

				arg_165_1.leftNameTxt_.text = var_168_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_9 = arg_165_1:GetWordFromCfg(1104202041)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 52
				local var_168_12 = utf8.len(var_168_10)
				local var_168_13 = var_168_11 <= 0 and var_168_7 or var_168_7 * (var_168_12 / var_168_11)

				if var_168_13 > 0 and var_168_7 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202041", "story_v_side_new_1104202.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202041", "story_v_side_new_1104202.awb") / 1000

					if var_168_14 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_6
					end

					if var_168_9.prefab_name ~= "" and arg_165_1.actors_[var_168_9.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_9.prefab_name].transform, "story_v_side_new_1104202", "1104202041", "story_v_side_new_1104202.awb")

						arg_165_1:RecordAudio("1104202041", var_168_15)
						arg_165_1:RecordAudio("1104202041", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202041", "story_v_side_new_1104202.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202041", "story_v_side_new_1104202.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_16 and arg_165_1.time_ < var_168_6 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1104202042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1104202042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1104202043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["6046_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect6046_story == nil then
				arg_169_1.var_.characterEffect6046_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect6046_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect6046_story.fillFlat = true
					arg_169_1.var_.characterEffect6046_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect6046_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect6046_story.fillFlat = true
				arg_169_1.var_.characterEffect6046_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.05

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_8

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

				local var_172_9 = arg_169_1:GetWordFromCfg(1104202042)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 2
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1104202043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1104202043
		arg_173_1.duration_ = 4.2

		local var_173_0 = {
			ja = 3.1,
			ko = 4.2,
			zh = 4.2
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
				arg_173_0:Play1104202044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["6045_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect6045_story == nil then
				arg_173_1.var_.characterEffect6045_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect6045_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect6045_story then
				arg_173_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_6 = 0
			local var_176_7 = 0.325

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[215].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_9 = arg_173_1:GetWordFromCfg(1104202043)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 13
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202043", "story_v_side_new_1104202.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202043", "story_v_side_new_1104202.awb") / 1000

					if var_176_14 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_6
					end

					if var_176_9.prefab_name ~= "" and arg_173_1.actors_[var_176_9.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_9.prefab_name].transform, "story_v_side_new_1104202", "1104202043", "story_v_side_new_1104202.awb")

						arg_173_1:RecordAudio("1104202043", var_176_15)
						arg_173_1:RecordAudio("1104202043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202043", "story_v_side_new_1104202.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202043", "story_v_side_new_1104202.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_16 and arg_173_1.time_ < var_176_6 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1104202044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1104202044
		arg_177_1.duration_ = 5.7

		local var_177_0 = {
			ja = 4.4,
			ko = 5.7,
			zh = 5.7
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
				arg_177_0:Play1104202045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["6046_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect6046_story == nil then
				arg_177_1.var_.characterEffect6046_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect6046_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect6046_story then
				arg_177_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_6 = arg_177_1.actors_["6045_story"]
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect6045_story == nil then
				arg_177_1.var_.characterEffect6045_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_8 = 0.200000002980232

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 and not isNil(var_180_6) then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8

				if arg_177_1.var_.characterEffect6045_story and not isNil(var_180_6) then
					local var_180_10 = Mathf.Lerp(0, 0.5, var_180_9)

					arg_177_1.var_.characterEffect6045_story.fillFlat = true
					arg_177_1.var_.characterEffect6045_story.fillRatio = var_180_10
				end
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect6045_story then
				local var_180_11 = 0.5

				arg_177_1.var_.characterEffect6045_story.fillFlat = true
				arg_177_1.var_.characterEffect6045_story.fillRatio = var_180_11
			end

			local var_180_12 = 0
			local var_180_13 = 0.5

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_14 = arg_177_1:FormatText(StoryNameCfg[214].name)

				arg_177_1.leftNameTxt_.text = var_180_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_15 = arg_177_1:GetWordFromCfg(1104202044)
				local var_180_16 = arg_177_1:FormatText(var_180_15.content)

				arg_177_1.text_.text = var_180_16

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 20
				local var_180_18 = utf8.len(var_180_16)
				local var_180_19 = var_180_17 <= 0 and var_180_13 or var_180_13 * (var_180_18 / var_180_17)

				if var_180_19 > 0 and var_180_13 < var_180_19 then
					arg_177_1.talkMaxDuration = var_180_19

					if var_180_19 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_16
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202044", "story_v_side_new_1104202.awb") ~= 0 then
					local var_180_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202044", "story_v_side_new_1104202.awb") / 1000

					if var_180_20 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_12
					end

					if var_180_15.prefab_name ~= "" and arg_177_1.actors_[var_180_15.prefab_name] ~= nil then
						local var_180_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_15.prefab_name].transform, "story_v_side_new_1104202", "1104202044", "story_v_side_new_1104202.awb")

						arg_177_1:RecordAudio("1104202044", var_180_21)
						arg_177_1:RecordAudio("1104202044", var_180_21)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202044", "story_v_side_new_1104202.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202044", "story_v_side_new_1104202.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_22 and arg_177_1.time_ < var_180_12 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1104202045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1104202045
		arg_181_1.duration_ = 10.3

		local var_181_0 = {
			ja = 8.6,
			ko = 10.3,
			zh = 10.3
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
				arg_181_0:Play1104202046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.05

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[214].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(1104202045)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202045", "story_v_side_new_1104202.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202045", "story_v_side_new_1104202.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_side_new_1104202", "1104202045", "story_v_side_new_1104202.awb")

						arg_181_1:RecordAudio("1104202045", var_184_9)
						arg_181_1:RecordAudio("1104202045", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202045", "story_v_side_new_1104202.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202045", "story_v_side_new_1104202.awb")
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
	Play1104202046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1104202046
		arg_185_1.duration_ = 5.93

		local var_185_0 = {
			ja = 5.3,
			ko = 5.933,
			zh = 5.933
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1104202047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["6045_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect6045_story == nil then
				arg_185_1.var_.characterEffect6045_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect6045_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect6045_story then
				arg_185_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_6 = arg_185_1.actors_["6046_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect6046_story == nil then
				arg_185_1.var_.characterEffect6046_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.200000002980232

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect6046_story and not isNil(var_188_6) then
					local var_188_10 = Mathf.Lerp(0, 0.5, var_188_9)

					arg_185_1.var_.characterEffect6046_story.fillFlat = true
					arg_185_1.var_.characterEffect6046_story.fillRatio = var_188_10
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect6046_story then
				local var_188_11 = 0.5

				arg_185_1.var_.characterEffect6046_story.fillFlat = true
				arg_185_1.var_.characterEffect6046_story.fillRatio = var_188_11
			end

			local var_188_12 = 0
			local var_188_13 = 0.5

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[215].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(1104202046)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 20
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202046", "story_v_side_new_1104202.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202046", "story_v_side_new_1104202.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_side_new_1104202", "1104202046", "story_v_side_new_1104202.awb")

						arg_185_1:RecordAudio("1104202046", var_188_21)
						arg_185_1:RecordAudio("1104202046", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202046", "story_v_side_new_1104202.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202046", "story_v_side_new_1104202.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1104202047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1104202047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1104202048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["6045_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect6045_story == nil then
				arg_189_1.var_.characterEffect6045_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect6045_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect6045_story.fillFlat = true
					arg_189_1.var_.characterEffect6045_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect6045_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect6045_story.fillFlat = true
				arg_189_1.var_.characterEffect6045_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.575

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(1104202047)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 23
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1104202048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1104202048
		arg_193_1.duration_ = 8.3

		local var_193_0 = {
			ja = 8.3,
			ko = 5.133,
			zh = 5.133
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1104202049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["6046_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect6046_story == nil then
				arg_193_1.var_.characterEffect6046_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect6046_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect6046_story then
				arg_193_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_196_4 = 0

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_6 = 0
			local var_196_7 = 0.575

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[214].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_9 = arg_193_1:GetWordFromCfg(1104202048)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 23
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202048", "story_v_side_new_1104202.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202048", "story_v_side_new_1104202.awb") / 1000

					if var_196_14 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_6
					end

					if var_196_9.prefab_name ~= "" and arg_193_1.actors_[var_196_9.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_9.prefab_name].transform, "story_v_side_new_1104202", "1104202048", "story_v_side_new_1104202.awb")

						arg_193_1:RecordAudio("1104202048", var_196_15)
						arg_193_1:RecordAudio("1104202048", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202048", "story_v_side_new_1104202.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202048", "story_v_side_new_1104202.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_16 and arg_193_1.time_ < var_196_6 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1104202049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1104202049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1104202050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["6046_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect6046_story == nil then
				arg_197_1.var_.characterEffect6046_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect6046_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect6046_story.fillFlat = true
					arg_197_1.var_.characterEffect6046_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect6046_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect6046_story.fillFlat = true
				arg_197_1.var_.characterEffect6046_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.15

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(1104202049)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 6
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1104202050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1104202050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1104202051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["6046_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos6046_story = var_204_0.localPosition

				local var_204_2 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_2 then
					var_204_2:EnableDynamicBone(false)
				end
			end

			local var_204_3 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_3 then
				local var_204_4 = (arg_201_1.time_ - var_204_1) / var_204_3
				local var_204_5 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos6046_story, var_204_5, var_204_4)

				local var_204_6 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_6.x, var_204_6.y, var_204_6.z)

				local var_204_7 = var_204_0.localEulerAngles

				var_204_7.z = 0
				var_204_7.x = 0
				var_204_0.localEulerAngles = var_204_7
			end

			if arg_201_1.time_ >= var_204_1 + var_204_3 and arg_201_1.time_ < var_204_1 + var_204_3 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_8 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_8.x, var_204_8.y, var_204_8.z)

				local var_204_9 = var_204_0.localEulerAngles

				var_204_9.z = 0
				var_204_9.x = 0
				var_204_0.localEulerAngles = var_204_9

				local var_204_10 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_10 then
					var_204_10:EnableDynamicBone(true)
				end
			end

			local var_204_11 = arg_201_1.actors_["6046_story"]
			local var_204_12 = 0

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect6046_story == nil then
				arg_201_1.var_.characterEffect6046_story = var_204_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_13 = 0.200000002980232

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_13 and not isNil(var_204_11) then
				local var_204_14 = (arg_201_1.time_ - var_204_12) / var_204_13

				if arg_201_1.var_.characterEffect6046_story and not isNil(var_204_11) then
					local var_204_15 = Mathf.Lerp(0, 0.5, var_204_14)

					arg_201_1.var_.characterEffect6046_story.fillFlat = true
					arg_201_1.var_.characterEffect6046_story.fillRatio = var_204_15
				end
			end

			if arg_201_1.time_ >= var_204_12 + var_204_13 and arg_201_1.time_ < var_204_12 + var_204_13 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect6046_story then
				local var_204_16 = 0.5

				arg_201_1.var_.characterEffect6046_story.fillFlat = true
				arg_201_1.var_.characterEffect6046_story.fillRatio = var_204_16
			end

			local var_204_17 = arg_201_1.actors_["6045_story"].transform
			local var_204_18 = 0

			if var_204_18 < arg_201_1.time_ and arg_201_1.time_ <= var_204_18 + arg_204_0 then
				arg_201_1.var_.moveOldPos6045_story = var_204_17.localPosition

				local var_204_19 = GameObjectTools.GetOrAddComponent(var_204_17.gameObject, typeof(DynamicBoneHelper))

				if var_204_19 then
					var_204_19:EnableDynamicBone(false)
				end
			end

			local var_204_20 = 0.001

			if var_204_18 <= arg_201_1.time_ and arg_201_1.time_ < var_204_18 + var_204_20 then
				local var_204_21 = (arg_201_1.time_ - var_204_18) / var_204_20
				local var_204_22 = Vector3.New(0, 100, 0)

				var_204_17.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos6045_story, var_204_22, var_204_21)

				local var_204_23 = manager.ui.mainCamera.transform.position - var_204_17.position

				var_204_17.forward = Vector3.New(var_204_23.x, var_204_23.y, var_204_23.z)

				local var_204_24 = var_204_17.localEulerAngles

				var_204_24.z = 0
				var_204_24.x = 0
				var_204_17.localEulerAngles = var_204_24
			end

			if arg_201_1.time_ >= var_204_18 + var_204_20 and arg_201_1.time_ < var_204_18 + var_204_20 + arg_204_0 then
				var_204_17.localPosition = Vector3.New(0, 100, 0)

				local var_204_25 = manager.ui.mainCamera.transform.position - var_204_17.position

				var_204_17.forward = Vector3.New(var_204_25.x, var_204_25.y, var_204_25.z)

				local var_204_26 = var_204_17.localEulerAngles

				var_204_26.z = 0
				var_204_26.x = 0
				var_204_17.localEulerAngles = var_204_26

				local var_204_27 = GameObjectTools.GetOrAddComponent(var_204_17.gameObject, typeof(DynamicBoneHelper))

				if var_204_27 then
					var_204_27:EnableDynamicBone(true)
				end
			end

			local var_204_28 = arg_201_1.actors_["6045_story"]
			local var_204_29 = 0

			if var_204_29 < arg_201_1.time_ and arg_201_1.time_ <= var_204_29 + arg_204_0 and not isNil(var_204_28) and arg_201_1.var_.characterEffect6045_story == nil then
				arg_201_1.var_.characterEffect6045_story = var_204_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_30 = 0.200000002980232

			if var_204_29 <= arg_201_1.time_ and arg_201_1.time_ < var_204_29 + var_204_30 and not isNil(var_204_28) then
				local var_204_31 = (arg_201_1.time_ - var_204_29) / var_204_30

				if arg_201_1.var_.characterEffect6045_story and not isNil(var_204_28) then
					local var_204_32 = Mathf.Lerp(0, 0.5, var_204_31)

					arg_201_1.var_.characterEffect6045_story.fillFlat = true
					arg_201_1.var_.characterEffect6045_story.fillRatio = var_204_32
				end
			end

			if arg_201_1.time_ >= var_204_29 + var_204_30 and arg_201_1.time_ < var_204_29 + var_204_30 + arg_204_0 and not isNil(var_204_28) and arg_201_1.var_.characterEffect6045_story then
				local var_204_33 = 0.5

				arg_201_1.var_.characterEffect6045_story.fillFlat = true
				arg_201_1.var_.characterEffect6045_story.fillRatio = var_204_33
			end

			local var_204_34 = 0
			local var_204_35 = 0.95

			if var_204_34 < arg_201_1.time_ and arg_201_1.time_ <= var_204_34 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_36 = arg_201_1:GetWordFromCfg(1104202050)
				local var_204_37 = arg_201_1:FormatText(var_204_36.content)

				arg_201_1.text_.text = var_204_37

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_38 = 38
				local var_204_39 = utf8.len(var_204_37)
				local var_204_40 = var_204_38 <= 0 and var_204_35 or var_204_35 * (var_204_39 / var_204_38)

				if var_204_40 > 0 and var_204_35 < var_204_40 then
					arg_201_1.talkMaxDuration = var_204_40

					if var_204_40 + var_204_34 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_40 + var_204_34
					end
				end

				arg_201_1.text_.text = var_204_37
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_41 = math.max(var_204_35, arg_201_1.talkMaxDuration)

			if var_204_34 <= arg_201_1.time_ and arg_201_1.time_ < var_204_34 + var_204_41 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_34) / var_204_41

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_34 + var_204_41 and arg_201_1.time_ < var_204_34 + var_204_41 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1104202051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1104202051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1104202052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.95

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(1104202051)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 38
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1104202052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1104202052
		arg_209_1.duration_ = 3.13

		local var_209_0 = {
			ja = 3.066,
			ko = 3.133,
			zh = 3.133
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1104202053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["6045_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos6045_story = var_212_0.localPosition

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end
			end

			local var_212_3 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos6045_story, var_212_5, var_212_4)

				local var_212_6 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_6.x, var_212_6.y, var_212_6.z)

				local var_212_7 = var_212_0.localEulerAngles

				var_212_7.z = 0
				var_212_7.x = 0
				var_212_0.localEulerAngles = var_212_7
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_212_8 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_8.x, var_212_8.y, var_212_8.z)

				local var_212_9 = var_212_0.localEulerAngles

				var_212_9.z = 0
				var_212_9.x = 0
				var_212_0.localEulerAngles = var_212_9

				local var_212_10 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_10 then
					var_212_10:EnableDynamicBone(true)
				end
			end

			local var_212_11 = arg_209_1.actors_["6045_story"]
			local var_212_12 = 0

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect6045_story == nil then
				arg_209_1.var_.characterEffect6045_story = var_212_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_13 = 0.200000002980232

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_13 and not isNil(var_212_11) then
				local var_212_14 = (arg_209_1.time_ - var_212_12) / var_212_13

				if arg_209_1.var_.characterEffect6045_story and not isNil(var_212_11) then
					arg_209_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_12 + var_212_13 and arg_209_1.time_ < var_212_12 + var_212_13 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect6045_story then
				arg_209_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_17 = 0
			local var_212_18 = 0.175

			if var_212_17 < arg_209_1.time_ and arg_209_1.time_ <= var_212_17 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_19 = arg_209_1:FormatText(StoryNameCfg[215].name)

				arg_209_1.leftNameTxt_.text = var_212_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_20 = arg_209_1:GetWordFromCfg(1104202052)
				local var_212_21 = arg_209_1:FormatText(var_212_20.content)

				arg_209_1.text_.text = var_212_21

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_22 = 7
				local var_212_23 = utf8.len(var_212_21)
				local var_212_24 = var_212_22 <= 0 and var_212_18 or var_212_18 * (var_212_23 / var_212_22)

				if var_212_24 > 0 and var_212_18 < var_212_24 then
					arg_209_1.talkMaxDuration = var_212_24

					if var_212_24 + var_212_17 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_17
					end
				end

				arg_209_1.text_.text = var_212_21
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202052", "story_v_side_new_1104202.awb") ~= 0 then
					local var_212_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202052", "story_v_side_new_1104202.awb") / 1000

					if var_212_25 + var_212_17 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_25 + var_212_17
					end

					if var_212_20.prefab_name ~= "" and arg_209_1.actors_[var_212_20.prefab_name] ~= nil then
						local var_212_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_20.prefab_name].transform, "story_v_side_new_1104202", "1104202052", "story_v_side_new_1104202.awb")

						arg_209_1:RecordAudio("1104202052", var_212_26)
						arg_209_1:RecordAudio("1104202052", var_212_26)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202052", "story_v_side_new_1104202.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202052", "story_v_side_new_1104202.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_27 = math.max(var_212_18, arg_209_1.talkMaxDuration)

			if var_212_17 <= arg_209_1.time_ and arg_209_1.time_ < var_212_17 + var_212_27 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_17) / var_212_27

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_17 + var_212_27 and arg_209_1.time_ < var_212_17 + var_212_27 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1104202053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1104202053
		arg_213_1.duration_ = 3.5

		local var_213_0 = {
			ja = 2.733,
			ko = 3.5,
			zh = 3.5
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
				arg_213_0:Play1104202054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["6046_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos6046_story = var_216_0.localPosition

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(0.7, -0.5, -6.3)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos6046_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9

				local var_216_10 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_10 then
					var_216_10:EnableDynamicBone(true)
				end
			end

			local var_216_11 = arg_213_1.actors_["6046_story"]
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect6046_story == nil then
				arg_213_1.var_.characterEffect6046_story = var_216_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_13 = 0.200000002980232

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 and not isNil(var_216_11) then
				local var_216_14 = (arg_213_1.time_ - var_216_12) / var_216_13

				if arg_213_1.var_.characterEffect6046_story and not isNil(var_216_11) then
					arg_213_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect6046_story then
				arg_213_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_216_15 = 0

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_17 = arg_213_1.actors_["6045_story"]
			local var_216_18 = 0

			if var_216_18 < arg_213_1.time_ and arg_213_1.time_ <= var_216_18 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect6045_story == nil then
				arg_213_1.var_.characterEffect6045_story = var_216_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_19 = 0.200000002980232

			if var_216_18 <= arg_213_1.time_ and arg_213_1.time_ < var_216_18 + var_216_19 and not isNil(var_216_17) then
				local var_216_20 = (arg_213_1.time_ - var_216_18) / var_216_19

				if arg_213_1.var_.characterEffect6045_story and not isNil(var_216_17) then
					local var_216_21 = Mathf.Lerp(0, 0.5, var_216_20)

					arg_213_1.var_.characterEffect6045_story.fillFlat = true
					arg_213_1.var_.characterEffect6045_story.fillRatio = var_216_21
				end
			end

			if arg_213_1.time_ >= var_216_18 + var_216_19 and arg_213_1.time_ < var_216_18 + var_216_19 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect6045_story then
				local var_216_22 = 0.5

				arg_213_1.var_.characterEffect6045_story.fillFlat = true
				arg_213_1.var_.characterEffect6045_story.fillRatio = var_216_22
			end

			local var_216_23 = 0
			local var_216_24 = 0.275

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_25 = arg_213_1:FormatText(StoryNameCfg[214].name)

				arg_213_1.leftNameTxt_.text = var_216_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(1104202053)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 11
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_24 or var_216_24 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_24 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_23
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202053", "story_v_side_new_1104202.awb") ~= 0 then
					local var_216_31 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202053", "story_v_side_new_1104202.awb") / 1000

					if var_216_31 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_31 + var_216_23
					end

					if var_216_26.prefab_name ~= "" and arg_213_1.actors_[var_216_26.prefab_name] ~= nil then
						local var_216_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_26.prefab_name].transform, "story_v_side_new_1104202", "1104202053", "story_v_side_new_1104202.awb")

						arg_213_1:RecordAudio("1104202053", var_216_32)
						arg_213_1:RecordAudio("1104202053", var_216_32)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202053", "story_v_side_new_1104202.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202053", "story_v_side_new_1104202.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_33 = math.max(var_216_24, arg_213_1.talkMaxDuration)

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_33 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_23) / var_216_33

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_23 + var_216_33 and arg_213_1.time_ < var_216_23 + var_216_33 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1104202054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1104202054
		arg_217_1.duration_ = 13.73

		local var_217_0 = {
			ja = 8.066,
			ko = 13.733,
			zh = 13.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1104202055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["6045_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos6045_story = var_220_0.localPosition

				local var_220_2 = GameObjectTools.GetOrAddComponent(var_220_0.gameObject, typeof(DynamicBoneHelper))

				if var_220_2 then
					var_220_2:EnableDynamicBone(false)
				end
			end

			local var_220_3 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_3 then
				local var_220_4 = (arg_217_1.time_ - var_220_1) / var_220_3
				local var_220_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos6045_story, var_220_5, var_220_4)

				local var_220_6 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_6.x, var_220_6.y, var_220_6.z)

				local var_220_7 = var_220_0.localEulerAngles

				var_220_7.z = 0
				var_220_7.x = 0
				var_220_0.localEulerAngles = var_220_7
			end

			if arg_217_1.time_ >= var_220_1 + var_220_3 and arg_217_1.time_ < var_220_1 + var_220_3 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_220_8 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_8.x, var_220_8.y, var_220_8.z)

				local var_220_9 = var_220_0.localEulerAngles

				var_220_9.z = 0
				var_220_9.x = 0
				var_220_0.localEulerAngles = var_220_9

				local var_220_10 = GameObjectTools.GetOrAddComponent(var_220_0.gameObject, typeof(DynamicBoneHelper))

				if var_220_10 then
					var_220_10:EnableDynamicBone(true)
				end
			end

			local var_220_11 = arg_217_1.actors_["6045_story"]
			local var_220_12 = 0

			if var_220_12 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 and not isNil(var_220_11) and arg_217_1.var_.characterEffect6045_story == nil then
				arg_217_1.var_.characterEffect6045_story = var_220_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_13 = 0.200000002980232

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_13 and not isNil(var_220_11) then
				local var_220_14 = (arg_217_1.time_ - var_220_12) / var_220_13

				if arg_217_1.var_.characterEffect6045_story and not isNil(var_220_11) then
					arg_217_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_12 + var_220_13 and arg_217_1.time_ < var_220_12 + var_220_13 + arg_220_0 and not isNil(var_220_11) and arg_217_1.var_.characterEffect6045_story then
				arg_217_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_220_15 = 0

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_17 = arg_217_1.actors_["6046_story"]
			local var_220_18 = 0

			if var_220_18 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 and not isNil(var_220_17) and arg_217_1.var_.characterEffect6046_story == nil then
				arg_217_1.var_.characterEffect6046_story = var_220_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_19 = 0.200000002980232

			if var_220_18 <= arg_217_1.time_ and arg_217_1.time_ < var_220_18 + var_220_19 and not isNil(var_220_17) then
				local var_220_20 = (arg_217_1.time_ - var_220_18) / var_220_19

				if arg_217_1.var_.characterEffect6046_story and not isNil(var_220_17) then
					local var_220_21 = Mathf.Lerp(0, 0.5, var_220_20)

					arg_217_1.var_.characterEffect6046_story.fillFlat = true
					arg_217_1.var_.characterEffect6046_story.fillRatio = var_220_21
				end
			end

			if arg_217_1.time_ >= var_220_18 + var_220_19 and arg_217_1.time_ < var_220_18 + var_220_19 + arg_220_0 and not isNil(var_220_17) and arg_217_1.var_.characterEffect6046_story then
				local var_220_22 = 0.5

				arg_217_1.var_.characterEffect6046_story.fillFlat = true
				arg_217_1.var_.characterEffect6046_story.fillRatio = var_220_22
			end

			local var_220_23 = 0
			local var_220_24 = 1.025

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_25 = arg_217_1:FormatText(StoryNameCfg[215].name)

				arg_217_1.leftNameTxt_.text = var_220_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_26 = arg_217_1:GetWordFromCfg(1104202054)
				local var_220_27 = arg_217_1:FormatText(var_220_26.content)

				arg_217_1.text_.text = var_220_27

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_28 = 41
				local var_220_29 = utf8.len(var_220_27)
				local var_220_30 = var_220_28 <= 0 and var_220_24 or var_220_24 * (var_220_29 / var_220_28)

				if var_220_30 > 0 and var_220_24 < var_220_30 then
					arg_217_1.talkMaxDuration = var_220_30

					if var_220_30 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_30 + var_220_23
					end
				end

				arg_217_1.text_.text = var_220_27
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202054", "story_v_side_new_1104202.awb") ~= 0 then
					local var_220_31 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202054", "story_v_side_new_1104202.awb") / 1000

					if var_220_31 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_31 + var_220_23
					end

					if var_220_26.prefab_name ~= "" and arg_217_1.actors_[var_220_26.prefab_name] ~= nil then
						local var_220_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_26.prefab_name].transform, "story_v_side_new_1104202", "1104202054", "story_v_side_new_1104202.awb")

						arg_217_1:RecordAudio("1104202054", var_220_32)
						arg_217_1:RecordAudio("1104202054", var_220_32)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202054", "story_v_side_new_1104202.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202054", "story_v_side_new_1104202.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_33 = math.max(var_220_24, arg_217_1.talkMaxDuration)

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_33 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_23) / var_220_33

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_23 + var_220_33 and arg_217_1.time_ < var_220_23 + var_220_33 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play1104202055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1104202055
		arg_221_1.duration_ = 8.97

		local var_221_0 = {
			ja = 5.933,
			ko = 8.966,
			zh = 8.966
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
				arg_221_0:Play1104202056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["6046_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect6046_story == nil then
				arg_221_1.var_.characterEffect6046_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect6046_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect6046_story then
				arg_221_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_224_4 = 0

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_6 = arg_221_1.actors_["6045_story"]
			local var_224_7 = 0

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect6045_story == nil then
				arg_221_1.var_.characterEffect6045_story = var_224_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_8 = 0.200000002980232

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_8 and not isNil(var_224_6) then
				local var_224_9 = (arg_221_1.time_ - var_224_7) / var_224_8

				if arg_221_1.var_.characterEffect6045_story and not isNil(var_224_6) then
					local var_224_10 = Mathf.Lerp(0, 0.5, var_224_9)

					arg_221_1.var_.characterEffect6045_story.fillFlat = true
					arg_221_1.var_.characterEffect6045_story.fillRatio = var_224_10
				end
			end

			if arg_221_1.time_ >= var_224_7 + var_224_8 and arg_221_1.time_ < var_224_7 + var_224_8 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect6045_story then
				local var_224_11 = 0.5

				arg_221_1.var_.characterEffect6045_story.fillFlat = true
				arg_221_1.var_.characterEffect6045_story.fillRatio = var_224_11
			end

			local var_224_12 = 0
			local var_224_13 = 0.75

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_14 = arg_221_1:FormatText(StoryNameCfg[214].name)

				arg_221_1.leftNameTxt_.text = var_224_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_15 = arg_221_1:GetWordFromCfg(1104202055)
				local var_224_16 = arg_221_1:FormatText(var_224_15.content)

				arg_221_1.text_.text = var_224_16

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_17 = 30
				local var_224_18 = utf8.len(var_224_16)
				local var_224_19 = var_224_17 <= 0 and var_224_13 or var_224_13 * (var_224_18 / var_224_17)

				if var_224_19 > 0 and var_224_13 < var_224_19 then
					arg_221_1.talkMaxDuration = var_224_19

					if var_224_19 + var_224_12 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_19 + var_224_12
					end
				end

				arg_221_1.text_.text = var_224_16
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202055", "story_v_side_new_1104202.awb") ~= 0 then
					local var_224_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202055", "story_v_side_new_1104202.awb") / 1000

					if var_224_20 + var_224_12 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_12
					end

					if var_224_15.prefab_name ~= "" and arg_221_1.actors_[var_224_15.prefab_name] ~= nil then
						local var_224_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_15.prefab_name].transform, "story_v_side_new_1104202", "1104202055", "story_v_side_new_1104202.awb")

						arg_221_1:RecordAudio("1104202055", var_224_21)
						arg_221_1:RecordAudio("1104202055", var_224_21)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202055", "story_v_side_new_1104202.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202055", "story_v_side_new_1104202.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = math.max(var_224_13, arg_221_1.talkMaxDuration)

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_12) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_12 + var_224_22 and arg_221_1.time_ < var_224_12 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1104202056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1104202056
		arg_225_1.duration_ = 4.47

		local var_225_0 = {
			ja = 4.466,
			ko = 3.166,
			zh = 3.166
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1104202057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["6045_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect6045_story == nil then
				arg_225_1.var_.characterEffect6045_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect6045_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect6045_story then
				arg_225_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_228_4 = 0

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_6 = arg_225_1.actors_["6046_story"]
			local var_228_7 = 0

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect6046_story == nil then
				arg_225_1.var_.characterEffect6046_story = var_228_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_8 = 0.200000002980232

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 and not isNil(var_228_6) then
				local var_228_9 = (arg_225_1.time_ - var_228_7) / var_228_8

				if arg_225_1.var_.characterEffect6046_story and not isNil(var_228_6) then
					local var_228_10 = Mathf.Lerp(0, 0.5, var_228_9)

					arg_225_1.var_.characterEffect6046_story.fillFlat = true
					arg_225_1.var_.characterEffect6046_story.fillRatio = var_228_10
				end
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect6046_story then
				local var_228_11 = 0.5

				arg_225_1.var_.characterEffect6046_story.fillFlat = true
				arg_225_1.var_.characterEffect6046_story.fillRatio = var_228_11
			end

			local var_228_12 = 0
			local var_228_13 = 0.175

			if var_228_12 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_14 = arg_225_1:FormatText(StoryNameCfg[215].name)

				arg_225_1.leftNameTxt_.text = var_228_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_15 = arg_225_1:GetWordFromCfg(1104202056)
				local var_228_16 = arg_225_1:FormatText(var_228_15.content)

				arg_225_1.text_.text = var_228_16

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_17 = 7
				local var_228_18 = utf8.len(var_228_16)
				local var_228_19 = var_228_17 <= 0 and var_228_13 or var_228_13 * (var_228_18 / var_228_17)

				if var_228_19 > 0 and var_228_13 < var_228_19 then
					arg_225_1.talkMaxDuration = var_228_19

					if var_228_19 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_19 + var_228_12
					end
				end

				arg_225_1.text_.text = var_228_16
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202056", "story_v_side_new_1104202.awb") ~= 0 then
					local var_228_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202056", "story_v_side_new_1104202.awb") / 1000

					if var_228_20 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_20 + var_228_12
					end

					if var_228_15.prefab_name ~= "" and arg_225_1.actors_[var_228_15.prefab_name] ~= nil then
						local var_228_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_15.prefab_name].transform, "story_v_side_new_1104202", "1104202056", "story_v_side_new_1104202.awb")

						arg_225_1:RecordAudio("1104202056", var_228_21)
						arg_225_1:RecordAudio("1104202056", var_228_21)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202056", "story_v_side_new_1104202.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202056", "story_v_side_new_1104202.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = math.max(var_228_13, arg_225_1.talkMaxDuration)

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_12) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_12 + var_228_22 and arg_225_1.time_ < var_228_12 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1104202057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1104202057
		arg_229_1.duration_ = 3.73

		local var_229_0 = {
			ja = 2.933,
			ko = 3.733,
			zh = 3.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1104202058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["6046_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect6046_story == nil then
				arg_229_1.var_.characterEffect6046_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect6046_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect6046_story then
				arg_229_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_6 = arg_229_1.actors_["6045_story"]
			local var_232_7 = 0

			if var_232_7 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect6045_story == nil then
				arg_229_1.var_.characterEffect6045_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_8 = 0.200000002980232

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_8 and not isNil(var_232_6) then
				local var_232_9 = (arg_229_1.time_ - var_232_7) / var_232_8

				if arg_229_1.var_.characterEffect6045_story and not isNil(var_232_6) then
					local var_232_10 = Mathf.Lerp(0, 0.5, var_232_9)

					arg_229_1.var_.characterEffect6045_story.fillFlat = true
					arg_229_1.var_.characterEffect6045_story.fillRatio = var_232_10
				end
			end

			if arg_229_1.time_ >= var_232_7 + var_232_8 and arg_229_1.time_ < var_232_7 + var_232_8 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect6045_story then
				local var_232_11 = 0.5

				arg_229_1.var_.characterEffect6045_story.fillFlat = true
				arg_229_1.var_.characterEffect6045_story.fillRatio = var_232_11
			end

			local var_232_12 = 0
			local var_232_13 = 0.275

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_14 = arg_229_1:FormatText(StoryNameCfg[214].name)

				arg_229_1.leftNameTxt_.text = var_232_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(1104202057)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 11
				local var_232_18 = utf8.len(var_232_16)
				local var_232_19 = var_232_17 <= 0 and var_232_13 or var_232_13 * (var_232_18 / var_232_17)

				if var_232_19 > 0 and var_232_13 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202057", "story_v_side_new_1104202.awb") ~= 0 then
					local var_232_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202057", "story_v_side_new_1104202.awb") / 1000

					if var_232_20 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_20 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_side_new_1104202", "1104202057", "story_v_side_new_1104202.awb")

						arg_229_1:RecordAudio("1104202057", var_232_21)
						arg_229_1:RecordAudio("1104202057", var_232_21)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202057", "story_v_side_new_1104202.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202057", "story_v_side_new_1104202.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_22 and arg_229_1.time_ < var_232_12 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1104202058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1104202058
		arg_233_1.duration_ = 14.3

		local var_233_0 = {
			ja = 13.533,
			ko = 14.3,
			zh = 14.3
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1104202059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["6045_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect6045_story == nil then
				arg_233_1.var_.characterEffect6045_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect6045_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect6045_story then
				arg_233_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_6 = arg_233_1.actors_["6046_story"]
			local var_236_7 = 0

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect6046_story == nil then
				arg_233_1.var_.characterEffect6046_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_8 = 0.200000002980232

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_8 and not isNil(var_236_6) then
				local var_236_9 = (arg_233_1.time_ - var_236_7) / var_236_8

				if arg_233_1.var_.characterEffect6046_story and not isNil(var_236_6) then
					local var_236_10 = Mathf.Lerp(0, 0.5, var_236_9)

					arg_233_1.var_.characterEffect6046_story.fillFlat = true
					arg_233_1.var_.characterEffect6046_story.fillRatio = var_236_10
				end
			end

			if arg_233_1.time_ >= var_236_7 + var_236_8 and arg_233_1.time_ < var_236_7 + var_236_8 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect6046_story then
				local var_236_11 = 0.5

				arg_233_1.var_.characterEffect6046_story.fillFlat = true
				arg_233_1.var_.characterEffect6046_story.fillRatio = var_236_11
			end

			local var_236_12 = 0
			local var_236_13 = 0.9

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_14 = arg_233_1:FormatText(StoryNameCfg[215].name)

				arg_233_1.leftNameTxt_.text = var_236_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_15 = arg_233_1:GetWordFromCfg(1104202058)
				local var_236_16 = arg_233_1:FormatText(var_236_15.content)

				arg_233_1.text_.text = var_236_16

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_17 = 36
				local var_236_18 = utf8.len(var_236_16)
				local var_236_19 = var_236_17 <= 0 and var_236_13 or var_236_13 * (var_236_18 / var_236_17)

				if var_236_19 > 0 and var_236_13 < var_236_19 then
					arg_233_1.talkMaxDuration = var_236_19

					if var_236_19 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_19 + var_236_12
					end
				end

				arg_233_1.text_.text = var_236_16
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202058", "story_v_side_new_1104202.awb") ~= 0 then
					local var_236_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202058", "story_v_side_new_1104202.awb") / 1000

					if var_236_20 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_20 + var_236_12
					end

					if var_236_15.prefab_name ~= "" and arg_233_1.actors_[var_236_15.prefab_name] ~= nil then
						local var_236_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_15.prefab_name].transform, "story_v_side_new_1104202", "1104202058", "story_v_side_new_1104202.awb")

						arg_233_1:RecordAudio("1104202058", var_236_21)
						arg_233_1:RecordAudio("1104202058", var_236_21)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202058", "story_v_side_new_1104202.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202058", "story_v_side_new_1104202.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_22 = math.max(var_236_13, arg_233_1.talkMaxDuration)

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_22 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_12) / var_236_22

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_12 + var_236_22 and arg_233_1.time_ < var_236_12 + var_236_22 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1104202059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1104202059
		arg_237_1.duration_ = 9.83

		local var_237_0 = {
			ja = 7.933,
			ko = 9.833,
			zh = 9.833
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1104202060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.7

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[215].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(1104202059)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 28
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202059", "story_v_side_new_1104202.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202059", "story_v_side_new_1104202.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_side_new_1104202", "1104202059", "story_v_side_new_1104202.awb")

						arg_237_1:RecordAudio("1104202059", var_240_9)
						arg_237_1:RecordAudio("1104202059", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202059", "story_v_side_new_1104202.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202059", "story_v_side_new_1104202.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1104202060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1104202060
		arg_241_1.duration_ = 3.83

		local var_241_0 = {
			ja = 2.566,
			ko = 3.833,
			zh = 3.833
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1104202061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["6046_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect6046_story == nil then
				arg_241_1.var_.characterEffect6046_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect6046_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect6046_story then
				arg_241_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_244_4 = 0

			if var_244_4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_6 = arg_241_1.actors_["6045_story"]
			local var_244_7 = 0

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect6045_story == nil then
				arg_241_1.var_.characterEffect6045_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.200000002980232

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_8 and not isNil(var_244_6) then
				local var_244_9 = (arg_241_1.time_ - var_244_7) / var_244_8

				if arg_241_1.var_.characterEffect6045_story and not isNil(var_244_6) then
					local var_244_10 = Mathf.Lerp(0, 0.5, var_244_9)

					arg_241_1.var_.characterEffect6045_story.fillFlat = true
					arg_241_1.var_.characterEffect6045_story.fillRatio = var_244_10
				end
			end

			if arg_241_1.time_ >= var_244_7 + var_244_8 and arg_241_1.time_ < var_244_7 + var_244_8 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect6045_story then
				local var_244_11 = 0.5

				arg_241_1.var_.characterEffect6045_story.fillFlat = true
				arg_241_1.var_.characterEffect6045_story.fillRatio = var_244_11
			end

			local var_244_12 = 0
			local var_244_13 = 0.3

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_14 = arg_241_1:FormatText(StoryNameCfg[214].name)

				arg_241_1.leftNameTxt_.text = var_244_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_15 = arg_241_1:GetWordFromCfg(1104202060)
				local var_244_16 = arg_241_1:FormatText(var_244_15.content)

				arg_241_1.text_.text = var_244_16

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_17 = 12
				local var_244_18 = utf8.len(var_244_16)
				local var_244_19 = var_244_17 <= 0 and var_244_13 or var_244_13 * (var_244_18 / var_244_17)

				if var_244_19 > 0 and var_244_13 < var_244_19 then
					arg_241_1.talkMaxDuration = var_244_19

					if var_244_19 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_12
					end
				end

				arg_241_1.text_.text = var_244_16
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202060", "story_v_side_new_1104202.awb") ~= 0 then
					local var_244_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202060", "story_v_side_new_1104202.awb") / 1000

					if var_244_20 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_20 + var_244_12
					end

					if var_244_15.prefab_name ~= "" and arg_241_1.actors_[var_244_15.prefab_name] ~= nil then
						local var_244_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_15.prefab_name].transform, "story_v_side_new_1104202", "1104202060", "story_v_side_new_1104202.awb")

						arg_241_1:RecordAudio("1104202060", var_244_21)
						arg_241_1:RecordAudio("1104202060", var_244_21)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202060", "story_v_side_new_1104202.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202060", "story_v_side_new_1104202.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_22 = math.max(var_244_13, arg_241_1.talkMaxDuration)

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_22 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_12) / var_244_22

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_12 + var_244_22 and arg_241_1.time_ < var_244_12 + var_244_22 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1104202061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1104202061
		arg_245_1.duration_ = 10.53

		local var_245_0 = {
			ja = 7.933,
			ko = 10.533,
			zh = 10.533
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1104202062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["6045_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect6045_story == nil then
				arg_245_1.var_.characterEffect6045_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect6045_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect6045_story then
				arg_245_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_248_4 = 0

			if var_248_4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_248_6 = arg_245_1.actors_["6046_story"]
			local var_248_7 = 0

			if var_248_7 < arg_245_1.time_ and arg_245_1.time_ <= var_248_7 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect6046_story == nil then
				arg_245_1.var_.characterEffect6046_story = var_248_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_8 = 0.200000002980232

			if var_248_7 <= arg_245_1.time_ and arg_245_1.time_ < var_248_7 + var_248_8 and not isNil(var_248_6) then
				local var_248_9 = (arg_245_1.time_ - var_248_7) / var_248_8

				if arg_245_1.var_.characterEffect6046_story and not isNil(var_248_6) then
					local var_248_10 = Mathf.Lerp(0, 0.5, var_248_9)

					arg_245_1.var_.characterEffect6046_story.fillFlat = true
					arg_245_1.var_.characterEffect6046_story.fillRatio = var_248_10
				end
			end

			if arg_245_1.time_ >= var_248_7 + var_248_8 and arg_245_1.time_ < var_248_7 + var_248_8 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect6046_story then
				local var_248_11 = 0.5

				arg_245_1.var_.characterEffect6046_story.fillFlat = true
				arg_245_1.var_.characterEffect6046_story.fillRatio = var_248_11
			end

			local var_248_12 = 0
			local var_248_13 = 0.725

			if var_248_12 < arg_245_1.time_ and arg_245_1.time_ <= var_248_12 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_14 = arg_245_1:FormatText(StoryNameCfg[215].name)

				arg_245_1.leftNameTxt_.text = var_248_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_15 = arg_245_1:GetWordFromCfg(1104202061)
				local var_248_16 = arg_245_1:FormatText(var_248_15.content)

				arg_245_1.text_.text = var_248_16

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_17 = 29
				local var_248_18 = utf8.len(var_248_16)
				local var_248_19 = var_248_17 <= 0 and var_248_13 or var_248_13 * (var_248_18 / var_248_17)

				if var_248_19 > 0 and var_248_13 < var_248_19 then
					arg_245_1.talkMaxDuration = var_248_19

					if var_248_19 + var_248_12 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_19 + var_248_12
					end
				end

				arg_245_1.text_.text = var_248_16
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202061", "story_v_side_new_1104202.awb") ~= 0 then
					local var_248_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202061", "story_v_side_new_1104202.awb") / 1000

					if var_248_20 + var_248_12 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_20 + var_248_12
					end

					if var_248_15.prefab_name ~= "" and arg_245_1.actors_[var_248_15.prefab_name] ~= nil then
						local var_248_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_15.prefab_name].transform, "story_v_side_new_1104202", "1104202061", "story_v_side_new_1104202.awb")

						arg_245_1:RecordAudio("1104202061", var_248_21)
						arg_245_1:RecordAudio("1104202061", var_248_21)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202061", "story_v_side_new_1104202.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202061", "story_v_side_new_1104202.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_22 = math.max(var_248_13, arg_245_1.talkMaxDuration)

			if var_248_12 <= arg_245_1.time_ and arg_245_1.time_ < var_248_12 + var_248_22 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_12) / var_248_22

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_12 + var_248_22 and arg_245_1.time_ < var_248_12 + var_248_22 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1104202062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1104202062
		arg_249_1.duration_ = 6.27

		local var_249_0 = {
			ja = 5.9,
			ko = 6.266,
			zh = 6.266
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1104202063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["6046_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect6046_story == nil then
				arg_249_1.var_.characterEffect6046_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect6046_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect6046_story then
				arg_249_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_6 = arg_249_1.actors_["6045_story"]
			local var_252_7 = 0

			if var_252_7 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect6045_story == nil then
				arg_249_1.var_.characterEffect6045_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_8 = 0.200000002980232

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 and not isNil(var_252_6) then
				local var_252_9 = (arg_249_1.time_ - var_252_7) / var_252_8

				if arg_249_1.var_.characterEffect6045_story and not isNil(var_252_6) then
					local var_252_10 = Mathf.Lerp(0, 0.5, var_252_9)

					arg_249_1.var_.characterEffect6045_story.fillFlat = true
					arg_249_1.var_.characterEffect6045_story.fillRatio = var_252_10
				end
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect6045_story then
				local var_252_11 = 0.5

				arg_249_1.var_.characterEffect6045_story.fillFlat = true
				arg_249_1.var_.characterEffect6045_story.fillRatio = var_252_11
			end

			local var_252_12 = 0
			local var_252_13 = 0.525

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[214].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(1104202062)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 21
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202062", "story_v_side_new_1104202.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202062", "story_v_side_new_1104202.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_side_new_1104202", "1104202062", "story_v_side_new_1104202.awb")

						arg_249_1:RecordAudio("1104202062", var_252_21)
						arg_249_1:RecordAudio("1104202062", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202062", "story_v_side_new_1104202.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202062", "story_v_side_new_1104202.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1104202063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1104202063
		arg_253_1.duration_ = 6.47

		local var_253_0 = {
			ja = 5.9,
			ko = 6.466,
			zh = 6.466
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1104202064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["6045_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect6045_story == nil then
				arg_253_1.var_.characterEffect6045_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect6045_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect6045_story then
				arg_253_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_256_4 = 0

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_6 = arg_253_1.actors_["6046_story"]
			local var_256_7 = 0

			if var_256_7 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect6046_story == nil then
				arg_253_1.var_.characterEffect6046_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_8 = 0.200000002980232

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 and not isNil(var_256_6) then
				local var_256_9 = (arg_253_1.time_ - var_256_7) / var_256_8

				if arg_253_1.var_.characterEffect6046_story and not isNil(var_256_6) then
					local var_256_10 = Mathf.Lerp(0, 0.5, var_256_9)

					arg_253_1.var_.characterEffect6046_story.fillFlat = true
					arg_253_1.var_.characterEffect6046_story.fillRatio = var_256_10
				end
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect6046_story then
				local var_256_11 = 0.5

				arg_253_1.var_.characterEffect6046_story.fillFlat = true
				arg_253_1.var_.characterEffect6046_story.fillRatio = var_256_11
			end

			local var_256_12 = 0
			local var_256_13 = 0.45

			if var_256_12 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_14 = arg_253_1:FormatText(StoryNameCfg[215].name)

				arg_253_1.leftNameTxt_.text = var_256_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_15 = arg_253_1:GetWordFromCfg(1104202063)
				local var_256_16 = arg_253_1:FormatText(var_256_15.content)

				arg_253_1.text_.text = var_256_16

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_17 = 18
				local var_256_18 = utf8.len(var_256_16)
				local var_256_19 = var_256_17 <= 0 and var_256_13 or var_256_13 * (var_256_18 / var_256_17)

				if var_256_19 > 0 and var_256_13 < var_256_19 then
					arg_253_1.talkMaxDuration = var_256_19

					if var_256_19 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_19 + var_256_12
					end
				end

				arg_253_1.text_.text = var_256_16
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202063", "story_v_side_new_1104202.awb") ~= 0 then
					local var_256_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202063", "story_v_side_new_1104202.awb") / 1000

					if var_256_20 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_20 + var_256_12
					end

					if var_256_15.prefab_name ~= "" and arg_253_1.actors_[var_256_15.prefab_name] ~= nil then
						local var_256_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_15.prefab_name].transform, "story_v_side_new_1104202", "1104202063", "story_v_side_new_1104202.awb")

						arg_253_1:RecordAudio("1104202063", var_256_21)
						arg_253_1:RecordAudio("1104202063", var_256_21)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202063", "story_v_side_new_1104202.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202063", "story_v_side_new_1104202.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_22 = math.max(var_256_13, arg_253_1.talkMaxDuration)

			if var_256_12 <= arg_253_1.time_ and arg_253_1.time_ < var_256_12 + var_256_22 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_12) / var_256_22

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_12 + var_256_22 and arg_253_1.time_ < var_256_12 + var_256_22 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1104202064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1104202064
		arg_257_1.duration_ = 4.8

		local var_257_0 = {
			ja = 4.8,
			ko = 4.2,
			zh = 4.2
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
				arg_257_0:Play1104202065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["6046_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect6046_story == nil then
				arg_257_1.var_.characterEffect6046_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect6046_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect6046_story then
				arg_257_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action445")
			end

			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_6 = arg_257_1.actors_["6045_story"]
			local var_260_7 = 0

			if var_260_7 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect6045_story == nil then
				arg_257_1.var_.characterEffect6045_story = var_260_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_8 = 0.200000002980232

			if var_260_7 <= arg_257_1.time_ and arg_257_1.time_ < var_260_7 + var_260_8 and not isNil(var_260_6) then
				local var_260_9 = (arg_257_1.time_ - var_260_7) / var_260_8

				if arg_257_1.var_.characterEffect6045_story and not isNil(var_260_6) then
					local var_260_10 = Mathf.Lerp(0, 0.5, var_260_9)

					arg_257_1.var_.characterEffect6045_story.fillFlat = true
					arg_257_1.var_.characterEffect6045_story.fillRatio = var_260_10
				end
			end

			if arg_257_1.time_ >= var_260_7 + var_260_8 and arg_257_1.time_ < var_260_7 + var_260_8 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect6045_story then
				local var_260_11 = 0.5

				arg_257_1.var_.characterEffect6045_story.fillFlat = true
				arg_257_1.var_.characterEffect6045_story.fillRatio = var_260_11
			end

			local var_260_12 = 0
			local var_260_13 = 0.325

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_14 = arg_257_1:FormatText(StoryNameCfg[214].name)

				arg_257_1.leftNameTxt_.text = var_260_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:GetWordFromCfg(1104202064)
				local var_260_16 = arg_257_1:FormatText(var_260_15.content)

				arg_257_1.text_.text = var_260_16

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 13
				local var_260_18 = utf8.len(var_260_16)
				local var_260_19 = var_260_17 <= 0 and var_260_13 or var_260_13 * (var_260_18 / var_260_17)

				if var_260_19 > 0 and var_260_13 < var_260_19 then
					arg_257_1.talkMaxDuration = var_260_19

					if var_260_19 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_12
					end
				end

				arg_257_1.text_.text = var_260_16
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202064", "story_v_side_new_1104202.awb") ~= 0 then
					local var_260_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202064", "story_v_side_new_1104202.awb") / 1000

					if var_260_20 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_12
					end

					if var_260_15.prefab_name ~= "" and arg_257_1.actors_[var_260_15.prefab_name] ~= nil then
						local var_260_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_15.prefab_name].transform, "story_v_side_new_1104202", "1104202064", "story_v_side_new_1104202.awb")

						arg_257_1:RecordAudio("1104202064", var_260_21)
						arg_257_1:RecordAudio("1104202064", var_260_21)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202064", "story_v_side_new_1104202.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202064", "story_v_side_new_1104202.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = math.max(var_260_13, arg_257_1.talkMaxDuration)

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_12) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_12 + var_260_22 and arg_257_1.time_ < var_260_12 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1104202065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1104202065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1104202066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["6046_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos6046_story = var_264_0.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos6046_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9

				local var_264_10 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_10 then
					var_264_10:EnableDynamicBone(true)
				end
			end

			local var_264_11 = arg_261_1.actors_["6046_story"]
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect6046_story == nil then
				arg_261_1.var_.characterEffect6046_story = var_264_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_13 = 0.200000002980232

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_13 and not isNil(var_264_11) then
				local var_264_14 = (arg_261_1.time_ - var_264_12) / var_264_13

				if arg_261_1.var_.characterEffect6046_story and not isNil(var_264_11) then
					local var_264_15 = Mathf.Lerp(0, 0.5, var_264_14)

					arg_261_1.var_.characterEffect6046_story.fillFlat = true
					arg_261_1.var_.characterEffect6046_story.fillRatio = var_264_15
				end
			end

			if arg_261_1.time_ >= var_264_12 + var_264_13 and arg_261_1.time_ < var_264_12 + var_264_13 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect6046_story then
				local var_264_16 = 0.5

				arg_261_1.var_.characterEffect6046_story.fillFlat = true
				arg_261_1.var_.characterEffect6046_story.fillRatio = var_264_16
			end

			local var_264_17 = arg_261_1.actors_["6045_story"].transform
			local var_264_18 = 0

			if var_264_18 < arg_261_1.time_ and arg_261_1.time_ <= var_264_18 + arg_264_0 then
				arg_261_1.var_.moveOldPos6045_story = var_264_17.localPosition

				local var_264_19 = GameObjectTools.GetOrAddComponent(var_264_17.gameObject, typeof(DynamicBoneHelper))

				if var_264_19 then
					var_264_19:EnableDynamicBone(false)
				end
			end

			local var_264_20 = 0.001

			if var_264_18 <= arg_261_1.time_ and arg_261_1.time_ < var_264_18 + var_264_20 then
				local var_264_21 = (arg_261_1.time_ - var_264_18) / var_264_20
				local var_264_22 = Vector3.New(0, 100, 0)

				var_264_17.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos6045_story, var_264_22, var_264_21)

				local var_264_23 = manager.ui.mainCamera.transform.position - var_264_17.position

				var_264_17.forward = Vector3.New(var_264_23.x, var_264_23.y, var_264_23.z)

				local var_264_24 = var_264_17.localEulerAngles

				var_264_24.z = 0
				var_264_24.x = 0
				var_264_17.localEulerAngles = var_264_24
			end

			if arg_261_1.time_ >= var_264_18 + var_264_20 and arg_261_1.time_ < var_264_18 + var_264_20 + arg_264_0 then
				var_264_17.localPosition = Vector3.New(0, 100, 0)

				local var_264_25 = manager.ui.mainCamera.transform.position - var_264_17.position

				var_264_17.forward = Vector3.New(var_264_25.x, var_264_25.y, var_264_25.z)

				local var_264_26 = var_264_17.localEulerAngles

				var_264_26.z = 0
				var_264_26.x = 0
				var_264_17.localEulerAngles = var_264_26

				local var_264_27 = GameObjectTools.GetOrAddComponent(var_264_17.gameObject, typeof(DynamicBoneHelper))

				if var_264_27 then
					var_264_27:EnableDynamicBone(true)
				end
			end

			local var_264_28 = arg_261_1.actors_["6045_story"]
			local var_264_29 = 0

			if var_264_29 < arg_261_1.time_ and arg_261_1.time_ <= var_264_29 + arg_264_0 and not isNil(var_264_28) and arg_261_1.var_.characterEffect6045_story == nil then
				arg_261_1.var_.characterEffect6045_story = var_264_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_30 = 0.200000002980232

			if var_264_29 <= arg_261_1.time_ and arg_261_1.time_ < var_264_29 + var_264_30 and not isNil(var_264_28) then
				local var_264_31 = (arg_261_1.time_ - var_264_29) / var_264_30

				if arg_261_1.var_.characterEffect6045_story and not isNil(var_264_28) then
					local var_264_32 = Mathf.Lerp(0, 0.5, var_264_31)

					arg_261_1.var_.characterEffect6045_story.fillFlat = true
					arg_261_1.var_.characterEffect6045_story.fillRatio = var_264_32
				end
			end

			if arg_261_1.time_ >= var_264_29 + var_264_30 and arg_261_1.time_ < var_264_29 + var_264_30 + arg_264_0 and not isNil(var_264_28) and arg_261_1.var_.characterEffect6045_story then
				local var_264_33 = 0.5

				arg_261_1.var_.characterEffect6045_story.fillFlat = true
				arg_261_1.var_.characterEffect6045_story.fillRatio = var_264_33
			end

			local var_264_34 = 0
			local var_264_35 = 0.6

			if var_264_34 < arg_261_1.time_ and arg_261_1.time_ <= var_264_34 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_36 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_37 = arg_261_1:GetWordFromCfg(1104202065)
				local var_264_38 = arg_261_1:FormatText(var_264_37.content)

				arg_261_1.text_.text = var_264_38

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_39 = 24
				local var_264_40 = utf8.len(var_264_38)
				local var_264_41 = var_264_39 <= 0 and var_264_35 or var_264_35 * (var_264_40 / var_264_39)

				if var_264_41 > 0 and var_264_35 < var_264_41 then
					arg_261_1.talkMaxDuration = var_264_41

					if var_264_41 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_41 + var_264_34
					end
				end

				arg_261_1.text_.text = var_264_38
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_42 = math.max(var_264_35, arg_261_1.talkMaxDuration)

			if var_264_34 <= arg_261_1.time_ and arg_261_1.time_ < var_264_34 + var_264_42 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_34) / var_264_42

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_34 + var_264_42 and arg_261_1.time_ < var_264_34 + var_264_42 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1104202066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1104202066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1104202067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.55

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(1104202066)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 22
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
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1104202067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1104202067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1104202068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.45

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(1104202067)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 18
				local var_272_5 = utf8.len(var_272_3)
				local var_272_6 = var_272_4 <= 0 and var_272_1 or var_272_1 * (var_272_5 / var_272_4)

				if var_272_6 > 0 and var_272_1 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_7 and arg_269_1.time_ < var_272_0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1104202068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1104202068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1104202069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.175

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_2 = arg_273_1:GetWordFromCfg(1104202068)
				local var_276_3 = arg_273_1:FormatText(var_276_2.content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 7
				local var_276_5 = utf8.len(var_276_3)
				local var_276_6 = var_276_4 <= 0 and var_276_1 or var_276_1 * (var_276_5 / var_276_4)

				if var_276_6 > 0 and var_276_1 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_7 and arg_273_1.time_ < var_276_0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1104202069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104202069
		arg_277_1.duration_ = 5.87

		local var_277_0 = {
			ja = 5.866,
			ko = 5.066,
			zh = 5.066
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
				arg_277_0:Play1104202070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.4

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[444].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1104202069)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 16
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202069", "story_v_side_new_1104202.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202069", "story_v_side_new_1104202.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_side_new_1104202", "1104202069", "story_v_side_new_1104202.awb")

						arg_277_1:RecordAudio("1104202069", var_280_9)
						arg_277_1:RecordAudio("1104202069", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202069", "story_v_side_new_1104202.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202069", "story_v_side_new_1104202.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1104202070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104202070
		arg_281_1.duration_ = 11

		local var_281_0 = {
			ja = 11,
			ko = 8.566,
			zh = 8.566
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
				arg_281_0:Play1104202071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["6046_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos6046_story = var_284_0.localPosition

				local var_284_2 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(false)
				end
			end

			local var_284_3 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_3 then
				local var_284_4 = (arg_281_1.time_ - var_284_1) / var_284_3
				local var_284_5 = Vector3.New(0, -0.5, -6.3)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos6046_story, var_284_5, var_284_4)

				local var_284_6 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_6.x, var_284_6.y, var_284_6.z)

				local var_284_7 = var_284_0.localEulerAngles

				var_284_7.z = 0
				var_284_7.x = 0
				var_284_0.localEulerAngles = var_284_7
			end

			if arg_281_1.time_ >= var_284_1 + var_284_3 and arg_281_1.time_ < var_284_1 + var_284_3 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_284_8 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_8.x, var_284_8.y, var_284_8.z)

				local var_284_9 = var_284_0.localEulerAngles

				var_284_9.z = 0
				var_284_9.x = 0
				var_284_0.localEulerAngles = var_284_9

				local var_284_10 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_10 then
					var_284_10:EnableDynamicBone(true)
				end
			end

			local var_284_11 = arg_281_1.actors_["6046_story"]
			local var_284_12 = 0

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 and not isNil(var_284_11) and arg_281_1.var_.characterEffect6046_story == nil then
				arg_281_1.var_.characterEffect6046_story = var_284_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_13 = 0.200000002980232

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_13 and not isNil(var_284_11) then
				local var_284_14 = (arg_281_1.time_ - var_284_12) / var_284_13

				if arg_281_1.var_.characterEffect6046_story and not isNil(var_284_11) then
					arg_281_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_12 + var_284_13 and arg_281_1.time_ < var_284_12 + var_284_13 + arg_284_0 and not isNil(var_284_11) and arg_281_1.var_.characterEffect6046_story then
				arg_281_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_284_15 = 0

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_17 = 0
			local var_284_18 = 0.8

			if var_284_17 < arg_281_1.time_ and arg_281_1.time_ <= var_284_17 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_19 = arg_281_1:FormatText(StoryNameCfg[214].name)

				arg_281_1.leftNameTxt_.text = var_284_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_20 = arg_281_1:GetWordFromCfg(1104202070)
				local var_284_21 = arg_281_1:FormatText(var_284_20.content)

				arg_281_1.text_.text = var_284_21

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_22 = 32
				local var_284_23 = utf8.len(var_284_21)
				local var_284_24 = var_284_22 <= 0 and var_284_18 or var_284_18 * (var_284_23 / var_284_22)

				if var_284_24 > 0 and var_284_18 < var_284_24 then
					arg_281_1.talkMaxDuration = var_284_24

					if var_284_24 + var_284_17 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_17
					end
				end

				arg_281_1.text_.text = var_284_21
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202070", "story_v_side_new_1104202.awb") ~= 0 then
					local var_284_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202070", "story_v_side_new_1104202.awb") / 1000

					if var_284_25 + var_284_17 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_25 + var_284_17
					end

					if var_284_20.prefab_name ~= "" and arg_281_1.actors_[var_284_20.prefab_name] ~= nil then
						local var_284_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_20.prefab_name].transform, "story_v_side_new_1104202", "1104202070", "story_v_side_new_1104202.awb")

						arg_281_1:RecordAudio("1104202070", var_284_26)
						arg_281_1:RecordAudio("1104202070", var_284_26)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202070", "story_v_side_new_1104202.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202070", "story_v_side_new_1104202.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_27 = math.max(var_284_18, arg_281_1.talkMaxDuration)

			if var_284_17 <= arg_281_1.time_ and arg_281_1.time_ < var_284_17 + var_284_27 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_17) / var_284_27

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_17 + var_284_27 and arg_281_1.time_ < var_284_17 + var_284_27 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1104202071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1104202071
		arg_285_1.duration_ = 5.07

		local var_285_0 = {
			ja = 4.366,
			ko = 5.066,
			zh = 5.066
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
				arg_285_0:Play1104202072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["6046_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect6046_story == nil then
				arg_285_1.var_.characterEffect6046_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect6046_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect6046_story.fillFlat = true
					arg_285_1.var_.characterEffect6046_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect6046_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect6046_story.fillFlat = true
				arg_285_1.var_.characterEffect6046_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.45

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[444].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_9 = arg_285_1:GetWordFromCfg(1104202071)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 18
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202071", "story_v_side_new_1104202.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202071", "story_v_side_new_1104202.awb") / 1000

					if var_288_14 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_6
					end

					if var_288_9.prefab_name ~= "" and arg_285_1.actors_[var_288_9.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_9.prefab_name].transform, "story_v_side_new_1104202", "1104202071", "story_v_side_new_1104202.awb")

						arg_285_1:RecordAudio("1104202071", var_288_15)
						arg_285_1:RecordAudio("1104202071", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202071", "story_v_side_new_1104202.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202071", "story_v_side_new_1104202.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_16 and arg_285_1.time_ < var_288_6 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1104202072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1104202072
		arg_289_1.duration_ = 9.6

		local var_289_0 = {
			ja = 9.6,
			ko = 6.766,
			zh = 6.766
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
				arg_289_0:Play1104202073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.825

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[444].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(1104202072)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 33
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202072", "story_v_side_new_1104202.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202072", "story_v_side_new_1104202.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_side_new_1104202", "1104202072", "story_v_side_new_1104202.awb")

						arg_289_1:RecordAudio("1104202072", var_292_9)
						arg_289_1:RecordAudio("1104202072", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202072", "story_v_side_new_1104202.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202072", "story_v_side_new_1104202.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1104202073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104202073
		arg_293_1.duration_ = 6.23

		local var_293_0 = {
			ja = 6.2,
			ko = 6.233,
			zh = 6.233
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
				arg_293_0:Play1104202074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["6046_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos6046_story = var_296_0.localPosition

				local var_296_2 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_2 then
					var_296_2:EnableDynamicBone(false)
				end
			end

			local var_296_3 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_3 then
				local var_296_4 = (arg_293_1.time_ - var_296_1) / var_296_3
				local var_296_5 = Vector3.New(0.7, -0.5, -6.3)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos6046_story, var_296_5, var_296_4)

				local var_296_6 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_6.x, var_296_6.y, var_296_6.z)

				local var_296_7 = var_296_0.localEulerAngles

				var_296_7.z = 0
				var_296_7.x = 0
				var_296_0.localEulerAngles = var_296_7
			end

			if arg_293_1.time_ >= var_296_1 + var_296_3 and arg_293_1.time_ < var_296_1 + var_296_3 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_296_8 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_8.x, var_296_8.y, var_296_8.z)

				local var_296_9 = var_296_0.localEulerAngles

				var_296_9.z = 0
				var_296_9.x = 0
				var_296_0.localEulerAngles = var_296_9

				local var_296_10 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_10 then
					var_296_10:EnableDynamicBone(true)
				end
			end

			local var_296_11 = arg_293_1.actors_["6046_story"]
			local var_296_12 = 0

			if var_296_12 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 and not isNil(var_296_11) and arg_293_1.var_.characterEffect6046_story == nil then
				arg_293_1.var_.characterEffect6046_story = var_296_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_13 = 0.200000002980232

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_13 and not isNil(var_296_11) then
				local var_296_14 = (arg_293_1.time_ - var_296_12) / var_296_13

				if arg_293_1.var_.characterEffect6046_story and not isNil(var_296_11) then
					local var_296_15 = Mathf.Lerp(0, 0.5, var_296_14)

					arg_293_1.var_.characterEffect6046_story.fillFlat = true
					arg_293_1.var_.characterEffect6046_story.fillRatio = var_296_15
				end
			end

			if arg_293_1.time_ >= var_296_12 + var_296_13 and arg_293_1.time_ < var_296_12 + var_296_13 + arg_296_0 and not isNil(var_296_11) and arg_293_1.var_.characterEffect6046_story then
				local var_296_16 = 0.5

				arg_293_1.var_.characterEffect6046_story.fillFlat = true
				arg_293_1.var_.characterEffect6046_story.fillRatio = var_296_16
			end

			local var_296_17 = arg_293_1.actors_["6045_story"].transform
			local var_296_18 = 0

			if var_296_18 < arg_293_1.time_ and arg_293_1.time_ <= var_296_18 + arg_296_0 then
				arg_293_1.var_.moveOldPos6045_story = var_296_17.localPosition

				local var_296_19 = GameObjectTools.GetOrAddComponent(var_296_17.gameObject, typeof(DynamicBoneHelper))

				if var_296_19 then
					var_296_19:EnableDynamicBone(false)
				end
			end

			local var_296_20 = 0.001

			if var_296_18 <= arg_293_1.time_ and arg_293_1.time_ < var_296_18 + var_296_20 then
				local var_296_21 = (arg_293_1.time_ - var_296_18) / var_296_20
				local var_296_22 = Vector3.New(-0.7, -0.5, -6.3)

				var_296_17.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos6045_story, var_296_22, var_296_21)

				local var_296_23 = manager.ui.mainCamera.transform.position - var_296_17.position

				var_296_17.forward = Vector3.New(var_296_23.x, var_296_23.y, var_296_23.z)

				local var_296_24 = var_296_17.localEulerAngles

				var_296_24.z = 0
				var_296_24.x = 0
				var_296_17.localEulerAngles = var_296_24
			end

			if arg_293_1.time_ >= var_296_18 + var_296_20 and arg_293_1.time_ < var_296_18 + var_296_20 + arg_296_0 then
				var_296_17.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_296_25 = manager.ui.mainCamera.transform.position - var_296_17.position

				var_296_17.forward = Vector3.New(var_296_25.x, var_296_25.y, var_296_25.z)

				local var_296_26 = var_296_17.localEulerAngles

				var_296_26.z = 0
				var_296_26.x = 0
				var_296_17.localEulerAngles = var_296_26

				local var_296_27 = GameObjectTools.GetOrAddComponent(var_296_17.gameObject, typeof(DynamicBoneHelper))

				if var_296_27 then
					var_296_27:EnableDynamicBone(true)
				end
			end

			local var_296_28 = arg_293_1.actors_["6045_story"]
			local var_296_29 = 0

			if var_296_29 < arg_293_1.time_ and arg_293_1.time_ <= var_296_29 + arg_296_0 and not isNil(var_296_28) and arg_293_1.var_.characterEffect6045_story == nil then
				arg_293_1.var_.characterEffect6045_story = var_296_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_30 = 0.200000002980232

			if var_296_29 <= arg_293_1.time_ and arg_293_1.time_ < var_296_29 + var_296_30 and not isNil(var_296_28) then
				local var_296_31 = (arg_293_1.time_ - var_296_29) / var_296_30

				if arg_293_1.var_.characterEffect6045_story and not isNil(var_296_28) then
					arg_293_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_29 + var_296_30 and arg_293_1.time_ < var_296_29 + var_296_30 + arg_296_0 and not isNil(var_296_28) and arg_293_1.var_.characterEffect6045_story then
				arg_293_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_296_32 = 0

			if var_296_32 < arg_293_1.time_ and arg_293_1.time_ <= var_296_32 + arg_296_0 then
				arg_293_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_296_33 = 0

			if var_296_33 < arg_293_1.time_ and arg_293_1.time_ <= var_296_33 + arg_296_0 then
				arg_293_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_34 = 0
			local var_296_35 = 0.35

			if var_296_34 < arg_293_1.time_ and arg_293_1.time_ <= var_296_34 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_36 = arg_293_1:FormatText(StoryNameCfg[215].name)

				arg_293_1.leftNameTxt_.text = var_296_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_37 = arg_293_1:GetWordFromCfg(1104202073)
				local var_296_38 = arg_293_1:FormatText(var_296_37.content)

				arg_293_1.text_.text = var_296_38

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_39 = 14
				local var_296_40 = utf8.len(var_296_38)
				local var_296_41 = var_296_39 <= 0 and var_296_35 or var_296_35 * (var_296_40 / var_296_39)

				if var_296_41 > 0 and var_296_35 < var_296_41 then
					arg_293_1.talkMaxDuration = var_296_41

					if var_296_41 + var_296_34 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_41 + var_296_34
					end
				end

				arg_293_1.text_.text = var_296_38
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202073", "story_v_side_new_1104202.awb") ~= 0 then
					local var_296_42 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202073", "story_v_side_new_1104202.awb") / 1000

					if var_296_42 + var_296_34 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_42 + var_296_34
					end

					if var_296_37.prefab_name ~= "" and arg_293_1.actors_[var_296_37.prefab_name] ~= nil then
						local var_296_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_37.prefab_name].transform, "story_v_side_new_1104202", "1104202073", "story_v_side_new_1104202.awb")

						arg_293_1:RecordAudio("1104202073", var_296_43)
						arg_293_1:RecordAudio("1104202073", var_296_43)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202073", "story_v_side_new_1104202.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202073", "story_v_side_new_1104202.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_44 = math.max(var_296_35, arg_293_1.talkMaxDuration)

			if var_296_34 <= arg_293_1.time_ and arg_293_1.time_ < var_296_34 + var_296_44 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_34) / var_296_44

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_34 + var_296_44 and arg_293_1.time_ < var_296_34 + var_296_44 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104202074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104202074
		arg_297_1.duration_ = 6.17

		local var_297_0 = {
			ja = 5.6,
			ko = 6.166,
			zh = 6.166
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104202075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["6045_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect6045_story == nil then
				arg_297_1.var_.characterEffect6045_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect6045_story and not isNil(var_300_0) then
					local var_300_4 = Mathf.Lerp(0, 0.5, var_300_3)

					arg_297_1.var_.characterEffect6045_story.fillFlat = true
					arg_297_1.var_.characterEffect6045_story.fillRatio = var_300_4
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect6045_story then
				local var_300_5 = 0.5

				arg_297_1.var_.characterEffect6045_story.fillFlat = true
				arg_297_1.var_.characterEffect6045_story.fillRatio = var_300_5
			end

			local var_300_6 = 0
			local var_300_7 = 0.625

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[444].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_9 = arg_297_1:GetWordFromCfg(1104202074)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 25
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202074", "story_v_side_new_1104202.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202074", "story_v_side_new_1104202.awb") / 1000

					if var_300_14 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_6
					end

					if var_300_9.prefab_name ~= "" and arg_297_1.actors_[var_300_9.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_9.prefab_name].transform, "story_v_side_new_1104202", "1104202074", "story_v_side_new_1104202.awb")

						arg_297_1:RecordAudio("1104202074", var_300_15)
						arg_297_1:RecordAudio("1104202074", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202074", "story_v_side_new_1104202.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202074", "story_v_side_new_1104202.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_16 and arg_297_1.time_ < var_300_6 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1104202075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104202075
		arg_301_1.duration_ = 6.23

		local var_301_0 = {
			ja = 4.566,
			ko = 6.233,
			zh = 6.233
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
				arg_301_0:Play1104202076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["6045_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect6045_story == nil then
				arg_301_1.var_.characterEffect6045_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect6045_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect6045_story.fillFlat = true
					arg_301_1.var_.characterEffect6045_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect6045_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect6045_story.fillFlat = true
				arg_301_1.var_.characterEffect6045_story.fillRatio = var_304_5
			end

			local var_304_6 = arg_301_1.actors_["6046_story"]
			local var_304_7 = 0

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect6046_story == nil then
				arg_301_1.var_.characterEffect6046_story = var_304_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_8 = 0.200000002980232

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_8 and not isNil(var_304_6) then
				local var_304_9 = (arg_301_1.time_ - var_304_7) / var_304_8

				if arg_301_1.var_.characterEffect6046_story and not isNil(var_304_6) then
					arg_301_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_7 + var_304_8 and arg_301_1.time_ < var_304_7 + var_304_8 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect6046_story then
				arg_301_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 then
				arg_301_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_304_11 = 0

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_12 = 0
			local var_304_13 = 0.425

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_14 = arg_301_1:FormatText(StoryNameCfg[214].name)

				arg_301_1.leftNameTxt_.text = var_304_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_15 = arg_301_1:GetWordFromCfg(1104202075)
				local var_304_16 = arg_301_1:FormatText(var_304_15.content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_17 = 17
				local var_304_18 = utf8.len(var_304_16)
				local var_304_19 = var_304_17 <= 0 and var_304_13 or var_304_13 * (var_304_18 / var_304_17)

				if var_304_19 > 0 and var_304_13 < var_304_19 then
					arg_301_1.talkMaxDuration = var_304_19

					if var_304_19 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_12
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202075", "story_v_side_new_1104202.awb") ~= 0 then
					local var_304_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202075", "story_v_side_new_1104202.awb") / 1000

					if var_304_20 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_12
					end

					if var_304_15.prefab_name ~= "" and arg_301_1.actors_[var_304_15.prefab_name] ~= nil then
						local var_304_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_15.prefab_name].transform, "story_v_side_new_1104202", "1104202075", "story_v_side_new_1104202.awb")

						arg_301_1:RecordAudio("1104202075", var_304_21)
						arg_301_1:RecordAudio("1104202075", var_304_21)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202075", "story_v_side_new_1104202.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202075", "story_v_side_new_1104202.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_22 = math.max(var_304_13, arg_301_1.talkMaxDuration)

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_12) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_12 + var_304_22 and arg_301_1.time_ < var_304_12 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1104202076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104202076
		arg_305_1.duration_ = 11.7

		local var_305_0 = {
			ja = 11.7,
			ko = 9.466,
			zh = 9.466
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
				arg_305_0:Play1104202077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["6046_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect6046_story == nil then
				arg_305_1.var_.characterEffect6046_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect6046_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect6046_story.fillFlat = true
					arg_305_1.var_.characterEffect6046_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect6046_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect6046_story.fillFlat = true
				arg_305_1.var_.characterEffect6046_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.975

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[444].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1104202076)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 39
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202076", "story_v_side_new_1104202.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202076", "story_v_side_new_1104202.awb") / 1000

					if var_308_14 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_6
					end

					if var_308_9.prefab_name ~= "" and arg_305_1.actors_[var_308_9.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_9.prefab_name].transform, "story_v_side_new_1104202", "1104202076", "story_v_side_new_1104202.awb")

						arg_305_1:RecordAudio("1104202076", var_308_15)
						arg_305_1:RecordAudio("1104202076", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202076", "story_v_side_new_1104202.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202076", "story_v_side_new_1104202.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_16 and arg_305_1.time_ < var_308_6 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104202077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104202077
		arg_309_1.duration_ = 3.53

		local var_309_0 = {
			ja = 3.533,
			ko = 3.5,
			zh = 3.5
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
				arg_309_0:Play1104202078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["6046_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect6046_story == nil then
				arg_309_1.var_.characterEffect6046_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect6046_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect6046_story then
				arg_309_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_312_6 = arg_309_1.actors_["6045_story"]
			local var_312_7 = 0

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect6045_story == nil then
				arg_309_1.var_.characterEffect6045_story = var_312_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_8 = 0.200000002980232

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_8 and not isNil(var_312_6) then
				local var_312_9 = (arg_309_1.time_ - var_312_7) / var_312_8

				if arg_309_1.var_.characterEffect6045_story and not isNil(var_312_6) then
					local var_312_10 = Mathf.Lerp(0, 0.5, var_312_9)

					arg_309_1.var_.characterEffect6045_story.fillFlat = true
					arg_309_1.var_.characterEffect6045_story.fillRatio = var_312_10
				end
			end

			if arg_309_1.time_ >= var_312_7 + var_312_8 and arg_309_1.time_ < var_312_7 + var_312_8 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect6045_story then
				local var_312_11 = 0.5

				arg_309_1.var_.characterEffect6045_story.fillFlat = true
				arg_309_1.var_.characterEffect6045_story.fillRatio = var_312_11
			end

			local var_312_12 = 0
			local var_312_13 = 0.275

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_14 = arg_309_1:FormatText(StoryNameCfg[214].name)

				arg_309_1.leftNameTxt_.text = var_312_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_15 = arg_309_1:GetWordFromCfg(1104202077)
				local var_312_16 = arg_309_1:FormatText(var_312_15.content)

				arg_309_1.text_.text = var_312_16

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_17 = 11
				local var_312_18 = utf8.len(var_312_16)
				local var_312_19 = var_312_17 <= 0 and var_312_13 or var_312_13 * (var_312_18 / var_312_17)

				if var_312_19 > 0 and var_312_13 < var_312_19 then
					arg_309_1.talkMaxDuration = var_312_19

					if var_312_19 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_19 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_16
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202077", "story_v_side_new_1104202.awb") ~= 0 then
					local var_312_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202077", "story_v_side_new_1104202.awb") / 1000

					if var_312_20 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_12
					end

					if var_312_15.prefab_name ~= "" and arg_309_1.actors_[var_312_15.prefab_name] ~= nil then
						local var_312_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_15.prefab_name].transform, "story_v_side_new_1104202", "1104202077", "story_v_side_new_1104202.awb")

						arg_309_1:RecordAudio("1104202077", var_312_21)
						arg_309_1:RecordAudio("1104202077", var_312_21)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202077", "story_v_side_new_1104202.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202077", "story_v_side_new_1104202.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_22 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_22 and arg_309_1.time_ < var_312_12 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1104202078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104202078
		arg_313_1.duration_ = 8.63

		local var_313_0 = {
			ja = 4.1,
			ko = 8.633,
			zh = 8.633
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1104202079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["6045_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect6045_story == nil then
				arg_313_1.var_.characterEffect6045_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect6045_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect6045_story then
				arg_313_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_6 = arg_313_1.actors_["6046_story"]
			local var_316_7 = 0

			if var_316_7 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect6046_story == nil then
				arg_313_1.var_.characterEffect6046_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_8 = 0.200000002980232

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_8 and not isNil(var_316_6) then
				local var_316_9 = (arg_313_1.time_ - var_316_7) / var_316_8

				if arg_313_1.var_.characterEffect6046_story and not isNil(var_316_6) then
					local var_316_10 = Mathf.Lerp(0, 0.5, var_316_9)

					arg_313_1.var_.characterEffect6046_story.fillFlat = true
					arg_313_1.var_.characterEffect6046_story.fillRatio = var_316_10
				end
			end

			if arg_313_1.time_ >= var_316_7 + var_316_8 and arg_313_1.time_ < var_316_7 + var_316_8 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect6046_story then
				local var_316_11 = 0.5

				arg_313_1.var_.characterEffect6046_story.fillFlat = true
				arg_313_1.var_.characterEffect6046_story.fillRatio = var_316_11
			end

			local var_316_12 = 0
			local var_316_13 = 0.525

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_14 = arg_313_1:FormatText(StoryNameCfg[215].name)

				arg_313_1.leftNameTxt_.text = var_316_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:GetWordFromCfg(1104202078)
				local var_316_16 = arg_313_1:FormatText(var_316_15.content)

				arg_313_1.text_.text = var_316_16

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 21
				local var_316_18 = utf8.len(var_316_16)
				local var_316_19 = var_316_17 <= 0 and var_316_13 or var_316_13 * (var_316_18 / var_316_17)

				if var_316_19 > 0 and var_316_13 < var_316_19 then
					arg_313_1.talkMaxDuration = var_316_19

					if var_316_19 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_16
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202078", "story_v_side_new_1104202.awb") ~= 0 then
					local var_316_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202078", "story_v_side_new_1104202.awb") / 1000

					if var_316_20 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_20 + var_316_12
					end

					if var_316_15.prefab_name ~= "" and arg_313_1.actors_[var_316_15.prefab_name] ~= nil then
						local var_316_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_15.prefab_name].transform, "story_v_side_new_1104202", "1104202078", "story_v_side_new_1104202.awb")

						arg_313_1:RecordAudio("1104202078", var_316_21)
						arg_313_1:RecordAudio("1104202078", var_316_21)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202078", "story_v_side_new_1104202.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202078", "story_v_side_new_1104202.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_22 and arg_313_1.time_ < var_316_12 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1104202079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104202079
		arg_317_1.duration_ = 12.2

		local var_317_0 = {
			ja = 12.2,
			ko = 10,
			zh = 10
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104202080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["6045_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect6045_story == nil then
				arg_317_1.var_.characterEffect6045_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect6045_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect6045_story.fillFlat = true
					arg_317_1.var_.characterEffect6045_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect6045_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect6045_story.fillFlat = true
				arg_317_1.var_.characterEffect6045_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 1.1

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[444].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(1104202079)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 44
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202079", "story_v_side_new_1104202.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202079", "story_v_side_new_1104202.awb") / 1000

					if var_320_14 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_6
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_side_new_1104202", "1104202079", "story_v_side_new_1104202.awb")

						arg_317_1:RecordAudio("1104202079", var_320_15)
						arg_317_1:RecordAudio("1104202079", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202079", "story_v_side_new_1104202.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202079", "story_v_side_new_1104202.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_16 and arg_317_1.time_ < var_320_6 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104202080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104202080
		arg_321_1.duration_ = 9.8

		local var_321_0 = {
			ja = 9.766,
			ko = 9.8,
			zh = 9.8
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
				arg_321_0:Play1104202081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["6045_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect6045_story == nil then
				arg_321_1.var_.characterEffect6045_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect6045_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect6045_story then
				arg_321_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_324_4 = 0

			if var_324_4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_6 = 0
			local var_324_7 = 0.525

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[215].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_9 = arg_321_1:GetWordFromCfg(1104202080)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 21
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202080", "story_v_side_new_1104202.awb") ~= 0 then
					local var_324_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202080", "story_v_side_new_1104202.awb") / 1000

					if var_324_14 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_6
					end

					if var_324_9.prefab_name ~= "" and arg_321_1.actors_[var_324_9.prefab_name] ~= nil then
						local var_324_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_9.prefab_name].transform, "story_v_side_new_1104202", "1104202080", "story_v_side_new_1104202.awb")

						arg_321_1:RecordAudio("1104202080", var_324_15)
						arg_321_1:RecordAudio("1104202080", var_324_15)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202080", "story_v_side_new_1104202.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202080", "story_v_side_new_1104202.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_16 and arg_321_1.time_ < var_324_6 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1104202081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104202081
		arg_325_1.duration_ = 3.97

		local var_325_0 = {
			ja = 3.6,
			ko = 3.966,
			zh = 3.966
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
				arg_325_0:Play1104202082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["6045_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect6045_story == nil then
				arg_325_1.var_.characterEffect6045_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect6045_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect6045_story then
				arg_325_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_328_4 = 0

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_6 = 0
			local var_328_7 = 0.25

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[215].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_9 = arg_325_1:GetWordFromCfg(1104202081)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 10
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202081", "story_v_side_new_1104202.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202081", "story_v_side_new_1104202.awb") / 1000

					if var_328_14 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_6
					end

					if var_328_9.prefab_name ~= "" and arg_325_1.actors_[var_328_9.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_9.prefab_name].transform, "story_v_side_new_1104202", "1104202081", "story_v_side_new_1104202.awb")

						arg_325_1:RecordAudio("1104202081", var_328_15)
						arg_325_1:RecordAudio("1104202081", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202081", "story_v_side_new_1104202.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202081", "story_v_side_new_1104202.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_16 and arg_325_1.time_ < var_328_6 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1104202082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104202082
		arg_329_1.duration_ = 7

		local var_329_0 = {
			ja = 5.766,
			ko = 7,
			zh = 7
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
				arg_329_0:Play1104202083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["6045_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect6045_story == nil then
				arg_329_1.var_.characterEffect6045_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect6045_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect6045_story.fillFlat = true
					arg_329_1.var_.characterEffect6045_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect6045_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect6045_story.fillFlat = true
				arg_329_1.var_.characterEffect6045_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.775

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[444].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(1104202082)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 31
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202082", "story_v_side_new_1104202.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202082", "story_v_side_new_1104202.awb") / 1000

					if var_332_14 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_6
					end

					if var_332_9.prefab_name ~= "" and arg_329_1.actors_[var_332_9.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_9.prefab_name].transform, "story_v_side_new_1104202", "1104202082", "story_v_side_new_1104202.awb")

						arg_329_1:RecordAudio("1104202082", var_332_15)
						arg_329_1:RecordAudio("1104202082", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202082", "story_v_side_new_1104202.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202082", "story_v_side_new_1104202.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_16 and arg_329_1.time_ < var_332_6 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1104202083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104202083
		arg_333_1.duration_ = 9.9

		local var_333_0 = {
			ja = 9.9,
			ko = 5.3,
			zh = 5.3
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
				arg_333_0:Play1104202084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["6046_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect6046_story == nil then
				arg_333_1.var_.characterEffect6046_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect6046_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect6046_story then
				arg_333_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_6 = 0
			local var_336_7 = 0.475

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[214].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(1104202083)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 19
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202083", "story_v_side_new_1104202.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202083", "story_v_side_new_1104202.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_side_new_1104202", "1104202083", "story_v_side_new_1104202.awb")

						arg_333_1:RecordAudio("1104202083", var_336_15)
						arg_333_1:RecordAudio("1104202083", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202083", "story_v_side_new_1104202.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202083", "story_v_side_new_1104202.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1104202084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104202084
		arg_337_1.duration_ = 5.1

		local var_337_0 = {
			ja = 3.533,
			ko = 5.1,
			zh = 5.1
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
				arg_337_0:Play1104202085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["6045_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect6045_story == nil then
				arg_337_1.var_.characterEffect6045_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect6045_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect6045_story then
				arg_337_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_340_4 = 0

			if var_340_4 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_340_5 = 0

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_340_6 = arg_337_1.actors_["6046_story"]
			local var_340_7 = 0

			if var_340_7 < arg_337_1.time_ and arg_337_1.time_ <= var_340_7 + arg_340_0 and not isNil(var_340_6) and arg_337_1.var_.characterEffect6046_story == nil then
				arg_337_1.var_.characterEffect6046_story = var_340_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_8 = 0.200000002980232

			if var_340_7 <= arg_337_1.time_ and arg_337_1.time_ < var_340_7 + var_340_8 and not isNil(var_340_6) then
				local var_340_9 = (arg_337_1.time_ - var_340_7) / var_340_8

				if arg_337_1.var_.characterEffect6046_story and not isNil(var_340_6) then
					local var_340_10 = Mathf.Lerp(0, 0.5, var_340_9)

					arg_337_1.var_.characterEffect6046_story.fillFlat = true
					arg_337_1.var_.characterEffect6046_story.fillRatio = var_340_10
				end
			end

			if arg_337_1.time_ >= var_340_7 + var_340_8 and arg_337_1.time_ < var_340_7 + var_340_8 + arg_340_0 and not isNil(var_340_6) and arg_337_1.var_.characterEffect6046_story then
				local var_340_11 = 0.5

				arg_337_1.var_.characterEffect6046_story.fillFlat = true
				arg_337_1.var_.characterEffect6046_story.fillRatio = var_340_11
			end

			local var_340_12 = 0
			local var_340_13 = 0.325

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_14 = arg_337_1:FormatText(StoryNameCfg[215].name)

				arg_337_1.leftNameTxt_.text = var_340_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_15 = arg_337_1:GetWordFromCfg(1104202084)
				local var_340_16 = arg_337_1:FormatText(var_340_15.content)

				arg_337_1.text_.text = var_340_16

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_17 = 13
				local var_340_18 = utf8.len(var_340_16)
				local var_340_19 = var_340_17 <= 0 and var_340_13 or var_340_13 * (var_340_18 / var_340_17)

				if var_340_19 > 0 and var_340_13 < var_340_19 then
					arg_337_1.talkMaxDuration = var_340_19

					if var_340_19 + var_340_12 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_19 + var_340_12
					end
				end

				arg_337_1.text_.text = var_340_16
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202084", "story_v_side_new_1104202.awb") ~= 0 then
					local var_340_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202084", "story_v_side_new_1104202.awb") / 1000

					if var_340_20 + var_340_12 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_20 + var_340_12
					end

					if var_340_15.prefab_name ~= "" and arg_337_1.actors_[var_340_15.prefab_name] ~= nil then
						local var_340_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_15.prefab_name].transform, "story_v_side_new_1104202", "1104202084", "story_v_side_new_1104202.awb")

						arg_337_1:RecordAudio("1104202084", var_340_21)
						arg_337_1:RecordAudio("1104202084", var_340_21)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202084", "story_v_side_new_1104202.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202084", "story_v_side_new_1104202.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_22 = math.max(var_340_13, arg_337_1.talkMaxDuration)

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_22 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_12) / var_340_22

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_12 + var_340_22 and arg_337_1.time_ < var_340_12 + var_340_22 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104202085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104202085
		arg_341_1.duration_ = 4.43

		local var_341_0 = {
			ja = 3.5,
			ko = 4.433,
			zh = 4.433
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
				arg_341_0:Play1104202086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["6046_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect6046_story == nil then
				arg_341_1.var_.characterEffect6046_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect6046_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect6046_story then
				arg_341_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_344_4 = 0

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_6 = arg_341_1.actors_["6045_story"]
			local var_344_7 = 0

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect6045_story == nil then
				arg_341_1.var_.characterEffect6045_story = var_344_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_8 = 0.200000002980232

			if var_344_7 <= arg_341_1.time_ and arg_341_1.time_ < var_344_7 + var_344_8 and not isNil(var_344_6) then
				local var_344_9 = (arg_341_1.time_ - var_344_7) / var_344_8

				if arg_341_1.var_.characterEffect6045_story and not isNil(var_344_6) then
					local var_344_10 = Mathf.Lerp(0, 0.5, var_344_9)

					arg_341_1.var_.characterEffect6045_story.fillFlat = true
					arg_341_1.var_.characterEffect6045_story.fillRatio = var_344_10
				end
			end

			if arg_341_1.time_ >= var_344_7 + var_344_8 and arg_341_1.time_ < var_344_7 + var_344_8 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect6045_story then
				local var_344_11 = 0.5

				arg_341_1.var_.characterEffect6045_story.fillFlat = true
				arg_341_1.var_.characterEffect6045_story.fillRatio = var_344_11
			end

			local var_344_12 = 0
			local var_344_13 = 0.4

			if var_344_12 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_14 = arg_341_1:FormatText(StoryNameCfg[214].name)

				arg_341_1.leftNameTxt_.text = var_344_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_15 = arg_341_1:GetWordFromCfg(1104202085)
				local var_344_16 = arg_341_1:FormatText(var_344_15.content)

				arg_341_1.text_.text = var_344_16

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_17 = 16
				local var_344_18 = utf8.len(var_344_16)
				local var_344_19 = var_344_17 <= 0 and var_344_13 or var_344_13 * (var_344_18 / var_344_17)

				if var_344_19 > 0 and var_344_13 < var_344_19 then
					arg_341_1.talkMaxDuration = var_344_19

					if var_344_19 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_19 + var_344_12
					end
				end

				arg_341_1.text_.text = var_344_16
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202085", "story_v_side_new_1104202.awb") ~= 0 then
					local var_344_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202085", "story_v_side_new_1104202.awb") / 1000

					if var_344_20 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_20 + var_344_12
					end

					if var_344_15.prefab_name ~= "" and arg_341_1.actors_[var_344_15.prefab_name] ~= nil then
						local var_344_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_15.prefab_name].transform, "story_v_side_new_1104202", "1104202085", "story_v_side_new_1104202.awb")

						arg_341_1:RecordAudio("1104202085", var_344_21)
						arg_341_1:RecordAudio("1104202085", var_344_21)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202085", "story_v_side_new_1104202.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202085", "story_v_side_new_1104202.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_22 = math.max(var_344_13, arg_341_1.talkMaxDuration)

			if var_344_12 <= arg_341_1.time_ and arg_341_1.time_ < var_344_12 + var_344_22 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_12) / var_344_22

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_12 + var_344_22 and arg_341_1.time_ < var_344_12 + var_344_22 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1104202086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104202086
		arg_345_1.duration_ = 7.8

		local var_345_0 = {
			ja = 6.033,
			ko = 7.8,
			zh = 7.8
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104202087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["6046_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect6046_story == nil then
				arg_345_1.var_.characterEffect6046_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect6046_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect6046_story.fillFlat = true
					arg_345_1.var_.characterEffect6046_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect6046_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect6046_story.fillFlat = true
				arg_345_1.var_.characterEffect6046_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.775

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[444].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(1104202086)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 31
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202086", "story_v_side_new_1104202.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202086", "story_v_side_new_1104202.awb") / 1000

					if var_348_14 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_6
					end

					if var_348_9.prefab_name ~= "" and arg_345_1.actors_[var_348_9.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_9.prefab_name].transform, "story_v_side_new_1104202", "1104202086", "story_v_side_new_1104202.awb")

						arg_345_1:RecordAudio("1104202086", var_348_15)
						arg_345_1:RecordAudio("1104202086", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202086", "story_v_side_new_1104202.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202086", "story_v_side_new_1104202.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_16 and arg_345_1.time_ < var_348_6 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1104202087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104202087
		arg_349_1.duration_ = 4.87

		local var_349_0 = {
			ja = 3.9,
			ko = 4.866,
			zh = 4.866
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
				arg_349_0:Play1104202088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["6046_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect6046_story == nil then
				arg_349_1.var_.characterEffect6046_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect6046_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect6046_story then
				arg_349_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_352_4 = 0

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_6 = 0
			local var_352_7 = 0.4

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[214].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(1104202087)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 16
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202087", "story_v_side_new_1104202.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202087", "story_v_side_new_1104202.awb") / 1000

					if var_352_14 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_6
					end

					if var_352_9.prefab_name ~= "" and arg_349_1.actors_[var_352_9.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_9.prefab_name].transform, "story_v_side_new_1104202", "1104202087", "story_v_side_new_1104202.awb")

						arg_349_1:RecordAudio("1104202087", var_352_15)
						arg_349_1:RecordAudio("1104202087", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202087", "story_v_side_new_1104202.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202087", "story_v_side_new_1104202.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_16 and arg_349_1.time_ < var_352_6 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1104202088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104202088
		arg_353_1.duration_ = 10.3

		local var_353_0 = {
			ja = 10.3,
			ko = 7.366,
			zh = 7.366
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
				arg_353_0:Play1104202089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["6046_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect6046_story == nil then
				arg_353_1.var_.characterEffect6046_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect6046_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect6046_story.fillFlat = true
					arg_353_1.var_.characterEffect6046_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect6046_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect6046_story.fillFlat = true
				arg_353_1.var_.characterEffect6046_story.fillRatio = var_356_5
			end

			local var_356_6 = 0
			local var_356_7 = 0.725

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_8 = arg_353_1:FormatText(StoryNameCfg[444].name)

				arg_353_1.leftNameTxt_.text = var_356_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_9 = arg_353_1:GetWordFromCfg(1104202088)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 29
				local var_356_12 = utf8.len(var_356_10)
				local var_356_13 = var_356_11 <= 0 and var_356_7 or var_356_7 * (var_356_12 / var_356_11)

				if var_356_13 > 0 and var_356_7 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202088", "story_v_side_new_1104202.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202088", "story_v_side_new_1104202.awb") / 1000

					if var_356_14 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_6
					end

					if var_356_9.prefab_name ~= "" and arg_353_1.actors_[var_356_9.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_9.prefab_name].transform, "story_v_side_new_1104202", "1104202088", "story_v_side_new_1104202.awb")

						arg_353_1:RecordAudio("1104202088", var_356_15)
						arg_353_1:RecordAudio("1104202088", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202088", "story_v_side_new_1104202.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202088", "story_v_side_new_1104202.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_16 and arg_353_1.time_ < var_356_6 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1104202089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104202089
		arg_357_1.duration_ = 5.67

		local var_357_0 = {
			ja = 4.9,
			ko = 5.666,
			zh = 5.666
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
				arg_357_0:Play1104202090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["6045_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect6045_story == nil then
				arg_357_1.var_.characterEffect6045_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect6045_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect6045_story then
				arg_357_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_360_4 = 0

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_6 = 0
			local var_360_7 = 0.3

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_8 = arg_357_1:FormatText(StoryNameCfg[215].name)

				arg_357_1.leftNameTxt_.text = var_360_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_9 = arg_357_1:GetWordFromCfg(1104202089)
				local var_360_10 = arg_357_1:FormatText(var_360_9.content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 12
				local var_360_12 = utf8.len(var_360_10)
				local var_360_13 = var_360_11 <= 0 and var_360_7 or var_360_7 * (var_360_12 / var_360_11)

				if var_360_13 > 0 and var_360_7 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202089", "story_v_side_new_1104202.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202089", "story_v_side_new_1104202.awb") / 1000

					if var_360_14 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_6
					end

					if var_360_9.prefab_name ~= "" and arg_357_1.actors_[var_360_9.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_9.prefab_name].transform, "story_v_side_new_1104202", "1104202089", "story_v_side_new_1104202.awb")

						arg_357_1:RecordAudio("1104202089", var_360_15)
						arg_357_1:RecordAudio("1104202089", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202089", "story_v_side_new_1104202.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202089", "story_v_side_new_1104202.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_16 and arg_357_1.time_ < var_360_6 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1104202090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104202090
		arg_361_1.duration_ = 10.5

		local var_361_0 = {
			ja = 10.066,
			ko = 10.5,
			zh = 10.5
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
				arg_361_0:Play1104202091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["6045_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect6045_story == nil then
				arg_361_1.var_.characterEffect6045_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect6045_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect6045_story.fillFlat = true
					arg_361_1.var_.characterEffect6045_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect6045_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect6045_story.fillFlat = true
				arg_361_1.var_.characterEffect6045_story.fillRatio = var_364_5
			end

			local var_364_6 = 0
			local var_364_7 = 1.225

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_8 = arg_361_1:FormatText(StoryNameCfg[444].name)

				arg_361_1.leftNameTxt_.text = var_364_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_9 = arg_361_1:GetWordFromCfg(1104202090)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 49
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_7 or var_364_7 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_7 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202090", "story_v_side_new_1104202.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202090", "story_v_side_new_1104202.awb") / 1000

					if var_364_14 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_6
					end

					if var_364_9.prefab_name ~= "" and arg_361_1.actors_[var_364_9.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_9.prefab_name].transform, "story_v_side_new_1104202", "1104202090", "story_v_side_new_1104202.awb")

						arg_361_1:RecordAudio("1104202090", var_364_15)
						arg_361_1:RecordAudio("1104202090", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202090", "story_v_side_new_1104202.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202090", "story_v_side_new_1104202.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_16 and arg_361_1.time_ < var_364_6 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104202091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104202091
		arg_365_1.duration_ = 7.3

		local var_365_0 = {
			ja = 6.266,
			ko = 7.3,
			zh = 7.3
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
				arg_365_0:Play1104202092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.775

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[444].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(1104202091)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 37
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202091", "story_v_side_new_1104202.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202091", "story_v_side_new_1104202.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_side_new_1104202", "1104202091", "story_v_side_new_1104202.awb")

						arg_365_1:RecordAudio("1104202091", var_368_9)
						arg_365_1:RecordAudio("1104202091", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202091", "story_v_side_new_1104202.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202091", "story_v_side_new_1104202.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104202092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104202092
		arg_369_1.duration_ = 11.3

		local var_369_0 = {
			ja = 9.4,
			ko = 11.3,
			zh = 11.3
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
				arg_369_0:Play1104202093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["6045_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect6045_story == nil then
				arg_369_1.var_.characterEffect6045_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect6045_story and not isNil(var_372_0) then
					arg_369_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect6045_story then
				arg_369_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_372_4 = 0

			if var_372_4 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			local var_372_5 = 0

			if var_372_5 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_6 = 0
			local var_372_7 = 0.725

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[215].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_9 = arg_369_1:GetWordFromCfg(1104202092)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 29
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202092", "story_v_side_new_1104202.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202092", "story_v_side_new_1104202.awb") / 1000

					if var_372_14 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_6
					end

					if var_372_9.prefab_name ~= "" and arg_369_1.actors_[var_372_9.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_9.prefab_name].transform, "story_v_side_new_1104202", "1104202092", "story_v_side_new_1104202.awb")

						arg_369_1:RecordAudio("1104202092", var_372_15)
						arg_369_1:RecordAudio("1104202092", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202092", "story_v_side_new_1104202.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202092", "story_v_side_new_1104202.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_16 and arg_369_1.time_ < var_372_6 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1104202093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104202093
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104202094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["6045_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect6045_story == nil then
				arg_373_1.var_.characterEffect6045_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect6045_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect6045_story.fillFlat = true
					arg_373_1.var_.characterEffect6045_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect6045_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect6045_story.fillFlat = true
				arg_373_1.var_.characterEffect6045_story.fillRatio = var_376_5
			end

			local var_376_6 = 0
			local var_376_7 = 0.825

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(1104202093)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 33
				local var_376_11 = utf8.len(var_376_9)
				local var_376_12 = var_376_10 <= 0 and var_376_7 or var_376_7 * (var_376_11 / var_376_10)

				if var_376_12 > 0 and var_376_7 < var_376_12 then
					arg_373_1.talkMaxDuration = var_376_12

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_13 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_13 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_13

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_13 and arg_373_1.time_ < var_376_6 + var_376_13 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1104202094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104202094
		arg_377_1.duration_ = 5.53

		local var_377_0 = {
			ja = 5.533,
			ko = 4.1,
			zh = 4.1
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
				arg_377_0:Play1104202095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["6046_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect6046_story == nil then
				arg_377_1.var_.characterEffect6046_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect6046_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect6046_story then
				arg_377_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_380_4 = 0

			if var_380_4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action443")
			end

			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_6 = 0
			local var_380_7 = 0.35

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[214].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_9 = arg_377_1:GetWordFromCfg(1104202094)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 14
				local var_380_12 = utf8.len(var_380_10)
				local var_380_13 = var_380_11 <= 0 and var_380_7 or var_380_7 * (var_380_12 / var_380_11)

				if var_380_13 > 0 and var_380_7 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202094", "story_v_side_new_1104202.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202094", "story_v_side_new_1104202.awb") / 1000

					if var_380_14 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_6
					end

					if var_380_9.prefab_name ~= "" and arg_377_1.actors_[var_380_9.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_9.prefab_name].transform, "story_v_side_new_1104202", "1104202094", "story_v_side_new_1104202.awb")

						arg_377_1:RecordAudio("1104202094", var_380_15)
						arg_377_1:RecordAudio("1104202094", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202094", "story_v_side_new_1104202.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202094", "story_v_side_new_1104202.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_16 and arg_377_1.time_ < var_380_6 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104202095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104202095
		arg_381_1.duration_ = 6.67

		local var_381_0 = {
			ja = 5.133,
			ko = 6.666,
			zh = 6.666
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104202096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["6046_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect6046_story == nil then
				arg_381_1.var_.characterEffect6046_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect6046_story and not isNil(var_384_0) then
					local var_384_4 = Mathf.Lerp(0, 0.5, var_384_3)

					arg_381_1.var_.characterEffect6046_story.fillFlat = true
					arg_381_1.var_.characterEffect6046_story.fillRatio = var_384_4
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect6046_story then
				local var_384_5 = 0.5

				arg_381_1.var_.characterEffect6046_story.fillFlat = true
				arg_381_1.var_.characterEffect6046_story.fillRatio = var_384_5
			end

			local var_384_6 = 0
			local var_384_7 = 0.775

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[444].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_9 = arg_381_1:GetWordFromCfg(1104202095)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 31
				local var_384_12 = utf8.len(var_384_10)
				local var_384_13 = var_384_11 <= 0 and var_384_7 or var_384_7 * (var_384_12 / var_384_11)

				if var_384_13 > 0 and var_384_7 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202095", "story_v_side_new_1104202.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202095", "story_v_side_new_1104202.awb") / 1000

					if var_384_14 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_6
					end

					if var_384_9.prefab_name ~= "" and arg_381_1.actors_[var_384_9.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_9.prefab_name].transform, "story_v_side_new_1104202", "1104202095", "story_v_side_new_1104202.awb")

						arg_381_1:RecordAudio("1104202095", var_384_15)
						arg_381_1:RecordAudio("1104202095", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202095", "story_v_side_new_1104202.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202095", "story_v_side_new_1104202.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_16 and arg_381_1.time_ < var_384_6 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1104202096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104202096
		arg_385_1.duration_ = 7.27

		local var_385_0 = {
			ja = 6.566,
			ko = 7.266,
			zh = 7.266
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
				arg_385_0:Play1104202097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["6046_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect6046_story == nil then
				arg_385_1.var_.characterEffect6046_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect6046_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect6046_story then
				arg_385_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_388_4 = 0

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_2")
			end

			local var_388_5 = 0

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_388_6 = 0

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_2")
			end

			local var_388_7 = 0
			local var_388_8 = 0.6

			if var_388_7 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_9 = arg_385_1:FormatText(StoryNameCfg[214].name)

				arg_385_1.leftNameTxt_.text = var_388_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_10 = arg_385_1:GetWordFromCfg(1104202096)
				local var_388_11 = arg_385_1:FormatText(var_388_10.content)

				arg_385_1.text_.text = var_388_11

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_12 = 24
				local var_388_13 = utf8.len(var_388_11)
				local var_388_14 = var_388_12 <= 0 and var_388_8 or var_388_8 * (var_388_13 / var_388_12)

				if var_388_14 > 0 and var_388_8 < var_388_14 then
					arg_385_1.talkMaxDuration = var_388_14

					if var_388_14 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_14 + var_388_7
					end
				end

				arg_385_1.text_.text = var_388_11
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202096", "story_v_side_new_1104202.awb") ~= 0 then
					local var_388_15 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202096", "story_v_side_new_1104202.awb") / 1000

					if var_388_15 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_15 + var_388_7
					end

					if var_388_10.prefab_name ~= "" and arg_385_1.actors_[var_388_10.prefab_name] ~= nil then
						local var_388_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_10.prefab_name].transform, "story_v_side_new_1104202", "1104202096", "story_v_side_new_1104202.awb")

						arg_385_1:RecordAudio("1104202096", var_388_16)
						arg_385_1:RecordAudio("1104202096", var_388_16)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202096", "story_v_side_new_1104202.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202096", "story_v_side_new_1104202.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_17 = math.max(var_388_8, arg_385_1.talkMaxDuration)

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_17 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_7) / var_388_17

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_7 + var_388_17 and arg_385_1.time_ < var_388_7 + var_388_17 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104202097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104202097
		arg_389_1.duration_ = 11.8

		local var_389_0 = {
			ja = 11.8,
			ko = 9.466,
			zh = 9.466
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
				arg_389_0:Play1104202098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["6046_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect6046_story == nil then
				arg_389_1.var_.characterEffect6046_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect6046_story and not isNil(var_392_0) then
					local var_392_4 = Mathf.Lerp(0, 0.5, var_392_3)

					arg_389_1.var_.characterEffect6046_story.fillFlat = true
					arg_389_1.var_.characterEffect6046_story.fillRatio = var_392_4
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect6046_story then
				local var_392_5 = 0.5

				arg_389_1.var_.characterEffect6046_story.fillFlat = true
				arg_389_1.var_.characterEffect6046_story.fillRatio = var_392_5
			end

			local var_392_6 = 0
			local var_392_7 = 1.125

			if var_392_6 < arg_389_1.time_ and arg_389_1.time_ <= var_392_6 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_8 = arg_389_1:FormatText(StoryNameCfg[444].name)

				arg_389_1.leftNameTxt_.text = var_392_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_9 = arg_389_1:GetWordFromCfg(1104202097)
				local var_392_10 = arg_389_1:FormatText(var_392_9.content)

				arg_389_1.text_.text = var_392_10

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_11 = 45
				local var_392_12 = utf8.len(var_392_10)
				local var_392_13 = var_392_11 <= 0 and var_392_7 or var_392_7 * (var_392_12 / var_392_11)

				if var_392_13 > 0 and var_392_7 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_6
					end
				end

				arg_389_1.text_.text = var_392_10
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202097", "story_v_side_new_1104202.awb") ~= 0 then
					local var_392_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202097", "story_v_side_new_1104202.awb") / 1000

					if var_392_14 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_6
					end

					if var_392_9.prefab_name ~= "" and arg_389_1.actors_[var_392_9.prefab_name] ~= nil then
						local var_392_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_9.prefab_name].transform, "story_v_side_new_1104202", "1104202097", "story_v_side_new_1104202.awb")

						arg_389_1:RecordAudio("1104202097", var_392_15)
						arg_389_1:RecordAudio("1104202097", var_392_15)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202097", "story_v_side_new_1104202.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202097", "story_v_side_new_1104202.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_7, arg_389_1.talkMaxDuration)

			if var_392_6 <= arg_389_1.time_ and arg_389_1.time_ < var_392_6 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_6) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_6 + var_392_16 and arg_389_1.time_ < var_392_6 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104202098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104202098
		arg_393_1.duration_ = 9.83

		local var_393_0 = {
			ja = 9.833,
			ko = 9.166,
			zh = 9.166
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104202099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 1.1

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[444].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(1104202098)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 44
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202098", "story_v_side_new_1104202.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202098", "story_v_side_new_1104202.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_side_new_1104202", "1104202098", "story_v_side_new_1104202.awb")

						arg_393_1:RecordAudio("1104202098", var_396_9)
						arg_393_1:RecordAudio("1104202098", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202098", "story_v_side_new_1104202.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202098", "story_v_side_new_1104202.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_10 and arg_393_1.time_ < var_396_0 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104202099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104202099
		arg_397_1.duration_ = 4.27

		local var_397_0 = {
			ja = 3.366,
			ko = 4.266,
			zh = 4.266
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
				arg_397_0:Play1104202100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["6046_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect6046_story == nil then
				arg_397_1.var_.characterEffect6046_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect6046_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect6046_story then
				arg_397_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_6 = 0
			local var_400_7 = 0.375

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[214].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(1104202099)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 15
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202099", "story_v_side_new_1104202.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202099", "story_v_side_new_1104202.awb") / 1000

					if var_400_14 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_6
					end

					if var_400_9.prefab_name ~= "" and arg_397_1.actors_[var_400_9.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_9.prefab_name].transform, "story_v_side_new_1104202", "1104202099", "story_v_side_new_1104202.awb")

						arg_397_1:RecordAudio("1104202099", var_400_15)
						arg_397_1:RecordAudio("1104202099", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202099", "story_v_side_new_1104202.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202099", "story_v_side_new_1104202.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_16 and arg_397_1.time_ < var_400_6 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104202100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104202100
		arg_401_1.duration_ = 9.73

		local var_401_0 = {
			ja = 6.466,
			ko = 9.733,
			zh = 9.733
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
				arg_401_0:Play1104202101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["6046_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect6046_story == nil then
				arg_401_1.var_.characterEffect6046_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect6046_story and not isNil(var_404_0) then
					local var_404_4 = Mathf.Lerp(0, 0.5, var_404_3)

					arg_401_1.var_.characterEffect6046_story.fillFlat = true
					arg_401_1.var_.characterEffect6046_story.fillRatio = var_404_4
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect6046_story then
				local var_404_5 = 0.5

				arg_401_1.var_.characterEffect6046_story.fillFlat = true
				arg_401_1.var_.characterEffect6046_story.fillRatio = var_404_5
			end

			local var_404_6 = 0
			local var_404_7 = 0.95

			if var_404_6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_8 = arg_401_1:FormatText(StoryNameCfg[444].name)

				arg_401_1.leftNameTxt_.text = var_404_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_9 = arg_401_1:GetWordFromCfg(1104202100)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 38
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_7 or var_404_7 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_7 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202100", "story_v_side_new_1104202.awb") ~= 0 then
					local var_404_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202100", "story_v_side_new_1104202.awb") / 1000

					if var_404_14 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_14 + var_404_6
					end

					if var_404_9.prefab_name ~= "" and arg_401_1.actors_[var_404_9.prefab_name] ~= nil then
						local var_404_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_9.prefab_name].transform, "story_v_side_new_1104202", "1104202100", "story_v_side_new_1104202.awb")

						arg_401_1:RecordAudio("1104202100", var_404_15)
						arg_401_1:RecordAudio("1104202100", var_404_15)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202100", "story_v_side_new_1104202.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202100", "story_v_side_new_1104202.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_16 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_16 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_16

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_16 and arg_401_1.time_ < var_404_6 + var_404_16 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104202101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104202101
		arg_405_1.duration_ = 4.7

		local var_405_0 = {
			ja = 4.7,
			ko = 4.6,
			zh = 4.6
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104202102(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.55

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[444].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(1104202101)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 22
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202101", "story_v_side_new_1104202.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202101", "story_v_side_new_1104202.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_side_new_1104202", "1104202101", "story_v_side_new_1104202.awb")

						arg_405_1:RecordAudio("1104202101", var_408_9)
						arg_405_1:RecordAudio("1104202101", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202101", "story_v_side_new_1104202.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202101", "story_v_side_new_1104202.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104202102 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104202102
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104202103(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.725

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(1104202102)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 29
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
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_8 and arg_409_1.time_ < var_412_0 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1104202103 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104202103
		arg_413_1.duration_ = 8.63

		local var_413_0 = {
			ja = 8.633,
			ko = 8.533,
			zh = 8.533
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104202104(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["6045_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect6045_story == nil then
				arg_413_1.var_.characterEffect6045_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect6045_story and not isNil(var_416_0) then
					arg_413_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect6045_story then
				arg_413_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_416_4 = 0

			if var_416_4 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			local var_416_5 = 0

			if var_416_5 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_416_6 = 0
			local var_416_7 = 0.525

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_8 = arg_413_1:FormatText(StoryNameCfg[215].name)

				arg_413_1.leftNameTxt_.text = var_416_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_9 = arg_413_1:GetWordFromCfg(1104202103)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 21
				local var_416_12 = utf8.len(var_416_10)
				local var_416_13 = var_416_11 <= 0 and var_416_7 or var_416_7 * (var_416_12 / var_416_11)

				if var_416_13 > 0 and var_416_7 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202103", "story_v_side_new_1104202.awb") ~= 0 then
					local var_416_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202103", "story_v_side_new_1104202.awb") / 1000

					if var_416_14 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_14 + var_416_6
					end

					if var_416_9.prefab_name ~= "" and arg_413_1.actors_[var_416_9.prefab_name] ~= nil then
						local var_416_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_9.prefab_name].transform, "story_v_side_new_1104202", "1104202103", "story_v_side_new_1104202.awb")

						arg_413_1:RecordAudio("1104202103", var_416_15)
						arg_413_1:RecordAudio("1104202103", var_416_15)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202103", "story_v_side_new_1104202.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202103", "story_v_side_new_1104202.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_16 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_16 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_16

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_16 and arg_413_1.time_ < var_416_6 + var_416_16 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104202104 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104202104
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104202105(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["6045_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos6045_story = var_420_0.localPosition

				local var_420_2 = GameObjectTools.GetOrAddComponent(var_420_0.gameObject, typeof(DynamicBoneHelper))

				if var_420_2 then
					var_420_2:EnableDynamicBone(false)
				end
			end

			local var_420_3 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_3 then
				local var_420_4 = (arg_417_1.time_ - var_420_1) / var_420_3
				local var_420_5 = Vector3.New(0, 100, 0)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos6045_story, var_420_5, var_420_4)

				local var_420_6 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_6.x, var_420_6.y, var_420_6.z)

				local var_420_7 = var_420_0.localEulerAngles

				var_420_7.z = 0
				var_420_7.x = 0
				var_420_0.localEulerAngles = var_420_7
			end

			if arg_417_1.time_ >= var_420_1 + var_420_3 and arg_417_1.time_ < var_420_1 + var_420_3 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, 100, 0)

				local var_420_8 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_8.x, var_420_8.y, var_420_8.z)

				local var_420_9 = var_420_0.localEulerAngles

				var_420_9.z = 0
				var_420_9.x = 0
				var_420_0.localEulerAngles = var_420_9

				local var_420_10 = GameObjectTools.GetOrAddComponent(var_420_0.gameObject, typeof(DynamicBoneHelper))

				if var_420_10 then
					var_420_10:EnableDynamicBone(true)
				end
			end

			local var_420_11 = arg_417_1.actors_["6045_story"]
			local var_420_12 = 0

			if var_420_12 < arg_417_1.time_ and arg_417_1.time_ <= var_420_12 + arg_420_0 and not isNil(var_420_11) and arg_417_1.var_.characterEffect6045_story == nil then
				arg_417_1.var_.characterEffect6045_story = var_420_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_13 = 0.200000002980232

			if var_420_12 <= arg_417_1.time_ and arg_417_1.time_ < var_420_12 + var_420_13 and not isNil(var_420_11) then
				local var_420_14 = (arg_417_1.time_ - var_420_12) / var_420_13

				if arg_417_1.var_.characterEffect6045_story and not isNil(var_420_11) then
					local var_420_15 = Mathf.Lerp(0, 0.5, var_420_14)

					arg_417_1.var_.characterEffect6045_story.fillFlat = true
					arg_417_1.var_.characterEffect6045_story.fillRatio = var_420_15
				end
			end

			if arg_417_1.time_ >= var_420_12 + var_420_13 and arg_417_1.time_ < var_420_12 + var_420_13 + arg_420_0 and not isNil(var_420_11) and arg_417_1.var_.characterEffect6045_story then
				local var_420_16 = 0.5

				arg_417_1.var_.characterEffect6045_story.fillFlat = true
				arg_417_1.var_.characterEffect6045_story.fillRatio = var_420_16
			end

			local var_420_17 = arg_417_1.actors_["6046_story"].transform
			local var_420_18 = 0

			if var_420_18 < arg_417_1.time_ and arg_417_1.time_ <= var_420_18 + arg_420_0 then
				arg_417_1.var_.moveOldPos6046_story = var_420_17.localPosition

				local var_420_19 = GameObjectTools.GetOrAddComponent(var_420_17.gameObject, typeof(DynamicBoneHelper))

				if var_420_19 then
					var_420_19:EnableDynamicBone(false)
				end
			end

			local var_420_20 = 0.001

			if var_420_18 <= arg_417_1.time_ and arg_417_1.time_ < var_420_18 + var_420_20 then
				local var_420_21 = (arg_417_1.time_ - var_420_18) / var_420_20
				local var_420_22 = Vector3.New(0, 100, 0)

				var_420_17.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos6046_story, var_420_22, var_420_21)

				local var_420_23 = manager.ui.mainCamera.transform.position - var_420_17.position

				var_420_17.forward = Vector3.New(var_420_23.x, var_420_23.y, var_420_23.z)

				local var_420_24 = var_420_17.localEulerAngles

				var_420_24.z = 0
				var_420_24.x = 0
				var_420_17.localEulerAngles = var_420_24
			end

			if arg_417_1.time_ >= var_420_18 + var_420_20 and arg_417_1.time_ < var_420_18 + var_420_20 + arg_420_0 then
				var_420_17.localPosition = Vector3.New(0, 100, 0)

				local var_420_25 = manager.ui.mainCamera.transform.position - var_420_17.position

				var_420_17.forward = Vector3.New(var_420_25.x, var_420_25.y, var_420_25.z)

				local var_420_26 = var_420_17.localEulerAngles

				var_420_26.z = 0
				var_420_26.x = 0
				var_420_17.localEulerAngles = var_420_26

				local var_420_27 = GameObjectTools.GetOrAddComponent(var_420_17.gameObject, typeof(DynamicBoneHelper))

				if var_420_27 then
					var_420_27:EnableDynamicBone(true)
				end
			end

			local var_420_28 = arg_417_1.actors_["6046_story"]
			local var_420_29 = 0

			if var_420_29 < arg_417_1.time_ and arg_417_1.time_ <= var_420_29 + arg_420_0 and not isNil(var_420_28) and arg_417_1.var_.characterEffect6046_story == nil then
				arg_417_1.var_.characterEffect6046_story = var_420_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_30 = 0.200000002980232

			if var_420_29 <= arg_417_1.time_ and arg_417_1.time_ < var_420_29 + var_420_30 and not isNil(var_420_28) then
				local var_420_31 = (arg_417_1.time_ - var_420_29) / var_420_30

				if arg_417_1.var_.characterEffect6046_story and not isNil(var_420_28) then
					local var_420_32 = Mathf.Lerp(0, 0.5, var_420_31)

					arg_417_1.var_.characterEffect6046_story.fillFlat = true
					arg_417_1.var_.characterEffect6046_story.fillRatio = var_420_32
				end
			end

			if arg_417_1.time_ >= var_420_29 + var_420_30 and arg_417_1.time_ < var_420_29 + var_420_30 + arg_420_0 and not isNil(var_420_28) and arg_417_1.var_.characterEffect6046_story then
				local var_420_33 = 0.5

				arg_417_1.var_.characterEffect6046_story.fillFlat = true
				arg_417_1.var_.characterEffect6046_story.fillRatio = var_420_33
			end

			local var_420_34 = 0
			local var_420_35 = 0.933333333333333

			if var_420_34 < arg_417_1.time_ and arg_417_1.time_ <= var_420_34 + arg_420_0 then
				local var_420_36 = "play"
				local var_420_37 = "effect"

				arg_417_1:AudioAction(var_420_36, var_420_37, "se_story_side_1042", "se_story_1042_stuck", "se_story_side_1042.awb")
			end

			local var_420_38 = 0
			local var_420_39 = 1

			if var_420_38 < arg_417_1.time_ and arg_417_1.time_ <= var_420_38 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_40 = arg_417_1:GetWordFromCfg(1104202104)
				local var_420_41 = arg_417_1:FormatText(var_420_40.content)

				arg_417_1.text_.text = var_420_41

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_42 = 40
				local var_420_43 = utf8.len(var_420_41)
				local var_420_44 = var_420_42 <= 0 and var_420_39 or var_420_39 * (var_420_43 / var_420_42)

				if var_420_44 > 0 and var_420_39 < var_420_44 then
					arg_417_1.talkMaxDuration = var_420_44

					if var_420_44 + var_420_38 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_44 + var_420_38
					end
				end

				arg_417_1.text_.text = var_420_41
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_45 = math.max(var_420_39, arg_417_1.talkMaxDuration)

			if var_420_38 <= arg_417_1.time_ and arg_417_1.time_ < var_420_38 + var_420_45 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_38) / var_420_45

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_38 + var_420_45 and arg_417_1.time_ < var_420_38 + var_420_45 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104202105 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104202105
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104202106(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["6046_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos6046_story = var_424_0.localPosition

				local var_424_2 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_2 then
					var_424_2:EnableDynamicBone(false)
				end
			end

			local var_424_3 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_3 then
				local var_424_4 = (arg_421_1.time_ - var_424_1) / var_424_3
				local var_424_5 = Vector3.New(0, -0.5, -6.3)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos6046_story, var_424_5, var_424_4)

				local var_424_6 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_6.x, var_424_6.y, var_424_6.z)

				local var_424_7 = var_424_0.localEulerAngles

				var_424_7.z = 0
				var_424_7.x = 0
				var_424_0.localEulerAngles = var_424_7
			end

			if arg_421_1.time_ >= var_424_1 + var_424_3 and arg_421_1.time_ < var_424_1 + var_424_3 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_424_8 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_8.x, var_424_8.y, var_424_8.z)

				local var_424_9 = var_424_0.localEulerAngles

				var_424_9.z = 0
				var_424_9.x = 0
				var_424_0.localEulerAngles = var_424_9

				local var_424_10 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_10 then
					var_424_10:EnableDynamicBone(true)
				end
			end

			local var_424_11 = arg_421_1.actors_["6046_story"]
			local var_424_12 = 0

			if var_424_12 < arg_421_1.time_ and arg_421_1.time_ <= var_424_12 + arg_424_0 and not isNil(var_424_11) and arg_421_1.var_.characterEffect6046_story == nil then
				arg_421_1.var_.characterEffect6046_story = var_424_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_13 = 0.200000002980232

			if var_424_12 <= arg_421_1.time_ and arg_421_1.time_ < var_424_12 + var_424_13 and not isNil(var_424_11) then
				local var_424_14 = (arg_421_1.time_ - var_424_12) / var_424_13

				if arg_421_1.var_.characterEffect6046_story and not isNil(var_424_11) then
					arg_421_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_12 + var_424_13 and arg_421_1.time_ < var_424_12 + var_424_13 + arg_424_0 and not isNil(var_424_11) and arg_421_1.var_.characterEffect6046_story then
				arg_421_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_424_15 = 0

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_424_16 = 0

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_424_17 = 0
			local var_424_18 = 0.1

			if var_424_17 < arg_421_1.time_ and arg_421_1.time_ <= var_424_17 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_19 = arg_421_1:FormatText(StoryNameCfg[214].name)

				arg_421_1.leftNameTxt_.text = var_424_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_20 = arg_421_1:GetWordFromCfg(1104202105)
				local var_424_21 = arg_421_1:FormatText(var_424_20.content)

				arg_421_1.text_.text = var_424_21

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_22 = 4
				local var_424_23 = utf8.len(var_424_21)
				local var_424_24 = var_424_22 <= 0 and var_424_18 or var_424_18 * (var_424_23 / var_424_22)

				if var_424_24 > 0 and var_424_18 < var_424_24 then
					arg_421_1.talkMaxDuration = var_424_24

					if var_424_24 + var_424_17 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_24 + var_424_17
					end
				end

				arg_421_1.text_.text = var_424_21
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202105", "story_v_side_new_1104202.awb") ~= 0 then
					local var_424_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202105", "story_v_side_new_1104202.awb") / 1000

					if var_424_25 + var_424_17 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_25 + var_424_17
					end

					if var_424_20.prefab_name ~= "" and arg_421_1.actors_[var_424_20.prefab_name] ~= nil then
						local var_424_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_20.prefab_name].transform, "story_v_side_new_1104202", "1104202105", "story_v_side_new_1104202.awb")

						arg_421_1:RecordAudio("1104202105", var_424_26)
						arg_421_1:RecordAudio("1104202105", var_424_26)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202105", "story_v_side_new_1104202.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202105", "story_v_side_new_1104202.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_27 = math.max(var_424_18, arg_421_1.talkMaxDuration)

			if var_424_17 <= arg_421_1.time_ and arg_421_1.time_ < var_424_17 + var_424_27 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_17) / var_424_27

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_17 + var_424_27 and arg_421_1.time_ < var_424_17 + var_424_27 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104202106 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104202106
		arg_425_1.duration_ = 3.7

		local var_425_0 = {
			ja = 3.666,
			ko = 3.7,
			zh = 3.7
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104202107(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["6046_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect6046_story == nil then
				arg_425_1.var_.characterEffect6046_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect6046_story and not isNil(var_428_0) then
					local var_428_4 = Mathf.Lerp(0, 0.5, var_428_3)

					arg_425_1.var_.characterEffect6046_story.fillFlat = true
					arg_425_1.var_.characterEffect6046_story.fillRatio = var_428_4
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect6046_story then
				local var_428_5 = 0.5

				arg_425_1.var_.characterEffect6046_story.fillFlat = true
				arg_425_1.var_.characterEffect6046_story.fillRatio = var_428_5
			end

			local var_428_6 = 0
			local var_428_7 = 0.45

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_8 = arg_425_1:FormatText(StoryNameCfg[444].name)

				arg_425_1.leftNameTxt_.text = var_428_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_9 = arg_425_1:GetWordFromCfg(1104202106)
				local var_428_10 = arg_425_1:FormatText(var_428_9.content)

				arg_425_1.text_.text = var_428_10

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 18
				local var_428_12 = utf8.len(var_428_10)
				local var_428_13 = var_428_11 <= 0 and var_428_7 or var_428_7 * (var_428_12 / var_428_11)

				if var_428_13 > 0 and var_428_7 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_10
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202106", "story_v_side_new_1104202.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202106", "story_v_side_new_1104202.awb") / 1000

					if var_428_14 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_6
					end

					if var_428_9.prefab_name ~= "" and arg_425_1.actors_[var_428_9.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_9.prefab_name].transform, "story_v_side_new_1104202", "1104202106", "story_v_side_new_1104202.awb")

						arg_425_1:RecordAudio("1104202106", var_428_15)
						arg_425_1:RecordAudio("1104202106", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202106", "story_v_side_new_1104202.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202106", "story_v_side_new_1104202.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_16 and arg_425_1.time_ < var_428_6 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104202107 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104202107
		arg_429_1.duration_ = 6.67

		local var_429_0 = {
			ja = 4.533,
			ko = 6.666,
			zh = 6.666
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104202108(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 0.7

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_2 = arg_429_1:FormatText(StoryNameCfg[444].name)

				arg_429_1.leftNameTxt_.text = var_432_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:GetWordFromCfg(1104202107)
				local var_432_4 = arg_429_1:FormatText(var_432_3.content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 28
				local var_432_6 = utf8.len(var_432_4)
				local var_432_7 = var_432_5 <= 0 and var_432_1 or var_432_1 * (var_432_6 / var_432_5)

				if var_432_7 > 0 and var_432_1 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202107", "story_v_side_new_1104202.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202107", "story_v_side_new_1104202.awb") / 1000

					if var_432_8 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_0
					end

					if var_432_3.prefab_name ~= "" and arg_429_1.actors_[var_432_3.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_3.prefab_name].transform, "story_v_side_new_1104202", "1104202107", "story_v_side_new_1104202.awb")

						arg_429_1:RecordAudio("1104202107", var_432_9)
						arg_429_1:RecordAudio("1104202107", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202107", "story_v_side_new_1104202.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202107", "story_v_side_new_1104202.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_10 and arg_429_1.time_ < var_432_0 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104202108 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104202108
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104202109(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["6046_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos6046_story = var_436_0.localPosition

				local var_436_2 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_2 then
					var_436_2:EnableDynamicBone(false)
				end
			end

			local var_436_3 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_3 then
				local var_436_4 = (arg_433_1.time_ - var_436_1) / var_436_3
				local var_436_5 = Vector3.New(0, 100, 0)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos6046_story, var_436_5, var_436_4)

				local var_436_6 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_6.x, var_436_6.y, var_436_6.z)

				local var_436_7 = var_436_0.localEulerAngles

				var_436_7.z = 0
				var_436_7.x = 0
				var_436_0.localEulerAngles = var_436_7
			end

			if arg_433_1.time_ >= var_436_1 + var_436_3 and arg_433_1.time_ < var_436_1 + var_436_3 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0, 100, 0)

				local var_436_8 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_8.x, var_436_8.y, var_436_8.z)

				local var_436_9 = var_436_0.localEulerAngles

				var_436_9.z = 0
				var_436_9.x = 0
				var_436_0.localEulerAngles = var_436_9

				local var_436_10 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_10 then
					var_436_10:EnableDynamicBone(true)
				end
			end

			local var_436_11 = arg_433_1.actors_["6045_story"]
			local var_436_12 = 0

			if var_436_12 < arg_433_1.time_ and arg_433_1.time_ <= var_436_12 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect6045_story == nil then
				arg_433_1.var_.characterEffect6045_story = var_436_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_13 = 0.200000002980232

			if var_436_12 <= arg_433_1.time_ and arg_433_1.time_ < var_436_12 + var_436_13 and not isNil(var_436_11) then
				local var_436_14 = (arg_433_1.time_ - var_436_12) / var_436_13

				if arg_433_1.var_.characterEffect6045_story and not isNil(var_436_11) then
					local var_436_15 = Mathf.Lerp(0, 0.5, var_436_14)

					arg_433_1.var_.characterEffect6045_story.fillFlat = true
					arg_433_1.var_.characterEffect6045_story.fillRatio = var_436_15
				end
			end

			if arg_433_1.time_ >= var_436_12 + var_436_13 and arg_433_1.time_ < var_436_12 + var_436_13 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect6045_story then
				local var_436_16 = 0.5

				arg_433_1.var_.characterEffect6045_story.fillFlat = true
				arg_433_1.var_.characterEffect6045_story.fillRatio = var_436_16
			end

			local var_436_17 = 0
			local var_436_18 = 1

			if var_436_17 < arg_433_1.time_ and arg_433_1.time_ <= var_436_17 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_19 = arg_433_1:GetWordFromCfg(1104202108)
				local var_436_20 = arg_433_1:FormatText(var_436_19.content)

				arg_433_1.text_.text = var_436_20

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_21 = 40
				local var_436_22 = utf8.len(var_436_20)
				local var_436_23 = var_436_21 <= 0 and var_436_18 or var_436_18 * (var_436_22 / var_436_21)

				if var_436_23 > 0 and var_436_18 < var_436_23 then
					arg_433_1.talkMaxDuration = var_436_23

					if var_436_23 + var_436_17 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_23 + var_436_17
					end
				end

				arg_433_1.text_.text = var_436_20
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_24 = math.max(var_436_18, arg_433_1.talkMaxDuration)

			if var_436_17 <= arg_433_1.time_ and arg_433_1.time_ < var_436_17 + var_436_24 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_17) / var_436_24

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_17 + var_436_24 and arg_433_1.time_ < var_436_17 + var_436_24 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104202109 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104202109
		arg_437_1.duration_ = 13.03

		local var_437_0 = {
			ja = 13.033,
			ko = 6.266,
			zh = 6.266
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104202110(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.75

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[444].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(1104202109)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 30
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202109", "story_v_side_new_1104202.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202109", "story_v_side_new_1104202.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_side_new_1104202", "1104202109", "story_v_side_new_1104202.awb")

						arg_437_1:RecordAudio("1104202109", var_440_9)
						arg_437_1:RecordAudio("1104202109", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202109", "story_v_side_new_1104202.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202109", "story_v_side_new_1104202.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104202110 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104202110
		arg_441_1.duration_ = 15.97

		local var_441_0 = {
			ja = 15.966,
			ko = 8.8,
			zh = 8.8
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104202111(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 1.05

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[444].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(1104202110)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 42
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202110", "story_v_side_new_1104202.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202110", "story_v_side_new_1104202.awb") / 1000

					if var_444_8 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_0
					end

					if var_444_3.prefab_name ~= "" and arg_441_1.actors_[var_444_3.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_3.prefab_name].transform, "story_v_side_new_1104202", "1104202110", "story_v_side_new_1104202.awb")

						arg_441_1:RecordAudio("1104202110", var_444_9)
						arg_441_1:RecordAudio("1104202110", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202110", "story_v_side_new_1104202.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202110", "story_v_side_new_1104202.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_10 and arg_441_1.time_ < var_444_0 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104202111 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104202111
		arg_445_1.duration_ = 5.93

		local var_445_0 = {
			ja = 5.933,
			ko = 4.233,
			zh = 4.233
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
				arg_445_0:Play1104202112(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.525

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[444].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(1104202111)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 21
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202111", "story_v_side_new_1104202.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202111", "story_v_side_new_1104202.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_side_new_1104202", "1104202111", "story_v_side_new_1104202.awb")

						arg_445_1:RecordAudio("1104202111", var_448_9)
						arg_445_1:RecordAudio("1104202111", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202111", "story_v_side_new_1104202.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202111", "story_v_side_new_1104202.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_10 and arg_445_1.time_ < var_448_0 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104202112 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104202112
		arg_449_1.duration_ = 5.1

		local var_449_0 = {
			ja = 5.1,
			ko = 4.966,
			zh = 4.966
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104202113(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["6046_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos6046_story = var_452_0.localPosition

				local var_452_2 = GameObjectTools.GetOrAddComponent(var_452_0.gameObject, typeof(DynamicBoneHelper))

				if var_452_2 then
					var_452_2:EnableDynamicBone(false)
				end
			end

			local var_452_3 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_3 then
				local var_452_4 = (arg_449_1.time_ - var_452_1) / var_452_3
				local var_452_5 = Vector3.New(0, -0.5, -6.3)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos6046_story, var_452_5, var_452_4)

				local var_452_6 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_6.x, var_452_6.y, var_452_6.z)

				local var_452_7 = var_452_0.localEulerAngles

				var_452_7.z = 0
				var_452_7.x = 0
				var_452_0.localEulerAngles = var_452_7
			end

			if arg_449_1.time_ >= var_452_1 + var_452_3 and arg_449_1.time_ < var_452_1 + var_452_3 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_452_8 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_8.x, var_452_8.y, var_452_8.z)

				local var_452_9 = var_452_0.localEulerAngles

				var_452_9.z = 0
				var_452_9.x = 0
				var_452_0.localEulerAngles = var_452_9

				local var_452_10 = GameObjectTools.GetOrAddComponent(var_452_0.gameObject, typeof(DynamicBoneHelper))

				if var_452_10 then
					var_452_10:EnableDynamicBone(true)
				end
			end

			local var_452_11 = arg_449_1.actors_["6046_story"]
			local var_452_12 = 0

			if var_452_12 < arg_449_1.time_ and arg_449_1.time_ <= var_452_12 + arg_452_0 and not isNil(var_452_11) and arg_449_1.var_.characterEffect6046_story == nil then
				arg_449_1.var_.characterEffect6046_story = var_452_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_13 = 0.200000002980232

			if var_452_12 <= arg_449_1.time_ and arg_449_1.time_ < var_452_12 + var_452_13 and not isNil(var_452_11) then
				local var_452_14 = (arg_449_1.time_ - var_452_12) / var_452_13

				if arg_449_1.var_.characterEffect6046_story and not isNil(var_452_11) then
					arg_449_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_12 + var_452_13 and arg_449_1.time_ < var_452_12 + var_452_13 + arg_452_0 and not isNil(var_452_11) and arg_449_1.var_.characterEffect6046_story then
				arg_449_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_452_15 = 0

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_452_16 = 0

			if var_452_16 < arg_449_1.time_ and arg_449_1.time_ <= var_452_16 + arg_452_0 then
				arg_449_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_17 = 0
			local var_452_18 = 0.475

			if var_452_17 < arg_449_1.time_ and arg_449_1.time_ <= var_452_17 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_19 = arg_449_1:FormatText(StoryNameCfg[214].name)

				arg_449_1.leftNameTxt_.text = var_452_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_20 = arg_449_1:GetWordFromCfg(1104202112)
				local var_452_21 = arg_449_1:FormatText(var_452_20.content)

				arg_449_1.text_.text = var_452_21

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_22 = 19
				local var_452_23 = utf8.len(var_452_21)
				local var_452_24 = var_452_22 <= 0 and var_452_18 or var_452_18 * (var_452_23 / var_452_22)

				if var_452_24 > 0 and var_452_18 < var_452_24 then
					arg_449_1.talkMaxDuration = var_452_24

					if var_452_24 + var_452_17 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_24 + var_452_17
					end
				end

				arg_449_1.text_.text = var_452_21
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202112", "story_v_side_new_1104202.awb") ~= 0 then
					local var_452_25 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202112", "story_v_side_new_1104202.awb") / 1000

					if var_452_25 + var_452_17 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_25 + var_452_17
					end

					if var_452_20.prefab_name ~= "" and arg_449_1.actors_[var_452_20.prefab_name] ~= nil then
						local var_452_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_20.prefab_name].transform, "story_v_side_new_1104202", "1104202112", "story_v_side_new_1104202.awb")

						arg_449_1:RecordAudio("1104202112", var_452_26)
						arg_449_1:RecordAudio("1104202112", var_452_26)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202112", "story_v_side_new_1104202.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202112", "story_v_side_new_1104202.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_27 = math.max(var_452_18, arg_449_1.talkMaxDuration)

			if var_452_17 <= arg_449_1.time_ and arg_449_1.time_ < var_452_17 + var_452_27 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_17) / var_452_27

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_17 + var_452_27 and arg_449_1.time_ < var_452_17 + var_452_27 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104202113 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104202113
		arg_453_1.duration_ = 8.7

		local var_453_0 = {
			ja = 4.266,
			ko = 8.7,
			zh = 8.7
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104202114(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.725

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[214].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:GetWordFromCfg(1104202113)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 29
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202113", "story_v_side_new_1104202.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202113", "story_v_side_new_1104202.awb") / 1000

					if var_456_8 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_0
					end

					if var_456_3.prefab_name ~= "" and arg_453_1.actors_[var_456_3.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_3.prefab_name].transform, "story_v_side_new_1104202", "1104202113", "story_v_side_new_1104202.awb")

						arg_453_1:RecordAudio("1104202113", var_456_9)
						arg_453_1:RecordAudio("1104202113", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202113", "story_v_side_new_1104202.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202113", "story_v_side_new_1104202.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_10 and arg_453_1.time_ < var_456_0 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104202114 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104202114
		arg_457_1.duration_ = 6

		local var_457_0 = {
			ja = 6,
			ko = 5.533,
			zh = 5.533
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104202115(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["6046_story"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect6046_story == nil then
				arg_457_1.var_.characterEffect6046_story = var_460_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.characterEffect6046_story and not isNil(var_460_0) then
					local var_460_4 = Mathf.Lerp(0, 0.5, var_460_3)

					arg_457_1.var_.characterEffect6046_story.fillFlat = true
					arg_457_1.var_.characterEffect6046_story.fillRatio = var_460_4
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect6046_story then
				local var_460_5 = 0.5

				arg_457_1.var_.characterEffect6046_story.fillFlat = true
				arg_457_1.var_.characterEffect6046_story.fillRatio = var_460_5
			end

			local var_460_6 = 0
			local var_460_7 = 0.7

			if var_460_6 < arg_457_1.time_ and arg_457_1.time_ <= var_460_6 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_8 = arg_457_1:FormatText(StoryNameCfg[444].name)

				arg_457_1.leftNameTxt_.text = var_460_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_9 = arg_457_1:GetWordFromCfg(1104202114)
				local var_460_10 = arg_457_1:FormatText(var_460_9.content)

				arg_457_1.text_.text = var_460_10

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 27
				local var_460_12 = utf8.len(var_460_10)
				local var_460_13 = var_460_11 <= 0 and var_460_7 or var_460_7 * (var_460_12 / var_460_11)

				if var_460_13 > 0 and var_460_7 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_6
					end
				end

				arg_457_1.text_.text = var_460_10
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202114", "story_v_side_new_1104202.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202114", "story_v_side_new_1104202.awb") / 1000

					if var_460_14 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_6
					end

					if var_460_9.prefab_name ~= "" and arg_457_1.actors_[var_460_9.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_9.prefab_name].transform, "story_v_side_new_1104202", "1104202114", "story_v_side_new_1104202.awb")

						arg_457_1:RecordAudio("1104202114", var_460_15)
						arg_457_1:RecordAudio("1104202114", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202114", "story_v_side_new_1104202.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202114", "story_v_side_new_1104202.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_7, arg_457_1.talkMaxDuration)

			if var_460_6 <= arg_457_1.time_ and arg_457_1.time_ < var_460_6 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_6) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_6 + var_460_16 and arg_457_1.time_ < var_460_6 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104202115 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104202115
		arg_461_1.duration_ = 9.6

		local var_461_0 = {
			ja = 9.6,
			ko = 4.3,
			zh = 4.3
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104202116(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.5

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[444].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(1104202115)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 20
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202115", "story_v_side_new_1104202.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202115", "story_v_side_new_1104202.awb") / 1000

					if var_464_8 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_0
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_side_new_1104202", "1104202115", "story_v_side_new_1104202.awb")

						arg_461_1:RecordAudio("1104202115", var_464_9)
						arg_461_1:RecordAudio("1104202115", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202115", "story_v_side_new_1104202.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202115", "story_v_side_new_1104202.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_10 and arg_461_1.time_ < var_464_0 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104202116 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104202116
		arg_465_1.duration_ = 11.57

		local var_465_0 = {
			ja = 4.633,
			ko = 11.566,
			zh = 11.566
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104202117(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["6046_story"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect6046_story == nil then
				arg_465_1.var_.characterEffect6046_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.characterEffect6046_story and not isNil(var_468_0) then
					arg_465_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect6046_story then
				arg_465_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_468_4 = 0

			if var_468_4 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			local var_468_5 = 0

			if var_468_5 < arg_465_1.time_ and arg_465_1.time_ <= var_468_5 + arg_468_0 then
				arg_465_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_468_6 = 0
			local var_468_7 = 1.075

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_8 = arg_465_1:FormatText(StoryNameCfg[214].name)

				arg_465_1.leftNameTxt_.text = var_468_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_9 = arg_465_1:GetWordFromCfg(1104202116)
				local var_468_10 = arg_465_1:FormatText(var_468_9.content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 43
				local var_468_12 = utf8.len(var_468_10)
				local var_468_13 = var_468_11 <= 0 and var_468_7 or var_468_7 * (var_468_12 / var_468_11)

				if var_468_13 > 0 and var_468_7 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202116", "story_v_side_new_1104202.awb") ~= 0 then
					local var_468_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202116", "story_v_side_new_1104202.awb") / 1000

					if var_468_14 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_14 + var_468_6
					end

					if var_468_9.prefab_name ~= "" and arg_465_1.actors_[var_468_9.prefab_name] ~= nil then
						local var_468_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_9.prefab_name].transform, "story_v_side_new_1104202", "1104202116", "story_v_side_new_1104202.awb")

						arg_465_1:RecordAudio("1104202116", var_468_15)
						arg_465_1:RecordAudio("1104202116", var_468_15)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202116", "story_v_side_new_1104202.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202116", "story_v_side_new_1104202.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_16 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_16 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_16

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_16 and arg_465_1.time_ < var_468_6 + var_468_16 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104202117 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104202117
		arg_469_1.duration_ = 6.4

		local var_469_0 = {
			ja = 5.433,
			ko = 6.4,
			zh = 6.4
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104202118(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["6046_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect6046_story == nil then
				arg_469_1.var_.characterEffect6046_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect6046_story and not isNil(var_472_0) then
					local var_472_4 = Mathf.Lerp(0, 0.5, var_472_3)

					arg_469_1.var_.characterEffect6046_story.fillFlat = true
					arg_469_1.var_.characterEffect6046_story.fillRatio = var_472_4
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect6046_story then
				local var_472_5 = 0.5

				arg_469_1.var_.characterEffect6046_story.fillFlat = true
				arg_469_1.var_.characterEffect6046_story.fillRatio = var_472_5
			end

			local var_472_6 = 0
			local var_472_7 = 0.7

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_8 = arg_469_1:FormatText(StoryNameCfg[444].name)

				arg_469_1.leftNameTxt_.text = var_472_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_9 = arg_469_1:GetWordFromCfg(1104202117)
				local var_472_10 = arg_469_1:FormatText(var_472_9.content)

				arg_469_1.text_.text = var_472_10

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 28
				local var_472_12 = utf8.len(var_472_10)
				local var_472_13 = var_472_11 <= 0 and var_472_7 or var_472_7 * (var_472_12 / var_472_11)

				if var_472_13 > 0 and var_472_7 < var_472_13 then
					arg_469_1.talkMaxDuration = var_472_13

					if var_472_13 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_13 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_10
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202117", "story_v_side_new_1104202.awb") ~= 0 then
					local var_472_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202117", "story_v_side_new_1104202.awb") / 1000

					if var_472_14 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_14 + var_472_6
					end

					if var_472_9.prefab_name ~= "" and arg_469_1.actors_[var_472_9.prefab_name] ~= nil then
						local var_472_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_9.prefab_name].transform, "story_v_side_new_1104202", "1104202117", "story_v_side_new_1104202.awb")

						arg_469_1:RecordAudio("1104202117", var_472_15)
						arg_469_1:RecordAudio("1104202117", var_472_15)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202117", "story_v_side_new_1104202.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202117", "story_v_side_new_1104202.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_16 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_16 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_16

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_16 and arg_469_1.time_ < var_472_6 + var_472_16 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104202118 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104202118
		arg_473_1.duration_ = 13.5

		local var_473_0 = {
			ja = 13.5,
			ko = 6.666,
			zh = 6.666
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104202119(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.775

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[444].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(1104202118)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 31
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202118", "story_v_side_new_1104202.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202118", "story_v_side_new_1104202.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_side_new_1104202", "1104202118", "story_v_side_new_1104202.awb")

						arg_473_1:RecordAudio("1104202118", var_476_9)
						arg_473_1:RecordAudio("1104202118", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202118", "story_v_side_new_1104202.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202118", "story_v_side_new_1104202.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104202119 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104202119
		arg_477_1.duration_ = 2.87

		local var_477_0 = {
			ja = 2.633,
			ko = 2.866,
			zh = 2.866
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104202120(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["6046_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect6046_story == nil then
				arg_477_1.var_.characterEffect6046_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect6046_story and not isNil(var_480_0) then
					arg_477_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect6046_story then
				arg_477_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_480_4 = 0

			if var_480_4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action435")
			end

			local var_480_5 = 0

			if var_480_5 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_6 = 0
			local var_480_7 = 0.225

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[214].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_9 = arg_477_1:GetWordFromCfg(1104202119)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 9
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202119", "story_v_side_new_1104202.awb") ~= 0 then
					local var_480_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202119", "story_v_side_new_1104202.awb") / 1000

					if var_480_14 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_14 + var_480_6
					end

					if var_480_9.prefab_name ~= "" and arg_477_1.actors_[var_480_9.prefab_name] ~= nil then
						local var_480_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_9.prefab_name].transform, "story_v_side_new_1104202", "1104202119", "story_v_side_new_1104202.awb")

						arg_477_1:RecordAudio("1104202119", var_480_15)
						arg_477_1:RecordAudio("1104202119", var_480_15)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202119", "story_v_side_new_1104202.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202119", "story_v_side_new_1104202.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_16 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_16 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_16

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_16 and arg_477_1.time_ < var_480_6 + var_480_16 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104202120 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104202120
		arg_481_1.duration_ = 10.2

		local var_481_0 = {
			ja = 5.832999999999,
			ko = 10.199999999999,
			zh = 10.199999999999
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104202121(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_1 = 2

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_1 then
				local var_484_2 = (arg_481_1.time_ - var_484_0) / var_484_1
				local var_484_3 = Color.New(0, 0, 0)

				var_484_3.a = Mathf.Lerp(0, 1, var_484_2)
				arg_481_1.mask_.color = var_484_3
			end

			if arg_481_1.time_ >= var_484_0 + var_484_1 and arg_481_1.time_ < var_484_0 + var_484_1 + arg_484_0 then
				local var_484_4 = Color.New(0, 0, 0)

				var_484_4.a = 1
				arg_481_1.mask_.color = var_484_4
			end

			local var_484_5 = 2

			if var_484_5 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_6 = 2

			if var_484_5 <= arg_481_1.time_ and arg_481_1.time_ < var_484_5 + var_484_6 then
				local var_484_7 = (arg_481_1.time_ - var_484_5) / var_484_6
				local var_484_8 = Color.New(0, 0, 0)

				var_484_8.a = Mathf.Lerp(1, 0, var_484_7)
				arg_481_1.mask_.color = var_484_8
			end

			if arg_481_1.time_ >= var_484_5 + var_484_6 and arg_481_1.time_ < var_484_5 + var_484_6 + arg_484_0 then
				local var_484_9 = Color.New(0, 0, 0)
				local var_484_10 = 0

				arg_481_1.mask_.enabled = false
				var_484_9.a = var_484_10
				arg_481_1.mask_.color = var_484_9
			end

			local var_484_11 = arg_481_1.actors_["6046_story"].transform
			local var_484_12 = 1.96599999815226

			if var_484_12 < arg_481_1.time_ and arg_481_1.time_ <= var_484_12 + arg_484_0 then
				arg_481_1.var_.moveOldPos6046_story = var_484_11.localPosition

				local var_484_13 = GameObjectTools.GetOrAddComponent(var_484_11.gameObject, typeof(DynamicBoneHelper))

				if var_484_13 then
					var_484_13:EnableDynamicBone(false)
				end
			end

			local var_484_14 = 0.001

			if var_484_12 <= arg_481_1.time_ and arg_481_1.time_ < var_484_12 + var_484_14 then
				local var_484_15 = (arg_481_1.time_ - var_484_12) / var_484_14
				local var_484_16 = Vector3.New(0, 100, 0)

				var_484_11.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos6046_story, var_484_16, var_484_15)

				local var_484_17 = manager.ui.mainCamera.transform.position - var_484_11.position

				var_484_11.forward = Vector3.New(var_484_17.x, var_484_17.y, var_484_17.z)

				local var_484_18 = var_484_11.localEulerAngles

				var_484_18.z = 0
				var_484_18.x = 0
				var_484_11.localEulerAngles = var_484_18
			end

			if arg_481_1.time_ >= var_484_12 + var_484_14 and arg_481_1.time_ < var_484_12 + var_484_14 + arg_484_0 then
				var_484_11.localPosition = Vector3.New(0, 100, 0)

				local var_484_19 = manager.ui.mainCamera.transform.position - var_484_11.position

				var_484_11.forward = Vector3.New(var_484_19.x, var_484_19.y, var_484_19.z)

				local var_484_20 = var_484_11.localEulerAngles

				var_484_20.z = 0
				var_484_20.x = 0
				var_484_11.localEulerAngles = var_484_20

				local var_484_21 = GameObjectTools.GetOrAddComponent(var_484_11.gameObject, typeof(DynamicBoneHelper))

				if var_484_21 then
					var_484_21:EnableDynamicBone(true)
				end
			end

			local var_484_22 = arg_481_1.actors_["6046_story"]
			local var_484_23 = 1.96599999815226

			if var_484_23 < arg_481_1.time_ and arg_481_1.time_ <= var_484_23 + arg_484_0 and not isNil(var_484_22) and arg_481_1.var_.characterEffect6046_story == nil then
				arg_481_1.var_.characterEffect6046_story = var_484_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_24 = 0.034000001847744

			if var_484_23 <= arg_481_1.time_ and arg_481_1.time_ < var_484_23 + var_484_24 and not isNil(var_484_22) then
				local var_484_25 = (arg_481_1.time_ - var_484_23) / var_484_24

				if arg_481_1.var_.characterEffect6046_story and not isNil(var_484_22) then
					local var_484_26 = Mathf.Lerp(0, 0.5, var_484_25)

					arg_481_1.var_.characterEffect6046_story.fillFlat = true
					arg_481_1.var_.characterEffect6046_story.fillRatio = var_484_26
				end
			end

			if arg_481_1.time_ >= var_484_23 + var_484_24 and arg_481_1.time_ < var_484_23 + var_484_24 + arg_484_0 and not isNil(var_484_22) and arg_481_1.var_.characterEffect6046_story then
				local var_484_27 = 0.5

				arg_481_1.var_.characterEffect6046_story.fillFlat = true
				arg_481_1.var_.characterEffect6046_story.fillRatio = var_484_27
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_28 = 3.999999999999
			local var_484_29 = 0.575

			if var_484_28 < arg_481_1.time_ and arg_481_1.time_ <= var_484_28 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_30 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_30:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_31 = arg_481_1:GetWordFromCfg(1104202120)
				local var_484_32 = arg_481_1:FormatText(var_484_31.content)

				arg_481_1.text_.text = var_484_32

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_33 = 23
				local var_484_34 = utf8.len(var_484_32)
				local var_484_35 = var_484_33 <= 0 and var_484_29 or var_484_29 * (var_484_34 / var_484_33)

				if var_484_35 > 0 and var_484_29 < var_484_35 then
					arg_481_1.talkMaxDuration = var_484_35
					var_484_28 = var_484_28 + 0.3

					if var_484_35 + var_484_28 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_35 + var_484_28
					end
				end

				arg_481_1.text_.text = var_484_32
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202120", "story_v_side_new_1104202.awb") ~= 0 then
					local var_484_36 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202120", "story_v_side_new_1104202.awb") / 1000

					if var_484_36 + var_484_28 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_36 + var_484_28
					end

					if var_484_31.prefab_name ~= "" and arg_481_1.actors_[var_484_31.prefab_name] ~= nil then
						local var_484_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_31.prefab_name].transform, "story_v_side_new_1104202", "1104202120", "story_v_side_new_1104202.awb")

						arg_481_1:RecordAudio("1104202120", var_484_37)
						arg_481_1:RecordAudio("1104202120", var_484_37)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202120", "story_v_side_new_1104202.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202120", "story_v_side_new_1104202.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_38 = var_484_28 + 0.3
			local var_484_39 = math.max(var_484_29, arg_481_1.talkMaxDuration)

			if var_484_38 <= arg_481_1.time_ and arg_481_1.time_ < var_484_38 + var_484_39 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_38) / var_484_39

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_38 + var_484_39 and arg_481_1.time_ < var_484_38 + var_484_39 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104202121 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1104202121
		arg_487_1.duration_ = 11.53

		local var_487_0 = {
			ja = 4.3,
			ko = 11.533,
			zh = 11.533
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1104202122(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["6045_story"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos6045_story = var_490_0.localPosition

				local var_490_2 = GameObjectTools.GetOrAddComponent(var_490_0.gameObject, typeof(DynamicBoneHelper))

				if var_490_2 then
					var_490_2:EnableDynamicBone(false)
				end
			end

			local var_490_3 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_3 then
				local var_490_4 = (arg_487_1.time_ - var_490_1) / var_490_3
				local var_490_5 = Vector3.New(0, -0.5, -6.3)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos6045_story, var_490_5, var_490_4)

				local var_490_6 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_6.x, var_490_6.y, var_490_6.z)

				local var_490_7 = var_490_0.localEulerAngles

				var_490_7.z = 0
				var_490_7.x = 0
				var_490_0.localEulerAngles = var_490_7
			end

			if arg_487_1.time_ >= var_490_1 + var_490_3 and arg_487_1.time_ < var_490_1 + var_490_3 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_490_8 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_8.x, var_490_8.y, var_490_8.z)

				local var_490_9 = var_490_0.localEulerAngles

				var_490_9.z = 0
				var_490_9.x = 0
				var_490_0.localEulerAngles = var_490_9

				local var_490_10 = GameObjectTools.GetOrAddComponent(var_490_0.gameObject, typeof(DynamicBoneHelper))

				if var_490_10 then
					var_490_10:EnableDynamicBone(true)
				end
			end

			local var_490_11 = arg_487_1.actors_["6045_story"]
			local var_490_12 = 0

			if var_490_12 < arg_487_1.time_ and arg_487_1.time_ <= var_490_12 + arg_490_0 and not isNil(var_490_11) and arg_487_1.var_.characterEffect6045_story == nil then
				arg_487_1.var_.characterEffect6045_story = var_490_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_13 = 0.200000002980232

			if var_490_12 <= arg_487_1.time_ and arg_487_1.time_ < var_490_12 + var_490_13 and not isNil(var_490_11) then
				local var_490_14 = (arg_487_1.time_ - var_490_12) / var_490_13

				if arg_487_1.var_.characterEffect6045_story and not isNil(var_490_11) then
					arg_487_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_12 + var_490_13 and arg_487_1.time_ < var_490_12 + var_490_13 + arg_490_0 and not isNil(var_490_11) and arg_487_1.var_.characterEffect6045_story then
				arg_487_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_490_15 = 0

			if var_490_15 < arg_487_1.time_ and arg_487_1.time_ <= var_490_15 + arg_490_0 then
				arg_487_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_490_16 = 0
			local var_490_17 = 0.675

			if var_490_16 < arg_487_1.time_ and arg_487_1.time_ <= var_490_16 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_18 = arg_487_1:FormatText(StoryNameCfg[215].name)

				arg_487_1.leftNameTxt_.text = var_490_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_19 = arg_487_1:GetWordFromCfg(1104202121)
				local var_490_20 = arg_487_1:FormatText(var_490_19.content)

				arg_487_1.text_.text = var_490_20

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_21 = 27
				local var_490_22 = utf8.len(var_490_20)
				local var_490_23 = var_490_21 <= 0 and var_490_17 or var_490_17 * (var_490_22 / var_490_21)

				if var_490_23 > 0 and var_490_17 < var_490_23 then
					arg_487_1.talkMaxDuration = var_490_23

					if var_490_23 + var_490_16 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_23 + var_490_16
					end
				end

				arg_487_1.text_.text = var_490_20
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202121", "story_v_side_new_1104202.awb") ~= 0 then
					local var_490_24 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202121", "story_v_side_new_1104202.awb") / 1000

					if var_490_24 + var_490_16 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_24 + var_490_16
					end

					if var_490_19.prefab_name ~= "" and arg_487_1.actors_[var_490_19.prefab_name] ~= nil then
						local var_490_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_19.prefab_name].transform, "story_v_side_new_1104202", "1104202121", "story_v_side_new_1104202.awb")

						arg_487_1:RecordAudio("1104202121", var_490_25)
						arg_487_1:RecordAudio("1104202121", var_490_25)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202121", "story_v_side_new_1104202.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202121", "story_v_side_new_1104202.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_26 = math.max(var_490_17, arg_487_1.talkMaxDuration)

			if var_490_16 <= arg_487_1.time_ and arg_487_1.time_ < var_490_16 + var_490_26 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_16) / var_490_26

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_16 + var_490_26 and arg_487_1.time_ < var_490_16 + var_490_26 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play1104202122 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1104202122
		arg_491_1.duration_ = 6.8

		local var_491_0 = {
			ja = 3.4,
			ko = 6.8,
			zh = 6.8
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1104202123(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["6045_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect6045_story == nil then
				arg_491_1.var_.characterEffect6045_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect6045_story and not isNil(var_494_0) then
					local var_494_4 = Mathf.Lerp(0, 0.5, var_494_3)

					arg_491_1.var_.characterEffect6045_story.fillFlat = true
					arg_491_1.var_.characterEffect6045_story.fillRatio = var_494_4
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect6045_story then
				local var_494_5 = 0.5

				arg_491_1.var_.characterEffect6045_story.fillFlat = true
				arg_491_1.var_.characterEffect6045_story.fillRatio = var_494_5
			end

			local var_494_6 = 0
			local var_494_7 = 0.675

			if var_494_6 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_8 = arg_491_1:FormatText(StoryNameCfg[444].name)

				arg_491_1.leftNameTxt_.text = var_494_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_9 = arg_491_1:GetWordFromCfg(1104202122)
				local var_494_10 = arg_491_1:FormatText(var_494_9.content)

				arg_491_1.text_.text = var_494_10

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 27
				local var_494_12 = utf8.len(var_494_10)
				local var_494_13 = var_494_11 <= 0 and var_494_7 or var_494_7 * (var_494_12 / var_494_11)

				if var_494_13 > 0 and var_494_7 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_10
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202122", "story_v_side_new_1104202.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202122", "story_v_side_new_1104202.awb") / 1000

					if var_494_14 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_6
					end

					if var_494_9.prefab_name ~= "" and arg_491_1.actors_[var_494_9.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_9.prefab_name].transform, "story_v_side_new_1104202", "1104202122", "story_v_side_new_1104202.awb")

						arg_491_1:RecordAudio("1104202122", var_494_15)
						arg_491_1:RecordAudio("1104202122", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202122", "story_v_side_new_1104202.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202122", "story_v_side_new_1104202.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_16 and arg_491_1.time_ < var_494_6 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1104202123 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1104202123
		arg_495_1.duration_ = 5.33

		local var_495_0 = {
			ja = 5.333,
			ko = 3.4,
			zh = 3.4
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1104202124(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["6045_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect6045_story == nil then
				arg_495_1.var_.characterEffect6045_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect6045_story and not isNil(var_498_0) then
					arg_495_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect6045_story then
				arg_495_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_498_4 = 0

			if var_498_4 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			local var_498_5 = 0

			if var_498_5 < arg_495_1.time_ and arg_495_1.time_ <= var_498_5 + arg_498_0 then
				arg_495_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_498_6 = 0
			local var_498_7 = 0.25

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_8 = arg_495_1:FormatText(StoryNameCfg[215].name)

				arg_495_1.leftNameTxt_.text = var_498_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_9 = arg_495_1:GetWordFromCfg(1104202123)
				local var_498_10 = arg_495_1:FormatText(var_498_9.content)

				arg_495_1.text_.text = var_498_10

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 10
				local var_498_12 = utf8.len(var_498_10)
				local var_498_13 = var_498_11 <= 0 and var_498_7 or var_498_7 * (var_498_12 / var_498_11)

				if var_498_13 > 0 and var_498_7 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_10
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202123", "story_v_side_new_1104202.awb") ~= 0 then
					local var_498_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202123", "story_v_side_new_1104202.awb") / 1000

					if var_498_14 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_14 + var_498_6
					end

					if var_498_9.prefab_name ~= "" and arg_495_1.actors_[var_498_9.prefab_name] ~= nil then
						local var_498_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_9.prefab_name].transform, "story_v_side_new_1104202", "1104202123", "story_v_side_new_1104202.awb")

						arg_495_1:RecordAudio("1104202123", var_498_15)
						arg_495_1:RecordAudio("1104202123", var_498_15)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202123", "story_v_side_new_1104202.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202123", "story_v_side_new_1104202.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_16 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_16 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_6) / var_498_16

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_6 + var_498_16 and arg_495_1.time_ < var_498_6 + var_498_16 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1104202124 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1104202124
		arg_499_1.duration_ = 9.23

		local var_499_0 = {
			ja = 8.466,
			ko = 9.233,
			zh = 9.233
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1104202125(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["6045_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect6045_story == nil then
				arg_499_1.var_.characterEffect6045_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect6045_story and not isNil(var_502_0) then
					local var_502_4 = Mathf.Lerp(0, 0.5, var_502_3)

					arg_499_1.var_.characterEffect6045_story.fillFlat = true
					arg_499_1.var_.characterEffect6045_story.fillRatio = var_502_4
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect6045_story then
				local var_502_5 = 0.5

				arg_499_1.var_.characterEffect6045_story.fillFlat = true
				arg_499_1.var_.characterEffect6045_story.fillRatio = var_502_5
			end

			local var_502_6 = 0
			local var_502_7 = 1.025

			if var_502_6 < arg_499_1.time_ and arg_499_1.time_ <= var_502_6 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_8 = arg_499_1:FormatText(StoryNameCfg[444].name)

				arg_499_1.leftNameTxt_.text = var_502_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_qq_1042")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_9 = arg_499_1:GetWordFromCfg(1104202124)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 41
				local var_502_12 = utf8.len(var_502_10)
				local var_502_13 = var_502_11 <= 0 and var_502_7 or var_502_7 * (var_502_12 / var_502_11)

				if var_502_13 > 0 and var_502_7 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_6
					end
				end

				arg_499_1.text_.text = var_502_10
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202124", "story_v_side_new_1104202.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202124", "story_v_side_new_1104202.awb") / 1000

					if var_502_14 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_6
					end

					if var_502_9.prefab_name ~= "" and arg_499_1.actors_[var_502_9.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_9.prefab_name].transform, "story_v_side_new_1104202", "1104202124", "story_v_side_new_1104202.awb")

						arg_499_1:RecordAudio("1104202124", var_502_15)
						arg_499_1:RecordAudio("1104202124", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202124", "story_v_side_new_1104202.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202124", "story_v_side_new_1104202.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_7, arg_499_1.talkMaxDuration)

			if var_502_6 <= arg_499_1.time_ and arg_499_1.time_ < var_502_6 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_6) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_6 + var_502_16 and arg_499_1.time_ < var_502_6 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1104202125 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1104202125
		arg_503_1.duration_ = 2.9

		local var_503_0 = {
			ja = 2.6,
			ko = 2.9,
			zh = 2.9
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1104202126(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["6045_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect6045_story == nil then
				arg_503_1.var_.characterEffect6045_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect6045_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect6045_story.fillFlat = true
					arg_503_1.var_.characterEffect6045_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect6045_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect6045_story.fillFlat = true
				arg_503_1.var_.characterEffect6045_story.fillRatio = var_506_5
			end

			local var_506_6 = 0

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_2")
			end

			local var_506_7 = arg_503_1.actors_["6046_story"]
			local var_506_8 = 0

			if var_506_8 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 and not isNil(var_506_7) and arg_503_1.var_.characterEffect6046_story == nil then
				arg_503_1.var_.characterEffect6046_story = var_506_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_9 = 0.200000002980232

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_9 and not isNil(var_506_7) then
				local var_506_10 = (arg_503_1.time_ - var_506_8) / var_506_9

				if arg_503_1.var_.characterEffect6046_story and not isNil(var_506_7) then
					arg_503_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_8 + var_506_9 and arg_503_1.time_ < var_506_8 + var_506_9 + arg_506_0 and not isNil(var_506_7) and arg_503_1.var_.characterEffect6046_story then
				arg_503_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_506_11 = arg_503_1.actors_["6046_story"].transform
			local var_506_12 = 0

			if var_506_12 < arg_503_1.time_ and arg_503_1.time_ <= var_506_12 + arg_506_0 then
				arg_503_1.var_.moveOldPos6046_story = var_506_11.localPosition

				local var_506_13 = GameObjectTools.GetOrAddComponent(var_506_11.gameObject, typeof(DynamicBoneHelper))

				if var_506_13 then
					var_506_13:EnableDynamicBone(false)
				end
			end

			local var_506_14 = 0.001

			if var_506_12 <= arg_503_1.time_ and arg_503_1.time_ < var_506_12 + var_506_14 then
				local var_506_15 = (arg_503_1.time_ - var_506_12) / var_506_14
				local var_506_16 = Vector3.New(0.7, -0.5, -6.3)

				var_506_11.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos6046_story, var_506_16, var_506_15)

				local var_506_17 = manager.ui.mainCamera.transform.position - var_506_11.position

				var_506_11.forward = Vector3.New(var_506_17.x, var_506_17.y, var_506_17.z)

				local var_506_18 = var_506_11.localEulerAngles

				var_506_18.z = 0
				var_506_18.x = 0
				var_506_11.localEulerAngles = var_506_18
			end

			if arg_503_1.time_ >= var_506_12 + var_506_14 and arg_503_1.time_ < var_506_12 + var_506_14 + arg_506_0 then
				var_506_11.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_506_19 = manager.ui.mainCamera.transform.position - var_506_11.position

				var_506_11.forward = Vector3.New(var_506_19.x, var_506_19.y, var_506_19.z)

				local var_506_20 = var_506_11.localEulerAngles

				var_506_20.z = 0
				var_506_20.x = 0
				var_506_11.localEulerAngles = var_506_20

				local var_506_21 = GameObjectTools.GetOrAddComponent(var_506_11.gameObject, typeof(DynamicBoneHelper))

				if var_506_21 then
					var_506_21:EnableDynamicBone(true)
				end
			end

			local var_506_22 = arg_503_1.actors_["6045_story"].transform
			local var_506_23 = 0

			if var_506_23 < arg_503_1.time_ and arg_503_1.time_ <= var_506_23 + arg_506_0 then
				arg_503_1.var_.moveOldPos6045_story = var_506_22.localPosition

				local var_506_24 = GameObjectTools.GetOrAddComponent(var_506_22.gameObject, typeof(DynamicBoneHelper))

				if var_506_24 then
					var_506_24:EnableDynamicBone(false)
				end
			end

			local var_506_25 = 0.001

			if var_506_23 <= arg_503_1.time_ and arg_503_1.time_ < var_506_23 + var_506_25 then
				local var_506_26 = (arg_503_1.time_ - var_506_23) / var_506_25
				local var_506_27 = Vector3.New(-0.7, -0.5, -6.3)

				var_506_22.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos6045_story, var_506_27, var_506_26)

				local var_506_28 = manager.ui.mainCamera.transform.position - var_506_22.position

				var_506_22.forward = Vector3.New(var_506_28.x, var_506_28.y, var_506_28.z)

				local var_506_29 = var_506_22.localEulerAngles

				var_506_29.z = 0
				var_506_29.x = 0
				var_506_22.localEulerAngles = var_506_29
			end

			if arg_503_1.time_ >= var_506_23 + var_506_25 and arg_503_1.time_ < var_506_23 + var_506_25 + arg_506_0 then
				var_506_22.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_506_30 = manager.ui.mainCamera.transform.position - var_506_22.position

				var_506_22.forward = Vector3.New(var_506_30.x, var_506_30.y, var_506_30.z)

				local var_506_31 = var_506_22.localEulerAngles

				var_506_31.z = 0
				var_506_31.x = 0
				var_506_22.localEulerAngles = var_506_31

				local var_506_32 = GameObjectTools.GetOrAddComponent(var_506_22.gameObject, typeof(DynamicBoneHelper))

				if var_506_32 then
					var_506_32:EnableDynamicBone(true)
				end
			end

			local var_506_33 = 0

			if var_506_33 < arg_503_1.time_ and arg_503_1.time_ <= var_506_33 + arg_506_0 then
				arg_503_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_506_34 = 0
			local var_506_35 = 0.2

			if var_506_34 < arg_503_1.time_ and arg_503_1.time_ <= var_506_34 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_36 = arg_503_1:FormatText(StoryNameCfg[214].name)

				arg_503_1.leftNameTxt_.text = var_506_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_37 = arg_503_1:GetWordFromCfg(1104202125)
				local var_506_38 = arg_503_1:FormatText(var_506_37.content)

				arg_503_1.text_.text = var_506_38

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_39 = 8
				local var_506_40 = utf8.len(var_506_38)
				local var_506_41 = var_506_39 <= 0 and var_506_35 or var_506_35 * (var_506_40 / var_506_39)

				if var_506_41 > 0 and var_506_35 < var_506_41 then
					arg_503_1.talkMaxDuration = var_506_41

					if var_506_41 + var_506_34 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_41 + var_506_34
					end
				end

				arg_503_1.text_.text = var_506_38
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202125", "story_v_side_new_1104202.awb") ~= 0 then
					local var_506_42 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202125", "story_v_side_new_1104202.awb") / 1000

					if var_506_42 + var_506_34 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_42 + var_506_34
					end

					if var_506_37.prefab_name ~= "" and arg_503_1.actors_[var_506_37.prefab_name] ~= nil then
						local var_506_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_37.prefab_name].transform, "story_v_side_new_1104202", "1104202125", "story_v_side_new_1104202.awb")

						arg_503_1:RecordAudio("1104202125", var_506_43)
						arg_503_1:RecordAudio("1104202125", var_506_43)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202125", "story_v_side_new_1104202.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202125", "story_v_side_new_1104202.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_44 = math.max(var_506_35, arg_503_1.talkMaxDuration)

			if var_506_34 <= arg_503_1.time_ and arg_503_1.time_ < var_506_34 + var_506_44 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_34) / var_506_44

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_34 + var_506_44 and arg_503_1.time_ < var_506_34 + var_506_44 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play1104202126 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1104202126
		arg_507_1.duration_ = 2.87

		local var_507_0 = {
			ja = 2.6,
			ko = 2.866,
			zh = 2.866
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1104202127(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["6045_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect6045_story == nil then
				arg_507_1.var_.characterEffect6045_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect6045_story and not isNil(var_510_0) then
					arg_507_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect6045_story then
				arg_507_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_510_4 = 0

			if var_510_4 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_510_5 = 0

			if var_510_5 < arg_507_1.time_ and arg_507_1.time_ <= var_510_5 + arg_510_0 then
				arg_507_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_510_6 = arg_507_1.actors_["6046_story"]
			local var_510_7 = 0

			if var_510_7 < arg_507_1.time_ and arg_507_1.time_ <= var_510_7 + arg_510_0 and not isNil(var_510_6) and arg_507_1.var_.characterEffect6046_story == nil then
				arg_507_1.var_.characterEffect6046_story = var_510_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_8 = 0.200000002980232

			if var_510_7 <= arg_507_1.time_ and arg_507_1.time_ < var_510_7 + var_510_8 and not isNil(var_510_6) then
				local var_510_9 = (arg_507_1.time_ - var_510_7) / var_510_8

				if arg_507_1.var_.characterEffect6046_story and not isNil(var_510_6) then
					local var_510_10 = Mathf.Lerp(0, 0.5, var_510_9)

					arg_507_1.var_.characterEffect6046_story.fillFlat = true
					arg_507_1.var_.characterEffect6046_story.fillRatio = var_510_10
				end
			end

			if arg_507_1.time_ >= var_510_7 + var_510_8 and arg_507_1.time_ < var_510_7 + var_510_8 + arg_510_0 and not isNil(var_510_6) and arg_507_1.var_.characterEffect6046_story then
				local var_510_11 = 0.5

				arg_507_1.var_.characterEffect6046_story.fillFlat = true
				arg_507_1.var_.characterEffect6046_story.fillRatio = var_510_11
			end

			local var_510_12 = 0
			local var_510_13 = 0.2

			if var_510_12 < arg_507_1.time_ and arg_507_1.time_ <= var_510_12 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_14 = arg_507_1:FormatText(StoryNameCfg[215].name)

				arg_507_1.leftNameTxt_.text = var_510_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_15 = arg_507_1:GetWordFromCfg(1104202126)
				local var_510_16 = arg_507_1:FormatText(var_510_15.content)

				arg_507_1.text_.text = var_510_16

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_17 = 8
				local var_510_18 = utf8.len(var_510_16)
				local var_510_19 = var_510_17 <= 0 and var_510_13 or var_510_13 * (var_510_18 / var_510_17)

				if var_510_19 > 0 and var_510_13 < var_510_19 then
					arg_507_1.talkMaxDuration = var_510_19

					if var_510_19 + var_510_12 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_19 + var_510_12
					end
				end

				arg_507_1.text_.text = var_510_16
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202126", "story_v_side_new_1104202.awb") ~= 0 then
					local var_510_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202126", "story_v_side_new_1104202.awb") / 1000

					if var_510_20 + var_510_12 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_20 + var_510_12
					end

					if var_510_15.prefab_name ~= "" and arg_507_1.actors_[var_510_15.prefab_name] ~= nil then
						local var_510_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_15.prefab_name].transform, "story_v_side_new_1104202", "1104202126", "story_v_side_new_1104202.awb")

						arg_507_1:RecordAudio("1104202126", var_510_21)
						arg_507_1:RecordAudio("1104202126", var_510_21)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202126", "story_v_side_new_1104202.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202126", "story_v_side_new_1104202.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_22 = math.max(var_510_13, arg_507_1.talkMaxDuration)

			if var_510_12 <= arg_507_1.time_ and arg_507_1.time_ < var_510_12 + var_510_22 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_12) / var_510_22

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_12 + var_510_22 and arg_507_1.time_ < var_510_12 + var_510_22 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1104202127 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1104202127
		arg_511_1.duration_ = 9

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1104202128(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_1 = 2

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_1 then
				local var_514_2 = (arg_511_1.time_ - var_514_0) / var_514_1
				local var_514_3 = Color.New(0, 0, 0)

				var_514_3.a = Mathf.Lerp(0, 1, var_514_2)
				arg_511_1.mask_.color = var_514_3
			end

			if arg_511_1.time_ >= var_514_0 + var_514_1 and arg_511_1.time_ < var_514_0 + var_514_1 + arg_514_0 then
				local var_514_4 = Color.New(0, 0, 0)

				var_514_4.a = 1
				arg_511_1.mask_.color = var_514_4
			end

			local var_514_5 = 2

			if var_514_5 < arg_511_1.time_ and arg_511_1.time_ <= var_514_5 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_6 = 2

			if var_514_5 <= arg_511_1.time_ and arg_511_1.time_ < var_514_5 + var_514_6 then
				local var_514_7 = (arg_511_1.time_ - var_514_5) / var_514_6
				local var_514_8 = Color.New(0, 0, 0)

				var_514_8.a = Mathf.Lerp(1, 0, var_514_7)
				arg_511_1.mask_.color = var_514_8
			end

			if arg_511_1.time_ >= var_514_5 + var_514_6 and arg_511_1.time_ < var_514_5 + var_514_6 + arg_514_0 then
				local var_514_9 = Color.New(0, 0, 0)
				local var_514_10 = 0

				arg_511_1.mask_.enabled = false
				var_514_9.a = var_514_10
				arg_511_1.mask_.color = var_514_9
			end

			local var_514_11 = arg_511_1.actors_["6045_story"].transform
			local var_514_12 = 1.96599999815226

			if var_514_12 < arg_511_1.time_ and arg_511_1.time_ <= var_514_12 + arg_514_0 then
				arg_511_1.var_.moveOldPos6045_story = var_514_11.localPosition

				local var_514_13 = GameObjectTools.GetOrAddComponent(var_514_11.gameObject, typeof(DynamicBoneHelper))

				if var_514_13 then
					var_514_13:EnableDynamicBone(false)
				end
			end

			local var_514_14 = 0.001

			if var_514_12 <= arg_511_1.time_ and arg_511_1.time_ < var_514_12 + var_514_14 then
				local var_514_15 = (arg_511_1.time_ - var_514_12) / var_514_14
				local var_514_16 = Vector3.New(0, 100, 0)

				var_514_11.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos6045_story, var_514_16, var_514_15)

				local var_514_17 = manager.ui.mainCamera.transform.position - var_514_11.position

				var_514_11.forward = Vector3.New(var_514_17.x, var_514_17.y, var_514_17.z)

				local var_514_18 = var_514_11.localEulerAngles

				var_514_18.z = 0
				var_514_18.x = 0
				var_514_11.localEulerAngles = var_514_18
			end

			if arg_511_1.time_ >= var_514_12 + var_514_14 and arg_511_1.time_ < var_514_12 + var_514_14 + arg_514_0 then
				var_514_11.localPosition = Vector3.New(0, 100, 0)

				local var_514_19 = manager.ui.mainCamera.transform.position - var_514_11.position

				var_514_11.forward = Vector3.New(var_514_19.x, var_514_19.y, var_514_19.z)

				local var_514_20 = var_514_11.localEulerAngles

				var_514_20.z = 0
				var_514_20.x = 0
				var_514_11.localEulerAngles = var_514_20

				local var_514_21 = GameObjectTools.GetOrAddComponent(var_514_11.gameObject, typeof(DynamicBoneHelper))

				if var_514_21 then
					var_514_21:EnableDynamicBone(true)
				end
			end

			local var_514_22 = arg_511_1.actors_["6045_story"]
			local var_514_23 = 1.96599999815226

			if var_514_23 < arg_511_1.time_ and arg_511_1.time_ <= var_514_23 + arg_514_0 and not isNil(var_514_22) and arg_511_1.var_.characterEffect6045_story == nil then
				arg_511_1.var_.characterEffect6045_story = var_514_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_24 = 0.034000001847744

			if var_514_23 <= arg_511_1.time_ and arg_511_1.time_ < var_514_23 + var_514_24 and not isNil(var_514_22) then
				local var_514_25 = (arg_511_1.time_ - var_514_23) / var_514_24

				if arg_511_1.var_.characterEffect6045_story and not isNil(var_514_22) then
					local var_514_26 = Mathf.Lerp(0, 0.5, var_514_25)

					arg_511_1.var_.characterEffect6045_story.fillFlat = true
					arg_511_1.var_.characterEffect6045_story.fillRatio = var_514_26
				end
			end

			if arg_511_1.time_ >= var_514_23 + var_514_24 and arg_511_1.time_ < var_514_23 + var_514_24 + arg_514_0 and not isNil(var_514_22) and arg_511_1.var_.characterEffect6045_story then
				local var_514_27 = 0.5

				arg_511_1.var_.characterEffect6045_story.fillFlat = true
				arg_511_1.var_.characterEffect6045_story.fillRatio = var_514_27
			end

			local var_514_28 = arg_511_1.actors_["6046_story"].transform
			local var_514_29 = 1.96599999815226

			if var_514_29 < arg_511_1.time_ and arg_511_1.time_ <= var_514_29 + arg_514_0 then
				arg_511_1.var_.moveOldPos6046_story = var_514_28.localPosition

				local var_514_30 = GameObjectTools.GetOrAddComponent(var_514_28.gameObject, typeof(DynamicBoneHelper))

				if var_514_30 then
					var_514_30:EnableDynamicBone(false)
				end
			end

			local var_514_31 = 0.001

			if var_514_29 <= arg_511_1.time_ and arg_511_1.time_ < var_514_29 + var_514_31 then
				local var_514_32 = (arg_511_1.time_ - var_514_29) / var_514_31
				local var_514_33 = Vector3.New(0, 100, 0)

				var_514_28.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos6046_story, var_514_33, var_514_32)

				local var_514_34 = manager.ui.mainCamera.transform.position - var_514_28.position

				var_514_28.forward = Vector3.New(var_514_34.x, var_514_34.y, var_514_34.z)

				local var_514_35 = var_514_28.localEulerAngles

				var_514_35.z = 0
				var_514_35.x = 0
				var_514_28.localEulerAngles = var_514_35
			end

			if arg_511_1.time_ >= var_514_29 + var_514_31 and arg_511_1.time_ < var_514_29 + var_514_31 + arg_514_0 then
				var_514_28.localPosition = Vector3.New(0, 100, 0)

				local var_514_36 = manager.ui.mainCamera.transform.position - var_514_28.position

				var_514_28.forward = Vector3.New(var_514_36.x, var_514_36.y, var_514_36.z)

				local var_514_37 = var_514_28.localEulerAngles

				var_514_37.z = 0
				var_514_37.x = 0
				var_514_28.localEulerAngles = var_514_37

				local var_514_38 = GameObjectTools.GetOrAddComponent(var_514_28.gameObject, typeof(DynamicBoneHelper))

				if var_514_38 then
					var_514_38:EnableDynamicBone(true)
				end
			end

			local var_514_39 = arg_511_1.actors_["6046_story"]
			local var_514_40 = 1.96599999815226

			if var_514_40 < arg_511_1.time_ and arg_511_1.time_ <= var_514_40 + arg_514_0 and not isNil(var_514_39) and arg_511_1.var_.characterEffect6046_story == nil then
				arg_511_1.var_.characterEffect6046_story = var_514_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_41 = 0.034000001847744

			if var_514_40 <= arg_511_1.time_ and arg_511_1.time_ < var_514_40 + var_514_41 and not isNil(var_514_39) then
				local var_514_42 = (arg_511_1.time_ - var_514_40) / var_514_41

				if arg_511_1.var_.characterEffect6046_story and not isNil(var_514_39) then
					local var_514_43 = Mathf.Lerp(0, 0.5, var_514_42)

					arg_511_1.var_.characterEffect6046_story.fillFlat = true
					arg_511_1.var_.characterEffect6046_story.fillRatio = var_514_43
				end
			end

			if arg_511_1.time_ >= var_514_40 + var_514_41 and arg_511_1.time_ < var_514_40 + var_514_41 + arg_514_0 and not isNil(var_514_39) and arg_511_1.var_.characterEffect6046_story then
				local var_514_44 = 0.5

				arg_511_1.var_.characterEffect6046_story.fillFlat = true
				arg_511_1.var_.characterEffect6046_story.fillRatio = var_514_44
			end

			if arg_511_1.frameCnt_ <= 1 then
				arg_511_1.dialog_:SetActive(false)
			end

			local var_514_45 = 4
			local var_514_46 = 0.25

			if var_514_45 < arg_511_1.time_ and arg_511_1.time_ <= var_514_45 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0

				arg_511_1.dialog_:SetActive(true)

				arg_511_1.dialogCg_.alpha = 0

				local var_514_47 = LeanTween.value(arg_511_1.dialog_, 0, 1, 0.3)

				var_514_47:setOnUpdate(LuaHelper.FloatAction(function(arg_515_0)
					arg_511_1.dialogCg_.alpha = arg_515_0
				end))
				var_514_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_511_1.dialog_)
					var_514_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_511_1.duration_ = arg_511_1.duration_ + 0.3

				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_48 = arg_511_1:GetWordFromCfg(1104202127)
				local var_514_49 = arg_511_1:FormatText(var_514_48.content)

				arg_511_1.text_.text = var_514_49

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_50 = 10
				local var_514_51 = utf8.len(var_514_49)
				local var_514_52 = var_514_50 <= 0 and var_514_46 or var_514_46 * (var_514_51 / var_514_50)

				if var_514_52 > 0 and var_514_46 < var_514_52 then
					arg_511_1.talkMaxDuration = var_514_52
					var_514_45 = var_514_45 + 0.3

					if var_514_52 + var_514_45 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_52 + var_514_45
					end
				end

				arg_511_1.text_.text = var_514_49
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_53 = var_514_45 + 0.3
			local var_514_54 = math.max(var_514_46, arg_511_1.talkMaxDuration)

			if var_514_53 <= arg_511_1.time_ and arg_511_1.time_ < var_514_53 + var_514_54 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_53) / var_514_54

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_53 + var_514_54 and arg_511_1.time_ < var_514_53 + var_514_54 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play1104202128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104202128
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104202129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.05

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1104202128)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 2
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
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104202129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104202129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104202130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.4

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

				local var_524_2 = arg_521_1:GetWordFromCfg(1104202129)
				local var_524_3 = arg_521_1:FormatText(var_524_2.content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 16
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
	Play1104202130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104202130
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1104202131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.95

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_2 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:GetWordFromCfg(1104202130)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 38
				local var_528_6 = utf8.len(var_528_4)
				local var_528_7 = var_528_5 <= 0 and var_528_1 or var_528_1 * (var_528_6 / var_528_5)

				if var_528_7 > 0 and var_528_1 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_8 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_8 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_8

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_8 and arg_525_1.time_ < var_528_0 + var_528_8 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1104202131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104202131
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1104202132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 0.925

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_2 = arg_529_1:FormatText(StoryNameCfg[7].name)

				arg_529_1.leftNameTxt_.text = var_532_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:GetWordFromCfg(1104202131)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 37
				local var_532_6 = utf8.len(var_532_4)
				local var_532_7 = var_532_5 <= 0 and var_532_1 or var_532_1 * (var_532_6 / var_532_5)

				if var_532_7 > 0 and var_532_1 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_8 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_8 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_8

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_8 and arg_529_1.time_ < var_532_0 + var_532_8 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104202132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1104202132
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1104202133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.775

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[7].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:GetWordFromCfg(1104202132)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 31
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_8 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_8 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_8

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_8 and arg_533_1.time_ < var_536_0 + var_536_8 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1104202133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1104202133
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1104202134(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.75

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(1104202133)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 30
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1104202134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1104202134
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1104202135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.7

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[7].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:GetWordFromCfg(1104202134)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 28
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_8 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_8 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_8

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_8 and arg_541_1.time_ < var_544_0 + var_544_8 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1104202135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1104202135
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1104202136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.325

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[7].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(1104202135)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 13
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_8 and arg_545_1.time_ < var_548_0 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1104202136 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104202136
		arg_549_1.duration_ = 7.07

		local var_549_0 = {
			ja = 7.066,
			ko = 5.1,
			zh = 5.1
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104202137(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["6045_story"].transform
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.var_.moveOldPos6045_story = var_552_0.localPosition

				local var_552_2 = GameObjectTools.GetOrAddComponent(var_552_0.gameObject, typeof(DynamicBoneHelper))

				if var_552_2 then
					var_552_2:EnableDynamicBone(false)
				end
			end

			local var_552_3 = 0.001

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_3 then
				local var_552_4 = (arg_549_1.time_ - var_552_1) / var_552_3
				local var_552_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_552_0.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos6045_story, var_552_5, var_552_4)

				local var_552_6 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_6.x, var_552_6.y, var_552_6.z)

				local var_552_7 = var_552_0.localEulerAngles

				var_552_7.z = 0
				var_552_7.x = 0
				var_552_0.localEulerAngles = var_552_7
			end

			if arg_549_1.time_ >= var_552_1 + var_552_3 and arg_549_1.time_ < var_552_1 + var_552_3 + arg_552_0 then
				var_552_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_552_8 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_8.x, var_552_8.y, var_552_8.z)

				local var_552_9 = var_552_0.localEulerAngles

				var_552_9.z = 0
				var_552_9.x = 0
				var_552_0.localEulerAngles = var_552_9

				local var_552_10 = GameObjectTools.GetOrAddComponent(var_552_0.gameObject, typeof(DynamicBoneHelper))

				if var_552_10 then
					var_552_10:EnableDynamicBone(true)
				end
			end

			local var_552_11 = arg_549_1.actors_["6045_story"]
			local var_552_12 = 0

			if var_552_12 < arg_549_1.time_ and arg_549_1.time_ <= var_552_12 + arg_552_0 and not isNil(var_552_11) and arg_549_1.var_.characterEffect6045_story == nil then
				arg_549_1.var_.characterEffect6045_story = var_552_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_13 = 0.200000002980232

			if var_552_12 <= arg_549_1.time_ and arg_549_1.time_ < var_552_12 + var_552_13 and not isNil(var_552_11) then
				local var_552_14 = (arg_549_1.time_ - var_552_12) / var_552_13

				if arg_549_1.var_.characterEffect6045_story and not isNil(var_552_11) then
					arg_549_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_12 + var_552_13 and arg_549_1.time_ < var_552_12 + var_552_13 + arg_552_0 and not isNil(var_552_11) and arg_549_1.var_.characterEffect6045_story then
				arg_549_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_552_15 = 0

			if var_552_15 < arg_549_1.time_ and arg_549_1.time_ <= var_552_15 + arg_552_0 then
				arg_549_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_552_16 = 0

			if var_552_16 < arg_549_1.time_ and arg_549_1.time_ <= var_552_16 + arg_552_0 then
				arg_549_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_552_17 = arg_549_1.actors_["6046_story"].transform
			local var_552_18 = 0

			if var_552_18 < arg_549_1.time_ and arg_549_1.time_ <= var_552_18 + arg_552_0 then
				arg_549_1.var_.moveOldPos6046_story = var_552_17.localPosition

				local var_552_19 = GameObjectTools.GetOrAddComponent(var_552_17.gameObject, typeof(DynamicBoneHelper))

				if var_552_19 then
					var_552_19:EnableDynamicBone(false)
				end
			end

			local var_552_20 = 0.001

			if var_552_18 <= arg_549_1.time_ and arg_549_1.time_ < var_552_18 + var_552_20 then
				local var_552_21 = (arg_549_1.time_ - var_552_18) / var_552_20
				local var_552_22 = Vector3.New(0.7, -0.5, -6.3)

				var_552_17.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos6046_story, var_552_22, var_552_21)

				local var_552_23 = manager.ui.mainCamera.transform.position - var_552_17.position

				var_552_17.forward = Vector3.New(var_552_23.x, var_552_23.y, var_552_23.z)

				local var_552_24 = var_552_17.localEulerAngles

				var_552_24.z = 0
				var_552_24.x = 0
				var_552_17.localEulerAngles = var_552_24
			end

			if arg_549_1.time_ >= var_552_18 + var_552_20 and arg_549_1.time_ < var_552_18 + var_552_20 + arg_552_0 then
				var_552_17.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_552_25 = manager.ui.mainCamera.transform.position - var_552_17.position

				var_552_17.forward = Vector3.New(var_552_25.x, var_552_25.y, var_552_25.z)

				local var_552_26 = var_552_17.localEulerAngles

				var_552_26.z = 0
				var_552_26.x = 0
				var_552_17.localEulerAngles = var_552_26

				local var_552_27 = GameObjectTools.GetOrAddComponent(var_552_17.gameObject, typeof(DynamicBoneHelper))

				if var_552_27 then
					var_552_27:EnableDynamicBone(true)
				end
			end

			local var_552_28 = arg_549_1.actors_["6046_story"]
			local var_552_29 = 0

			if var_552_29 < arg_549_1.time_ and arg_549_1.time_ <= var_552_29 + arg_552_0 and not isNil(var_552_28) and arg_549_1.var_.characterEffect6046_story == nil then
				arg_549_1.var_.characterEffect6046_story = var_552_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_30 = 0.200000002980232

			if var_552_29 <= arg_549_1.time_ and arg_549_1.time_ < var_552_29 + var_552_30 and not isNil(var_552_28) then
				local var_552_31 = (arg_549_1.time_ - var_552_29) / var_552_30

				if arg_549_1.var_.characterEffect6046_story and not isNil(var_552_28) then
					local var_552_32 = Mathf.Lerp(0, 0.5, var_552_31)

					arg_549_1.var_.characterEffect6046_story.fillFlat = true
					arg_549_1.var_.characterEffect6046_story.fillRatio = var_552_32
				end
			end

			if arg_549_1.time_ >= var_552_29 + var_552_30 and arg_549_1.time_ < var_552_29 + var_552_30 + arg_552_0 and not isNil(var_552_28) and arg_549_1.var_.characterEffect6046_story then
				local var_552_33 = 0.5

				arg_549_1.var_.characterEffect6046_story.fillFlat = true
				arg_549_1.var_.characterEffect6046_story.fillRatio = var_552_33
			end

			local var_552_34 = 0
			local var_552_35 = 0.475

			if var_552_34 < arg_549_1.time_ and arg_549_1.time_ <= var_552_34 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_36 = arg_549_1:FormatText(StoryNameCfg[215].name)

				arg_549_1.leftNameTxt_.text = var_552_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_37 = arg_549_1:GetWordFromCfg(1104202136)
				local var_552_38 = arg_549_1:FormatText(var_552_37.content)

				arg_549_1.text_.text = var_552_38

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_39 = 19
				local var_552_40 = utf8.len(var_552_38)
				local var_552_41 = var_552_39 <= 0 and var_552_35 or var_552_35 * (var_552_40 / var_552_39)

				if var_552_41 > 0 and var_552_35 < var_552_41 then
					arg_549_1.talkMaxDuration = var_552_41

					if var_552_41 + var_552_34 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_41 + var_552_34
					end
				end

				arg_549_1.text_.text = var_552_38
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202136", "story_v_side_new_1104202.awb") ~= 0 then
					local var_552_42 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202136", "story_v_side_new_1104202.awb") / 1000

					if var_552_42 + var_552_34 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_42 + var_552_34
					end

					if var_552_37.prefab_name ~= "" and arg_549_1.actors_[var_552_37.prefab_name] ~= nil then
						local var_552_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_37.prefab_name].transform, "story_v_side_new_1104202", "1104202136", "story_v_side_new_1104202.awb")

						arg_549_1:RecordAudio("1104202136", var_552_43)
						arg_549_1:RecordAudio("1104202136", var_552_43)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202136", "story_v_side_new_1104202.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202136", "story_v_side_new_1104202.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_44 = math.max(var_552_35, arg_549_1.talkMaxDuration)

			if var_552_34 <= arg_549_1.time_ and arg_549_1.time_ < var_552_34 + var_552_44 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_34) / var_552_44

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_34 + var_552_44 and arg_549_1.time_ < var_552_34 + var_552_44 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play1104202137 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104202137
		arg_553_1.duration_ = 11.2

		local var_553_0 = {
			ja = 11.2,
			ko = 10.066,
			zh = 10.066
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104202138(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["6046_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect6046_story == nil then
				arg_553_1.var_.characterEffect6046_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect6046_story and not isNil(var_556_0) then
					arg_553_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect6046_story then
				arg_553_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_556_4 = 0

			if var_556_4 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_556_5 = 0

			if var_556_5 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_556_6 = arg_553_1.actors_["6045_story"]
			local var_556_7 = 0

			if var_556_7 < arg_553_1.time_ and arg_553_1.time_ <= var_556_7 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect6045_story == nil then
				arg_553_1.var_.characterEffect6045_story = var_556_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_8 = 0.200000002980232

			if var_556_7 <= arg_553_1.time_ and arg_553_1.time_ < var_556_7 + var_556_8 and not isNil(var_556_6) then
				local var_556_9 = (arg_553_1.time_ - var_556_7) / var_556_8

				if arg_553_1.var_.characterEffect6045_story and not isNil(var_556_6) then
					local var_556_10 = Mathf.Lerp(0, 0.5, var_556_9)

					arg_553_1.var_.characterEffect6045_story.fillFlat = true
					arg_553_1.var_.characterEffect6045_story.fillRatio = var_556_10
				end
			end

			if arg_553_1.time_ >= var_556_7 + var_556_8 and arg_553_1.time_ < var_556_7 + var_556_8 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect6045_story then
				local var_556_11 = 0.5

				arg_553_1.var_.characterEffect6045_story.fillFlat = true
				arg_553_1.var_.characterEffect6045_story.fillRatio = var_556_11
			end

			local var_556_12 = 0
			local var_556_13 = 1

			if var_556_12 < arg_553_1.time_ and arg_553_1.time_ <= var_556_12 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_14 = arg_553_1:FormatText(StoryNameCfg[214].name)

				arg_553_1.leftNameTxt_.text = var_556_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_15 = arg_553_1:GetWordFromCfg(1104202137)
				local var_556_16 = arg_553_1:FormatText(var_556_15.content)

				arg_553_1.text_.text = var_556_16

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_17 = 40
				local var_556_18 = utf8.len(var_556_16)
				local var_556_19 = var_556_17 <= 0 and var_556_13 or var_556_13 * (var_556_18 / var_556_17)

				if var_556_19 > 0 and var_556_13 < var_556_19 then
					arg_553_1.talkMaxDuration = var_556_19

					if var_556_19 + var_556_12 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_19 + var_556_12
					end
				end

				arg_553_1.text_.text = var_556_16
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202137", "story_v_side_new_1104202.awb") ~= 0 then
					local var_556_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202137", "story_v_side_new_1104202.awb") / 1000

					if var_556_20 + var_556_12 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_20 + var_556_12
					end

					if var_556_15.prefab_name ~= "" and arg_553_1.actors_[var_556_15.prefab_name] ~= nil then
						local var_556_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_15.prefab_name].transform, "story_v_side_new_1104202", "1104202137", "story_v_side_new_1104202.awb")

						arg_553_1:RecordAudio("1104202137", var_556_21)
						arg_553_1:RecordAudio("1104202137", var_556_21)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202137", "story_v_side_new_1104202.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202137", "story_v_side_new_1104202.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_22 = math.max(var_556_13, arg_553_1.talkMaxDuration)

			if var_556_12 <= arg_553_1.time_ and arg_553_1.time_ < var_556_12 + var_556_22 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_12) / var_556_22

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_12 + var_556_22 and arg_553_1.time_ < var_556_12 + var_556_22 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1104202138 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104202138
		arg_557_1.duration_ = 10.4

		local var_557_0 = {
			ja = 9.7,
			ko = 10.4,
			zh = 10.4
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104202139(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 1.025

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[214].name)

				arg_557_1.leftNameTxt_.text = var_560_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_3 = arg_557_1:GetWordFromCfg(1104202138)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 41
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202138", "story_v_side_new_1104202.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202138", "story_v_side_new_1104202.awb") / 1000

					if var_560_8 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_0
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1104202", "1104202138", "story_v_side_new_1104202.awb")

						arg_557_1:RecordAudio("1104202138", var_560_9)
						arg_557_1:RecordAudio("1104202138", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202138", "story_v_side_new_1104202.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202138", "story_v_side_new_1104202.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_10 and arg_557_1.time_ < var_560_0 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1104202139 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104202139
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104202140(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["6046_story"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect6046_story == nil then
				arg_561_1.var_.characterEffect6046_story = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.characterEffect6046_story and not isNil(var_564_0) then
					local var_564_4 = Mathf.Lerp(0, 0.5, var_564_3)

					arg_561_1.var_.characterEffect6046_story.fillFlat = true
					arg_561_1.var_.characterEffect6046_story.fillRatio = var_564_4
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect6046_story then
				local var_564_5 = 0.5

				arg_561_1.var_.characterEffect6046_story.fillFlat = true
				arg_561_1.var_.characterEffect6046_story.fillRatio = var_564_5
			end

			local var_564_6 = 0
			local var_564_7 = 0.175

			if var_564_6 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_8 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_9 = arg_561_1:GetWordFromCfg(1104202139)
				local var_564_10 = arg_561_1:FormatText(var_564_9.content)

				arg_561_1.text_.text = var_564_10

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_11 = 7
				local var_564_12 = utf8.len(var_564_10)
				local var_564_13 = var_564_11 <= 0 and var_564_7 or var_564_7 * (var_564_12 / var_564_11)

				if var_564_13 > 0 and var_564_7 < var_564_13 then
					arg_561_1.talkMaxDuration = var_564_13

					if var_564_13 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_13 + var_564_6
					end
				end

				arg_561_1.text_.text = var_564_10
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_14 = math.max(var_564_7, arg_561_1.talkMaxDuration)

			if var_564_6 <= arg_561_1.time_ and arg_561_1.time_ < var_564_6 + var_564_14 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_6) / var_564_14

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_6 + var_564_14 and arg_561_1.time_ < var_564_6 + var_564_14 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104202140 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104202140
		arg_565_1.duration_ = 11.4

		local var_565_0 = {
			ja = 7.466,
			ko = 11.4,
			zh = 11.4
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104202141(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["6045_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect6045_story == nil then
				arg_565_1.var_.characterEffect6045_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect6045_story and not isNil(var_568_0) then
					arg_565_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect6045_story then
				arg_565_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_568_4 = 0

			if var_568_4 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_568_5 = 0

			if var_568_5 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_568_6 = arg_565_1.actors_["6046_story"]
			local var_568_7 = 0

			if var_568_7 < arg_565_1.time_ and arg_565_1.time_ <= var_568_7 + arg_568_0 and not isNil(var_568_6) and arg_565_1.var_.characterEffect6046_story == nil then
				arg_565_1.var_.characterEffect6046_story = var_568_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_8 = 0.200000002980232

			if var_568_7 <= arg_565_1.time_ and arg_565_1.time_ < var_568_7 + var_568_8 and not isNil(var_568_6) then
				local var_568_9 = (arg_565_1.time_ - var_568_7) / var_568_8

				if arg_565_1.var_.characterEffect6046_story and not isNil(var_568_6) then
					local var_568_10 = Mathf.Lerp(0, 0.5, var_568_9)

					arg_565_1.var_.characterEffect6046_story.fillFlat = true
					arg_565_1.var_.characterEffect6046_story.fillRatio = var_568_10
				end
			end

			if arg_565_1.time_ >= var_568_7 + var_568_8 and arg_565_1.time_ < var_568_7 + var_568_8 + arg_568_0 and not isNil(var_568_6) and arg_565_1.var_.characterEffect6046_story then
				local var_568_11 = 0.5

				arg_565_1.var_.characterEffect6046_story.fillFlat = true
				arg_565_1.var_.characterEffect6046_story.fillRatio = var_568_11
			end

			local var_568_12 = 0
			local var_568_13 = 1.025

			if var_568_12 < arg_565_1.time_ and arg_565_1.time_ <= var_568_12 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_14 = arg_565_1:FormatText(StoryNameCfg[215].name)

				arg_565_1.leftNameTxt_.text = var_568_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_15 = arg_565_1:GetWordFromCfg(1104202140)
				local var_568_16 = arg_565_1:FormatText(var_568_15.content)

				arg_565_1.text_.text = var_568_16

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_17 = 41
				local var_568_18 = utf8.len(var_568_16)
				local var_568_19 = var_568_17 <= 0 and var_568_13 or var_568_13 * (var_568_18 / var_568_17)

				if var_568_19 > 0 and var_568_13 < var_568_19 then
					arg_565_1.talkMaxDuration = var_568_19

					if var_568_19 + var_568_12 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_19 + var_568_12
					end
				end

				arg_565_1.text_.text = var_568_16
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202140", "story_v_side_new_1104202.awb") ~= 0 then
					local var_568_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202140", "story_v_side_new_1104202.awb") / 1000

					if var_568_20 + var_568_12 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_20 + var_568_12
					end

					if var_568_15.prefab_name ~= "" and arg_565_1.actors_[var_568_15.prefab_name] ~= nil then
						local var_568_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_15.prefab_name].transform, "story_v_side_new_1104202", "1104202140", "story_v_side_new_1104202.awb")

						arg_565_1:RecordAudio("1104202140", var_568_21)
						arg_565_1:RecordAudio("1104202140", var_568_21)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202140", "story_v_side_new_1104202.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202140", "story_v_side_new_1104202.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_22 = math.max(var_568_13, arg_565_1.talkMaxDuration)

			if var_568_12 <= arg_565_1.time_ and arg_565_1.time_ < var_568_12 + var_568_22 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_12) / var_568_22

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_12 + var_568_22 and arg_565_1.time_ < var_568_12 + var_568_22 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1104202141 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104202141
		arg_569_1.duration_ = 9.73

		local var_569_0 = {
			ja = 9.733,
			ko = 9.333,
			zh = 9.333
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1104202142(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["6046_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect6046_story == nil then
				arg_569_1.var_.characterEffect6046_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect6046_story and not isNil(var_572_0) then
					arg_569_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect6046_story then
				arg_569_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_572_4 = 0

			if var_572_4 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_572_5 = 0

			if var_572_5 < arg_569_1.time_ and arg_569_1.time_ <= var_572_5 + arg_572_0 then
				arg_569_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_572_6 = arg_569_1.actors_["6045_story"]
			local var_572_7 = 0

			if var_572_7 < arg_569_1.time_ and arg_569_1.time_ <= var_572_7 + arg_572_0 and not isNil(var_572_6) and arg_569_1.var_.characterEffect6045_story == nil then
				arg_569_1.var_.characterEffect6045_story = var_572_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_8 = 0.200000002980232

			if var_572_7 <= arg_569_1.time_ and arg_569_1.time_ < var_572_7 + var_572_8 and not isNil(var_572_6) then
				local var_572_9 = (arg_569_1.time_ - var_572_7) / var_572_8

				if arg_569_1.var_.characterEffect6045_story and not isNil(var_572_6) then
					local var_572_10 = Mathf.Lerp(0, 0.5, var_572_9)

					arg_569_1.var_.characterEffect6045_story.fillFlat = true
					arg_569_1.var_.characterEffect6045_story.fillRatio = var_572_10
				end
			end

			if arg_569_1.time_ >= var_572_7 + var_572_8 and arg_569_1.time_ < var_572_7 + var_572_8 + arg_572_0 and not isNil(var_572_6) and arg_569_1.var_.characterEffect6045_story then
				local var_572_11 = 0.5

				arg_569_1.var_.characterEffect6045_story.fillFlat = true
				arg_569_1.var_.characterEffect6045_story.fillRatio = var_572_11
			end

			local var_572_12 = 0
			local var_572_13 = 0.875

			if var_572_12 < arg_569_1.time_ and arg_569_1.time_ <= var_572_12 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_14 = arg_569_1:FormatText(StoryNameCfg[214].name)

				arg_569_1.leftNameTxt_.text = var_572_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_15 = arg_569_1:GetWordFromCfg(1104202141)
				local var_572_16 = arg_569_1:FormatText(var_572_15.content)

				arg_569_1.text_.text = var_572_16

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_17 = 35
				local var_572_18 = utf8.len(var_572_16)
				local var_572_19 = var_572_17 <= 0 and var_572_13 or var_572_13 * (var_572_18 / var_572_17)

				if var_572_19 > 0 and var_572_13 < var_572_19 then
					arg_569_1.talkMaxDuration = var_572_19

					if var_572_19 + var_572_12 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_19 + var_572_12
					end
				end

				arg_569_1.text_.text = var_572_16
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202141", "story_v_side_new_1104202.awb") ~= 0 then
					local var_572_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202141", "story_v_side_new_1104202.awb") / 1000

					if var_572_20 + var_572_12 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_20 + var_572_12
					end

					if var_572_15.prefab_name ~= "" and arg_569_1.actors_[var_572_15.prefab_name] ~= nil then
						local var_572_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_15.prefab_name].transform, "story_v_side_new_1104202", "1104202141", "story_v_side_new_1104202.awb")

						arg_569_1:RecordAudio("1104202141", var_572_21)
						arg_569_1:RecordAudio("1104202141", var_572_21)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202141", "story_v_side_new_1104202.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202141", "story_v_side_new_1104202.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_22 = math.max(var_572_13, arg_569_1.talkMaxDuration)

			if var_572_12 <= arg_569_1.time_ and arg_569_1.time_ < var_572_12 + var_572_22 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_12) / var_572_22

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_12 + var_572_22 and arg_569_1.time_ < var_572_12 + var_572_22 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1104202142 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104202142
		arg_573_1.duration_ = 7.47

		local var_573_0 = {
			ja = 7.466,
			ko = 4.866,
			zh = 4.866
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104202143(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["6045_story"]
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect6045_story == nil then
				arg_573_1.var_.characterEffect6045_story = var_576_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.200000002980232

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 and not isNil(var_576_0) then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2

				if arg_573_1.var_.characterEffect6045_story and not isNil(var_576_0) then
					arg_573_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect6045_story then
				arg_573_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_576_4 = 0

			if var_576_4 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_576_5 = 0

			if var_576_5 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_576_6 = arg_573_1.actors_["6046_story"]
			local var_576_7 = 0

			if var_576_7 < arg_573_1.time_ and arg_573_1.time_ <= var_576_7 + arg_576_0 and not isNil(var_576_6) and arg_573_1.var_.characterEffect6046_story == nil then
				arg_573_1.var_.characterEffect6046_story = var_576_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_8 = 0.200000002980232

			if var_576_7 <= arg_573_1.time_ and arg_573_1.time_ < var_576_7 + var_576_8 and not isNil(var_576_6) then
				local var_576_9 = (arg_573_1.time_ - var_576_7) / var_576_8

				if arg_573_1.var_.characterEffect6046_story and not isNil(var_576_6) then
					local var_576_10 = Mathf.Lerp(0, 0.5, var_576_9)

					arg_573_1.var_.characterEffect6046_story.fillFlat = true
					arg_573_1.var_.characterEffect6046_story.fillRatio = var_576_10
				end
			end

			if arg_573_1.time_ >= var_576_7 + var_576_8 and arg_573_1.time_ < var_576_7 + var_576_8 + arg_576_0 and not isNil(var_576_6) and arg_573_1.var_.characterEffect6046_story then
				local var_576_11 = 0.5

				arg_573_1.var_.characterEffect6046_story.fillFlat = true
				arg_573_1.var_.characterEffect6046_story.fillRatio = var_576_11
			end

			local var_576_12 = 0
			local var_576_13 = 0.45

			if var_576_12 < arg_573_1.time_ and arg_573_1.time_ <= var_576_12 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_14 = arg_573_1:FormatText(StoryNameCfg[215].name)

				arg_573_1.leftNameTxt_.text = var_576_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_15 = arg_573_1:GetWordFromCfg(1104202142)
				local var_576_16 = arg_573_1:FormatText(var_576_15.content)

				arg_573_1.text_.text = var_576_16

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_17 = 18
				local var_576_18 = utf8.len(var_576_16)
				local var_576_19 = var_576_17 <= 0 and var_576_13 or var_576_13 * (var_576_18 / var_576_17)

				if var_576_19 > 0 and var_576_13 < var_576_19 then
					arg_573_1.talkMaxDuration = var_576_19

					if var_576_19 + var_576_12 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_19 + var_576_12
					end
				end

				arg_573_1.text_.text = var_576_16
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202142", "story_v_side_new_1104202.awb") ~= 0 then
					local var_576_20 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202142", "story_v_side_new_1104202.awb") / 1000

					if var_576_20 + var_576_12 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_20 + var_576_12
					end

					if var_576_15.prefab_name ~= "" and arg_573_1.actors_[var_576_15.prefab_name] ~= nil then
						local var_576_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_15.prefab_name].transform, "story_v_side_new_1104202", "1104202142", "story_v_side_new_1104202.awb")

						arg_573_1:RecordAudio("1104202142", var_576_21)
						arg_573_1:RecordAudio("1104202142", var_576_21)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202142", "story_v_side_new_1104202.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202142", "story_v_side_new_1104202.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_22 = math.max(var_576_13, arg_573_1.talkMaxDuration)

			if var_576_12 <= arg_573_1.time_ and arg_573_1.time_ < var_576_12 + var_576_22 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_12) / var_576_22

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_12 + var_576_22 and arg_573_1.time_ < var_576_12 + var_576_22 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1104202143 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104202143
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104202144(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["6045_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect6045_story == nil then
				arg_577_1.var_.characterEffect6045_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect6045_story and not isNil(var_580_0) then
					local var_580_4 = Mathf.Lerp(0, 0.5, var_580_3)

					arg_577_1.var_.characterEffect6045_story.fillFlat = true
					arg_577_1.var_.characterEffect6045_story.fillRatio = var_580_4
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect6045_story then
				local var_580_5 = 0.5

				arg_577_1.var_.characterEffect6045_story.fillFlat = true
				arg_577_1.var_.characterEffect6045_story.fillRatio = var_580_5
			end

			local var_580_6 = 0
			local var_580_7 = 0.2

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_8 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_9 = arg_577_1:GetWordFromCfg(1104202143)
				local var_580_10 = arg_577_1:FormatText(var_580_9.content)

				arg_577_1.text_.text = var_580_10

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 8
				local var_580_12 = utf8.len(var_580_10)
				local var_580_13 = var_580_11 <= 0 and var_580_7 or var_580_7 * (var_580_12 / var_580_11)

				if var_580_13 > 0 and var_580_7 < var_580_13 then
					arg_577_1.talkMaxDuration = var_580_13

					if var_580_13 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_13 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_10
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_14 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_14 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_14

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_14 and arg_577_1.time_ < var_580_6 + var_580_14 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104202144 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104202144
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1104202145(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 0.875

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, false)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_2 = arg_581_1:GetWordFromCfg(1104202144)
				local var_584_3 = arg_581_1:FormatText(var_584_2.content)

				arg_581_1.text_.text = var_584_3

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_4 = 35
				local var_584_5 = utf8.len(var_584_3)
				local var_584_6 = var_584_4 <= 0 and var_584_1 or var_584_1 * (var_584_5 / var_584_4)

				if var_584_6 > 0 and var_584_1 < var_584_6 then
					arg_581_1.talkMaxDuration = var_584_6

					if var_584_6 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_6 + var_584_0
					end
				end

				arg_581_1.text_.text = var_584_3
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_1, arg_581_1.talkMaxDuration)

			if var_584_0 <= arg_581_1.time_ and arg_581_1.time_ < var_584_0 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_0) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_0 + var_584_7 and arg_581_1.time_ < var_584_0 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1104202145 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104202145
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104202146(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.35

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:GetWordFromCfg(1104202145)
				local var_588_3 = arg_585_1:FormatText(var_588_2.content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 14
				local var_588_5 = utf8.len(var_588_3)
				local var_588_6 = var_588_4 <= 0 and var_588_1 or var_588_1 * (var_588_5 / var_588_4)

				if var_588_6 > 0 and var_588_1 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_7 and arg_585_1.time_ < var_588_0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104202146 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104202146
		arg_589_1.duration_ = 8.07

		local var_589_0 = {
			ja = 8.066,
			ko = 5.066,
			zh = 5.066
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104202147(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["6046_story"]
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect6046_story == nil then
				arg_589_1.var_.characterEffect6046_story = var_592_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_2 = 0.200000002980232

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 and not isNil(var_592_0) then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2

				if arg_589_1.var_.characterEffect6046_story and not isNil(var_592_0) then
					arg_589_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect6046_story then
				arg_589_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_592_4 = 0

			if var_592_4 < arg_589_1.time_ and arg_589_1.time_ <= var_592_4 + arg_592_0 then
				arg_589_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_592_5 = 0

			if var_592_5 < arg_589_1.time_ and arg_589_1.time_ <= var_592_5 + arg_592_0 then
				arg_589_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_592_6 = 0
			local var_592_7 = 0.525

			if var_592_6 < arg_589_1.time_ and arg_589_1.time_ <= var_592_6 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_8 = arg_589_1:FormatText(StoryNameCfg[214].name)

				arg_589_1.leftNameTxt_.text = var_592_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_9 = arg_589_1:GetWordFromCfg(1104202146)
				local var_592_10 = arg_589_1:FormatText(var_592_9.content)

				arg_589_1.text_.text = var_592_10

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_11 = 21
				local var_592_12 = utf8.len(var_592_10)
				local var_592_13 = var_592_11 <= 0 and var_592_7 or var_592_7 * (var_592_12 / var_592_11)

				if var_592_13 > 0 and var_592_7 < var_592_13 then
					arg_589_1.talkMaxDuration = var_592_13

					if var_592_13 + var_592_6 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_13 + var_592_6
					end
				end

				arg_589_1.text_.text = var_592_10
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202146", "story_v_side_new_1104202.awb") ~= 0 then
					local var_592_14 = manager.audio:GetVoiceLength("story_v_side_new_1104202", "1104202146", "story_v_side_new_1104202.awb") / 1000

					if var_592_14 + var_592_6 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_14 + var_592_6
					end

					if var_592_9.prefab_name ~= "" and arg_589_1.actors_[var_592_9.prefab_name] ~= nil then
						local var_592_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_9.prefab_name].transform, "story_v_side_new_1104202", "1104202146", "story_v_side_new_1104202.awb")

						arg_589_1:RecordAudio("1104202146", var_592_15)
						arg_589_1:RecordAudio("1104202146", var_592_15)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_new_1104202", "1104202146", "story_v_side_new_1104202.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_new_1104202", "1104202146", "story_v_side_new_1104202.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_16 = math.max(var_592_7, arg_589_1.talkMaxDuration)

			if var_592_6 <= arg_589_1.time_ and arg_589_1.time_ < var_592_6 + var_592_16 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_6) / var_592_16

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_6 + var_592_16 and arg_589_1.time_ < var_592_6 + var_592_16 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104202147 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104202147
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104202148(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["6046_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect6046_story == nil then
				arg_593_1.var_.characterEffect6046_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect6046_story and not isNil(var_596_0) then
					local var_596_4 = Mathf.Lerp(0, 0.5, var_596_3)

					arg_593_1.var_.characterEffect6046_story.fillFlat = true
					arg_593_1.var_.characterEffect6046_story.fillRatio = var_596_4
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect6046_story then
				local var_596_5 = 0.5

				arg_593_1.var_.characterEffect6046_story.fillFlat = true
				arg_593_1.var_.characterEffect6046_story.fillRatio = var_596_5
			end

			local var_596_6 = 0
			local var_596_7 = 0.275

			if var_596_6 < arg_593_1.time_ and arg_593_1.time_ <= var_596_6 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_8 = arg_593_1:FormatText(StoryNameCfg[7].name)

				arg_593_1.leftNameTxt_.text = var_596_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_9 = arg_593_1:GetWordFromCfg(1104202147)
				local var_596_10 = arg_593_1:FormatText(var_596_9.content)

				arg_593_1.text_.text = var_596_10

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_11 = 11
				local var_596_12 = utf8.len(var_596_10)
				local var_596_13 = var_596_11 <= 0 and var_596_7 or var_596_7 * (var_596_12 / var_596_11)

				if var_596_13 > 0 and var_596_7 < var_596_13 then
					arg_593_1.talkMaxDuration = var_596_13

					if var_596_13 + var_596_6 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_13 + var_596_6
					end
				end

				arg_593_1.text_.text = var_596_10
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_14 = math.max(var_596_7, arg_593_1.talkMaxDuration)

			if var_596_6 <= arg_593_1.time_ and arg_593_1.time_ < var_596_6 + var_596_14 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_6) / var_596_14

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_6 + var_596_14 and arg_593_1.time_ < var_596_6 + var_596_14 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104202148 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104202148
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
			arg_597_1.auto_ = false
		end

		function arg_597_1.playNext_(arg_599_0)
			arg_597_1.onStoryFinished_()
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			local var_600_1 = 0
			local var_600_2 = 1

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				local var_600_3 = "play"
				local var_600_4 = "effect"

				arg_597_1:AudioAction(var_600_3, var_600_4, "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_600_5 = 0
			local var_600_6 = 0.65

			if var_600_5 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_7 = arg_597_1:GetWordFromCfg(1104202148)
				local var_600_8 = arg_597_1:FormatText(var_600_7.content)

				arg_597_1.text_.text = var_600_8

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_9 = 26
				local var_600_10 = utf8.len(var_600_8)
				local var_600_11 = var_600_9 <= 0 and var_600_6 or var_600_6 * (var_600_10 / var_600_9)

				if var_600_11 > 0 and var_600_6 < var_600_11 then
					arg_597_1.talkMaxDuration = var_600_11

					if var_600_11 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_11 + var_600_5
					end
				end

				arg_597_1.text_.text = var_600_8
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_12 = math.max(var_600_6, arg_597_1.talkMaxDuration)

			if var_600_5 <= arg_597_1.time_ and arg_597_1.time_ < var_600_5 + var_600_12 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_5) / var_600_12

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_5 + var_600_12 and arg_597_1.time_ < var_600_5 + var_600_12 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1104202.awb"
	}
}
