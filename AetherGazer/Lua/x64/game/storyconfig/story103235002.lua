return {
	Play323502001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323502001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323502002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J21f"

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
				local var_4_5 = arg_1_1.bgs_.J21f

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
					if iter_4_0 ~= "J21f" then
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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

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

			local var_4_36 = 0.166666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_40 = 0.466666666666667
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "bgm_activity_4_8_story_dahuang_pingyuan", "init_story", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "init_story")

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

			local var_4_46 = 1.8
			local var_4_47 = 0.425

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
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

				local var_4_50 = arg_1_1:GetWordFromCfg(323502001)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_52 = 17
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
	Play323502002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 323502002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play323502003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 1.05

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_2 = arg_10_1:GetWordFromCfg(323502002)
				local var_13_3 = arg_10_1:FormatText(var_13_2.content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 42
				local var_13_5 = utf8.len(var_13_3)
				local var_13_6 = var_13_4 <= 0 and var_13_1 or var_13_1 * (var_13_5 / var_13_4)

				if var_13_6 > 0 and var_13_1 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_7 and arg_10_1.time_ < var_13_0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play323502003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 323502003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play323502004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.7
			local var_17_1 = 1

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				local var_17_2 = "play"
				local var_17_3 = "effect"

				arg_14_1:AudioAction(var_17_2, var_17_3, "se_story_148", "se_story_148_footstep02", "")
			end

			local var_17_4 = 0
			local var_17_5 = 1.175

			if var_17_4 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_6 = arg_14_1:GetWordFromCfg(323502003)
				local var_17_7 = arg_14_1:FormatText(var_17_6.content)

				arg_14_1.text_.text = var_17_7

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_8 = 47
				local var_17_9 = utf8.len(var_17_7)
				local var_17_10 = var_17_8 <= 0 and var_17_5 or var_17_5 * (var_17_9 / var_17_8)

				if var_17_10 > 0 and var_17_5 < var_17_10 then
					arg_14_1.talkMaxDuration = var_17_10

					if var_17_10 + var_17_4 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_4
					end
				end

				arg_14_1.text_.text = var_17_7
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_11 = math.max(var_17_5, arg_14_1.talkMaxDuration)

			if var_17_4 <= arg_14_1.time_ and arg_14_1.time_ < var_17_4 + var_17_11 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_4) / var_17_11

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_4 + var_17_11 and arg_14_1.time_ < var_17_4 + var_17_11 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play323502004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 323502004
		arg_18_1.duration_ = 2.5

		local var_18_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play323502005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "10162ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "10162ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_18_1.stage_.transform)

					var_21_2.name = var_21_0
					var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_0] = var_21_2

					local var_21_3 = var_21_2:GetComponentInChildren(typeof(CharacterEffect))

					var_21_3.enabled = true

					local var_21_4 = GameObjectTools.GetOrAddComponent(var_21_2, typeof(DynamicBoneHelper))

					if var_21_4 then
						var_21_4:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_3.transform, false)

					arg_18_1.var_[var_21_0 .. "Animator"] = var_21_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_0 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_0 .. "LipSync"] = var_21_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_5 = arg_18_1.actors_["10162ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos10162ui_story = var_21_5.localPosition

				local var_21_7 = GameObjectTools.GetOrAddComponent(var_21_5.gameObject, typeof(DynamicBoneHelper))

				if var_21_7 then
					var_21_7:EnableDynamicBone(false)
				end
			end

			local var_21_8 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_8 then
				local var_21_9 = (arg_18_1.time_ - var_21_6) / var_21_8
				local var_21_10 = Vector3.New(0, -1.08, -5.83)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10162ui_story, var_21_10, var_21_9)

				local var_21_11 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_11.x, var_21_11.y, var_21_11.z)

				local var_21_12 = var_21_5.localEulerAngles

				var_21_12.z = 0
				var_21_12.x = 0
				var_21_5.localEulerAngles = var_21_12
			end

			if arg_18_1.time_ >= var_21_6 + var_21_8 and arg_18_1.time_ < var_21_6 + var_21_8 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_21_13 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_13.x, var_21_13.y, var_21_13.z)

				local var_21_14 = var_21_5.localEulerAngles

				var_21_14.z = 0
				var_21_14.x = 0
				var_21_5.localEulerAngles = var_21_14

				local var_21_15 = GameObjectTools.GetOrAddComponent(var_21_5.gameObject, typeof(DynamicBoneHelper))

				if var_21_15 then
					var_21_15:EnableDynamicBone(true)
				end
			end

			local var_21_16 = arg_18_1.actors_["10162ui_story"]
			local var_21_17 = 0

			if var_21_17 < arg_18_1.time_ and arg_18_1.time_ <= var_21_17 + arg_21_0 and not isNil(var_21_16) and arg_18_1.var_.characterEffect10162ui_story == nil then
				arg_18_1.var_.characterEffect10162ui_story = var_21_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_18 = 0.200000002980232

			if var_21_17 <= arg_18_1.time_ and arg_18_1.time_ < var_21_17 + var_21_18 and not isNil(var_21_16) then
				local var_21_19 = (arg_18_1.time_ - var_21_17) / var_21_18

				if arg_18_1.var_.characterEffect10162ui_story and not isNil(var_21_16) then
					arg_18_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_17 + var_21_18 and arg_18_1.time_ < var_21_17 + var_21_18 + arg_21_0 and not isNil(var_21_16) and arg_18_1.var_.characterEffect10162ui_story then
				arg_18_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_21_20 = 0

			if var_21_20 < arg_18_1.time_ and arg_18_1.time_ <= var_21_20 + arg_21_0 then
				arg_18_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_21_21 = 0
			local var_21_22 = 0.175

			if var_21_21 < arg_18_1.time_ and arg_18_1.time_ <= var_21_21 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_23 = arg_18_1:FormatText(StoryNameCfg[1459].name)

				arg_18_1.leftNameTxt_.text = var_21_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_24 = arg_18_1:GetWordFromCfg(323502004)
				local var_21_25 = arg_18_1:FormatText(var_21_24.content)

				arg_18_1.text_.text = var_21_25

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_26 = 7
				local var_21_27 = utf8.len(var_21_25)
				local var_21_28 = var_21_26 <= 0 and var_21_22 or var_21_22 * (var_21_27 / var_21_26)

				if var_21_28 > 0 and var_21_22 < var_21_28 then
					arg_18_1.talkMaxDuration = var_21_28

					if var_21_28 + var_21_21 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_28 + var_21_21
					end
				end

				arg_18_1.text_.text = var_21_25
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502004", "story_v_out_323502.awb") ~= 0 then
					local var_21_29 = manager.audio:GetVoiceLength("story_v_out_323502", "323502004", "story_v_out_323502.awb") / 1000

					if var_21_29 + var_21_21 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_29 + var_21_21
					end

					if var_21_24.prefab_name ~= "" and arg_18_1.actors_[var_21_24.prefab_name] ~= nil then
						local var_21_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_24.prefab_name].transform, "story_v_out_323502", "323502004", "story_v_out_323502.awb")

						arg_18_1:RecordAudio("323502004", var_21_30)
						arg_18_1:RecordAudio("323502004", var_21_30)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_323502", "323502004", "story_v_out_323502.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_323502", "323502004", "story_v_out_323502.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_31 = math.max(var_21_22, arg_18_1.talkMaxDuration)

			if var_21_21 <= arg_18_1.time_ and arg_18_1.time_ < var_21_21 + var_21_31 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_21) / var_21_31

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_21 + var_21_31 and arg_18_1.time_ < var_21_21 + var_21_31 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play323502005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 323502005
		arg_22_1.duration_ = 2

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play323502006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10162ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos10162ui_story = var_25_0.localPosition

				local var_25_2 = GameObjectTools.GetOrAddComponent(var_25_0.gameObject, typeof(DynamicBoneHelper))

				if var_25_2 then
					var_25_2:EnableDynamicBone(false)
				end
			end

			local var_25_3 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_3 then
				local var_25_4 = (arg_22_1.time_ - var_25_1) / var_25_3
				local var_25_5 = Vector3.New(0, 100, 0)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10162ui_story, var_25_5, var_25_4)

				local var_25_6 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_6.x, var_25_6.y, var_25_6.z)

				local var_25_7 = var_25_0.localEulerAngles

				var_25_7.z = 0
				var_25_7.x = 0
				var_25_0.localEulerAngles = var_25_7
			end

			if arg_22_1.time_ >= var_25_1 + var_25_3 and arg_22_1.time_ < var_25_1 + var_25_3 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0, 100, 0)

				local var_25_8 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_8.x, var_25_8.y, var_25_8.z)

				local var_25_9 = var_25_0.localEulerAngles

				var_25_9.z = 0
				var_25_9.x = 0
				var_25_0.localEulerAngles = var_25_9

				local var_25_10 = GameObjectTools.GetOrAddComponent(var_25_0.gameObject, typeof(DynamicBoneHelper))

				if var_25_10 then
					var_25_10:EnableDynamicBone(true)
				end
			end

			local var_25_11 = arg_22_1.actors_["10162ui_story"]
			local var_25_12 = 0

			if var_25_12 < arg_22_1.time_ and arg_22_1.time_ <= var_25_12 + arg_25_0 and not isNil(var_25_11) and arg_22_1.var_.characterEffect10162ui_story == nil then
				arg_22_1.var_.characterEffect10162ui_story = var_25_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_13 = 0.200000002980232

			if var_25_12 <= arg_22_1.time_ and arg_22_1.time_ < var_25_12 + var_25_13 and not isNil(var_25_11) then
				local var_25_14 = (arg_22_1.time_ - var_25_12) / var_25_13

				if arg_22_1.var_.characterEffect10162ui_story and not isNil(var_25_11) then
					local var_25_15 = Mathf.Lerp(0, 0.5, var_25_14)

					arg_22_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10162ui_story.fillRatio = var_25_15
				end
			end

			if arg_22_1.time_ >= var_25_12 + var_25_13 and arg_22_1.time_ < var_25_12 + var_25_13 + arg_25_0 and not isNil(var_25_11) and arg_22_1.var_.characterEffect10162ui_story then
				local var_25_16 = 0.5

				arg_22_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10162ui_story.fillRatio = var_25_16
			end

			local var_25_17 = "10170ui_story"

			if arg_22_1.actors_[var_25_17] == nil then
				local var_25_18 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_25_18) then
					local var_25_19 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_22_1.stage_.transform)

					var_25_19.name = var_25_17
					var_25_19.transform.localPosition = Vector3.New(0, 100, 0)
					arg_22_1.actors_[var_25_17] = var_25_19

					local var_25_20 = var_25_19:GetComponentInChildren(typeof(CharacterEffect))

					var_25_20.enabled = true

					local var_25_21 = GameObjectTools.GetOrAddComponent(var_25_19, typeof(DynamicBoneHelper))

					if var_25_21 then
						var_25_21:EnableDynamicBone(false)
					end

					arg_22_1:ShowWeapon(var_25_20.transform, false)

					arg_22_1.var_[var_25_17 .. "Animator"] = var_25_20.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_22_1.var_[var_25_17 .. "Animator"].applyRootMotion = true
					arg_22_1.var_[var_25_17 .. "LipSync"] = var_25_20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_25_22 = arg_22_1.actors_["10170ui_story"].transform
			local var_25_23 = 0

			if var_25_23 < arg_22_1.time_ and arg_22_1.time_ <= var_25_23 + arg_25_0 then
				arg_22_1.var_.moveOldPos10170ui_story = var_25_22.localPosition

				local var_25_24 = GameObjectTools.GetOrAddComponent(var_25_22.gameObject, typeof(DynamicBoneHelper))

				if var_25_24 then
					var_25_24:EnableDynamicBone(false)
				end
			end

			local var_25_25 = 0.001

			if var_25_23 <= arg_22_1.time_ and arg_22_1.time_ < var_25_23 + var_25_25 then
				local var_25_26 = (arg_22_1.time_ - var_25_23) / var_25_25
				local var_25_27 = Vector3.New(0, -1.03, -6.05)

				var_25_22.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10170ui_story, var_25_27, var_25_26)

				local var_25_28 = manager.ui.mainCamera.transform.position - var_25_22.position

				var_25_22.forward = Vector3.New(var_25_28.x, var_25_28.y, var_25_28.z)

				local var_25_29 = var_25_22.localEulerAngles

				var_25_29.z = 0
				var_25_29.x = 0
				var_25_22.localEulerAngles = var_25_29
			end

			if arg_22_1.time_ >= var_25_23 + var_25_25 and arg_22_1.time_ < var_25_23 + var_25_25 + arg_25_0 then
				var_25_22.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_25_30 = manager.ui.mainCamera.transform.position - var_25_22.position

				var_25_22.forward = Vector3.New(var_25_30.x, var_25_30.y, var_25_30.z)

				local var_25_31 = var_25_22.localEulerAngles

				var_25_31.z = 0
				var_25_31.x = 0
				var_25_22.localEulerAngles = var_25_31

				local var_25_32 = GameObjectTools.GetOrAddComponent(var_25_22.gameObject, typeof(DynamicBoneHelper))

				if var_25_32 then
					var_25_32:EnableDynamicBone(true)
				end
			end

			local var_25_33 = arg_22_1.actors_["10170ui_story"]
			local var_25_34 = 0

			if var_25_34 < arg_22_1.time_ and arg_22_1.time_ <= var_25_34 + arg_25_0 and not isNil(var_25_33) and arg_22_1.var_.characterEffect10170ui_story == nil then
				arg_22_1.var_.characterEffect10170ui_story = var_25_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_35 = 0.200000002980232

			if var_25_34 <= arg_22_1.time_ and arg_22_1.time_ < var_25_34 + var_25_35 and not isNil(var_25_33) then
				local var_25_36 = (arg_22_1.time_ - var_25_34) / var_25_35

				if arg_22_1.var_.characterEffect10170ui_story and not isNil(var_25_33) then
					arg_22_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_34 + var_25_35 and arg_22_1.time_ < var_25_34 + var_25_35 + arg_25_0 and not isNil(var_25_33) and arg_22_1.var_.characterEffect10170ui_story then
				arg_22_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_25_37 = 0

			if var_25_37 < arg_22_1.time_ and arg_22_1.time_ <= var_25_37 + arg_25_0 then
				arg_22_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_25_38 = 0

			if var_25_38 < arg_22_1.time_ and arg_22_1.time_ <= var_25_38 + arg_25_0 then
				arg_22_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_25_39 = 0
			local var_25_40 = 0.15

			if var_25_39 < arg_22_1.time_ and arg_22_1.time_ <= var_25_39 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_41 = arg_22_1:FormatText(StoryNameCfg[1450].name)

				arg_22_1.leftNameTxt_.text = var_25_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_42 = arg_22_1:GetWordFromCfg(323502005)
				local var_25_43 = arg_22_1:FormatText(var_25_42.content)

				arg_22_1.text_.text = var_25_43

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_44 = 6
				local var_25_45 = utf8.len(var_25_43)
				local var_25_46 = var_25_44 <= 0 and var_25_40 or var_25_40 * (var_25_45 / var_25_44)

				if var_25_46 > 0 and var_25_40 < var_25_46 then
					arg_22_1.talkMaxDuration = var_25_46

					if var_25_46 + var_25_39 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_46 + var_25_39
					end
				end

				arg_22_1.text_.text = var_25_43
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502005", "story_v_out_323502.awb") ~= 0 then
					local var_25_47 = manager.audio:GetVoiceLength("story_v_out_323502", "323502005", "story_v_out_323502.awb") / 1000

					if var_25_47 + var_25_39 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_47 + var_25_39
					end

					if var_25_42.prefab_name ~= "" and arg_22_1.actors_[var_25_42.prefab_name] ~= nil then
						local var_25_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_42.prefab_name].transform, "story_v_out_323502", "323502005", "story_v_out_323502.awb")

						arg_22_1:RecordAudio("323502005", var_25_48)
						arg_22_1:RecordAudio("323502005", var_25_48)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_323502", "323502005", "story_v_out_323502.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_323502", "323502005", "story_v_out_323502.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_49 = math.max(var_25_40, arg_22_1.talkMaxDuration)

			if var_25_39 <= arg_22_1.time_ and arg_22_1.time_ < var_25_39 + var_25_49 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_39) / var_25_49

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_39 + var_25_49 and arg_22_1.time_ < var_25_39 + var_25_49 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play323502006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 323502006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play323502007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10170ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10170ui_story == nil then
				arg_26_1.var_.characterEffect10170ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect10170ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_26_1.var_.characterEffect10170ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10170ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_26_1.var_.characterEffect10170ui_story.fillRatio = var_29_5
			end

			local var_29_6 = 0
			local var_29_7 = 0.525

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_8 = arg_26_1:FormatText(StoryNameCfg[7].name)

				arg_26_1.leftNameTxt_.text = var_29_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_9 = arg_26_1:GetWordFromCfg(323502006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 21
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_7 or var_29_7 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_7 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play323502007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323502007
		arg_30_1.duration_ = 2.03

		local var_30_0 = {
			zh = 1.3,
			ja = 2.033
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323502008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10170ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10170ui_story == nil then
				arg_30_1.var_.characterEffect10170ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10170ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10170ui_story then
				arg_30_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_33_4 = 0
			local var_33_5 = 0.15

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_6 = arg_30_1:FormatText(StoryNameCfg[1450].name)

				arg_30_1.leftNameTxt_.text = var_33_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(323502007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 6
				local var_33_10 = utf8.len(var_33_8)
				local var_33_11 = var_33_9 <= 0 and var_33_5 or var_33_5 * (var_33_10 / var_33_9)

				if var_33_11 > 0 and var_33_5 < var_33_11 then
					arg_30_1.talkMaxDuration = var_33_11

					if var_33_11 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502007", "story_v_out_323502.awb") ~= 0 then
					local var_33_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502007", "story_v_out_323502.awb") / 1000

					if var_33_12 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_12 + var_33_4
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_323502", "323502007", "story_v_out_323502.awb")

						arg_30_1:RecordAudio("323502007", var_33_13)
						arg_30_1:RecordAudio("323502007", var_33_13)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_323502", "323502007", "story_v_out_323502.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_323502", "323502007", "story_v_out_323502.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_14 and arg_30_1.time_ < var_33_4 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play323502008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 323502008
		arg_34_1.duration_ = 5.2

		local var_34_0 = {
			zh = 2.966,
			ja = 5.2
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play323502009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10162ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos10162ui_story = var_37_0.localPosition

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0.gameObject, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end
			end

			local var_37_3 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_3 then
				local var_37_4 = (arg_34_1.time_ - var_37_1) / var_37_3
				local var_37_5 = Vector3.New(0, -1.08, -5.83)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10162ui_story, var_37_5, var_37_4)

				local var_37_6 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_6.x, var_37_6.y, var_37_6.z)

				local var_37_7 = var_37_0.localEulerAngles

				var_37_7.z = 0
				var_37_7.x = 0
				var_37_0.localEulerAngles = var_37_7
			end

			if arg_34_1.time_ >= var_37_1 + var_37_3 and arg_34_1.time_ < var_37_1 + var_37_3 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_37_8 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_8.x, var_37_8.y, var_37_8.z)

				local var_37_9 = var_37_0.localEulerAngles

				var_37_9.z = 0
				var_37_9.x = 0
				var_37_0.localEulerAngles = var_37_9

				local var_37_10 = GameObjectTools.GetOrAddComponent(var_37_0.gameObject, typeof(DynamicBoneHelper))

				if var_37_10 then
					var_37_10:EnableDynamicBone(true)
				end
			end

			local var_37_11 = arg_34_1.actors_["10162ui_story"]
			local var_37_12 = 0

			if var_37_12 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 and not isNil(var_37_11) and arg_34_1.var_.characterEffect10162ui_story == nil then
				arg_34_1.var_.characterEffect10162ui_story = var_37_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_13 = 0.200000002980232

			if var_37_12 <= arg_34_1.time_ and arg_34_1.time_ < var_37_12 + var_37_13 and not isNil(var_37_11) then
				local var_37_14 = (arg_34_1.time_ - var_37_12) / var_37_13

				if arg_34_1.var_.characterEffect10162ui_story and not isNil(var_37_11) then
					arg_34_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_12 + var_37_13 and arg_34_1.time_ < var_37_12 + var_37_13 + arg_37_0 and not isNil(var_37_11) and arg_34_1.var_.characterEffect10162ui_story then
				arg_34_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_37_15 = 0

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_37_16 = "1067ui_story"

			if arg_34_1.actors_[var_37_16] == nil then
				local var_37_17 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_37_17) then
					local var_37_18 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_34_1.stage_.transform)

					var_37_18.name = var_37_16
					var_37_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_16] = var_37_18

					local var_37_19 = var_37_18:GetComponentInChildren(typeof(CharacterEffect))

					var_37_19.enabled = true

					local var_37_20 = GameObjectTools.GetOrAddComponent(var_37_18, typeof(DynamicBoneHelper))

					if var_37_20 then
						var_37_20:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_19.transform, false)

					arg_34_1.var_[var_37_16 .. "Animator"] = var_37_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_16 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_16 .. "LipSync"] = var_37_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_21 = 0

			if var_37_21 < arg_34_1.time_ and arg_34_1.time_ <= var_37_21 + arg_37_0 then
				arg_34_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_22 = arg_34_1.actors_["10170ui_story"].transform
			local var_37_23 = 0

			if var_37_23 < arg_34_1.time_ and arg_34_1.time_ <= var_37_23 + arg_37_0 then
				arg_34_1.var_.moveOldPos10170ui_story = var_37_22.localPosition

				local var_37_24 = GameObjectTools.GetOrAddComponent(var_37_22.gameObject, typeof(DynamicBoneHelper))

				if var_37_24 then
					var_37_24:EnableDynamicBone(false)
				end
			end

			local var_37_25 = 0.001

			if var_37_23 <= arg_34_1.time_ and arg_34_1.time_ < var_37_23 + var_37_25 then
				local var_37_26 = (arg_34_1.time_ - var_37_23) / var_37_25
				local var_37_27 = Vector3.New(0, 100, 0)

				var_37_22.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10170ui_story, var_37_27, var_37_26)

				local var_37_28 = manager.ui.mainCamera.transform.position - var_37_22.position

				var_37_22.forward = Vector3.New(var_37_28.x, var_37_28.y, var_37_28.z)

				local var_37_29 = var_37_22.localEulerAngles

				var_37_29.z = 0
				var_37_29.x = 0
				var_37_22.localEulerAngles = var_37_29
			end

			if arg_34_1.time_ >= var_37_23 + var_37_25 and arg_34_1.time_ < var_37_23 + var_37_25 + arg_37_0 then
				var_37_22.localPosition = Vector3.New(0, 100, 0)

				local var_37_30 = manager.ui.mainCamera.transform.position - var_37_22.position

				var_37_22.forward = Vector3.New(var_37_30.x, var_37_30.y, var_37_30.z)

				local var_37_31 = var_37_22.localEulerAngles

				var_37_31.z = 0
				var_37_31.x = 0
				var_37_22.localEulerAngles = var_37_31

				local var_37_32 = GameObjectTools.GetOrAddComponent(var_37_22.gameObject, typeof(DynamicBoneHelper))

				if var_37_32 then
					var_37_32:EnableDynamicBone(true)
				end
			end

			local var_37_33 = 0
			local var_37_34 = 0.325

			if var_37_33 < arg_34_1.time_ and arg_34_1.time_ <= var_37_33 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_35 = arg_34_1:FormatText(StoryNameCfg[1459].name)

				arg_34_1.leftNameTxt_.text = var_37_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_36 = arg_34_1:GetWordFromCfg(323502008)
				local var_37_37 = arg_34_1:FormatText(var_37_36.content)

				arg_34_1.text_.text = var_37_37

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_38 = 13
				local var_37_39 = utf8.len(var_37_37)
				local var_37_40 = var_37_38 <= 0 and var_37_34 or var_37_34 * (var_37_39 / var_37_38)

				if var_37_40 > 0 and var_37_34 < var_37_40 then
					arg_34_1.talkMaxDuration = var_37_40

					if var_37_40 + var_37_33 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_40 + var_37_33
					end
				end

				arg_34_1.text_.text = var_37_37
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502008", "story_v_out_323502.awb") ~= 0 then
					local var_37_41 = manager.audio:GetVoiceLength("story_v_out_323502", "323502008", "story_v_out_323502.awb") / 1000

					if var_37_41 + var_37_33 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_41 + var_37_33
					end

					if var_37_36.prefab_name ~= "" and arg_34_1.actors_[var_37_36.prefab_name] ~= nil then
						local var_37_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_36.prefab_name].transform, "story_v_out_323502", "323502008", "story_v_out_323502.awb")

						arg_34_1:RecordAudio("323502008", var_37_42)
						arg_34_1:RecordAudio("323502008", var_37_42)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_323502", "323502008", "story_v_out_323502.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_323502", "323502008", "story_v_out_323502.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_43 = math.max(var_37_34, arg_34_1.talkMaxDuration)

			if var_37_33 <= arg_34_1.time_ and arg_34_1.time_ < var_37_33 + var_37_43 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_33) / var_37_43

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_33 + var_37_43 and arg_34_1.time_ < var_37_33 + var_37_43 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_34_1:InitPlayNodeList()
	end,
	Play323502009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 323502009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play323502010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10162ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10162ui_story == nil then
				arg_38_1.var_.characterEffect10162ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10162ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_38_1.var_.characterEffect10162ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10162ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_38_1.var_.characterEffect10162ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.1

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(323502009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 4
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play323502010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 323502010
		arg_42_1.duration_ = 11.2

		local var_42_0 = {
			zh = 7.9,
			ja = 11.2
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play323502011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10162ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10162ui_story == nil then
				arg_42_1.var_.characterEffect10162ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10162ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10162ui_story then
				arg_42_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_45_4 = 0
			local var_45_5 = 0.975

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_6 = arg_42_1:FormatText(StoryNameCfg[1459].name)

				arg_42_1.leftNameTxt_.text = var_45_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(323502010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 39
				local var_45_10 = utf8.len(var_45_8)
				local var_45_11 = var_45_9 <= 0 and var_45_5 or var_45_5 * (var_45_10 / var_45_9)

				if var_45_11 > 0 and var_45_5 < var_45_11 then
					arg_42_1.talkMaxDuration = var_45_11

					if var_45_11 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502010", "story_v_out_323502.awb") ~= 0 then
					local var_45_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502010", "story_v_out_323502.awb") / 1000

					if var_45_12 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_4
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_out_323502", "323502010", "story_v_out_323502.awb")

						arg_42_1:RecordAudio("323502010", var_45_13)
						arg_42_1:RecordAudio("323502010", var_45_13)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_323502", "323502010", "story_v_out_323502.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_323502", "323502010", "story_v_out_323502.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_14 and arg_42_1.time_ < var_45_4 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play323502011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 323502011
		arg_46_1.duration_ = 6.83

		local var_46_0 = {
			zh = 4.566,
			ja = 6.833
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play323502012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			local var_49_1 = 0
			local var_49_2 = 0.55

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_3 = arg_46_1:FormatText(StoryNameCfg[1459].name)

				arg_46_1.leftNameTxt_.text = var_49_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(323502011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 22
				local var_49_7 = utf8.len(var_49_5)
				local var_49_8 = var_49_6 <= 0 and var_49_2 or var_49_2 * (var_49_7 / var_49_6)

				if var_49_8 > 0 and var_49_2 < var_49_8 then
					arg_46_1.talkMaxDuration = var_49_8

					if var_49_8 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502011", "story_v_out_323502.awb") ~= 0 then
					local var_49_9 = manager.audio:GetVoiceLength("story_v_out_323502", "323502011", "story_v_out_323502.awb") / 1000

					if var_49_9 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_1
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_323502", "323502011", "story_v_out_323502.awb")

						arg_46_1:RecordAudio("323502011", var_49_10)
						arg_46_1:RecordAudio("323502011", var_49_10)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_323502", "323502011", "story_v_out_323502.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_323502", "323502011", "story_v_out_323502.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_11 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_11 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_11

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_11 and arg_46_1.time_ < var_49_1 + var_49_11 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play323502012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 323502012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play323502013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10162ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10162ui_story == nil then
				arg_50_1.var_.characterEffect10162ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10162ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10162ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10162ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10162ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.375

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

				local var_53_9 = arg_50_1:GetWordFromCfg(323502012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 15
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
	Play323502013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 323502013
		arg_54_1.duration_ = 15.77

		local var_54_0 = {
			zh = 10.066,
			ja = 15.766
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
				arg_54_0:Play323502014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10162ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10162ui_story == nil then
				arg_54_1.var_.characterEffect10162ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect10162ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10162ui_story then
				arg_54_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_57_4 = 0
			local var_57_5 = 1.125

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_6 = arg_54_1:FormatText(StoryNameCfg[1459].name)

				arg_54_1.leftNameTxt_.text = var_57_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(323502013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 45
				local var_57_10 = utf8.len(var_57_8)
				local var_57_11 = var_57_9 <= 0 and var_57_5 or var_57_5 * (var_57_10 / var_57_9)

				if var_57_11 > 0 and var_57_5 < var_57_11 then
					arg_54_1.talkMaxDuration = var_57_11

					if var_57_11 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502013", "story_v_out_323502.awb") ~= 0 then
					local var_57_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502013", "story_v_out_323502.awb") / 1000

					if var_57_12 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_4
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_323502", "323502013", "story_v_out_323502.awb")

						arg_54_1:RecordAudio("323502013", var_57_13)
						arg_54_1:RecordAudio("323502013", var_57_13)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_323502", "323502013", "story_v_out_323502.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_323502", "323502013", "story_v_out_323502.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_14 and arg_54_1.time_ < var_57_4 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play323502014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 323502014
		arg_58_1.duration_ = 11.93

		local var_58_0 = {
			zh = 8.866,
			ja = 11.933
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play323502015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.1

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1459].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(323502014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 44
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502014", "story_v_out_323502.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_323502", "323502014", "story_v_out_323502.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_323502", "323502014", "story_v_out_323502.awb")

						arg_58_1:RecordAudio("323502014", var_61_9)
						arg_58_1:RecordAudio("323502014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_323502", "323502014", "story_v_out_323502.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_323502", "323502014", "story_v_out_323502.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play323502015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 323502015
		arg_62_1.duration_ = 13.9

		local var_62_0 = {
			zh = 11.066,
			ja = 13.9
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play323502016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_65_1 = 0
			local var_65_2 = 1.2

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_3 = arg_62_1:FormatText(StoryNameCfg[1459].name)

				arg_62_1.leftNameTxt_.text = var_65_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(323502015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 48
				local var_65_7 = utf8.len(var_65_5)
				local var_65_8 = var_65_6 <= 0 and var_65_2 or var_65_2 * (var_65_7 / var_65_6)

				if var_65_8 > 0 and var_65_2 < var_65_8 then
					arg_62_1.talkMaxDuration = var_65_8

					if var_65_8 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502015", "story_v_out_323502.awb") ~= 0 then
					local var_65_9 = manager.audio:GetVoiceLength("story_v_out_323502", "323502015", "story_v_out_323502.awb") / 1000

					if var_65_9 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_1
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_323502", "323502015", "story_v_out_323502.awb")

						arg_62_1:RecordAudio("323502015", var_65_10)
						arg_62_1:RecordAudio("323502015", var_65_10)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_323502", "323502015", "story_v_out_323502.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_323502", "323502015", "story_v_out_323502.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_11 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_11 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_11

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_11 and arg_62_1.time_ < var_65_1 + var_65_11 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play323502016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 323502016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play323502017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10162ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10162ui_story == nil then
				arg_66_1.var_.characterEffect10162ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10162ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_66_1.var_.characterEffect10162ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10162ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_66_1.var_.characterEffect10162ui_story.fillRatio = var_69_5
			end

			local var_69_6 = 0
			local var_69_7 = 0.675

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_9 = arg_66_1:GetWordFromCfg(323502016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 27
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
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play323502017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 323502017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play323502018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.575

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

				local var_73_2 = arg_70_1:GetWordFromCfg(323502017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 63
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
	Play323502018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 323502018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play323502019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.375

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

				local var_77_2 = arg_74_1:GetWordFromCfg(323502018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 55
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
	Play323502019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 323502019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play323502020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.675

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_2

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

				local var_81_3 = arg_78_1:GetWordFromCfg(323502019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 27
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play323502020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 323502020
		arg_82_1.duration_ = 9.1

		local var_82_0 = {
			zh = 5.033,
			ja = 9.1
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play323502021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10162ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10162ui_story == nil then
				arg_82_1.var_.characterEffect10162ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10162ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10162ui_story then
				arg_82_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_85_4 = 0

			if var_85_4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_2")
			end

			local var_85_5 = 0
			local var_85_6 = 0.525

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_7 = arg_82_1:FormatText(StoryNameCfg[1459].name)

				arg_82_1.leftNameTxt_.text = var_85_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(323502020)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 21
				local var_85_11 = utf8.len(var_85_9)
				local var_85_12 = var_85_10 <= 0 and var_85_6 or var_85_6 * (var_85_11 / var_85_10)

				if var_85_12 > 0 and var_85_6 < var_85_12 then
					arg_82_1.talkMaxDuration = var_85_12

					if var_85_12 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502020", "story_v_out_323502.awb") ~= 0 then
					local var_85_13 = manager.audio:GetVoiceLength("story_v_out_323502", "323502020", "story_v_out_323502.awb") / 1000

					if var_85_13 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_5
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_out_323502", "323502020", "story_v_out_323502.awb")

						arg_82_1:RecordAudio("323502020", var_85_14)
						arg_82_1:RecordAudio("323502020", var_85_14)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_323502", "323502020", "story_v_out_323502.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_323502", "323502020", "story_v_out_323502.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_15 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_15 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_15

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_15 and arg_82_1.time_ < var_85_5 + var_85_15 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play323502021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 323502021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play323502022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10162ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10162ui_story == nil then
				arg_86_1.var_.characterEffect10162ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10162ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10162ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10162ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10162ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.125

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

				local var_89_9 = arg_86_1:GetWordFromCfg(323502021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 5
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
	Play323502022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 323502022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play323502023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10162ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos10162ui_story = var_93_0.localPosition

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end
			end

			local var_93_3 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_3 then
				local var_93_4 = (arg_90_1.time_ - var_93_1) / var_93_3
				local var_93_5 = Vector3.New(0, 100, 0)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10162ui_story, var_93_5, var_93_4)

				local var_93_6 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_6.x, var_93_6.y, var_93_6.z)

				local var_93_7 = var_93_0.localEulerAngles

				var_93_7.z = 0
				var_93_7.x = 0
				var_93_0.localEulerAngles = var_93_7
			end

			if arg_90_1.time_ >= var_93_1 + var_93_3 and arg_90_1.time_ < var_93_1 + var_93_3 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, 100, 0)

				local var_93_8 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_8.x, var_93_8.y, var_93_8.z)

				local var_93_9 = var_93_0.localEulerAngles

				var_93_9.z = 0
				var_93_9.x = 0
				var_93_0.localEulerAngles = var_93_9

				local var_93_10 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_10 then
					var_93_10:EnableDynamicBone(true)
				end
			end

			local var_93_11 = 0.166666666666667
			local var_93_12 = 1

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				local var_93_13 = "play"
				local var_93_14 = "effect"

				arg_90_1:AudioAction(var_93_13, var_93_14, "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_93_15 = 0
			local var_93_16 = 1.2

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_17 = arg_90_1:GetWordFromCfg(323502022)
				local var_93_18 = arg_90_1:FormatText(var_93_17.content)

				arg_90_1.text_.text = var_93_18

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_19 = 48
				local var_93_20 = utf8.len(var_93_18)
				local var_93_21 = var_93_19 <= 0 and var_93_16 or var_93_16 * (var_93_20 / var_93_19)

				if var_93_21 > 0 and var_93_16 < var_93_21 then
					arg_90_1.talkMaxDuration = var_93_21

					if var_93_21 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_18
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_22 and arg_90_1.time_ < var_93_15 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
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
	Play323502023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 323502023
		arg_94_1.duration_ = 2.6

		local var_94_0 = {
			zh = 2.6,
			ja = 2.5
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play323502024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10162ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos10162ui_story = var_97_0.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_3 then
				local var_97_4 = (arg_94_1.time_ - var_97_1) / var_97_3
				local var_97_5 = Vector3.New(0, -1.08, -5.83)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10162ui_story, var_97_5, var_97_4)

				local var_97_6 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_6.x, var_97_6.y, var_97_6.z)

				local var_97_7 = var_97_0.localEulerAngles

				var_97_7.z = 0
				var_97_7.x = 0
				var_97_0.localEulerAngles = var_97_7
			end

			if arg_94_1.time_ >= var_97_1 + var_97_3 and arg_94_1.time_ < var_97_1 + var_97_3 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_97_8 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_8.x, var_97_8.y, var_97_8.z)

				local var_97_9 = var_97_0.localEulerAngles

				var_97_9.z = 0
				var_97_9.x = 0
				var_97_0.localEulerAngles = var_97_9

				local var_97_10 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_10 then
					var_97_10:EnableDynamicBone(true)
				end
			end

			local var_97_11 = arg_94_1.actors_["10162ui_story"]
			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect10162ui_story == nil then
				arg_94_1.var_.characterEffect10162ui_story = var_97_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_13 = 0.200000002980232

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 and not isNil(var_97_11) then
				local var_97_14 = (arg_94_1.time_ - var_97_12) / var_97_13

				if arg_94_1.var_.characterEffect10162ui_story and not isNil(var_97_11) then
					arg_94_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect10162ui_story then
				arg_94_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action29_1")
			end

			local var_97_16 = 0
			local var_97_17 = 0.175

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_18 = arg_94_1:FormatText(StoryNameCfg[1459].name)

				arg_94_1.leftNameTxt_.text = var_97_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_19 = arg_94_1:GetWordFromCfg(323502023)
				local var_97_20 = arg_94_1:FormatText(var_97_19.content)

				arg_94_1.text_.text = var_97_20

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_21 = 7
				local var_97_22 = utf8.len(var_97_20)
				local var_97_23 = var_97_21 <= 0 and var_97_17 or var_97_17 * (var_97_22 / var_97_21)

				if var_97_23 > 0 and var_97_17 < var_97_23 then
					arg_94_1.talkMaxDuration = var_97_23

					if var_97_23 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_20
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502023", "story_v_out_323502.awb") ~= 0 then
					local var_97_24 = manager.audio:GetVoiceLength("story_v_out_323502", "323502023", "story_v_out_323502.awb") / 1000

					if var_97_24 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_16
					end

					if var_97_19.prefab_name ~= "" and arg_94_1.actors_[var_97_19.prefab_name] ~= nil then
						local var_97_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_19.prefab_name].transform, "story_v_out_323502", "323502023", "story_v_out_323502.awb")

						arg_94_1:RecordAudio("323502023", var_97_25)
						arg_94_1:RecordAudio("323502023", var_97_25)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_323502", "323502023", "story_v_out_323502.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_323502", "323502023", "story_v_out_323502.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_26 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_26 and arg_94_1.time_ < var_97_16 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play323502024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 323502024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play323502025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10162ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10162ui_story == nil then
				arg_98_1.var_.characterEffect10162ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10162ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10162ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10162ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10162ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.325

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

				local var_101_9 = arg_98_1:GetWordFromCfg(323502024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 13
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
	Play323502025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 323502025
		arg_102_1.duration_ = 4.93

		local var_102_0 = {
			zh = 3.9,
			ja = 4.933
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play323502026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10162ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10162ui_story == nil then
				arg_102_1.var_.characterEffect10162ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10162ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10162ui_story then
				arg_102_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_105_4 = 0
			local var_105_5 = 0.625

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_6 = arg_102_1:FormatText(StoryNameCfg[1459].name)

				arg_102_1.leftNameTxt_.text = var_105_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:GetWordFromCfg(323502025)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 25
				local var_105_10 = utf8.len(var_105_8)
				local var_105_11 = var_105_9 <= 0 and var_105_5 or var_105_5 * (var_105_10 / var_105_9)

				if var_105_11 > 0 and var_105_5 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502025", "story_v_out_323502.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502025", "story_v_out_323502.awb") / 1000

					if var_105_12 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_4
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_323502", "323502025", "story_v_out_323502.awb")

						arg_102_1:RecordAudio("323502025", var_105_13)
						arg_102_1:RecordAudio("323502025", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_323502", "323502025", "story_v_out_323502.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_323502", "323502025", "story_v_out_323502.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_14 and arg_102_1.time_ < var_105_4 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play323502026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 323502026
		arg_106_1.duration_ = 7.5

		local var_106_0 = {
			zh = 3,
			ja = 7.5
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play323502027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.275

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[1459].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(323502026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 11
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502026", "story_v_out_323502.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_323502", "323502026", "story_v_out_323502.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_323502", "323502026", "story_v_out_323502.awb")

						arg_106_1:RecordAudio("323502026", var_109_9)
						arg_106_1:RecordAudio("323502026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_323502", "323502026", "story_v_out_323502.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_323502", "323502026", "story_v_out_323502.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play323502027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323502027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play323502028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10162ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10162ui_story == nil then
				arg_110_1.var_.characterEffect10162ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10162ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10162ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10162ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10162ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 1.15

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(323502027)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_10 = 46
				local var_113_11 = utf8.len(var_113_9)
				local var_113_12 = var_113_10 <= 0 and var_113_7 or var_113_7 * (var_113_11 / var_113_10)

				if var_113_12 > 0 and var_113_7 < var_113_12 then
					arg_110_1.talkMaxDuration = var_113_12

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_13 and arg_110_1.time_ < var_113_6 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play323502028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323502028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play323502029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.275

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(323502028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 11
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play323502029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 323502029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play323502030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.025

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

				local var_121_2 = arg_118_1:GetWordFromCfg(323502029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 41
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
	Play323502030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323502030
		arg_122_1.duration_ = 4.8

		local var_122_0 = {
			zh = 4.8,
			ja = 4.233
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
				arg_122_0:Play323502031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10162ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10162ui_story == nil then
				arg_122_1.var_.characterEffect10162ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect10162ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10162ui_story then
				arg_122_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action29_2")
			end

			local var_125_5 = 0
			local var_125_6 = 0.525

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_7 = arg_122_1:FormatText(StoryNameCfg[1459].name)

				arg_122_1.leftNameTxt_.text = var_125_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_8 = arg_122_1:GetWordFromCfg(323502030)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 21
				local var_125_11 = utf8.len(var_125_9)
				local var_125_12 = var_125_10 <= 0 and var_125_6 or var_125_6 * (var_125_11 / var_125_10)

				if var_125_12 > 0 and var_125_6 < var_125_12 then
					arg_122_1.talkMaxDuration = var_125_12

					if var_125_12 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_5
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502030", "story_v_out_323502.awb") ~= 0 then
					local var_125_13 = manager.audio:GetVoiceLength("story_v_out_323502", "323502030", "story_v_out_323502.awb") / 1000

					if var_125_13 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_5
					end

					if var_125_8.prefab_name ~= "" and arg_122_1.actors_[var_125_8.prefab_name] ~= nil then
						local var_125_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_8.prefab_name].transform, "story_v_out_323502", "323502030", "story_v_out_323502.awb")

						arg_122_1:RecordAudio("323502030", var_125_14)
						arg_122_1:RecordAudio("323502030", var_125_14)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_323502", "323502030", "story_v_out_323502.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_323502", "323502030", "story_v_out_323502.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_15 = math.max(var_125_6, arg_122_1.talkMaxDuration)

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_15 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_5) / var_125_15

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_5 + var_125_15 and arg_122_1.time_ < var_125_5 + var_125_15 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play323502031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323502031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play323502032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10162ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10162ui_story == nil then
				arg_126_1.var_.characterEffect10162ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect10162ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10162ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect10162ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10162ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.85

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

				local var_129_9 = arg_126_1:GetWordFromCfg(323502031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 34
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
	Play323502032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323502032
		arg_130_1.duration_ = 5.2

		local var_130_0 = {
			zh = 3,
			ja = 5.2
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
				arg_130_0:Play323502033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10162ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10162ui_story == nil then
				arg_130_1.var_.characterEffect10162ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect10162ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10162ui_story then
				arg_130_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_133_4 = 0
			local var_133_5 = 0.225

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_6 = arg_130_1:FormatText(StoryNameCfg[1459].name)

				arg_130_1.leftNameTxt_.text = var_133_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(323502032)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 9
				local var_133_10 = utf8.len(var_133_8)
				local var_133_11 = var_133_9 <= 0 and var_133_5 or var_133_5 * (var_133_10 / var_133_9)

				if var_133_11 > 0 and var_133_5 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502032", "story_v_out_323502.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502032", "story_v_out_323502.awb") / 1000

					if var_133_12 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_4
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_323502", "323502032", "story_v_out_323502.awb")

						arg_130_1:RecordAudio("323502032", var_133_13)
						arg_130_1:RecordAudio("323502032", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_323502", "323502032", "story_v_out_323502.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_323502", "323502032", "story_v_out_323502.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_14 and arg_130_1.time_ < var_133_4 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play323502033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323502033
		arg_134_1.duration_ = 10.87

		local var_134_0 = {
			zh = 5.7,
			ja = 10.866
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play323502034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.625

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[1459].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:GetWordFromCfg(323502033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 25
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502033", "story_v_out_323502.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_323502", "323502033", "story_v_out_323502.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_323502", "323502033", "story_v_out_323502.awb")

						arg_134_1:RecordAudio("323502033", var_137_9)
						arg_134_1:RecordAudio("323502033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_323502", "323502033", "story_v_out_323502.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_323502", "323502033", "story_v_out_323502.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play323502034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 323502034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play323502035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10162ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10162ui_story == nil then
				arg_138_1.var_.characterEffect10162ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect10162ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_138_1.var_.characterEffect10162ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10162ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_138_1.var_.characterEffect10162ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.575

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(323502034)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 23
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play323502035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 323502035
		arg_142_1.duration_ = 2

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play323502036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10162ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10162ui_story == nil then
				arg_142_1.var_.characterEffect10162ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect10162ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10162ui_story then
				arg_142_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_145_4 = 0

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_145_5 = 0
			local var_145_6 = 0.175

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_7 = arg_142_1:FormatText(StoryNameCfg[1459].name)

				arg_142_1.leftNameTxt_.text = var_145_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_8 = arg_142_1:GetWordFromCfg(323502035)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 7
				local var_145_11 = utf8.len(var_145_9)
				local var_145_12 = var_145_10 <= 0 and var_145_6 or var_145_6 * (var_145_11 / var_145_10)

				if var_145_12 > 0 and var_145_6 < var_145_12 then
					arg_142_1.talkMaxDuration = var_145_12

					if var_145_12 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502035", "story_v_out_323502.awb") ~= 0 then
					local var_145_13 = manager.audio:GetVoiceLength("story_v_out_323502", "323502035", "story_v_out_323502.awb") / 1000

					if var_145_13 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_5
					end

					if var_145_8.prefab_name ~= "" and arg_142_1.actors_[var_145_8.prefab_name] ~= nil then
						local var_145_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_8.prefab_name].transform, "story_v_out_323502", "323502035", "story_v_out_323502.awb")

						arg_142_1:RecordAudio("323502035", var_145_14)
						arg_142_1:RecordAudio("323502035", var_145_14)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_323502", "323502035", "story_v_out_323502.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_323502", "323502035", "story_v_out_323502.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_15 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_15 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_15

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_15 and arg_142_1.time_ < var_145_5 + var_145_15 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play323502036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 323502036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play323502037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10162ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos10162ui_story = var_149_0.localPosition

				local var_149_2 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_2 then
					var_149_2:EnableDynamicBone(false)
				end
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10162ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9

				local var_149_10 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_10 then
					var_149_10:EnableDynamicBone(true)
				end
			end

			local var_149_11 = arg_146_1.actors_["10162ui_story"]
			local var_149_12 = 0

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect10162ui_story == nil then
				arg_146_1.var_.characterEffect10162ui_story = var_149_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_13 = 0.200000002980232

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 and not isNil(var_149_11) then
				local var_149_14 = (arg_146_1.time_ - var_149_12) / var_149_13

				if arg_146_1.var_.characterEffect10162ui_story and not isNil(var_149_11) then
					local var_149_15 = Mathf.Lerp(0, 0.5, var_149_14)

					arg_146_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10162ui_story.fillRatio = var_149_15
				end
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect10162ui_story then
				local var_149_16 = 0.5

				arg_146_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10162ui_story.fillRatio = var_149_16
			end

			local var_149_17 = 0.3
			local var_149_18 = 1

			if var_149_17 < arg_146_1.time_ and arg_146_1.time_ <= var_149_17 + arg_149_0 then
				local var_149_19 = "play"
				local var_149_20 = "effect"

				arg_146_1:AudioAction(var_149_19, var_149_20, "se_story_148", "se_story_148_box02", "")
			end

			local var_149_21 = 0
			local var_149_22 = 1.2

			if var_149_21 < arg_146_1.time_ and arg_146_1.time_ <= var_149_21 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_23 = arg_146_1:GetWordFromCfg(323502036)
				local var_149_24 = arg_146_1:FormatText(var_149_23.content)

				arg_146_1.text_.text = var_149_24

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_25 = 48
				local var_149_26 = utf8.len(var_149_24)
				local var_149_27 = var_149_25 <= 0 and var_149_22 or var_149_22 * (var_149_26 / var_149_25)

				if var_149_27 > 0 and var_149_22 < var_149_27 then
					arg_146_1.talkMaxDuration = var_149_27

					if var_149_27 + var_149_21 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_27 + var_149_21
					end
				end

				arg_146_1.text_.text = var_149_24
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_28 = math.max(var_149_22, arg_146_1.talkMaxDuration)

			if var_149_21 <= arg_146_1.time_ and arg_146_1.time_ < var_149_21 + var_149_28 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_21) / var_149_28

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_21 + var_149_28 and arg_146_1.time_ < var_149_21 + var_149_28 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play323502037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 323502037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play323502038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.275

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(323502037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 51
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play323502038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 323502038
		arg_154_1.duration_ = 5.57

		local var_154_0 = {
			zh = 3.8,
			ja = 5.566
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play323502039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10162ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10162ui_story == nil then
				arg_154_1.var_.characterEffect10162ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect10162ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10162ui_story then
				arg_154_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_157_4 = 0
			local var_157_5 = 0.3

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_6 = arg_154_1:FormatText(StoryNameCfg[1459].name)

				arg_154_1.leftNameTxt_.text = var_157_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_7 = arg_154_1:GetWordFromCfg(323502038)
				local var_157_8 = arg_154_1:FormatText(var_157_7.content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 12
				local var_157_10 = utf8.len(var_157_8)
				local var_157_11 = var_157_9 <= 0 and var_157_5 or var_157_5 * (var_157_10 / var_157_9)

				if var_157_11 > 0 and var_157_5 < var_157_11 then
					arg_154_1.talkMaxDuration = var_157_11

					if var_157_11 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502038", "story_v_out_323502.awb") ~= 0 then
					local var_157_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502038", "story_v_out_323502.awb") / 1000

					if var_157_12 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_4
					end

					if var_157_7.prefab_name ~= "" and arg_154_1.actors_[var_157_7.prefab_name] ~= nil then
						local var_157_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_7.prefab_name].transform, "story_v_out_323502", "323502038", "story_v_out_323502.awb")

						arg_154_1:RecordAudio("323502038", var_157_13)
						arg_154_1:RecordAudio("323502038", var_157_13)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_323502", "323502038", "story_v_out_323502.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_323502", "323502038", "story_v_out_323502.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_14 and arg_154_1.time_ < var_157_4 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play323502039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 323502039
		arg_158_1.duration_ = 1.13

		local var_158_0 = {
			zh = 1,
			ja = 1.133
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play323502040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = "1069ui_story"

			if arg_158_1.actors_[var_161_0] == nil then
				local var_161_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_161_1) then
					local var_161_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_158_1.stage_.transform)

					var_161_2.name = var_161_0
					var_161_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_158_1.actors_[var_161_0] = var_161_2

					local var_161_3 = var_161_2:GetComponentInChildren(typeof(CharacterEffect))

					var_161_3.enabled = true

					local var_161_4 = GameObjectTools.GetOrAddComponent(var_161_2, typeof(DynamicBoneHelper))

					if var_161_4 then
						var_161_4:EnableDynamicBone(false)
					end

					arg_158_1:ShowWeapon(var_161_3.transform, false)

					arg_158_1.var_[var_161_0 .. "Animator"] = var_161_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_158_1.var_[var_161_0 .. "Animator"].applyRootMotion = true
					arg_158_1.var_[var_161_0 .. "LipSync"] = var_161_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_161_5 = arg_158_1.actors_["1069ui_story"]
			local var_161_6 = 0

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1069ui_story == nil then
				arg_158_1.var_.characterEffect1069ui_story = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_7 = 0.200000002980232

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_7 and not isNil(var_161_5) then
				local var_161_8 = (arg_158_1.time_ - var_161_6) / var_161_7

				if arg_158_1.var_.characterEffect1069ui_story and not isNil(var_161_5) then
					arg_158_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_6 + var_161_7 and arg_158_1.time_ < var_161_6 + var_161_7 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1069ui_story then
				arg_158_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_161_9 = arg_158_1.actors_["10162ui_story"]
			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect10162ui_story == nil then
				arg_158_1.var_.characterEffect10162ui_story = var_161_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_11 = 0.200000002980232

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_11 and not isNil(var_161_9) then
				local var_161_12 = (arg_158_1.time_ - var_161_10) / var_161_11

				if arg_158_1.var_.characterEffect10162ui_story and not isNil(var_161_9) then
					local var_161_13 = Mathf.Lerp(0, 0.5, var_161_12)

					arg_158_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10162ui_story.fillRatio = var_161_13
				end
			end

			if arg_158_1.time_ >= var_161_10 + var_161_11 and arg_158_1.time_ < var_161_10 + var_161_11 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect10162ui_story then
				local var_161_14 = 0.5

				arg_158_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10162ui_story.fillRatio = var_161_14
			end

			local var_161_15 = 0
			local var_161_16 = 0.1

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_17 = arg_158_1:FormatText(StoryNameCfg[1460].name)

				arg_158_1.leftNameTxt_.text = var_161_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_18 = arg_158_1:GetWordFromCfg(323502039)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_20 = 4
				local var_161_21 = utf8.len(var_161_19)
				local var_161_22 = var_161_20 <= 0 and var_161_16 or var_161_16 * (var_161_21 / var_161_20)

				if var_161_22 > 0 and var_161_16 < var_161_22 then
					arg_158_1.talkMaxDuration = var_161_22

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502039", "story_v_out_323502.awb") ~= 0 then
					local var_161_23 = manager.audio:GetVoiceLength("story_v_out_323502", "323502039", "story_v_out_323502.awb") / 1000

					if var_161_23 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_23 + var_161_15
					end

					if var_161_18.prefab_name ~= "" and arg_158_1.actors_[var_161_18.prefab_name] ~= nil then
						local var_161_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_18.prefab_name].transform, "story_v_out_323502", "323502039", "story_v_out_323502.awb")

						arg_158_1:RecordAudio("323502039", var_161_24)
						arg_158_1:RecordAudio("323502039", var_161_24)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_323502", "323502039", "story_v_out_323502.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_323502", "323502039", "story_v_out_323502.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_25 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_15) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_15 + var_161_25 and arg_158_1.time_ < var_161_15 + var_161_25 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play323502040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 323502040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play323502041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1069ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1069ui_story == nil then
				arg_162_1.var_.characterEffect1069ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1069ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1069ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1069ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1069ui_story.fillRatio = var_165_5
			end

			local var_165_6 = 0
			local var_165_7 = 0.8

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_8 = arg_162_1:GetWordFromCfg(323502040)
				local var_165_9 = arg_162_1:FormatText(var_165_8.content)

				arg_162_1.text_.text = var_165_9

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_10 = 32
				local var_165_11 = utf8.len(var_165_9)
				local var_165_12 = var_165_10 <= 0 and var_165_7 or var_165_7 * (var_165_11 / var_165_10)

				if var_165_12 > 0 and var_165_7 < var_165_12 then
					arg_162_1.talkMaxDuration = var_165_12

					if var_165_12 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_9
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_13 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_13 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_13

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_13 and arg_162_1.time_ < var_165_6 + var_165_13 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play323502041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 323502041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play323502042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.275

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(323502041)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 11
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_8 and arg_166_1.time_ < var_169_0 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play323502042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 323502042
		arg_170_1.duration_ = 9.1

		local var_170_0 = {
			zh = 4.666,
			ja = 9.1
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
				arg_170_0:Play323502043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10162ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos10162ui_story = var_173_0.localPosition

				local var_173_2 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(false)
				end
			end

			local var_173_3 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_3 then
				local var_173_4 = (arg_170_1.time_ - var_173_1) / var_173_3
				local var_173_5 = Vector3.New(0, -1.08, -5.83)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10162ui_story, var_173_5, var_173_4)

				local var_173_6 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_6.x, var_173_6.y, var_173_6.z)

				local var_173_7 = var_173_0.localEulerAngles

				var_173_7.z = 0
				var_173_7.x = 0
				var_173_0.localEulerAngles = var_173_7
			end

			if arg_170_1.time_ >= var_173_1 + var_173_3 and arg_170_1.time_ < var_173_1 + var_173_3 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_173_8 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_8.x, var_173_8.y, var_173_8.z)

				local var_173_9 = var_173_0.localEulerAngles

				var_173_9.z = 0
				var_173_9.x = 0
				var_173_0.localEulerAngles = var_173_9

				local var_173_10 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_10 then
					var_173_10:EnableDynamicBone(true)
				end
			end

			local var_173_11 = arg_170_1.actors_["10162ui_story"]
			local var_173_12 = 0

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 and not isNil(var_173_11) and arg_170_1.var_.characterEffect10162ui_story == nil then
				arg_170_1.var_.characterEffect10162ui_story = var_173_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_13 = 0.200000002980232

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_13 and not isNil(var_173_11) then
				local var_173_14 = (arg_170_1.time_ - var_173_12) / var_173_13

				if arg_170_1.var_.characterEffect10162ui_story and not isNil(var_173_11) then
					arg_170_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_12 + var_173_13 and arg_170_1.time_ < var_173_12 + var_173_13 + arg_173_0 and not isNil(var_173_11) and arg_170_1.var_.characterEffect10162ui_story then
				arg_170_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_173_15 = 0

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41516")
			end

			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_173_17 = 0
			local var_173_18 = 0.55

			if var_173_17 < arg_170_1.time_ and arg_170_1.time_ <= var_173_17 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_19 = arg_170_1:FormatText(StoryNameCfg[1459].name)

				arg_170_1.leftNameTxt_.text = var_173_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_20 = arg_170_1:GetWordFromCfg(323502042)
				local var_173_21 = arg_170_1:FormatText(var_173_20.content)

				arg_170_1.text_.text = var_173_21

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_22 = 22
				local var_173_23 = utf8.len(var_173_21)
				local var_173_24 = var_173_22 <= 0 and var_173_18 or var_173_18 * (var_173_23 / var_173_22)

				if var_173_24 > 0 and var_173_18 < var_173_24 then
					arg_170_1.talkMaxDuration = var_173_24

					if var_173_24 + var_173_17 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_24 + var_173_17
					end
				end

				arg_170_1.text_.text = var_173_21
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502042", "story_v_out_323502.awb") ~= 0 then
					local var_173_25 = manager.audio:GetVoiceLength("story_v_out_323502", "323502042", "story_v_out_323502.awb") / 1000

					if var_173_25 + var_173_17 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_25 + var_173_17
					end

					if var_173_20.prefab_name ~= "" and arg_170_1.actors_[var_173_20.prefab_name] ~= nil then
						local var_173_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_20.prefab_name].transform, "story_v_out_323502", "323502042", "story_v_out_323502.awb")

						arg_170_1:RecordAudio("323502042", var_173_26)
						arg_170_1:RecordAudio("323502042", var_173_26)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_323502", "323502042", "story_v_out_323502.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_323502", "323502042", "story_v_out_323502.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_27 = math.max(var_173_18, arg_170_1.talkMaxDuration)

			if var_173_17 <= arg_170_1.time_ and arg_170_1.time_ < var_173_17 + var_173_27 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_17) / var_173_27

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_17 + var_173_27 and arg_170_1.time_ < var_173_17 + var_173_27 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play323502043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 323502043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play323502044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10162ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10162ui_story == nil then
				arg_174_1.var_.characterEffect10162ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect10162ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10162ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10162ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10162ui_story.fillRatio = var_177_5
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

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(323502043)
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
	Play323502044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 323502044
		arg_178_1.duration_ = 5.1

		local var_178_0 = {
			zh = 5.1,
			ja = 4.733
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
			arg_178_1.auto_ = false
		end

		function arg_178_1.playNext_(arg_180_0)
			arg_178_1.onStoryFinished_()
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10162ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect10162ui_story == nil then
				arg_178_1.var_.characterEffect10162ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect10162ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect10162ui_story then
				arg_178_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_181_4 = 0
			local var_181_5 = 0.55

			if var_181_4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_6 = arg_178_1:FormatText(StoryNameCfg[1459].name)

				arg_178_1.leftNameTxt_.text = var_181_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_7 = arg_178_1:GetWordFromCfg(323502044)
				local var_181_8 = arg_178_1:FormatText(var_181_7.content)

				arg_178_1.text_.text = var_181_8

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 22
				local var_181_10 = utf8.len(var_181_8)
				local var_181_11 = var_181_9 <= 0 and var_181_5 or var_181_5 * (var_181_10 / var_181_9)

				if var_181_11 > 0 and var_181_5 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_8
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323502", "323502044", "story_v_out_323502.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_323502", "323502044", "story_v_out_323502.awb") / 1000

					if var_181_12 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_4
					end

					if var_181_7.prefab_name ~= "" and arg_178_1.actors_[var_181_7.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_7.prefab_name].transform, "story_v_out_323502", "323502044", "story_v_out_323502.awb")

						arg_178_1:RecordAudio("323502044", var_181_13)
						arg_178_1:RecordAudio("323502044", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_323502", "323502044", "story_v_out_323502.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_323502", "323502044", "story_v_out_323502.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_14 and arg_178_1.time_ < var_181_4 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21f"
	},
	voices = {
		"story_v_out_323502.awb"
	}
}
