return {
	Play319791001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319791001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319791002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST72"

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
				local var_4_5 = arg_1_1.bgs_.ST72

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
					if iter_4_0 ~= "ST72" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.233333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.125

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[698].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(319791001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 5
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319791002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319791002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319791003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.425

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

				local var_12_2 = arg_9_1:GetWordFromCfg(319791002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 57
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
	Play319791003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319791003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319791004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.775

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[698].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(319791003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 31
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
	Play319791004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319791004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319791005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.625

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[698].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(319791004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 25
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
	Play319791005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319791005
		arg_21_1.duration_ = 4.07

		local var_21_0 = {
			zh = 3.33300000298023,
			ja = 4.06600000298023
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
				arg_21_0:Play319791006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1084ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_5.localPosition

				local var_24_7 = "1084ui_story"

				arg_21_1:ShowWeapon(arg_21_1.var_[var_24_7 .. "Animator"].transform, false)
			end

			local var_24_8 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_6) / var_24_8
				local var_24_10 = Vector3.New(0, -0.97, -6)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_10, var_24_9)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_5.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_5.localEulerAngles = var_24_12
			end

			if arg_21_1.time_ >= var_24_6 + var_24_8 and arg_21_1.time_ < var_24_6 + var_24_8 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_24_13 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_13.x, var_24_13.y, var_24_13.z)

				local var_24_14 = var_24_5.localEulerAngles

				var_24_14.z = 0
				var_24_14.x = 0
				var_24_5.localEulerAngles = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["1084ui_story"]
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_17 = 0.200000002980232

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 and not isNil(var_24_15) then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_15) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_21 = 0.200000002980232
			local var_24_22 = 0.3

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_23 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_23:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_24 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_25 = arg_21_1:GetWordFromCfg(319791005)
				local var_24_26 = arg_21_1:FormatText(var_24_25.content)

				arg_21_1.text_.text = var_24_26

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_27 = 12
				local var_24_28 = utf8.len(var_24_26)
				local var_24_29 = var_24_27 <= 0 and var_24_22 or var_24_22 * (var_24_28 / var_24_27)

				if var_24_29 > 0 and var_24_22 < var_24_29 then
					arg_21_1.talkMaxDuration = var_24_29
					var_24_21 = var_24_21 + 0.3

					if var_24_29 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_21
					end
				end

				arg_21_1.text_.text = var_24_26
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791005", "story_v_out_319791.awb") ~= 0 then
					local var_24_30 = manager.audio:GetVoiceLength("story_v_out_319791", "319791005", "story_v_out_319791.awb") / 1000

					if var_24_30 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_21
					end

					if var_24_25.prefab_name ~= "" and arg_21_1.actors_[var_24_25.prefab_name] ~= nil then
						local var_24_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_25.prefab_name].transform, "story_v_out_319791", "319791005", "story_v_out_319791.awb")

						arg_21_1:RecordAudio("319791005", var_24_31)
						arg_21_1:RecordAudio("319791005", var_24_31)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319791", "319791005", "story_v_out_319791.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319791", "319791005", "story_v_out_319791.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_32 = var_24_21 + 0.3
			local var_24_33 = math.max(var_24_22, arg_21_1.talkMaxDuration)

			if var_24_32 <= arg_21_1.time_ and arg_21_1.time_ < var_24_32 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_32) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_32 + var_24_33 and arg_21_1.time_ < var_24_32 + var_24_33 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319791006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play319791007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1084ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1084ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1084ui_story.fillRatio = var_30_5
			end

			local var_30_6 = 0
			local var_30_7 = 0.325

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_8 = arg_27_1:FormatText(StoryNameCfg[698].name)

				arg_27_1.leftNameTxt_.text = var_30_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_9 = arg_27_1:GetWordFromCfg(319791006)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 13
				local var_30_12 = utf8.len(var_30_10)
				local var_30_13 = var_30_11 <= 0 and var_30_7 or var_30_7 * (var_30_12 / var_30_11)

				if var_30_13 > 0 and var_30_7 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play319791007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319791007
		arg_31_1.duration_ = 1.97

		local var_31_0 = {
			zh = 0.999999999999,
			ja = 1.966
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319791008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = "1095ui_story"

			if arg_31_1.actors_[var_34_0] == nil then
				local var_34_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_34_1) then
					local var_34_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_31_1.stage_.transform)

					var_34_2.name = var_34_0
					var_34_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_31_1.actors_[var_34_0] = var_34_2

					local var_34_3 = var_34_2:GetComponentInChildren(typeof(CharacterEffect))

					var_34_3.enabled = true

					local var_34_4 = GameObjectTools.GetOrAddComponent(var_34_2, typeof(DynamicBoneHelper))

					if var_34_4 then
						var_34_4:EnableDynamicBone(false)
					end

					arg_31_1:ShowWeapon(var_34_3.transform, false)

					arg_31_1.var_[var_34_0 .. "Animator"] = var_34_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_31_1.var_[var_34_0 .. "Animator"].applyRootMotion = true
					arg_31_1.var_[var_34_0 .. "LipSync"] = var_34_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_34_5 = arg_31_1.actors_["1095ui_story"].transform
			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.var_.moveOldPos1095ui_story = var_34_5.localPosition
			end

			local var_34_7 = 0.001

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_7 then
				local var_34_8 = (arg_31_1.time_ - var_34_6) / var_34_7
				local var_34_9 = Vector3.New(0.7, -0.98, -6.1)

				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1095ui_story, var_34_9, var_34_8)

				local var_34_10 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_10.x, var_34_10.y, var_34_10.z)

				local var_34_11 = var_34_5.localEulerAngles

				var_34_11.z = 0
				var_34_11.x = 0
				var_34_5.localEulerAngles = var_34_11
			end

			if arg_31_1.time_ >= var_34_6 + var_34_7 and arg_31_1.time_ < var_34_6 + var_34_7 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_34_12 = manager.ui.mainCamera.transform.position - var_34_5.position

				var_34_5.forward = Vector3.New(var_34_12.x, var_34_12.y, var_34_12.z)

				local var_34_13 = var_34_5.localEulerAngles

				var_34_13.z = 0
				var_34_13.x = 0
				var_34_5.localEulerAngles = var_34_13
			end

			local var_34_14 = arg_31_1.actors_["1095ui_story"]
			local var_34_15 = 0

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 and not isNil(var_34_14) and arg_31_1.var_.characterEffect1095ui_story == nil then
				arg_31_1.var_.characterEffect1095ui_story = var_34_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_16 = 0.200000002980232

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_16 and not isNil(var_34_14) then
				local var_34_17 = (arg_31_1.time_ - var_34_15) / var_34_16

				if arg_31_1.var_.characterEffect1095ui_story and not isNil(var_34_14) then
					arg_31_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_15 + var_34_16 and arg_31_1.time_ < var_34_15 + var_34_16 + arg_34_0 and not isNil(var_34_14) and arg_31_1.var_.characterEffect1095ui_story then
				arg_31_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_34_18 = 0

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_34_19 = 0

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_20 = arg_31_1.actors_["1084ui_story"].transform
			local var_34_21 = 0

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = var_34_20.localPosition
			end

			local var_34_22 = 0.001

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_22 then
				local var_34_23 = (arg_31_1.time_ - var_34_21) / var_34_22
				local var_34_24 = Vector3.New(-0.7, -0.97, -6)

				var_34_20.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, var_34_24, var_34_23)

				local var_34_25 = manager.ui.mainCamera.transform.position - var_34_20.position

				var_34_20.forward = Vector3.New(var_34_25.x, var_34_25.y, var_34_25.z)

				local var_34_26 = var_34_20.localEulerAngles

				var_34_26.z = 0
				var_34_26.x = 0
				var_34_20.localEulerAngles = var_34_26
			end

			if arg_31_1.time_ >= var_34_21 + var_34_22 and arg_31_1.time_ < var_34_21 + var_34_22 + arg_34_0 then
				var_34_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_34_27 = manager.ui.mainCamera.transform.position - var_34_20.position

				var_34_20.forward = Vector3.New(var_34_27.x, var_34_27.y, var_34_27.z)

				local var_34_28 = var_34_20.localEulerAngles

				var_34_28.z = 0
				var_34_28.x = 0
				var_34_20.localEulerAngles = var_34_28
			end

			local var_34_29 = arg_31_1.actors_["1084ui_story"]
			local var_34_30 = 0

			if var_34_30 < arg_31_1.time_ and arg_31_1.time_ <= var_34_30 + arg_34_0 and not isNil(var_34_29) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_31 = 0.200000002980232

			if var_34_30 <= arg_31_1.time_ and arg_31_1.time_ < var_34_30 + var_34_31 and not isNil(var_34_29) then
				local var_34_32 = (arg_31_1.time_ - var_34_30) / var_34_31

				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_29) then
					local var_34_33 = Mathf.Lerp(0, 0.5, var_34_32)

					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_33
				end
			end

			if arg_31_1.time_ >= var_34_30 + var_34_31 and arg_31_1.time_ < var_34_30 + var_34_31 + arg_34_0 and not isNil(var_34_29) and arg_31_1.var_.characterEffect1084ui_story then
				local var_34_34 = 0.5

				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_34
			end

			local var_34_35 = 0
			local var_34_36 = 0.1

			if var_34_35 < arg_31_1.time_ and arg_31_1.time_ <= var_34_35 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_37 = arg_31_1:FormatText(StoryNameCfg[471].name)

				arg_31_1.leftNameTxt_.text = var_34_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_38 = arg_31_1:GetWordFromCfg(319791007)
				local var_34_39 = arg_31_1:FormatText(var_34_38.content)

				arg_31_1.text_.text = var_34_39

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_40 = 4
				local var_34_41 = utf8.len(var_34_39)
				local var_34_42 = var_34_40 <= 0 and var_34_36 or var_34_36 * (var_34_41 / var_34_40)

				if var_34_42 > 0 and var_34_36 < var_34_42 then
					arg_31_1.talkMaxDuration = var_34_42

					if var_34_42 + var_34_35 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_42 + var_34_35
					end
				end

				arg_31_1.text_.text = var_34_39
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791007", "story_v_out_319791.awb") ~= 0 then
					local var_34_43 = manager.audio:GetVoiceLength("story_v_out_319791", "319791007", "story_v_out_319791.awb") / 1000

					if var_34_43 + var_34_35 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_43 + var_34_35
					end

					if var_34_38.prefab_name ~= "" and arg_31_1.actors_[var_34_38.prefab_name] ~= nil then
						local var_34_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_38.prefab_name].transform, "story_v_out_319791", "319791007", "story_v_out_319791.awb")

						arg_31_1:RecordAudio("319791007", var_34_44)
						arg_31_1:RecordAudio("319791007", var_34_44)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319791", "319791007", "story_v_out_319791.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319791", "319791007", "story_v_out_319791.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_45 = math.max(var_34_36, arg_31_1.talkMaxDuration)

			if var_34_35 <= arg_31_1.time_ and arg_31_1.time_ < var_34_35 + var_34_45 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_35) / var_34_45

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_35 + var_34_45 and arg_31_1.time_ < var_34_35 + var_34_45 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319791008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319791009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1095ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1095ui_story == nil then
				arg_35_1.var_.characterEffect1095ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1095ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1095ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1095ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1095ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_38_7 = 0
			local var_38_8 = 0.125

			if var_38_7 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_9 = arg_35_1:FormatText(StoryNameCfg[698].name)

				arg_35_1.leftNameTxt_.text = var_38_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_10 = arg_35_1:GetWordFromCfg(319791008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_12 = 5
				local var_38_13 = utf8.len(var_38_11)
				local var_38_14 = var_38_12 <= 0 and var_38_8 or var_38_8 * (var_38_13 / var_38_12)

				if var_38_14 > 0 and var_38_8 < var_38_14 then
					arg_35_1.talkMaxDuration = var_38_14

					if var_38_14 + var_38_7 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_7
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_8, arg_35_1.talkMaxDuration)

			if var_38_7 <= arg_35_1.time_ and arg_35_1.time_ < var_38_7 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_7) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_7 + var_38_15 and arg_35_1.time_ < var_38_7 + var_38_15 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319791009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319791009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319791010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1095ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, 100, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, 100, 0)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1084ui_story"].transform
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_9.localPosition
			end

			local var_42_11 = 0.001

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11
				local var_42_13 = Vector3.New(0, 100, 0)

				var_42_9.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, var_42_13, var_42_12)

				local var_42_14 = manager.ui.mainCamera.transform.position - var_42_9.position

				var_42_9.forward = Vector3.New(var_42_14.x, var_42_14.y, var_42_14.z)

				local var_42_15 = var_42_9.localEulerAngles

				var_42_15.z = 0
				var_42_15.x = 0
				var_42_9.localEulerAngles = var_42_15
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 then
				var_42_9.localPosition = Vector3.New(0, 100, 0)

				local var_42_16 = manager.ui.mainCamera.transform.position - var_42_9.position

				var_42_9.forward = Vector3.New(var_42_16.x, var_42_16.y, var_42_16.z)

				local var_42_17 = var_42_9.localEulerAngles

				var_42_17.z = 0
				var_42_17.x = 0
				var_42_9.localEulerAngles = var_42_17
			end

			local var_42_18 = 0
			local var_42_19 = 1

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_20 = arg_39_1:GetWordFromCfg(319791009)
				local var_42_21 = arg_39_1:FormatText(var_42_20.content)

				arg_39_1.text_.text = var_42_21

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_22 = 40
				local var_42_23 = utf8.len(var_42_21)
				local var_42_24 = var_42_22 <= 0 and var_42_19 or var_42_19 * (var_42_23 / var_42_22)

				if var_42_24 > 0 and var_42_19 < var_42_24 then
					arg_39_1.talkMaxDuration = var_42_24

					if var_42_24 + var_42_18 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_24 + var_42_18
					end
				end

				arg_39_1.text_.text = var_42_21
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_19, arg_39_1.talkMaxDuration)

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_18) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_18 + var_42_25 and arg_39_1.time_ < var_42_18 + var_42_25 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play319791010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319791010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play319791011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 1.125

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(319791010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 45
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319791011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319791011
		arg_47_1.duration_ = 3.03

		local var_47_0 = {
			zh = 3.033,
			ja = 2.233
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319791012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "10066ui_story"

			if arg_47_1.actors_[var_50_0] == nil then
				local var_50_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_50_1) then
					local var_50_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_47_1.stage_.transform)

					var_50_2.name = var_50_0
					var_50_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_47_1.actors_[var_50_0] = var_50_2

					local var_50_3 = var_50_2:GetComponentInChildren(typeof(CharacterEffect))

					var_50_3.enabled = true

					local var_50_4 = GameObjectTools.GetOrAddComponent(var_50_2, typeof(DynamicBoneHelper))

					if var_50_4 then
						var_50_4:EnableDynamicBone(false)
					end

					arg_47_1:ShowWeapon(var_50_3.transform, false)

					arg_47_1.var_[var_50_0 .. "Animator"] = var_50_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_47_1.var_[var_50_0 .. "Animator"].applyRootMotion = true
					arg_47_1.var_[var_50_0 .. "LipSync"] = var_50_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_50_5 = arg_47_1.actors_["10066ui_story"].transform
			local var_50_6 = 0

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.var_.moveOldPos10066ui_story = var_50_5.localPosition
			end

			local var_50_7 = 0.001

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_7 then
				local var_50_8 = (arg_47_1.time_ - var_50_6) / var_50_7
				local var_50_9 = Vector3.New(0, -0.99, -5.83)

				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10066ui_story, var_50_9, var_50_8)

				local var_50_10 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_10.x, var_50_10.y, var_50_10.z)

				local var_50_11 = var_50_5.localEulerAngles

				var_50_11.z = 0
				var_50_11.x = 0
				var_50_5.localEulerAngles = var_50_11
			end

			if arg_47_1.time_ >= var_50_6 + var_50_7 and arg_47_1.time_ < var_50_6 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_50_12 = manager.ui.mainCamera.transform.position - var_50_5.position

				var_50_5.forward = Vector3.New(var_50_12.x, var_50_12.y, var_50_12.z)

				local var_50_13 = var_50_5.localEulerAngles

				var_50_13.z = 0
				var_50_13.x = 0
				var_50_5.localEulerAngles = var_50_13
			end

			local var_50_14 = arg_47_1.actors_["10066ui_story"]
			local var_50_15 = 0

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect10066ui_story == nil then
				arg_47_1.var_.characterEffect10066ui_story = var_50_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_16 = 0.200000002980232

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_16 and not isNil(var_50_14) then
				local var_50_17 = (arg_47_1.time_ - var_50_15) / var_50_16

				if arg_47_1.var_.characterEffect10066ui_story and not isNil(var_50_14) then
					arg_47_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_15 + var_50_16 and arg_47_1.time_ < var_50_15 + var_50_16 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect10066ui_story then
				arg_47_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_50_18 = 0

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				arg_47_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_20 = arg_47_1.actors_["1095ui_story"].transform
			local var_50_21 = 0

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.var_.moveOldPos1095ui_story = var_50_20.localPosition
			end

			local var_50_22 = 0.001

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_22 then
				local var_50_23 = (arg_47_1.time_ - var_50_21) / var_50_22
				local var_50_24 = Vector3.New(0, 100, 0)

				var_50_20.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1095ui_story, var_50_24, var_50_23)

				local var_50_25 = manager.ui.mainCamera.transform.position - var_50_20.position

				var_50_20.forward = Vector3.New(var_50_25.x, var_50_25.y, var_50_25.z)

				local var_50_26 = var_50_20.localEulerAngles

				var_50_26.z = 0
				var_50_26.x = 0
				var_50_20.localEulerAngles = var_50_26
			end

			if arg_47_1.time_ >= var_50_21 + var_50_22 and arg_47_1.time_ < var_50_21 + var_50_22 + arg_50_0 then
				var_50_20.localPosition = Vector3.New(0, 100, 0)

				local var_50_27 = manager.ui.mainCamera.transform.position - var_50_20.position

				var_50_20.forward = Vector3.New(var_50_27.x, var_50_27.y, var_50_27.z)

				local var_50_28 = var_50_20.localEulerAngles

				var_50_28.z = 0
				var_50_28.x = 0
				var_50_20.localEulerAngles = var_50_28
			end

			local var_50_29 = arg_47_1.actors_["1095ui_story"]
			local var_50_30 = 0

			if var_50_30 < arg_47_1.time_ and arg_47_1.time_ <= var_50_30 + arg_50_0 and not isNil(var_50_29) and arg_47_1.var_.characterEffect1095ui_story == nil then
				arg_47_1.var_.characterEffect1095ui_story = var_50_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_31 = 0.200000002980232

			if var_50_30 <= arg_47_1.time_ and arg_47_1.time_ < var_50_30 + var_50_31 and not isNil(var_50_29) then
				local var_50_32 = (arg_47_1.time_ - var_50_30) / var_50_31

				if arg_47_1.var_.characterEffect1095ui_story and not isNil(var_50_29) then
					local var_50_33 = Mathf.Lerp(0, 0.5, var_50_32)

					arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1095ui_story.fillRatio = var_50_33
				end
			end

			if arg_47_1.time_ >= var_50_30 + var_50_31 and arg_47_1.time_ < var_50_30 + var_50_31 + arg_50_0 and not isNil(var_50_29) and arg_47_1.var_.characterEffect1095ui_story then
				local var_50_34 = 0.5

				arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1095ui_story.fillRatio = var_50_34
			end

			local var_50_35 = arg_47_1.actors_["1084ui_story"].transform
			local var_50_36 = 0

			if var_50_36 < arg_47_1.time_ and arg_47_1.time_ <= var_50_36 + arg_50_0 then
				arg_47_1.var_.moveOldPos1084ui_story = var_50_35.localPosition
			end

			local var_50_37 = 0.001

			if var_50_36 <= arg_47_1.time_ and arg_47_1.time_ < var_50_36 + var_50_37 then
				local var_50_38 = (arg_47_1.time_ - var_50_36) / var_50_37
				local var_50_39 = Vector3.New(0, 100, 0)

				var_50_35.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1084ui_story, var_50_39, var_50_38)

				local var_50_40 = manager.ui.mainCamera.transform.position - var_50_35.position

				var_50_35.forward = Vector3.New(var_50_40.x, var_50_40.y, var_50_40.z)

				local var_50_41 = var_50_35.localEulerAngles

				var_50_41.z = 0
				var_50_41.x = 0
				var_50_35.localEulerAngles = var_50_41
			end

			if arg_47_1.time_ >= var_50_36 + var_50_37 and arg_47_1.time_ < var_50_36 + var_50_37 + arg_50_0 then
				var_50_35.localPosition = Vector3.New(0, 100, 0)

				local var_50_42 = manager.ui.mainCamera.transform.position - var_50_35.position

				var_50_35.forward = Vector3.New(var_50_42.x, var_50_42.y, var_50_42.z)

				local var_50_43 = var_50_35.localEulerAngles

				var_50_43.z = 0
				var_50_43.x = 0
				var_50_35.localEulerAngles = var_50_43
			end

			local var_50_44 = arg_47_1.actors_["1084ui_story"]
			local var_50_45 = 0

			if var_50_45 < arg_47_1.time_ and arg_47_1.time_ <= var_50_45 + arg_50_0 and not isNil(var_50_44) and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = var_50_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_46 = 0.200000002980232

			if var_50_45 <= arg_47_1.time_ and arg_47_1.time_ < var_50_45 + var_50_46 and not isNil(var_50_44) then
				local var_50_47 = (arg_47_1.time_ - var_50_45) / var_50_46

				if arg_47_1.var_.characterEffect1084ui_story and not isNil(var_50_44) then
					local var_50_48 = Mathf.Lerp(0, 0.5, var_50_47)

					arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_48
				end
			end

			if arg_47_1.time_ >= var_50_45 + var_50_46 and arg_47_1.time_ < var_50_45 + var_50_46 + arg_50_0 and not isNil(var_50_44) and arg_47_1.var_.characterEffect1084ui_story then
				local var_50_49 = 0.5

				arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_49
			end

			local var_50_50 = 0
			local var_50_51 = 0.25

			if var_50_50 < arg_47_1.time_ and arg_47_1.time_ <= var_50_50 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_52 = arg_47_1:FormatText(StoryNameCfg[640].name)

				arg_47_1.leftNameTxt_.text = var_50_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_53 = arg_47_1:GetWordFromCfg(319791011)
				local var_50_54 = arg_47_1:FormatText(var_50_53.content)

				arg_47_1.text_.text = var_50_54

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_55 = 10
				local var_50_56 = utf8.len(var_50_54)
				local var_50_57 = var_50_55 <= 0 and var_50_51 or var_50_51 * (var_50_56 / var_50_55)

				if var_50_57 > 0 and var_50_51 < var_50_57 then
					arg_47_1.talkMaxDuration = var_50_57

					if var_50_57 + var_50_50 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_57 + var_50_50
					end
				end

				arg_47_1.text_.text = var_50_54
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791011", "story_v_out_319791.awb") ~= 0 then
					local var_50_58 = manager.audio:GetVoiceLength("story_v_out_319791", "319791011", "story_v_out_319791.awb") / 1000

					if var_50_58 + var_50_50 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_58 + var_50_50
					end

					if var_50_53.prefab_name ~= "" and arg_47_1.actors_[var_50_53.prefab_name] ~= nil then
						local var_50_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_53.prefab_name].transform, "story_v_out_319791", "319791011", "story_v_out_319791.awb")

						arg_47_1:RecordAudio("319791011", var_50_59)
						arg_47_1:RecordAudio("319791011", var_50_59)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319791", "319791011", "story_v_out_319791.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319791", "319791011", "story_v_out_319791.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_60 = math.max(var_50_51, arg_47_1.talkMaxDuration)

			if var_50_50 <= arg_47_1.time_ and arg_47_1.time_ < var_50_50 + var_50_60 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_50) / var_50_60

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_50 + var_50_60 and arg_47_1.time_ < var_50_50 + var_50_60 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319791012
		arg_51_1.duration_ = 6.03

		local var_51_0 = {
			zh = 2.6,
			ja = 6.033
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319791013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1084ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1084ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(-0.7, -0.97, -6)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1084ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1084ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1084ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_15 = arg_51_1.actors_["10066ui_story"].transform
			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.var_.moveOldPos10066ui_story = var_54_15.localPosition
			end

			local var_54_17 = 0.001

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_17 then
				local var_54_18 = (arg_51_1.time_ - var_54_16) / var_54_17
				local var_54_19 = Vector3.New(0, 100, 0)

				var_54_15.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10066ui_story, var_54_19, var_54_18)

				local var_54_20 = manager.ui.mainCamera.transform.position - var_54_15.position

				var_54_15.forward = Vector3.New(var_54_20.x, var_54_20.y, var_54_20.z)

				local var_54_21 = var_54_15.localEulerAngles

				var_54_21.z = 0
				var_54_21.x = 0
				var_54_15.localEulerAngles = var_54_21
			end

			if arg_51_1.time_ >= var_54_16 + var_54_17 and arg_51_1.time_ < var_54_16 + var_54_17 + arg_54_0 then
				var_54_15.localPosition = Vector3.New(0, 100, 0)

				local var_54_22 = manager.ui.mainCamera.transform.position - var_54_15.position

				var_54_15.forward = Vector3.New(var_54_22.x, var_54_22.y, var_54_22.z)

				local var_54_23 = var_54_15.localEulerAngles

				var_54_23.z = 0
				var_54_23.x = 0
				var_54_15.localEulerAngles = var_54_23
			end

			local var_54_24 = arg_51_1.actors_["10066ui_story"]
			local var_54_25 = 0

			if var_54_25 < arg_51_1.time_ and arg_51_1.time_ <= var_54_25 + arg_54_0 and not isNil(var_54_24) and arg_51_1.var_.characterEffect10066ui_story == nil then
				arg_51_1.var_.characterEffect10066ui_story = var_54_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_26 = 0.200000002980232

			if var_54_25 <= arg_51_1.time_ and arg_51_1.time_ < var_54_25 + var_54_26 and not isNil(var_54_24) then
				local var_54_27 = (arg_51_1.time_ - var_54_25) / var_54_26

				if arg_51_1.var_.characterEffect10066ui_story and not isNil(var_54_24) then
					local var_54_28 = Mathf.Lerp(0, 0.5, var_54_27)

					arg_51_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10066ui_story.fillRatio = var_54_28
				end
			end

			if arg_51_1.time_ >= var_54_25 + var_54_26 and arg_51_1.time_ < var_54_25 + var_54_26 + arg_54_0 and not isNil(var_54_24) and arg_51_1.var_.characterEffect10066ui_story then
				local var_54_29 = 0.5

				arg_51_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10066ui_story.fillRatio = var_54_29
			end

			local var_54_30 = 0
			local var_54_31 = 0.325

			if var_54_30 < arg_51_1.time_ and arg_51_1.time_ <= var_54_30 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_32 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_33 = arg_51_1:GetWordFromCfg(319791012)
				local var_54_34 = arg_51_1:FormatText(var_54_33.content)

				arg_51_1.text_.text = var_54_34

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_35 = 13
				local var_54_36 = utf8.len(var_54_34)
				local var_54_37 = var_54_35 <= 0 and var_54_31 or var_54_31 * (var_54_36 / var_54_35)

				if var_54_37 > 0 and var_54_31 < var_54_37 then
					arg_51_1.talkMaxDuration = var_54_37

					if var_54_37 + var_54_30 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_37 + var_54_30
					end
				end

				arg_51_1.text_.text = var_54_34
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791012", "story_v_out_319791.awb") ~= 0 then
					local var_54_38 = manager.audio:GetVoiceLength("story_v_out_319791", "319791012", "story_v_out_319791.awb") / 1000

					if var_54_38 + var_54_30 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_38 + var_54_30
					end

					if var_54_33.prefab_name ~= "" and arg_51_1.actors_[var_54_33.prefab_name] ~= nil then
						local var_54_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_33.prefab_name].transform, "story_v_out_319791", "319791012", "story_v_out_319791.awb")

						arg_51_1:RecordAudio("319791012", var_54_39)
						arg_51_1:RecordAudio("319791012", var_54_39)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319791", "319791012", "story_v_out_319791.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319791", "319791012", "story_v_out_319791.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_40 = math.max(var_54_31, arg_51_1.talkMaxDuration)

			if var_54_30 <= arg_51_1.time_ and arg_51_1.time_ < var_54_30 + var_54_40 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_30) / var_54_40

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_30 + var_54_40 and arg_51_1.time_ < var_54_30 + var_54_40 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play319791013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319791013
		arg_55_1.duration_ = 5.07

		local var_55_0 = {
			zh = 2.3,
			ja = 5.066
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319791014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1095ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1095ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0.7, -0.98, -6.1)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1095ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1095ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1095ui_story == nil then
				arg_55_1.var_.characterEffect1095ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1095ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1095ui_story then
				arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_58_13 = 0

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_15 = arg_55_1.actors_["1084ui_story"].transform
			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_15.localPosition
			end

			local var_58_17 = 0.001

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17
				local var_58_19 = Vector3.New(-0.7, -0.97, -6)

				var_58_15.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, var_58_19, var_58_18)

				local var_58_20 = manager.ui.mainCamera.transform.position - var_58_15.position

				var_58_15.forward = Vector3.New(var_58_20.x, var_58_20.y, var_58_20.z)

				local var_58_21 = var_58_15.localEulerAngles

				var_58_21.z = 0
				var_58_21.x = 0
				var_58_15.localEulerAngles = var_58_21
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				var_58_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_58_22 = manager.ui.mainCamera.transform.position - var_58_15.position

				var_58_15.forward = Vector3.New(var_58_22.x, var_58_22.y, var_58_22.z)

				local var_58_23 = var_58_15.localEulerAngles

				var_58_23.z = 0
				var_58_23.x = 0
				var_58_15.localEulerAngles = var_58_23
			end

			local var_58_24 = arg_55_1.actors_["1084ui_story"]
			local var_58_25 = 0

			if var_58_25 < arg_55_1.time_ and arg_55_1.time_ <= var_58_25 + arg_58_0 and not isNil(var_58_24) and arg_55_1.var_.characterEffect1084ui_story == nil then
				arg_55_1.var_.characterEffect1084ui_story = var_58_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_26 = 0.200000002980232

			if var_58_25 <= arg_55_1.time_ and arg_55_1.time_ < var_58_25 + var_58_26 and not isNil(var_58_24) then
				local var_58_27 = (arg_55_1.time_ - var_58_25) / var_58_26

				if arg_55_1.var_.characterEffect1084ui_story and not isNil(var_58_24) then
					local var_58_28 = Mathf.Lerp(0, 0.5, var_58_27)

					arg_55_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1084ui_story.fillRatio = var_58_28
				end
			end

			if arg_55_1.time_ >= var_58_25 + var_58_26 and arg_55_1.time_ < var_58_25 + var_58_26 + arg_58_0 and not isNil(var_58_24) and arg_55_1.var_.characterEffect1084ui_story then
				local var_58_29 = 0.5

				arg_55_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1084ui_story.fillRatio = var_58_29
			end

			local var_58_30 = 0
			local var_58_31 = 0.425

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_32 = arg_55_1:FormatText(StoryNameCfg[471].name)

				arg_55_1.leftNameTxt_.text = var_58_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_33 = arg_55_1:GetWordFromCfg(319791013)
				local var_58_34 = arg_55_1:FormatText(var_58_33.content)

				arg_55_1.text_.text = var_58_34

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_35 = 17
				local var_58_36 = utf8.len(var_58_34)
				local var_58_37 = var_58_35 <= 0 and var_58_31 or var_58_31 * (var_58_36 / var_58_35)

				if var_58_37 > 0 and var_58_31 < var_58_37 then
					arg_55_1.talkMaxDuration = var_58_37

					if var_58_37 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_37 + var_58_30
					end
				end

				arg_55_1.text_.text = var_58_34
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791013", "story_v_out_319791.awb") ~= 0 then
					local var_58_38 = manager.audio:GetVoiceLength("story_v_out_319791", "319791013", "story_v_out_319791.awb") / 1000

					if var_58_38 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_38 + var_58_30
					end

					if var_58_33.prefab_name ~= "" and arg_55_1.actors_[var_58_33.prefab_name] ~= nil then
						local var_58_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_33.prefab_name].transform, "story_v_out_319791", "319791013", "story_v_out_319791.awb")

						arg_55_1:RecordAudio("319791013", var_58_39)
						arg_55_1:RecordAudio("319791013", var_58_39)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319791", "319791013", "story_v_out_319791.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319791", "319791013", "story_v_out_319791.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_40 = math.max(var_58_31, arg_55_1.talkMaxDuration)

			if var_58_30 <= arg_55_1.time_ and arg_55_1.time_ < var_58_30 + var_58_40 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_30) / var_58_40

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_30 + var_58_40 and arg_55_1.time_ < var_58_30 + var_58_40 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play319791014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319791014
		arg_59_1.duration_ = 9.27

		local var_59_0 = {
			zh = 6.566,
			ja = 9.266
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319791015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.8

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[471].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(319791014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 32
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791014", "story_v_out_319791.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791014", "story_v_out_319791.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_319791", "319791014", "story_v_out_319791.awb")

						arg_59_1:RecordAudio("319791014", var_62_9)
						arg_59_1:RecordAudio("319791014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319791", "319791014", "story_v_out_319791.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319791", "319791014", "story_v_out_319791.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play319791015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319791015
		arg_63_1.duration_ = 7.67

		local var_63_0 = {
			zh = 6.833,
			ja = 7.666
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319791016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1084ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1084ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_66_4 = 0

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_6 = arg_63_1.actors_["1095ui_story"]
			local var_66_7 = 0

			if var_66_7 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1095ui_story == nil then
				arg_63_1.var_.characterEffect1095ui_story = var_66_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_8 = 0.200000002980232

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_8 and not isNil(var_66_6) then
				local var_66_9 = (arg_63_1.time_ - var_66_7) / var_66_8

				if arg_63_1.var_.characterEffect1095ui_story and not isNil(var_66_6) then
					local var_66_10 = Mathf.Lerp(0, 0.5, var_66_9)

					arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1095ui_story.fillRatio = var_66_10
				end
			end

			if arg_63_1.time_ >= var_66_7 + var_66_8 and arg_63_1.time_ < var_66_7 + var_66_8 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1095ui_story then
				local var_66_11 = 0.5

				arg_63_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1095ui_story.fillRatio = var_66_11
			end

			local var_66_12 = 0
			local var_66_13 = 0.825

			if var_66_12 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_14 = arg_63_1:FormatText(StoryNameCfg[6].name)

				arg_63_1.leftNameTxt_.text = var_66_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_15 = arg_63_1:GetWordFromCfg(319791015)
				local var_66_16 = arg_63_1:FormatText(var_66_15.content)

				arg_63_1.text_.text = var_66_16

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 33
				local var_66_18 = utf8.len(var_66_16)
				local var_66_19 = var_66_17 <= 0 and var_66_13 or var_66_13 * (var_66_18 / var_66_17)

				if var_66_19 > 0 and var_66_13 < var_66_19 then
					arg_63_1.talkMaxDuration = var_66_19

					if var_66_19 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_12
					end
				end

				arg_63_1.text_.text = var_66_16
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791015", "story_v_out_319791.awb") ~= 0 then
					local var_66_20 = manager.audio:GetVoiceLength("story_v_out_319791", "319791015", "story_v_out_319791.awb") / 1000

					if var_66_20 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_20 + var_66_12
					end

					if var_66_15.prefab_name ~= "" and arg_63_1.actors_[var_66_15.prefab_name] ~= nil then
						local var_66_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_15.prefab_name].transform, "story_v_out_319791", "319791015", "story_v_out_319791.awb")

						arg_63_1:RecordAudio("319791015", var_66_21)
						arg_63_1:RecordAudio("319791015", var_66_21)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319791", "319791015", "story_v_out_319791.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319791", "319791015", "story_v_out_319791.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_22 = math.max(var_66_13, arg_63_1.talkMaxDuration)

			if var_66_12 <= arg_63_1.time_ and arg_63_1.time_ < var_66_12 + var_66_22 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_12) / var_66_22

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_12 + var_66_22 and arg_63_1.time_ < var_66_12 + var_66_22 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319791016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319791016
		arg_67_1.duration_ = 11.27

		local var_67_0 = {
			zh = 9.766,
			ja = 11.266
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319791017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1095ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1095ui_story == nil then
				arg_67_1.var_.characterEffect1095ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1095ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1095ui_story then
				arg_67_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["1084ui_story"]
			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_6 and not isNil(var_70_4) then
				local var_70_7 = (arg_67_1.time_ - var_70_5) / var_70_6

				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_4) then
					local var_70_8 = Mathf.Lerp(0, 0.5, var_70_7)

					arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1084ui_story.fillRatio = var_70_8
				end
			end

			if arg_67_1.time_ >= var_70_5 + var_70_6 and arg_67_1.time_ < var_70_5 + var_70_6 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1084ui_story then
				local var_70_9 = 0.5

				arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1084ui_story.fillRatio = var_70_9
			end

			local var_70_10 = 0
			local var_70_11 = 1.15

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_12 = arg_67_1:FormatText(StoryNameCfg[471].name)

				arg_67_1.leftNameTxt_.text = var_70_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_13 = arg_67_1:GetWordFromCfg(319791016)
				local var_70_14 = arg_67_1:FormatText(var_70_13.content)

				arg_67_1.text_.text = var_70_14

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_15 = 46
				local var_70_16 = utf8.len(var_70_14)
				local var_70_17 = var_70_15 <= 0 and var_70_11 or var_70_11 * (var_70_16 / var_70_15)

				if var_70_17 > 0 and var_70_11 < var_70_17 then
					arg_67_1.talkMaxDuration = var_70_17

					if var_70_17 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_17 + var_70_10
					end
				end

				arg_67_1.text_.text = var_70_14
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791016", "story_v_out_319791.awb") ~= 0 then
					local var_70_18 = manager.audio:GetVoiceLength("story_v_out_319791", "319791016", "story_v_out_319791.awb") / 1000

					if var_70_18 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_10
					end

					if var_70_13.prefab_name ~= "" and arg_67_1.actors_[var_70_13.prefab_name] ~= nil then
						local var_70_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_13.prefab_name].transform, "story_v_out_319791", "319791016", "story_v_out_319791.awb")

						arg_67_1:RecordAudio("319791016", var_70_19)
						arg_67_1:RecordAudio("319791016", var_70_19)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319791", "319791016", "story_v_out_319791.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319791", "319791016", "story_v_out_319791.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_20 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_20 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_10) / var_70_20

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_10 + var_70_20 and arg_67_1.time_ < var_70_10 + var_70_20 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319791017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319791017
		arg_71_1.duration_ = 4.1

		local var_71_0 = {
			zh = 2.033,
			ja = 4.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319791018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1084ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(-0.7, -0.97, -6)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_11 = arg_71_1.actors_["1095ui_story"]
			local var_74_12 = 0

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = var_74_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_13 = 0.200000002980232

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 and not isNil(var_74_11) then
				local var_74_14 = (arg_71_1.time_ - var_74_12) / var_74_13

				if arg_71_1.var_.characterEffect1095ui_story and not isNil(var_74_11) then
					local var_74_15 = Mathf.Lerp(0, 0.5, var_74_14)

					arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_15
				end
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1095ui_story then
				local var_74_16 = 0.5

				arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_16
			end

			local var_74_17 = arg_71_1.actors_["1084ui_story"]
			local var_74_18 = 0

			if var_74_18 < arg_71_1.time_ and arg_71_1.time_ <= var_74_18 + arg_74_0 and not isNil(var_74_17) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_19 = 0.200000002980232

			if var_74_18 <= arg_71_1.time_ and arg_71_1.time_ < var_74_18 + var_74_19 and not isNil(var_74_17) then
				local var_74_20 = (arg_71_1.time_ - var_74_18) / var_74_19

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_17) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_18 + var_74_19 and arg_71_1.time_ < var_74_18 + var_74_19 + arg_74_0 and not isNil(var_74_17) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_74_21 = 0
			local var_74_22 = 0.25

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_23 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_24 = arg_71_1:GetWordFromCfg(319791017)
				local var_74_25 = arg_71_1:FormatText(var_74_24.content)

				arg_71_1.text_.text = var_74_25

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_26 = 10
				local var_74_27 = utf8.len(var_74_25)
				local var_74_28 = var_74_26 <= 0 and var_74_22 or var_74_22 * (var_74_27 / var_74_26)

				if var_74_28 > 0 and var_74_22 < var_74_28 then
					arg_71_1.talkMaxDuration = var_74_28

					if var_74_28 + var_74_21 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_28 + var_74_21
					end
				end

				arg_71_1.text_.text = var_74_25
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791017", "story_v_out_319791.awb") ~= 0 then
					local var_74_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791017", "story_v_out_319791.awb") / 1000

					if var_74_29 + var_74_21 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_29 + var_74_21
					end

					if var_74_24.prefab_name ~= "" and arg_71_1.actors_[var_74_24.prefab_name] ~= nil then
						local var_74_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_24.prefab_name].transform, "story_v_out_319791", "319791017", "story_v_out_319791.awb")

						arg_71_1:RecordAudio("319791017", var_74_30)
						arg_71_1:RecordAudio("319791017", var_74_30)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319791", "319791017", "story_v_out_319791.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319791", "319791017", "story_v_out_319791.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_31 = math.max(var_74_22, arg_71_1.talkMaxDuration)

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_31 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_21) / var_74_31

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_21 + var_74_31 and arg_71_1.time_ < var_74_21 + var_74_31 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319791018
		arg_75_1.duration_ = 9.8

		local var_75_0 = {
			zh = 9.8,
			ja = 9.4
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
				arg_75_0:Play319791019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10066ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10066ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -0.99, -5.83)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10066ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["10066ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect10066ui_story == nil then
				arg_75_1.var_.characterEffect10066ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect10066ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect10066ui_story then
				arg_75_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_78_13 = 0

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_15 = arg_75_1.actors_["1095ui_story"].transform
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.var_.moveOldPos1095ui_story = var_78_15.localPosition
			end

			local var_78_17 = 0.001

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17
				local var_78_19 = Vector3.New(0, 100, 0)

				var_78_15.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1095ui_story, var_78_19, var_78_18)

				local var_78_20 = manager.ui.mainCamera.transform.position - var_78_15.position

				var_78_15.forward = Vector3.New(var_78_20.x, var_78_20.y, var_78_20.z)

				local var_78_21 = var_78_15.localEulerAngles

				var_78_21.z = 0
				var_78_21.x = 0
				var_78_15.localEulerAngles = var_78_21
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				var_78_15.localPosition = Vector3.New(0, 100, 0)

				local var_78_22 = manager.ui.mainCamera.transform.position - var_78_15.position

				var_78_15.forward = Vector3.New(var_78_22.x, var_78_22.y, var_78_22.z)

				local var_78_23 = var_78_15.localEulerAngles

				var_78_23.z = 0
				var_78_23.x = 0
				var_78_15.localEulerAngles = var_78_23
			end

			local var_78_24 = arg_75_1.actors_["1095ui_story"]
			local var_78_25 = 0

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 and not isNil(var_78_24) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_26 = 0.200000002980232

			if var_78_25 <= arg_75_1.time_ and arg_75_1.time_ < var_78_25 + var_78_26 and not isNil(var_78_24) then
				local var_78_27 = (arg_75_1.time_ - var_78_25) / var_78_26

				if arg_75_1.var_.characterEffect1095ui_story and not isNil(var_78_24) then
					local var_78_28 = Mathf.Lerp(0, 0.5, var_78_27)

					arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1095ui_story.fillRatio = var_78_28
				end
			end

			if arg_75_1.time_ >= var_78_25 + var_78_26 and arg_75_1.time_ < var_78_25 + var_78_26 + arg_78_0 and not isNil(var_78_24) and arg_75_1.var_.characterEffect1095ui_story then
				local var_78_29 = 0.5

				arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1095ui_story.fillRatio = var_78_29
			end

			local var_78_30 = arg_75_1.actors_["1084ui_story"].transform
			local var_78_31 = 0

			if var_78_31 < arg_75_1.time_ and arg_75_1.time_ <= var_78_31 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084ui_story = var_78_30.localPosition
			end

			local var_78_32 = 0.001

			if var_78_31 <= arg_75_1.time_ and arg_75_1.time_ < var_78_31 + var_78_32 then
				local var_78_33 = (arg_75_1.time_ - var_78_31) / var_78_32
				local var_78_34 = Vector3.New(0, 100, 0)

				var_78_30.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084ui_story, var_78_34, var_78_33)

				local var_78_35 = manager.ui.mainCamera.transform.position - var_78_30.position

				var_78_30.forward = Vector3.New(var_78_35.x, var_78_35.y, var_78_35.z)

				local var_78_36 = var_78_30.localEulerAngles

				var_78_36.z = 0
				var_78_36.x = 0
				var_78_30.localEulerAngles = var_78_36
			end

			if arg_75_1.time_ >= var_78_31 + var_78_32 and arg_75_1.time_ < var_78_31 + var_78_32 + arg_78_0 then
				var_78_30.localPosition = Vector3.New(0, 100, 0)

				local var_78_37 = manager.ui.mainCamera.transform.position - var_78_30.position

				var_78_30.forward = Vector3.New(var_78_37.x, var_78_37.y, var_78_37.z)

				local var_78_38 = var_78_30.localEulerAngles

				var_78_38.z = 0
				var_78_38.x = 0
				var_78_30.localEulerAngles = var_78_38
			end

			local var_78_39 = arg_75_1.actors_["1084ui_story"]
			local var_78_40 = 0

			if var_78_40 < arg_75_1.time_ and arg_75_1.time_ <= var_78_40 + arg_78_0 and not isNil(var_78_39) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_41 = 0.200000002980232

			if var_78_40 <= arg_75_1.time_ and arg_75_1.time_ < var_78_40 + var_78_41 and not isNil(var_78_39) then
				local var_78_42 = (arg_75_1.time_ - var_78_40) / var_78_41

				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_39) then
					local var_78_43 = Mathf.Lerp(0, 0.5, var_78_42)

					arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_43
				end
			end

			if arg_75_1.time_ >= var_78_40 + var_78_41 and arg_75_1.time_ < var_78_40 + var_78_41 + arg_78_0 and not isNil(var_78_39) and arg_75_1.var_.characterEffect1084ui_story then
				local var_78_44 = 0.5

				arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_44
			end

			local var_78_45 = 0
			local var_78_46 = 1.075

			if var_78_45 < arg_75_1.time_ and arg_75_1.time_ <= var_78_45 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_47 = arg_75_1:FormatText(StoryNameCfg[640].name)

				arg_75_1.leftNameTxt_.text = var_78_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_48 = arg_75_1:GetWordFromCfg(319791018)
				local var_78_49 = arg_75_1:FormatText(var_78_48.content)

				arg_75_1.text_.text = var_78_49

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_50 = 43
				local var_78_51 = utf8.len(var_78_49)
				local var_78_52 = var_78_50 <= 0 and var_78_46 or var_78_46 * (var_78_51 / var_78_50)

				if var_78_52 > 0 and var_78_46 < var_78_52 then
					arg_75_1.talkMaxDuration = var_78_52

					if var_78_52 + var_78_45 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_52 + var_78_45
					end
				end

				arg_75_1.text_.text = var_78_49
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791018", "story_v_out_319791.awb") ~= 0 then
					local var_78_53 = manager.audio:GetVoiceLength("story_v_out_319791", "319791018", "story_v_out_319791.awb") / 1000

					if var_78_53 + var_78_45 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_53 + var_78_45
					end

					if var_78_48.prefab_name ~= "" and arg_75_1.actors_[var_78_48.prefab_name] ~= nil then
						local var_78_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_48.prefab_name].transform, "story_v_out_319791", "319791018", "story_v_out_319791.awb")

						arg_75_1:RecordAudio("319791018", var_78_54)
						arg_75_1:RecordAudio("319791018", var_78_54)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319791", "319791018", "story_v_out_319791.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319791", "319791018", "story_v_out_319791.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_55 = math.max(var_78_46, arg_75_1.talkMaxDuration)

			if var_78_45 <= arg_75_1.time_ and arg_75_1.time_ < var_78_45 + var_78_55 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_45) / var_78_55

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_45 + var_78_55 and arg_75_1.time_ < var_78_45 + var_78_55 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319791019
		arg_79_1.duration_ = 6.83

		local var_79_0 = {
			zh = 6.833,
			ja = 4.133
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
				arg_79_0:Play319791020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1095ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1095ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0.7, -0.98, -6.1)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1095ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1095ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1095ui_story == nil then
				arg_79_1.var_.characterEffect1095ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1095ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1095ui_story then
				arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_82_13 = arg_79_1.actors_["10066ui_story"].transform
			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.var_.moveOldPos10066ui_story = var_82_13.localPosition
			end

			local var_82_15 = 0.001

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_15 then
				local var_82_16 = (arg_79_1.time_ - var_82_14) / var_82_15
				local var_82_17 = Vector3.New(-0.7, -0.99, -5.83)

				var_82_13.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10066ui_story, var_82_17, var_82_16)

				local var_82_18 = manager.ui.mainCamera.transform.position - var_82_13.position

				var_82_13.forward = Vector3.New(var_82_18.x, var_82_18.y, var_82_18.z)

				local var_82_19 = var_82_13.localEulerAngles

				var_82_19.z = 0
				var_82_19.x = 0
				var_82_13.localEulerAngles = var_82_19
			end

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 then
				var_82_13.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_82_20 = manager.ui.mainCamera.transform.position - var_82_13.position

				var_82_13.forward = Vector3.New(var_82_20.x, var_82_20.y, var_82_20.z)

				local var_82_21 = var_82_13.localEulerAngles

				var_82_21.z = 0
				var_82_21.x = 0
				var_82_13.localEulerAngles = var_82_21
			end

			local var_82_22 = arg_79_1.actors_["10066ui_story"]
			local var_82_23 = 0

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 and not isNil(var_82_22) and arg_79_1.var_.characterEffect10066ui_story == nil then
				arg_79_1.var_.characterEffect10066ui_story = var_82_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_24 = 0.200000002980232

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_24 and not isNil(var_82_22) then
				local var_82_25 = (arg_79_1.time_ - var_82_23) / var_82_24

				if arg_79_1.var_.characterEffect10066ui_story and not isNil(var_82_22) then
					local var_82_26 = Mathf.Lerp(0, 0.5, var_82_25)

					arg_79_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10066ui_story.fillRatio = var_82_26
				end
			end

			if arg_79_1.time_ >= var_82_23 + var_82_24 and arg_79_1.time_ < var_82_23 + var_82_24 + arg_82_0 and not isNil(var_82_22) and arg_79_1.var_.characterEffect10066ui_story then
				local var_82_27 = 0.5

				arg_79_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10066ui_story.fillRatio = var_82_27
			end

			local var_82_28 = 0
			local var_82_29 = 0.95

			if var_82_28 < arg_79_1.time_ and arg_79_1.time_ <= var_82_28 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_30 = arg_79_1:FormatText(StoryNameCfg[471].name)

				arg_79_1.leftNameTxt_.text = var_82_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_31 = arg_79_1:GetWordFromCfg(319791019)
				local var_82_32 = arg_79_1:FormatText(var_82_31.content)

				arg_79_1.text_.text = var_82_32

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_33 = 38
				local var_82_34 = utf8.len(var_82_32)
				local var_82_35 = var_82_33 <= 0 and var_82_29 or var_82_29 * (var_82_34 / var_82_33)

				if var_82_35 > 0 and var_82_29 < var_82_35 then
					arg_79_1.talkMaxDuration = var_82_35

					if var_82_35 + var_82_28 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_35 + var_82_28
					end
				end

				arg_79_1.text_.text = var_82_32
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791019", "story_v_out_319791.awb") ~= 0 then
					local var_82_36 = manager.audio:GetVoiceLength("story_v_out_319791", "319791019", "story_v_out_319791.awb") / 1000

					if var_82_36 + var_82_28 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_36 + var_82_28
					end

					if var_82_31.prefab_name ~= "" and arg_79_1.actors_[var_82_31.prefab_name] ~= nil then
						local var_82_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_31.prefab_name].transform, "story_v_out_319791", "319791019", "story_v_out_319791.awb")

						arg_79_1:RecordAudio("319791019", var_82_37)
						arg_79_1:RecordAudio("319791019", var_82_37)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319791", "319791019", "story_v_out_319791.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319791", "319791019", "story_v_out_319791.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_38 = math.max(var_82_29, arg_79_1.talkMaxDuration)

			if var_82_28 <= arg_79_1.time_ and arg_79_1.time_ < var_82_28 + var_82_38 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_28) / var_82_38

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_28 + var_82_38 and arg_79_1.time_ < var_82_28 + var_82_38 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play319791020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319791020
		arg_83_1.duration_ = 13.13

		local var_83_0 = {
			zh = 7.633,
			ja = 13.133
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319791021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_2 = 0
			local var_86_3 = 0.9

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_4 = arg_83_1:FormatText(StoryNameCfg[471].name)

				arg_83_1.leftNameTxt_.text = var_86_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:GetWordFromCfg(319791020)
				local var_86_6 = arg_83_1:FormatText(var_86_5.content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 36
				local var_86_8 = utf8.len(var_86_6)
				local var_86_9 = var_86_7 <= 0 and var_86_3 or var_86_3 * (var_86_8 / var_86_7)

				if var_86_9 > 0 and var_86_3 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791020", "story_v_out_319791.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_319791", "319791020", "story_v_out_319791.awb") / 1000

					if var_86_10 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_2
					end

					if var_86_5.prefab_name ~= "" and arg_83_1.actors_[var_86_5.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_5.prefab_name].transform, "story_v_out_319791", "319791020", "story_v_out_319791.awb")

						arg_83_1:RecordAudio("319791020", var_86_11)
						arg_83_1:RecordAudio("319791020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319791", "319791020", "story_v_out_319791.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319791", "319791020", "story_v_out_319791.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_12 and arg_83_1.time_ < var_86_2 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319791021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319791021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319791022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1095ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1095ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1095ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["10066ui_story"].transform
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.var_.moveOldPos10066ui_story = var_90_9.localPosition
			end

			local var_90_11 = 0.001

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11
				local var_90_13 = Vector3.New(0, 100, 0)

				var_90_9.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10066ui_story, var_90_13, var_90_12)

				local var_90_14 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_14.x, var_90_14.y, var_90_14.z)

				local var_90_15 = var_90_9.localEulerAngles

				var_90_15.z = 0
				var_90_15.x = 0
				var_90_9.localEulerAngles = var_90_15
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 then
				var_90_9.localPosition = Vector3.New(0, 100, 0)

				local var_90_16 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_16.x, var_90_16.y, var_90_16.z)

				local var_90_17 = var_90_9.localEulerAngles

				var_90_17.z = 0
				var_90_17.x = 0
				var_90_9.localEulerAngles = var_90_17
			end

			local var_90_18 = 0
			local var_90_19 = 0.95

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_20 = arg_87_1:GetWordFromCfg(319791021)
				local var_90_21 = arg_87_1:FormatText(var_90_20.content)

				arg_87_1.text_.text = var_90_21

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_22 = 38
				local var_90_23 = utf8.len(var_90_21)
				local var_90_24 = var_90_22 <= 0 and var_90_19 or var_90_19 * (var_90_23 / var_90_22)

				if var_90_24 > 0 and var_90_19 < var_90_24 then
					arg_87_1.talkMaxDuration = var_90_24

					if var_90_24 + var_90_18 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_24 + var_90_18
					end
				end

				arg_87_1.text_.text = var_90_21
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_19, arg_87_1.talkMaxDuration)

			if var_90_18 <= arg_87_1.time_ and arg_87_1.time_ < var_90_18 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_18) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_18 + var_90_25 and arg_87_1.time_ < var_90_18 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play319791022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319791022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319791023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.025

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[698].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(319791022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 41
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
	Play319791023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319791023
		arg_95_1.duration_ = 7.97

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319791024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "ST70"

			if arg_95_1.bgs_[var_98_0] == nil then
				local var_98_1 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_98_0)
				var_98_1.name = var_98_0
				var_98_1.transform.parent = arg_95_1.stage_.transform
				var_98_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_[var_98_0] = var_98_1
			end

			local var_98_2 = 1.1

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				local var_98_3 = manager.ui.mainCamera.transform.localPosition
				local var_98_4 = Vector3.New(0, 0, 10) + Vector3.New(var_98_3.x, var_98_3.y, 0)
				local var_98_5 = arg_95_1.bgs_.ST70

				var_98_5.transform.localPosition = var_98_4
				var_98_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_6 = var_98_5:GetComponent("SpriteRenderer")

				if var_98_6 and var_98_6.sprite then
					local var_98_7 = (var_98_5.transform.localPosition - var_98_3).z
					local var_98_8 = manager.ui.mainCameraCom_
					local var_98_9 = 2 * var_98_7 * Mathf.Tan(var_98_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_10 = var_98_9 * var_98_8.aspect
					local var_98_11 = var_98_6.sprite.bounds.size.x
					local var_98_12 = var_98_6.sprite.bounds.size.y
					local var_98_13 = var_98_10 / var_98_11
					local var_98_14 = var_98_9 / var_98_12
					local var_98_15 = var_98_14 < var_98_13 and var_98_13 or var_98_14

					var_98_5.transform.localScale = Vector3.New(var_98_15, var_98_15, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST70" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_17 = 0.3

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_18 = 0

			if var_98_18 < arg_95_1.time_ and arg_95_1.time_ <= var_98_18 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_19 = 1.1

			if var_98_18 <= arg_95_1.time_ and arg_95_1.time_ < var_98_18 + var_98_19 then
				local var_98_20 = (arg_95_1.time_ - var_98_18) / var_98_19
				local var_98_21 = Color.New(0, 0, 0)

				var_98_21.a = Mathf.Lerp(0, 1, var_98_20)
				arg_95_1.mask_.color = var_98_21
			end

			if arg_95_1.time_ >= var_98_18 + var_98_19 and arg_95_1.time_ < var_98_18 + var_98_19 + arg_98_0 then
				local var_98_22 = Color.New(0, 0, 0)

				var_98_22.a = 1
				arg_95_1.mask_.color = var_98_22
			end

			local var_98_23 = 1.1

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_24 = 2

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24
				local var_98_26 = Color.New(0, 0, 0)

				var_98_26.a = Mathf.Lerp(1, 0, var_98_25)
				arg_95_1.mask_.color = var_98_26
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 then
				local var_98_27 = Color.New(0, 0, 0)
				local var_98_28 = 0

				arg_95_1.mask_.enabled = false
				var_98_27.a = var_98_28
				arg_95_1.mask_.color = var_98_27
			end

			local var_98_29 = arg_95_1.actors_["1095ui_story"].transform
			local var_98_30 = 0

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.var_.moveOldPos1095ui_story = var_98_29.localPosition
			end

			local var_98_31 = 0.001

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_31 then
				local var_98_32 = (arg_95_1.time_ - var_98_30) / var_98_31
				local var_98_33 = Vector3.New(0, 100, 0)

				var_98_29.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1095ui_story, var_98_33, var_98_32)

				local var_98_34 = manager.ui.mainCamera.transform.position - var_98_29.position

				var_98_29.forward = Vector3.New(var_98_34.x, var_98_34.y, var_98_34.z)

				local var_98_35 = var_98_29.localEulerAngles

				var_98_35.z = 0
				var_98_35.x = 0
				var_98_29.localEulerAngles = var_98_35
			end

			if arg_95_1.time_ >= var_98_30 + var_98_31 and arg_95_1.time_ < var_98_30 + var_98_31 + arg_98_0 then
				var_98_29.localPosition = Vector3.New(0, 100, 0)

				local var_98_36 = manager.ui.mainCamera.transform.position - var_98_29.position

				var_98_29.forward = Vector3.New(var_98_36.x, var_98_36.y, var_98_36.z)

				local var_98_37 = var_98_29.localEulerAngles

				var_98_37.z = 0
				var_98_37.x = 0
				var_98_29.localEulerAngles = var_98_37
			end

			local var_98_38 = arg_95_1.actors_["1095ui_story"]
			local var_98_39 = 0

			if var_98_39 < arg_95_1.time_ and arg_95_1.time_ <= var_98_39 + arg_98_0 and not isNil(var_98_38) and arg_95_1.var_.characterEffect1095ui_story == nil then
				arg_95_1.var_.characterEffect1095ui_story = var_98_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_40 = 0.200000002980232

			if var_98_39 <= arg_95_1.time_ and arg_95_1.time_ < var_98_39 + var_98_40 and not isNil(var_98_38) then
				local var_98_41 = (arg_95_1.time_ - var_98_39) / var_98_40

				if arg_95_1.var_.characterEffect1095ui_story and not isNil(var_98_38) then
					local var_98_42 = Mathf.Lerp(0, 0.5, var_98_41)

					arg_95_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1095ui_story.fillRatio = var_98_42
				end
			end

			if arg_95_1.time_ >= var_98_39 + var_98_40 and arg_95_1.time_ < var_98_39 + var_98_40 + arg_98_0 and not isNil(var_98_38) and arg_95_1.var_.characterEffect1095ui_story then
				local var_98_43 = 0.5

				arg_95_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1095ui_story.fillRatio = var_98_43
			end

			local var_98_44 = arg_95_1.actors_["10066ui_story"].transform
			local var_98_45 = 0

			if var_98_45 < arg_95_1.time_ and arg_95_1.time_ <= var_98_45 + arg_98_0 then
				arg_95_1.var_.moveOldPos10066ui_story = var_98_44.localPosition
			end

			local var_98_46 = 0.001

			if var_98_45 <= arg_95_1.time_ and arg_95_1.time_ < var_98_45 + var_98_46 then
				local var_98_47 = (arg_95_1.time_ - var_98_45) / var_98_46
				local var_98_48 = Vector3.New(0, 100, 0)

				var_98_44.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10066ui_story, var_98_48, var_98_47)

				local var_98_49 = manager.ui.mainCamera.transform.position - var_98_44.position

				var_98_44.forward = Vector3.New(var_98_49.x, var_98_49.y, var_98_49.z)

				local var_98_50 = var_98_44.localEulerAngles

				var_98_50.z = 0
				var_98_50.x = 0
				var_98_44.localEulerAngles = var_98_50
			end

			if arg_95_1.time_ >= var_98_45 + var_98_46 and arg_95_1.time_ < var_98_45 + var_98_46 + arg_98_0 then
				var_98_44.localPosition = Vector3.New(0, 100, 0)

				local var_98_51 = manager.ui.mainCamera.transform.position - var_98_44.position

				var_98_44.forward = Vector3.New(var_98_51.x, var_98_51.y, var_98_51.z)

				local var_98_52 = var_98_44.localEulerAngles

				var_98_52.z = 0
				var_98_52.x = 0
				var_98_44.localEulerAngles = var_98_52
			end

			local var_98_53 = arg_95_1.actors_["10066ui_story"]
			local var_98_54 = 0

			if var_98_54 < arg_95_1.time_ and arg_95_1.time_ <= var_98_54 + arg_98_0 and not isNil(var_98_53) and arg_95_1.var_.characterEffect10066ui_story == nil then
				arg_95_1.var_.characterEffect10066ui_story = var_98_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_55 = 0.200000002980232

			if var_98_54 <= arg_95_1.time_ and arg_95_1.time_ < var_98_54 + var_98_55 and not isNil(var_98_53) then
				local var_98_56 = (arg_95_1.time_ - var_98_54) / var_98_55

				if arg_95_1.var_.characterEffect10066ui_story and not isNil(var_98_53) then
					local var_98_57 = Mathf.Lerp(0, 0.5, var_98_56)

					arg_95_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10066ui_story.fillRatio = var_98_57
				end
			end

			if arg_95_1.time_ >= var_98_54 + var_98_55 and arg_95_1.time_ < var_98_54 + var_98_55 + arg_98_0 and not isNil(var_98_53) and arg_95_1.var_.characterEffect10066ui_story then
				local var_98_58 = 0.5

				arg_95_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10066ui_story.fillRatio = var_98_58
			end

			local var_98_59 = 0
			local var_98_60 = 0.2

			if var_98_59 < arg_95_1.time_ and arg_95_1.time_ <= var_98_59 + arg_98_0 then
				local var_98_61 = "play"
				local var_98_62 = "music"

				arg_95_1:AudioAction(var_98_61, var_98_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_98_63 = ""
				local var_98_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_98_64 ~= "" then
					if arg_95_1.bgmTxt_.text ~= var_98_64 and arg_95_1.bgmTxt_.text ~= "" then
						if arg_95_1.bgmTxt2_.text ~= "" then
							arg_95_1.bgmTxt_.text = arg_95_1.bgmTxt2_.text
						end

						arg_95_1.bgmTxt2_.text = var_98_64

						arg_95_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_95_1.bgmTxt_.text = var_98_64
						arg_95_1.bgmTxt2_.text = var_98_64
					end

					if arg_95_1.bgmTimer then
						arg_95_1.bgmTimer:Stop()

						arg_95_1.bgmTimer = nil
					end

					if arg_95_1.settingData.show_music_name == 1 then
						arg_95_1.musicController:SetSelectedState("show")
						arg_95_1.musicAnimator_:Play("open", 0, 0)

						if arg_95_1.settingData.music_time ~= 0 then
							arg_95_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_95_1.settingData.music_time), function()
								if arg_95_1 == nil or isNil(arg_95_1.bgmTxt_) then
									return
								end

								arg_95_1.musicController:SetSelectedState("hide")
								arg_95_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_98_65 = 0.233333333333333
			local var_98_66 = 1

			if var_98_65 < arg_95_1.time_ and arg_95_1.time_ <= var_98_65 + arg_98_0 then
				local var_98_67 = "play"
				local var_98_68 = "music"

				arg_95_1:AudioAction(var_98_67, var_98_68, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_98_69 = ""
				local var_98_70 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_98_70 ~= "" then
					if arg_95_1.bgmTxt_.text ~= var_98_70 and arg_95_1.bgmTxt_.text ~= "" then
						if arg_95_1.bgmTxt2_.text ~= "" then
							arg_95_1.bgmTxt_.text = arg_95_1.bgmTxt2_.text
						end

						arg_95_1.bgmTxt2_.text = var_98_70

						arg_95_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_95_1.bgmTxt_.text = var_98_70
						arg_95_1.bgmTxt2_.text = var_98_70
					end

					if arg_95_1.bgmTimer then
						arg_95_1.bgmTimer:Stop()

						arg_95_1.bgmTimer = nil
					end

					if arg_95_1.settingData.show_music_name == 1 then
						arg_95_1.musicController:SetSelectedState("show")
						arg_95_1.musicAnimator_:Play("open", 0, 0)

						if arg_95_1.settingData.music_time ~= 0 then
							arg_95_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_95_1.settingData.music_time), function()
								if arg_95_1 == nil or isNil(arg_95_1.bgmTxt_) then
									return
								end

								arg_95_1.musicController:SetSelectedState("hide")
								arg_95_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_71 = 2.96666666666667
			local var_98_72 = 0.875

			if var_98_71 < arg_95_1.time_ and arg_95_1.time_ <= var_98_71 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_73 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_73:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_95_1.dialogCg_.alpha = arg_101_0
				end))
				var_98_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_74 = arg_95_1:GetWordFromCfg(319791023)
				local var_98_75 = arg_95_1:FormatText(var_98_74.content)

				arg_95_1.text_.text = var_98_75

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_76 = 35
				local var_98_77 = utf8.len(var_98_75)
				local var_98_78 = var_98_76 <= 0 and var_98_72 or var_98_72 * (var_98_77 / var_98_76)

				if var_98_78 > 0 and var_98_72 < var_98_78 then
					arg_95_1.talkMaxDuration = var_98_78
					var_98_71 = var_98_71 + 0.3

					if var_98_78 + var_98_71 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_78 + var_98_71
					end
				end

				arg_95_1.text_.text = var_98_75
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_79 = var_98_71 + 0.3
			local var_98_80 = math.max(var_98_72, arg_95_1.talkMaxDuration)

			if var_98_79 <= arg_95_1.time_ and arg_95_1.time_ < var_98_79 + var_98_80 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_79) / var_98_80

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_79 + var_98_80 and arg_95_1.time_ < var_98_79 + var_98_80 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play319791024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319791024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319791025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.875

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(319791024)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 35
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319791025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319791025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319791026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.875

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(319791025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 35
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319791026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319791026
		arg_111_1.duration_ = 3.2

		local var_111_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319791027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1095ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1095ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1095ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1095ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1095ui_story == nil then
				arg_111_1.var_.characterEffect1095ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect1095ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1095ui_story then
				arg_111_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_15 = 0
			local var_114_16 = 0.15

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[471].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(319791026)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791026", "story_v_out_319791.awb") ~= 0 then
					local var_114_23 = manager.audio:GetVoiceLength("story_v_out_319791", "319791026", "story_v_out_319791.awb") / 1000

					if var_114_23 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_15
					end

					if var_114_18.prefab_name ~= "" and arg_111_1.actors_[var_114_18.prefab_name] ~= nil then
						local var_114_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_18.prefab_name].transform, "story_v_out_319791", "319791026", "story_v_out_319791.awb")

						arg_111_1:RecordAudio("319791026", var_114_24)
						arg_111_1:RecordAudio("319791026", var_114_24)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319791", "319791026", "story_v_out_319791.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319791", "319791026", "story_v_out_319791.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_25 and arg_111_1.time_ < var_114_15 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play319791027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319791027
		arg_115_1.duration_ = 7.37

		local var_115_0 = {
			zh = 3.766,
			ja = 7.366
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319791028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1084ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0.7, -0.97, -6)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1084ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_118_15 = arg_115_1.actors_["1095ui_story"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos1095ui_story = var_118_15.localPosition
			end

			local var_118_17 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17
				local var_118_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1095ui_story, var_118_19, var_118_18)

				local var_118_20 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_20.x, var_118_20.y, var_118_20.z)

				local var_118_21 = var_118_15.localEulerAngles

				var_118_21.z = 0
				var_118_21.x = 0
				var_118_15.localEulerAngles = var_118_21
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_118_22 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_22.x, var_118_22.y, var_118_22.z)

				local var_118_23 = var_118_15.localEulerAngles

				var_118_23.z = 0
				var_118_23.x = 0
				var_118_15.localEulerAngles = var_118_23
			end

			local var_118_24 = arg_115_1.actors_["1095ui_story"]
			local var_118_25 = 0

			if var_118_25 < arg_115_1.time_ and arg_115_1.time_ <= var_118_25 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = var_118_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_26 = 0.200000002980232

			if var_118_25 <= arg_115_1.time_ and arg_115_1.time_ < var_118_25 + var_118_26 and not isNil(var_118_24) then
				local var_118_27 = (arg_115_1.time_ - var_118_25) / var_118_26

				if arg_115_1.var_.characterEffect1095ui_story and not isNil(var_118_24) then
					local var_118_28 = Mathf.Lerp(0, 0.5, var_118_27)

					arg_115_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1095ui_story.fillRatio = var_118_28
				end
			end

			if arg_115_1.time_ >= var_118_25 + var_118_26 and arg_115_1.time_ < var_118_25 + var_118_26 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect1095ui_story then
				local var_118_29 = 0.5

				arg_115_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1095ui_story.fillRatio = var_118_29
			end

			local var_118_30 = 0
			local var_118_31 = 0.45

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[6].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(319791027)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 18
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791027", "story_v_out_319791.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_319791", "319791027", "story_v_out_319791.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_319791", "319791027", "story_v_out_319791.awb")

						arg_115_1:RecordAudio("319791027", var_118_39)
						arg_115_1:RecordAudio("319791027", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319791", "319791027", "story_v_out_319791.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319791", "319791027", "story_v_out_319791.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_115_1:InitPlayNodeList()
	end,
	Play319791028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319791028
		arg_119_1.duration_ = 11

		local var_119_0 = {
			zh = 6.8,
			ja = 11
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play319791029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[6].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(319791028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 40
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791028", "story_v_out_319791.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791028", "story_v_out_319791.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_319791", "319791028", "story_v_out_319791.awb")

						arg_119_1:RecordAudio("319791028", var_122_9)
						arg_119_1:RecordAudio("319791028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319791", "319791028", "story_v_out_319791.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319791", "319791028", "story_v_out_319791.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319791029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319791029
		arg_123_1.duration_ = 10

		local var_123_0 = {
			zh = 6.9,
			ja = 10
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319791030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.825

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(319791029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 33
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791029", "story_v_out_319791.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791029", "story_v_out_319791.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_319791", "319791029", "story_v_out_319791.awb")

						arg_123_1:RecordAudio("319791029", var_126_9)
						arg_123_1:RecordAudio("319791029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319791", "319791029", "story_v_out_319791.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319791", "319791029", "story_v_out_319791.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319791030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319791030
		arg_127_1.duration_ = 3.67

		local var_127_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319791031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_130_2 = 0
			local var_130_3 = 0.125

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_4 = arg_127_1:FormatText(StoryNameCfg[6].name)

				arg_127_1.leftNameTxt_.text = var_130_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_5 = arg_127_1:GetWordFromCfg(319791030)
				local var_130_6 = arg_127_1:FormatText(var_130_5.content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 5
				local var_130_8 = utf8.len(var_130_6)
				local var_130_9 = var_130_7 <= 0 and var_130_3 or var_130_3 * (var_130_8 / var_130_7)

				if var_130_9 > 0 and var_130_3 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791030", "story_v_out_319791.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319791", "319791030", "story_v_out_319791.awb") / 1000

					if var_130_10 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_2
					end

					if var_130_5.prefab_name ~= "" and arg_127_1.actors_[var_130_5.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_5.prefab_name].transform, "story_v_out_319791", "319791030", "story_v_out_319791.awb")

						arg_127_1:RecordAudio("319791030", var_130_11)
						arg_127_1:RecordAudio("319791030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319791", "319791030", "story_v_out_319791.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319791", "319791030", "story_v_out_319791.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_12 and arg_127_1.time_ < var_130_2 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319791031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319791031
		arg_131_1.duration_ = 2.5

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319791032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1095ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1095ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1095ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1095ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1095ui_story == nil then
				arg_131_1.var_.characterEffect1095ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1095ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1095ui_story then
				arg_131_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = arg_131_1.actors_["1084ui_story"]
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_17 = 0.200000002980232

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 and not isNil(var_134_15) then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17

				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_15) then
					local var_134_19 = Mathf.Lerp(0, 0.5, var_134_18)

					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = var_134_19
				end
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.characterEffect1084ui_story then
				local var_134_20 = 0.5

				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = var_134_20
			end

			local var_134_21 = 0
			local var_134_22 = 0.225

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_23 = arg_131_1:FormatText(StoryNameCfg[471].name)

				arg_131_1.leftNameTxt_.text = var_134_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_24 = arg_131_1:GetWordFromCfg(319791031)
				local var_134_25 = arg_131_1:FormatText(var_134_24.content)

				arg_131_1.text_.text = var_134_25

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_26 = 9
				local var_134_27 = utf8.len(var_134_25)
				local var_134_28 = var_134_26 <= 0 and var_134_22 or var_134_22 * (var_134_27 / var_134_26)

				if var_134_28 > 0 and var_134_22 < var_134_28 then
					arg_131_1.talkMaxDuration = var_134_28

					if var_134_28 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_28 + var_134_21
					end
				end

				arg_131_1.text_.text = var_134_25
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791031", "story_v_out_319791.awb") ~= 0 then
					local var_134_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791031", "story_v_out_319791.awb") / 1000

					if var_134_29 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_21
					end

					if var_134_24.prefab_name ~= "" and arg_131_1.actors_[var_134_24.prefab_name] ~= nil then
						local var_134_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_24.prefab_name].transform, "story_v_out_319791", "319791031", "story_v_out_319791.awb")

						arg_131_1:RecordAudio("319791031", var_134_30)
						arg_131_1:RecordAudio("319791031", var_134_30)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319791", "319791031", "story_v_out_319791.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319791", "319791031", "story_v_out_319791.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_31 = math.max(var_134_22, arg_131_1.talkMaxDuration)

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_31 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_21) / var_134_31

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_21 + var_134_31 and arg_131_1.time_ < var_134_21 + var_134_31 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play319791032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319791032
		arg_135_1.duration_ = 3.27

		local var_135_0 = {
			zh = 3.066,
			ja = 3.266
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319791033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1095ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1095ui_story == nil then
				arg_135_1.var_.characterEffect1095ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1095ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1095ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1095ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1095ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["1084ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_138_11 = 0
			local var_138_12 = 0.35

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_13 = arg_135_1:FormatText(StoryNameCfg[6].name)

				arg_135_1.leftNameTxt_.text = var_138_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(319791032)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 14
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_12 or var_138_12 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_12 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791032", "story_v_out_319791.awb") ~= 0 then
					local var_138_19 = manager.audio:GetVoiceLength("story_v_out_319791", "319791032", "story_v_out_319791.awb") / 1000

					if var_138_19 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_11
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_out_319791", "319791032", "story_v_out_319791.awb")

						arg_135_1:RecordAudio("319791032", var_138_20)
						arg_135_1:RecordAudio("319791032", var_138_20)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319791", "319791032", "story_v_out_319791.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319791", "319791032", "story_v_out_319791.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_21 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_21 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_21

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_21 and arg_135_1.time_ < var_138_11 + var_138_21 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319791033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319791033
		arg_139_1.duration_ = 4.83

		local var_139_0 = {
			zh = 2.8,
			ja = 4.833
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play319791034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1084ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1084ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_5
			end

			local var_142_6 = arg_139_1.actors_["1095ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_142_10 = 0
			local var_142_11 = 0.375

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_12 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_13 = arg_139_1:GetWordFromCfg(319791033)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_15 = 15
				local var_142_16 = utf8.len(var_142_14)
				local var_142_17 = var_142_15 <= 0 and var_142_11 or var_142_11 * (var_142_16 / var_142_15)

				if var_142_17 > 0 and var_142_11 < var_142_17 then
					arg_139_1.talkMaxDuration = var_142_17

					if var_142_17 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_10
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791033", "story_v_out_319791.awb") ~= 0 then
					local var_142_18 = manager.audio:GetVoiceLength("story_v_out_319791", "319791033", "story_v_out_319791.awb") / 1000

					if var_142_18 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_10
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_319791", "319791033", "story_v_out_319791.awb")

						arg_139_1:RecordAudio("319791033", var_142_19)
						arg_139_1:RecordAudio("319791033", var_142_19)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319791", "319791033", "story_v_out_319791.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319791", "319791033", "story_v_out_319791.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = math.max(var_142_11, arg_139_1.talkMaxDuration)

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_10) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_10 + var_142_20 and arg_139_1.time_ < var_142_10 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319791034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319791034
		arg_143_1.duration_ = 14.13

		local var_143_0 = {
			zh = 5.1,
			ja = 14.133
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play319791035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1084ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1084ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0.7, -0.97, -6)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1084ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_11 = 0
			local var_146_12 = 0.6

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[471].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(319791034)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 24
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791034", "story_v_out_319791.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_319791", "319791034", "story_v_out_319791.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_319791", "319791034", "story_v_out_319791.awb")

						arg_143_1:RecordAudio("319791034", var_146_20)
						arg_143_1:RecordAudio("319791034", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319791", "319791034", "story_v_out_319791.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319791", "319791034", "story_v_out_319791.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319791035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319791035
		arg_147_1.duration_ = 12.33

		local var_147_0 = {
			zh = 12.333,
			ja = 9.066
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
				arg_147_0:Play319791036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1095ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1095ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1095ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1084ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1084ui_story == nil then
				arg_147_1.var_.characterEffect1084ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1084ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1084ui_story then
				arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_150_13 = arg_147_1.actors_["1095ui_story"]
			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.characterEffect1095ui_story == nil then
				arg_147_1.var_.characterEffect1095ui_story = var_150_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_15 = 0.200000002980232

			if var_150_14 <= arg_147_1.time_ and arg_147_1.time_ < var_150_14 + var_150_15 and not isNil(var_150_13) then
				local var_150_16 = (arg_147_1.time_ - var_150_14) / var_150_15

				if arg_147_1.var_.characterEffect1095ui_story and not isNil(var_150_13) then
					local var_150_17 = Mathf.Lerp(0, 0.5, var_150_16)

					arg_147_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1095ui_story.fillRatio = var_150_17
				end
			end

			if arg_147_1.time_ >= var_150_14 + var_150_15 and arg_147_1.time_ < var_150_14 + var_150_15 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.characterEffect1095ui_story then
				local var_150_18 = 0.5

				arg_147_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1095ui_story.fillRatio = var_150_18
			end

			local var_150_19 = 0
			local var_150_20 = 1.375

			if var_150_19 < arg_147_1.time_ and arg_147_1.time_ <= var_150_19 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_21 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_22 = arg_147_1:GetWordFromCfg(319791035)
				local var_150_23 = arg_147_1:FormatText(var_150_22.content)

				arg_147_1.text_.text = var_150_23

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_24 = 55
				local var_150_25 = utf8.len(var_150_23)
				local var_150_26 = var_150_24 <= 0 and var_150_20 or var_150_20 * (var_150_25 / var_150_24)

				if var_150_26 > 0 and var_150_20 < var_150_26 then
					arg_147_1.talkMaxDuration = var_150_26

					if var_150_26 + var_150_19 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_26 + var_150_19
					end
				end

				arg_147_1.text_.text = var_150_23
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791035", "story_v_out_319791.awb") ~= 0 then
					local var_150_27 = manager.audio:GetVoiceLength("story_v_out_319791", "319791035", "story_v_out_319791.awb") / 1000

					if var_150_27 + var_150_19 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_27 + var_150_19
					end

					if var_150_22.prefab_name ~= "" and arg_147_1.actors_[var_150_22.prefab_name] ~= nil then
						local var_150_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_22.prefab_name].transform, "story_v_out_319791", "319791035", "story_v_out_319791.awb")

						arg_147_1:RecordAudio("319791035", var_150_28)
						arg_147_1:RecordAudio("319791035", var_150_28)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319791", "319791035", "story_v_out_319791.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319791", "319791035", "story_v_out_319791.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_29 = math.max(var_150_20, arg_147_1.talkMaxDuration)

			if var_150_19 <= arg_147_1.time_ and arg_147_1.time_ < var_150_19 + var_150_29 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_19) / var_150_29

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_19 + var_150_29 and arg_147_1.time_ < var_150_19 + var_150_29 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play319791036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319791036
		arg_151_1.duration_ = 14.43

		local var_151_0 = {
			zh = 8.7,
			ja = 14.433
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319791037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_154_2 = 0
			local var_154_3 = 1.1

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_4 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:GetWordFromCfg(319791036)
				local var_154_6 = arg_151_1:FormatText(var_154_5.content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 44
				local var_154_8 = utf8.len(var_154_6)
				local var_154_9 = var_154_7 <= 0 and var_154_3 or var_154_3 * (var_154_8 / var_154_7)

				if var_154_9 > 0 and var_154_3 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791036", "story_v_out_319791.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_319791", "319791036", "story_v_out_319791.awb") / 1000

					if var_154_10 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_2
					end

					if var_154_5.prefab_name ~= "" and arg_151_1.actors_[var_154_5.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_5.prefab_name].transform, "story_v_out_319791", "319791036", "story_v_out_319791.awb")

						arg_151_1:RecordAudio("319791036", var_154_11)
						arg_151_1:RecordAudio("319791036", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319791", "319791036", "story_v_out_319791.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319791", "319791036", "story_v_out_319791.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_12 and arg_151_1.time_ < var_154_2 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319791037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319791037
		arg_155_1.duration_ = 7.07

		local var_155_0 = {
			zh = 3.8,
			ja = 7.066
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
				arg_155_0:Play319791038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.425

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[6].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(319791037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 17
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791037", "story_v_out_319791.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791037", "story_v_out_319791.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_319791", "319791037", "story_v_out_319791.awb")

						arg_155_1:RecordAudio("319791037", var_158_9)
						arg_155_1:RecordAudio("319791037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319791", "319791037", "story_v_out_319791.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319791", "319791037", "story_v_out_319791.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319791038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319791038
		arg_159_1.duration_ = 8.43

		local var_159_0 = {
			zh = 4.6,
			ja = 8.433
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
				arg_159_0:Play319791039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1095ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1095ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1095ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1095ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1095ui_story == nil then
				arg_159_1.var_.characterEffect1095ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1095ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1095ui_story then
				arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_15 = arg_159_1.actors_["1084ui_story"]
			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_17 = 0.200000002980232

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 and not isNil(var_162_15) then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17

				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_15) then
					local var_162_19 = Mathf.Lerp(0, 0.5, var_162_18)

					arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1084ui_story.fillRatio = var_162_19
				end
			end

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.characterEffect1084ui_story then
				local var_162_20 = 0.5

				arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1084ui_story.fillRatio = var_162_20
			end

			local var_162_21 = 0
			local var_162_22 = 0.525

			if var_162_21 < arg_159_1.time_ and arg_159_1.time_ <= var_162_21 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_23 = arg_159_1:FormatText(StoryNameCfg[471].name)

				arg_159_1.leftNameTxt_.text = var_162_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_24 = arg_159_1:GetWordFromCfg(319791038)
				local var_162_25 = arg_159_1:FormatText(var_162_24.content)

				arg_159_1.text_.text = var_162_25

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_26 = 21
				local var_162_27 = utf8.len(var_162_25)
				local var_162_28 = var_162_26 <= 0 and var_162_22 or var_162_22 * (var_162_27 / var_162_26)

				if var_162_28 > 0 and var_162_22 < var_162_28 then
					arg_159_1.talkMaxDuration = var_162_28

					if var_162_28 + var_162_21 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_28 + var_162_21
					end
				end

				arg_159_1.text_.text = var_162_25
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791038", "story_v_out_319791.awb") ~= 0 then
					local var_162_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791038", "story_v_out_319791.awb") / 1000

					if var_162_29 + var_162_21 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_29 + var_162_21
					end

					if var_162_24.prefab_name ~= "" and arg_159_1.actors_[var_162_24.prefab_name] ~= nil then
						local var_162_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_24.prefab_name].transform, "story_v_out_319791", "319791038", "story_v_out_319791.awb")

						arg_159_1:RecordAudio("319791038", var_162_30)
						arg_159_1:RecordAudio("319791038", var_162_30)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319791", "319791038", "story_v_out_319791.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319791", "319791038", "story_v_out_319791.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_31 = math.max(var_162_22, arg_159_1.talkMaxDuration)

			if var_162_21 <= arg_159_1.time_ and arg_159_1.time_ < var_162_21 + var_162_31 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_21) / var_162_31

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_21 + var_162_31 and arg_159_1.time_ < var_162_21 + var_162_31 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play319791039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319791039
		arg_163_1.duration_ = 10.3

		local var_163_0 = {
			zh = 4.7,
			ja = 10.3
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
				arg_163_0:Play319791040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.575

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[471].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(319791039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 23
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791039", "story_v_out_319791.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791039", "story_v_out_319791.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_319791", "319791039", "story_v_out_319791.awb")

						arg_163_1:RecordAudio("319791039", var_166_9)
						arg_163_1:RecordAudio("319791039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319791", "319791039", "story_v_out_319791.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319791", "319791039", "story_v_out_319791.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play319791040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319791040
		arg_167_1.duration_ = 2.47

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319791041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_170_2 = arg_167_1.actors_["1095ui_story"]
			local var_170_3 = 0

			if var_170_3 < arg_167_1.time_ and arg_167_1.time_ <= var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1095ui_story == nil then
				arg_167_1.var_.characterEffect1095ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if var_170_3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_3 + var_170_4 and not isNil(var_170_2) then
				local var_170_5 = (arg_167_1.time_ - var_170_3) / var_170_4

				if arg_167_1.var_.characterEffect1095ui_story and not isNil(var_170_2) then
					local var_170_6 = Mathf.Lerp(0, 0.5, var_170_5)

					arg_167_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1095ui_story.fillRatio = var_170_6
				end
			end

			if arg_167_1.time_ >= var_170_3 + var_170_4 and arg_167_1.time_ < var_170_3 + var_170_4 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1095ui_story then
				local var_170_7 = 0.5

				arg_167_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1095ui_story.fillRatio = var_170_7
			end

			local var_170_8 = arg_167_1.actors_["1084ui_story"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.characterEffect1084ui_story == nil then
				arg_167_1.var_.characterEffect1084ui_story = var_170_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_10 = 0.200000002980232

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_10 and not isNil(var_170_8) then
				local var_170_11 = (arg_167_1.time_ - var_170_9) / var_170_10

				if arg_167_1.var_.characterEffect1084ui_story and not isNil(var_170_8) then
					arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_10 and arg_167_1.time_ < var_170_9 + var_170_10 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.characterEffect1084ui_story then
				arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_170_12 = 0
			local var_170_13 = 0.15

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_14 = arg_167_1:FormatText(StoryNameCfg[6].name)

				arg_167_1.leftNameTxt_.text = var_170_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_15 = arg_167_1:GetWordFromCfg(319791040)
				local var_170_16 = arg_167_1:FormatText(var_170_15.content)

				arg_167_1.text_.text = var_170_16

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 6
				local var_170_18 = utf8.len(var_170_16)
				local var_170_19 = var_170_17 <= 0 and var_170_13 or var_170_13 * (var_170_18 / var_170_17)

				if var_170_19 > 0 and var_170_13 < var_170_19 then
					arg_167_1.talkMaxDuration = var_170_19

					if var_170_19 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_16
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791040", "story_v_out_319791.awb") ~= 0 then
					local var_170_20 = manager.audio:GetVoiceLength("story_v_out_319791", "319791040", "story_v_out_319791.awb") / 1000

					if var_170_20 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_20 + var_170_12
					end

					if var_170_15.prefab_name ~= "" and arg_167_1.actors_[var_170_15.prefab_name] ~= nil then
						local var_170_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_15.prefab_name].transform, "story_v_out_319791", "319791040", "story_v_out_319791.awb")

						arg_167_1:RecordAudio("319791040", var_170_21)
						arg_167_1:RecordAudio("319791040", var_170_21)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319791", "319791040", "story_v_out_319791.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319791", "319791040", "story_v_out_319791.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_22 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_22 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_22

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_22 and arg_167_1.time_ < var_170_12 + var_170_22 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319791041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319791041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play319791042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				local var_174_1 = arg_171_1.fswbg_.transform:Find("textbox/adapt/content") or arg_171_1.fswbg_.transform:Find("textbox/content")
				local var_174_2 = arg_171_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_174_3 = var_174_1:GetComponent("Text")
				local var_174_4 = var_174_1:GetComponent("RectTransform")

				var_174_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_174_4.offsetMin = Vector2.New(0, 0)
				var_174_4.offsetMax = Vector2.New(0, 0)
			end

			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.fswbg_:SetActive(true)
				arg_171_1.dialog_:SetActive(false)

				arg_171_1.fswtw_.percent = 0

				local var_174_6 = arg_171_1:GetWordFromCfg(319791041)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.fswt_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.fswt_)

				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_171_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_171_1.fswtw_:SetDirty()

				arg_171_1.typewritterCharCountI18N = 0

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_8 = 0.533333333333333

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.var_.oldValueTypewriter = arg_171_1.fswtw_.percent

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_9 = 16
			local var_174_10 = 1.06666666666667
			local var_174_11 = arg_171_1:GetWordFromCfg(319791041)
			local var_174_12 = arg_171_1:FormatText(var_174_11.content)
			local var_174_13, var_174_14 = arg_171_1:GetPercentByPara(var_174_12, 1)

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				local var_174_15 = var_174_9 <= 0 and var_174_10 or var_174_10 * ((var_174_14 - arg_171_1.typewritterCharCountI18N) / var_174_9)

				if var_174_15 > 0 and var_174_10 < var_174_15 then
					arg_171_1.talkMaxDuration = var_174_15

					if var_174_15 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_8
					end
				end
			end

			local var_174_16 = 1.06666666666667
			local var_174_17 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_8) / var_174_17

				arg_171_1.fswtw_.percent = Mathf.Lerp(arg_171_1.var_.oldValueTypewriter, var_174_13, var_174_18)
				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.fswtw_:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_17 and arg_171_1.time_ < var_174_8 + var_174_17 + arg_174_0 then
				arg_171_1.fswtw_.percent = var_174_13

				arg_171_1.fswtw_:SetDirty()
				arg_171_1:ShowNextGo(true)

				arg_171_1.typewritterCharCountI18N = var_174_14
			end

			local var_174_19 = "STblack"

			if arg_171_1.bgs_[var_174_19] == nil then
				local var_174_20 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_19)
				var_174_20.name = var_174_19
				var_174_20.transform.parent = arg_171_1.stage_.transform
				var_174_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_19] = var_174_20
			end

			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				local var_174_22 = manager.ui.mainCamera.transform.localPosition
				local var_174_23 = Vector3.New(0, 0, 10) + Vector3.New(var_174_22.x, var_174_22.y, 0)
				local var_174_24 = arg_171_1.bgs_.STblack

				var_174_24.transform.localPosition = var_174_23
				var_174_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_25 = var_174_24:GetComponent("SpriteRenderer")

				if var_174_25 and var_174_25.sprite then
					local var_174_26 = (var_174_24.transform.localPosition - var_174_22).z
					local var_174_27 = manager.ui.mainCameraCom_
					local var_174_28 = 2 * var_174_26 * Mathf.Tan(var_174_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_29 = var_174_28 * var_174_27.aspect
					local var_174_30 = var_174_25.sprite.bounds.size.x
					local var_174_31 = var_174_25.sprite.bounds.size.y
					local var_174_32 = var_174_29 / var_174_30
					local var_174_33 = var_174_28 / var_174_31
					local var_174_34 = var_174_33 < var_174_32 and var_174_32 or var_174_33

					var_174_24.transform.localScale = Vector3.New(var_174_34, var_174_34, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "STblack" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_35 = arg_171_1.actors_["1095ui_story"].transform
			local var_174_36 = 0

			if var_174_36 < arg_171_1.time_ and arg_171_1.time_ <= var_174_36 + arg_174_0 then
				arg_171_1.var_.moveOldPos1095ui_story = var_174_35.localPosition
			end

			local var_174_37 = 0.001

			if var_174_36 <= arg_171_1.time_ and arg_171_1.time_ < var_174_36 + var_174_37 then
				local var_174_38 = (arg_171_1.time_ - var_174_36) / var_174_37
				local var_174_39 = Vector3.New(0, 100, 0)

				var_174_35.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1095ui_story, var_174_39, var_174_38)

				local var_174_40 = manager.ui.mainCamera.transform.position - var_174_35.position

				var_174_35.forward = Vector3.New(var_174_40.x, var_174_40.y, var_174_40.z)

				local var_174_41 = var_174_35.localEulerAngles

				var_174_41.z = 0
				var_174_41.x = 0
				var_174_35.localEulerAngles = var_174_41
			end

			if arg_171_1.time_ >= var_174_36 + var_174_37 and arg_171_1.time_ < var_174_36 + var_174_37 + arg_174_0 then
				var_174_35.localPosition = Vector3.New(0, 100, 0)

				local var_174_42 = manager.ui.mainCamera.transform.position - var_174_35.position

				var_174_35.forward = Vector3.New(var_174_42.x, var_174_42.y, var_174_42.z)

				local var_174_43 = var_174_35.localEulerAngles

				var_174_43.z = 0
				var_174_43.x = 0
				var_174_35.localEulerAngles = var_174_43
			end

			local var_174_44 = arg_171_1.actors_["1084ui_story"].transform
			local var_174_45 = 0

			if var_174_45 < arg_171_1.time_ and arg_171_1.time_ <= var_174_45 + arg_174_0 then
				arg_171_1.var_.moveOldPos1084ui_story = var_174_44.localPosition
			end

			local var_174_46 = 0.001

			if var_174_45 <= arg_171_1.time_ and arg_171_1.time_ < var_174_45 + var_174_46 then
				local var_174_47 = (arg_171_1.time_ - var_174_45) / var_174_46
				local var_174_48 = Vector3.New(0, 100, 0)

				var_174_44.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1084ui_story, var_174_48, var_174_47)

				local var_174_49 = manager.ui.mainCamera.transform.position - var_174_44.position

				var_174_44.forward = Vector3.New(var_174_49.x, var_174_49.y, var_174_49.z)

				local var_174_50 = var_174_44.localEulerAngles

				var_174_50.z = 0
				var_174_50.x = 0
				var_174_44.localEulerAngles = var_174_50
			end

			if arg_171_1.time_ >= var_174_45 + var_174_46 and arg_171_1.time_ < var_174_45 + var_174_46 + arg_174_0 then
				var_174_44.localPosition = Vector3.New(0, 100, 0)

				local var_174_51 = manager.ui.mainCamera.transform.position - var_174_44.position

				var_174_44.forward = Vector3.New(var_174_51.x, var_174_51.y, var_174_51.z)

				local var_174_52 = var_174_44.localEulerAngles

				var_174_52.z = 0
				var_174_52.x = 0
				var_174_44.localEulerAngles = var_174_52
			end

			local var_174_53 = 0.533333333333333
			local var_174_54 = 3.7
			local var_174_55 = manager.audio:GetVoiceLength("story_v_out_319791", "319791041", "story_v_out_319791.awb") / 1000

			if var_174_55 > 0 and var_174_54 < var_174_55 and var_174_55 + var_174_53 > arg_171_1.duration_ then
				local var_174_56 = var_174_55

				arg_171_1.duration_ = var_174_55 + var_174_53
			end

			if var_174_53 < arg_171_1.time_ and arg_171_1.time_ <= var_174_53 + arg_174_0 then
				local var_174_57 = "play"
				local var_174_58 = "voice"

				arg_171_1:AudioAction(var_174_57, var_174_58, "story_v_out_319791", "319791041", "story_v_out_319791.awb")
			end

			local var_174_59 = 0

			if var_174_59 < arg_171_1.time_ and arg_171_1.time_ <= var_174_59 + arg_174_0 then
				arg_171_1.cswbg_:SetActive(true)

				local var_174_60 = arg_171_1.cswt_:GetComponent("RectTransform")

				arg_171_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_174_60.offsetMin = Vector2.New(410, 330)
				var_174_60.offsetMax = Vector2.New(-400, -175)

				local var_174_61 = arg_171_1:GetWordFromCfg(419054)
				local var_174_62 = arg_171_1:FormatText(var_174_61.content)

				arg_171_1.cswt_.text = var_174_62

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.cswt_)

				arg_171_1.cswt_.fontSize = 180
				arg_171_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_171_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play319791042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319791042
		arg_175_1.duration_ = 1.63

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319791043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(true)
				arg_175_1.dialog_:SetActive(false)

				arg_175_1.fswtw_.percent = 0

				local var_178_1 = arg_175_1:GetWordFromCfg(319791042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.fswt_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.fswt_)

				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_175_1.fswtw_:SetDirty()

				arg_175_1.typewritterCharCountI18N = 0

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_3 = 0.333333333333333

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_4 = 3
			local var_178_5 = 0.2
			local var_178_6 = arg_175_1:GetWordFromCfg(319791042)
			local var_178_7 = arg_175_1:FormatText(var_178_6.content)
			local var_178_8, var_178_9 = arg_175_1:GetPercentByPara(var_178_7, 1)

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_10 = var_178_4 <= 0 and var_178_5 or var_178_5 * ((var_178_9 - arg_175_1.typewritterCharCountI18N) / var_178_4)

				if var_178_10 > 0 and var_178_5 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_3
					end
				end
			end

			local var_178_11 = 0.2
			local var_178_12 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_3) / var_178_12

				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_8, var_178_13)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_12 and arg_175_1.time_ < var_178_3 + var_178_12 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_8

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_9
			end

			local var_178_14 = 0.333333333333333
			local var_178_15 = 1.3
			local var_178_16 = manager.audio:GetVoiceLength("story_v_out_319791", "319791042", "story_v_out_319791.awb") / 1000

			if var_178_16 > 0 and var_178_15 < var_178_16 and var_178_16 + var_178_14 > arg_175_1.duration_ then
				local var_178_17 = var_178_16

				arg_175_1.duration_ = var_178_16 + var_178_14
			end

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				local var_178_18 = "play"
				local var_178_19 = "voice"

				arg_175_1:AudioAction(var_178_18, var_178_19, "story_v_out_319791", "319791042", "story_v_out_319791.awb")
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319791043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319791043
		arg_179_1.duration_ = 6.17

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319791044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.fswbg_:SetActive(true)
				arg_179_1.dialog_:SetActive(false)

				arg_179_1.fswtw_.percent = 0

				local var_182_1 = arg_179_1:GetWordFromCfg(319791043)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.fswt_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.fswt_)

				arg_179_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_179_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_179_1.fswtw_:SetDirty()

				arg_179_1.typewritterCharCountI18N = 0

				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_3 = 0.266666666666667

			if var_182_3 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.var_.oldValueTypewriter = arg_179_1.fswtw_.percent

				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_4 = 19
			local var_182_5 = 1.26666666666667
			local var_182_6 = arg_179_1:GetWordFromCfg(319791043)
			local var_182_7 = arg_179_1:FormatText(var_182_6.content)
			local var_182_8, var_182_9 = arg_179_1:GetPercentByPara(var_182_7, 1)

			if var_182_3 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				local var_182_10 = var_182_4 <= 0 and var_182_5 or var_182_5 * ((var_182_9 - arg_179_1.typewritterCharCountI18N) / var_182_4)

				if var_182_10 > 0 and var_182_5 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_3
					end
				end
			end

			local var_182_11 = 1.26666666666667
			local var_182_12 = math.max(var_182_11, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_12 then
				local var_182_13 = (arg_179_1.time_ - var_182_3) / var_182_12

				arg_179_1.fswtw_.percent = Mathf.Lerp(arg_179_1.var_.oldValueTypewriter, var_182_8, var_182_13)
				arg_179_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_179_1.fswtw_:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_12 and arg_179_1.time_ < var_182_3 + var_182_12 + arg_182_0 then
				arg_179_1.fswtw_.percent = var_182_8

				arg_179_1.fswtw_:SetDirty()
				arg_179_1:ShowNextGo(true)

				arg_179_1.typewritterCharCountI18N = var_182_9
			end

			local var_182_14 = 0.266666666666667
			local var_182_15 = 5.9
			local var_182_16 = manager.audio:GetVoiceLength("story_v_out_319791", "319791043", "story_v_out_319791.awb") / 1000

			if var_182_16 > 0 and var_182_15 < var_182_16 and var_182_16 + var_182_14 > arg_179_1.duration_ then
				local var_182_17 = var_182_16

				arg_179_1.duration_ = var_182_16 + var_182_14
			end

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 then
				local var_182_18 = "play"
				local var_182_19 = "voice"

				arg_179_1:AudioAction(var_182_18, var_182_19, "story_v_out_319791", "319791043", "story_v_out_319791.awb")
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319791044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319791044
		arg_183_1.duration_ = 3.57

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319791045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.fswbg_:SetActive(true)
				arg_183_1.dialog_:SetActive(false)

				arg_183_1.fswtw_.percent = 0

				local var_186_1 = arg_183_1:GetWordFromCfg(319791044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.fswt_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.fswt_)

				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_183_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_183_1.fswtw_:SetDirty()

				arg_183_1.typewritterCharCountI18N = 0

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_3 = 0.266666666666667

			if var_186_3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.var_.oldValueTypewriter = arg_183_1.fswtw_.percent

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_4 = 12
			local var_186_5 = 0.8
			local var_186_6 = arg_183_1:GetWordFromCfg(319791044)
			local var_186_7 = arg_183_1:FormatText(var_186_6.content)
			local var_186_8, var_186_9 = arg_183_1:GetPercentByPara(var_186_7, 1)

			if var_186_3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				local var_186_10 = var_186_4 <= 0 and var_186_5 or var_186_5 * ((var_186_9 - arg_183_1.typewritterCharCountI18N) / var_186_4)

				if var_186_10 > 0 and var_186_5 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_3
					end
				end
			end

			local var_186_11 = 0.8
			local var_186_12 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_3) / var_186_12

				arg_183_1.fswtw_.percent = Mathf.Lerp(arg_183_1.var_.oldValueTypewriter, var_186_8, var_186_13)
				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_183_1.fswtw_:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_12 and arg_183_1.time_ < var_186_3 + var_186_12 + arg_186_0 then
				arg_183_1.fswtw_.percent = var_186_8

				arg_183_1.fswtw_:SetDirty()
				arg_183_1:ShowNextGo(true)

				arg_183_1.typewritterCharCountI18N = var_186_9
			end

			local var_186_14 = 0.266666666666667
			local var_186_15 = 3.3
			local var_186_16 = manager.audio:GetVoiceLength("story_v_out_319791", "319791044", "story_v_out_319791.awb") / 1000

			if var_186_16 > 0 and var_186_15 < var_186_16 and var_186_16 + var_186_14 > arg_183_1.duration_ then
				local var_186_17 = var_186_16

				arg_183_1.duration_ = var_186_16 + var_186_14
			end

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				local var_186_18 = "play"
				local var_186_19 = "voice"

				arg_183_1:AudioAction(var_186_18, var_186_19, "story_v_out_319791", "319791044", "story_v_out_319791.awb")
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319791045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319791045
		arg_187_1.duration_ = 7.83

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319791046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_1 = manager.ui.mainCamera.transform.localPosition
				local var_190_2 = Vector3.New(0, 0, 10) + Vector3.New(var_190_1.x, var_190_1.y, 0)
				local var_190_3 = arg_187_1.bgs_.ST70

				var_190_3.transform.localPosition = var_190_2
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = (var_190_3.transform.localPosition - var_190_1).z
					local var_190_6 = manager.ui.mainCameraCom_
					local var_190_7 = 2 * var_190_5 * Mathf.Tan(var_190_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_8 = var_190_7 * var_190_6.aspect
					local var_190_9 = var_190_4.sprite.bounds.size.x
					local var_190_10 = var_190_4.sprite.bounds.size.y
					local var_190_11 = var_190_8 / var_190_9
					local var_190_12 = var_190_7 / var_190_10
					local var_190_13 = var_190_12 < var_190_11 and var_190_11 or var_190_12

					var_190_3.transform.localScale = Vector3.New(var_190_13, var_190_13, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST70" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_15 = 0.3

			if arg_187_1.time_ >= var_190_14 + var_190_15 and arg_187_1.time_ < var_190_14 + var_190_15 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_17 = 1

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17
				local var_190_19 = Color.New(0, 0, 0)

				var_190_19.a = Mathf.Lerp(0, 1, var_190_18)
				arg_187_1.mask_.color = var_190_19
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				local var_190_20 = Color.New(0, 0, 0)

				var_190_20.a = 1
				arg_187_1.mask_.color = var_190_20
			end

			local var_190_21 = 1

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_22 = 2

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_22 then
				local var_190_23 = (arg_187_1.time_ - var_190_21) / var_190_22
				local var_190_24 = Color.New(0, 0, 0)

				var_190_24.a = Mathf.Lerp(1, 0, var_190_23)
				arg_187_1.mask_.color = var_190_24
			end

			if arg_187_1.time_ >= var_190_21 + var_190_22 and arg_187_1.time_ < var_190_21 + var_190_22 + arg_190_0 then
				local var_190_25 = Color.New(0, 0, 0)
				local var_190_26 = 0

				arg_187_1.mask_.enabled = false
				var_190_25.a = var_190_26
				arg_187_1.mask_.color = var_190_25
			end

			local var_190_27 = 0
			local var_190_28 = 0.2

			if var_190_27 < arg_187_1.time_ and arg_187_1.time_ <= var_190_27 + arg_190_0 then
				local var_190_29 = "play"
				local var_190_30 = "music"

				arg_187_1:AudioAction(var_190_29, var_190_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_190_31 = ""
				local var_190_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_190_32 ~= "" then
					if arg_187_1.bgmTxt_.text ~= var_190_32 and arg_187_1.bgmTxt_.text ~= "" then
						if arg_187_1.bgmTxt2_.text ~= "" then
							arg_187_1.bgmTxt_.text = arg_187_1.bgmTxt2_.text
						end

						arg_187_1.bgmTxt2_.text = var_190_32

						arg_187_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_187_1.bgmTxt_.text = var_190_32
						arg_187_1.bgmTxt2_.text = var_190_32
					end

					if arg_187_1.bgmTimer then
						arg_187_1.bgmTimer:Stop()

						arg_187_1.bgmTimer = nil
					end

					if arg_187_1.settingData.show_music_name == 1 then
						arg_187_1.musicController:SetSelectedState("show")
						arg_187_1.musicAnimator_:Play("open", 0, 0)

						if arg_187_1.settingData.music_time ~= 0 then
							arg_187_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_187_1.settingData.music_time), function()
								if arg_187_1 == nil or isNil(arg_187_1.bgmTxt_) then
									return
								end

								arg_187_1.musicController:SetSelectedState("hide")
								arg_187_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_190_33 = 0.233333333333333
			local var_190_34 = 1

			if var_190_33 < arg_187_1.time_ and arg_187_1.time_ <= var_190_33 + arg_190_0 then
				local var_190_35 = "play"
				local var_190_36 = "music"

				arg_187_1:AudioAction(var_190_35, var_190_36, "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_190_37 = ""
				local var_190_38 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

				if var_190_38 ~= "" then
					if arg_187_1.bgmTxt_.text ~= var_190_38 and arg_187_1.bgmTxt_.text ~= "" then
						if arg_187_1.bgmTxt2_.text ~= "" then
							arg_187_1.bgmTxt_.text = arg_187_1.bgmTxt2_.text
						end

						arg_187_1.bgmTxt2_.text = var_190_38

						arg_187_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_187_1.bgmTxt_.text = var_190_38
						arg_187_1.bgmTxt2_.text = var_190_38
					end

					if arg_187_1.bgmTimer then
						arg_187_1.bgmTimer:Stop()

						arg_187_1.bgmTimer = nil
					end

					if arg_187_1.settingData.show_music_name == 1 then
						arg_187_1.musicController:SetSelectedState("show")
						arg_187_1.musicAnimator_:Play("open", 0, 0)

						if arg_187_1.settingData.music_time ~= 0 then
							arg_187_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_187_1.settingData.music_time), function()
								if arg_187_1 == nil or isNil(arg_187_1.bgmTxt_) then
									return
								end

								arg_187_1.musicController:SetSelectedState("hide")
								arg_187_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_190_39 = 1

			if var_190_39 < arg_187_1.time_ and arg_187_1.time_ <= var_190_39 + arg_190_0 then
				arg_187_1.fswbg_:SetActive(false)
				arg_187_1.dialog_:SetActive(false)
				SetActive(arg_187_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_187_1:ShowNextGo(false)
			end

			local var_190_40 = 1.1

			if var_190_40 < arg_187_1.time_ and arg_187_1.time_ <= var_190_40 + arg_190_0 then
				arg_187_1.fswbg_:SetActive(false)
				arg_187_1.dialog_:SetActive(false)
				SetActive(arg_187_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_187_1:ShowNextGo(false)
			end

			local var_190_41 = 1

			if var_190_41 < arg_187_1.time_ and arg_187_1.time_ <= var_190_41 + arg_190_0 then
				arg_187_1.cswbg_:SetActive(false)
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_42 = 2.83333333333333
			local var_190_43 = 0.8

			if var_190_42 < arg_187_1.time_ and arg_187_1.time_ <= var_190_42 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_44 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_44:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_187_1.dialogCg_.alpha = arg_193_0
				end))
				var_190_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_45 = arg_187_1:GetWordFromCfg(319791045)
				local var_190_46 = arg_187_1:FormatText(var_190_45.content)

				arg_187_1.text_.text = var_190_46

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_47 = 32
				local var_190_48 = utf8.len(var_190_46)
				local var_190_49 = var_190_47 <= 0 and var_190_43 or var_190_43 * (var_190_48 / var_190_47)

				if var_190_49 > 0 and var_190_43 < var_190_49 then
					arg_187_1.talkMaxDuration = var_190_49
					var_190_42 = var_190_42 + 0.3

					if var_190_49 + var_190_42 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_49 + var_190_42
					end
				end

				arg_187_1.text_.text = var_190_46
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_50 = var_190_42 + 0.3
			local var_190_51 = math.max(var_190_43, arg_187_1.talkMaxDuration)

			if var_190_50 <= arg_187_1.time_ and arg_187_1.time_ < var_190_50 + var_190_51 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_50) / var_190_51

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_50 + var_190_51 and arg_187_1.time_ < var_190_50 + var_190_51 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319791046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319791046
		arg_195_1.duration_ = 6.39

		local var_195_0 = {
			zh = 3.258,
			ja = 6.391
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
				arg_195_0:Play319791047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10066ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10066ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -0.99, -5.83)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10066ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["10066ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10066ui_story == nil then
				arg_195_1.var_.characterEffect10066ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect10066ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10066ui_story then
				arg_195_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_15 = 0.725
			local var_198_16 = 0.275

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_17 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_17:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_18 = arg_195_1:FormatText(StoryNameCfg[640].name)

				arg_195_1.leftNameTxt_.text = var_198_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_19 = arg_195_1:GetWordFromCfg(319791046)
				local var_198_20 = arg_195_1:FormatText(var_198_19.content)

				arg_195_1.text_.text = var_198_20

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_21 = 11
				local var_198_22 = utf8.len(var_198_20)
				local var_198_23 = var_198_21 <= 0 and var_198_16 or var_198_16 * (var_198_22 / var_198_21)

				if var_198_23 > 0 and var_198_16 < var_198_23 then
					arg_195_1.talkMaxDuration = var_198_23
					var_198_15 = var_198_15 + 0.3

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_20
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791046", "story_v_out_319791.awb") ~= 0 then
					local var_198_24 = manager.audio:GetVoiceLength("story_v_out_319791", "319791046", "story_v_out_319791.awb") / 1000

					if var_198_24 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_24 + var_198_15
					end

					if var_198_19.prefab_name ~= "" and arg_195_1.actors_[var_198_19.prefab_name] ~= nil then
						local var_198_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_19.prefab_name].transform, "story_v_out_319791", "319791046", "story_v_out_319791.awb")

						arg_195_1:RecordAudio("319791046", var_198_25)
						arg_195_1:RecordAudio("319791046", var_198_25)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319791", "319791046", "story_v_out_319791.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319791", "319791046", "story_v_out_319791.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_26 = var_198_15 + 0.3
			local var_198_27 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_27 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_26) / var_198_27

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_26 + var_198_27 and arg_195_1.time_ < var_198_26 + var_198_27 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play319791047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319791047
		arg_201_1.duration_ = 7.65

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319791048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.ST72

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "ST72" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_15 = 0.3

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_17 = 1

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Color.New(0, 0, 0)

				var_204_19.a = Mathf.Lerp(0, 1, var_204_18)
				arg_201_1.mask_.color = var_204_19
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				local var_204_20 = Color.New(0, 0, 0)

				var_204_20.a = 1
				arg_201_1.mask_.color = var_204_20
			end

			local var_204_21 = 1

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_22 = 2

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_22 then
				local var_204_23 = (arg_201_1.time_ - var_204_21) / var_204_22
				local var_204_24 = Color.New(0, 0, 0)

				var_204_24.a = Mathf.Lerp(1, 0, var_204_23)
				arg_201_1.mask_.color = var_204_24
			end

			if arg_201_1.time_ >= var_204_21 + var_204_22 and arg_201_1.time_ < var_204_21 + var_204_22 + arg_204_0 then
				local var_204_25 = Color.New(0, 0, 0)
				local var_204_26 = 0

				arg_201_1.mask_.enabled = false
				var_204_25.a = var_204_26
				arg_201_1.mask_.color = var_204_25
			end

			local var_204_27 = arg_201_1.actors_["10066ui_story"].transform
			local var_204_28 = 1

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1.var_.moveOldPos10066ui_story = var_204_27.localPosition
			end

			local var_204_29 = 0.001

			if var_204_28 <= arg_201_1.time_ and arg_201_1.time_ < var_204_28 + var_204_29 then
				local var_204_30 = (arg_201_1.time_ - var_204_28) / var_204_29
				local var_204_31 = Vector3.New(0, 100, 0)

				var_204_27.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10066ui_story, var_204_31, var_204_30)

				local var_204_32 = manager.ui.mainCamera.transform.position - var_204_27.position

				var_204_27.forward = Vector3.New(var_204_32.x, var_204_32.y, var_204_32.z)

				local var_204_33 = var_204_27.localEulerAngles

				var_204_33.z = 0
				var_204_33.x = 0
				var_204_27.localEulerAngles = var_204_33
			end

			if arg_201_1.time_ >= var_204_28 + var_204_29 and arg_201_1.time_ < var_204_28 + var_204_29 + arg_204_0 then
				var_204_27.localPosition = Vector3.New(0, 100, 0)

				local var_204_34 = manager.ui.mainCamera.transform.position - var_204_27.position

				var_204_27.forward = Vector3.New(var_204_34.x, var_204_34.y, var_204_34.z)

				local var_204_35 = var_204_27.localEulerAngles

				var_204_35.z = 0
				var_204_35.x = 0
				var_204_27.localEulerAngles = var_204_35
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_36 = 2.65
			local var_204_37 = 0.35

			if var_204_36 < arg_201_1.time_ and arg_201_1.time_ <= var_204_36 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_38 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_38:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_39 = arg_201_1:FormatText(StoryNameCfg[698].name)

				arg_201_1.leftNameTxt_.text = var_204_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_40 = arg_201_1:GetWordFromCfg(319791047)
				local var_204_41 = arg_201_1:FormatText(var_204_40.content)

				arg_201_1.text_.text = var_204_41

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_42 = 14
				local var_204_43 = utf8.len(var_204_41)
				local var_204_44 = var_204_42 <= 0 and var_204_37 or var_204_37 * (var_204_43 / var_204_42)

				if var_204_44 > 0 and var_204_37 < var_204_44 then
					arg_201_1.talkMaxDuration = var_204_44
					var_204_36 = var_204_36 + 0.3

					if var_204_44 + var_204_36 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_44 + var_204_36
					end
				end

				arg_201_1.text_.text = var_204_41
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_45 = var_204_36 + 0.3
			local var_204_46 = math.max(var_204_37, arg_201_1.talkMaxDuration)

			if var_204_45 <= arg_201_1.time_ and arg_201_1.time_ < var_204_45 + var_204_46 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_45) / var_204_46

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_45 + var_204_46 and arg_201_1.time_ < var_204_45 + var_204_46 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play319791048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319791048
		arg_207_1.duration_ = 5.37

		local var_207_0 = {
			zh = 2.59966666666667,
			ja = 5.36666666666667
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319791049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1084ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, -0.97, -6)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1084ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_210_13 = 0

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_15 = 0.466666666666667
			local var_210_16 = 0.2

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_17 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_17:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_18 = arg_207_1:FormatText(StoryNameCfg[6].name)

				arg_207_1.leftNameTxt_.text = var_210_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_19 = arg_207_1:GetWordFromCfg(319791048)
				local var_210_20 = arg_207_1:FormatText(var_210_19.content)

				arg_207_1.text_.text = var_210_20

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_21 = 8
				local var_210_22 = utf8.len(var_210_20)
				local var_210_23 = var_210_21 <= 0 and var_210_16 or var_210_16 * (var_210_22 / var_210_21)

				if var_210_23 > 0 and var_210_16 < var_210_23 then
					arg_207_1.talkMaxDuration = var_210_23
					var_210_15 = var_210_15 + 0.3

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_20
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791048", "story_v_out_319791.awb") ~= 0 then
					local var_210_24 = manager.audio:GetVoiceLength("story_v_out_319791", "319791048", "story_v_out_319791.awb") / 1000

					if var_210_24 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_24 + var_210_15
					end

					if var_210_19.prefab_name ~= "" and arg_207_1.actors_[var_210_19.prefab_name] ~= nil then
						local var_210_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_19.prefab_name].transform, "story_v_out_319791", "319791048", "story_v_out_319791.awb")

						arg_207_1:RecordAudio("319791048", var_210_25)
						arg_207_1:RecordAudio("319791048", var_210_25)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319791", "319791048", "story_v_out_319791.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319791", "319791048", "story_v_out_319791.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_26 = var_210_15 + 0.3
			local var_210_27 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_26 <= arg_207_1.time_ and arg_207_1.time_ < var_210_26 + var_210_27 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_26) / var_210_27

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_26 + var_210_27 and arg_207_1.time_ < var_210_26 + var_210_27 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play319791049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319791049
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319791050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1084ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1084ui_story == nil then
				arg_213_1.var_.characterEffect1084ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1084ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1084ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1084ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1084ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.75

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[698].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(319791049)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 30
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319791050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319791050
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319791051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.9

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[698].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(319791050)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 36
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319791051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319791051
		arg_221_1.duration_ = 7.13

		local var_221_0 = {
			zh = 2.7,
			ja = 7.133
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
				arg_221_0:Play319791052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1084ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1084ui_story == nil then
				arg_221_1.var_.characterEffect1084ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1084ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1084ui_story then
				arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_224_4 = 0

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_224_6 = 0
			local var_224_7 = 0.275

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[6].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_9 = arg_221_1:GetWordFromCfg(319791051)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 11
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791051", "story_v_out_319791.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_319791", "319791051", "story_v_out_319791.awb") / 1000

					if var_224_14 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_6
					end

					if var_224_9.prefab_name ~= "" and arg_221_1.actors_[var_224_9.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_9.prefab_name].transform, "story_v_out_319791", "319791051", "story_v_out_319791.awb")

						arg_221_1:RecordAudio("319791051", var_224_15)
						arg_221_1:RecordAudio("319791051", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319791", "319791051", "story_v_out_319791.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319791", "319791051", "story_v_out_319791.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_16 and arg_221_1.time_ < var_224_6 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319791052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319791052
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319791053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1084ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.7

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(319791052)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 28
				local var_228_11 = utf8.len(var_228_9)
				local var_228_12 = var_228_10 <= 0 and var_228_7 or var_228_7 * (var_228_11 / var_228_10)

				if var_228_12 > 0 and var_228_7 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_13 and arg_225_1.time_ < var_228_6 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319791053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319791053
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319791054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.3

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[698].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(319791053)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 12
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319791054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319791054
		arg_233_1.duration_ = 2.23

		local var_233_0 = {
			zh = 2.166,
			ja = 2.233
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
				arg_233_0:Play319791055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1084ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, -0.97, -6)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1084ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1084ui_story then
				arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_15 = 0
			local var_236_16 = 0.225

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_17 = arg_233_1:FormatText(StoryNameCfg[6].name)

				arg_233_1.leftNameTxt_.text = var_236_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(319791054)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_20 = 9
				local var_236_21 = utf8.len(var_236_19)
				local var_236_22 = var_236_20 <= 0 and var_236_16 or var_236_16 * (var_236_21 / var_236_20)

				if var_236_22 > 0 and var_236_16 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_15
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791054", "story_v_out_319791.awb") ~= 0 then
					local var_236_23 = manager.audio:GetVoiceLength("story_v_out_319791", "319791054", "story_v_out_319791.awb") / 1000

					if var_236_23 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_15
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_out_319791", "319791054", "story_v_out_319791.awb")

						arg_233_1:RecordAudio("319791054", var_236_24)
						arg_233_1:RecordAudio("319791054", var_236_24)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319791", "319791054", "story_v_out_319791.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319791", "319791054", "story_v_out_319791.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_25 = math.max(var_236_16, arg_233_1.talkMaxDuration)

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_25 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_15) / var_236_25

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_15 + var_236_25 and arg_233_1.time_ < var_236_15 + var_236_25 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play319791055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319791055
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319791056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1084ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1084ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1084ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1084ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.225

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[698].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(319791055)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 9
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319791056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319791056
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319791057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1084ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1084ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1084ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = 0
			local var_244_10 = 0.675

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_11 = arg_241_1:GetWordFromCfg(319791056)
				local var_244_12 = arg_241_1:FormatText(var_244_11.content)

				arg_241_1.text_.text = var_244_12

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 27
				local var_244_14 = utf8.len(var_244_12)
				local var_244_15 = var_244_13 <= 0 and var_244_10 or var_244_10 * (var_244_14 / var_244_13)

				if var_244_15 > 0 and var_244_10 < var_244_15 then
					arg_241_1.talkMaxDuration = var_244_15

					if var_244_15 + var_244_9 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_15 + var_244_9
					end
				end

				arg_241_1.text_.text = var_244_12
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_10, arg_241_1.talkMaxDuration)

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_9) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_9 + var_244_16 and arg_241_1.time_ < var_244_9 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play319791057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319791057
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319791058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.925

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(319791057)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 37
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319791058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319791058
		arg_249_1.duration_ = 5.2

		local var_249_0 = {
			zh = 5.033,
			ja = 5.2
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
				arg_249_0:Play319791059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = "ST71"

			if arg_249_1.bgs_[var_252_0] == nil then
				local var_252_1 = Object.Instantiate(arg_249_1.paintGo_)

				var_252_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_252_0)
				var_252_1.name = var_252_0
				var_252_1.transform.parent = arg_249_1.stage_.transform
				var_252_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.bgs_[var_252_0] = var_252_1
			end

			local var_252_2 = 1

			if var_252_2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				local var_252_3 = manager.ui.mainCamera.transform.localPosition
				local var_252_4 = Vector3.New(0, 0, 10) + Vector3.New(var_252_3.x, var_252_3.y, 0)
				local var_252_5 = arg_249_1.bgs_.ST71

				var_252_5.transform.localPosition = var_252_4
				var_252_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_252_6 = var_252_5:GetComponent("SpriteRenderer")

				if var_252_6 and var_252_6.sprite then
					local var_252_7 = (var_252_5.transform.localPosition - var_252_3).z
					local var_252_8 = manager.ui.mainCameraCom_
					local var_252_9 = 2 * var_252_7 * Mathf.Tan(var_252_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_252_10 = var_252_9 * var_252_8.aspect
					local var_252_11 = var_252_6.sprite.bounds.size.x
					local var_252_12 = var_252_6.sprite.bounds.size.y
					local var_252_13 = var_252_10 / var_252_11
					local var_252_14 = var_252_9 / var_252_12
					local var_252_15 = var_252_14 < var_252_13 and var_252_13 or var_252_14

					var_252_5.transform.localScale = Vector3.New(var_252_15, var_252_15, 0)
				end

				for iter_252_0, iter_252_1 in pairs(arg_249_1.bgs_) do
					if iter_252_0 ~= "ST71" then
						iter_252_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			local var_252_17 = 0.3

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end

			local var_252_18 = 0

			if var_252_18 < arg_249_1.time_ and arg_249_1.time_ <= var_252_18 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_19 = 1

			if var_252_18 <= arg_249_1.time_ and arg_249_1.time_ < var_252_18 + var_252_19 then
				local var_252_20 = (arg_249_1.time_ - var_252_18) / var_252_19
				local var_252_21 = Color.New(0, 0, 0)

				var_252_21.a = Mathf.Lerp(0, 1, var_252_20)
				arg_249_1.mask_.color = var_252_21
			end

			if arg_249_1.time_ >= var_252_18 + var_252_19 and arg_249_1.time_ < var_252_18 + var_252_19 + arg_252_0 then
				local var_252_22 = Color.New(0, 0, 0)

				var_252_22.a = 1
				arg_249_1.mask_.color = var_252_22
			end

			local var_252_23 = 1

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_24 = 2

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24
				local var_252_26 = Color.New(0, 0, 0)

				var_252_26.a = Mathf.Lerp(1, 0, var_252_25)
				arg_249_1.mask_.color = var_252_26
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 then
				local var_252_27 = Color.New(0, 0, 0)
				local var_252_28 = 0

				arg_249_1.mask_.enabled = false
				var_252_27.a = var_252_28
				arg_249_1.mask_.color = var_252_27
			end

			local var_252_29 = arg_249_1.actors_["1084ui_story"].transform
			local var_252_30 = 3

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.var_.moveOldPos1084ui_story = var_252_29.localPosition
			end

			local var_252_31 = 0.001

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_31 then
				local var_252_32 = (arg_249_1.time_ - var_252_30) / var_252_31
				local var_252_33 = Vector3.New(0, -0.97, -6)

				var_252_29.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1084ui_story, var_252_33, var_252_32)

				local var_252_34 = manager.ui.mainCamera.transform.position - var_252_29.position

				var_252_29.forward = Vector3.New(var_252_34.x, var_252_34.y, var_252_34.z)

				local var_252_35 = var_252_29.localEulerAngles

				var_252_35.z = 0
				var_252_35.x = 0
				var_252_29.localEulerAngles = var_252_35
			end

			if arg_249_1.time_ >= var_252_30 + var_252_31 and arg_249_1.time_ < var_252_30 + var_252_31 + arg_252_0 then
				var_252_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_252_36 = manager.ui.mainCamera.transform.position - var_252_29.position

				var_252_29.forward = Vector3.New(var_252_36.x, var_252_36.y, var_252_36.z)

				local var_252_37 = var_252_29.localEulerAngles

				var_252_37.z = 0
				var_252_37.x = 0
				var_252_29.localEulerAngles = var_252_37
			end

			local var_252_38 = arg_249_1.actors_["1084ui_story"]
			local var_252_39 = 3

			if var_252_39 < arg_249_1.time_ and arg_249_1.time_ <= var_252_39 + arg_252_0 and not isNil(var_252_38) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_40 = 0.200000002980232

			if var_252_39 <= arg_249_1.time_ and arg_249_1.time_ < var_252_39 + var_252_40 and not isNil(var_252_38) then
				local var_252_41 = (arg_249_1.time_ - var_252_39) / var_252_40

				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_38) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_39 + var_252_40 and arg_249_1.time_ < var_252_39 + var_252_40 + arg_252_0 and not isNil(var_252_38) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_42 = 3

			if var_252_42 < arg_249_1.time_ and arg_249_1.time_ <= var_252_42 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_43 = 0
			local var_252_44 = 0.2

			if var_252_43 < arg_249_1.time_ and arg_249_1.time_ <= var_252_43 + arg_252_0 then
				local var_252_45 = "play"
				local var_252_46 = "music"

				arg_249_1:AudioAction(var_252_45, var_252_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_252_47 = ""
				local var_252_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_252_48 ~= "" then
					if arg_249_1.bgmTxt_.text ~= var_252_48 and arg_249_1.bgmTxt_.text ~= "" then
						if arg_249_1.bgmTxt2_.text ~= "" then
							arg_249_1.bgmTxt_.text = arg_249_1.bgmTxt2_.text
						end

						arg_249_1.bgmTxt2_.text = var_252_48

						arg_249_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_249_1.bgmTxt_.text = var_252_48
						arg_249_1.bgmTxt2_.text = var_252_48
					end

					if arg_249_1.bgmTimer then
						arg_249_1.bgmTimer:Stop()

						arg_249_1.bgmTimer = nil
					end

					if arg_249_1.settingData.show_music_name == 1 then
						arg_249_1.musicController:SetSelectedState("show")
						arg_249_1.musicAnimator_:Play("open", 0, 0)

						if arg_249_1.settingData.music_time ~= 0 then
							arg_249_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_249_1.settingData.music_time), function()
								if arg_249_1 == nil or isNil(arg_249_1.bgmTxt_) then
									return
								end

								arg_249_1.musicController:SetSelectedState("hide")
								arg_249_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_252_49 = 0.233333333333333
			local var_252_50 = 1

			if var_252_49 < arg_249_1.time_ and arg_249_1.time_ <= var_252_49 + arg_252_0 then
				local var_252_51 = "play"
				local var_252_52 = "music"

				arg_249_1:AudioAction(var_252_51, var_252_52, "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_252_53 = ""
				local var_252_54 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if var_252_54 ~= "" then
					if arg_249_1.bgmTxt_.text ~= var_252_54 and arg_249_1.bgmTxt_.text ~= "" then
						if arg_249_1.bgmTxt2_.text ~= "" then
							arg_249_1.bgmTxt_.text = arg_249_1.bgmTxt2_.text
						end

						arg_249_1.bgmTxt2_.text = var_252_54

						arg_249_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_249_1.bgmTxt_.text = var_252_54
						arg_249_1.bgmTxt2_.text = var_252_54
					end

					if arg_249_1.bgmTimer then
						arg_249_1.bgmTimer:Stop()

						arg_249_1.bgmTimer = nil
					end

					if arg_249_1.settingData.show_music_name == 1 then
						arg_249_1.musicController:SetSelectedState("show")
						arg_249_1.musicAnimator_:Play("open", 0, 0)

						if arg_249_1.settingData.music_time ~= 0 then
							arg_249_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_249_1.settingData.music_time), function()
								if arg_249_1 == nil or isNil(arg_249_1.bgmTxt_) then
									return
								end

								arg_249_1.musicController:SetSelectedState("hide")
								arg_249_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_249_1.frameCnt_ <= 1 then
				arg_249_1.dialog_:SetActive(false)
			end

			local var_252_55 = 3.1
			local var_252_56 = 0.3

			if var_252_55 < arg_249_1.time_ and arg_249_1.time_ <= var_252_55 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				arg_249_1.dialog_:SetActive(true)

				arg_249_1.dialogCg_.alpha = 0

				local var_252_57 = LeanTween.value(arg_249_1.dialog_, 0, 1, 0.3)

				var_252_57:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_249_1.dialogCg_.alpha = arg_255_0
				end))
				var_252_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_249_1.dialog_)
					var_252_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_249_1.duration_ = arg_249_1.duration_ + 0.3

				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_58 = arg_249_1:FormatText(StoryNameCfg[6].name)

				arg_249_1.leftNameTxt_.text = var_252_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_59 = arg_249_1:GetWordFromCfg(319791058)
				local var_252_60 = arg_249_1:FormatText(var_252_59.content)

				arg_249_1.text_.text = var_252_60

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_61 = 12
				local var_252_62 = utf8.len(var_252_60)
				local var_252_63 = var_252_61 <= 0 and var_252_56 or var_252_56 * (var_252_62 / var_252_61)

				if var_252_63 > 0 and var_252_56 < var_252_63 then
					arg_249_1.talkMaxDuration = var_252_63
					var_252_55 = var_252_55 + 0.3

					if var_252_63 + var_252_55 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_63 + var_252_55
					end
				end

				arg_249_1.text_.text = var_252_60
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791058", "story_v_out_319791.awb") ~= 0 then
					local var_252_64 = manager.audio:GetVoiceLength("story_v_out_319791", "319791058", "story_v_out_319791.awb") / 1000

					if var_252_64 + var_252_55 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_64 + var_252_55
					end

					if var_252_59.prefab_name ~= "" and arg_249_1.actors_[var_252_59.prefab_name] ~= nil then
						local var_252_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_59.prefab_name].transform, "story_v_out_319791", "319791058", "story_v_out_319791.awb")

						arg_249_1:RecordAudio("319791058", var_252_65)
						arg_249_1:RecordAudio("319791058", var_252_65)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319791", "319791058", "story_v_out_319791.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319791", "319791058", "story_v_out_319791.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_66 = var_252_55 + 0.3
			local var_252_67 = math.max(var_252_56, arg_249_1.talkMaxDuration)

			if var_252_66 <= arg_249_1.time_ and arg_249_1.time_ < var_252_66 + var_252_67 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_66) / var_252_67

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_66 + var_252_67 and arg_249_1.time_ < var_252_66 + var_252_67 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play319791059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319791059
		arg_257_1.duration_ = 2.7

		local var_257_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_257_0:Play319791060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_260_2 = 0
			local var_260_3 = 0.175

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_4 = arg_257_1:FormatText(StoryNameCfg[6].name)

				arg_257_1.leftNameTxt_.text = var_260_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:GetWordFromCfg(319791059)
				local var_260_6 = arg_257_1:FormatText(var_260_5.content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 7
				local var_260_8 = utf8.len(var_260_6)
				local var_260_9 = var_260_7 <= 0 and var_260_3 or var_260_3 * (var_260_8 / var_260_7)

				if var_260_9 > 0 and var_260_3 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791059", "story_v_out_319791.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_319791", "319791059", "story_v_out_319791.awb") / 1000

					if var_260_10 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_2
					end

					if var_260_5.prefab_name ~= "" and arg_257_1.actors_[var_260_5.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_5.prefab_name].transform, "story_v_out_319791", "319791059", "story_v_out_319791.awb")

						arg_257_1:RecordAudio("319791059", var_260_11)
						arg_257_1:RecordAudio("319791059", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319791", "319791059", "story_v_out_319791.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319791", "319791059", "story_v_out_319791.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_12 and arg_257_1.time_ < var_260_2 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319791060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319791060
		arg_261_1.duration_ = 3.6

		local var_261_0 = {
			zh = 2.8,
			ja = 3.6
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
				arg_261_0:Play319791061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = "10050ui_story"

			if arg_261_1.actors_[var_264_0] == nil then
				local var_264_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_264_1) then
					local var_264_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_261_1.stage_.transform)

					var_264_2.name = var_264_0
					var_264_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_261_1.actors_[var_264_0] = var_264_2

					local var_264_3 = var_264_2:GetComponentInChildren(typeof(CharacterEffect))

					var_264_3.enabled = true

					local var_264_4 = GameObjectTools.GetOrAddComponent(var_264_2, typeof(DynamicBoneHelper))

					if var_264_4 then
						var_264_4:EnableDynamicBone(false)
					end

					arg_261_1:ShowWeapon(var_264_3.transform, false)

					arg_261_1.var_[var_264_0 .. "Animator"] = var_264_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_261_1.var_[var_264_0 .. "Animator"].applyRootMotion = true
					arg_261_1.var_[var_264_0 .. "LipSync"] = var_264_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_264_5 = arg_261_1.actors_["10050ui_story"].transform
			local var_264_6 = 0

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.var_.moveOldPos10050ui_story = var_264_5.localPosition
			end

			local var_264_7 = 0.001

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				local var_264_8 = (arg_261_1.time_ - var_264_6) / var_264_7
				local var_264_9 = Vector3.New(0.7, -0.715, -6.15)

				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10050ui_story, var_264_9, var_264_8)

				local var_264_10 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_10.x, var_264_10.y, var_264_10.z)

				local var_264_11 = var_264_5.localEulerAngles

				var_264_11.z = 0
				var_264_11.x = 0
				var_264_5.localEulerAngles = var_264_11
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_264_12 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_12.x, var_264_12.y, var_264_12.z)

				local var_264_13 = var_264_5.localEulerAngles

				var_264_13.z = 0
				var_264_13.x = 0
				var_264_5.localEulerAngles = var_264_13
			end

			local var_264_14 = arg_261_1.actors_["10050ui_story"]
			local var_264_15 = 0

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect10050ui_story == nil then
				arg_261_1.var_.characterEffect10050ui_story = var_264_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_16 = 0.200000002980232

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_16 and not isNil(var_264_14) then
				local var_264_17 = (arg_261_1.time_ - var_264_15) / var_264_16

				if arg_261_1.var_.characterEffect10050ui_story and not isNil(var_264_14) then
					arg_261_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_15 + var_264_16 and arg_261_1.time_ < var_264_15 + var_264_16 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect10050ui_story then
				arg_261_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_264_18 = 0

			if var_264_18 < arg_261_1.time_ and arg_261_1.time_ <= var_264_18 + arg_264_0 then
				arg_261_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_264_19 = 0

			if var_264_19 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_264_20 = arg_261_1.actors_["1084ui_story"].transform
			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_20.localPosition
			end

			local var_264_22 = 0.001

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22
				local var_264_24 = Vector3.New(-0.7, -0.97, -6)

				var_264_20.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, var_264_24, var_264_23)

				local var_264_25 = manager.ui.mainCamera.transform.position - var_264_20.position

				var_264_20.forward = Vector3.New(var_264_25.x, var_264_25.y, var_264_25.z)

				local var_264_26 = var_264_20.localEulerAngles

				var_264_26.z = 0
				var_264_26.x = 0
				var_264_20.localEulerAngles = var_264_26
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 then
				var_264_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_264_27 = manager.ui.mainCamera.transform.position - var_264_20.position

				var_264_20.forward = Vector3.New(var_264_27.x, var_264_27.y, var_264_27.z)

				local var_264_28 = var_264_20.localEulerAngles

				var_264_28.z = 0
				var_264_28.x = 0
				var_264_20.localEulerAngles = var_264_28
			end

			local var_264_29 = arg_261_1.actors_["1084ui_story"]
			local var_264_30 = 0

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 and not isNil(var_264_29) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_31 = 0.200000002980232

			if var_264_30 <= arg_261_1.time_ and arg_261_1.time_ < var_264_30 + var_264_31 and not isNil(var_264_29) then
				local var_264_32 = (arg_261_1.time_ - var_264_30) / var_264_31

				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_29) then
					local var_264_33 = Mathf.Lerp(0, 0.5, var_264_32)

					arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1084ui_story.fillRatio = var_264_33
				end
			end

			if arg_261_1.time_ >= var_264_30 + var_264_31 and arg_261_1.time_ < var_264_30 + var_264_31 + arg_264_0 and not isNil(var_264_29) and arg_261_1.var_.characterEffect1084ui_story then
				local var_264_34 = 0.5

				arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1084ui_story.fillRatio = var_264_34
			end

			local var_264_35 = 0
			local var_264_36 = 0.25

			if var_264_35 < arg_261_1.time_ and arg_261_1.time_ <= var_264_35 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_37 = arg_261_1:FormatText(StoryNameCfg[692].name)

				arg_261_1.leftNameTxt_.text = var_264_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_38 = arg_261_1:GetWordFromCfg(319791060)
				local var_264_39 = arg_261_1:FormatText(var_264_38.content)

				arg_261_1.text_.text = var_264_39

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_40 = 10
				local var_264_41 = utf8.len(var_264_39)
				local var_264_42 = var_264_40 <= 0 and var_264_36 or var_264_36 * (var_264_41 / var_264_40)

				if var_264_42 > 0 and var_264_36 < var_264_42 then
					arg_261_1.talkMaxDuration = var_264_42

					if var_264_42 + var_264_35 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_42 + var_264_35
					end
				end

				arg_261_1.text_.text = var_264_39
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791060", "story_v_out_319791.awb") ~= 0 then
					local var_264_43 = manager.audio:GetVoiceLength("story_v_out_319791", "319791060", "story_v_out_319791.awb") / 1000

					if var_264_43 + var_264_35 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_43 + var_264_35
					end

					if var_264_38.prefab_name ~= "" and arg_261_1.actors_[var_264_38.prefab_name] ~= nil then
						local var_264_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_38.prefab_name].transform, "story_v_out_319791", "319791060", "story_v_out_319791.awb")

						arg_261_1:RecordAudio("319791060", var_264_44)
						arg_261_1:RecordAudio("319791060", var_264_44)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319791", "319791060", "story_v_out_319791.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319791", "319791060", "story_v_out_319791.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_45 = math.max(var_264_36, arg_261_1.talkMaxDuration)

			if var_264_35 <= arg_261_1.time_ and arg_261_1.time_ < var_264_35 + var_264_45 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_35) / var_264_45

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_35 + var_264_45 and arg_261_1.time_ < var_264_35 + var_264_45 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319791061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319791061
		arg_265_1.duration_ = 5.13

		local var_265_0 = {
			zh = 1.866,
			ja = 5.133
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
				arg_265_0:Play319791062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.15

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[692].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(319791061)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791061", "story_v_out_319791.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791061", "story_v_out_319791.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_319791", "319791061", "story_v_out_319791.awb")

						arg_265_1:RecordAudio("319791061", var_268_9)
						arg_265_1:RecordAudio("319791061", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319791", "319791061", "story_v_out_319791.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319791", "319791061", "story_v_out_319791.awb")
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
	Play319791062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319791062
		arg_269_1.duration_ = 6.1

		local var_269_0 = {
			zh = 5.1,
			ja = 6.1
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
				arg_269_0:Play319791063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10050ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10050ui_story == nil then
				arg_269_1.var_.characterEffect10050ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect10050ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10050ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10050ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10050ui_story.fillRatio = var_272_5
			end

			local var_272_6 = arg_269_1.actors_["1084ui_story"]
			local var_272_7 = 0

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_8 = 0.200000002980232

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_8 and not isNil(var_272_6) then
				local var_272_9 = (arg_269_1.time_ - var_272_7) / var_272_8

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_6) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_7 + var_272_8 and arg_269_1.time_ < var_272_7 + var_272_8 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_272_10 = 0
			local var_272_11 = 0.6

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_12 = arg_269_1:FormatText(StoryNameCfg[6].name)

				arg_269_1.leftNameTxt_.text = var_272_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_13 = arg_269_1:GetWordFromCfg(319791062)
				local var_272_14 = arg_269_1:FormatText(var_272_13.content)

				arg_269_1.text_.text = var_272_14

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 24
				local var_272_16 = utf8.len(var_272_14)
				local var_272_17 = var_272_15 <= 0 and var_272_11 or var_272_11 * (var_272_16 / var_272_15)

				if var_272_17 > 0 and var_272_11 < var_272_17 then
					arg_269_1.talkMaxDuration = var_272_17

					if var_272_17 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_17 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_14
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791062", "story_v_out_319791.awb") ~= 0 then
					local var_272_18 = manager.audio:GetVoiceLength("story_v_out_319791", "319791062", "story_v_out_319791.awb") / 1000

					if var_272_18 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_10
					end

					if var_272_13.prefab_name ~= "" and arg_269_1.actors_[var_272_13.prefab_name] ~= nil then
						local var_272_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_13.prefab_name].transform, "story_v_out_319791", "319791062", "story_v_out_319791.awb")

						arg_269_1:RecordAudio("319791062", var_272_19)
						arg_269_1:RecordAudio("319791062", var_272_19)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319791", "319791062", "story_v_out_319791.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319791", "319791062", "story_v_out_319791.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_20 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_20 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_10) / var_272_20

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_10 + var_272_20 and arg_269_1.time_ < var_272_10 + var_272_20 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319791063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319791063
		arg_273_1.duration_ = 8.1

		local var_273_0 = {
			zh = 5.4,
			ja = 8.1
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319791064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.75

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[6].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(319791063)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 30
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791063", "story_v_out_319791.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_319791", "319791063", "story_v_out_319791.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_319791", "319791063", "story_v_out_319791.awb")

						arg_273_1:RecordAudio("319791063", var_276_9)
						arg_273_1:RecordAudio("319791063", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319791", "319791063", "story_v_out_319791.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319791", "319791063", "story_v_out_319791.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play319791064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319791064
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play319791065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10050ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10050ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, 100, 0)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10050ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, 100, 0)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1084ui_story"].transform
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.var_.moveOldPos1084ui_story = var_280_9.localPosition
			end

			local var_280_11 = 0.001

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11
				local var_280_13 = Vector3.New(0, 100, 0)

				var_280_9.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1084ui_story, var_280_13, var_280_12)

				local var_280_14 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_14.x, var_280_14.y, var_280_14.z)

				local var_280_15 = var_280_9.localEulerAngles

				var_280_15.z = 0
				var_280_15.x = 0
				var_280_9.localEulerAngles = var_280_15
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 then
				var_280_9.localPosition = Vector3.New(0, 100, 0)

				local var_280_16 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_16.x, var_280_16.y, var_280_16.z)

				local var_280_17 = var_280_9.localEulerAngles

				var_280_17.z = 0
				var_280_17.x = 0
				var_280_9.localEulerAngles = var_280_17
			end

			local var_280_18 = 0
			local var_280_19 = 0.65

			if var_280_18 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_20 = arg_277_1:GetWordFromCfg(319791064)
				local var_280_21 = arg_277_1:FormatText(var_280_20.content)

				arg_277_1.text_.text = var_280_21

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_22 = 26
				local var_280_23 = utf8.len(var_280_21)
				local var_280_24 = var_280_22 <= 0 and var_280_19 or var_280_19 * (var_280_23 / var_280_22)

				if var_280_24 > 0 and var_280_19 < var_280_24 then
					arg_277_1.talkMaxDuration = var_280_24

					if var_280_24 + var_280_18 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_18
					end
				end

				arg_277_1.text_.text = var_280_21
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_19, arg_277_1.talkMaxDuration)

			if var_280_18 <= arg_277_1.time_ and arg_277_1.time_ < var_280_18 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_18) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_18 + var_280_25 and arg_277_1.time_ < var_280_18 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play319791065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319791065
		arg_281_1.duration_ = 6.63

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play319791066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_1 = manager.ui.mainCamera.transform.localPosition
				local var_284_2 = Vector3.New(0, 0, 10) + Vector3.New(var_284_1.x, var_284_1.y, 0)
				local var_284_3 = arg_281_1.bgs_.STblack

				var_284_3.transform.localPosition = var_284_2
				var_284_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_4 = var_284_3:GetComponent("SpriteRenderer")

				if var_284_4 and var_284_4.sprite then
					local var_284_5 = (var_284_3.transform.localPosition - var_284_1).z
					local var_284_6 = manager.ui.mainCameraCom_
					local var_284_7 = 2 * var_284_5 * Mathf.Tan(var_284_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_284_8 = var_284_7 * var_284_6.aspect
					local var_284_9 = var_284_4.sprite.bounds.size.x
					local var_284_10 = var_284_4.sprite.bounds.size.y
					local var_284_11 = var_284_8 / var_284_9
					local var_284_12 = var_284_7 / var_284_10
					local var_284_13 = var_284_12 < var_284_11 and var_284_11 or var_284_12

					var_284_3.transform.localScale = Vector3.New(var_284_13, var_284_13, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "STblack" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_15 = 1

			if var_284_14 <= arg_281_1.time_ and arg_281_1.time_ < var_284_14 + var_284_15 then
				local var_284_16 = (arg_281_1.time_ - var_284_14) / var_284_15
				local var_284_17 = Color.New(0, 0, 0)

				var_284_17.a = Mathf.Lerp(0, 1, var_284_16)
				arg_281_1.mask_.color = var_284_17
			end

			if arg_281_1.time_ >= var_284_14 + var_284_15 and arg_281_1.time_ < var_284_14 + var_284_15 + arg_284_0 then
				local var_284_18 = Color.New(0, 0, 0)

				var_284_18.a = 1
				arg_281_1.mask_.color = var_284_18
			end

			local var_284_19 = 1

			if var_284_19 < arg_281_1.time_ and arg_281_1.time_ <= var_284_19 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_20 = 1

			if var_284_19 <= arg_281_1.time_ and arg_281_1.time_ < var_284_19 + var_284_20 then
				local var_284_21 = (arg_281_1.time_ - var_284_19) / var_284_20
				local var_284_22 = Color.New(0, 0, 0)

				var_284_22.a = Mathf.Lerp(1, 0, var_284_21)
				arg_281_1.mask_.color = var_284_22
			end

			if arg_281_1.time_ >= var_284_19 + var_284_20 and arg_281_1.time_ < var_284_19 + var_284_20 + arg_284_0 then
				local var_284_23 = Color.New(0, 0, 0)
				local var_284_24 = 0

				arg_281_1.mask_.enabled = false
				var_284_23.a = var_284_24
				arg_281_1.mask_.color = var_284_23
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_25 = 1.63333333333333
			local var_284_26 = 1.325

			if var_284_25 < arg_281_1.time_ and arg_281_1.time_ <= var_284_25 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_27 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_27:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_28 = arg_281_1:GetWordFromCfg(319791065)
				local var_284_29 = arg_281_1:FormatText(var_284_28.content)

				arg_281_1.text_.text = var_284_29

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_30 = 53
				local var_284_31 = utf8.len(var_284_29)
				local var_284_32 = var_284_30 <= 0 and var_284_26 or var_284_26 * (var_284_31 / var_284_30)

				if var_284_32 > 0 and var_284_26 < var_284_32 then
					arg_281_1.talkMaxDuration = var_284_32
					var_284_25 = var_284_25 + 0.3

					if var_284_32 + var_284_25 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_32 + var_284_25
					end
				end

				arg_281_1.text_.text = var_284_29
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_33 = var_284_25 + 0.3
			local var_284_34 = math.max(var_284_26, arg_281_1.talkMaxDuration)

			if var_284_33 <= arg_281_1.time_ and arg_281_1.time_ < var_284_33 + var_284_34 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_33) / var_284_34

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_33 + var_284_34 and arg_281_1.time_ < var_284_33 + var_284_34 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play319791066 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319791066
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play319791067(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 1.475

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:GetWordFromCfg(319791066)
				local var_290_3 = arg_287_1:FormatText(var_290_2.content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 59
				local var_290_5 = utf8.len(var_290_3)
				local var_290_6 = var_290_4 <= 0 and var_290_1 or var_290_1 * (var_290_5 / var_290_4)

				if var_290_6 > 0 and var_290_1 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_7 and arg_287_1.time_ < var_290_0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play319791067 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319791067
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319791068(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.075

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(319791067)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 43
				local var_294_5 = utf8.len(var_294_3)
				local var_294_6 = var_294_4 <= 0 and var_294_1 or var_294_1 * (var_294_5 / var_294_4)

				if var_294_6 > 0 and var_294_1 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_7 and arg_291_1.time_ < var_294_0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319791068 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319791068
		arg_295_1.duration_ = 6.67

		local var_295_0 = {
			zh = 5.09966666666667,
			ja = 6.66666666666667
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319791069(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1084ui_story"].transform
			local var_298_1 = 2.53333333333333

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1084ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(-0.7, -0.97, -6)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1084ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1084ui_story"]
			local var_298_10 = 2.53333333333333

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1084ui_story then
				arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_298_13 = 2.53333333333333

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_298_14 = 2.53333333333333

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_15 = 1

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				local var_298_16 = manager.ui.mainCamera.transform.localPosition
				local var_298_17 = Vector3.New(0, 0, 10) + Vector3.New(var_298_16.x, var_298_16.y, 0)
				local var_298_18 = arg_295_1.bgs_.ST71

				var_298_18.transform.localPosition = var_298_17
				var_298_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_19 = var_298_18:GetComponent("SpriteRenderer")

				if var_298_19 and var_298_19.sprite then
					local var_298_20 = (var_298_18.transform.localPosition - var_298_16).z
					local var_298_21 = manager.ui.mainCameraCom_
					local var_298_22 = 2 * var_298_20 * Mathf.Tan(var_298_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_298_23 = var_298_22 * var_298_21.aspect
					local var_298_24 = var_298_19.sprite.bounds.size.x
					local var_298_25 = var_298_19.sprite.bounds.size.y
					local var_298_26 = var_298_23 / var_298_24
					local var_298_27 = var_298_22 / var_298_25
					local var_298_28 = var_298_27 < var_298_26 and var_298_26 or var_298_27

					var_298_18.transform.localScale = Vector3.New(var_298_28, var_298_28, 0)
				end

				for iter_298_0, iter_298_1 in pairs(arg_295_1.bgs_) do
					if iter_298_0 ~= "ST71" then
						iter_298_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_29 = 0

			if var_298_29 < arg_295_1.time_ and arg_295_1.time_ <= var_298_29 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_30 = 1

			if var_298_29 <= arg_295_1.time_ and arg_295_1.time_ < var_298_29 + var_298_30 then
				local var_298_31 = (arg_295_1.time_ - var_298_29) / var_298_30
				local var_298_32 = Color.New(0, 0, 0)

				var_298_32.a = Mathf.Lerp(0, 1, var_298_31)
				arg_295_1.mask_.color = var_298_32
			end

			if arg_295_1.time_ >= var_298_29 + var_298_30 and arg_295_1.time_ < var_298_29 + var_298_30 + arg_298_0 then
				local var_298_33 = Color.New(0, 0, 0)

				var_298_33.a = 1
				arg_295_1.mask_.color = var_298_33
			end

			local var_298_34 = 1

			if var_298_34 < arg_295_1.time_ and arg_295_1.time_ <= var_298_34 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_35 = 1.66666666666667

			if var_298_34 <= arg_295_1.time_ and arg_295_1.time_ < var_298_34 + var_298_35 then
				local var_298_36 = (arg_295_1.time_ - var_298_34) / var_298_35
				local var_298_37 = Color.New(0, 0, 0)

				var_298_37.a = Mathf.Lerp(1, 0, var_298_36)
				arg_295_1.mask_.color = var_298_37
			end

			if arg_295_1.time_ >= var_298_34 + var_298_35 and arg_295_1.time_ < var_298_34 + var_298_35 + arg_298_0 then
				local var_298_38 = Color.New(0, 0, 0)
				local var_298_39 = 0

				arg_295_1.mask_.enabled = false
				var_298_38.a = var_298_39
				arg_295_1.mask_.color = var_298_38
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_40 = 2.66666666666667
			local var_298_41 = 0.25

			if var_298_40 < arg_295_1.time_ and arg_295_1.time_ <= var_298_40 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_42 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_42:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_43 = arg_295_1:FormatText(StoryNameCfg[6].name)

				arg_295_1.leftNameTxt_.text = var_298_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_44 = arg_295_1:GetWordFromCfg(319791068)
				local var_298_45 = arg_295_1:FormatText(var_298_44.content)

				arg_295_1.text_.text = var_298_45

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_46 = 10
				local var_298_47 = utf8.len(var_298_45)
				local var_298_48 = var_298_46 <= 0 and var_298_41 or var_298_41 * (var_298_47 / var_298_46)

				if var_298_48 > 0 and var_298_41 < var_298_48 then
					arg_295_1.talkMaxDuration = var_298_48
					var_298_40 = var_298_40 + 0.3

					if var_298_48 + var_298_40 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_48 + var_298_40
					end
				end

				arg_295_1.text_.text = var_298_45
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791068", "story_v_out_319791.awb") ~= 0 then
					local var_298_49 = manager.audio:GetVoiceLength("story_v_out_319791", "319791068", "story_v_out_319791.awb") / 1000

					if var_298_49 + var_298_40 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_49 + var_298_40
					end

					if var_298_44.prefab_name ~= "" and arg_295_1.actors_[var_298_44.prefab_name] ~= nil then
						local var_298_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_44.prefab_name].transform, "story_v_out_319791", "319791068", "story_v_out_319791.awb")

						arg_295_1:RecordAudio("319791068", var_298_50)
						arg_295_1:RecordAudio("319791068", var_298_50)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319791", "319791068", "story_v_out_319791.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319791", "319791068", "story_v_out_319791.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_51 = var_298_40 + 0.3
			local var_298_52 = math.max(var_298_41, arg_295_1.talkMaxDuration)

			if var_298_51 <= arg_295_1.time_ and arg_295_1.time_ < var_298_51 + var_298_52 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_51) / var_298_52

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_51 + var_298_52 and arg_295_1.time_ < var_298_51 + var_298_52 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play319791069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 319791069
		arg_301_1.duration_ = 4

		local var_301_0 = {
			zh = 1.999999999999,
			ja = 4
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
				arg_301_0:Play319791070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10050ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10050ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0.7, -0.715, -6.15)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10050ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["10050ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect10050ui_story == nil then
				arg_301_1.var_.characterEffect10050ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect10050ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect10050ui_story then
				arg_301_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_304_15 = arg_301_1.actors_["1084ui_story"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = var_304_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_17 = 0.200000002980232

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.characterEffect1084ui_story and not isNil(var_304_15) then
					local var_304_19 = Mathf.Lerp(0, 0.5, var_304_18)

					arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1084ui_story.fillRatio = var_304_19
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect1084ui_story then
				local var_304_20 = 0.5

				arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1084ui_story.fillRatio = var_304_20
			end

			local var_304_21 = 0
			local var_304_22 = 0.15

			if var_304_21 < arg_301_1.time_ and arg_301_1.time_ <= var_304_21 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_23 = arg_301_1:FormatText(StoryNameCfg[692].name)

				arg_301_1.leftNameTxt_.text = var_304_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_24 = arg_301_1:GetWordFromCfg(319791069)
				local var_304_25 = arg_301_1:FormatText(var_304_24.content)

				arg_301_1.text_.text = var_304_25

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_26 = 6
				local var_304_27 = utf8.len(var_304_25)
				local var_304_28 = var_304_26 <= 0 and var_304_22 or var_304_22 * (var_304_27 / var_304_26)

				if var_304_28 > 0 and var_304_22 < var_304_28 then
					arg_301_1.talkMaxDuration = var_304_28

					if var_304_28 + var_304_21 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_28 + var_304_21
					end
				end

				arg_301_1.text_.text = var_304_25
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791069", "story_v_out_319791.awb") ~= 0 then
					local var_304_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791069", "story_v_out_319791.awb") / 1000

					if var_304_29 + var_304_21 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_29 + var_304_21
					end

					if var_304_24.prefab_name ~= "" and arg_301_1.actors_[var_304_24.prefab_name] ~= nil then
						local var_304_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_24.prefab_name].transform, "story_v_out_319791", "319791069", "story_v_out_319791.awb")

						arg_301_1:RecordAudio("319791069", var_304_30)
						arg_301_1:RecordAudio("319791069", var_304_30)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_319791", "319791069", "story_v_out_319791.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_319791", "319791069", "story_v_out_319791.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_31 = math.max(var_304_22, arg_301_1.talkMaxDuration)

			if var_304_21 <= arg_301_1.time_ and arg_301_1.time_ < var_304_21 + var_304_31 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_21) / var_304_31

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_21 + var_304_31 and arg_301_1.time_ < var_304_21 + var_304_31 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play319791070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319791070
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play319791071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10050ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10050ui_story == nil then
				arg_305_1.var_.characterEffect10050ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect10050ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10050ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10050ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10050ui_story.fillRatio = var_308_5
			end

			local var_308_6 = arg_305_1.actors_["10050ui_story"].transform
			local var_308_7 = 0

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.var_.moveOldPos10050ui_story = var_308_6.localPosition
			end

			local var_308_8 = 0.001

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_8 then
				local var_308_9 = (arg_305_1.time_ - var_308_7) / var_308_8
				local var_308_10 = Vector3.New(0, 100, 0)

				var_308_6.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10050ui_story, var_308_10, var_308_9)

				local var_308_11 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_11.x, var_308_11.y, var_308_11.z)

				local var_308_12 = var_308_6.localEulerAngles

				var_308_12.z = 0
				var_308_12.x = 0
				var_308_6.localEulerAngles = var_308_12
			end

			if arg_305_1.time_ >= var_308_7 + var_308_8 and arg_305_1.time_ < var_308_7 + var_308_8 + arg_308_0 then
				var_308_6.localPosition = Vector3.New(0, 100, 0)

				local var_308_13 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_13.x, var_308_13.y, var_308_13.z)

				local var_308_14 = var_308_6.localEulerAngles

				var_308_14.z = 0
				var_308_14.x = 0
				var_308_6.localEulerAngles = var_308_14
			end

			local var_308_15 = arg_305_1.actors_["1084ui_story"].transform
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.var_.moveOldPos1084ui_story = var_308_15.localPosition
			end

			local var_308_17 = 0.001

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 then
				local var_308_18 = (arg_305_1.time_ - var_308_16) / var_308_17
				local var_308_19 = Vector3.New(0, 100, 0)

				var_308_15.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1084ui_story, var_308_19, var_308_18)

				local var_308_20 = manager.ui.mainCamera.transform.position - var_308_15.position

				var_308_15.forward = Vector3.New(var_308_20.x, var_308_20.y, var_308_20.z)

				local var_308_21 = var_308_15.localEulerAngles

				var_308_21.z = 0
				var_308_21.x = 0
				var_308_15.localEulerAngles = var_308_21
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				var_308_15.localPosition = Vector3.New(0, 100, 0)

				local var_308_22 = manager.ui.mainCamera.transform.position - var_308_15.position

				var_308_15.forward = Vector3.New(var_308_22.x, var_308_22.y, var_308_22.z)

				local var_308_23 = var_308_15.localEulerAngles

				var_308_23.z = 0
				var_308_23.x = 0
				var_308_15.localEulerAngles = var_308_23
			end

			local var_308_24 = 0
			local var_308_25 = 1.6

			if var_308_24 < arg_305_1.time_ and arg_305_1.time_ <= var_308_24 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_26 = arg_305_1:GetWordFromCfg(319791070)
				local var_308_27 = arg_305_1:FormatText(var_308_26.content)

				arg_305_1.text_.text = var_308_27

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_28 = 64
				local var_308_29 = utf8.len(var_308_27)
				local var_308_30 = var_308_28 <= 0 and var_308_25 or var_308_25 * (var_308_29 / var_308_28)

				if var_308_30 > 0 and var_308_25 < var_308_30 then
					arg_305_1.talkMaxDuration = var_308_30

					if var_308_30 + var_308_24 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_30 + var_308_24
					end
				end

				arg_305_1.text_.text = var_308_27
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_31 = math.max(var_308_25, arg_305_1.talkMaxDuration)

			if var_308_24 <= arg_305_1.time_ and arg_305_1.time_ < var_308_24 + var_308_31 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_24) / var_308_31

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_24 + var_308_31 and arg_305_1.time_ < var_308_24 + var_308_31 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play319791071 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 319791071
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play319791072(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.3

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[698].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(319791071)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 12
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play319791072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 319791072
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play319791073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.65

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(319791072)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 26
				local var_316_5 = utf8.len(var_316_3)
				local var_316_6 = var_316_4 <= 0 and var_316_1 or var_316_1 * (var_316_5 / var_316_4)

				if var_316_6 > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_7 and arg_313_1.time_ < var_316_0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play319791073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319791073
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319791074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.3

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

				local var_320_2 = arg_317_1:GetWordFromCfg(319791073)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 52
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
	Play319791074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 319791074
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play319791075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.35

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[698].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(319791074)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 14
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play319791075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 319791075
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play319791076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 1.425

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(319791075)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 57
				local var_328_5 = utf8.len(var_328_3)
				local var_328_6 = var_328_4 <= 0 and var_328_1 or var_328_1 * (var_328_5 / var_328_4)

				if var_328_6 > 0 and var_328_1 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_7 and arg_325_1.time_ < var_328_0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play319791076 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 319791076
		arg_329_1.duration_ = 2

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play319791077(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				local var_332_2 = "play"
				local var_332_3 = "effect"

				arg_329_1:AudioAction(var_332_2, var_332_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_332_4 = arg_329_1.actors_["10050ui_story"].transform
			local var_332_5 = 0

			if var_332_5 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.var_.moveOldPos10050ui_story = var_332_4.localPosition
			end

			local var_332_6 = 0.001

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_6 then
				local var_332_7 = (arg_329_1.time_ - var_332_5) / var_332_6
				local var_332_8 = Vector3.New(0.7, -0.715, -6.15)

				var_332_4.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10050ui_story, var_332_8, var_332_7)

				local var_332_9 = manager.ui.mainCamera.transform.position - var_332_4.position

				var_332_4.forward = Vector3.New(var_332_9.x, var_332_9.y, var_332_9.z)

				local var_332_10 = var_332_4.localEulerAngles

				var_332_10.z = 0
				var_332_10.x = 0
				var_332_4.localEulerAngles = var_332_10
			end

			if arg_329_1.time_ >= var_332_5 + var_332_6 and arg_329_1.time_ < var_332_5 + var_332_6 + arg_332_0 then
				var_332_4.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_332_11 = manager.ui.mainCamera.transform.position - var_332_4.position

				var_332_4.forward = Vector3.New(var_332_11.x, var_332_11.y, var_332_11.z)

				local var_332_12 = var_332_4.localEulerAngles

				var_332_12.z = 0
				var_332_12.x = 0
				var_332_4.localEulerAngles = var_332_12
			end

			local var_332_13 = arg_329_1.actors_["1084ui_story"].transform
			local var_332_14 = 0

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1.var_.moveOldPos1084ui_story = var_332_13.localPosition
			end

			local var_332_15 = 0.001

			if var_332_14 <= arg_329_1.time_ and arg_329_1.time_ < var_332_14 + var_332_15 then
				local var_332_16 = (arg_329_1.time_ - var_332_14) / var_332_15
				local var_332_17 = Vector3.New(-0.7, -0.97, -6)

				var_332_13.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1084ui_story, var_332_17, var_332_16)

				local var_332_18 = manager.ui.mainCamera.transform.position - var_332_13.position

				var_332_13.forward = Vector3.New(var_332_18.x, var_332_18.y, var_332_18.z)

				local var_332_19 = var_332_13.localEulerAngles

				var_332_19.z = 0
				var_332_19.x = 0
				var_332_13.localEulerAngles = var_332_19
			end

			if arg_329_1.time_ >= var_332_14 + var_332_15 and arg_329_1.time_ < var_332_14 + var_332_15 + arg_332_0 then
				var_332_13.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_332_20 = manager.ui.mainCamera.transform.position - var_332_13.position

				var_332_13.forward = Vector3.New(var_332_20.x, var_332_20.y, var_332_20.z)

				local var_332_21 = var_332_13.localEulerAngles

				var_332_21.z = 0
				var_332_21.x = 0
				var_332_13.localEulerAngles = var_332_21
			end

			local var_332_22 = 0

			if var_332_22 < arg_329_1.time_ and arg_329_1.time_ <= var_332_22 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_332_23 = 0

			if var_332_23 < arg_329_1.time_ and arg_329_1.time_ <= var_332_23 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_332_24 = 0

			if var_332_24 < arg_329_1.time_ and arg_329_1.time_ <= var_332_24 + arg_332_0 then
				arg_329_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_1")
			end

			local var_332_25 = 0

			if var_332_25 < arg_329_1.time_ and arg_329_1.time_ <= var_332_25 + arg_332_0 then
				arg_329_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_332_26 = arg_329_1.actors_["1084ui_story"]
			local var_332_27 = 0

			if var_332_27 < arg_329_1.time_ and arg_329_1.time_ <= var_332_27 + arg_332_0 and not isNil(var_332_26) and arg_329_1.var_.characterEffect1084ui_story == nil then
				arg_329_1.var_.characterEffect1084ui_story = var_332_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_28 = 0.200000002980232

			if var_332_27 <= arg_329_1.time_ and arg_329_1.time_ < var_332_27 + var_332_28 and not isNil(var_332_26) then
				local var_332_29 = (arg_329_1.time_ - var_332_27) / var_332_28

				if arg_329_1.var_.characterEffect1084ui_story and not isNil(var_332_26) then
					arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_27 + var_332_28 and arg_329_1.time_ < var_332_27 + var_332_28 + arg_332_0 and not isNil(var_332_26) and arg_329_1.var_.characterEffect1084ui_story then
				arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_332_30 = arg_329_1.actors_["10050ui_story"]
			local var_332_31 = 0

			if var_332_31 < arg_329_1.time_ and arg_329_1.time_ <= var_332_31 + arg_332_0 and not isNil(var_332_30) and arg_329_1.var_.characterEffect10050ui_story == nil then
				arg_329_1.var_.characterEffect10050ui_story = var_332_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_32 = 0.200000002980232

			if var_332_31 <= arg_329_1.time_ and arg_329_1.time_ < var_332_31 + var_332_32 and not isNil(var_332_30) then
				local var_332_33 = (arg_329_1.time_ - var_332_31) / var_332_32

				if arg_329_1.var_.characterEffect10050ui_story and not isNil(var_332_30) then
					arg_329_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_31 + var_332_32 and arg_329_1.time_ < var_332_31 + var_332_32 + arg_332_0 and not isNil(var_332_30) and arg_329_1.var_.characterEffect10050ui_story then
				arg_329_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_332_34 = 0
			local var_332_35 = 0.05

			if var_332_34 < arg_329_1.time_ and arg_329_1.time_ <= var_332_34 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_36 = arg_329_1:FormatText(StoryNameCfg[723].name)

				arg_329_1.leftNameTxt_.text = var_332_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_37 = arg_329_1:GetWordFromCfg(319791076)
				local var_332_38 = arg_329_1:FormatText(var_332_37.content)

				arg_329_1.text_.text = var_332_38

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_39 = 2
				local var_332_40 = utf8.len(var_332_38)
				local var_332_41 = var_332_39 <= 0 and var_332_35 or var_332_35 * (var_332_40 / var_332_39)

				if var_332_41 > 0 and var_332_35 < var_332_41 then
					arg_329_1.talkMaxDuration = var_332_41

					if var_332_41 + var_332_34 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_41 + var_332_34
					end
				end

				arg_329_1.text_.text = var_332_38
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791076", "story_v_out_319791.awb") ~= 0 then
					local var_332_42 = manager.audio:GetVoiceLength("story_v_out_319791", "319791076", "story_v_out_319791.awb") / 1000

					if var_332_42 + var_332_34 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_42 + var_332_34
					end

					if var_332_37.prefab_name ~= "" and arg_329_1.actors_[var_332_37.prefab_name] ~= nil then
						local var_332_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_37.prefab_name].transform, "story_v_out_319791", "319791076", "story_v_out_319791.awb")

						arg_329_1:RecordAudio("319791076", var_332_43)
						arg_329_1:RecordAudio("319791076", var_332_43)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_319791", "319791076", "story_v_out_319791.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_319791", "319791076", "story_v_out_319791.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_44 = math.max(var_332_35, arg_329_1.talkMaxDuration)

			if var_332_34 <= arg_329_1.time_ and arg_329_1.time_ < var_332_34 + var_332_44 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_34) / var_332_44

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_34 + var_332_44 and arg_329_1.time_ < var_332_34 + var_332_44 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play319791077 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 319791077
		arg_333_1.duration_ = 4.87

		local var_333_0 = {
			zh = 3.6,
			ja = 4.866
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
				arg_333_0:Play319791078(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_336_1 = arg_333_1.actors_["1084ui_story"]
			local var_336_2 = 0

			if var_336_2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1084ui_story == nil then
				arg_333_1.var_.characterEffect1084ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.200000002980232

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_3 and not isNil(var_336_1) then
				local var_336_4 = (arg_333_1.time_ - var_336_2) / var_336_3

				if arg_333_1.var_.characterEffect1084ui_story and not isNil(var_336_1) then
					local var_336_5 = Mathf.Lerp(0, 0.5, var_336_4)

					arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1084ui_story.fillRatio = var_336_5
				end
			end

			if arg_333_1.time_ >= var_336_2 + var_336_3 and arg_333_1.time_ < var_336_2 + var_336_3 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1084ui_story then
				local var_336_6 = 0.5

				arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1084ui_story.fillRatio = var_336_6
			end

			local var_336_7 = 0
			local var_336_8 = 0.425

			if var_336_7 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_9 = arg_333_1:FormatText(StoryNameCfg[692].name)

				arg_333_1.leftNameTxt_.text = var_336_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_10 = arg_333_1:GetWordFromCfg(319791077)
				local var_336_11 = arg_333_1:FormatText(var_336_10.content)

				arg_333_1.text_.text = var_336_11

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_12 = 17
				local var_336_13 = utf8.len(var_336_11)
				local var_336_14 = var_336_12 <= 0 and var_336_8 or var_336_8 * (var_336_13 / var_336_12)

				if var_336_14 > 0 and var_336_8 < var_336_14 then
					arg_333_1.talkMaxDuration = var_336_14

					if var_336_14 + var_336_7 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_7
					end
				end

				arg_333_1.text_.text = var_336_11
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791077", "story_v_out_319791.awb") ~= 0 then
					local var_336_15 = manager.audio:GetVoiceLength("story_v_out_319791", "319791077", "story_v_out_319791.awb") / 1000

					if var_336_15 + var_336_7 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_7
					end

					if var_336_10.prefab_name ~= "" and arg_333_1.actors_[var_336_10.prefab_name] ~= nil then
						local var_336_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_10.prefab_name].transform, "story_v_out_319791", "319791077", "story_v_out_319791.awb")

						arg_333_1:RecordAudio("319791077", var_336_16)
						arg_333_1:RecordAudio("319791077", var_336_16)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_319791", "319791077", "story_v_out_319791.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_319791", "319791077", "story_v_out_319791.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_17 = math.max(var_336_8, arg_333_1.talkMaxDuration)

			if var_336_7 <= arg_333_1.time_ and arg_333_1.time_ < var_336_7 + var_336_17 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_7) / var_336_17

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_7 + var_336_17 and arg_333_1.time_ < var_336_7 + var_336_17 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play319791078 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 319791078
		arg_337_1.duration_ = 2.6

		local var_337_0 = {
			zh = 2.533,
			ja = 2.6
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
				arg_337_0:Play319791079(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1084ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1084ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(-0.7, -0.97, -6)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1084ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_340_11 = arg_337_1.actors_["1084ui_story"]
			local var_340_12 = 0

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = var_340_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_13 = 0.200000002980232

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_13 and not isNil(var_340_11) then
				local var_340_14 = (arg_337_1.time_ - var_340_12) / var_340_13

				if arg_337_1.var_.characterEffect1084ui_story and not isNil(var_340_11) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_12 + var_340_13 and arg_337_1.time_ < var_340_12 + var_340_13 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_340_15 = arg_337_1.actors_["10050ui_story"]
			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.characterEffect10050ui_story == nil then
				arg_337_1.var_.characterEffect10050ui_story = var_340_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_17 = 0.200000002980232

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_17 and not isNil(var_340_15) then
				local var_340_18 = (arg_337_1.time_ - var_340_16) / var_340_17

				if arg_337_1.var_.characterEffect10050ui_story and not isNil(var_340_15) then
					local var_340_19 = Mathf.Lerp(0, 0.5, var_340_18)

					arg_337_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10050ui_story.fillRatio = var_340_19
				end
			end

			if arg_337_1.time_ >= var_340_16 + var_340_17 and arg_337_1.time_ < var_340_16 + var_340_17 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.characterEffect10050ui_story then
				local var_340_20 = 0.5

				arg_337_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10050ui_story.fillRatio = var_340_20
			end

			local var_340_21 = 0
			local var_340_22 = 0.275

			if var_340_21 < arg_337_1.time_ and arg_337_1.time_ <= var_340_21 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_23 = arg_337_1:FormatText(StoryNameCfg[6].name)

				arg_337_1.leftNameTxt_.text = var_340_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_24 = arg_337_1:GetWordFromCfg(319791078)
				local var_340_25 = arg_337_1:FormatText(var_340_24.content)

				arg_337_1.text_.text = var_340_25

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_26 = 11
				local var_340_27 = utf8.len(var_340_25)
				local var_340_28 = var_340_26 <= 0 and var_340_22 or var_340_22 * (var_340_27 / var_340_26)

				if var_340_28 > 0 and var_340_22 < var_340_28 then
					arg_337_1.talkMaxDuration = var_340_28

					if var_340_28 + var_340_21 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_28 + var_340_21
					end
				end

				arg_337_1.text_.text = var_340_25
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791078", "story_v_out_319791.awb") ~= 0 then
					local var_340_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791078", "story_v_out_319791.awb") / 1000

					if var_340_29 + var_340_21 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_29 + var_340_21
					end

					if var_340_24.prefab_name ~= "" and arg_337_1.actors_[var_340_24.prefab_name] ~= nil then
						local var_340_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_24.prefab_name].transform, "story_v_out_319791", "319791078", "story_v_out_319791.awb")

						arg_337_1:RecordAudio("319791078", var_340_30)
						arg_337_1:RecordAudio("319791078", var_340_30)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_319791", "319791078", "story_v_out_319791.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_319791", "319791078", "story_v_out_319791.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_31 = math.max(var_340_22, arg_337_1.talkMaxDuration)

			if var_340_21 <= arg_337_1.time_ and arg_337_1.time_ < var_340_21 + var_340_31 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_21) / var_340_31

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_21 + var_340_31 and arg_337_1.time_ < var_340_21 + var_340_31 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play319791079 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 319791079
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play319791080(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 1

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				local var_344_2 = "stop"
				local var_344_3 = "effect"

				arg_341_1:AudioAction(var_344_2, var_344_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_344_4 = arg_341_1.actors_["1084ui_story"]
			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = var_344_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_6 = 0.200000002980232

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_6 and not isNil(var_344_4) then
				local var_344_7 = (arg_341_1.time_ - var_344_5) / var_344_6

				if arg_341_1.var_.characterEffect1084ui_story and not isNil(var_344_4) then
					local var_344_8 = Mathf.Lerp(0, 0.5, var_344_7)

					arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1084ui_story.fillRatio = var_344_8
				end
			end

			if arg_341_1.time_ >= var_344_5 + var_344_6 and arg_341_1.time_ < var_344_5 + var_344_6 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect1084ui_story then
				local var_344_9 = 0.5

				arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1084ui_story.fillRatio = var_344_9
			end

			local var_344_10 = 0
			local var_344_11 = 0.825

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_12 = arg_341_1:GetWordFromCfg(319791079)
				local var_344_13 = arg_341_1:FormatText(var_344_12.content)

				arg_341_1.text_.text = var_344_13

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_14 = 33
				local var_344_15 = utf8.len(var_344_13)
				local var_344_16 = var_344_14 <= 0 and var_344_11 or var_344_11 * (var_344_15 / var_344_14)

				if var_344_16 > 0 and var_344_11 < var_344_16 then
					arg_341_1.talkMaxDuration = var_344_16

					if var_344_16 + var_344_10 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_16 + var_344_10
					end
				end

				arg_341_1.text_.text = var_344_13
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_17 = math.max(var_344_11, arg_341_1.talkMaxDuration)

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_17 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_10) / var_344_17

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_10 + var_344_17 and arg_341_1.time_ < var_344_10 + var_344_17 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play319791080 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 319791080
		arg_345_1.duration_ = 4.63

		local var_345_0 = {
			zh = 4.633,
			ja = 3.4
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
				arg_345_0:Play319791081(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10050ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10050ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0.7, -0.715, -6.15)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10050ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["10050ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10050ui_story == nil then
				arg_345_1.var_.characterEffect10050ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect10050ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10050ui_story then
				arg_345_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action4132")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_15 = 0
			local var_348_16 = 0.45

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[692].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(319791080)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 18
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791080", "story_v_out_319791.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_out_319791", "319791080", "story_v_out_319791.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_out_319791", "319791080", "story_v_out_319791.awb")

						arg_345_1:RecordAudio("319791080", var_348_24)
						arg_345_1:RecordAudio("319791080", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_319791", "319791080", "story_v_out_319791.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_319791", "319791080", "story_v_out_319791.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play319791081 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 319791081
		arg_349_1.duration_ = 4.1

		local var_349_0 = {
			zh = 4.1,
			ja = 3.666
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
				arg_349_0:Play319791082(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1084ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1084ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(-0.7, -0.97, -6)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1084ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1084ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_9) then
					arg_349_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1084ui_story then
				arg_349_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_352_13 = 0

			if var_352_13 < arg_349_1.time_ and arg_349_1.time_ <= var_352_13 + arg_352_0 then
				arg_349_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_352_14 = 0

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 then
				arg_349_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_352_15 = arg_349_1.actors_["10050ui_story"]
			local var_352_16 = 0

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 and not isNil(var_352_15) and arg_349_1.var_.characterEffect10050ui_story == nil then
				arg_349_1.var_.characterEffect10050ui_story = var_352_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_17 = 0.200000002980232

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_17 and not isNil(var_352_15) then
				local var_352_18 = (arg_349_1.time_ - var_352_16) / var_352_17

				if arg_349_1.var_.characterEffect10050ui_story and not isNil(var_352_15) then
					local var_352_19 = Mathf.Lerp(0, 0.5, var_352_18)

					arg_349_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10050ui_story.fillRatio = var_352_19
				end
			end

			if arg_349_1.time_ >= var_352_16 + var_352_17 and arg_349_1.time_ < var_352_16 + var_352_17 + arg_352_0 and not isNil(var_352_15) and arg_349_1.var_.characterEffect10050ui_story then
				local var_352_20 = 0.5

				arg_349_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10050ui_story.fillRatio = var_352_20
			end

			local var_352_21 = 0
			local var_352_22 = 0.425

			if var_352_21 < arg_349_1.time_ and arg_349_1.time_ <= var_352_21 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_23 = arg_349_1:FormatText(StoryNameCfg[6].name)

				arg_349_1.leftNameTxt_.text = var_352_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_24 = arg_349_1:GetWordFromCfg(319791081)
				local var_352_25 = arg_349_1:FormatText(var_352_24.content)

				arg_349_1.text_.text = var_352_25

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_26 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319791", "319791081", "story_v_out_319791.awb") ~= 0 then
					local var_352_29 = manager.audio:GetVoiceLength("story_v_out_319791", "319791081", "story_v_out_319791.awb") / 1000

					if var_352_29 + var_352_21 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_29 + var_352_21
					end

					if var_352_24.prefab_name ~= "" and arg_349_1.actors_[var_352_24.prefab_name] ~= nil then
						local var_352_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_24.prefab_name].transform, "story_v_out_319791", "319791081", "story_v_out_319791.awb")

						arg_349_1:RecordAudio("319791081", var_352_30)
						arg_349_1:RecordAudio("319791081", var_352_30)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_319791", "319791081", "story_v_out_319791.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_319791", "319791081", "story_v_out_319791.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play319791082 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 319791082
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1084ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1084ui_story == nil then
				arg_353_1.var_.characterEffect1084ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1084ui_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1084ui_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1084ui_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1084ui_story.fillRatio = var_356_5
			end

			local var_356_6 = arg_353_1.actors_["10050ui_story"].transform
			local var_356_7 = 0

			if var_356_7 < arg_353_1.time_ and arg_353_1.time_ <= var_356_7 + arg_356_0 then
				arg_353_1.var_.moveOldPos10050ui_story = var_356_6.localPosition
			end

			local var_356_8 = 0.001

			if var_356_7 <= arg_353_1.time_ and arg_353_1.time_ < var_356_7 + var_356_8 then
				local var_356_9 = (arg_353_1.time_ - var_356_7) / var_356_8
				local var_356_10 = Vector3.New(0, 100, 0)

				var_356_6.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10050ui_story, var_356_10, var_356_9)

				local var_356_11 = manager.ui.mainCamera.transform.position - var_356_6.position

				var_356_6.forward = Vector3.New(var_356_11.x, var_356_11.y, var_356_11.z)

				local var_356_12 = var_356_6.localEulerAngles

				var_356_12.z = 0
				var_356_12.x = 0
				var_356_6.localEulerAngles = var_356_12
			end

			if arg_353_1.time_ >= var_356_7 + var_356_8 and arg_353_1.time_ < var_356_7 + var_356_8 + arg_356_0 then
				var_356_6.localPosition = Vector3.New(0, 100, 0)

				local var_356_13 = manager.ui.mainCamera.transform.position - var_356_6.position

				var_356_6.forward = Vector3.New(var_356_13.x, var_356_13.y, var_356_13.z)

				local var_356_14 = var_356_6.localEulerAngles

				var_356_14.z = 0
				var_356_14.x = 0
				var_356_6.localEulerAngles = var_356_14
			end

			local var_356_15 = arg_353_1.actors_["1084ui_story"].transform
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.var_.moveOldPos1084ui_story = var_356_15.localPosition
			end

			local var_356_17 = 0.001

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_17 then
				local var_356_18 = (arg_353_1.time_ - var_356_16) / var_356_17
				local var_356_19 = Vector3.New(0, 100, 0)

				var_356_15.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1084ui_story, var_356_19, var_356_18)

				local var_356_20 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_20.x, var_356_20.y, var_356_20.z)

				local var_356_21 = var_356_15.localEulerAngles

				var_356_21.z = 0
				var_356_21.x = 0
				var_356_15.localEulerAngles = var_356_21
			end

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				var_356_15.localPosition = Vector3.New(0, 100, 0)

				local var_356_22 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_22.x, var_356_22.y, var_356_22.z)

				local var_356_23 = var_356_15.localEulerAngles

				var_356_23.z = 0
				var_356_23.x = 0
				var_356_15.localEulerAngles = var_356_23
			end

			local var_356_24 = 0
			local var_356_25 = 1.2

			if var_356_24 < arg_353_1.time_ and arg_353_1.time_ <= var_356_24 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_26 = arg_353_1:GetWordFromCfg(319791082)
				local var_356_27 = arg_353_1:FormatText(var_356_26.content)

				arg_353_1.text_.text = var_356_27

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_28 = 48
				local var_356_29 = utf8.len(var_356_27)
				local var_356_30 = var_356_28 <= 0 and var_356_25 or var_356_25 * (var_356_29 / var_356_28)

				if var_356_30 > 0 and var_356_25 < var_356_30 then
					arg_353_1.talkMaxDuration = var_356_30

					if var_356_30 + var_356_24 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_30 + var_356_24
					end
				end

				arg_353_1.text_.text = var_356_27
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_31 = math.max(var_356_25, arg_353_1.talkMaxDuration)

			if var_356_24 <= arg_353_1.time_ and arg_353_1.time_ < var_356_24 + var_356_31 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_24) / var_356_31

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_24 + var_356_31 and arg_353_1.time_ < var_356_24 + var_356_31 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/ST70",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST71"
	},
	voices = {
		"story_v_out_319791.awb"
	}
}
