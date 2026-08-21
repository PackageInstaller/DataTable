return {
	Play424011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST28a"

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
				local var_4_5 = arg_1_1.bgs_.ST28a

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
					if iter_4_0 ~= "ST28a" then
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
				local var_4_26 = arg_1_1.var_.effect46wuqi1
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_in"), var_4_28)
					var_4_26.name = "46wuqi1"
					arg_1_1.var_.effect46wuqi1 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0.18, -5.74)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = 0.133333333333333
			local var_4_30 = 1

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "effect"

				arg_1_1:AudioAction(var_4_31, var_4_32, "se_story_side_1095", "se_story_side_1095_amb_fountain_night", "")
			end

			local var_4_33 = 0
			local var_4_34 = 0.3

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 0.4
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily")

				if var_4_44 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_44 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_44

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_44
						arg_1_1.bgmTxt2_.text = var_4_44
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

			local var_4_45 = 0.133333333333333
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_146", "se_story_146_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 1.275

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_52 = arg_1_1:GetWordFromCfg(424011001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_54 = 51
				local var_4_55 = utf8.len(var_4_53)
				local var_4_56 = var_4_54 <= 0 and var_4_50 or var_4_50 * (var_4_55 / var_4_54)

				if var_4_56 > 0 and var_4_50 < var_4_56 then
					arg_1_1.talkMaxDuration = var_4_56
					var_4_49 = var_4_49 + 0.3

					if var_4_56 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_53
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_49 + 0.3
			local var_4_58 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424011002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.4
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_140", "se_story_140_foley_situp", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.2

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(424011002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 48
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_5 or var_12_5 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_5 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_11 and arg_9_1.time_ < var_12_4 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play424011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.3

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

				local var_16_2 = arg_13_1:GetWordFromCfg(424011003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 52
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
	Play424011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424011004
		arg_17_1.duration_ = 11.7

		local var_17_0 = {
			zh = 5.8,
			ja = 11.7
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.5

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[1385].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(424011004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011004", "story_v_out_424011.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011004", "story_v_out_424011.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_424011", "424011004", "story_v_out_424011.awb")

						arg_17_1:RecordAudio("424011004", var_20_9)
						arg_17_1:RecordAudio("424011004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424011", "424011004", "story_v_out_424011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424011", "424011004", "story_v_out_424011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424011005
		arg_21_1.duration_ = 11.27

		local var_21_0 = {
			zh = 11.266,
			ja = 10.933
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
				arg_21_0:Play424011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1385].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(424011005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011005", "story_v_out_424011.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011005", "story_v_out_424011.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_424011", "424011005", "story_v_out_424011.awb")

						arg_21_1:RecordAudio("424011005", var_24_9)
						arg_21_1:RecordAudio("424011005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424011", "424011005", "story_v_out_424011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424011", "424011005", "story_v_out_424011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play424011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424011006
		arg_25_1.duration_ = 12.2

		local var_25_0 = {
			zh = 8.366,
			ja = 12.2
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
				arg_25_0:Play424011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.775

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1385].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(424011006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011006", "story_v_out_424011.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011006", "story_v_out_424011.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_424011", "424011006", "story_v_out_424011.awb")

						arg_25_1:RecordAudio("424011006", var_28_9)
						arg_25_1:RecordAudio("424011006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_424011", "424011006", "story_v_out_424011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_424011", "424011006", "story_v_out_424011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play424011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.8

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(424011007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 32
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play424011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424011008
		arg_33_1.duration_ = 3.63

		local var_33_0 = {
			zh = 1.366,
			ja = 3.633
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
				arg_33_0:Play424011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_2 = "play"
				local var_36_3 = "effect"

				arg_33_1:AudioAction(var_36_2, var_36_3, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_36_4 = 0
			local var_36_5 = 0.1

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_6 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1194")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_7 = arg_33_1:GetWordFromCfg(424011008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 4
				local var_36_10 = utf8.len(var_36_8)
				local var_36_11 = var_36_9 <= 0 and var_36_5 or var_36_5 * (var_36_10 / var_36_9)

				if var_36_11 > 0 and var_36_5 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011008", "story_v_out_424011.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_424011", "424011008", "story_v_out_424011.awb") / 1000

					if var_36_12 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_4
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_424011", "424011008", "story_v_out_424011.awb")

						arg_33_1:RecordAudio("424011008", var_36_13)
						arg_33_1:RecordAudio("424011008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_424011", "424011008", "story_v_out_424011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_424011", "424011008", "story_v_out_424011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_14 and arg_33_1.time_ < var_36_4 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play424011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424011009
		arg_37_1.duration_ = 7.5

		local var_37_0 = {
			zh = 7.5,
			ja = 7.3
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
				arg_37_0:Play424011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.4

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1385].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(424011009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 16
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011009", "story_v_out_424011.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011009", "story_v_out_424011.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_424011", "424011009", "story_v_out_424011.awb")

						arg_37_1:RecordAudio("424011009", var_40_9)
						arg_37_1:RecordAudio("424011009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_424011", "424011009", "story_v_out_424011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_424011", "424011009", "story_v_out_424011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play424011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play424011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.175

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(424011010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 47
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play424011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424011011
		arg_45_1.duration_ = 8.51

		local var_45_0 = {
			zh = 8.508,
			ja = 7.641
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
				arg_45_0:Play424011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "SS2401"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_2 = 2

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_3 = manager.ui.mainCamera.transform.localPosition
				local var_48_4 = Vector3.New(0, 0, 10) + Vector3.New(var_48_3.x, var_48_3.y, 0)
				local var_48_5 = arg_45_1.bgs_.SS2401

				var_48_5.transform.localPosition = var_48_4
				var_48_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_6 = var_48_5:GetComponent("SpriteRenderer")

				if var_48_6 and var_48_6.sprite then
					local var_48_7 = (var_48_5.transform.localPosition - var_48_3).z
					local var_48_8 = manager.ui.mainCameraCom_
					local var_48_9 = 2 * var_48_7 * Mathf.Tan(var_48_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_10 = var_48_9 * var_48_8.aspect
					local var_48_11 = var_48_6.sprite.bounds.size.x
					local var_48_12 = var_48_6.sprite.bounds.size.y
					local var_48_13 = var_48_10 / var_48_11
					local var_48_14 = var_48_9 / var_48_12
					local var_48_15 = var_48_14 < var_48_13 and var_48_13 or var_48_14

					var_48_5.transform.localScale = Vector3.New(var_48_15, var_48_15, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "SS2401" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_16 = 4

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_17 = 0.3

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_18 = 0

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_19 = 2

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_18) / var_48_19
				local var_48_21 = Color.New(0, 0, 0)

				var_48_21.a = Mathf.Lerp(0, 1, var_48_20)
				arg_45_1.mask_.color = var_48_21
			end

			if arg_45_1.time_ >= var_48_18 + var_48_19 and arg_45_1.time_ < var_48_18 + var_48_19 + arg_48_0 then
				local var_48_22 = Color.New(0, 0, 0)

				var_48_22.a = 1
				arg_45_1.mask_.color = var_48_22
			end

			local var_48_23 = 2

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_24 = 2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24
				local var_48_26 = Color.New(0, 0, 0)

				var_48_26.a = Mathf.Lerp(1, 0, var_48_25)
				arg_45_1.mask_.color = var_48_26
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 then
				local var_48_27 = Color.New(0, 0, 0)
				local var_48_28 = 0

				arg_45_1.mask_.enabled = false
				var_48_27.a = var_48_28
				arg_45_1.mask_.color = var_48_27
			end

			local var_48_29 = arg_45_1.bgs_.SS2401.transform
			local var_48_30 = 2

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.var_.moveOldPosSS2401 = var_48_29.localPosition
			end

			local var_48_31 = 2.1

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_31 then
				local var_48_32 = (arg_45_1.time_ - var_48_30) / var_48_31
				local var_48_33 = Vector3.New(0, 1, 10)

				var_48_29.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPosSS2401, var_48_33, var_48_32)
			end

			if arg_45_1.time_ >= var_48_30 + var_48_31 and arg_45_1.time_ < var_48_30 + var_48_31 + arg_48_0 then
				var_48_29.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_34 = 3.675
			local var_48_35 = 0.325

			if var_48_34 < arg_45_1.time_ and arg_45_1.time_ <= var_48_34 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_36 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_36:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_37 = arg_45_1:FormatText(StoryNameCfg[1386].name)

				arg_45_1.leftNameTxt_.text = var_48_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_38 = arg_45_1:GetWordFromCfg(424011011)
				local var_48_39 = arg_45_1:FormatText(var_48_38.content)

				arg_45_1.text_.text = var_48_39

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_40 = 13
				local var_48_41 = utf8.len(var_48_39)
				local var_48_42 = var_48_40 <= 0 and var_48_35 or var_48_35 * (var_48_41 / var_48_40)

				if var_48_42 > 0 and var_48_35 < var_48_42 then
					arg_45_1.talkMaxDuration = var_48_42
					var_48_34 = var_48_34 + 0.3

					if var_48_42 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_42 + var_48_34
					end
				end

				arg_45_1.text_.text = var_48_39
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011011", "story_v_out_424011.awb") ~= 0 then
					local var_48_43 = manager.audio:GetVoiceLength("story_v_out_424011", "424011011", "story_v_out_424011.awb") / 1000

					if var_48_43 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_43 + var_48_34
					end

					if var_48_38.prefab_name ~= "" and arg_45_1.actors_[var_48_38.prefab_name] ~= nil then
						local var_48_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_38.prefab_name].transform, "story_v_out_424011", "424011011", "story_v_out_424011.awb")

						arg_45_1:RecordAudio("424011011", var_48_44)
						arg_45_1:RecordAudio("424011011", var_48_44)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424011", "424011011", "story_v_out_424011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424011", "424011011", "story_v_out_424011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_45 = var_48_34 + 0.3
			local var_48_46 = math.max(var_48_35, arg_45_1.talkMaxDuration)

			if var_48_45 <= arg_45_1.time_ and arg_45_1.time_ < var_48_45 + var_48_46 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_45) / var_48_46

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_45 + var_48_46 and arg_45_1.time_ < var_48_45 + var_48_46 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.1,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play424011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 424011012
		arg_51_1.duration_ = 10.77

		local var_51_0 = {
			zh = 7.5,
			ja = 10.766
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
				arg_51_0:Play424011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.525

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[1385].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(424011012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 21
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011012", "story_v_out_424011.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011012", "story_v_out_424011.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_424011", "424011012", "story_v_out_424011.awb")

						arg_51_1:RecordAudio("424011012", var_54_9)
						arg_51_1:RecordAudio("424011012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_424011", "424011012", "story_v_out_424011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_424011", "424011012", "story_v_out_424011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play424011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 424011013
		arg_55_1.duration_ = 1

		local var_55_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_55_0:Play424011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.05

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[1386].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(424011013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011013", "story_v_out_424011.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011013", "story_v_out_424011.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_424011", "424011013", "story_v_out_424011.awb")

						arg_55_1:RecordAudio("424011013", var_58_9)
						arg_55_1:RecordAudio("424011013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_424011", "424011013", "story_v_out_424011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_424011", "424011013", "story_v_out_424011.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play424011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 424011014
		arg_59_1.duration_ = 12.63

		local var_59_0 = {
			zh = 12.633,
			ja = 10.733
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
				arg_59_0:Play424011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.575

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[1385].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(424011014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011014", "story_v_out_424011.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011014", "story_v_out_424011.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_424011", "424011014", "story_v_out_424011.awb")

						arg_59_1:RecordAudio("424011014", var_62_9)
						arg_59_1:RecordAudio("424011014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_424011", "424011014", "story_v_out_424011.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_424011", "424011014", "story_v_out_424011.awb")
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
	Play424011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 424011015
		arg_63_1.duration_ = 10.87

		local var_63_0 = {
			zh = 4.766,
			ja = 10.866
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
				arg_63_0:Play424011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.325

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[1385].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(424011015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011015", "story_v_out_424011.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011015", "story_v_out_424011.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_424011", "424011015", "story_v_out_424011.awb")

						arg_63_1:RecordAudio("424011015", var_66_9)
						arg_63_1:RecordAudio("424011015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_424011", "424011015", "story_v_out_424011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_424011", "424011015", "story_v_out_424011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play424011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 424011016
		arg_67_1.duration_ = 1.63

		local var_67_0 = {
			zh = 1.466,
			ja = 1.633
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
				arg_67_0:Play424011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.2

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[1386].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(424011016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 8
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011016", "story_v_out_424011.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011016", "story_v_out_424011.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_424011", "424011016", "story_v_out_424011.awb")

						arg_67_1:RecordAudio("424011016", var_70_9)
						arg_67_1:RecordAudio("424011016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_424011", "424011016", "story_v_out_424011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_424011", "424011016", "story_v_out_424011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play424011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 424011017
		arg_71_1.duration_ = 6

		local var_71_0 = {
			zh = 3.766,
			ja = 6
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
				arg_71_0:Play424011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.125

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[1385].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(424011017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 5
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011017", "story_v_out_424011.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011017", "story_v_out_424011.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_424011", "424011017", "story_v_out_424011.awb")

						arg_71_1:RecordAudio("424011017", var_74_9)
						arg_71_1:RecordAudio("424011017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_424011", "424011017", "story_v_out_424011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_424011", "424011017", "story_v_out_424011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play424011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 424011018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play424011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.875

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(424011018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 35
				local var_78_5 = utf8.len(var_78_3)
				local var_78_6 = var_78_4 <= 0 and var_78_1 or var_78_1 * (var_78_5 / var_78_4)

				if var_78_6 > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_7 and arg_75_1.time_ < var_78_0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play424011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 424011019
		arg_79_1.duration_ = 12.3

		local var_79_0 = {
			zh = 12.3,
			ja = 11.166
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
				arg_79_0:Play424011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.775

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[1385].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(424011019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 31
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011019", "story_v_out_424011.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011019", "story_v_out_424011.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_424011", "424011019", "story_v_out_424011.awb")

						arg_79_1:RecordAudio("424011019", var_82_9)
						arg_79_1:RecordAudio("424011019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_424011", "424011019", "story_v_out_424011.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_424011", "424011019", "story_v_out_424011.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play424011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 424011020
		arg_83_1.duration_ = 15.33

		local var_83_0 = {
			zh = 10.8,
			ja = 15.333
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
				arg_83_0:Play424011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.55

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[1385].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(424011020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 22
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011020", "story_v_out_424011.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011020", "story_v_out_424011.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_424011", "424011020", "story_v_out_424011.awb")

						arg_83_1:RecordAudio("424011020", var_86_9)
						arg_83_1:RecordAudio("424011020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_424011", "424011020", "story_v_out_424011.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_424011", "424011020", "story_v_out_424011.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play424011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 424011021
		arg_87_1.duration_ = 9.7

		local var_87_0 = {
			zh = 6.3,
			ja = 9.7
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play424011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.375

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[1385].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(424011021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 15
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011021", "story_v_out_424011.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011021", "story_v_out_424011.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_424011", "424011021", "story_v_out_424011.awb")

						arg_87_1:RecordAudio("424011021", var_90_9)
						arg_87_1:RecordAudio("424011021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_424011", "424011021", "story_v_out_424011.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_424011", "424011021", "story_v_out_424011.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play424011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 424011022
		arg_91_1.duration_ = 3.23

		local var_91_0 = {
			zh = 1.233,
			ja = 3.233
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play424011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.1

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[1386].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(424011022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011022", "story_v_out_424011.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011022", "story_v_out_424011.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_424011", "424011022", "story_v_out_424011.awb")

						arg_91_1:RecordAudio("424011022", var_94_9)
						arg_91_1:RecordAudio("424011022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_424011", "424011022", "story_v_out_424011.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_424011", "424011022", "story_v_out_424011.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play424011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 424011023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play424011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.075

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(424011023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 43
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play424011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 424011024
		arg_99_1.duration_ = 4.87

		local var_99_0 = {
			zh = 4.866,
			ja = 2.066
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play424011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.15

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1385].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(424011024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 6
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011024", "story_v_out_424011.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011024", "story_v_out_424011.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_424011", "424011024", "story_v_out_424011.awb")

						arg_99_1:RecordAudio("424011024", var_102_9)
						arg_99_1:RecordAudio("424011024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_424011", "424011024", "story_v_out_424011.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_424011", "424011024", "story_v_out_424011.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play424011025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424011025
		arg_103_1.duration_ = 6.64

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play424011026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.8
			local var_106_1 = 1

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_2 = "play"
				local var_106_3 = "effect"

				arg_103_1:AudioAction(var_106_2, var_106_3, "se_story_143", "se_story_143_organic01", "")
			end

			local var_106_4 = "SS2401a"

			if arg_103_1.bgs_[var_106_4] == nil then
				local var_106_5 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_106_4)
				var_106_5.name = var_106_4
				var_106_5.transform.parent = arg_103_1.stage_.transform
				var_106_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_[var_106_4] = var_106_5
			end

			local var_106_6 = 0.8

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				local var_106_7 = manager.ui.mainCamera.transform.localPosition
				local var_106_8 = Vector3.New(0, 0, 10) + Vector3.New(var_106_7.x, var_106_7.y, 0)
				local var_106_9 = arg_103_1.bgs_.SS2401a

				var_106_9.transform.localPosition = var_106_8
				var_106_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_10 = var_106_9:GetComponent("SpriteRenderer")

				if var_106_10 and var_106_10.sprite then
					local var_106_11 = (var_106_9.transform.localPosition - var_106_7).z
					local var_106_12 = manager.ui.mainCameraCom_
					local var_106_13 = 2 * var_106_11 * Mathf.Tan(var_106_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_14 = var_106_13 * var_106_12.aspect
					local var_106_15 = var_106_10.sprite.bounds.size.x
					local var_106_16 = var_106_10.sprite.bounds.size.y
					local var_106_17 = var_106_14 / var_106_15
					local var_106_18 = var_106_13 / var_106_16
					local var_106_19 = var_106_18 < var_106_17 and var_106_17 or var_106_18

					var_106_9.transform.localScale = Vector3.New(var_106_19, var_106_19, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "SS2401a" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_20 = 0

			if var_106_20 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_21 = 0.8

			if var_106_20 <= arg_103_1.time_ and arg_103_1.time_ < var_106_20 + var_106_21 then
				local var_106_22 = (arg_103_1.time_ - var_106_20) / var_106_21
				local var_106_23 = Color.New(0, 0, 0)

				var_106_23.a = Mathf.Lerp(0, 1, var_106_22)
				arg_103_1.mask_.color = var_106_23
			end

			if arg_103_1.time_ >= var_106_20 + var_106_21 and arg_103_1.time_ < var_106_20 + var_106_21 + arg_106_0 then
				local var_106_24 = Color.New(0, 0, 0)

				var_106_24.a = 1
				arg_103_1.mask_.color = var_106_24
			end

			local var_106_25 = 0.8

			if var_106_25 < arg_103_1.time_ and arg_103_1.time_ <= var_106_25 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_26 = 0.8

			if var_106_25 <= arg_103_1.time_ and arg_103_1.time_ < var_106_25 + var_106_26 then
				local var_106_27 = (arg_103_1.time_ - var_106_25) / var_106_26
				local var_106_28 = Color.New(0, 0, 0)

				var_106_28.a = Mathf.Lerp(1, 0, var_106_27)
				arg_103_1.mask_.color = var_106_28
			end

			if arg_103_1.time_ >= var_106_25 + var_106_26 and arg_103_1.time_ < var_106_25 + var_106_26 + arg_106_0 then
				local var_106_29 = Color.New(0, 0, 0)
				local var_106_30 = 0

				arg_103_1.mask_.enabled = false
				var_106_29.a = var_106_30
				arg_103_1.mask_.color = var_106_29
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_31 = 1.64166666666667
			local var_106_32 = 1.025

			if var_106_31 < arg_103_1.time_ and arg_103_1.time_ <= var_106_31 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_33 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_33:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_34 = arg_103_1:GetWordFromCfg(424011025)
				local var_106_35 = arg_103_1:FormatText(var_106_34.content)

				arg_103_1.text_.text = var_106_35

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_36 = 41
				local var_106_37 = utf8.len(var_106_35)
				local var_106_38 = var_106_36 <= 0 and var_106_32 or var_106_32 * (var_106_37 / var_106_36)

				if var_106_38 > 0 and var_106_32 < var_106_38 then
					arg_103_1.talkMaxDuration = var_106_38
					var_106_31 = var_106_31 + 0.3

					if var_106_38 + var_106_31 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_38 + var_106_31
					end
				end

				arg_103_1.text_.text = var_106_35
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_39 = var_106_31 + 0.3
			local var_106_40 = math.max(var_106_32, arg_103_1.talkMaxDuration)

			if var_106_39 <= arg_103_1.time_ and arg_103_1.time_ < var_106_39 + var_106_40 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_39) / var_106_40

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_39 + var_106_40 and arg_103_1.time_ < var_106_39 + var_106_40 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play424011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 424011026
		arg_109_1.duration_ = 1.7

		local var_109_0 = {
			zh = 1.7,
			ja = 1.3
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
				arg_109_0:Play424011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.175

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[1386].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(424011026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 7
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011026", "story_v_out_424011.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011026", "story_v_out_424011.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_424011", "424011026", "story_v_out_424011.awb")

						arg_109_1:RecordAudio("424011026", var_112_9)
						arg_109_1:RecordAudio("424011026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_424011", "424011026", "story_v_out_424011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_424011", "424011026", "story_v_out_424011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play424011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 424011027
		arg_113_1.duration_ = 8.37

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play424011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 3.26666666666667

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_1 = 0.3

			if arg_113_1.time_ >= var_116_0 + var_116_1 and arg_113_1.time_ < var_116_0 + var_116_1 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_2 = "SS2401b"

			if arg_113_1.bgs_[var_116_2] == nil then
				local var_116_3 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_2)
				var_116_3.name = var_116_2
				var_116_3.transform.parent = arg_113_1.stage_.transform
				var_116_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_2] = var_116_3
			end

			local var_116_4 = arg_113_1.bgs_.SS2401b.transform
			local var_116_5 = 1.36666666666667

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.var_.moveOldPosSS2401b = var_116_4.localPosition
			end

			local var_116_6 = 2

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6
				local var_116_8 = Vector3.New(0, 1, 9.5)

				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPosSS2401b, var_116_8, var_116_7)
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_116_9 = manager.ui.mainCamera.transform
			local var_116_10 = 1.36666666666667

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				local var_116_11 = arg_113_1.var_.effect46hailahudiechudengchang1
				local var_116_12
				local var_116_13 = var_116_9

				if not var_116_11 then
					var_116_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blueglow"), var_116_13)
					var_116_11.name = "46hailahudiechudengchang1"
					arg_113_1.var_.effect46hailahudiechudengchang1 = var_116_11
				else
					var_116_11.transform:SetParent(var_116_13)
				end

				var_116_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_14 = 1.7777777777777777
				local var_116_15 = Screen.width / Screen.height
				local var_116_16 = var_116_15 / var_116_14
				local var_116_17 = Mathf.Max(var_116_14 / var_116_15, 1)

				var_116_11.transform.localScale = Vector3.New(var_116_11.transform.localScale.x * var_116_16, var_116_11.transform.localScale.y * var_116_17, var_116_11.transform.localScale.z)
			end

			local var_116_18 = 1.36666666666667
			local var_116_19 = 1

			if var_116_18 < arg_113_1.time_ and arg_113_1.time_ <= var_116_18 + arg_116_0 then
				local var_116_20 = "play"
				local var_116_21 = "effect"

				arg_113_1:AudioAction(var_116_20, var_116_21, "se_story_146", "se_story_146_umbrella01", "")
			end

			local var_116_22 = 1.36666666666667

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				local var_116_23 = manager.ui.mainCamera.transform.localPosition
				local var_116_24 = Vector3.New(0, 0, 10) + Vector3.New(var_116_23.x, var_116_23.y, 0)
				local var_116_25 = arg_113_1.bgs_.SS2401b

				var_116_25.transform.localPosition = var_116_24
				var_116_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_26 = var_116_25:GetComponent("SpriteRenderer")

				if var_116_26 and var_116_26.sprite then
					local var_116_27 = (var_116_25.transform.localPosition - var_116_23).z
					local var_116_28 = manager.ui.mainCameraCom_
					local var_116_29 = 2 * var_116_27 * Mathf.Tan(var_116_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_30 = var_116_29 * var_116_28.aspect
					local var_116_31 = var_116_26.sprite.bounds.size.x
					local var_116_32 = var_116_26.sprite.bounds.size.y
					local var_116_33 = var_116_30 / var_116_31
					local var_116_34 = var_116_29 / var_116_32
					local var_116_35 = var_116_34 < var_116_33 and var_116_33 or var_116_34

					var_116_25.transform.localScale = Vector3.New(var_116_35, var_116_35, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "SS2401b" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_36 = manager.ui.mainCamera.transform
			local var_116_37 = 0

			if var_116_37 < arg_113_1.time_ and arg_113_1.time_ <= var_116_37 + arg_116_0 then
				local var_116_38 = arg_113_1.var_.effecthudiexuanguang
				local var_116_39
				local var_116_40 = var_116_36

				if not var_116_38 then
					var_116_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_116_40)
					var_116_38.name = "hudiexuanguang"
					arg_113_1.var_.effecthudiexuanguang = var_116_38
				else
					var_116_38.transform:SetParent(var_116_40)
				end

				var_116_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_116_41 = manager.ui.mainCamera.transform
			local var_116_42 = 1.5

			if var_116_42 < arg_113_1.time_ and arg_113_1.time_ <= var_116_42 + arg_116_0 then
				local var_116_43 = arg_113_1.var_.effecthudiexuanguang

				if var_116_43 then
					Object.Destroy(var_116_43)

					arg_113_1.var_.effecthudiexuanguang = nil
				end
			end

			local var_116_44 = manager.ui.mainCamera.transform
			local var_116_45 = 1.5

			if var_116_45 < arg_113_1.time_ and arg_113_1.time_ <= var_116_45 + arg_116_0 then
				local var_116_46 = arg_113_1.var_.effecthudiexuanguang2
				local var_116_47
				local var_116_48 = var_116_44

				if not var_116_46 then
					var_116_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_116_48)
					var_116_46.name = "hudiexuanguang2"
					arg_113_1.var_.effecthudiexuanguang2 = var_116_46
				else
					var_116_46.transform:SetParent(var_116_48)
				end

				var_116_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_46.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_116_49 = manager.ui.mainCamera.transform
			local var_116_50 = 2

			if var_116_50 < arg_113_1.time_ and arg_113_1.time_ <= var_116_50 + arg_116_0 then
				local var_116_51 = arg_113_1.var_.effecthudiexuanguang2

				if var_116_51 then
					Object.Destroy(var_116_51)

					arg_113_1.var_.effecthudiexuanguang2 = nil
				end
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_52 = 3.36666666666667
			local var_116_53 = 1.075

			if var_116_52 < arg_113_1.time_ and arg_113_1.time_ <= var_116_52 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_54 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_54:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_55 = arg_113_1:GetWordFromCfg(424011027)
				local var_116_56 = arg_113_1:FormatText(var_116_55.content)

				arg_113_1.text_.text = var_116_56

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_57 = 43
				local var_116_58 = utf8.len(var_116_56)
				local var_116_59 = var_116_57 <= 0 and var_116_53 or var_116_53 * (var_116_58 / var_116_57)

				if var_116_59 > 0 and var_116_53 < var_116_59 then
					arg_113_1.talkMaxDuration = var_116_59
					var_116_52 = var_116_52 + 0.3

					if var_116_59 + var_116_52 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_59 + var_116_52
					end
				end

				arg_113_1.text_.text = var_116_56
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_60 = var_116_52 + 0.3
			local var_116_61 = math.max(var_116_53, arg_113_1.talkMaxDuration)

			if var_116_60 <= arg_113_1.time_ and arg_113_1.time_ < var_116_60 + var_116_61 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_60) / var_116_61

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_60 + var_116_61 and arg_113_1.time_ < var_116_60 + var_116_61 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2401b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1.36666666666667,
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

		arg_113_1:InitPlayNodeList()
	end,
	Play424011028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424011028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424011029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.125

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(424011028)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 45
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play424011029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424011029
		arg_123_1.duration_ = 7.1

		local var_123_0 = {
			zh = 7.1,
			ja = 4.1
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
				arg_123_0:Play424011030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.225

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[1385].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(424011029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011029", "story_v_out_424011.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011029", "story_v_out_424011.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_424011", "424011029", "story_v_out_424011.awb")

						arg_123_1:RecordAudio("424011029", var_126_9)
						arg_123_1:RecordAudio("424011029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424011", "424011029", "story_v_out_424011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424011", "424011029", "story_v_out_424011.awb")
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
	Play424011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424011030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.55

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(424011030)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 22
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424011031
		arg_131_1.duration_ = 1.93

		local var_131_0 = {
			zh = 1.933,
			ja = 1.3
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
				arg_131_0:Play424011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.175

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[1386].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(424011031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011031", "story_v_out_424011.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011031", "story_v_out_424011.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_424011", "424011031", "story_v_out_424011.awb")

						arg_131_1:RecordAudio("424011031", var_134_9)
						arg_131_1:RecordAudio("424011031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424011", "424011031", "story_v_out_424011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424011", "424011031", "story_v_out_424011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play424011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424011032
		arg_135_1.duration_ = 9

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "ST04c"

			if arg_135_1.bgs_[var_138_0] == nil then
				local var_138_1 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_138_0)
				var_138_1.name = var_138_0
				var_138_1.transform.parent = arg_135_1.stage_.transform
				var_138_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_[var_138_0] = var_138_1
			end

			local var_138_2 = 2

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				local var_138_3 = manager.ui.mainCamera.transform.localPosition
				local var_138_4 = Vector3.New(0, 0, 10) + Vector3.New(var_138_3.x, var_138_3.y, 0)
				local var_138_5 = arg_135_1.bgs_.ST04c

				var_138_5.transform.localPosition = var_138_4
				var_138_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_6 = var_138_5:GetComponent("SpriteRenderer")

				if var_138_6 and var_138_6.sprite then
					local var_138_7 = (var_138_5.transform.localPosition - var_138_3).z
					local var_138_8 = manager.ui.mainCameraCom_
					local var_138_9 = 2 * var_138_7 * Mathf.Tan(var_138_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_10 = var_138_9 * var_138_8.aspect
					local var_138_11 = var_138_6.sprite.bounds.size.x
					local var_138_12 = var_138_6.sprite.bounds.size.y
					local var_138_13 = var_138_10 / var_138_11
					local var_138_14 = var_138_9 / var_138_12
					local var_138_15 = var_138_14 < var_138_13 and var_138_13 or var_138_14

					var_138_5.transform.localScale = Vector3.New(var_138_15, var_138_15, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "ST04c" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_16 = 4

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_17 = 0.3

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_18 = 0

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_19 = 2

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_19 then
				local var_138_20 = (arg_135_1.time_ - var_138_18) / var_138_19
				local var_138_21 = Color.New(0, 0, 0)

				var_138_21.a = Mathf.Lerp(0, 1, var_138_20)
				arg_135_1.mask_.color = var_138_21
			end

			if arg_135_1.time_ >= var_138_18 + var_138_19 and arg_135_1.time_ < var_138_18 + var_138_19 + arg_138_0 then
				local var_138_22 = Color.New(0, 0, 0)

				var_138_22.a = 1
				arg_135_1.mask_.color = var_138_22
			end

			local var_138_23 = 2

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_24 = 2

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24
				local var_138_26 = Color.New(0, 0, 0)

				var_138_26.a = Mathf.Lerp(1, 0, var_138_25)
				arg_135_1.mask_.color = var_138_26
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 then
				local var_138_27 = Color.New(0, 0, 0)
				local var_138_28 = 0

				arg_135_1.mask_.enabled = false
				var_138_27.a = var_138_28
				arg_135_1.mask_.color = var_138_27
			end

			local var_138_29 = manager.ui.mainCamera.transform
			local var_138_30 = 2

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				local var_138_31 = arg_135_1.var_.effect46wuqi1

				if var_138_31 then
					Object.Destroy(var_138_31)

					arg_135_1.var_.effect46wuqi1 = nil
				end
			end

			local var_138_32 = manager.ui.mainCamera.transform
			local var_138_33 = 2

			if var_138_33 < arg_135_1.time_ and arg_135_1.time_ <= var_138_33 + arg_138_0 then
				local var_138_34 = arg_135_1.var_.effect46hailahudiechudengchang1

				if var_138_34 then
					Object.Destroy(var_138_34)

					arg_135_1.var_.effect46hailahudiechudengchang1 = nil
				end
			end

			local var_138_35 = 4.1
			local var_138_36 = 1

			if var_138_35 < arg_135_1.time_ and arg_135_1.time_ <= var_138_35 + arg_138_0 then
				local var_138_37 = "play"
				local var_138_38 = "effect"

				arg_135_1:AudioAction(var_138_37, var_138_38, "se_story_146", "se_story_146_umbrella02", "")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_39 = 4
			local var_138_40 = 0.9

			if var_138_39 < arg_135_1.time_ and arg_135_1.time_ <= var_138_39 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_41 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_41:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_42 = arg_135_1:GetWordFromCfg(424011032)
				local var_138_43 = arg_135_1:FormatText(var_138_42.content)

				arg_135_1.text_.text = var_138_43

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_44 = 36
				local var_138_45 = utf8.len(var_138_43)
				local var_138_46 = var_138_44 <= 0 and var_138_40 or var_138_40 * (var_138_45 / var_138_44)

				if var_138_46 > 0 and var_138_40 < var_138_46 then
					arg_135_1.talkMaxDuration = var_138_46
					var_138_39 = var_138_39 + 0.3

					if var_138_46 + var_138_39 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_46 + var_138_39
					end
				end

				arg_135_1.text_.text = var_138_43
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_47 = var_138_39 + 0.3
			local var_138_48 = math.max(var_138_40, arg_135_1.talkMaxDuration)

			if var_138_47 <= arg_135_1.time_ and arg_135_1.time_ < var_138_47 + var_138_48 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_47) / var_138_48

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_47 + var_138_48 and arg_135_1.time_ < var_138_47 + var_138_48 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424011033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 424011033
		arg_141_1.duration_ = 7.73

		local var_141_0 = {
			zh = 6.6,
			ja = 7.733
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
				arg_141_0:Play424011034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.775

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[177].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(424011033)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011033", "story_v_out_424011.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011033", "story_v_out_424011.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_424011", "424011033", "story_v_out_424011.awb")

						arg_141_1:RecordAudio("424011033", var_144_9)
						arg_141_1:RecordAudio("424011033", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_424011", "424011033", "story_v_out_424011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_424011", "424011033", "story_v_out_424011.awb")
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
	Play424011034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 424011034
		arg_145_1.duration_ = 4.77

		local var_145_0 = {
			zh = 4.233,
			ja = 4.766
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play424011035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "1094"

			if arg_145_1.actors_[var_148_0] == nil then
				local var_148_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_148_1) then
					local var_148_2 = Object.Instantiate(var_148_1, arg_145_1.canvasGo_.transform)

					var_148_2.transform:SetSiblingIndex(1)

					var_148_2.name = var_148_0
					var_148_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_145_1.actors_[var_148_0] = var_148_2

					local var_148_3 = var_148_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_145_1.isInRecall_ then
						for iter_148_0, iter_148_1 in ipairs(var_148_3) do
							iter_148_1.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_148_4 = arg_145_1.actors_["1094"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.actorSpriteComps1094 == nil then
				arg_145_1.var_.actorSpriteComps1094 = var_148_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.2

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.actorSpriteComps1094 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								local var_148_8 = Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor1.r, var_148_7)
								local var_148_9 = Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor1.g, var_148_7)
								local var_148_10 = Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor1.b, var_148_7)

								iter_148_3.color = Color.New(var_148_8, var_148_9, var_148_10)
							else
								local var_148_11 = Mathf.Lerp(iter_148_3.color.r, 1, var_148_7)

								iter_148_3.color = Color.New(var_148_11, var_148_11, var_148_11)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.actorSpriteComps1094 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_148_5 then
						if arg_145_1.isInRecall_ then
							iter_148_5.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1094 = nil
			end

			local var_148_12 = arg_145_1.actors_["1094"].transform
			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1.var_.moveOldPos1094 = var_148_12.localPosition
				var_148_12.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1094", 3)

				local var_148_14 = var_148_12.childCount

				for iter_148_6 = 0, var_148_14 - 1 do
					local var_148_15 = var_148_12:GetChild(iter_148_6)

					if var_148_15.name == "" or not string.find(var_148_15.name, "split") then
						var_148_15.gameObject:SetActive(true)
					else
						var_148_15.gameObject:SetActive(false)
					end
				end
			end

			local var_148_16 = 0.001

			if var_148_13 <= arg_145_1.time_ and arg_145_1.time_ < var_148_13 + var_148_16 then
				local var_148_17 = (arg_145_1.time_ - var_148_13) / var_148_16
				local var_148_18 = Vector3.New(0, -335, -230)

				var_148_12.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1094, var_148_18, var_148_17)
			end

			if arg_145_1.time_ >= var_148_13 + var_148_16 and arg_145_1.time_ < var_148_13 + var_148_16 + arg_148_0 then
				var_148_12.localPosition = Vector3.New(0, -335, -230)
			end

			local var_148_19 = arg_145_1.actors_["1094"]
			local var_148_20 = 0

			if var_148_20 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				local var_148_21 = var_148_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_148_21 then
					arg_145_1.var_.alphaOldValue1094 = var_148_21.alpha
					arg_145_1.var_.characterEffect1094 = var_148_21
				end

				arg_145_1.var_.alphaOldValue1094 = 0
			end

			local var_148_22 = 0.5

			if var_148_20 <= arg_145_1.time_ and arg_145_1.time_ < var_148_20 + var_148_22 then
				local var_148_23 = (arg_145_1.time_ - var_148_20) / var_148_22
				local var_148_24 = Mathf.Lerp(arg_145_1.var_.alphaOldValue1094, 1, var_148_23)

				if arg_145_1.var_.characterEffect1094 then
					arg_145_1.var_.characterEffect1094.alpha = var_148_24
				end
			end

			if arg_145_1.time_ >= var_148_20 + var_148_22 and arg_145_1.time_ < var_148_20 + var_148_22 + arg_148_0 and arg_145_1.var_.characterEffect1094 then
				arg_145_1.var_.characterEffect1094.alpha = 1
			end

			local var_148_25 = 0
			local var_148_26 = 0.275

			if var_148_25 < arg_145_1.time_ and arg_145_1.time_ <= var_148_25 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_27 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_27:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_28 = arg_145_1:FormatText(StoryNameCfg[181].name)

				arg_145_1.leftNameTxt_.text = var_148_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_29 = arg_145_1:GetWordFromCfg(424011034)
				local var_148_30 = arg_145_1:FormatText(var_148_29.content)

				arg_145_1.text_.text = var_148_30

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_31 = 11
				local var_148_32 = utf8.len(var_148_30)
				local var_148_33 = var_148_31 <= 0 and var_148_26 or var_148_26 * (var_148_32 / var_148_31)

				if var_148_33 > 0 and var_148_26 < var_148_33 then
					arg_145_1.talkMaxDuration = var_148_33
					var_148_25 = var_148_25 + 0.3

					if var_148_33 + var_148_25 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_33 + var_148_25
					end
				end

				arg_145_1.text_.text = var_148_30
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011034", "story_v_out_424011.awb") ~= 0 then
					local var_148_34 = manager.audio:GetVoiceLength("story_v_out_424011", "424011034", "story_v_out_424011.awb") / 1000

					if var_148_34 + var_148_25 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_34 + var_148_25
					end

					if var_148_29.prefab_name ~= "" and arg_145_1.actors_[var_148_29.prefab_name] ~= nil then
						local var_148_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_29.prefab_name].transform, "story_v_out_424011", "424011034", "story_v_out_424011.awb")

						arg_145_1:RecordAudio("424011034", var_148_35)
						arg_145_1:RecordAudio("424011034", var_148_35)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_424011", "424011034", "story_v_out_424011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_424011", "424011034", "story_v_out_424011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_36 = var_148_25 + 0.3
			local var_148_37 = math.max(var_148_26, arg_145_1.talkMaxDuration)

			if var_148_36 <= arg_145_1.time_ and arg_145_1.time_ < var_148_36 + var_148_37 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_36) / var_148_37

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_36 + var_148_37 and arg_145_1.time_ < var_148_36 + var_148_37 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play424011035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424011035
		arg_151_1.duration_ = 8.67

		local var_151_0 = {
			zh = 6.233,
			ja = 8.666
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
				arg_151_0:Play424011036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1094"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1094 == nil then
				arg_151_1.var_.actorSpriteComps1094 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps1094 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1094 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1094 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.725

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[177].name)

				arg_151_1.leftNameTxt_.text = var_154_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_11 = arg_151_1:GetWordFromCfg(424011035)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 29
				local var_154_14 = utf8.len(var_154_12)
				local var_154_15 = var_154_13 <= 0 and var_154_9 or var_154_9 * (var_154_14 / var_154_13)

				if var_154_15 > 0 and var_154_9 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_12
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011035", "story_v_out_424011.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_424011", "424011035", "story_v_out_424011.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_424011", "424011035", "story_v_out_424011.awb")

						arg_151_1:RecordAudio("424011035", var_154_17)
						arg_151_1:RecordAudio("424011035", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424011", "424011035", "story_v_out_424011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424011", "424011035", "story_v_out_424011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_18 and arg_151_1.time_ < var_154_8 + var_154_18 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play424011036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424011036
		arg_155_1.duration_ = 3.63

		local var_155_0 = {
			zh = 3.633,
			ja = 2.766
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
				arg_155_0:Play424011037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1094"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1094 == nil then
				arg_155_1.var_.actorSpriteComps1094 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps1094 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 1, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1094 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1094 = nil
			end

			local var_158_8 = arg_155_1.actors_["1094"].transform
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.var_.moveOldPos1094 = var_158_8.localPosition
				var_158_8.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1094", 3)

				local var_158_10 = var_158_8.childCount

				for iter_158_4 = 0, var_158_10 - 1 do
					local var_158_11 = var_158_8:GetChild(iter_158_4)

					if var_158_11.name == "split_4" then
						var_158_11:SetAsLastSibling()
						var_158_11.gameObject:SetActive(true)

						arg_155_1.var_.actorSpriteSplit1094 = var_158_11.gameObject:GetComponent(typeof(Image))

						arg_155_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_158_12 = 0.5

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_12 then
				local var_158_13 = (arg_155_1.time_ - var_158_9) / var_158_12
				local var_158_14 = Vector3.New(0, -335, -230)

				var_158_8.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1094, var_158_14, var_158_13)

				if arg_155_1.var_.actorSpriteSplit1094 ~= nil then
					arg_155_1.var_.actorSpriteSplit1094:SetAlpha(var_158_13)
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_12 and arg_155_1.time_ < var_158_9 + var_158_12 + arg_158_0 then
				var_158_8.localPosition = Vector3.New(0, -335, -230)

				if arg_155_1.var_.actorSpriteSplit1094 ~= nil then
					arg_155_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_158_15 = 0
			local var_158_16 = 0.2

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[181].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(424011036)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 8
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011036", "story_v_out_424011.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011036", "story_v_out_424011.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_424011", "424011036", "story_v_out_424011.awb")

						arg_155_1:RecordAudio("424011036", var_158_24)
						arg_155_1:RecordAudio("424011036", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424011", "424011036", "story_v_out_424011.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424011", "424011036", "story_v_out_424011.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play424011037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424011037
		arg_159_1.duration_ = 1.6

		local var_159_0 = {
			zh = 1.233,
			ja = 1.6
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
				arg_159_0:Play424011038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1094"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1094 == nil then
				arg_159_1.var_.actorSpriteComps1094 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps1094 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 0.5, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1094 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1094 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 1

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				local var_162_10 = "play"
				local var_162_11 = "effect"

				arg_159_1:AudioAction(var_162_10, var_162_11, "se_story_121_04", "se_story_121_04_walk02", "")
			end

			local var_162_12 = 0
			local var_162_13 = 0.1

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[36].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_1")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_15 = arg_159_1:GetWordFromCfg(424011037)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 4
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011037", "story_v_out_424011.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_424011", "424011037", "story_v_out_424011.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_424011", "424011037", "story_v_out_424011.awb")

						arg_159_1:RecordAudio("424011037", var_162_21)
						arg_159_1:RecordAudio("424011037", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_424011", "424011037", "story_v_out_424011.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_424011", "424011037", "story_v_out_424011.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play424011038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424011038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play424011039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				local var_166_2 = "play"
				local var_166_3 = "effect"

				arg_163_1:AudioAction(var_166_2, var_166_3, "se_story_122_03", "se_story_122_03_wind", "")
			end

			local var_166_4 = 0.3
			local var_166_5 = 1

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				local var_166_6 = "play"
				local var_166_7 = "effect"

				arg_163_1:AudioAction(var_166_6, var_166_7, "se_story_144", "se_story_144_bell02", "")
			end

			local var_166_8 = 0
			local var_166_9 = 0.9

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(424011038)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 36
				local var_166_13 = utf8.len(var_166_11)
				local var_166_14 = var_166_12 <= 0 and var_166_9 or var_166_9 * (var_166_13 / var_166_12)

				if var_166_14 > 0 and var_166_9 < var_166_14 then
					arg_163_1.talkMaxDuration = var_166_14

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_15 and arg_163_1.time_ < var_166_8 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play424011039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424011039
		arg_167_1.duration_ = 1.5

		local var_167_0 = {
			zh = 1.366,
			ja = 1.5
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
				arg_167_0:Play424011040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1094"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1094 == nil then
				arg_167_1.var_.actorSpriteComps1094 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps1094 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 1, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1094 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1094 = nil
			end

			local var_170_8 = arg_167_1.actors_["1094"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos1094 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1094", 3)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "split_5" then
						var_170_11:SetAsLastSibling()
						var_170_11.gameObject:SetActive(true)

						arg_167_1.var_.actorSpriteSplit1094 = var_170_11.gameObject:GetComponent(typeof(Image))

						arg_167_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_170_12 = 0.5

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(0, -335, -230)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1094, var_170_14, var_170_13)

				if arg_167_1.var_.actorSpriteSplit1094 ~= nil then
					arg_167_1.var_.actorSpriteSplit1094:SetAlpha(var_170_13)
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, -335, -230)

				if arg_167_1.var_.actorSpriteSplit1094 ~= nil then
					arg_167_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_170_15 = 0
			local var_170_16 = 0.125

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[181].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(424011039)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 5
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011039", "story_v_out_424011.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011039", "story_v_out_424011.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_424011", "424011039", "story_v_out_424011.awb")

						arg_167_1:RecordAudio("424011039", var_170_24)
						arg_167_1:RecordAudio("424011039", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424011", "424011039", "story_v_out_424011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424011", "424011039", "story_v_out_424011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play424011040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424011040
		arg_171_1.duration_ = 5.2

		local var_171_0 = {
			zh = 5.2,
			ja = 5.033
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
				arg_171_0:Play424011041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1094"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1094 == nil then
				arg_171_1.var_.actorSpriteComps1094 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps1094 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 0.5, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1094 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1094 = nil
			end

			local var_174_8 = 0
			local var_174_9 = 0.625

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_10 = arg_171_1:FormatText(StoryNameCfg[177].name)

				arg_171_1.leftNameTxt_.text = var_174_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_11 = arg_171_1:GetWordFromCfg(424011040)
				local var_174_12 = arg_171_1:FormatText(var_174_11.content)

				arg_171_1.text_.text = var_174_12

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 25
				local var_174_14 = utf8.len(var_174_12)
				local var_174_15 = var_174_13 <= 0 and var_174_9 or var_174_9 * (var_174_14 / var_174_13)

				if var_174_15 > 0 and var_174_9 < var_174_15 then
					arg_171_1.talkMaxDuration = var_174_15

					if var_174_15 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_12
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011040", "story_v_out_424011.awb") ~= 0 then
					local var_174_16 = manager.audio:GetVoiceLength("story_v_out_424011", "424011040", "story_v_out_424011.awb") / 1000

					if var_174_16 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_8
					end

					if var_174_11.prefab_name ~= "" and arg_171_1.actors_[var_174_11.prefab_name] ~= nil then
						local var_174_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_11.prefab_name].transform, "story_v_out_424011", "424011040", "story_v_out_424011.awb")

						arg_171_1:RecordAudio("424011040", var_174_17)
						arg_171_1:RecordAudio("424011040", var_174_17)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424011", "424011040", "story_v_out_424011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424011", "424011040", "story_v_out_424011.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_18 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_18 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_18

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_18 and arg_171_1.time_ < var_174_8 + var_174_18 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424011041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424011041
		arg_175_1.duration_ = 5.03

		local var_175_0 = {
			zh = 3,
			ja = 5.033
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play424011042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "10153"

			if arg_175_1.actors_[var_178_0] == nil then
				local var_178_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_178_1) then
					local var_178_2 = Object.Instantiate(var_178_1, arg_175_1.canvasGo_.transform)

					var_178_2.transform:SetSiblingIndex(1)

					var_178_2.name = var_178_0
					var_178_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_175_1.actors_[var_178_0] = var_178_2

					local var_178_3 = var_178_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_175_1.isInRecall_ then
						for iter_178_0, iter_178_1 in ipairs(var_178_3) do
							iter_178_1.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_178_4 = arg_175_1.actors_["10153"]
			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps10153 == nil then
				arg_175_1.var_.actorSpriteComps10153 = var_178_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 0.2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 and not isNil(var_178_4) then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6

				if arg_175_1.var_.actorSpriteComps10153 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_178_3 then
							if arg_175_1.isInRecall_ then
								local var_178_8 = Mathf.Lerp(iter_178_3.color.r, arg_175_1.hightColor1.r, var_178_7)
								local var_178_9 = Mathf.Lerp(iter_178_3.color.g, arg_175_1.hightColor1.g, var_178_7)
								local var_178_10 = Mathf.Lerp(iter_178_3.color.b, arg_175_1.hightColor1.b, var_178_7)

								iter_178_3.color = Color.New(var_178_8, var_178_9, var_178_10)
							else
								local var_178_11 = Mathf.Lerp(iter_178_3.color.r, 1, var_178_7)

								iter_178_3.color = Color.New(var_178_11, var_178_11, var_178_11)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps10153 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_178_5 then
						if arg_175_1.isInRecall_ then
							iter_178_5.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10153 = nil
			end

			local var_178_12 = arg_175_1.actors_["10153"].transform
			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1.var_.moveOldPos10153 = var_178_12.localPosition
				var_178_12.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10153", 4)

				local var_178_14 = var_178_12.childCount

				for iter_178_6 = 0, var_178_14 - 1 do
					local var_178_15 = var_178_12:GetChild(iter_178_6)

					if var_178_15.name == "split_3" or not string.find(var_178_15.name, "split") then
						var_178_15.gameObject:SetActive(true)
					else
						var_178_15.gameObject:SetActive(false)
					end
				end
			end

			local var_178_16 = 0.001

			if var_178_13 <= arg_175_1.time_ and arg_175_1.time_ < var_178_13 + var_178_16 then
				local var_178_17 = (arg_175_1.time_ - var_178_13) / var_178_16
				local var_178_18 = Vector3.New(400, -395, -330)

				var_178_12.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10153, var_178_18, var_178_17)
			end

			if arg_175_1.time_ >= var_178_13 + var_178_16 and arg_175_1.time_ < var_178_13 + var_178_16 + arg_178_0 then
				var_178_12.localPosition = Vector3.New(400, -395, -330)
			end

			local var_178_19 = arg_175_1.actors_["1094"].transform
			local var_178_20 = 0

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				arg_175_1.var_.moveOldPos1094 = var_178_19.localPosition
				var_178_19.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1094", 2)

				local var_178_21 = var_178_19.childCount

				for iter_178_7 = 0, var_178_21 - 1 do
					local var_178_22 = var_178_19:GetChild(iter_178_7)

					if var_178_22.name == "split_1" then
						var_178_22:SetAsLastSibling()
						var_178_22.gameObject:SetActive(true)

						arg_175_1.var_.actorSpriteSplit1094 = var_178_22.gameObject:GetComponent(typeof(Image))

						arg_175_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_178_23 = 0.001

			if var_178_20 <= arg_175_1.time_ and arg_175_1.time_ < var_178_20 + var_178_23 then
				local var_178_24 = (arg_175_1.time_ - var_178_20) / var_178_23
				local var_178_25 = Vector3.New(-380, -335, -230)

				var_178_19.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1094, var_178_25, var_178_24)

				if arg_175_1.var_.actorSpriteSplit1094 ~= nil then
					arg_175_1.var_.actorSpriteSplit1094:SetAlpha(var_178_24)
				end
			end

			if arg_175_1.time_ >= var_178_20 + var_178_23 and arg_175_1.time_ < var_178_20 + var_178_23 + arg_178_0 then
				var_178_19.localPosition = Vector3.New(-380, -335, -230)

				if arg_175_1.var_.actorSpriteSplit1094 ~= nil then
					arg_175_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_178_26 = arg_175_1.actors_["10153"]
			local var_178_27 = 0

			if var_178_27 < arg_175_1.time_ and arg_175_1.time_ <= var_178_27 + arg_178_0 then
				local var_178_28 = var_178_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_178_28 then
					arg_175_1.var_.alphaOldValue10153 = var_178_28.alpha
					arg_175_1.var_.characterEffect10153 = var_178_28
				end

				arg_175_1.var_.alphaOldValue10153 = 0
			end

			local var_178_29 = 0.5

			if var_178_27 <= arg_175_1.time_ and arg_175_1.time_ < var_178_27 + var_178_29 then
				local var_178_30 = (arg_175_1.time_ - var_178_27) / var_178_29
				local var_178_31 = Mathf.Lerp(arg_175_1.var_.alphaOldValue10153, 1, var_178_30)

				if arg_175_1.var_.characterEffect10153 then
					arg_175_1.var_.characterEffect10153.alpha = var_178_31
				end
			end

			if arg_175_1.time_ >= var_178_27 + var_178_29 and arg_175_1.time_ < var_178_27 + var_178_29 + arg_178_0 and arg_175_1.var_.characterEffect10153 then
				arg_175_1.var_.characterEffect10153.alpha = 1
			end

			local var_178_32 = 0
			local var_178_33 = 0.325

			if var_178_32 < arg_175_1.time_ and arg_175_1.time_ <= var_178_32 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_34 = arg_175_1:FormatText(StoryNameCfg[1387].name)

				arg_175_1.leftNameTxt_.text = var_178_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_35 = arg_175_1:GetWordFromCfg(424011041)
				local var_178_36 = arg_175_1:FormatText(var_178_35.content)

				arg_175_1.text_.text = var_178_36

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_37 = 13
				local var_178_38 = utf8.len(var_178_36)
				local var_178_39 = var_178_37 <= 0 and var_178_33 or var_178_33 * (var_178_38 / var_178_37)

				if var_178_39 > 0 and var_178_33 < var_178_39 then
					arg_175_1.talkMaxDuration = var_178_39

					if var_178_39 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_39 + var_178_32
					end
				end

				arg_175_1.text_.text = var_178_36
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011041", "story_v_out_424011.awb") ~= 0 then
					local var_178_40 = manager.audio:GetVoiceLength("story_v_out_424011", "424011041", "story_v_out_424011.awb") / 1000

					if var_178_40 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_40 + var_178_32
					end

					if var_178_35.prefab_name ~= "" and arg_175_1.actors_[var_178_35.prefab_name] ~= nil then
						local var_178_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_35.prefab_name].transform, "story_v_out_424011", "424011041", "story_v_out_424011.awb")

						arg_175_1:RecordAudio("424011041", var_178_41)
						arg_175_1:RecordAudio("424011041", var_178_41)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_424011", "424011041", "story_v_out_424011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_424011", "424011041", "story_v_out_424011.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_42 = math.max(var_178_33, arg_175_1.talkMaxDuration)

			if var_178_32 <= arg_175_1.time_ and arg_175_1.time_ < var_178_32 + var_178_42 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_32) / var_178_42

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_32 + var_178_42 and arg_175_1.time_ < var_178_32 + var_178_42 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play424011042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424011042
		arg_179_1.duration_ = 7.1

		local var_179_0 = {
			zh = 6.3,
			ja = 7.1
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424011043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10153"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10153 == nil then
				arg_179_1.var_.actorSpriteComps10153 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps10153 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 0.5, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10153 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10153 = nil
			end

			local var_182_8 = 0
			local var_182_9 = 0.675

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_10 = arg_179_1:FormatText(StoryNameCfg[177].name)

				arg_179_1.leftNameTxt_.text = var_182_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_11 = arg_179_1:GetWordFromCfg(424011042)
				local var_182_12 = arg_179_1:FormatText(var_182_11.content)

				arg_179_1.text_.text = var_182_12

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 27
				local var_182_14 = utf8.len(var_182_12)
				local var_182_15 = var_182_13 <= 0 and var_182_9 or var_182_9 * (var_182_14 / var_182_13)

				if var_182_15 > 0 and var_182_9 < var_182_15 then
					arg_179_1.talkMaxDuration = var_182_15

					if var_182_15 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_15 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_12
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011042", "story_v_out_424011.awb") ~= 0 then
					local var_182_16 = manager.audio:GetVoiceLength("story_v_out_424011", "424011042", "story_v_out_424011.awb") / 1000

					if var_182_16 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_8
					end

					if var_182_11.prefab_name ~= "" and arg_179_1.actors_[var_182_11.prefab_name] ~= nil then
						local var_182_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_11.prefab_name].transform, "story_v_out_424011", "424011042", "story_v_out_424011.awb")

						arg_179_1:RecordAudio("424011042", var_182_17)
						arg_179_1:RecordAudio("424011042", var_182_17)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_424011", "424011042", "story_v_out_424011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_424011", "424011042", "story_v_out_424011.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_18 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_18 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_18

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_18 and arg_179_1.time_ < var_182_8 + var_182_18 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424011043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424011043
		arg_183_1.duration_ = 2.6

		local var_183_0 = {
			zh = 2.266,
			ja = 2.6
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play424011044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1094"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1094 == nil then
				arg_183_1.var_.actorSpriteComps1094 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps1094 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 1, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1094 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1094 = nil
			end

			local var_186_8 = arg_183_1.actors_["1094"].transform
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.var_.moveOldPos1094 = var_186_8.localPosition
				var_186_8.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1094", 2)

				local var_186_10 = var_186_8.childCount

				for iter_186_4 = 0, var_186_10 - 1 do
					local var_186_11 = var_186_8:GetChild(iter_186_4)

					if var_186_11.name == "split_1" or not string.find(var_186_11.name, "split") then
						var_186_11.gameObject:SetActive(true)
					else
						var_186_11.gameObject:SetActive(false)
					end
				end
			end

			local var_186_12 = 0.001

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_9) / var_186_12
				local var_186_14 = Vector3.New(-380, -335, -230)

				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1094, var_186_14, var_186_13)
			end

			if arg_183_1.time_ >= var_186_9 + var_186_12 and arg_183_1.time_ < var_186_9 + var_186_12 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_186_15 = 0
			local var_186_16 = 0.15

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[181].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(424011043)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 6
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011043", "story_v_out_424011.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011043", "story_v_out_424011.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_424011", "424011043", "story_v_out_424011.awb")

						arg_183_1:RecordAudio("424011043", var_186_24)
						arg_183_1:RecordAudio("424011043", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_424011", "424011043", "story_v_out_424011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_424011", "424011043", "story_v_out_424011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play424011044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424011044
		arg_187_1.duration_ = 11.23

		local var_187_0 = {
			zh = 7.066,
			ja = 11.233
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play424011045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10153"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps10153 == nil then
				arg_187_1.var_.actorSpriteComps10153 = var_190_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.actorSpriteComps10153 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								local var_190_4 = Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, var_190_3)
								local var_190_5 = Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, var_190_3)
								local var_190_6 = Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, var_190_3)

								iter_190_1.color = Color.New(var_190_4, var_190_5, var_190_6)
							else
								local var_190_7 = Mathf.Lerp(iter_190_1.color.r, 1, var_190_3)

								iter_190_1.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps10153 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_190_3 then
						if arg_187_1.isInRecall_ then
							iter_190_3.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10153 = nil
			end

			local var_190_8 = arg_187_1.actors_["1094"]
			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps1094 == nil then
				arg_187_1.var_.actorSpriteComps1094 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_10 = 0.2

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 and not isNil(var_190_8) then
				local var_190_11 = (arg_187_1.time_ - var_190_9) / var_190_10

				if arg_187_1.var_.actorSpriteComps1094 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_190_5 then
							if arg_187_1.isInRecall_ then
								local var_190_12 = Mathf.Lerp(iter_190_5.color.r, arg_187_1.hightColor2.r, var_190_11)
								local var_190_13 = Mathf.Lerp(iter_190_5.color.g, arg_187_1.hightColor2.g, var_190_11)
								local var_190_14 = Mathf.Lerp(iter_190_5.color.b, arg_187_1.hightColor2.b, var_190_11)

								iter_190_5.color = Color.New(var_190_12, var_190_13, var_190_14)
							else
								local var_190_15 = Mathf.Lerp(iter_190_5.color.r, 0.5, var_190_11)

								iter_190_5.color = Color.New(var_190_15, var_190_15, var_190_15)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps1094 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_190_7 then
						if arg_187_1.isInRecall_ then
							iter_190_7.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1094 = nil
			end

			local var_190_16 = arg_187_1.actors_["10153"].transform
			local var_190_17 = 0

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.var_.moveOldPos10153 = var_190_16.localPosition
				var_190_16.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10153", 4)

				local var_190_18 = var_190_16.childCount

				for iter_190_8 = 0, var_190_18 - 1 do
					local var_190_19 = var_190_16:GetChild(iter_190_8)

					if var_190_19.name == "split_5" then
						var_190_19:SetAsLastSibling()
						var_190_19.gameObject:SetActive(true)

						arg_187_1.var_.actorSpriteSplit10153 = var_190_19.gameObject:GetComponent(typeof(Image))

						arg_187_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_190_20 = 0.5

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_20 then
				local var_190_21 = (arg_187_1.time_ - var_190_17) / var_190_20
				local var_190_22 = Vector3.New(400, -395, -330)

				var_190_16.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10153, var_190_22, var_190_21)

				if arg_187_1.var_.actorSpriteSplit10153 ~= nil then
					arg_187_1.var_.actorSpriteSplit10153:SetAlpha(var_190_21)
				end
			end

			if arg_187_1.time_ >= var_190_17 + var_190_20 and arg_187_1.time_ < var_190_17 + var_190_20 + arg_190_0 then
				var_190_16.localPosition = Vector3.New(400, -395, -330)

				if arg_187_1.var_.actorSpriteSplit10153 ~= nil then
					arg_187_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_190_23 = 0
			local var_190_24 = 0.85

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_25 = arg_187_1:FormatText(StoryNameCfg[1387].name)

				arg_187_1.leftNameTxt_.text = var_190_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_26 = arg_187_1:GetWordFromCfg(424011044)
				local var_190_27 = arg_187_1:FormatText(var_190_26.content)

				arg_187_1.text_.text = var_190_27

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_28 = 34
				local var_190_29 = utf8.len(var_190_27)
				local var_190_30 = var_190_28 <= 0 and var_190_24 or var_190_24 * (var_190_29 / var_190_28)

				if var_190_30 > 0 and var_190_24 < var_190_30 then
					arg_187_1.talkMaxDuration = var_190_30

					if var_190_30 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_30 + var_190_23
					end
				end

				arg_187_1.text_.text = var_190_27
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011044", "story_v_out_424011.awb") ~= 0 then
					local var_190_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011044", "story_v_out_424011.awb") / 1000

					if var_190_31 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_31 + var_190_23
					end

					if var_190_26.prefab_name ~= "" and arg_187_1.actors_[var_190_26.prefab_name] ~= nil then
						local var_190_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_26.prefab_name].transform, "story_v_out_424011", "424011044", "story_v_out_424011.awb")

						arg_187_1:RecordAudio("424011044", var_190_32)
						arg_187_1:RecordAudio("424011044", var_190_32)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_424011", "424011044", "story_v_out_424011.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_424011", "424011044", "story_v_out_424011.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_33 = math.max(var_190_24, arg_187_1.talkMaxDuration)

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_33 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_23) / var_190_33

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_23 + var_190_33 and arg_187_1.time_ < var_190_23 + var_190_33 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play424011045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424011045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play424011046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10153"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10153 == nil then
				arg_191_1.var_.actorSpriteComps10153 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps10153 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								local var_194_4 = Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, var_194_3)
								local var_194_5 = Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, var_194_3)
								local var_194_6 = Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, var_194_3)

								iter_194_1.color = Color.New(var_194_4, var_194_5, var_194_6)
							else
								local var_194_7 = Mathf.Lerp(iter_194_1.color.r, 0.5, var_194_3)

								iter_194_1.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10153 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10153 = nil
			end

			local var_194_8 = arg_191_1.actors_["10153"].transform
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.var_.moveOldPos10153 = var_194_8.localPosition
				var_194_8.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10153", 7)

				local var_194_10 = var_194_8.childCount

				for iter_194_4 = 0, var_194_10 - 1 do
					local var_194_11 = var_194_8:GetChild(iter_194_4)

					if var_194_11.name == "" or not string.find(var_194_11.name, "split") then
						var_194_11.gameObject:SetActive(true)
					else
						var_194_11.gameObject:SetActive(false)
					end
				end
			end

			local var_194_12 = 0.001

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_12 then
				local var_194_13 = (arg_191_1.time_ - var_194_9) / var_194_12
				local var_194_14 = Vector3.New(0, -2000, 0)

				var_194_8.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10153, var_194_14, var_194_13)
			end

			if arg_191_1.time_ >= var_194_9 + var_194_12 and arg_191_1.time_ < var_194_9 + var_194_12 + arg_194_0 then
				var_194_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_15 = arg_191_1.actors_["1094"].transform
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.var_.moveOldPos1094 = var_194_15.localPosition
				var_194_15.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1094", 7)

				local var_194_17 = var_194_15.childCount

				for iter_194_5 = 0, var_194_17 - 1 do
					local var_194_18 = var_194_15:GetChild(iter_194_5)

					if var_194_18.name == "" or not string.find(var_194_18.name, "split") then
						var_194_18.gameObject:SetActive(true)
					else
						var_194_18.gameObject:SetActive(false)
					end
				end
			end

			local var_194_19 = 0.001

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_19 then
				local var_194_20 = (arg_191_1.time_ - var_194_16) / var_194_19
				local var_194_21 = Vector3.New(0, -2000, 0)

				var_194_15.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1094, var_194_21, var_194_20)
			end

			if arg_191_1.time_ >= var_194_16 + var_194_19 and arg_191_1.time_ < var_194_16 + var_194_19 + arg_194_0 then
				var_194_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_22 = 0
			local var_194_23 = 0.8

			if var_194_22 < arg_191_1.time_ and arg_191_1.time_ <= var_194_22 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_24 = arg_191_1:GetWordFromCfg(424011045)
				local var_194_25 = arg_191_1:FormatText(var_194_24.content)

				arg_191_1.text_.text = var_194_25

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_26 = 32
				local var_194_27 = utf8.len(var_194_25)
				local var_194_28 = var_194_26 <= 0 and var_194_23 or var_194_23 * (var_194_27 / var_194_26)

				if var_194_28 > 0 and var_194_23 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28

					if var_194_28 + var_194_22 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_22
					end
				end

				arg_191_1.text_.text = var_194_25
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_29 = math.max(var_194_23, arg_191_1.talkMaxDuration)

			if var_194_22 <= arg_191_1.time_ and arg_191_1.time_ < var_194_22 + var_194_29 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_22) / var_194_29

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_22 + var_194_29 and arg_191_1.time_ < var_194_22 + var_194_29 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play424011046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424011046
		arg_195_1.duration_ = 6.17

		local var_195_0 = {
			zh = 3.9,
			ja = 6.166
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
				arg_195_0:Play424011047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1094"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1094 == nil then
				arg_195_1.var_.actorSpriteComps1094 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps1094 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 1, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1094 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1094 = nil
			end

			local var_198_8 = arg_195_1.actors_["1094"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos1094 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1094", 3)

				local var_198_10 = var_198_8.childCount

				for iter_198_4 = 0, var_198_10 - 1 do
					local var_198_11 = var_198_8:GetChild(iter_198_4)

					if var_198_11.name == "split_4" or not string.find(var_198_11.name, "split") then
						var_198_11.gameObject:SetActive(true)
					else
						var_198_11.gameObject:SetActive(false)
					end
				end
			end

			local var_198_12 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_9) / var_198_12
				local var_198_14 = Vector3.New(0, -335, -230)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1094, var_198_14, var_198_13)
			end

			if arg_195_1.time_ >= var_198_9 + var_198_12 and arg_195_1.time_ < var_198_9 + var_198_12 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_198_15 = 0
			local var_198_16 = 0.35

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[181].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(424011046)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 14
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011046", "story_v_out_424011.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011046", "story_v_out_424011.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_424011", "424011046", "story_v_out_424011.awb")

						arg_195_1:RecordAudio("424011046", var_198_24)
						arg_195_1:RecordAudio("424011046", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424011", "424011046", "story_v_out_424011.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424011", "424011046", "story_v_out_424011.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play424011047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424011047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play424011048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1094"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1094 == nil then
				arg_199_1.var_.actorSpriteComps1094 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps1094 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 0.5, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1094 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1094 = nil
			end

			local var_202_8 = arg_199_1.actors_["1094"].transform
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.var_.moveOldPos1094 = var_202_8.localPosition
				var_202_8.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1094", 7)

				local var_202_10 = var_202_8.childCount

				for iter_202_4 = 0, var_202_10 - 1 do
					local var_202_11 = var_202_8:GetChild(iter_202_4)

					if var_202_11.name == "" or not string.find(var_202_11.name, "split") then
						var_202_11.gameObject:SetActive(true)
					else
						var_202_11.gameObject:SetActive(false)
					end
				end
			end

			local var_202_12 = 0.001

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_12 then
				local var_202_13 = (arg_199_1.time_ - var_202_9) / var_202_12
				local var_202_14 = Vector3.New(0, -2000, 0)

				var_202_8.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1094, var_202_14, var_202_13)
			end

			if arg_199_1.time_ >= var_202_9 + var_202_12 and arg_199_1.time_ < var_202_9 + var_202_12 + arg_202_0 then
				var_202_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_202_15 = 0
			local var_202_16 = 0.65

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_17 = arg_199_1:GetWordFromCfg(424011047)
				local var_202_18 = arg_199_1:FormatText(var_202_17.content)

				arg_199_1.text_.text = var_202_18

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_19 = 26
				local var_202_20 = utf8.len(var_202_18)
				local var_202_21 = var_202_19 <= 0 and var_202_16 or var_202_16 * (var_202_20 / var_202_19)

				if var_202_21 > 0 and var_202_16 < var_202_21 then
					arg_199_1.talkMaxDuration = var_202_21

					if var_202_21 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_21 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_18
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_22 and arg_199_1.time_ < var_202_15 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play424011048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424011048
		arg_203_1.duration_ = 9.37

		local var_203_0 = {
			zh = 9.366,
			ja = 4.966
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play424011049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10153"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10153 == nil then
				arg_203_1.var_.actorSpriteComps10153 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10153 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 1, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10153 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10153 = nil
			end

			local var_206_8 = arg_203_1.actors_["10153"].transform
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.var_.moveOldPos10153 = var_206_8.localPosition
				var_206_8.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10153", 3)

				local var_206_10 = var_206_8.childCount

				for iter_206_4 = 0, var_206_10 - 1 do
					local var_206_11 = var_206_8:GetChild(iter_206_4)

					if var_206_11.name == "split_2" or not string.find(var_206_11.name, "split") then
						var_206_11.gameObject:SetActive(true)
					else
						var_206_11.gameObject:SetActive(false)
					end
				end
			end

			local var_206_12 = 0.001

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_9) / var_206_12
				local var_206_14 = Vector3.New(-60, -395, -330)

				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10153, var_206_14, var_206_13)
			end

			if arg_203_1.time_ >= var_206_9 + var_206_12 and arg_203_1.time_ < var_206_9 + var_206_12 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_206_15 = 0
			local var_206_16 = 0.9

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[1387].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(424011048)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 36
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011048", "story_v_out_424011.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011048", "story_v_out_424011.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_424011", "424011048", "story_v_out_424011.awb")

						arg_203_1:RecordAudio("424011048", var_206_24)
						arg_203_1:RecordAudio("424011048", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_424011", "424011048", "story_v_out_424011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_424011", "424011048", "story_v_out_424011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play424011049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424011049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play424011050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10153"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10153 == nil then
				arg_207_1.var_.actorSpriteComps10153 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10153 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor2.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor2.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor2.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 0.5, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10153 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10153 = nil
			end

			local var_210_8 = arg_207_1.actors_["10153"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos10153 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10153", 7)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(0, -2000, 0)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10153, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_15 = 0
			local var_210_16 = 0.875

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(424011049)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 35
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_16 or var_210_16 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_16 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_22 and arg_207_1.time_ < var_210_15 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play424011050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424011050
		arg_211_1.duration_ = 1

		local var_211_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play424011051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1094"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1094 == nil then
				arg_211_1.var_.actorSpriteComps1094 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps1094 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 1, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1094 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1094 = nil
			end

			local var_214_8 = arg_211_1.actors_["1094"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos1094 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1094", 2)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "split_1" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(-380, -335, -230)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1094, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_214_15 = 0
			local var_214_16 = 0.075

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[181].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(424011050)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 3
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011050", "story_v_out_424011.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011050", "story_v_out_424011.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_424011", "424011050", "story_v_out_424011.awb")

						arg_211_1:RecordAudio("424011050", var_214_24)
						arg_211_1:RecordAudio("424011050", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_424011", "424011050", "story_v_out_424011.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_424011", "424011050", "story_v_out_424011.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play424011051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424011051
		arg_215_1.duration_ = 8.6

		local var_215_0 = {
			zh = 7.866,
			ja = 8.6
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424011052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10153"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10153 == nil then
				arg_215_1.var_.actorSpriteComps10153 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps10153 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10153 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10153 = nil
			end

			local var_218_8 = arg_215_1.actors_["1094"]
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 and not isNil(var_218_8) and arg_215_1.var_.actorSpriteComps1094 == nil then
				arg_215_1.var_.actorSpriteComps1094 = var_218_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_10 = 0.2

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_10 and not isNil(var_218_8) then
				local var_218_11 = (arg_215_1.time_ - var_218_9) / var_218_10

				if arg_215_1.var_.actorSpriteComps1094 then
					for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_218_5 then
							if arg_215_1.isInRecall_ then
								local var_218_12 = Mathf.Lerp(iter_218_5.color.r, arg_215_1.hightColor2.r, var_218_11)
								local var_218_13 = Mathf.Lerp(iter_218_5.color.g, arg_215_1.hightColor2.g, var_218_11)
								local var_218_14 = Mathf.Lerp(iter_218_5.color.b, arg_215_1.hightColor2.b, var_218_11)

								iter_218_5.color = Color.New(var_218_12, var_218_13, var_218_14)
							else
								local var_218_15 = Mathf.Lerp(iter_218_5.color.r, 0.5, var_218_11)

								iter_218_5.color = Color.New(var_218_15, var_218_15, var_218_15)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_9 + var_218_10 and arg_215_1.time_ < var_218_9 + var_218_10 + arg_218_0 and not isNil(var_218_8) and arg_215_1.var_.actorSpriteComps1094 then
				for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_218_7 then
						if arg_215_1.isInRecall_ then
							iter_218_7.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1094 = nil
			end

			local var_218_16 = arg_215_1.actors_["10153"].transform
			local var_218_17 = 0

			if var_218_17 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.var_.moveOldPos10153 = var_218_16.localPosition
				var_218_16.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10153", 4)

				local var_218_18 = var_218_16.childCount

				for iter_218_8 = 0, var_218_18 - 1 do
					local var_218_19 = var_218_16:GetChild(iter_218_8)

					if var_218_19.name == "split_2" or not string.find(var_218_19.name, "split") then
						var_218_19.gameObject:SetActive(true)
					else
						var_218_19.gameObject:SetActive(false)
					end
				end
			end

			local var_218_20 = 0.001

			if var_218_17 <= arg_215_1.time_ and arg_215_1.time_ < var_218_17 + var_218_20 then
				local var_218_21 = (arg_215_1.time_ - var_218_17) / var_218_20
				local var_218_22 = Vector3.New(400, -395, -330)

				var_218_16.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10153, var_218_22, var_218_21)
			end

			if arg_215_1.time_ >= var_218_17 + var_218_20 and arg_215_1.time_ < var_218_17 + var_218_20 + arg_218_0 then
				var_218_16.localPosition = Vector3.New(400, -395, -330)
			end

			local var_218_23 = 0
			local var_218_24 = 0.75

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_25 = arg_215_1:FormatText(StoryNameCfg[1387].name)

				arg_215_1.leftNameTxt_.text = var_218_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(424011051)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 30
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_24 or var_218_24 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_24 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_23
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011051", "story_v_out_424011.awb") ~= 0 then
					local var_218_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011051", "story_v_out_424011.awb") / 1000

					if var_218_31 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_23
					end

					if var_218_26.prefab_name ~= "" and arg_215_1.actors_[var_218_26.prefab_name] ~= nil then
						local var_218_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_26.prefab_name].transform, "story_v_out_424011", "424011051", "story_v_out_424011.awb")

						arg_215_1:RecordAudio("424011051", var_218_32)
						arg_215_1:RecordAudio("424011051", var_218_32)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_424011", "424011051", "story_v_out_424011.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_424011", "424011051", "story_v_out_424011.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_33 = math.max(var_218_24, arg_215_1.talkMaxDuration)

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_33 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_33

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_33 and arg_215_1.time_ < var_218_23 + var_218_33 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play424011052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424011052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play424011053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10153"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10153 == nil then
				arg_219_1.var_.actorSpriteComps10153 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps10153 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 0.5, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10153 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10153 = nil
			end

			local var_222_8 = arg_219_1.actors_["10153"].transform
			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.var_.moveOldPos10153 = var_222_8.localPosition
				var_222_8.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10153", 7)

				local var_222_10 = var_222_8.childCount

				for iter_222_4 = 0, var_222_10 - 1 do
					local var_222_11 = var_222_8:GetChild(iter_222_4)

					if var_222_11.name == "" or not string.find(var_222_11.name, "split") then
						var_222_11.gameObject:SetActive(true)
					else
						var_222_11.gameObject:SetActive(false)
					end
				end
			end

			local var_222_12 = 0.001

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_12 then
				local var_222_13 = (arg_219_1.time_ - var_222_9) / var_222_12
				local var_222_14 = Vector3.New(0, -2000, 0)

				var_222_8.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10153, var_222_14, var_222_13)
			end

			if arg_219_1.time_ >= var_222_9 + var_222_12 and arg_219_1.time_ < var_222_9 + var_222_12 + arg_222_0 then
				var_222_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_15 = arg_219_1.actors_["1094"].transform
			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.var_.moveOldPos1094 = var_222_15.localPosition
				var_222_15.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1094", 7)

				local var_222_17 = var_222_15.childCount

				for iter_222_5 = 0, var_222_17 - 1 do
					local var_222_18 = var_222_15:GetChild(iter_222_5)

					if var_222_18.name == "" or not string.find(var_222_18.name, "split") then
						var_222_18.gameObject:SetActive(true)
					else
						var_222_18.gameObject:SetActive(false)
					end
				end
			end

			local var_222_19 = 0.001

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_19 then
				local var_222_20 = (arg_219_1.time_ - var_222_16) / var_222_19
				local var_222_21 = Vector3.New(0, -2000, 0)

				var_222_15.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1094, var_222_21, var_222_20)
			end

			if arg_219_1.time_ >= var_222_16 + var_222_19 and arg_219_1.time_ < var_222_16 + var_222_19 + arg_222_0 then
				var_222_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_22 = 0
			local var_222_23 = 0.875

			if var_222_22 < arg_219_1.time_ and arg_219_1.time_ <= var_222_22 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_24 = arg_219_1:GetWordFromCfg(424011052)
				local var_222_25 = arg_219_1:FormatText(var_222_24.content)

				arg_219_1.text_.text = var_222_25

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_26 = 35
				local var_222_27 = utf8.len(var_222_25)
				local var_222_28 = var_222_26 <= 0 and var_222_23 or var_222_23 * (var_222_27 / var_222_26)

				if var_222_28 > 0 and var_222_23 < var_222_28 then
					arg_219_1.talkMaxDuration = var_222_28

					if var_222_28 + var_222_22 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_28 + var_222_22
					end
				end

				arg_219_1.text_.text = var_222_25
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_29 = math.max(var_222_23, arg_219_1.talkMaxDuration)

			if var_222_22 <= arg_219_1.time_ and arg_219_1.time_ < var_222_22 + var_222_29 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_22) / var_222_29

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_22 + var_222_29 and arg_219_1.time_ < var_222_22 + var_222_29 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play424011053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424011053
		arg_223_1.duration_ = 7.83

		local var_223_0 = {
			zh = 7.833,
			ja = 6.6
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play424011054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10153"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10153 == nil then
				arg_223_1.var_.actorSpriteComps10153 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10153 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 1, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10153 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10153 = nil
			end

			local var_226_8 = arg_223_1.actors_["10153"].transform
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.moveOldPos10153 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10153", 2)

				local var_226_10 = var_226_8.childCount

				for iter_226_4 = 0, var_226_10 - 1 do
					local var_226_11 = var_226_8:GetChild(iter_226_4)

					if var_226_11.name == "" or not string.find(var_226_11.name, "split") then
						var_226_11.gameObject:SetActive(true)
					else
						var_226_11.gameObject:SetActive(false)
					end
				end
			end

			local var_226_12 = 0.001

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_12 then
				local var_226_13 = (arg_223_1.time_ - var_226_9) / var_226_12
				local var_226_14 = Vector3.New(-400, -395, -330)

				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10153, var_226_14, var_226_13)
			end

			if arg_223_1.time_ >= var_226_9 + var_226_12 and arg_223_1.time_ < var_226_9 + var_226_12 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_226_15 = 0
			local var_226_16 = 0.9

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[1387].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(424011053)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 36
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011053", "story_v_out_424011.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011053", "story_v_out_424011.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_424011", "424011053", "story_v_out_424011.awb")

						arg_223_1:RecordAudio("424011053", var_226_24)
						arg_223_1:RecordAudio("424011053", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_424011", "424011053", "story_v_out_424011.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_424011", "424011053", "story_v_out_424011.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play424011054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424011054
		arg_227_1.duration_ = 4.8

		local var_227_0 = {
			zh = 3.633,
			ja = 4.8
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play424011055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1094"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1094 == nil then
				arg_227_1.var_.actorSpriteComps1094 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1094 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 1, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1094 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1094 = nil
			end

			local var_230_8 = arg_227_1.actors_["10153"]
			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps10153 == nil then
				arg_227_1.var_.actorSpriteComps10153 = var_230_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_10 = 0.2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 and not isNil(var_230_8) then
				local var_230_11 = (arg_227_1.time_ - var_230_9) / var_230_10

				if arg_227_1.var_.actorSpriteComps10153 then
					for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_230_5 then
							if arg_227_1.isInRecall_ then
								local var_230_12 = Mathf.Lerp(iter_230_5.color.r, arg_227_1.hightColor2.r, var_230_11)
								local var_230_13 = Mathf.Lerp(iter_230_5.color.g, arg_227_1.hightColor2.g, var_230_11)
								local var_230_14 = Mathf.Lerp(iter_230_5.color.b, arg_227_1.hightColor2.b, var_230_11)

								iter_230_5.color = Color.New(var_230_12, var_230_13, var_230_14)
							else
								local var_230_15 = Mathf.Lerp(iter_230_5.color.r, 0.5, var_230_11)

								iter_230_5.color = Color.New(var_230_15, var_230_15, var_230_15)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps10153 then
				for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_230_7 then
						if arg_227_1.isInRecall_ then
							iter_230_7.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10153 = nil
			end

			local var_230_16 = arg_227_1.actors_["1094"].transform
			local var_230_17 = 0

			if var_230_17 < arg_227_1.time_ and arg_227_1.time_ <= var_230_17 + arg_230_0 then
				arg_227_1.var_.moveOldPos1094 = var_230_16.localPosition
				var_230_16.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1094", 4)

				local var_230_18 = var_230_16.childCount

				for iter_230_8 = 0, var_230_18 - 1 do
					local var_230_19 = var_230_16:GetChild(iter_230_8)

					if var_230_19.name == "split_5" or not string.find(var_230_19.name, "split") then
						var_230_19.gameObject:SetActive(true)
					else
						var_230_19.gameObject:SetActive(false)
					end
				end
			end

			local var_230_20 = 0.001

			if var_230_17 <= arg_227_1.time_ and arg_227_1.time_ < var_230_17 + var_230_20 then
				local var_230_21 = (arg_227_1.time_ - var_230_17) / var_230_20
				local var_230_22 = Vector3.New(470, -335, -230)

				var_230_16.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1094, var_230_22, var_230_21)
			end

			if arg_227_1.time_ >= var_230_17 + var_230_20 and arg_227_1.time_ < var_230_17 + var_230_20 + arg_230_0 then
				var_230_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_230_23 = 0
			local var_230_24 = 0.225

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_25 = arg_227_1:FormatText(StoryNameCfg[181].name)

				arg_227_1.leftNameTxt_.text = var_230_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_26 = arg_227_1:GetWordFromCfg(424011054)
				local var_230_27 = arg_227_1:FormatText(var_230_26.content)

				arg_227_1.text_.text = var_230_27

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_28 = 9
				local var_230_29 = utf8.len(var_230_27)
				local var_230_30 = var_230_28 <= 0 and var_230_24 or var_230_24 * (var_230_29 / var_230_28)

				if var_230_30 > 0 and var_230_24 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30

					if var_230_30 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_23
					end
				end

				arg_227_1.text_.text = var_230_27
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011054", "story_v_out_424011.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011054", "story_v_out_424011.awb") / 1000

					if var_230_31 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_23
					end

					if var_230_26.prefab_name ~= "" and arg_227_1.actors_[var_230_26.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_26.prefab_name].transform, "story_v_out_424011", "424011054", "story_v_out_424011.awb")

						arg_227_1:RecordAudio("424011054", var_230_32)
						arg_227_1:RecordAudio("424011054", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424011", "424011054", "story_v_out_424011.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424011", "424011054", "story_v_out_424011.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_24, arg_227_1.talkMaxDuration)

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_23) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_23 + var_230_33 and arg_227_1.time_ < var_230_23 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play424011055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 424011055
		arg_231_1.duration_ = 10.8

		local var_231_0 = {
			zh = 10.8,
			ja = 9.866
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play424011056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10153"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10153 == nil then
				arg_231_1.var_.actorSpriteComps10153 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10153 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 1, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10153 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10153 = nil
			end

			local var_234_8 = arg_231_1.actors_["1094"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1094 == nil then
				arg_231_1.var_.actorSpriteComps1094 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1094 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								local var_234_12 = Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, var_234_11)
								local var_234_13 = Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, var_234_11)
								local var_234_14 = Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, var_234_11)

								iter_234_5.color = Color.New(var_234_12, var_234_13, var_234_14)
							else
								local var_234_15 = Mathf.Lerp(iter_234_5.color.r, 0.5, var_234_11)

								iter_234_5.color = Color.New(var_234_15, var_234_15, var_234_15)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1094 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1094 = nil
			end

			local var_234_16 = arg_231_1.actors_["10153"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos10153 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10153", 2)

				local var_234_18 = var_234_16.childCount

				for iter_234_8 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_8)

					if var_234_19.name == "split_1" or not string.find(var_234_19.name, "split") then
						var_234_19.gameObject:SetActive(true)
					else
						var_234_19.gameObject:SetActive(false)
					end
				end
			end

			local var_234_20 = 0.001

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-400, -395, -330)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10153, var_234_22, var_234_21)
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_234_23 = 0
			local var_234_24 = 0.85

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[1387].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(424011055)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 34
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_24 or var_234_24 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_24 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011055", "story_v_out_424011.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011055", "story_v_out_424011.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_424011", "424011055", "story_v_out_424011.awb")

						arg_231_1:RecordAudio("424011055", var_234_32)
						arg_231_1:RecordAudio("424011055", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_424011", "424011055", "story_v_out_424011.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_424011", "424011055", "story_v_out_424011.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_33 and arg_231_1.time_ < var_234_23 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play424011056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 424011056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play424011057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10153"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10153 == nil then
				arg_235_1.var_.actorSpriteComps10153 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10153 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10153 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10153 = nil
			end

			local var_238_8 = arg_235_1.actors_["10153"].transform
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.var_.moveOldPos10153 = var_238_8.localPosition
				var_238_8.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10153", 7)

				local var_238_10 = var_238_8.childCount

				for iter_238_4 = 0, var_238_10 - 1 do
					local var_238_11 = var_238_8:GetChild(iter_238_4)

					if var_238_11.name == "" or not string.find(var_238_11.name, "split") then
						var_238_11.gameObject:SetActive(true)
					else
						var_238_11.gameObject:SetActive(false)
					end
				end
			end

			local var_238_12 = 0.001

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_12 then
				local var_238_13 = (arg_235_1.time_ - var_238_9) / var_238_12
				local var_238_14 = Vector3.New(0, -2000, 0)

				var_238_8.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10153, var_238_14, var_238_13)
			end

			if arg_235_1.time_ >= var_238_9 + var_238_12 and arg_235_1.time_ < var_238_9 + var_238_12 + arg_238_0 then
				var_238_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_238_15 = arg_235_1.actors_["1094"].transform
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.var_.moveOldPos1094 = var_238_15.localPosition
				var_238_15.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1094", 7)

				local var_238_17 = var_238_15.childCount

				for iter_238_5 = 0, var_238_17 - 1 do
					local var_238_18 = var_238_15:GetChild(iter_238_5)

					if var_238_18.name == "" or not string.find(var_238_18.name, "split") then
						var_238_18.gameObject:SetActive(true)
					else
						var_238_18.gameObject:SetActive(false)
					end
				end
			end

			local var_238_19 = 0.001

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_19 then
				local var_238_20 = (arg_235_1.time_ - var_238_16) / var_238_19
				local var_238_21 = Vector3.New(0, -2000, 0)

				var_238_15.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1094, var_238_21, var_238_20)
			end

			if arg_235_1.time_ >= var_238_16 + var_238_19 and arg_235_1.time_ < var_238_16 + var_238_19 + arg_238_0 then
				var_238_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_238_22 = 0
			local var_238_23 = 1.325

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(424011056)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 53
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_23 or var_238_23 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_23 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_22 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_22
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_29 = math.max(var_238_23, arg_235_1.talkMaxDuration)

			if var_238_22 <= arg_235_1.time_ and arg_235_1.time_ < var_238_22 + var_238_29 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_22) / var_238_29

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_22 + var_238_29 and arg_235_1.time_ < var_238_22 + var_238_29 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play424011057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424011057
		arg_239_1.duration_ = 5.43

		local var_239_0 = {
			zh = 5.433,
			ja = 4.8
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play424011058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1094"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 == nil then
				arg_239_1.var_.actorSpriteComps1094 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps1094 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 1, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1094 = nil
			end

			local var_242_8 = arg_239_1.actors_["1094"].transform
			local var_242_9 = 0

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.var_.moveOldPos1094 = var_242_8.localPosition
				var_242_8.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1094", 4)

				local var_242_10 = var_242_8.childCount

				for iter_242_4 = 0, var_242_10 - 1 do
					local var_242_11 = var_242_8:GetChild(iter_242_4)

					if var_242_11.name == "split_4" then
						var_242_11:SetAsLastSibling()
						var_242_11.gameObject:SetActive(true)

						arg_239_1.var_.actorSpriteSplit1094 = var_242_11.gameObject:GetComponent(typeof(Image))

						arg_239_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_242_12 = 0.001

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_12 then
				local var_242_13 = (arg_239_1.time_ - var_242_9) / var_242_12
				local var_242_14 = Vector3.New(470, -335, -230)

				var_242_8.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1094, var_242_14, var_242_13)

				if arg_239_1.var_.actorSpriteSplit1094 ~= nil then
					arg_239_1.var_.actorSpriteSplit1094:SetAlpha(var_242_13)
				end
			end

			if arg_239_1.time_ >= var_242_9 + var_242_12 and arg_239_1.time_ < var_242_9 + var_242_12 + arg_242_0 then
				var_242_8.localPosition = Vector3.New(470, -335, -230)

				if arg_239_1.var_.actorSpriteSplit1094 ~= nil then
					arg_239_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_242_15 = 0
			local var_242_16 = 0.475

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[181].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(424011057)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 19
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011057", "story_v_out_424011.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011057", "story_v_out_424011.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_424011", "424011057", "story_v_out_424011.awb")

						arg_239_1:RecordAudio("424011057", var_242_24)
						arg_239_1:RecordAudio("424011057", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_424011", "424011057", "story_v_out_424011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_424011", "424011057", "story_v_out_424011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play424011058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424011058
		arg_243_1.duration_ = 7.53

		local var_243_0 = {
			zh = 6.433,
			ja = 7.533
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424011059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10153"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10153 == nil then
				arg_243_1.var_.actorSpriteComps10153 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10153 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 1, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10153 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10153 = nil
			end

			local var_246_8 = arg_243_1.actors_["1094"]
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1094 == nil then
				arg_243_1.var_.actorSpriteComps1094 = var_246_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_10 = 0.2

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 and not isNil(var_246_8) then
				local var_246_11 = (arg_243_1.time_ - var_246_9) / var_246_10

				if arg_243_1.var_.actorSpriteComps1094 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								local var_246_12 = Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor2.r, var_246_11)
								local var_246_13 = Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor2.g, var_246_11)
								local var_246_14 = Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor2.b, var_246_11)

								iter_246_5.color = Color.New(var_246_12, var_246_13, var_246_14)
							else
								local var_246_15 = Mathf.Lerp(iter_246_5.color.r, 0.5, var_246_11)

								iter_246_5.color = Color.New(var_246_15, var_246_15, var_246_15)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1094 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_246_7 then
						if arg_243_1.isInRecall_ then
							iter_246_7.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1094 = nil
			end

			local var_246_16 = arg_243_1.actors_["10153"].transform
			local var_246_17 = 0

			if var_246_17 < arg_243_1.time_ and arg_243_1.time_ <= var_246_17 + arg_246_0 then
				arg_243_1.var_.moveOldPos10153 = var_246_16.localPosition
				var_246_16.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10153", 2)

				local var_246_18 = var_246_16.childCount

				for iter_246_8 = 0, var_246_18 - 1 do
					local var_246_19 = var_246_16:GetChild(iter_246_8)

					if var_246_19.name == "split_5" then
						var_246_19:SetAsLastSibling()
						var_246_19.gameObject:SetActive(true)

						arg_243_1.var_.actorSpriteSplit10153 = var_246_19.gameObject:GetComponent(typeof(Image))

						arg_243_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_246_20 = 0.001

			if var_246_17 <= arg_243_1.time_ and arg_243_1.time_ < var_246_17 + var_246_20 then
				local var_246_21 = (arg_243_1.time_ - var_246_17) / var_246_20
				local var_246_22 = Vector3.New(-400, -395, -330)

				var_246_16.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10153, var_246_22, var_246_21)

				if arg_243_1.var_.actorSpriteSplit10153 ~= nil then
					arg_243_1.var_.actorSpriteSplit10153:SetAlpha(var_246_21)
				end
			end

			if arg_243_1.time_ >= var_246_17 + var_246_20 and arg_243_1.time_ < var_246_17 + var_246_20 + arg_246_0 then
				var_246_16.localPosition = Vector3.New(-400, -395, -330)

				if arg_243_1.var_.actorSpriteSplit10153 ~= nil then
					arg_243_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_246_23 = 0
			local var_246_24 = 0.55

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_25 = arg_243_1:FormatText(StoryNameCfg[1387].name)

				arg_243_1.leftNameTxt_.text = var_246_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_26 = arg_243_1:GetWordFromCfg(424011058)
				local var_246_27 = arg_243_1:FormatText(var_246_26.content)

				arg_243_1.text_.text = var_246_27

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_28 = 22
				local var_246_29 = utf8.len(var_246_27)
				local var_246_30 = var_246_28 <= 0 and var_246_24 or var_246_24 * (var_246_29 / var_246_28)

				if var_246_30 > 0 and var_246_24 < var_246_30 then
					arg_243_1.talkMaxDuration = var_246_30

					if var_246_30 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_30 + var_246_23
					end
				end

				arg_243_1.text_.text = var_246_27
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011058", "story_v_out_424011.awb") ~= 0 then
					local var_246_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011058", "story_v_out_424011.awb") / 1000

					if var_246_31 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_31 + var_246_23
					end

					if var_246_26.prefab_name ~= "" and arg_243_1.actors_[var_246_26.prefab_name] ~= nil then
						local var_246_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_26.prefab_name].transform, "story_v_out_424011", "424011058", "story_v_out_424011.awb")

						arg_243_1:RecordAudio("424011058", var_246_32)
						arg_243_1:RecordAudio("424011058", var_246_32)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_424011", "424011058", "story_v_out_424011.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_424011", "424011058", "story_v_out_424011.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_33 = math.max(var_246_24, arg_243_1.talkMaxDuration)

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_33 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_23) / var_246_33

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_23 + var_246_33 and arg_243_1.time_ < var_246_23 + var_246_33 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play424011059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424011059
		arg_247_1.duration_ = 9.07

		local var_247_0 = {
			zh = 5.566,
			ja = 9.066
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play424011060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1094"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1094 == nil then
				arg_247_1.var_.actorSpriteComps1094 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps1094 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 1, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1094 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1094 = nil
			end

			local var_250_8 = arg_247_1.actors_["10153"]
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10153 == nil then
				arg_247_1.var_.actorSpriteComps10153 = var_250_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_10 = 0.2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 and not isNil(var_250_8) then
				local var_250_11 = (arg_247_1.time_ - var_250_9) / var_250_10

				if arg_247_1.var_.actorSpriteComps10153 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								local var_250_12 = Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, var_250_11)
								local var_250_13 = Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, var_250_11)
								local var_250_14 = Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, var_250_11)

								iter_250_5.color = Color.New(var_250_12, var_250_13, var_250_14)
							else
								local var_250_15 = Mathf.Lerp(iter_250_5.color.r, 0.5, var_250_11)

								iter_250_5.color = Color.New(var_250_15, var_250_15, var_250_15)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10153 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10153 = nil
			end

			local var_250_16 = arg_247_1.actors_["1094"].transform
			local var_250_17 = 0

			if var_250_17 < arg_247_1.time_ and arg_247_1.time_ <= var_250_17 + arg_250_0 then
				arg_247_1.var_.moveOldPos1094 = var_250_16.localPosition
				var_250_16.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1094", 4)

				local var_250_18 = var_250_16.childCount

				for iter_250_8 = 0, var_250_18 - 1 do
					local var_250_19 = var_250_16:GetChild(iter_250_8)

					if var_250_19.name == "" then
						var_250_19:SetAsLastSibling()
						var_250_19.gameObject:SetActive(true)

						arg_247_1.var_.actorSpriteSplit1094 = var_250_19.gameObject:GetComponent(typeof(Image))

						arg_247_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_250_20 = 0.5

			if var_250_17 <= arg_247_1.time_ and arg_247_1.time_ < var_250_17 + var_250_20 then
				local var_250_21 = (arg_247_1.time_ - var_250_17) / var_250_20
				local var_250_22 = Vector3.New(470, -335, -230)

				var_250_16.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1094, var_250_22, var_250_21)

				if arg_247_1.var_.actorSpriteSplit1094 ~= nil then
					arg_247_1.var_.actorSpriteSplit1094:SetAlpha(var_250_21)
				end
			end

			if arg_247_1.time_ >= var_250_17 + var_250_20 and arg_247_1.time_ < var_250_17 + var_250_20 + arg_250_0 then
				var_250_16.localPosition = Vector3.New(470, -335, -230)

				if arg_247_1.var_.actorSpriteSplit1094 ~= nil then
					arg_247_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_250_23 = 0
			local var_250_24 = 0.475

			if var_250_23 < arg_247_1.time_ and arg_247_1.time_ <= var_250_23 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_25 = arg_247_1:FormatText(StoryNameCfg[181].name)

				arg_247_1.leftNameTxt_.text = var_250_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_26 = arg_247_1:GetWordFromCfg(424011059)
				local var_250_27 = arg_247_1:FormatText(var_250_26.content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_28 = 19
				local var_250_29 = utf8.len(var_250_27)
				local var_250_30 = var_250_28 <= 0 and var_250_24 or var_250_24 * (var_250_29 / var_250_28)

				if var_250_30 > 0 and var_250_24 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30

					if var_250_30 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_23
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011059", "story_v_out_424011.awb") ~= 0 then
					local var_250_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011059", "story_v_out_424011.awb") / 1000

					if var_250_31 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_31 + var_250_23
					end

					if var_250_26.prefab_name ~= "" and arg_247_1.actors_[var_250_26.prefab_name] ~= nil then
						local var_250_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_26.prefab_name].transform, "story_v_out_424011", "424011059", "story_v_out_424011.awb")

						arg_247_1:RecordAudio("424011059", var_250_32)
						arg_247_1:RecordAudio("424011059", var_250_32)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_424011", "424011059", "story_v_out_424011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_424011", "424011059", "story_v_out_424011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_33 = math.max(var_250_24, arg_247_1.talkMaxDuration)

			if var_250_23 <= arg_247_1.time_ and arg_247_1.time_ < var_250_23 + var_250_33 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_23) / var_250_33

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_23 + var_250_33 and arg_247_1.time_ < var_250_23 + var_250_33 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play424011060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424011060
		arg_251_1.duration_ = 7.7

		local var_251_0 = {
			zh = 6.6,
			ja = 7.7
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play424011061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10153"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 == nil then
				arg_251_1.var_.actorSpriteComps10153 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10153 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 1, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10153 = nil
			end

			local var_254_8 = arg_251_1.actors_["1094"]
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1094 == nil then
				arg_251_1.var_.actorSpriteComps1094 = var_254_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_10 = 0.2

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_10 and not isNil(var_254_8) then
				local var_254_11 = (arg_251_1.time_ - var_254_9) / var_254_10

				if arg_251_1.var_.actorSpriteComps1094 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								local var_254_12 = Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor2.r, var_254_11)
								local var_254_13 = Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor2.g, var_254_11)
								local var_254_14 = Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor2.b, var_254_11)

								iter_254_5.color = Color.New(var_254_12, var_254_13, var_254_14)
							else
								local var_254_15 = Mathf.Lerp(iter_254_5.color.r, 0.5, var_254_11)

								iter_254_5.color = Color.New(var_254_15, var_254_15, var_254_15)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_10 and arg_251_1.time_ < var_254_9 + var_254_10 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1094 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_254_7 then
						if arg_251_1.isInRecall_ then
							iter_254_7.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1094 = nil
			end

			local var_254_16 = arg_251_1.actors_["10153"].transform
			local var_254_17 = 0

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.var_.moveOldPos10153 = var_254_16.localPosition
				var_254_16.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10153", 2)

				local var_254_18 = var_254_16.childCount

				for iter_254_8 = 0, var_254_18 - 1 do
					local var_254_19 = var_254_16:GetChild(iter_254_8)

					if var_254_19.name == "split_1" then
						var_254_19:SetAsLastSibling()
						var_254_19.gameObject:SetActive(true)

						arg_251_1.var_.actorSpriteSplit10153 = var_254_19.gameObject:GetComponent(typeof(Image))

						arg_251_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_254_20 = 0.5

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_20 then
				local var_254_21 = (arg_251_1.time_ - var_254_17) / var_254_20
				local var_254_22 = Vector3.New(-400, -395, -330)

				var_254_16.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10153, var_254_22, var_254_21)

				if arg_251_1.var_.actorSpriteSplit10153 ~= nil then
					arg_251_1.var_.actorSpriteSplit10153:SetAlpha(var_254_21)
				end
			end

			if arg_251_1.time_ >= var_254_17 + var_254_20 and arg_251_1.time_ < var_254_17 + var_254_20 + arg_254_0 then
				var_254_16.localPosition = Vector3.New(-400, -395, -330)

				if arg_251_1.var_.actorSpriteSplit10153 ~= nil then
					arg_251_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_254_23 = 0
			local var_254_24 = 0.7

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[1387].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_26 = arg_251_1:GetWordFromCfg(424011060)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 28
				local var_254_29 = utf8.len(var_254_27)
				local var_254_30 = var_254_28 <= 0 and var_254_24 or var_254_24 * (var_254_29 / var_254_28)

				if var_254_30 > 0 and var_254_24 < var_254_30 then
					arg_251_1.talkMaxDuration = var_254_30

					if var_254_30 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_23
					end
				end

				arg_251_1.text_.text = var_254_27
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011060", "story_v_out_424011.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011060", "story_v_out_424011.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_424011", "424011060", "story_v_out_424011.awb")

						arg_251_1:RecordAudio("424011060", var_254_32)
						arg_251_1:RecordAudio("424011060", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424011", "424011060", "story_v_out_424011.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424011", "424011060", "story_v_out_424011.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_33 = math.max(var_254_24, arg_251_1.talkMaxDuration)

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_33 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_23) / var_254_33

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_23 + var_254_33 and arg_251_1.time_ < var_254_23 + var_254_33 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play424011061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424011061
		arg_255_1.duration_ = 4.4

		local var_255_0 = {
			zh = 3.766,
			ja = 4.4
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play424011062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.3

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1387].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(424011061)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 12
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011061", "story_v_out_424011.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011061", "story_v_out_424011.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_424011", "424011061", "story_v_out_424011.awb")

						arg_255_1:RecordAudio("424011061", var_258_9)
						arg_255_1:RecordAudio("424011061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424011", "424011061", "story_v_out_424011.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424011", "424011061", "story_v_out_424011.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play424011062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424011062
		arg_259_1.duration_ = 1.57

		local var_259_0 = {
			zh = 1.166,
			ja = 1.566
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play424011063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1094"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 == nil then
				arg_259_1.var_.actorSpriteComps1094 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1094 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 1, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1094 = nil
			end

			local var_262_8 = arg_259_1.actors_["10153"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10153 == nil then
				arg_259_1.var_.actorSpriteComps10153 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps10153 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								local var_262_12 = Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor2.r, var_262_11)
								local var_262_13 = Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor2.g, var_262_11)
								local var_262_14 = Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor2.b, var_262_11)

								iter_262_5.color = Color.New(var_262_12, var_262_13, var_262_14)
							else
								local var_262_15 = Mathf.Lerp(iter_262_5.color.r, 0.5, var_262_11)

								iter_262_5.color = Color.New(var_262_15, var_262_15, var_262_15)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10153 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10153 = nil
			end

			local var_262_16 = arg_259_1.actors_["1094"].transform
			local var_262_17 = 0

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 then
				arg_259_1.var_.moveOldPos1094 = var_262_16.localPosition
				var_262_16.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1094", 4)

				local var_262_18 = var_262_16.childCount

				for iter_262_8 = 0, var_262_18 - 1 do
					local var_262_19 = var_262_16:GetChild(iter_262_8)

					if var_262_19.name == "split_4" then
						var_262_19:SetAsLastSibling()
						var_262_19.gameObject:SetActive(true)

						arg_259_1.var_.actorSpriteSplit1094 = var_262_19.gameObject:GetComponent(typeof(Image))

						arg_259_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_262_20 = 0.5

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_20 then
				local var_262_21 = (arg_259_1.time_ - var_262_17) / var_262_20
				local var_262_22 = Vector3.New(470, -335, -230)

				var_262_16.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1094, var_262_22, var_262_21)

				if arg_259_1.var_.actorSpriteSplit1094 ~= nil then
					arg_259_1.var_.actorSpriteSplit1094:SetAlpha(var_262_21)
				end
			end

			if arg_259_1.time_ >= var_262_17 + var_262_20 and arg_259_1.time_ < var_262_17 + var_262_20 + arg_262_0 then
				var_262_16.localPosition = Vector3.New(470, -335, -230)

				if arg_259_1.var_.actorSpriteSplit1094 ~= nil then
					arg_259_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_262_23 = 0
			local var_262_24 = 0.1

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_25 = arg_259_1:FormatText(StoryNameCfg[181].name)

				arg_259_1.leftNameTxt_.text = var_262_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_26 = arg_259_1:GetWordFromCfg(424011062)
				local var_262_27 = arg_259_1:FormatText(var_262_26.content)

				arg_259_1.text_.text = var_262_27

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_28 = 4
				local var_262_29 = utf8.len(var_262_27)
				local var_262_30 = var_262_28 <= 0 and var_262_24 or var_262_24 * (var_262_29 / var_262_28)

				if var_262_30 > 0 and var_262_24 < var_262_30 then
					arg_259_1.talkMaxDuration = var_262_30

					if var_262_30 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_30 + var_262_23
					end
				end

				arg_259_1.text_.text = var_262_27
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011062", "story_v_out_424011.awb") ~= 0 then
					local var_262_31 = manager.audio:GetVoiceLength("story_v_out_424011", "424011062", "story_v_out_424011.awb") / 1000

					if var_262_31 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_31 + var_262_23
					end

					if var_262_26.prefab_name ~= "" and arg_259_1.actors_[var_262_26.prefab_name] ~= nil then
						local var_262_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_26.prefab_name].transform, "story_v_out_424011", "424011062", "story_v_out_424011.awb")

						arg_259_1:RecordAudio("424011062", var_262_32)
						arg_259_1:RecordAudio("424011062", var_262_32)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_424011", "424011062", "story_v_out_424011.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_424011", "424011062", "story_v_out_424011.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_33 = math.max(var_262_24, arg_259_1.talkMaxDuration)

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_33 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_23) / var_262_33

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_23 + var_262_33 and arg_259_1.time_ < var_262_23 + var_262_33 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play424011063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424011063
		arg_263_1.duration_ = 19.03

		local var_263_0 = {
			zh = 13.5,
			ja = 19.033
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424011064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10153"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10153 == nil then
				arg_263_1.var_.actorSpriteComps10153 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10153 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10153 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10153 = nil
			end

			local var_266_8 = arg_263_1.actors_["1094"]
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps1094 == nil then
				arg_263_1.var_.actorSpriteComps1094 = var_266_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_10 = 0.2

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 and not isNil(var_266_8) then
				local var_266_11 = (arg_263_1.time_ - var_266_9) / var_266_10

				if arg_263_1.var_.actorSpriteComps1094 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								local var_266_12 = Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, var_266_11)
								local var_266_13 = Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, var_266_11)
								local var_266_14 = Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, var_266_11)

								iter_266_5.color = Color.New(var_266_12, var_266_13, var_266_14)
							else
								local var_266_15 = Mathf.Lerp(iter_266_5.color.r, 0.5, var_266_11)

								iter_266_5.color = Color.New(var_266_15, var_266_15, var_266_15)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps1094 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_266_7 then
						if arg_263_1.isInRecall_ then
							iter_266_7.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1094 = nil
			end

			local var_266_16 = 0
			local var_266_17 = 1.225

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_18 = arg_263_1:FormatText(StoryNameCfg[1387].name)

				arg_263_1.leftNameTxt_.text = var_266_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_19 = arg_263_1:GetWordFromCfg(424011063)
				local var_266_20 = arg_263_1:FormatText(var_266_19.content)

				arg_263_1.text_.text = var_266_20

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_21 = 49
				local var_266_22 = utf8.len(var_266_20)
				local var_266_23 = var_266_21 <= 0 and var_266_17 or var_266_17 * (var_266_22 / var_266_21)

				if var_266_23 > 0 and var_266_17 < var_266_23 then
					arg_263_1.talkMaxDuration = var_266_23

					if var_266_23 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_16
					end
				end

				arg_263_1.text_.text = var_266_20
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011063", "story_v_out_424011.awb") ~= 0 then
					local var_266_24 = manager.audio:GetVoiceLength("story_v_out_424011", "424011063", "story_v_out_424011.awb") / 1000

					if var_266_24 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_24 + var_266_16
					end

					if var_266_19.prefab_name ~= "" and arg_263_1.actors_[var_266_19.prefab_name] ~= nil then
						local var_266_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_19.prefab_name].transform, "story_v_out_424011", "424011063", "story_v_out_424011.awb")

						arg_263_1:RecordAudio("424011063", var_266_25)
						arg_263_1:RecordAudio("424011063", var_266_25)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_424011", "424011063", "story_v_out_424011.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_424011", "424011063", "story_v_out_424011.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_26 = math.max(var_266_17, arg_263_1.talkMaxDuration)

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_26 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_16) / var_266_26

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_16 + var_266_26 and arg_263_1.time_ < var_266_16 + var_266_26 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play424011064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424011064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play424011065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10153"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 == nil then
				arg_267_1.var_.actorSpriteComps10153 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10153 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 0.5, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10153 = nil
			end

			local var_270_8 = arg_267_1.actors_["10153"].transform
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.var_.moveOldPos10153 = var_270_8.localPosition
				var_270_8.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10153", 7)

				local var_270_10 = var_270_8.childCount

				for iter_270_4 = 0, var_270_10 - 1 do
					local var_270_11 = var_270_8:GetChild(iter_270_4)

					if var_270_11.name == "" or not string.find(var_270_11.name, "split") then
						var_270_11.gameObject:SetActive(true)
					else
						var_270_11.gameObject:SetActive(false)
					end
				end
			end

			local var_270_12 = 0.001

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_9) / var_270_12
				local var_270_14 = Vector3.New(0, -2000, 0)

				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10153, var_270_14, var_270_13)
			end

			if arg_267_1.time_ >= var_270_9 + var_270_12 and arg_267_1.time_ < var_270_9 + var_270_12 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_15 = arg_267_1.actors_["1094"].transform
			local var_270_16 = 0

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				arg_267_1.var_.moveOldPos1094 = var_270_15.localPosition
				var_270_15.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1094", 7)

				local var_270_17 = var_270_15.childCount

				for iter_270_5 = 0, var_270_17 - 1 do
					local var_270_18 = var_270_15:GetChild(iter_270_5)

					if var_270_18.name == "" or not string.find(var_270_18.name, "split") then
						var_270_18.gameObject:SetActive(true)
					else
						var_270_18.gameObject:SetActive(false)
					end
				end
			end

			local var_270_19 = 0.001

			if var_270_16 <= arg_267_1.time_ and arg_267_1.time_ < var_270_16 + var_270_19 then
				local var_270_20 = (arg_267_1.time_ - var_270_16) / var_270_19
				local var_270_21 = Vector3.New(0, -2000, 0)

				var_270_15.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1094, var_270_21, var_270_20)
			end

			if arg_267_1.time_ >= var_270_16 + var_270_19 and arg_267_1.time_ < var_270_16 + var_270_19 + arg_270_0 then
				var_270_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_22 = 0
			local var_270_23 = 0.95

			if var_270_22 < arg_267_1.time_ and arg_267_1.time_ <= var_270_22 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_24 = arg_267_1:GetWordFromCfg(424011064)
				local var_270_25 = arg_267_1:FormatText(var_270_24.content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_26 = 38
				local var_270_27 = utf8.len(var_270_25)
				local var_270_28 = var_270_26 <= 0 and var_270_23 or var_270_23 * (var_270_27 / var_270_26)

				if var_270_28 > 0 and var_270_23 < var_270_28 then
					arg_267_1.talkMaxDuration = var_270_28

					if var_270_28 + var_270_22 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_28 + var_270_22
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_29 = math.max(var_270_23, arg_267_1.talkMaxDuration)

			if var_270_22 <= arg_267_1.time_ and arg_267_1.time_ < var_270_22 + var_270_29 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_22) / var_270_29

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_22 + var_270_29 and arg_267_1.time_ < var_270_22 + var_270_29 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play424011065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424011065
		arg_271_1.duration_ = 6.77

		local var_271_0 = {
			zh = 6.766,
			ja = 5.966
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424011066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10153"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 == nil then
				arg_271_1.var_.actorSpriteComps10153 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10153 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 1, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10153 = nil
			end

			local var_274_8 = arg_271_1.actors_["10153"].transform
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.var_.moveOldPos10153 = var_274_8.localPosition
				var_274_8.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10153", 3)

				local var_274_10 = var_274_8.childCount

				for iter_274_4 = 0, var_274_10 - 1 do
					local var_274_11 = var_274_8:GetChild(iter_274_4)

					if var_274_11.name == "split_2" then
						var_274_11:SetAsLastSibling()
						var_274_11.gameObject:SetActive(true)

						arg_271_1.var_.actorSpriteSplit10153 = var_274_11.gameObject:GetComponent(typeof(Image))

						arg_271_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_274_12 = 0.001

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_12 then
				local var_274_13 = (arg_271_1.time_ - var_274_9) / var_274_12
				local var_274_14 = Vector3.New(-60, -395, -330)

				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10153, var_274_14, var_274_13)

				if arg_271_1.var_.actorSpriteSplit10153 ~= nil then
					arg_271_1.var_.actorSpriteSplit10153:SetAlpha(var_274_13)
				end
			end

			if arg_271_1.time_ >= var_274_9 + var_274_12 and arg_271_1.time_ < var_274_9 + var_274_12 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(-60, -395, -330)

				if arg_271_1.var_.actorSpriteSplit10153 ~= nil then
					arg_271_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_274_15 = 0
			local var_274_16 = 0.675

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[1387].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(424011065)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 27
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011065", "story_v_out_424011.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011065", "story_v_out_424011.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_424011", "424011065", "story_v_out_424011.awb")

						arg_271_1:RecordAudio("424011065", var_274_24)
						arg_271_1:RecordAudio("424011065", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_424011", "424011065", "story_v_out_424011.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_424011", "424011065", "story_v_out_424011.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play424011066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424011066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play424011067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10153"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10153 == nil then
				arg_275_1.var_.actorSpriteComps10153 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10153 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 0.5, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10153 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10153 = nil
			end

			local var_278_8 = arg_275_1.actors_["10153"].transform
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.var_.moveOldPos10153 = var_278_8.localPosition
				var_278_8.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10153", 7)

				local var_278_10 = var_278_8.childCount

				for iter_278_4 = 0, var_278_10 - 1 do
					local var_278_11 = var_278_8:GetChild(iter_278_4)

					if var_278_11.name == "" or not string.find(var_278_11.name, "split") then
						var_278_11.gameObject:SetActive(true)
					else
						var_278_11.gameObject:SetActive(false)
					end
				end
			end

			local var_278_12 = 0.001

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_12 then
				local var_278_13 = (arg_275_1.time_ - var_278_9) / var_278_12
				local var_278_14 = Vector3.New(0, -2000, 0)

				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10153, var_278_14, var_278_13)
			end

			if arg_275_1.time_ >= var_278_9 + var_278_12 and arg_275_1.time_ < var_278_9 + var_278_12 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_278_15 = 0
			local var_278_16 = 1.175

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_17 = arg_275_1:GetWordFromCfg(424011066)
				local var_278_18 = arg_275_1:FormatText(var_278_17.content)

				arg_275_1.text_.text = var_278_18

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_19 = 47
				local var_278_20 = utf8.len(var_278_18)
				local var_278_21 = var_278_19 <= 0 and var_278_16 or var_278_16 * (var_278_20 / var_278_19)

				if var_278_21 > 0 and var_278_16 < var_278_21 then
					arg_275_1.talkMaxDuration = var_278_21

					if var_278_21 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_21 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_18
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_22 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_22 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_22

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_22 and arg_275_1.time_ < var_278_15 + var_278_22 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play424011067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424011067
		arg_279_1.duration_ = 7.17

		local var_279_0 = {
			zh = 7.166,
			ja = 6.833
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play424011068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = "B13e"

			if arg_279_1.bgs_[var_282_0] == nil then
				local var_282_1 = Object.Instantiate(arg_279_1.paintGo_)

				var_282_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_282_0)
				var_282_1.name = var_282_0
				var_282_1.transform.parent = arg_279_1.stage_.transform
				var_282_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.bgs_[var_282_0] = var_282_1
			end

			local var_282_2 = 2

			if var_282_2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				local var_282_3 = manager.ui.mainCamera.transform.localPosition
				local var_282_4 = Vector3.New(0, 0, 10) + Vector3.New(var_282_3.x, var_282_3.y, 0)
				local var_282_5 = arg_279_1.bgs_.B13e

				var_282_5.transform.localPosition = var_282_4
				var_282_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_6 = var_282_5:GetComponent("SpriteRenderer")

				if var_282_6 and var_282_6.sprite then
					local var_282_7 = (var_282_5.transform.localPosition - var_282_3).z
					local var_282_8 = manager.ui.mainCameraCom_
					local var_282_9 = 2 * var_282_7 * Mathf.Tan(var_282_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_282_10 = var_282_9 * var_282_8.aspect
					local var_282_11 = var_282_6.sprite.bounds.size.x
					local var_282_12 = var_282_6.sprite.bounds.size.y
					local var_282_13 = var_282_10 / var_282_11
					local var_282_14 = var_282_9 / var_282_12
					local var_282_15 = var_282_14 < var_282_13 and var_282_13 or var_282_14

					var_282_5.transform.localScale = Vector3.New(var_282_15, var_282_15, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "B13e" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_16 = 3.999999999999

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			local var_282_17 = 0.3

			if arg_279_1.time_ >= var_282_16 + var_282_17 and arg_279_1.time_ < var_282_16 + var_282_17 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end

			local var_282_18 = 0

			if var_282_18 < arg_279_1.time_ and arg_279_1.time_ <= var_282_18 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_19 = 2

			if var_282_18 <= arg_279_1.time_ and arg_279_1.time_ < var_282_18 + var_282_19 then
				local var_282_20 = (arg_279_1.time_ - var_282_18) / var_282_19
				local var_282_21 = Color.New(0, 0, 0)

				var_282_21.a = Mathf.Lerp(0, 1, var_282_20)
				arg_279_1.mask_.color = var_282_21
			end

			if arg_279_1.time_ >= var_282_18 + var_282_19 and arg_279_1.time_ < var_282_18 + var_282_19 + arg_282_0 then
				local var_282_22 = Color.New(0, 0, 0)

				var_282_22.a = 1
				arg_279_1.mask_.color = var_282_22
			end

			local var_282_23 = 2

			if var_282_23 < arg_279_1.time_ and arg_279_1.time_ <= var_282_23 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_24 = 2

			if var_282_23 <= arg_279_1.time_ and arg_279_1.time_ < var_282_23 + var_282_24 then
				local var_282_25 = (arg_279_1.time_ - var_282_23) / var_282_24
				local var_282_26 = Color.New(0, 0, 0)

				var_282_26.a = Mathf.Lerp(1, 0, var_282_25)
				arg_279_1.mask_.color = var_282_26
			end

			if arg_279_1.time_ >= var_282_23 + var_282_24 and arg_279_1.time_ < var_282_23 + var_282_24 + arg_282_0 then
				local var_282_27 = Color.New(0, 0, 0)
				local var_282_28 = 0

				arg_279_1.mask_.enabled = false
				var_282_27.a = var_282_28
				arg_279_1.mask_.color = var_282_27
			end

			local var_282_29 = manager.ui.mainCamera.transform
			local var_282_30 = 1.86666666666667

			if var_282_30 < arg_279_1.time_ and arg_279_1.time_ <= var_282_30 + arg_282_0 then
				local var_282_31 = arg_279_1.var_.effect46hailazhengyan1
				local var_282_32
				local var_282_33 = var_282_29

				if not var_282_31 then
					var_282_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_282_33)
					var_282_31.name = "46hailazhengyan1"
					arg_279_1.var_.effect46hailazhengyan1 = var_282_31
				else
					var_282_31.transform:SetParent(var_282_33)
				end

				var_282_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_282_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_282_34 = manager.ui.mainCamera.transform
			local var_282_35 = 4.3

			if var_282_35 < arg_279_1.time_ and arg_279_1.time_ <= var_282_35 + arg_282_0 then
				local var_282_36 = arg_279_1.var_.effect46hailazhengyan1

				if var_282_36 then
					Object.Destroy(var_282_36)

					arg_279_1.var_.effect46hailazhengyan1 = nil
				end
			end

			local var_282_37 = 0.166666666666667
			local var_282_38 = 0.3

			if var_282_37 < arg_279_1.time_ and arg_279_1.time_ <= var_282_37 + arg_282_0 then
				local var_282_39 = "play"
				local var_282_40 = "music"

				arg_279_1:AudioAction(var_282_39, var_282_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_282_41 = ""
				local var_282_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_282_42 ~= "" then
					if arg_279_1.bgmTxt_.text ~= var_282_42 and arg_279_1.bgmTxt_.text ~= "" then
						if arg_279_1.bgmTxt2_.text ~= "" then
							arg_279_1.bgmTxt_.text = arg_279_1.bgmTxt2_.text
						end

						arg_279_1.bgmTxt2_.text = var_282_42

						arg_279_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_279_1.bgmTxt_.text = var_282_42
						arg_279_1.bgmTxt2_.text = var_282_42
					end

					if arg_279_1.bgmTimer then
						arg_279_1.bgmTimer:Stop()

						arg_279_1.bgmTimer = nil
					end

					if arg_279_1.settingData.show_music_name == 1 then
						arg_279_1.musicController:SetSelectedState("show")
						arg_279_1.musicAnimator_:Play("open", 0, 0)

						if arg_279_1.settingData.music_time ~= 0 then
							arg_279_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_279_1.settingData.music_time), function()
								if arg_279_1 == nil or isNil(arg_279_1.bgmTxt_) then
									return
								end

								arg_279_1.musicController:SetSelectedState("hide")
								arg_279_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_282_43 = 0.133333333333333
			local var_282_44 = 1

			if var_282_43 < arg_279_1.time_ and arg_279_1.time_ <= var_282_43 + arg_282_0 then
				local var_282_45 = "stop"
				local var_282_46 = "effect"

				arg_279_1:AudioAction(var_282_45, var_282_46, "se_story_146", "se_story_146_wind", "")
			end

			local var_282_47 = 1.86666666666667
			local var_282_48 = 1

			if var_282_47 < arg_279_1.time_ and arg_279_1.time_ <= var_282_47 + arg_282_0 then
				local var_282_49 = "play"
				local var_282_50 = "effect"

				arg_279_1:AudioAction(var_282_49, var_282_50, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_282_51 = 1.86666666666667
			local var_282_52 = 1

			if var_282_51 < arg_279_1.time_ and arg_279_1.time_ <= var_282_51 + arg_282_0 then
				local var_282_53 = "play"
				local var_282_54 = "effect"

				arg_279_1:AudioAction(var_282_53, var_282_54, "se_story_141", "se_story_141_amb_rooftop", "")
			end

			local var_282_55 = 0.133333333333333
			local var_282_56 = 1

			if var_282_55 < arg_279_1.time_ and arg_279_1.time_ <= var_282_55 + arg_282_0 then
				local var_282_57 = "stop"
				local var_282_58 = "effect"

				arg_279_1:AudioAction(var_282_57, var_282_58, "se_story_side_1095", "se_story_side_1095_amb_fountain_night", "")
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_59 = 4
			local var_282_60 = 0.3

			if var_282_59 < arg_279_1.time_ and arg_279_1.time_ <= var_282_59 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_61 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_61:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_279_1.dialogCg_.alpha = arg_284_0
				end))
				var_282_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_62 = arg_279_1:FormatText(StoryNameCfg[177].name)

				arg_279_1.leftNameTxt_.text = var_282_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_63 = arg_279_1:GetWordFromCfg(424011067)
				local var_282_64 = arg_279_1:FormatText(var_282_63.content)

				arg_279_1.text_.text = var_282_64

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_65 = 12
				local var_282_66 = utf8.len(var_282_64)
				local var_282_67 = var_282_65 <= 0 and var_282_60 or var_282_60 * (var_282_66 / var_282_65)

				if var_282_67 > 0 and var_282_60 < var_282_67 then
					arg_279_1.talkMaxDuration = var_282_67
					var_282_59 = var_282_59 + 0.3

					if var_282_67 + var_282_59 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_67 + var_282_59
					end
				end

				arg_279_1.text_.text = var_282_64
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011067", "story_v_out_424011.awb") ~= 0 then
					local var_282_68 = manager.audio:GetVoiceLength("story_v_out_424011", "424011067", "story_v_out_424011.awb") / 1000

					if var_282_68 + var_282_59 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_68 + var_282_59
					end

					if var_282_63.prefab_name ~= "" and arg_279_1.actors_[var_282_63.prefab_name] ~= nil then
						local var_282_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_63.prefab_name].transform, "story_v_out_424011", "424011067", "story_v_out_424011.awb")

						arg_279_1:RecordAudio("424011067", var_282_69)
						arg_279_1:RecordAudio("424011067", var_282_69)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_424011", "424011067", "story_v_out_424011.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_424011", "424011067", "story_v_out_424011.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_70 = var_282_59 + 0.3
			local var_282_71 = math.max(var_282_60, arg_279_1.talkMaxDuration)

			if var_282_70 <= arg_279_1.time_ and arg_279_1.time_ < var_282_70 + var_282_71 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_70) / var_282_71

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_70 + var_282_71 and arg_279_1.time_ < var_282_70 + var_282_71 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play424011068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 424011068
		arg_286_1.duration_ = 3.63

		local var_286_0 = {
			zh = 3.533,
			ja = 3.633
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
				arg_286_0:Play424011069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.3

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_2 = "play"
				local var_289_3 = "music"

				arg_286_1:AudioAction(var_289_2, var_289_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_289_4 = ""
				local var_289_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_289_5 ~= "" then
					if arg_286_1.bgmTxt_.text ~= var_289_5 and arg_286_1.bgmTxt_.text ~= "" then
						if arg_286_1.bgmTxt2_.text ~= "" then
							arg_286_1.bgmTxt_.text = arg_286_1.bgmTxt2_.text
						end

						arg_286_1.bgmTxt2_.text = var_289_5

						arg_286_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_286_1.bgmTxt_.text = var_289_5
						arg_286_1.bgmTxt2_.text = var_289_5
					end

					if arg_286_1.bgmTimer then
						arg_286_1.bgmTimer:Stop()

						arg_286_1.bgmTimer = nil
					end

					if arg_286_1.settingData.show_music_name == 1 then
						arg_286_1.musicController:SetSelectedState("show")
						arg_286_1.musicAnimator_:Play("open", 0, 0)

						if arg_286_1.settingData.music_time ~= 0 then
							arg_286_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_286_1.settingData.music_time), function()
								if arg_286_1 == nil or isNil(arg_286_1.bgmTxt_) then
									return
								end

								arg_286_1.musicController:SetSelectedState("hide")
								arg_286_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_289_6 = 0.3
			local var_289_7 = 1

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				local var_289_8 = "play"
				local var_289_9 = "music"

				arg_286_1:AudioAction(var_289_8, var_289_9, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_289_10 = ""
				local var_289_11 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_289_11 ~= "" then
					if arg_286_1.bgmTxt_.text ~= var_289_11 and arg_286_1.bgmTxt_.text ~= "" then
						if arg_286_1.bgmTxt2_.text ~= "" then
							arg_286_1.bgmTxt_.text = arg_286_1.bgmTxt2_.text
						end

						arg_286_1.bgmTxt2_.text = var_289_11

						arg_286_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_286_1.bgmTxt_.text = var_289_11
						arg_286_1.bgmTxt2_.text = var_289_11
					end

					if arg_286_1.bgmTimer then
						arg_286_1.bgmTimer:Stop()

						arg_286_1.bgmTimer = nil
					end

					if arg_286_1.settingData.show_music_name == 1 then
						arg_286_1.musicController:SetSelectedState("show")
						arg_286_1.musicAnimator_:Play("open", 0, 0)

						if arg_286_1.settingData.music_time ~= 0 then
							arg_286_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_286_1.settingData.music_time), function()
								if arg_286_1 == nil or isNil(arg_286_1.bgmTxt_) then
									return
								end

								arg_286_1.musicController:SetSelectedState("hide")
								arg_286_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_289_12 = 0
			local var_289_13 = 0.45

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_14 = arg_286_1:FormatText(StoryNameCfg[177].name)

				arg_286_1.leftNameTxt_.text = var_289_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_15 = arg_286_1:GetWordFromCfg(424011068)
				local var_289_16 = arg_286_1:FormatText(var_289_15.content)

				arg_286_1.text_.text = var_289_16

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_17 = 18
				local var_289_18 = utf8.len(var_289_16)
				local var_289_19 = var_289_17 <= 0 and var_289_13 or var_289_13 * (var_289_18 / var_289_17)

				if var_289_19 > 0 and var_289_13 < var_289_19 then
					arg_286_1.talkMaxDuration = var_289_19

					if var_289_19 + var_289_12 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_19 + var_289_12
					end
				end

				arg_286_1.text_.text = var_289_16
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011068", "story_v_out_424011.awb") ~= 0 then
					local var_289_20 = manager.audio:GetVoiceLength("story_v_out_424011", "424011068", "story_v_out_424011.awb") / 1000

					if var_289_20 + var_289_12 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_20 + var_289_12
					end

					if var_289_15.prefab_name ~= "" and arg_286_1.actors_[var_289_15.prefab_name] ~= nil then
						local var_289_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_15.prefab_name].transform, "story_v_out_424011", "424011068", "story_v_out_424011.awb")

						arg_286_1:RecordAudio("424011068", var_289_21)
						arg_286_1:RecordAudio("424011068", var_289_21)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_424011", "424011068", "story_v_out_424011.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_424011", "424011068", "story_v_out_424011.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_22 = math.max(var_289_13, arg_286_1.talkMaxDuration)

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_22 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_12) / var_289_22

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_12 + var_289_22 and arg_286_1.time_ < var_289_12 + var_289_22 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play424011069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 424011069
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play424011070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.7

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(424011069)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 28
				local var_295_5 = utf8.len(var_295_3)
				local var_295_6 = var_295_4 <= 0 and var_295_1 or var_295_1 * (var_295_5 / var_295_4)

				if var_295_6 > 0 and var_295_1 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_7 and arg_292_1.time_ < var_295_0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play424011070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 424011070
		arg_296_1.duration_ = 5.3

		local var_296_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play424011071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.425

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[177].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_3 = arg_296_1:GetWordFromCfg(424011070)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 17
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011070", "story_v_out_424011.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011070", "story_v_out_424011.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_out_424011", "424011070", "story_v_out_424011.awb")

						arg_296_1:RecordAudio("424011070", var_299_9)
						arg_296_1:RecordAudio("424011070", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_424011", "424011070", "story_v_out_424011.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_424011", "424011070", "story_v_out_424011.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play424011071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 424011071
		arg_300_1.duration_ = 1.3

		local var_300_0 = {
			zh = 1.133,
			ja = 1.3
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play424011072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1094"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps1094 == nil then
				arg_300_1.var_.actorSpriteComps1094 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps1094 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor1.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor1.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor1.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 1, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps1094 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_303_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps1094 = nil
			end

			local var_303_8 = arg_300_1.actors_["1094"].transform
			local var_303_9 = 0

			if var_303_9 < arg_300_1.time_ and arg_300_1.time_ <= var_303_9 + arg_303_0 then
				arg_300_1.var_.moveOldPos1094 = var_303_8.localPosition
				var_303_8.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("1094", 3)

				local var_303_10 = var_303_8.childCount

				for iter_303_4 = 0, var_303_10 - 1 do
					local var_303_11 = var_303_8:GetChild(iter_303_4)

					if var_303_11.name == "" or not string.find(var_303_11.name, "split") then
						var_303_11.gameObject:SetActive(true)
					else
						var_303_11.gameObject:SetActive(false)
					end
				end
			end

			local var_303_12 = 0.001

			if var_303_9 <= arg_300_1.time_ and arg_300_1.time_ < var_303_9 + var_303_12 then
				local var_303_13 = (arg_300_1.time_ - var_303_9) / var_303_12
				local var_303_14 = Vector3.New(0, -335, -230)

				var_303_8.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1094, var_303_14, var_303_13)
			end

			if arg_300_1.time_ >= var_303_9 + var_303_12 and arg_300_1.time_ < var_303_9 + var_303_12 + arg_303_0 then
				var_303_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_303_15 = arg_300_1.actors_["1094"]
			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				local var_303_17 = var_303_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_303_17 then
					arg_300_1.var_.alphaOldValue1094 = var_303_17.alpha
					arg_300_1.var_.characterEffect1094 = var_303_17
				end

				arg_300_1.var_.alphaOldValue1094 = 0
			end

			local var_303_18 = 0.5

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_18 then
				local var_303_19 = (arg_300_1.time_ - var_303_16) / var_303_18
				local var_303_20 = Mathf.Lerp(arg_300_1.var_.alphaOldValue1094, 1, var_303_19)

				if arg_300_1.var_.characterEffect1094 then
					arg_300_1.var_.characterEffect1094.alpha = var_303_20
				end
			end

			if arg_300_1.time_ >= var_303_16 + var_303_18 and arg_300_1.time_ < var_303_16 + var_303_18 + arg_303_0 and arg_300_1.var_.characterEffect1094 then
				arg_300_1.var_.characterEffect1094.alpha = 1
			end

			local var_303_21 = 0
			local var_303_22 = 0.125

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_23 = arg_300_1:FormatText(StoryNameCfg[181].name)

				arg_300_1.leftNameTxt_.text = var_303_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_24 = arg_300_1:GetWordFromCfg(424011071)
				local var_303_25 = arg_300_1:FormatText(var_303_24.content)

				arg_300_1.text_.text = var_303_25

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_26 = 5
				local var_303_27 = utf8.len(var_303_25)
				local var_303_28 = var_303_26 <= 0 and var_303_22 or var_303_22 * (var_303_27 / var_303_26)

				if var_303_28 > 0 and var_303_22 < var_303_28 then
					arg_300_1.talkMaxDuration = var_303_28

					if var_303_28 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_21
					end
				end

				arg_300_1.text_.text = var_303_25
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011071", "story_v_out_424011.awb") ~= 0 then
					local var_303_29 = manager.audio:GetVoiceLength("story_v_out_424011", "424011071", "story_v_out_424011.awb") / 1000

					if var_303_29 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_29 + var_303_21
					end

					if var_303_24.prefab_name ~= "" and arg_300_1.actors_[var_303_24.prefab_name] ~= nil then
						local var_303_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_24.prefab_name].transform, "story_v_out_424011", "424011071", "story_v_out_424011.awb")

						arg_300_1:RecordAudio("424011071", var_303_30)
						arg_300_1:RecordAudio("424011071", var_303_30)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_424011", "424011071", "story_v_out_424011.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_424011", "424011071", "story_v_out_424011.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_31 = math.max(var_303_22, arg_300_1.talkMaxDuration)

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_31 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_21) / var_303_31

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_21 + var_303_31 and arg_300_1.time_ < var_303_21 + var_303_31 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play424011072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 424011072
		arg_304_1.duration_ = 8

		local var_304_0 = {
			zh = 6.366,
			ja = 8
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play424011073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1094"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps1094 == nil then
				arg_304_1.var_.actorSpriteComps1094 = var_307_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_2 = 0.2

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.actorSpriteComps1094 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								local var_307_4 = Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor2.r, var_307_3)
								local var_307_5 = Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor2.g, var_307_3)
								local var_307_6 = Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor2.b, var_307_3)

								iter_307_1.color = Color.New(var_307_4, var_307_5, var_307_6)
							else
								local var_307_7 = Mathf.Lerp(iter_307_1.color.r, 0.5, var_307_3)

								iter_307_1.color = Color.New(var_307_7, var_307_7, var_307_7)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps1094 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_307_3 then
						if arg_304_1.isInRecall_ then
							iter_307_3.color = arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_307_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_304_1.var_.actorSpriteComps1094 = nil
			end

			local var_307_8 = 0
			local var_307_9 = 0.9

			if var_307_8 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_10 = arg_304_1:FormatText(StoryNameCfg[177].name)

				arg_304_1.leftNameTxt_.text = var_307_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_11 = arg_304_1:GetWordFromCfg(424011072)
				local var_307_12 = arg_304_1:FormatText(var_307_11.content)

				arg_304_1.text_.text = var_307_12

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_13 = 36
				local var_307_14 = utf8.len(var_307_12)
				local var_307_15 = var_307_13 <= 0 and var_307_9 or var_307_9 * (var_307_14 / var_307_13)

				if var_307_15 > 0 and var_307_9 < var_307_15 then
					arg_304_1.talkMaxDuration = var_307_15

					if var_307_15 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_8
					end
				end

				arg_304_1.text_.text = var_307_12
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011072", "story_v_out_424011.awb") ~= 0 then
					local var_307_16 = manager.audio:GetVoiceLength("story_v_out_424011", "424011072", "story_v_out_424011.awb") / 1000

					if var_307_16 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_16 + var_307_8
					end

					if var_307_11.prefab_name ~= "" and arg_304_1.actors_[var_307_11.prefab_name] ~= nil then
						local var_307_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_11.prefab_name].transform, "story_v_out_424011", "424011072", "story_v_out_424011.awb")

						arg_304_1:RecordAudio("424011072", var_307_17)
						arg_304_1:RecordAudio("424011072", var_307_17)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_424011", "424011072", "story_v_out_424011.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_424011", "424011072", "story_v_out_424011.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_18 = math.max(var_307_9, arg_304_1.talkMaxDuration)

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_18 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_8) / var_307_18

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_8 + var_307_18 and arg_304_1.time_ < var_307_8 + var_307_18 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play424011073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 424011073
		arg_308_1.duration_ = 2.7

		local var_308_0 = {
			zh = 2.633,
			ja = 2.7
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play424011074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1094"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1094 == nil then
				arg_308_1.var_.actorSpriteComps1094 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps1094 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1094 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps1094 = nil
			end

			local var_311_8 = arg_308_1.actors_["1094"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos1094 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1094", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_4" then
						var_311_11:SetAsLastSibling()
						var_311_11.gameObject:SetActive(true)

						arg_308_1.var_.actorSpriteSplit1094 = var_311_11.gameObject:GetComponent(typeof(Image))

						arg_308_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_311_12 = 0.5

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(0, -335, -230)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1094, var_311_14, var_311_13)

				if arg_308_1.var_.actorSpriteSplit1094 ~= nil then
					arg_308_1.var_.actorSpriteSplit1094:SetAlpha(var_311_13)
				end
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(0, -335, -230)

				if arg_308_1.var_.actorSpriteSplit1094 ~= nil then
					arg_308_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_311_15 = 0
			local var_311_16 = 0.2

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[181].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(424011073)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 8
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011073", "story_v_out_424011.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011073", "story_v_out_424011.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_424011", "424011073", "story_v_out_424011.awb")

						arg_308_1:RecordAudio("424011073", var_311_24)
						arg_308_1:RecordAudio("424011073", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_424011", "424011073", "story_v_out_424011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_424011", "424011073", "story_v_out_424011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play424011074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 424011074
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play424011075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1094"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1094 == nil then
				arg_312_1.var_.actorSpriteComps1094 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1094 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 0.5, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1094 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1094 = nil
			end

			local var_315_8 = arg_312_1.actors_["1094"].transform
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.var_.moveOldPos1094 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1094", 7)

				local var_315_10 = var_315_8.childCount

				for iter_315_4 = 0, var_315_10 - 1 do
					local var_315_11 = var_315_8:GetChild(iter_315_4)

					if var_315_11.name == "" or not string.find(var_315_11.name, "split") then
						var_315_11.gameObject:SetActive(true)
					else
						var_315_11.gameObject:SetActive(false)
					end
				end
			end

			local var_315_12 = 0.001

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_9) / var_315_12
				local var_315_14 = Vector3.New(0, -2000, 0)

				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1094, var_315_14, var_315_13)
			end

			if arg_312_1.time_ >= var_315_9 + var_315_12 and arg_312_1.time_ < var_315_9 + var_315_12 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_15 = 0
			local var_315_16 = 1

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				local var_315_17 = "play"
				local var_315_18 = "effect"

				arg_312_1:AudioAction(var_315_17, var_315_18, "se_story_121_04", "se_story_121_04_jump", "")
			end

			local var_315_19 = 0
			local var_315_20 = 0.775

			if var_315_19 < arg_312_1.time_ and arg_312_1.time_ <= var_315_19 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_21 = arg_312_1:GetWordFromCfg(424011074)
				local var_315_22 = arg_312_1:FormatText(var_315_21.content)

				arg_312_1.text_.text = var_315_22

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_23 = 31
				local var_315_24 = utf8.len(var_315_22)
				local var_315_25 = var_315_23 <= 0 and var_315_20 or var_315_20 * (var_315_24 / var_315_23)

				if var_315_25 > 0 and var_315_20 < var_315_25 then
					arg_312_1.talkMaxDuration = var_315_25

					if var_315_25 + var_315_19 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_25 + var_315_19
					end
				end

				arg_312_1.text_.text = var_315_22
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_26 = math.max(var_315_20, arg_312_1.talkMaxDuration)

			if var_315_19 <= arg_312_1.time_ and arg_312_1.time_ < var_315_19 + var_315_26 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_19) / var_315_26

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_19 + var_315_26 and arg_312_1.time_ < var_315_19 + var_315_26 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play424011075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 424011075
		arg_316_1.duration_ = 4.47

		local var_316_0 = {
			zh = 3.7,
			ja = 4.466
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play424011076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1094"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1094 == nil then
				arg_316_1.var_.actorSpriteComps1094 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps1094 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 1, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1094 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1094 = nil
			end

			local var_319_8 = arg_316_1.actors_["1094"].transform
			local var_319_9 = 0

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 then
				arg_316_1.var_.moveOldPos1094 = var_319_8.localPosition
				var_319_8.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("1094", 3)

				local var_319_10 = var_319_8.childCount

				for iter_319_4 = 0, var_319_10 - 1 do
					local var_319_11 = var_319_8:GetChild(iter_319_4)

					if var_319_11.name == "split_1" then
						var_319_11:SetAsLastSibling()
						var_319_11.gameObject:SetActive(true)

						arg_316_1.var_.actorSpriteSplit1094 = var_319_11.gameObject:GetComponent(typeof(Image))

						arg_316_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_319_12 = 0.001

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_12 then
				local var_319_13 = (arg_316_1.time_ - var_319_9) / var_319_12
				local var_319_14 = Vector3.New(0, -335, -230)

				var_319_8.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1094, var_319_14, var_319_13)

				if arg_316_1.var_.actorSpriteSplit1094 ~= nil then
					arg_316_1.var_.actorSpriteSplit1094:SetAlpha(var_319_13)
				end
			end

			if arg_316_1.time_ >= var_319_9 + var_319_12 and arg_316_1.time_ < var_319_9 + var_319_12 + arg_319_0 then
				var_319_8.localPosition = Vector3.New(0, -335, -230)

				if arg_316_1.var_.actorSpriteSplit1094 ~= nil then
					arg_316_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_319_15 = 0
			local var_319_16 = 0.275

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_17 = arg_316_1:FormatText(StoryNameCfg[181].name)

				arg_316_1.leftNameTxt_.text = var_319_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_18 = arg_316_1:GetWordFromCfg(424011075)
				local var_319_19 = arg_316_1:FormatText(var_319_18.content)

				arg_316_1.text_.text = var_319_19

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_20 = 11
				local var_319_21 = utf8.len(var_319_19)
				local var_319_22 = var_319_20 <= 0 and var_319_16 or var_319_16 * (var_319_21 / var_319_20)

				if var_319_22 > 0 and var_319_16 < var_319_22 then
					arg_316_1.talkMaxDuration = var_319_22

					if var_319_22 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_22 + var_319_15
					end
				end

				arg_316_1.text_.text = var_319_19
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011075", "story_v_out_424011.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011075", "story_v_out_424011.awb") / 1000

					if var_319_23 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_15
					end

					if var_319_18.prefab_name ~= "" and arg_316_1.actors_[var_319_18.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_18.prefab_name].transform, "story_v_out_424011", "424011075", "story_v_out_424011.awb")

						arg_316_1:RecordAudio("424011075", var_319_24)
						arg_316_1:RecordAudio("424011075", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_424011", "424011075", "story_v_out_424011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_424011", "424011075", "story_v_out_424011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_25 = math.max(var_319_16, arg_316_1.talkMaxDuration)

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_25 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_15) / var_319_25

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_15 + var_319_25 and arg_316_1.time_ < var_319_15 + var_319_25 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play424011076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 424011076
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play424011077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1094"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps1094 == nil then
				arg_320_1.var_.actorSpriteComps1094 = var_323_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.actorSpriteComps1094 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								local var_323_4 = Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor2.r, var_323_3)
								local var_323_5 = Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor2.g, var_323_3)
								local var_323_6 = Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor2.b, var_323_3)

								iter_323_1.color = Color.New(var_323_4, var_323_5, var_323_6)
							else
								local var_323_7 = Mathf.Lerp(iter_323_1.color.r, 0.5, var_323_3)

								iter_323_1.color = Color.New(var_323_7, var_323_7, var_323_7)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps1094 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_323_3 then
						if arg_320_1.isInRecall_ then
							iter_323_3.color = arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_323_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps1094 = nil
			end

			local var_323_8 = arg_320_1.actors_["1094"].transform
			local var_323_9 = 0

			if var_323_9 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 then
				arg_320_1.var_.moveOldPos1094 = var_323_8.localPosition
				var_323_8.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1094", 7)

				local var_323_10 = var_323_8.childCount

				for iter_323_4 = 0, var_323_10 - 1 do
					local var_323_11 = var_323_8:GetChild(iter_323_4)

					if var_323_11.name == "" or not string.find(var_323_11.name, "split") then
						var_323_11.gameObject:SetActive(true)
					else
						var_323_11.gameObject:SetActive(false)
					end
				end
			end

			local var_323_12 = 0.001

			if var_323_9 <= arg_320_1.time_ and arg_320_1.time_ < var_323_9 + var_323_12 then
				local var_323_13 = (arg_320_1.time_ - var_323_9) / var_323_12
				local var_323_14 = Vector3.New(0, -2000, 0)

				var_323_8.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1094, var_323_14, var_323_13)
			end

			if arg_320_1.time_ >= var_323_9 + var_323_12 and arg_320_1.time_ < var_323_9 + var_323_12 + arg_323_0 then
				var_323_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_15 = 0
			local var_323_16 = 0.85

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_17 = arg_320_1:GetWordFromCfg(424011076)
				local var_323_18 = arg_320_1:FormatText(var_323_17.content)

				arg_320_1.text_.text = var_323_18

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_19 = 34
				local var_323_20 = utf8.len(var_323_18)
				local var_323_21 = var_323_19 <= 0 and var_323_16 or var_323_16 * (var_323_20 / var_323_19)

				if var_323_21 > 0 and var_323_16 < var_323_21 then
					arg_320_1.talkMaxDuration = var_323_21

					if var_323_21 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_21 + var_323_15
					end
				end

				arg_320_1.text_.text = var_323_18
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_22 = math.max(var_323_16, arg_320_1.talkMaxDuration)

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_22 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_15) / var_323_22

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_15 + var_323_22 and arg_320_1.time_ < var_323_15 + var_323_22 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play424011077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 424011077
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play424011078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				local var_327_2 = "play"
				local var_327_3 = "effect"

				arg_324_1:AudioAction(var_327_2, var_327_3, "se_story_145", "se_story_145_footstep03", "")
			end

			local var_327_4 = 0
			local var_327_5 = 0.875

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_6 = arg_324_1:GetWordFromCfg(424011077)
				local var_327_7 = arg_324_1:FormatText(var_327_6.content)

				arg_324_1.text_.text = var_327_7

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_8 = 35
				local var_327_9 = utf8.len(var_327_7)
				local var_327_10 = var_327_8 <= 0 and var_327_5 or var_327_5 * (var_327_9 / var_327_8)

				if var_327_10 > 0 and var_327_5 < var_327_10 then
					arg_324_1.talkMaxDuration = var_327_10

					if var_327_10 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_4
					end
				end

				arg_324_1.text_.text = var_327_7
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_11 = math.max(var_327_5, arg_324_1.talkMaxDuration)

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_11 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_4) / var_327_11

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_4 + var_327_11 and arg_324_1.time_ < var_327_4 + var_327_11 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play424011078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 424011078
		arg_328_1.duration_ = 9

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play424011079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = "ST34"

			if arg_328_1.bgs_[var_331_0] == nil then
				local var_331_1 = Object.Instantiate(arg_328_1.paintGo_)

				var_331_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_331_0)
				var_331_1.name = var_331_0
				var_331_1.transform.parent = arg_328_1.stage_.transform
				var_331_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.bgs_[var_331_0] = var_331_1
			end

			local var_331_2 = 2

			if var_331_2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				local var_331_3 = manager.ui.mainCamera.transform.localPosition
				local var_331_4 = Vector3.New(0, 0, 10) + Vector3.New(var_331_3.x, var_331_3.y, 0)
				local var_331_5 = arg_328_1.bgs_.ST34

				var_331_5.transform.localPosition = var_331_4
				var_331_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_6 = var_331_5:GetComponent("SpriteRenderer")

				if var_331_6 and var_331_6.sprite then
					local var_331_7 = (var_331_5.transform.localPosition - var_331_3).z
					local var_331_8 = manager.ui.mainCameraCom_
					local var_331_9 = 2 * var_331_7 * Mathf.Tan(var_331_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_331_10 = var_331_9 * var_331_8.aspect
					local var_331_11 = var_331_6.sprite.bounds.size.x
					local var_331_12 = var_331_6.sprite.bounds.size.y
					local var_331_13 = var_331_10 / var_331_11
					local var_331_14 = var_331_9 / var_331_12
					local var_331_15 = var_331_14 < var_331_13 and var_331_13 or var_331_14

					var_331_5.transform.localScale = Vector3.New(var_331_15, var_331_15, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "ST34" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_16 = 4

			if var_331_16 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			local var_331_17 = 0.3

			if arg_328_1.time_ >= var_331_16 + var_331_17 and arg_328_1.time_ < var_331_16 + var_331_17 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_18 = 0

			if var_331_18 < arg_328_1.time_ and arg_328_1.time_ <= var_331_18 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_19 = 2

			if var_331_18 <= arg_328_1.time_ and arg_328_1.time_ < var_331_18 + var_331_19 then
				local var_331_20 = (arg_328_1.time_ - var_331_18) / var_331_19
				local var_331_21 = Color.New(0, 0, 0)

				var_331_21.a = Mathf.Lerp(0, 1, var_331_20)
				arg_328_1.mask_.color = var_331_21
			end

			if arg_328_1.time_ >= var_331_18 + var_331_19 and arg_328_1.time_ < var_331_18 + var_331_19 + arg_331_0 then
				local var_331_22 = Color.New(0, 0, 0)

				var_331_22.a = 1
				arg_328_1.mask_.color = var_331_22
			end

			local var_331_23 = 2

			if var_331_23 < arg_328_1.time_ and arg_328_1.time_ <= var_331_23 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_24 = 2

			if var_331_23 <= arg_328_1.time_ and arg_328_1.time_ < var_331_23 + var_331_24 then
				local var_331_25 = (arg_328_1.time_ - var_331_23) / var_331_24
				local var_331_26 = Color.New(0, 0, 0)

				var_331_26.a = Mathf.Lerp(1, 0, var_331_25)
				arg_328_1.mask_.color = var_331_26
			end

			if arg_328_1.time_ >= var_331_23 + var_331_24 and arg_328_1.time_ < var_331_23 + var_331_24 + arg_331_0 then
				local var_331_27 = Color.New(0, 0, 0)
				local var_331_28 = 0

				arg_328_1.mask_.enabled = false
				var_331_27.a = var_331_28
				arg_328_1.mask_.color = var_331_27
			end

			local var_331_29 = 0.133333333333333
			local var_331_30 = 1

			if var_331_29 < arg_328_1.time_ and arg_328_1.time_ <= var_331_29 + arg_331_0 then
				local var_331_31 = "stop"
				local var_331_32 = "effect"

				arg_328_1:AudioAction(var_331_31, var_331_32, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_331_33 = 0.133333333333333
			local var_331_34 = 1

			if var_331_33 < arg_328_1.time_ and arg_328_1.time_ <= var_331_33 + arg_331_0 then
				local var_331_35 = "stop"
				local var_331_36 = "effect"

				arg_328_1:AudioAction(var_331_35, var_331_36, "se_story_141", "se_story_141_amb_rooftop", "")
			end

			local var_331_37 = 1.73333333333333
			local var_331_38 = 1

			if var_331_37 < arg_328_1.time_ and arg_328_1.time_ <= var_331_37 + arg_331_0 then
				local var_331_39 = "play"
				local var_331_40 = "effect"

				arg_328_1:AudioAction(var_331_39, var_331_40, "se_story_143", "se_story_143_amb_lift", "")
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_41 = 4
			local var_331_42 = 0.875

			if var_331_41 < arg_328_1.time_ and arg_328_1.time_ <= var_331_41 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_43 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_43:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_328_1.dialogCg_.alpha = arg_332_0
				end))
				var_331_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_44 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_45 = arg_328_1:GetWordFromCfg(424011078)
				local var_331_46 = arg_328_1:FormatText(var_331_45.content)

				arg_328_1.text_.text = var_331_46

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_47 = 35
				local var_331_48 = utf8.len(var_331_46)
				local var_331_49 = var_331_47 <= 0 and var_331_42 or var_331_42 * (var_331_48 / var_331_47)

				if var_331_49 > 0 and var_331_42 < var_331_49 then
					arg_328_1.talkMaxDuration = var_331_49
					var_331_41 = var_331_41 + 0.3

					if var_331_49 + var_331_41 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_49 + var_331_41
					end
				end

				arg_328_1.text_.text = var_331_46
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_50 = var_331_41 + 0.3
			local var_331_51 = math.max(var_331_42, arg_328_1.talkMaxDuration)

			if var_331_50 <= arg_328_1.time_ and arg_328_1.time_ < var_331_50 + var_331_51 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_50) / var_331_51

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_50 + var_331_51 and arg_328_1.time_ < var_331_50 + var_331_51 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play424011079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 424011079
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play424011080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.999999999999
			local var_337_1 = 1

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				local var_337_2 = "play"
				local var_337_3 = "effect"

				arg_334_1:AudioAction(var_337_2, var_337_3, "se_story_140", "se_story_140_camera_ui01", "")
			end

			local var_337_4 = 0
			local var_337_5 = 1.325

			if var_337_4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_6 = arg_334_1:GetWordFromCfg(424011079)
				local var_337_7 = arg_334_1:FormatText(var_337_6.content)

				arg_334_1.text_.text = var_337_7

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_8 = 53
				local var_337_9 = utf8.len(var_337_7)
				local var_337_10 = var_337_8 <= 0 and var_337_5 or var_337_5 * (var_337_9 / var_337_8)

				if var_337_10 > 0 and var_337_5 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_4
					end
				end

				arg_334_1.text_.text = var_337_7
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_11 = math.max(var_337_5, arg_334_1.talkMaxDuration)

			if var_337_4 <= arg_334_1.time_ and arg_334_1.time_ < var_337_4 + var_337_11 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_4) / var_337_11

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_4 + var_337_11 and arg_334_1.time_ < var_337_4 + var_337_11 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play424011080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 424011080
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play424011081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.133333333333333
			local var_341_1 = 1

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				local var_341_2 = "play"
				local var_341_3 = "effect"

				arg_338_1:AudioAction(var_341_2, var_341_3, "se_story_143", "se_story_143_elevator_door", "")
			end

			local var_341_4 = 0
			local var_341_5 = 0.9

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_6 = arg_338_1:GetWordFromCfg(424011080)
				local var_341_7 = arg_338_1:FormatText(var_341_6.content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_8 = 36
				local var_341_9 = utf8.len(var_341_7)
				local var_341_10 = var_341_8 <= 0 and var_341_5 or var_341_5 * (var_341_9 / var_341_8)

				if var_341_10 > 0 and var_341_5 < var_341_10 then
					arg_338_1.talkMaxDuration = var_341_10

					if var_341_10 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_11 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_11 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_11

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_11 and arg_338_1.time_ < var_341_4 + var_341_11 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play424011081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 424011081
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play424011082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.325

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(424011081)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 13
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_8 and arg_342_1.time_ < var_345_0 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play424011082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 424011082
		arg_346_1.duration_ = 3.13

		local var_346_0 = {
			zh = 2.2,
			ja = 3.133
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play424011083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1094"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1094 == nil then
				arg_346_1.var_.actorSpriteComps1094 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.2

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps1094 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 1, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1094 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_349_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps1094 = nil
			end

			local var_349_8 = arg_346_1.actors_["1094"].transform
			local var_349_9 = 0

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.var_.moveOldPos1094 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1094", 3)

				local var_349_10 = var_349_8.childCount

				for iter_349_4 = 0, var_349_10 - 1 do
					local var_349_11 = var_349_8:GetChild(iter_349_4)

					if var_349_11.name == "" or not string.find(var_349_11.name, "split") then
						var_349_11.gameObject:SetActive(true)
					else
						var_349_11.gameObject:SetActive(false)
					end
				end
			end

			local var_349_12 = 0.001

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_9) / var_349_12
				local var_349_14 = Vector3.New(0, -335, -230)

				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1094, var_349_14, var_349_13)
			end

			if arg_346_1.time_ >= var_349_9 + var_349_12 and arg_346_1.time_ < var_349_9 + var_349_12 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_349_15 = arg_346_1.actors_["1094"]
			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 then
				local var_349_17 = var_349_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_349_17 then
					arg_346_1.var_.alphaOldValue1094 = var_349_17.alpha
					arg_346_1.var_.characterEffect1094 = var_349_17
				end

				arg_346_1.var_.alphaOldValue1094 = 0
			end

			local var_349_18 = 0.5

			if var_349_16 <= arg_346_1.time_ and arg_346_1.time_ < var_349_16 + var_349_18 then
				local var_349_19 = (arg_346_1.time_ - var_349_16) / var_349_18
				local var_349_20 = Mathf.Lerp(arg_346_1.var_.alphaOldValue1094, 1, var_349_19)

				if arg_346_1.var_.characterEffect1094 then
					arg_346_1.var_.characterEffect1094.alpha = var_349_20
				end
			end

			if arg_346_1.time_ >= var_349_16 + var_349_18 and arg_346_1.time_ < var_349_16 + var_349_18 + arg_349_0 and arg_346_1.var_.characterEffect1094 then
				arg_346_1.var_.characterEffect1094.alpha = 1
			end

			local var_349_21 = 0
			local var_349_22 = 0.15

			if var_349_21 < arg_346_1.time_ and arg_346_1.time_ <= var_349_21 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_23 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_23:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_24 = arg_346_1:FormatText(StoryNameCfg[181].name)

				arg_346_1.leftNameTxt_.text = var_349_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_25 = arg_346_1:GetWordFromCfg(424011082)
				local var_349_26 = arg_346_1:FormatText(var_349_25.content)

				arg_346_1.text_.text = var_349_26

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_27 = 6
				local var_349_28 = utf8.len(var_349_26)
				local var_349_29 = var_349_27 <= 0 and var_349_22 or var_349_22 * (var_349_28 / var_349_27)

				if var_349_29 > 0 and var_349_22 < var_349_29 then
					arg_346_1.talkMaxDuration = var_349_29
					var_349_21 = var_349_21 + 0.3

					if var_349_29 + var_349_21 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_29 + var_349_21
					end
				end

				arg_346_1.text_.text = var_349_26
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011082", "story_v_out_424011.awb") ~= 0 then
					local var_349_30 = manager.audio:GetVoiceLength("story_v_out_424011", "424011082", "story_v_out_424011.awb") / 1000

					if var_349_30 + var_349_21 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_30 + var_349_21
					end

					if var_349_25.prefab_name ~= "" and arg_346_1.actors_[var_349_25.prefab_name] ~= nil then
						local var_349_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_25.prefab_name].transform, "story_v_out_424011", "424011082", "story_v_out_424011.awb")

						arg_346_1:RecordAudio("424011082", var_349_31)
						arg_346_1:RecordAudio("424011082", var_349_31)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_424011", "424011082", "story_v_out_424011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_424011", "424011082", "story_v_out_424011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_32 = var_349_21 + 0.3
			local var_349_33 = math.max(var_349_22, arg_346_1.talkMaxDuration)

			if var_349_32 <= arg_346_1.time_ and arg_346_1.time_ < var_349_32 + var_349_33 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_32) / var_349_33

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_32 + var_349_33 and arg_346_1.time_ < var_349_32 + var_349_33 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play424011083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 424011083
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play424011084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1094"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1094 == nil then
				arg_352_1.var_.actorSpriteComps1094 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps1094 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor2.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor2.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor2.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 0.5, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1094 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_355_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps1094 = nil
			end

			local var_355_8 = 0
			local var_355_9 = 0.25

			if var_355_8 < arg_352_1.time_ and arg_352_1.time_ <= var_355_8 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_10 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_11 = arg_352_1:GetWordFromCfg(424011083)
				local var_355_12 = arg_352_1:FormatText(var_355_11.content)

				arg_352_1.text_.text = var_355_12

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_13 = 10
				local var_355_14 = utf8.len(var_355_12)
				local var_355_15 = var_355_13 <= 0 and var_355_9 or var_355_9 * (var_355_14 / var_355_13)

				if var_355_15 > 0 and var_355_9 < var_355_15 then
					arg_352_1.talkMaxDuration = var_355_15

					if var_355_15 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_15 + var_355_8
					end
				end

				arg_352_1.text_.text = var_355_12
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_9, arg_352_1.talkMaxDuration)

			if var_355_8 <= arg_352_1.time_ and arg_352_1.time_ < var_355_8 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_8) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_8 + var_355_16 and arg_352_1.time_ < var_355_8 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play424011084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 424011084
		arg_356_1.duration_ = 6.4

		local var_356_0 = {
			zh = 6.4,
			ja = 5.366
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play424011085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.85

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[177].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(424011084)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 34
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011084", "story_v_out_424011.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011084", "story_v_out_424011.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_424011", "424011084", "story_v_out_424011.awb")

						arg_356_1:RecordAudio("424011084", var_359_9)
						arg_356_1:RecordAudio("424011084", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_424011", "424011084", "story_v_out_424011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_424011", "424011084", "story_v_out_424011.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play424011085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 424011085
		arg_360_1.duration_ = 1

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"

			SetActive(arg_360_1.choicesGo_, true)

			for iter_361_0, iter_361_1 in ipairs(arg_360_1.choices_) do
				local var_361_0 = iter_361_0 <= 2

				SetActive(iter_361_1.go, var_361_0)
			end

			arg_360_1.choices_[1].txt.text = arg_360_1:FormatText(StoryChoiceCfg[1476].name)
			arg_360_1.choices_[2].txt.text = arg_360_1:FormatText(StoryChoiceCfg[1477].name)
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play424011086(arg_360_1)
			end

			if arg_362_0 == 2 then
				arg_360_0:Play424011087(arg_360_1)
			end

			arg_360_1:RecordChoiceLog(424011085, 1476, 1477)
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.allBtn_.enabled = false
			end

			local var_363_1 = 0.5

			if arg_360_1.time_ >= var_363_0 + var_363_1 and arg_360_1.time_ < var_363_0 + var_363_1 + arg_363_0 then
				arg_360_1.allBtn_.enabled = true
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play424011086 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 424011086
		arg_364_1.duration_ = 2.33

		local var_364_0 = {
			zh = 2.333,
			ja = 2.166
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play424011089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.175

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[177].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(424011086)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 7
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011086", "story_v_out_424011.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011086", "story_v_out_424011.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_424011", "424011086", "story_v_out_424011.awb")

						arg_364_1:RecordAudio("424011086", var_367_9)
						arg_364_1:RecordAudio("424011086", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_424011", "424011086", "story_v_out_424011.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_424011", "424011086", "story_v_out_424011.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play424011089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 424011089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play424011090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.45

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(424011089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 18
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play424011090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 424011090
		arg_372_1.duration_ = 4.5

		local var_372_0 = {
			zh = 4.5,
			ja = 4.466
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play424011091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.55

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[177].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(424011090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 22
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011090", "story_v_out_424011.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011090", "story_v_out_424011.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_424011", "424011090", "story_v_out_424011.awb")

						arg_372_1:RecordAudio("424011090", var_375_9)
						arg_372_1:RecordAudio("424011090", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_424011", "424011090", "story_v_out_424011.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_424011", "424011090", "story_v_out_424011.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play424011091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 424011091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play424011092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1094"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1094 = var_379_0.localPosition
				var_379_0.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1094", 7)

				local var_379_2 = var_379_0.childCount

				for iter_379_0 = 0, var_379_2 - 1 do
					local var_379_3 = var_379_0:GetChild(iter_379_0)

					if var_379_3.name == "" or not string.find(var_379_3.name, "split") then
						var_379_3.gameObject:SetActive(true)
					else
						var_379_3.gameObject:SetActive(false)
					end
				end
			end

			local var_379_4 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_4 then
				local var_379_5 = (arg_376_1.time_ - var_379_1) / var_379_4
				local var_379_6 = Vector3.New(0, -2000, 0)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1094, var_379_6, var_379_5)
			end

			if arg_376_1.time_ >= var_379_1 + var_379_4 and arg_376_1.time_ < var_379_1 + var_379_4 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_379_7 = 0
			local var_379_8 = 0.225

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_9 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_10 = arg_376_1:GetWordFromCfg(424011091)
				local var_379_11 = arg_376_1:FormatText(var_379_10.content)

				arg_376_1.text_.text = var_379_11

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_12 = 9
				local var_379_13 = utf8.len(var_379_11)
				local var_379_14 = var_379_12 <= 0 and var_379_8 or var_379_8 * (var_379_13 / var_379_12)

				if var_379_14 > 0 and var_379_8 < var_379_14 then
					arg_376_1.talkMaxDuration = var_379_14

					if var_379_14 + var_379_7 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_7
					end
				end

				arg_376_1.text_.text = var_379_11
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_15 = math.max(var_379_8, arg_376_1.talkMaxDuration)

			if var_379_7 <= arg_376_1.time_ and arg_376_1.time_ < var_379_7 + var_379_15 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_7) / var_379_15

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_7 + var_379_15 and arg_376_1.time_ < var_379_7 + var_379_15 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play424011092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 424011092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play424011093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 1.275

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(424011092)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 51
				local var_383_5 = utf8.len(var_383_3)
				local var_383_6 = var_383_4 <= 0 and var_383_1 or var_383_1 * (var_383_5 / var_383_4)

				if var_383_6 > 0 and var_383_1 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_7 and arg_380_1.time_ < var_383_0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play424011093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 424011093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play424011094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.625

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(424011093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 25
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_8 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_8 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_8

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_8 and arg_384_1.time_ < var_387_0 + var_387_8 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play424011094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 424011094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play424011095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.95

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_2 = arg_388_1:GetWordFromCfg(424011094)
				local var_391_3 = arg_388_1:FormatText(var_391_2.content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 38
				local var_391_5 = utf8.len(var_391_3)
				local var_391_6 = var_391_4 <= 0 and var_391_1 or var_391_1 * (var_391_5 / var_391_4)

				if var_391_6 > 0 and var_391_1 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_7 and arg_388_1.time_ < var_391_0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play424011095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 424011095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play424011096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 1.025

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(424011095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 41
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_8 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_8 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_8

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_8 and arg_392_1.time_ < var_395_0 + var_395_8 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play424011096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 424011096
		arg_396_1.duration_ = 1.23

		local var_396_0 = {
			zh = 1.233,
			ja = 1.2
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play424011097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1094"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps1094 == nil then
				arg_396_1.var_.actorSpriteComps1094 = var_399_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_2 = 0.2

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.actorSpriteComps1094 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								local var_399_4 = Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor1.r, var_399_3)
								local var_399_5 = Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor1.g, var_399_3)
								local var_399_6 = Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor1.b, var_399_3)

								iter_399_1.color = Color.New(var_399_4, var_399_5, var_399_6)
							else
								local var_399_7 = Mathf.Lerp(iter_399_1.color.r, 1, var_399_3)

								iter_399_1.color = Color.New(var_399_7, var_399_7, var_399_7)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps1094 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_399_3 then
						if arg_396_1.isInRecall_ then
							iter_399_3.color = arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_399_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps1094 = nil
			end

			local var_399_8 = arg_396_1.actors_["1094"].transform
			local var_399_9 = 0

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 then
				arg_396_1.var_.moveOldPos1094 = var_399_8.localPosition
				var_399_8.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("1094", 3)

				local var_399_10 = var_399_8.childCount

				for iter_399_4 = 0, var_399_10 - 1 do
					local var_399_11 = var_399_8:GetChild(iter_399_4)

					if var_399_11.name == "split_2" or not string.find(var_399_11.name, "split") then
						var_399_11.gameObject:SetActive(true)
					else
						var_399_11.gameObject:SetActive(false)
					end
				end
			end

			local var_399_12 = 0.001

			if var_399_9 <= arg_396_1.time_ and arg_396_1.time_ < var_399_9 + var_399_12 then
				local var_399_13 = (arg_396_1.time_ - var_399_9) / var_399_12
				local var_399_14 = Vector3.New(0, -335, -230)

				var_399_8.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1094, var_399_14, var_399_13)
			end

			if arg_396_1.time_ >= var_399_9 + var_399_12 and arg_396_1.time_ < var_399_9 + var_399_12 + arg_399_0 then
				var_399_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_399_15 = 0
			local var_399_16 = 0.1

			if var_399_15 < arg_396_1.time_ and arg_396_1.time_ <= var_399_15 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_17 = arg_396_1:FormatText(StoryNameCfg[181].name)

				arg_396_1.leftNameTxt_.text = var_399_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_18 = arg_396_1:GetWordFromCfg(424011096)
				local var_399_19 = arg_396_1:FormatText(var_399_18.content)

				arg_396_1.text_.text = var_399_19

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_20 = 4
				local var_399_21 = utf8.len(var_399_19)
				local var_399_22 = var_399_20 <= 0 and var_399_16 or var_399_16 * (var_399_21 / var_399_20)

				if var_399_22 > 0 and var_399_16 < var_399_22 then
					arg_396_1.talkMaxDuration = var_399_22

					if var_399_22 + var_399_15 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_22 + var_399_15
					end
				end

				arg_396_1.text_.text = var_399_19
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011096", "story_v_out_424011.awb") ~= 0 then
					local var_399_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011096", "story_v_out_424011.awb") / 1000

					if var_399_23 + var_399_15 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_23 + var_399_15
					end

					if var_399_18.prefab_name ~= "" and arg_396_1.actors_[var_399_18.prefab_name] ~= nil then
						local var_399_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_18.prefab_name].transform, "story_v_out_424011", "424011096", "story_v_out_424011.awb")

						arg_396_1:RecordAudio("424011096", var_399_24)
						arg_396_1:RecordAudio("424011096", var_399_24)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_424011", "424011096", "story_v_out_424011.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_424011", "424011096", "story_v_out_424011.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_25 = math.max(var_399_16, arg_396_1.talkMaxDuration)

			if var_399_15 <= arg_396_1.time_ and arg_396_1.time_ < var_399_15 + var_399_25 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_15) / var_399_25

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_15 + var_399_25 and arg_396_1.time_ < var_399_15 + var_399_25 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play424011097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 424011097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play424011098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1094"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.actorSpriteComps1094 == nil then
				arg_400_1.var_.actorSpriteComps1094 = var_403_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_2 = 0.2

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.actorSpriteComps1094 then
					for iter_403_0, iter_403_1 in pairs(arg_400_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_403_1 then
							if arg_400_1.isInRecall_ then
								local var_403_4 = Mathf.Lerp(iter_403_1.color.r, arg_400_1.hightColor2.r, var_403_3)
								local var_403_5 = Mathf.Lerp(iter_403_1.color.g, arg_400_1.hightColor2.g, var_403_3)
								local var_403_6 = Mathf.Lerp(iter_403_1.color.b, arg_400_1.hightColor2.b, var_403_3)

								iter_403_1.color = Color.New(var_403_4, var_403_5, var_403_6)
							else
								local var_403_7 = Mathf.Lerp(iter_403_1.color.r, 0.5, var_403_3)

								iter_403_1.color = Color.New(var_403_7, var_403_7, var_403_7)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.actorSpriteComps1094 then
				for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_403_3 then
						if arg_400_1.isInRecall_ then
							iter_403_3.color = arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_403_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps1094 = nil
			end

			local var_403_8 = 0
			local var_403_9 = 0.4

			if var_403_8 < arg_400_1.time_ and arg_400_1.time_ <= var_403_8 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_10 = arg_400_1:FormatText(StoryNameCfg[7].name)

				arg_400_1.leftNameTxt_.text = var_403_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_11 = arg_400_1:GetWordFromCfg(424011097)
				local var_403_12 = arg_400_1:FormatText(var_403_11.content)

				arg_400_1.text_.text = var_403_12

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_13 = 16
				local var_403_14 = utf8.len(var_403_12)
				local var_403_15 = var_403_13 <= 0 and var_403_9 or var_403_9 * (var_403_14 / var_403_13)

				if var_403_15 > 0 and var_403_9 < var_403_15 then
					arg_400_1.talkMaxDuration = var_403_15

					if var_403_15 + var_403_8 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_15 + var_403_8
					end
				end

				arg_400_1.text_.text = var_403_12
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_16 = math.max(var_403_9, arg_400_1.talkMaxDuration)

			if var_403_8 <= arg_400_1.time_ and arg_400_1.time_ < var_403_8 + var_403_16 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_8) / var_403_16

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_8 + var_403_16 and arg_400_1.time_ < var_403_8 + var_403_16 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play424011098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 424011098
		arg_404_1.duration_ = 6.03

		local var_404_0 = {
			zh = 5.4,
			ja = 6.033
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play424011099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1094"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1094 == nil then
				arg_404_1.var_.actorSpriteComps1094 = var_407_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_2 = 0.2

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.actorSpriteComps1094 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_407_1 then
							if arg_404_1.isInRecall_ then
								local var_407_4 = Mathf.Lerp(iter_407_1.color.r, arg_404_1.hightColor1.r, var_407_3)
								local var_407_5 = Mathf.Lerp(iter_407_1.color.g, arg_404_1.hightColor1.g, var_407_3)
								local var_407_6 = Mathf.Lerp(iter_407_1.color.b, arg_404_1.hightColor1.b, var_407_3)

								iter_407_1.color = Color.New(var_407_4, var_407_5, var_407_6)
							else
								local var_407_7 = Mathf.Lerp(iter_407_1.color.r, 1, var_407_3)

								iter_407_1.color = Color.New(var_407_7, var_407_7, var_407_7)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1094 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_407_3 then
						if arg_404_1.isInRecall_ then
							iter_407_3.color = arg_404_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_407_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps1094 = nil
			end

			local var_407_8 = arg_404_1.actors_["1094"].transform
			local var_407_9 = 0

			if var_407_9 < arg_404_1.time_ and arg_404_1.time_ <= var_407_9 + arg_407_0 then
				arg_404_1.var_.moveOldPos1094 = var_407_8.localPosition
				var_407_8.localScale = Vector3.New(1, 1, 1)

				arg_404_1:CheckSpriteTmpPos("1094", 3)

				local var_407_10 = var_407_8.childCount

				for iter_407_4 = 0, var_407_10 - 1 do
					local var_407_11 = var_407_8:GetChild(iter_407_4)

					if var_407_11.name == "split_1" then
						var_407_11:SetAsLastSibling()
						var_407_11.gameObject:SetActive(true)

						arg_404_1.var_.actorSpriteSplit1094 = var_407_11.gameObject:GetComponent(typeof(Image))

						arg_404_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_407_12 = 0.5

			if var_407_9 <= arg_404_1.time_ and arg_404_1.time_ < var_407_9 + var_407_12 then
				local var_407_13 = (arg_404_1.time_ - var_407_9) / var_407_12
				local var_407_14 = Vector3.New(0, -335, -230)

				var_407_8.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1094, var_407_14, var_407_13)

				if arg_404_1.var_.actorSpriteSplit1094 ~= nil then
					arg_404_1.var_.actorSpriteSplit1094:SetAlpha(var_407_13)
				end
			end

			if arg_404_1.time_ >= var_407_9 + var_407_12 and arg_404_1.time_ < var_407_9 + var_407_12 + arg_407_0 then
				var_407_8.localPosition = Vector3.New(0, -335, -230)

				if arg_404_1.var_.actorSpriteSplit1094 ~= nil then
					arg_404_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_407_15 = 0
			local var_407_16 = 0.375

			if var_407_15 < arg_404_1.time_ and arg_404_1.time_ <= var_407_15 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_17 = arg_404_1:FormatText(StoryNameCfg[181].name)

				arg_404_1.leftNameTxt_.text = var_407_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_18 = arg_404_1:GetWordFromCfg(424011098)
				local var_407_19 = arg_404_1:FormatText(var_407_18.content)

				arg_404_1.text_.text = var_407_19

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_20 = 15
				local var_407_21 = utf8.len(var_407_19)
				local var_407_22 = var_407_20 <= 0 and var_407_16 or var_407_16 * (var_407_21 / var_407_20)

				if var_407_22 > 0 and var_407_16 < var_407_22 then
					arg_404_1.talkMaxDuration = var_407_22

					if var_407_22 + var_407_15 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_22 + var_407_15
					end
				end

				arg_404_1.text_.text = var_407_19
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011098", "story_v_out_424011.awb") ~= 0 then
					local var_407_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011098", "story_v_out_424011.awb") / 1000

					if var_407_23 + var_407_15 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_23 + var_407_15
					end

					if var_407_18.prefab_name ~= "" and arg_404_1.actors_[var_407_18.prefab_name] ~= nil then
						local var_407_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_18.prefab_name].transform, "story_v_out_424011", "424011098", "story_v_out_424011.awb")

						arg_404_1:RecordAudio("424011098", var_407_24)
						arg_404_1:RecordAudio("424011098", var_407_24)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_424011", "424011098", "story_v_out_424011.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_424011", "424011098", "story_v_out_424011.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_25 = math.max(var_407_16, arg_404_1.talkMaxDuration)

			if var_407_15 <= arg_404_1.time_ and arg_404_1.time_ < var_407_15 + var_407_25 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_15) / var_407_25

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_15 + var_407_25 and arg_404_1.time_ < var_407_15 + var_407_25 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play424011099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 424011099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play424011100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1094"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.actorSpriteComps1094 == nil then
				arg_408_1.var_.actorSpriteComps1094 = var_411_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_2 = 0.2

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.actorSpriteComps1094 then
					for iter_411_0, iter_411_1 in pairs(arg_408_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_411_1 then
							if arg_408_1.isInRecall_ then
								local var_411_4 = Mathf.Lerp(iter_411_1.color.r, arg_408_1.hightColor2.r, var_411_3)
								local var_411_5 = Mathf.Lerp(iter_411_1.color.g, arg_408_1.hightColor2.g, var_411_3)
								local var_411_6 = Mathf.Lerp(iter_411_1.color.b, arg_408_1.hightColor2.b, var_411_3)

								iter_411_1.color = Color.New(var_411_4, var_411_5, var_411_6)
							else
								local var_411_7 = Mathf.Lerp(iter_411_1.color.r, 0.5, var_411_3)

								iter_411_1.color = Color.New(var_411_7, var_411_7, var_411_7)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.actorSpriteComps1094 then
				for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_411_3 then
						if arg_408_1.isInRecall_ then
							iter_411_3.color = arg_408_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_411_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_408_1.var_.actorSpriteComps1094 = nil
			end

			local var_411_8 = 0
			local var_411_9 = 0.075

			if var_411_8 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_10 = arg_408_1:FormatText(StoryNameCfg[7].name)

				arg_408_1.leftNameTxt_.text = var_411_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_11 = arg_408_1:GetWordFromCfg(424011099)
				local var_411_12 = arg_408_1:FormatText(var_411_11.content)

				arg_408_1.text_.text = var_411_12

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_13 = 3
				local var_411_14 = utf8.len(var_411_12)
				local var_411_15 = var_411_13 <= 0 and var_411_9 or var_411_9 * (var_411_14 / var_411_13)

				if var_411_15 > 0 and var_411_9 < var_411_15 then
					arg_408_1.talkMaxDuration = var_411_15

					if var_411_15 + var_411_8 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_15 + var_411_8
					end
				end

				arg_408_1.text_.text = var_411_12
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_9, arg_408_1.talkMaxDuration)

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_8) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_8 + var_411_16 and arg_408_1.time_ < var_411_8 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play424011100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 424011100
		arg_412_1.duration_ = 2.3

		local var_412_0 = {
			zh = 2.2,
			ja = 2.3
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play424011101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1094"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps1094 == nil then
				arg_412_1.var_.actorSpriteComps1094 = var_415_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_2 = 0.2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.actorSpriteComps1094 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								local var_415_4 = Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor1.r, var_415_3)
								local var_415_5 = Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor1.g, var_415_3)
								local var_415_6 = Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor1.b, var_415_3)

								iter_415_1.color = Color.New(var_415_4, var_415_5, var_415_6)
							else
								local var_415_7 = Mathf.Lerp(iter_415_1.color.r, 1, var_415_3)

								iter_415_1.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps1094 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_415_3 then
						if arg_412_1.isInRecall_ then
							iter_415_3.color = arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_415_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps1094 = nil
			end

			local var_415_8 = 0
			local var_415_9 = 0.225

			if var_415_8 < arg_412_1.time_ and arg_412_1.time_ <= var_415_8 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_10 = arg_412_1:FormatText(StoryNameCfg[181].name)

				arg_412_1.leftNameTxt_.text = var_415_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_11 = arg_412_1:GetWordFromCfg(424011100)
				local var_415_12 = arg_412_1:FormatText(var_415_11.content)

				arg_412_1.text_.text = var_415_12

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_13 = 9
				local var_415_14 = utf8.len(var_415_12)
				local var_415_15 = var_415_13 <= 0 and var_415_9 or var_415_9 * (var_415_14 / var_415_13)

				if var_415_15 > 0 and var_415_9 < var_415_15 then
					arg_412_1.talkMaxDuration = var_415_15

					if var_415_15 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_15 + var_415_8
					end
				end

				arg_412_1.text_.text = var_415_12
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011100", "story_v_out_424011.awb") ~= 0 then
					local var_415_16 = manager.audio:GetVoiceLength("story_v_out_424011", "424011100", "story_v_out_424011.awb") / 1000

					if var_415_16 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_16 + var_415_8
					end

					if var_415_11.prefab_name ~= "" and arg_412_1.actors_[var_415_11.prefab_name] ~= nil then
						local var_415_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_11.prefab_name].transform, "story_v_out_424011", "424011100", "story_v_out_424011.awb")

						arg_412_1:RecordAudio("424011100", var_415_17)
						arg_412_1:RecordAudio("424011100", var_415_17)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_424011", "424011100", "story_v_out_424011.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_424011", "424011100", "story_v_out_424011.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_18 = math.max(var_415_9, arg_412_1.talkMaxDuration)

			if var_415_8 <= arg_412_1.time_ and arg_412_1.time_ < var_415_8 + var_415_18 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_8) / var_415_18

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_8 + var_415_18 and arg_412_1.time_ < var_415_8 + var_415_18 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play424011101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 424011101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play424011102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1094"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1094 == nil then
				arg_416_1.var_.actorSpriteComps1094 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps1094 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 0.5, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1094 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps1094 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 0.075

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_10 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_11 = arg_416_1:GetWordFromCfg(424011101)
				local var_419_12 = arg_416_1:FormatText(var_419_11.content)

				arg_416_1.text_.text = var_419_12

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 3
				local var_419_14 = utf8.len(var_419_12)
				local var_419_15 = var_419_13 <= 0 and var_419_9 or var_419_9 * (var_419_14 / var_419_13)

				if var_419_15 > 0 and var_419_9 < var_419_15 then
					arg_416_1.talkMaxDuration = var_419_15

					if var_419_15 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_15 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_12
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_16 and arg_416_1.time_ < var_419_8 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play424011102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 424011102
		arg_420_1.duration_ = 8.27

		local var_420_0 = {
			zh = 5.633,
			ja = 8.266
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play424011103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.675

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_2 = arg_420_1:FormatText(StoryNameCfg[177].name)

				arg_420_1.leftNameTxt_.text = var_423_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_3 = arg_420_1:GetWordFromCfg(424011102)
				local var_423_4 = arg_420_1:FormatText(var_423_3.content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 27
				local var_423_6 = utf8.len(var_423_4)
				local var_423_7 = var_423_5 <= 0 and var_423_1 or var_423_1 * (var_423_6 / var_423_5)

				if var_423_7 > 0 and var_423_1 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_4
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011102", "story_v_out_424011.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011102", "story_v_out_424011.awb") / 1000

					if var_423_8 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_0
					end

					if var_423_3.prefab_name ~= "" and arg_420_1.actors_[var_423_3.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_3.prefab_name].transform, "story_v_out_424011", "424011102", "story_v_out_424011.awb")

						arg_420_1:RecordAudio("424011102", var_423_9)
						arg_420_1:RecordAudio("424011102", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_424011", "424011102", "story_v_out_424011.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_424011", "424011102", "story_v_out_424011.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_10 and arg_420_1.time_ < var_423_0 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play424011103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 424011103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play424011104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.775

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_2 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:GetWordFromCfg(424011103)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 31
				local var_427_6 = utf8.len(var_427_4)
				local var_427_7 = var_427_5 <= 0 and var_427_1 or var_427_1 * (var_427_6 / var_427_5)

				if var_427_7 > 0 and var_427_1 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_8 and arg_424_1.time_ < var_427_0 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play424011104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 424011104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play424011105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1094"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1094 = var_431_0.localPosition
				var_431_0.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("1094", 7)

				local var_431_2 = var_431_0.childCount

				for iter_431_0 = 0, var_431_2 - 1 do
					local var_431_3 = var_431_0:GetChild(iter_431_0)

					if var_431_3.name == "" or not string.find(var_431_3.name, "split") then
						var_431_3.gameObject:SetActive(true)
					else
						var_431_3.gameObject:SetActive(false)
					end
				end
			end

			local var_431_4 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_4 then
				local var_431_5 = (arg_428_1.time_ - var_431_1) / var_431_4
				local var_431_6 = Vector3.New(0, -2000, 0)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1094, var_431_6, var_431_5)
			end

			if arg_428_1.time_ >= var_431_1 + var_431_4 and arg_428_1.time_ < var_431_1 + var_431_4 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_431_7 = 0
			local var_431_8 = 0.6

			if var_431_7 < arg_428_1.time_ and arg_428_1.time_ <= var_431_7 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_9 = arg_428_1:GetWordFromCfg(424011104)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 24
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_8 or var_431_8 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_8 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_7 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_7
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_8, arg_428_1.talkMaxDuration)

			if var_431_7 <= arg_428_1.time_ and arg_428_1.time_ < var_431_7 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_7) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_7 + var_431_14 and arg_428_1.time_ < var_431_7 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play424011105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 424011105
		arg_432_1.duration_ = 3.43

		local var_432_0 = {
			zh = 3.433,
			ja = 3.233
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play424011106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1094"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps1094 == nil then
				arg_432_1.var_.actorSpriteComps1094 = var_435_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_2 = 0.2

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.actorSpriteComps1094 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								local var_435_4 = Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor1.r, var_435_3)
								local var_435_5 = Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor1.g, var_435_3)
								local var_435_6 = Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor1.b, var_435_3)

								iter_435_1.color = Color.New(var_435_4, var_435_5, var_435_6)
							else
								local var_435_7 = Mathf.Lerp(iter_435_1.color.r, 1, var_435_3)

								iter_435_1.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps1094 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_435_3 then
						if arg_432_1.isInRecall_ then
							iter_435_3.color = arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_435_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps1094 = nil
			end

			local var_435_8 = arg_432_1.actors_["1094"].transform
			local var_435_9 = 0

			if var_435_9 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 then
				arg_432_1.var_.moveOldPos1094 = var_435_8.localPosition
				var_435_8.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("1094", 3)

				local var_435_10 = var_435_8.childCount

				for iter_435_4 = 0, var_435_10 - 1 do
					local var_435_11 = var_435_8:GetChild(iter_435_4)

					if var_435_11.name == "" or not string.find(var_435_11.name, "split") then
						var_435_11.gameObject:SetActive(true)
					else
						var_435_11.gameObject:SetActive(false)
					end
				end
			end

			local var_435_12 = 0.001

			if var_435_9 <= arg_432_1.time_ and arg_432_1.time_ < var_435_9 + var_435_12 then
				local var_435_13 = (arg_432_1.time_ - var_435_9) / var_435_12
				local var_435_14 = Vector3.New(0, -335, -230)

				var_435_8.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1094, var_435_14, var_435_13)
			end

			if arg_432_1.time_ >= var_435_9 + var_435_12 and arg_432_1.time_ < var_435_9 + var_435_12 + arg_435_0 then
				var_435_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_435_15 = 0
			local var_435_16 = 0.2

			if var_435_15 < arg_432_1.time_ and arg_432_1.time_ <= var_435_15 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_17 = arg_432_1:FormatText(StoryNameCfg[181].name)

				arg_432_1.leftNameTxt_.text = var_435_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_18 = arg_432_1:GetWordFromCfg(424011105)
				local var_435_19 = arg_432_1:FormatText(var_435_18.content)

				arg_432_1.text_.text = var_435_19

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_20 = 8
				local var_435_21 = utf8.len(var_435_19)
				local var_435_22 = var_435_20 <= 0 and var_435_16 or var_435_16 * (var_435_21 / var_435_20)

				if var_435_22 > 0 and var_435_16 < var_435_22 then
					arg_432_1.talkMaxDuration = var_435_22

					if var_435_22 + var_435_15 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_22 + var_435_15
					end
				end

				arg_432_1.text_.text = var_435_19
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011105", "story_v_out_424011.awb") ~= 0 then
					local var_435_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011105", "story_v_out_424011.awb") / 1000

					if var_435_23 + var_435_15 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_23 + var_435_15
					end

					if var_435_18.prefab_name ~= "" and arg_432_1.actors_[var_435_18.prefab_name] ~= nil then
						local var_435_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_18.prefab_name].transform, "story_v_out_424011", "424011105", "story_v_out_424011.awb")

						arg_432_1:RecordAudio("424011105", var_435_24)
						arg_432_1:RecordAudio("424011105", var_435_24)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_424011", "424011105", "story_v_out_424011.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_424011", "424011105", "story_v_out_424011.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_25 = math.max(var_435_16, arg_432_1.talkMaxDuration)

			if var_435_15 <= arg_432_1.time_ and arg_432_1.time_ < var_435_15 + var_435_25 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_15) / var_435_25

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_15 + var_435_25 and arg_432_1.time_ < var_435_15 + var_435_25 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play424011106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 424011106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play424011107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1094"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps1094 == nil then
				arg_436_1.var_.actorSpriteComps1094 = var_439_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.actorSpriteComps1094 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								local var_439_4 = Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor2.r, var_439_3)
								local var_439_5 = Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor2.g, var_439_3)
								local var_439_6 = Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor2.b, var_439_3)

								iter_439_1.color = Color.New(var_439_4, var_439_5, var_439_6)
							else
								local var_439_7 = Mathf.Lerp(iter_439_1.color.r, 0.5, var_439_3)

								iter_439_1.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps1094 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_439_3 then
						if arg_436_1.isInRecall_ then
							iter_439_3.color = arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_439_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps1094 = nil
			end

			local var_439_8 = 0
			local var_439_9 = 0.625

			if var_439_8 < arg_436_1.time_ and arg_436_1.time_ <= var_439_8 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_10 = arg_436_1:FormatText(StoryNameCfg[7].name)

				arg_436_1.leftNameTxt_.text = var_439_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_11 = arg_436_1:GetWordFromCfg(424011106)
				local var_439_12 = arg_436_1:FormatText(var_439_11.content)

				arg_436_1.text_.text = var_439_12

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_13 = 25
				local var_439_14 = utf8.len(var_439_12)
				local var_439_15 = var_439_13 <= 0 and var_439_9 or var_439_9 * (var_439_14 / var_439_13)

				if var_439_15 > 0 and var_439_9 < var_439_15 then
					arg_436_1.talkMaxDuration = var_439_15

					if var_439_15 + var_439_8 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_15 + var_439_8
					end
				end

				arg_436_1.text_.text = var_439_12
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_16 = math.max(var_439_9, arg_436_1.talkMaxDuration)

			if var_439_8 <= arg_436_1.time_ and arg_436_1.time_ < var_439_8 + var_439_16 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_8) / var_439_16

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_8 + var_439_16 and arg_436_1.time_ < var_439_8 + var_439_16 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play424011107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 424011107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play424011108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1094"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1094 = var_443_0.localPosition
				var_443_0.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("1094", 7)

				local var_443_2 = var_443_0.childCount

				for iter_443_0 = 0, var_443_2 - 1 do
					local var_443_3 = var_443_0:GetChild(iter_443_0)

					if var_443_3.name == "" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_4 then
				local var_443_5 = (arg_440_1.time_ - var_443_1) / var_443_4
				local var_443_6 = Vector3.New(0, -2000, 0)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1094, var_443_6, var_443_5)
			end

			if arg_440_1.time_ >= var_443_1 + var_443_4 and arg_440_1.time_ < var_443_1 + var_443_4 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_443_7 = 0.034
			local var_443_8 = 1

			if var_443_7 < arg_440_1.time_ and arg_440_1.time_ <= var_443_7 + arg_443_0 then
				local var_443_9 = "play"
				local var_443_10 = "effect"

				arg_440_1:AudioAction(var_443_9, var_443_10, "se_story_146", "se_story_146_straw", "")
			end

			local var_443_11 = 0
			local var_443_12 = 0.85

			if var_443_11 < arg_440_1.time_ and arg_440_1.time_ <= var_443_11 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_13 = arg_440_1:GetWordFromCfg(424011107)
				local var_443_14 = arg_440_1:FormatText(var_443_13.content)

				arg_440_1.text_.text = var_443_14

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_15 = 34
				local var_443_16 = utf8.len(var_443_14)
				local var_443_17 = var_443_15 <= 0 and var_443_12 or var_443_12 * (var_443_16 / var_443_15)

				if var_443_17 > 0 and var_443_12 < var_443_17 then
					arg_440_1.talkMaxDuration = var_443_17

					if var_443_17 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_17 + var_443_11
					end
				end

				arg_440_1.text_.text = var_443_14
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_18 = math.max(var_443_12, arg_440_1.talkMaxDuration)

			if var_443_11 <= arg_440_1.time_ and arg_440_1.time_ < var_443_11 + var_443_18 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_11) / var_443_18

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_11 + var_443_18 and arg_440_1.time_ < var_443_11 + var_443_18 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play424011108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 424011108
		arg_444_1.duration_ = 3.5

		local var_444_0 = {
			zh = 1.733,
			ja = 3.5
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play424011109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1094"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps1094 == nil then
				arg_444_1.var_.actorSpriteComps1094 = var_447_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.actorSpriteComps1094 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								local var_447_4 = Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, var_447_3)
								local var_447_5 = Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, var_447_3)
								local var_447_6 = Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, var_447_3)

								iter_447_1.color = Color.New(var_447_4, var_447_5, var_447_6)
							else
								local var_447_7 = Mathf.Lerp(iter_447_1.color.r, 1, var_447_3)

								iter_447_1.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps1094 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_447_3 then
						if arg_444_1.isInRecall_ then
							iter_447_3.color = arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_447_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps1094 = nil
			end

			local var_447_8 = arg_444_1.actors_["1094"].transform
			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 then
				arg_444_1.var_.moveOldPos1094 = var_447_8.localPosition
				var_447_8.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("1094", 3)

				local var_447_10 = var_447_8.childCount

				for iter_447_4 = 0, var_447_10 - 1 do
					local var_447_11 = var_447_8:GetChild(iter_447_4)

					if var_447_11.name == "" or not string.find(var_447_11.name, "split") then
						var_447_11.gameObject:SetActive(true)
					else
						var_447_11.gameObject:SetActive(false)
					end
				end
			end

			local var_447_12 = 0.001

			if var_447_9 <= arg_444_1.time_ and arg_444_1.time_ < var_447_9 + var_447_12 then
				local var_447_13 = (arg_444_1.time_ - var_447_9) / var_447_12
				local var_447_14 = Vector3.New(0, -335, -230)

				var_447_8.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1094, var_447_14, var_447_13)
			end

			if arg_444_1.time_ >= var_447_9 + var_447_12 and arg_444_1.time_ < var_447_9 + var_447_12 + arg_447_0 then
				var_447_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_447_15 = 0
			local var_447_16 = 0.15

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_17 = arg_444_1:FormatText(StoryNameCfg[181].name)

				arg_444_1.leftNameTxt_.text = var_447_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_18 = arg_444_1:GetWordFromCfg(424011108)
				local var_447_19 = arg_444_1:FormatText(var_447_18.content)

				arg_444_1.text_.text = var_447_19

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_20 = 6
				local var_447_21 = utf8.len(var_447_19)
				local var_447_22 = var_447_20 <= 0 and var_447_16 or var_447_16 * (var_447_21 / var_447_20)

				if var_447_22 > 0 and var_447_16 < var_447_22 then
					arg_444_1.talkMaxDuration = var_447_22

					if var_447_22 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_22 + var_447_15
					end
				end

				arg_444_1.text_.text = var_447_19
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011108", "story_v_out_424011.awb") ~= 0 then
					local var_447_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011108", "story_v_out_424011.awb") / 1000

					if var_447_23 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_23 + var_447_15
					end

					if var_447_18.prefab_name ~= "" and arg_444_1.actors_[var_447_18.prefab_name] ~= nil then
						local var_447_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_18.prefab_name].transform, "story_v_out_424011", "424011108", "story_v_out_424011.awb")

						arg_444_1:RecordAudio("424011108", var_447_24)
						arg_444_1:RecordAudio("424011108", var_447_24)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_424011", "424011108", "story_v_out_424011.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_424011", "424011108", "story_v_out_424011.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_25 = math.max(var_447_16, arg_444_1.talkMaxDuration)

			if var_447_15 <= arg_444_1.time_ and arg_444_1.time_ < var_447_15 + var_447_25 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_15) / var_447_25

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_15 + var_447_25 and arg_444_1.time_ < var_447_15 + var_447_25 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play424011109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 424011109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play424011110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1094"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps1094 == nil then
				arg_448_1.var_.actorSpriteComps1094 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps1094 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								local var_451_4 = Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor2.r, var_451_3)
								local var_451_5 = Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor2.g, var_451_3)
								local var_451_6 = Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor2.b, var_451_3)

								iter_451_1.color = Color.New(var_451_4, var_451_5, var_451_6)
							else
								local var_451_7 = Mathf.Lerp(iter_451_1.color.r, 0.5, var_451_3)

								iter_451_1.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps1094 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_451_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps1094 = nil
			end

			local var_451_8 = 0
			local var_451_9 = 0.075

			if var_451_8 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_10 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_11 = arg_448_1:GetWordFromCfg(424011109)
				local var_451_12 = arg_448_1:FormatText(var_451_11.content)

				arg_448_1.text_.text = var_451_12

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 3
				local var_451_14 = utf8.len(var_451_12)
				local var_451_15 = var_451_13 <= 0 and var_451_9 or var_451_9 * (var_451_14 / var_451_13)

				if var_451_15 > 0 and var_451_9 < var_451_15 then
					arg_448_1.talkMaxDuration = var_451_15

					if var_451_15 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_15 + var_451_8
					end
				end

				arg_448_1.text_.text = var_451_12
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_16 and arg_448_1.time_ < var_451_8 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play424011110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 424011110
		arg_452_1.duration_ = 1.7

		local var_452_0 = {
			zh = 1.7,
			ja = 1.5
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play424011111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1094"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps1094 == nil then
				arg_452_1.var_.actorSpriteComps1094 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps1094 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								local var_455_4 = Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor1.r, var_455_3)
								local var_455_5 = Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor1.g, var_455_3)
								local var_455_6 = Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor1.b, var_455_3)

								iter_455_1.color = Color.New(var_455_4, var_455_5, var_455_6)
							else
								local var_455_7 = Mathf.Lerp(iter_455_1.color.r, 1, var_455_3)

								iter_455_1.color = Color.New(var_455_7, var_455_7, var_455_7)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps1094 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_455_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps1094 = nil
			end

			local var_455_8 = arg_452_1.actors_["1094"].transform
			local var_455_9 = 0

			if var_455_9 < arg_452_1.time_ and arg_452_1.time_ <= var_455_9 + arg_455_0 then
				arg_452_1.var_.moveOldPos1094 = var_455_8.localPosition
				var_455_8.localScale = Vector3.New(1, 1, 1)

				arg_452_1:CheckSpriteTmpPos("1094", 3)

				local var_455_10 = var_455_8.childCount

				for iter_455_4 = 0, var_455_10 - 1 do
					local var_455_11 = var_455_8:GetChild(iter_455_4)

					if var_455_11.name == "" or not string.find(var_455_11.name, "split") then
						var_455_11.gameObject:SetActive(true)
					else
						var_455_11.gameObject:SetActive(false)
					end
				end
			end

			local var_455_12 = 0.001

			if var_455_9 <= arg_452_1.time_ and arg_452_1.time_ < var_455_9 + var_455_12 then
				local var_455_13 = (arg_452_1.time_ - var_455_9) / var_455_12
				local var_455_14 = Vector3.New(0, -335, -230)

				var_455_8.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1094, var_455_14, var_455_13)
			end

			if arg_452_1.time_ >= var_455_9 + var_455_12 and arg_452_1.time_ < var_455_9 + var_455_12 + arg_455_0 then
				var_455_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_455_15 = 0
			local var_455_16 = 0.125

			if var_455_15 < arg_452_1.time_ and arg_452_1.time_ <= var_455_15 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_17 = arg_452_1:FormatText(StoryNameCfg[181].name)

				arg_452_1.leftNameTxt_.text = var_455_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_18 = arg_452_1:GetWordFromCfg(424011110)
				local var_455_19 = arg_452_1:FormatText(var_455_18.content)

				arg_452_1.text_.text = var_455_19

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_20 = 5
				local var_455_21 = utf8.len(var_455_19)
				local var_455_22 = var_455_20 <= 0 and var_455_16 or var_455_16 * (var_455_21 / var_455_20)

				if var_455_22 > 0 and var_455_16 < var_455_22 then
					arg_452_1.talkMaxDuration = var_455_22

					if var_455_22 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_22 + var_455_15
					end
				end

				arg_452_1.text_.text = var_455_19
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011110", "story_v_out_424011.awb") ~= 0 then
					local var_455_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011110", "story_v_out_424011.awb") / 1000

					if var_455_23 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_15
					end

					if var_455_18.prefab_name ~= "" and arg_452_1.actors_[var_455_18.prefab_name] ~= nil then
						local var_455_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_18.prefab_name].transform, "story_v_out_424011", "424011110", "story_v_out_424011.awb")

						arg_452_1:RecordAudio("424011110", var_455_24)
						arg_452_1:RecordAudio("424011110", var_455_24)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_424011", "424011110", "story_v_out_424011.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_424011", "424011110", "story_v_out_424011.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_25 = math.max(var_455_16, arg_452_1.talkMaxDuration)

			if var_455_15 <= arg_452_1.time_ and arg_452_1.time_ < var_455_15 + var_455_25 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_15) / var_455_25

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_15 + var_455_25 and arg_452_1.time_ < var_455_15 + var_455_25 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play424011111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 424011111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play424011112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1094"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps1094 == nil then
				arg_456_1.var_.actorSpriteComps1094 = var_459_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.actorSpriteComps1094 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								local var_459_4 = Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor2.r, var_459_3)
								local var_459_5 = Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor2.g, var_459_3)
								local var_459_6 = Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor2.b, var_459_3)

								iter_459_1.color = Color.New(var_459_4, var_459_5, var_459_6)
							else
								local var_459_7 = Mathf.Lerp(iter_459_1.color.r, 0.5, var_459_3)

								iter_459_1.color = Color.New(var_459_7, var_459_7, var_459_7)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps1094 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_459_3 then
						if arg_456_1.isInRecall_ then
							iter_459_3.color = arg_456_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_459_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps1094 = nil
			end

			local var_459_8 = 0
			local var_459_9 = 0.475

			if var_459_8 < arg_456_1.time_ and arg_456_1.time_ <= var_459_8 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_10 = arg_456_1:FormatText(StoryNameCfg[7].name)

				arg_456_1.leftNameTxt_.text = var_459_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_11 = arg_456_1:GetWordFromCfg(424011111)
				local var_459_12 = arg_456_1:FormatText(var_459_11.content)

				arg_456_1.text_.text = var_459_12

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_13 = 19
				local var_459_14 = utf8.len(var_459_12)
				local var_459_15 = var_459_13 <= 0 and var_459_9 or var_459_9 * (var_459_14 / var_459_13)

				if var_459_15 > 0 and var_459_9 < var_459_15 then
					arg_456_1.talkMaxDuration = var_459_15

					if var_459_15 + var_459_8 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_15 + var_459_8
					end
				end

				arg_456_1.text_.text = var_459_12
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_16 = math.max(var_459_9, arg_456_1.talkMaxDuration)

			if var_459_8 <= arg_456_1.time_ and arg_456_1.time_ < var_459_8 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_8) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_8 + var_459_16 and arg_456_1.time_ < var_459_8 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play424011112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 424011112
		arg_460_1.duration_ = 2.83

		local var_460_0 = {
			zh = 1.366,
			ja = 2.833
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play424011113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1094"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps1094 == nil then
				arg_460_1.var_.actorSpriteComps1094 = var_463_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_2 = 0.2

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.actorSpriteComps1094 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								local var_463_4 = Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, var_463_3)
								local var_463_5 = Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, var_463_3)
								local var_463_6 = Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, var_463_3)

								iter_463_1.color = Color.New(var_463_4, var_463_5, var_463_6)
							else
								local var_463_7 = Mathf.Lerp(iter_463_1.color.r, 1, var_463_3)

								iter_463_1.color = Color.New(var_463_7, var_463_7, var_463_7)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps1094 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_463_3 then
						if arg_460_1.isInRecall_ then
							iter_463_3.color = arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_463_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps1094 = nil
			end

			local var_463_8 = arg_460_1.actors_["1094"].transform
			local var_463_9 = 0

			if var_463_9 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 then
				arg_460_1.var_.moveOldPos1094 = var_463_8.localPosition
				var_463_8.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("1094", 3)

				local var_463_10 = var_463_8.childCount

				for iter_463_4 = 0, var_463_10 - 1 do
					local var_463_11 = var_463_8:GetChild(iter_463_4)

					if var_463_11.name == "split_2" then
						var_463_11:SetAsLastSibling()
						var_463_11.gameObject:SetActive(true)

						arg_460_1.var_.actorSpriteSplit1094 = var_463_11.gameObject:GetComponent(typeof(Image))

						arg_460_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_463_12 = 0.5

			if var_463_9 <= arg_460_1.time_ and arg_460_1.time_ < var_463_9 + var_463_12 then
				local var_463_13 = (arg_460_1.time_ - var_463_9) / var_463_12
				local var_463_14 = Vector3.New(0, -335, -230)

				var_463_8.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1094, var_463_14, var_463_13)

				if arg_460_1.var_.actorSpriteSplit1094 ~= nil then
					arg_460_1.var_.actorSpriteSplit1094:SetAlpha(var_463_13)
				end
			end

			if arg_460_1.time_ >= var_463_9 + var_463_12 and arg_460_1.time_ < var_463_9 + var_463_12 + arg_463_0 then
				var_463_8.localPosition = Vector3.New(0, -335, -230)

				if arg_460_1.var_.actorSpriteSplit1094 ~= nil then
					arg_460_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_463_15 = 0
			local var_463_16 = 0.1

			if var_463_15 < arg_460_1.time_ and arg_460_1.time_ <= var_463_15 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_17 = arg_460_1:FormatText(StoryNameCfg[181].name)

				arg_460_1.leftNameTxt_.text = var_463_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_18 = arg_460_1:GetWordFromCfg(424011112)
				local var_463_19 = arg_460_1:FormatText(var_463_18.content)

				arg_460_1.text_.text = var_463_19

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_20 = 4
				local var_463_21 = utf8.len(var_463_19)
				local var_463_22 = var_463_20 <= 0 and var_463_16 or var_463_16 * (var_463_21 / var_463_20)

				if var_463_22 > 0 and var_463_16 < var_463_22 then
					arg_460_1.talkMaxDuration = var_463_22

					if var_463_22 + var_463_15 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_22 + var_463_15
					end
				end

				arg_460_1.text_.text = var_463_19
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011112", "story_v_out_424011.awb") ~= 0 then
					local var_463_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011112", "story_v_out_424011.awb") / 1000

					if var_463_23 + var_463_15 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_23 + var_463_15
					end

					if var_463_18.prefab_name ~= "" and arg_460_1.actors_[var_463_18.prefab_name] ~= nil then
						local var_463_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_18.prefab_name].transform, "story_v_out_424011", "424011112", "story_v_out_424011.awb")

						arg_460_1:RecordAudio("424011112", var_463_24)
						arg_460_1:RecordAudio("424011112", var_463_24)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_424011", "424011112", "story_v_out_424011.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_424011", "424011112", "story_v_out_424011.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_25 = math.max(var_463_16, arg_460_1.talkMaxDuration)

			if var_463_15 <= arg_460_1.time_ and arg_460_1.time_ < var_463_15 + var_463_25 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_15) / var_463_25

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_15 + var_463_25 and arg_460_1.time_ < var_463_15 + var_463_25 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play424011113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 424011113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play424011114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1094"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps1094 == nil then
				arg_464_1.var_.actorSpriteComps1094 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps1094 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								local var_467_4 = Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor2.r, var_467_3)
								local var_467_5 = Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor2.g, var_467_3)
								local var_467_6 = Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor2.b, var_467_3)

								iter_467_1.color = Color.New(var_467_4, var_467_5, var_467_6)
							else
								local var_467_7 = Mathf.Lerp(iter_467_1.color.r, 0.5, var_467_3)

								iter_467_1.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps1094 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps1094 = nil
			end

			local var_467_8 = 0.133333333333333
			local var_467_9 = 1

			if var_467_8 < arg_464_1.time_ and arg_464_1.time_ <= var_467_8 + arg_467_0 then
				local var_467_10 = "play"
				local var_467_11 = "effect"

				arg_464_1:AudioAction(var_467_10, var_467_11, "se_story_146", "se_story_146_elevator", "")
			end

			local var_467_12 = 0
			local var_467_13 = 0.55

			if var_467_12 < arg_464_1.time_ and arg_464_1.time_ <= var_467_12 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_14 = arg_464_1:GetWordFromCfg(424011113)
				local var_467_15 = arg_464_1:FormatText(var_467_14.content)

				arg_464_1.text_.text = var_467_15

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_16 = 22
				local var_467_17 = utf8.len(var_467_15)
				local var_467_18 = var_467_16 <= 0 and var_467_13 or var_467_13 * (var_467_17 / var_467_16)

				if var_467_18 > 0 and var_467_13 < var_467_18 then
					arg_464_1.talkMaxDuration = var_467_18

					if var_467_18 + var_467_12 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_18 + var_467_12
					end
				end

				arg_464_1.text_.text = var_467_15
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_19 = math.max(var_467_13, arg_464_1.talkMaxDuration)

			if var_467_12 <= arg_464_1.time_ and arg_464_1.time_ < var_467_12 + var_467_19 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_12) / var_467_19

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_12 + var_467_19 and arg_464_1.time_ < var_467_12 + var_467_19 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play424011114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 424011114
		arg_468_1.duration_ = 2.2

		local var_468_0 = {
			zh = 2.2,
			ja = 1.066
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play424011115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1094"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps1094 == nil then
				arg_468_1.var_.actorSpriteComps1094 = var_471_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_2 = 0.2

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.actorSpriteComps1094 then
					for iter_471_0, iter_471_1 in pairs(arg_468_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_471_1 then
							if arg_468_1.isInRecall_ then
								local var_471_4 = Mathf.Lerp(iter_471_1.color.r, arg_468_1.hightColor1.r, var_471_3)
								local var_471_5 = Mathf.Lerp(iter_471_1.color.g, arg_468_1.hightColor1.g, var_471_3)
								local var_471_6 = Mathf.Lerp(iter_471_1.color.b, arg_468_1.hightColor1.b, var_471_3)

								iter_471_1.color = Color.New(var_471_4, var_471_5, var_471_6)
							else
								local var_471_7 = Mathf.Lerp(iter_471_1.color.r, 1, var_471_3)

								iter_471_1.color = Color.New(var_471_7, var_471_7, var_471_7)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps1094 then
				for iter_471_2, iter_471_3 in pairs(arg_468_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_471_3 then
						if arg_468_1.isInRecall_ then
							iter_471_3.color = arg_468_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_471_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_468_1.var_.actorSpriteComps1094 = nil
			end

			local var_471_8 = arg_468_1.actors_["1094"].transform
			local var_471_9 = 0

			if var_471_9 < arg_468_1.time_ and arg_468_1.time_ <= var_471_9 + arg_471_0 then
				arg_468_1.var_.moveOldPos1094 = var_471_8.localPosition
				var_471_8.localScale = Vector3.New(1, 1, 1)

				arg_468_1:CheckSpriteTmpPos("1094", 3)

				local var_471_10 = var_471_8.childCount

				for iter_471_4 = 0, var_471_10 - 1 do
					local var_471_11 = var_471_8:GetChild(iter_471_4)

					if var_471_11.name == "split_2" or not string.find(var_471_11.name, "split") then
						var_471_11.gameObject:SetActive(true)
					else
						var_471_11.gameObject:SetActive(false)
					end
				end
			end

			local var_471_12 = 0.001

			if var_471_9 <= arg_468_1.time_ and arg_468_1.time_ < var_471_9 + var_471_12 then
				local var_471_13 = (arg_468_1.time_ - var_471_9) / var_471_12
				local var_471_14 = Vector3.New(0, -335, -230)

				var_471_8.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1094, var_471_14, var_471_13)
			end

			if arg_468_1.time_ >= var_471_9 + var_471_12 and arg_468_1.time_ < var_471_9 + var_471_12 + arg_471_0 then
				var_471_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_471_15 = 0
			local var_471_16 = 0.175

			if var_471_15 < arg_468_1.time_ and arg_468_1.time_ <= var_471_15 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_17 = arg_468_1:FormatText(StoryNameCfg[181].name)

				arg_468_1.leftNameTxt_.text = var_471_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_18 = arg_468_1:GetWordFromCfg(424011114)
				local var_471_19 = arg_468_1:FormatText(var_471_18.content)

				arg_468_1.text_.text = var_471_19

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_20 = 7
				local var_471_21 = utf8.len(var_471_19)
				local var_471_22 = var_471_20 <= 0 and var_471_16 or var_471_16 * (var_471_21 / var_471_20)

				if var_471_22 > 0 and var_471_16 < var_471_22 then
					arg_468_1.talkMaxDuration = var_471_22

					if var_471_22 + var_471_15 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_22 + var_471_15
					end
				end

				arg_468_1.text_.text = var_471_19
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011114", "story_v_out_424011.awb") ~= 0 then
					local var_471_23 = manager.audio:GetVoiceLength("story_v_out_424011", "424011114", "story_v_out_424011.awb") / 1000

					if var_471_23 + var_471_15 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_23 + var_471_15
					end

					if var_471_18.prefab_name ~= "" and arg_468_1.actors_[var_471_18.prefab_name] ~= nil then
						local var_471_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_18.prefab_name].transform, "story_v_out_424011", "424011114", "story_v_out_424011.awb")

						arg_468_1:RecordAudio("424011114", var_471_24)
						arg_468_1:RecordAudio("424011114", var_471_24)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_424011", "424011114", "story_v_out_424011.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_424011", "424011114", "story_v_out_424011.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_25 = math.max(var_471_16, arg_468_1.talkMaxDuration)

			if var_471_15 <= arg_468_1.time_ and arg_468_1.time_ < var_471_15 + var_471_25 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_15) / var_471_25

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_15 + var_471_25 and arg_468_1.time_ < var_471_15 + var_471_25 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_468_1:InitPlayNodeList()
	end,
	Play424011115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 424011115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play424011116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1094"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps1094 == nil then
				arg_472_1.var_.actorSpriteComps1094 = var_475_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_2 = 0.2

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.actorSpriteComps1094 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								local var_475_4 = Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor2.r, var_475_3)
								local var_475_5 = Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor2.g, var_475_3)
								local var_475_6 = Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor2.b, var_475_3)

								iter_475_1.color = Color.New(var_475_4, var_475_5, var_475_6)
							else
								local var_475_7 = Mathf.Lerp(iter_475_1.color.r, 0.5, var_475_3)

								iter_475_1.color = Color.New(var_475_7, var_475_7, var_475_7)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps1094 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_475_3 then
						if arg_472_1.isInRecall_ then
							iter_475_3.color = arg_472_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_475_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_472_1.var_.actorSpriteComps1094 = nil
			end

			local var_475_8 = 0
			local var_475_9 = 1

			if var_475_8 < arg_472_1.time_ and arg_472_1.time_ <= var_475_8 + arg_475_0 then
				local var_475_10 = "play"
				local var_475_11 = "effect"

				arg_472_1:AudioAction(var_475_10, var_475_11, "se_story_143", "se_story_143_elevator_door", "")
			end

			local var_475_12 = 0.2
			local var_475_13 = 1

			if var_475_12 < arg_472_1.time_ and arg_472_1.time_ <= var_475_12 + arg_475_0 then
				local var_475_14 = "play"
				local var_475_15 = "effect"

				arg_472_1:AudioAction(var_475_14, var_475_15, "se_story_146", "se_story_146_footstep", "")
			end

			local var_475_16 = 0
			local var_475_17 = 0.7

			if var_475_16 < arg_472_1.time_ and arg_472_1.time_ <= var_475_16 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_18 = arg_472_1:GetWordFromCfg(424011115)
				local var_475_19 = arg_472_1:FormatText(var_475_18.content)

				arg_472_1.text_.text = var_475_19

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_20 = 28
				local var_475_21 = utf8.len(var_475_19)
				local var_475_22 = var_475_20 <= 0 and var_475_17 or var_475_17 * (var_475_21 / var_475_20)

				if var_475_22 > 0 and var_475_17 < var_475_22 then
					arg_472_1.talkMaxDuration = var_475_22

					if var_475_22 + var_475_16 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_22 + var_475_16
					end
				end

				arg_472_1.text_.text = var_475_19
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_23 = math.max(var_475_17, arg_472_1.talkMaxDuration)

			if var_475_16 <= arg_472_1.time_ and arg_472_1.time_ < var_475_16 + var_475_23 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_16) / var_475_23

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_16 + var_475_23 and arg_472_1.time_ < var_475_16 + var_475_23 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play424011116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 424011116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
			arg_476_1.auto_ = false
		end

		function arg_476_1.playNext_(arg_478_0)
			arg_476_1.onStoryFinished_()
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.125

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:GetWordFromCfg(424011116)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 5
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_8 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_8 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_8

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_8 and arg_476_1.time_ < var_479_0 + var_479_8 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play424011087 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 424011087
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play424011088(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.525

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(424011087)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 21
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play424011088 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 424011088
		arg_484_1.duration_ = 2.3

		local var_484_0 = {
			zh = 2.3,
			ja = 2.066
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play424011089(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.25

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[177].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:GetWordFromCfg(424011088)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 10
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424011", "424011088", "story_v_out_424011.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_424011", "424011088", "story_v_out_424011.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_424011", "424011088", "story_v_out_424011.awb")

						arg_484_1:RecordAudio("424011088", var_487_9)
						arg_484_1:RecordAudio("424011088", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_424011", "424011088", "story_v_out_424011.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_424011", "424011088", "story_v_out_424011.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST28a",
		"TextureConfig/Background/SS2401",
		"TextureConfig/Background/SS2401a",
		"TextureConfig/Background/SS2401b",
		"TextureConfig/Background/ST04c",
		"TextureConfig/Background/B13e",
		"TextureConfig/Background/ST34"
	},
	voices = {
		"story_v_out_424011.awb"
	}
}
