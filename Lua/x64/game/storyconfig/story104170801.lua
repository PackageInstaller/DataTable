return {
	Play417081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417081001
		arg_1_1.duration_ = 10.77

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B01"

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
				local var_4_5 = arg_1_1.bgs_.B01

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
					if iter_4_0 ~= "B01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 5.76666666666667

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0
			local var_4_19 = 0.2

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_20 = "play"
				local var_4_21 = "music"

				arg_1_1:AudioAction(var_4_20, var_4_21, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = ""
				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_23 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 0.466666666666667
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

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

			local var_4_30 = 4.76666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_120_00", "se_story_120_00_scan", "")
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_35 = 1

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35
				local var_4_37 = Color.New(0, 0, 0)

				var_4_37.a = Mathf.Lerp(1, 0, var_4_36)
				arg_1_1.mask_.color = var_4_37
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				local var_4_38 = Color.New(0, 0, 0)
				local var_4_39 = 0

				arg_1_1.mask_.enabled = false
				var_4_38.a = var_4_39
				arg_1_1.mask_.color = var_4_38
			end

			local var_4_40 = 0
			local var_4_41 = 3.06666666666667
			local var_4_42 = "B01"

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_42)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_43 = arg_1_1:GetWordFromCfg(501029)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_timeText_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_45 = arg_1_1:GetWordFromCfg(501030)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_siteText_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_47 = 3.06666666666667

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_48 = 1.2

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				local var_4_49 = (arg_1_1.time_ - var_4_47) / var_4_48
				local var_4_50 = Color.New(0, 0, 0)

				var_4_50.a = Mathf.Lerp(0, 1, var_4_49)
				arg_1_1.mask_.color = var_4_50
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				local var_4_51 = Color.New(0, 0, 0)

				var_4_51.a = 1
				arg_1_1.mask_.color = var_4_51
			end

			local var_4_52 = 4.26666666666667

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_53 = 1.5

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				local var_4_54 = (arg_1_1.time_ - var_4_52) / var_4_53
				local var_4_55 = Color.New(0, 0, 0)

				var_4_55.a = Mathf.Lerp(1, 0, var_4_54)
				arg_1_1.mask_.color = var_4_55
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				local var_4_56 = Color.New(0, 0, 0)
				local var_4_57 = 0

				arg_1_1.mask_.enabled = false
				var_4_56.a = var_4_57
				arg_1_1.mask_.color = var_4_56
			end

			local var_4_58 = 0

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_59 = 3.06666666666667

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 5.76666666666667
			local var_4_61 = 1.175

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(417081001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 47
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_61 or var_4_61 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_61 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_60 = var_4_60 + 0.3

					if var_4_67 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_60 + 0.3
			local var_4_69 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417081002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417081002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417081003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 0.95

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

				local var_13_2 = arg_10_1:GetWordFromCfg(417081002)
				local var_13_3 = arg_10_1:FormatText(var_13_2.content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 38
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
	Play417081003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417081003
		arg_14_1.duration_ = 1.3

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417081004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "10128"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(var_17_1, arg_14_1.canvasGo_.transform)

					var_17_2.transform:SetSiblingIndex(1)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs(var_17_3) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_4 = arg_14_1.actors_["10128"]
			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10128 == nil then
				arg_14_1.var_.actorSpriteComps10128 = var_17_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_6 = 0.2

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 and not isNil(var_17_4) then
				local var_17_7 = (arg_14_1.time_ - var_17_5) / var_17_6

				if arg_14_1.var_.actorSpriteComps10128 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								local var_17_8 = Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, var_17_7)
								local var_17_9 = Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, var_17_7)
								local var_17_10 = Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, var_17_7)

								iter_17_3.color = Color.New(var_17_8, var_17_9, var_17_10)
							else
								local var_17_11 = Mathf.Lerp(iter_17_3.color.r, 1, var_17_7)

								iter_17_3.color = Color.New(var_17_11, var_17_11, var_17_11)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10128 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_17_5 then
						if arg_14_1.isInRecall_ then
							iter_17_5.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps10128 = nil
			end

			local var_17_12 = arg_14_1.actors_["10128"].transform
			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = var_17_12.localPosition
				var_17_12.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 3)

				local var_17_14 = var_17_12.childCount

				for iter_17_6 = 0, var_17_14 - 1 do
					local var_17_15 = var_17_12:GetChild(iter_17_6)

					if var_17_15.name == "" or not string.find(var_17_15.name, "split") then
						var_17_15.gameObject:SetActive(true)
					else
						var_17_15.gameObject:SetActive(false)
					end
				end
			end

			local var_17_16 = 0.001

			if var_17_13 <= arg_14_1.time_ and arg_14_1.time_ < var_17_13 + var_17_16 then
				local var_17_17 = (arg_14_1.time_ - var_17_13) / var_17_16
				local var_17_18 = Vector3.New(0, -347, -300)

				var_17_12.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, var_17_18, var_17_17)
			end

			if arg_14_1.time_ >= var_17_13 + var_17_16 and arg_14_1.time_ < var_17_13 + var_17_16 + arg_17_0 then
				var_17_12.localPosition = Vector3.New(0, -347, -300)
			end

			local var_17_19 = 0
			local var_17_20 = 0.1

			if var_17_19 < arg_14_1.time_ and arg_14_1.time_ <= var_17_19 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_21 = arg_14_1:FormatText(StoryNameCfg[595].name)

				arg_14_1.leftNameTxt_.text = var_17_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_22 = arg_14_1:GetWordFromCfg(417081003)
				local var_17_23 = arg_14_1:FormatText(var_17_22.content)

				arg_14_1.text_.text = var_17_23

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_24 = 4
				local var_17_25 = utf8.len(var_17_23)
				local var_17_26 = var_17_24 <= 0 and var_17_20 or var_17_20 * (var_17_25 / var_17_24)

				if var_17_26 > 0 and var_17_20 < var_17_26 then
					arg_14_1.talkMaxDuration = var_17_26

					if var_17_26 + var_17_19 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_26 + var_17_19
					end
				end

				arg_14_1.text_.text = var_17_23
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081003", "story_v_out_417081.awb") ~= 0 then
					local var_17_27 = manager.audio:GetVoiceLength("story_v_out_417081", "417081003", "story_v_out_417081.awb") / 1000

					if var_17_27 + var_17_19 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_27 + var_17_19
					end

					if var_17_22.prefab_name ~= "" and arg_14_1.actors_[var_17_22.prefab_name] ~= nil then
						local var_17_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_22.prefab_name].transform, "story_v_out_417081", "417081003", "story_v_out_417081.awb")

						arg_14_1:RecordAudio("417081003", var_17_28)
						arg_14_1:RecordAudio("417081003", var_17_28)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417081", "417081003", "story_v_out_417081.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417081", "417081003", "story_v_out_417081.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_29 = math.max(var_17_20, arg_14_1.talkMaxDuration)

			if var_17_19 <= arg_14_1.time_ and arg_14_1.time_ < var_17_19 + var_17_29 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_19) / var_17_29

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_19 + var_17_29 and arg_14_1.time_ < var_17_19 + var_17_29 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play417081004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417081004
		arg_18_1.duration_ = 4.4

		local var_18_0 = {
			zh = 4.4,
			ja = 3.766
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
				arg_18_0:Play417081005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10128"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps10128 == nil then
				arg_18_1.var_.actorSpriteComps10128 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps10128 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor2.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor2.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor2.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 0.5, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps10128 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_21_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps10128 = nil
			end

			local var_21_8 = 0
			local var_21_9 = 0.575

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_10 = arg_18_1:FormatText(StoryNameCfg[1110].name)

				arg_18_1.leftNameTxt_.text = var_21_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_11 = arg_18_1:GetWordFromCfg(417081004)
				local var_21_12 = arg_18_1:FormatText(var_21_11.content)

				arg_18_1.text_.text = var_21_12

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 23
				local var_21_14 = utf8.len(var_21_12)
				local var_21_15 = var_21_13 <= 0 and var_21_9 or var_21_9 * (var_21_14 / var_21_13)

				if var_21_15 > 0 and var_21_9 < var_21_15 then
					arg_18_1.talkMaxDuration = var_21_15

					if var_21_15 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_15 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_12
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081004", "story_v_out_417081.awb") ~= 0 then
					local var_21_16 = manager.audio:GetVoiceLength("story_v_out_417081", "417081004", "story_v_out_417081.awb") / 1000

					if var_21_16 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_16 + var_21_8
					end

					if var_21_11.prefab_name ~= "" and arg_18_1.actors_[var_21_11.prefab_name] ~= nil then
						local var_21_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_11.prefab_name].transform, "story_v_out_417081", "417081004", "story_v_out_417081.awb")

						arg_18_1:RecordAudio("417081004", var_21_17)
						arg_18_1:RecordAudio("417081004", var_21_17)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417081", "417081004", "story_v_out_417081.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417081", "417081004", "story_v_out_417081.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_18 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_18 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_8) / var_21_18

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_18 and arg_18_1.time_ < var_21_8 + var_21_18 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417081005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417081005
		arg_22_1.duration_ = 5.83

		local var_22_0 = {
			zh = 5.833,
			ja = 5.666
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
				arg_22_0:Play417081006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "1034"

			if arg_22_1.actors_[var_25_0] == nil then
				local var_25_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_25_1) then
					local var_25_2 = Object.Instantiate(var_25_1, arg_22_1.canvasGo_.transform)

					var_25_2.transform:SetSiblingIndex(1)

					var_25_2.name = var_25_0
					var_25_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_22_1.actors_[var_25_0] = var_25_2

					local var_25_3 = var_25_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_22_1.isInRecall_ then
						for iter_25_0, iter_25_1 in ipairs(var_25_3) do
							iter_25_1.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_25_4 = arg_22_1.actors_["1034"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_6 = 0.2

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_25_3 then
							if arg_22_1.isInRecall_ then
								local var_25_8 = Mathf.Lerp(iter_25_3.color.r, arg_22_1.hightColor1.r, var_25_7)
								local var_25_9 = Mathf.Lerp(iter_25_3.color.g, arg_22_1.hightColor1.g, var_25_7)
								local var_25_10 = Mathf.Lerp(iter_25_3.color.b, arg_22_1.hightColor1.b, var_25_7)

								iter_25_3.color = Color.New(var_25_8, var_25_9, var_25_10)
							else
								local var_25_11 = Mathf.Lerp(iter_25_3.color.r, 1, var_25_7)

								iter_25_3.color = Color.New(var_25_11, var_25_11, var_25_11)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_5 then
						if arg_22_1.isInRecall_ then
							iter_25_5.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_12 = arg_22_1.actors_["1034"].transform
			local var_25_13 = 0

			if var_25_13 < arg_22_1.time_ and arg_22_1.time_ <= var_25_13 + arg_25_0 then
				arg_22_1.var_.moveOldPos1034 = var_25_12.localPosition
				var_25_12.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1034", 2)

				local var_25_14 = var_25_12.childCount

				for iter_25_6 = 0, var_25_14 - 1 do
					local var_25_15 = var_25_12:GetChild(iter_25_6)

					if var_25_15.name == "split_4" or not string.find(var_25_15.name, "split") then
						var_25_15.gameObject:SetActive(true)
					else
						var_25_15.gameObject:SetActive(false)
					end
				end
			end

			local var_25_16 = 0.001

			if var_25_13 <= arg_22_1.time_ and arg_22_1.time_ < var_25_13 + var_25_16 then
				local var_25_17 = (arg_22_1.time_ - var_25_13) / var_25_16
				local var_25_18 = Vector3.New(-390, -331.9, -324)

				var_25_12.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1034, var_25_18, var_25_17)
			end

			if arg_22_1.time_ >= var_25_13 + var_25_16 and arg_22_1.time_ < var_25_13 + var_25_16 + arg_25_0 then
				var_25_12.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_25_19 = arg_22_1.actors_["10128"].transform
			local var_25_20 = 0

			if var_25_20 < arg_22_1.time_ and arg_22_1.time_ <= var_25_20 + arg_25_0 then
				arg_22_1.var_.moveOldPos10128 = var_25_19.localPosition
				var_25_19.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10128", 4)

				local var_25_21 = var_25_19.childCount

				for iter_25_7 = 0, var_25_21 - 1 do
					local var_25_22 = var_25_19:GetChild(iter_25_7)

					if var_25_22.name == "" or not string.find(var_25_22.name, "split") then
						var_25_22.gameObject:SetActive(true)
					else
						var_25_22.gameObject:SetActive(false)
					end
				end
			end

			local var_25_23 = 0.001

			if var_25_20 <= arg_22_1.time_ and arg_22_1.time_ < var_25_20 + var_25_23 then
				local var_25_24 = (arg_22_1.time_ - var_25_20) / var_25_23
				local var_25_25 = Vector3.New(390, -347, -300)

				var_25_19.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10128, var_25_25, var_25_24)
			end

			if arg_22_1.time_ >= var_25_20 + var_25_23 and arg_22_1.time_ < var_25_20 + var_25_23 + arg_25_0 then
				var_25_19.localPosition = Vector3.New(390, -347, -300)
			end

			local var_25_26 = 0
			local var_25_27 = 0.725

			if var_25_26 < arg_22_1.time_ and arg_22_1.time_ <= var_25_26 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_28 = arg_22_1:FormatText(StoryNameCfg[1109].name)

				arg_22_1.leftNameTxt_.text = var_25_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_29 = arg_22_1:GetWordFromCfg(417081005)
				local var_25_30 = arg_22_1:FormatText(var_25_29.content)

				arg_22_1.text_.text = var_25_30

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_31 = 29
				local var_25_32 = utf8.len(var_25_30)
				local var_25_33 = var_25_31 <= 0 and var_25_27 or var_25_27 * (var_25_32 / var_25_31)

				if var_25_33 > 0 and var_25_27 < var_25_33 then
					arg_22_1.talkMaxDuration = var_25_33

					if var_25_33 + var_25_26 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_33 + var_25_26
					end
				end

				arg_22_1.text_.text = var_25_30
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081005", "story_v_out_417081.awb") ~= 0 then
					local var_25_34 = manager.audio:GetVoiceLength("story_v_out_417081", "417081005", "story_v_out_417081.awb") / 1000

					if var_25_34 + var_25_26 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_34 + var_25_26
					end

					if var_25_29.prefab_name ~= "" and arg_22_1.actors_[var_25_29.prefab_name] ~= nil then
						local var_25_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_29.prefab_name].transform, "story_v_out_417081", "417081005", "story_v_out_417081.awb")

						arg_22_1:RecordAudio("417081005", var_25_35)
						arg_22_1:RecordAudio("417081005", var_25_35)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417081", "417081005", "story_v_out_417081.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417081", "417081005", "story_v_out_417081.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_36 = math.max(var_25_27, arg_22_1.talkMaxDuration)

			if var_25_26 <= arg_22_1.time_ and arg_22_1.time_ < var_25_26 + var_25_36 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_26) / var_25_36

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_26 + var_25_36 and arg_22_1.time_ < var_25_26 + var_25_36 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417081006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417081006
		arg_26_1.duration_ = 8.2

		local var_26_0 = {
			zh = 6.233,
			ja = 8.2
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417081007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10128"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps10128 == nil then
				arg_26_1.var_.actorSpriteComps10128 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps10128 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								local var_29_4 = Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, var_29_3)
								local var_29_5 = Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, var_29_3)
								local var_29_6 = Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, var_29_3)

								iter_29_1.color = Color.New(var_29_4, var_29_5, var_29_6)
							else
								local var_29_7 = Mathf.Lerp(iter_29_1.color.r, 1, var_29_3)

								iter_29_1.color = Color.New(var_29_7, var_29_7, var_29_7)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps10128 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps10128 = nil
			end

			local var_29_8 = arg_26_1.actors_["1034"]
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1034 == nil then
				arg_26_1.var_.actorSpriteComps1034 = var_29_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_10 = 0.2

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_10 and not isNil(var_29_8) then
				local var_29_11 = (arg_26_1.time_ - var_29_9) / var_29_10

				if arg_26_1.var_.actorSpriteComps1034 then
					for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_29_5 then
							if arg_26_1.isInRecall_ then
								local var_29_12 = Mathf.Lerp(iter_29_5.color.r, arg_26_1.hightColor2.r, var_29_11)
								local var_29_13 = Mathf.Lerp(iter_29_5.color.g, arg_26_1.hightColor2.g, var_29_11)
								local var_29_14 = Mathf.Lerp(iter_29_5.color.b, arg_26_1.hightColor2.b, var_29_11)

								iter_29_5.color = Color.New(var_29_12, var_29_13, var_29_14)
							else
								local var_29_15 = Mathf.Lerp(iter_29_5.color.r, 0.5, var_29_11)

								iter_29_5.color = Color.New(var_29_15, var_29_15, var_29_15)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_9 + var_29_10 and arg_26_1.time_ < var_29_9 + var_29_10 + arg_29_0 and not isNil(var_29_8) and arg_26_1.var_.actorSpriteComps1034 then
				for iter_29_6, iter_29_7 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_29_7 then
						if arg_26_1.isInRecall_ then
							iter_29_7.color = arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_29_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1034 = nil
			end

			local var_29_16 = 0
			local var_29_17 = 0.8

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_18 = arg_26_1:FormatText(StoryNameCfg[595].name)

				arg_26_1.leftNameTxt_.text = var_29_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_19 = arg_26_1:GetWordFromCfg(417081006)
				local var_29_20 = arg_26_1:FormatText(var_29_19.content)

				arg_26_1.text_.text = var_29_20

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_21 = 32
				local var_29_22 = utf8.len(var_29_20)
				local var_29_23 = var_29_21 <= 0 and var_29_17 or var_29_17 * (var_29_22 / var_29_21)

				if var_29_23 > 0 and var_29_17 < var_29_23 then
					arg_26_1.talkMaxDuration = var_29_23

					if var_29_23 + var_29_16 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_16
					end
				end

				arg_26_1.text_.text = var_29_20
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081006", "story_v_out_417081.awb") ~= 0 then
					local var_29_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081006", "story_v_out_417081.awb") / 1000

					if var_29_24 + var_29_16 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_24 + var_29_16
					end

					if var_29_19.prefab_name ~= "" and arg_26_1.actors_[var_29_19.prefab_name] ~= nil then
						local var_29_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_19.prefab_name].transform, "story_v_out_417081", "417081006", "story_v_out_417081.awb")

						arg_26_1:RecordAudio("417081006", var_29_25)
						arg_26_1:RecordAudio("417081006", var_29_25)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417081", "417081006", "story_v_out_417081.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417081", "417081006", "story_v_out_417081.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_26 = math.max(var_29_17, arg_26_1.talkMaxDuration)

			if var_29_16 <= arg_26_1.time_ and arg_26_1.time_ < var_29_16 + var_29_26 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_16) / var_29_26

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_16 + var_29_26 and arg_26_1.time_ < var_29_16 + var_29_26 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417081007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417081007
		arg_30_1.duration_ = 7.47

		local var_30_0 = {
			zh = 3.633,
			ja = 7.466
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
				arg_30_0:Play417081008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1034"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 1, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_8 = arg_30_1.actors_["10128"]
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = var_33_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_10 = 0.2

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_10 and not isNil(var_33_8) then
				local var_33_11 = (arg_30_1.time_ - var_33_9) / var_33_10

				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_33_5 then
							if arg_30_1.isInRecall_ then
								local var_33_12 = Mathf.Lerp(iter_33_5.color.r, arg_30_1.hightColor2.r, var_33_11)
								local var_33_13 = Mathf.Lerp(iter_33_5.color.g, arg_30_1.hightColor2.g, var_33_11)
								local var_33_14 = Mathf.Lerp(iter_33_5.color.b, arg_30_1.hightColor2.b, var_33_11)

								iter_33_5.color = Color.New(var_33_12, var_33_13, var_33_14)
							else
								local var_33_15 = Mathf.Lerp(iter_33_5.color.r, 0.5, var_33_11)

								iter_33_5.color = Color.New(var_33_15, var_33_15, var_33_15)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_9 + var_33_10 and arg_30_1.time_ < var_33_9 + var_33_10 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_6, iter_33_7 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_7 then
						if arg_30_1.isInRecall_ then
							iter_33_7.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_16 = arg_30_1.actors_["1034"].transform
			local var_33_17 = 0

			if var_33_17 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_16.localPosition
				var_33_16.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 2)

				local var_33_18 = var_33_16.childCount

				for iter_33_8 = 0, var_33_18 - 1 do
					local var_33_19 = var_33_16:GetChild(iter_33_8)

					if var_33_19.name == "split_7" or not string.find(var_33_19.name, "split") then
						var_33_19.gameObject:SetActive(true)
					else
						var_33_19.gameObject:SetActive(false)
					end
				end
			end

			local var_33_20 = 0.001

			if var_33_17 <= arg_30_1.time_ and arg_30_1.time_ < var_33_17 + var_33_20 then
				local var_33_21 = (arg_30_1.time_ - var_33_17) / var_33_20
				local var_33_22 = Vector3.New(-390, -331.9, -324)

				var_33_16.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, var_33_22, var_33_21)
			end

			if arg_30_1.time_ >= var_33_17 + var_33_20 and arg_30_1.time_ < var_33_17 + var_33_20 + arg_33_0 then
				var_33_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_33_23 = 0
			local var_33_24 = 0.425

			if var_33_23 < arg_30_1.time_ and arg_30_1.time_ <= var_33_23 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_25 = arg_30_1:FormatText(StoryNameCfg[1109].name)

				arg_30_1.leftNameTxt_.text = var_33_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_26 = arg_30_1:GetWordFromCfg(417081007)
				local var_33_27 = arg_30_1:FormatText(var_33_26.content)

				arg_30_1.text_.text = var_33_27

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_28 = 17
				local var_33_29 = utf8.len(var_33_27)
				local var_33_30 = var_33_28 <= 0 and var_33_24 or var_33_24 * (var_33_29 / var_33_28)

				if var_33_30 > 0 and var_33_24 < var_33_30 then
					arg_30_1.talkMaxDuration = var_33_30

					if var_33_30 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_30 + var_33_23
					end
				end

				arg_30_1.text_.text = var_33_27
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081007", "story_v_out_417081.awb") ~= 0 then
					local var_33_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081007", "story_v_out_417081.awb") / 1000

					if var_33_31 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_31 + var_33_23
					end

					if var_33_26.prefab_name ~= "" and arg_30_1.actors_[var_33_26.prefab_name] ~= nil then
						local var_33_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_26.prefab_name].transform, "story_v_out_417081", "417081007", "story_v_out_417081.awb")

						arg_30_1:RecordAudio("417081007", var_33_32)
						arg_30_1:RecordAudio("417081007", var_33_32)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417081", "417081007", "story_v_out_417081.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417081", "417081007", "story_v_out_417081.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_33 = math.max(var_33_24, arg_30_1.talkMaxDuration)

			if var_33_23 <= arg_30_1.time_ and arg_30_1.time_ < var_33_23 + var_33_33 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_23) / var_33_33

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_23 + var_33_33 and arg_30_1.time_ < var_33_23 + var_33_33 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play417081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417081008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1034"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 0.5, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_8 = 0
			local var_37_9 = 0.625

			if var_37_8 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_10 = arg_34_1:GetWordFromCfg(417081008)
				local var_37_11 = arg_34_1:FormatText(var_37_10.content)

				arg_34_1.text_.text = var_37_11

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_12 = 25
				local var_37_13 = utf8.len(var_37_11)
				local var_37_14 = var_37_12 <= 0 and var_37_9 or var_37_9 * (var_37_13 / var_37_12)

				if var_37_14 > 0 and var_37_9 < var_37_14 then
					arg_34_1.talkMaxDuration = var_37_14

					if var_37_14 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_11
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_15 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_15 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_15

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_15 and arg_34_1.time_ < var_37_8 + var_37_15 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417081009
		arg_38_1.duration_ = 7.13

		local var_38_0 = {
			zh = 4.8,
			ja = 7.133
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10128"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 1, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_8 = 0
			local var_41_9 = 0.575

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_10 = arg_38_1:FormatText(StoryNameCfg[595].name)

				arg_38_1.leftNameTxt_.text = var_41_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_11 = arg_38_1:GetWordFromCfg(417081009)
				local var_41_12 = arg_38_1:FormatText(var_41_11.content)

				arg_38_1.text_.text = var_41_12

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 23
				local var_41_14 = utf8.len(var_41_12)
				local var_41_15 = var_41_13 <= 0 and var_41_9 or var_41_9 * (var_41_14 / var_41_13)

				if var_41_15 > 0 and var_41_9 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_12
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081009", "story_v_out_417081.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_out_417081", "417081009", "story_v_out_417081.awb") / 1000

					if var_41_16 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_8
					end

					if var_41_11.prefab_name ~= "" and arg_38_1.actors_[var_41_11.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_11.prefab_name].transform, "story_v_out_417081", "417081009", "story_v_out_417081.awb")

						arg_38_1:RecordAudio("417081009", var_41_17)
						arg_38_1:RecordAudio("417081009", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417081", "417081009", "story_v_out_417081.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417081", "417081009", "story_v_out_417081.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_18 and arg_38_1.time_ < var_41_8 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417081010
		arg_42_1.duration_ = 6.43

		local var_42_0 = {
			zh = 4.933,
			ja = 6.433
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
				arg_42_0:Play417081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10128"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor2.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor2.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor2.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 0.5, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_8 = 0
			local var_45_9 = 0.6

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_10 = arg_42_1:FormatText(StoryNameCfg[1110].name)

				arg_42_1.leftNameTxt_.text = var_45_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_11 = arg_42_1:GetWordFromCfg(417081010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 24
				local var_45_14 = utf8.len(var_45_12)
				local var_45_15 = var_45_13 <= 0 and var_45_9 or var_45_9 * (var_45_14 / var_45_13)

				if var_45_15 > 0 and var_45_9 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081010", "story_v_out_417081.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_417081", "417081010", "story_v_out_417081.awb") / 1000

					if var_45_16 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_8
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_417081", "417081010", "story_v_out_417081.awb")

						arg_42_1:RecordAudio("417081010", var_45_17)
						arg_42_1:RecordAudio("417081010", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417081", "417081010", "story_v_out_417081.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417081", "417081010", "story_v_out_417081.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_18 and arg_42_1.time_ < var_45_8 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417081011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417081011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417081012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10128"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos10128 = var_49_0.localPosition
				var_49_0.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("10128", 7)

				local var_49_2 = var_49_0.childCount

				for iter_49_0 = 0, var_49_2 - 1 do
					local var_49_3 = var_49_0:GetChild(iter_49_0)

					if var_49_3.name == "" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_4 then
				local var_49_5 = (arg_46_1.time_ - var_49_1) / var_49_4
				local var_49_6 = Vector3.New(0, -2000, -300)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10128, var_49_6, var_49_5)
			end

			if arg_46_1.time_ >= var_49_1 + var_49_4 and arg_46_1.time_ < var_49_1 + var_49_4 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_49_7 = arg_46_1.actors_["1034"].transform
			local var_49_8 = 0

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.var_.moveOldPos1034 = var_49_7.localPosition
				var_49_7.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1034", 7)

				local var_49_9 = var_49_7.childCount

				for iter_49_1 = 0, var_49_9 - 1 do
					local var_49_10 = var_49_7:GetChild(iter_49_1)

					if var_49_10.name == "" or not string.find(var_49_10.name, "split") then
						var_49_10.gameObject:SetActive(true)
					else
						var_49_10.gameObject:SetActive(false)
					end
				end
			end

			local var_49_11 = 0.001

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_11 then
				local var_49_12 = (arg_46_1.time_ - var_49_8) / var_49_11
				local var_49_13 = Vector3.New(0, -2000, 0)

				var_49_7.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1034, var_49_13, var_49_12)
			end

			if arg_46_1.time_ >= var_49_8 + var_49_11 and arg_46_1.time_ < var_49_8 + var_49_11 + arg_49_0 then
				var_49_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_14 = 0
			local var_49_15 = 1.7

			if var_49_14 < arg_46_1.time_ and arg_46_1.time_ <= var_49_14 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_16 = arg_46_1:GetWordFromCfg(417081011)
				local var_49_17 = arg_46_1:FormatText(var_49_16.content)

				arg_46_1.text_.text = var_49_17

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_18 = 68
				local var_49_19 = utf8.len(var_49_17)
				local var_49_20 = var_49_18 <= 0 and var_49_15 or var_49_15 * (var_49_19 / var_49_18)

				if var_49_20 > 0 and var_49_15 < var_49_20 then
					arg_46_1.talkMaxDuration = var_49_20

					if var_49_20 + var_49_14 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_14
					end
				end

				arg_46_1.text_.text = var_49_17
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_21 = math.max(var_49_15, arg_46_1.talkMaxDuration)

			if var_49_14 <= arg_46_1.time_ and arg_46_1.time_ < var_49_14 + var_49_21 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_14) / var_49_21

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_14 + var_49_21 and arg_46_1.time_ < var_49_14 + var_49_21 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play417081012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417081012
		arg_50_1.duration_ = 9.03

		local var_50_0 = {
			zh = 6.266,
			ja = 9.033
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417081013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10128"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								local var_53_4 = Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, var_53_3)
								local var_53_5 = Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, var_53_3)
								local var_53_6 = Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, var_53_3)

								iter_53_1.color = Color.New(var_53_4, var_53_5, var_53_6)
							else
								local var_53_7 = Mathf.Lerp(iter_53_1.color.r, 1, var_53_3)

								iter_53_1.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_8 = arg_50_1.actors_["10128"].transform
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.var_.moveOldPos10128 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10128", 4)

				local var_53_10 = var_53_8.childCount

				for iter_53_4 = 0, var_53_10 - 1 do
					local var_53_11 = var_53_8:GetChild(iter_53_4)

					if var_53_11.name == "split_2" or not string.find(var_53_11.name, "split") then
						var_53_11.gameObject:SetActive(true)
					else
						var_53_11.gameObject:SetActive(false)
					end
				end
			end

			local var_53_12 = 0.001

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_9) / var_53_12
				local var_53_14 = Vector3.New(390, -347, -300)

				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10128, var_53_14, var_53_13)
			end

			if arg_50_1.time_ >= var_53_9 + var_53_12 and arg_50_1.time_ < var_53_9 + var_53_12 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_53_15 = 0
			local var_53_16 = 0.825

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[595].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(417081012)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 33
				local var_53_21 = utf8.len(var_53_19)
				local var_53_22 = var_53_20 <= 0 and var_53_16 or var_53_16 * (var_53_21 / var_53_20)

				if var_53_22 > 0 and var_53_16 < var_53_22 then
					arg_50_1.talkMaxDuration = var_53_22

					if var_53_22 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_19
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081012", "story_v_out_417081.awb") ~= 0 then
					local var_53_23 = manager.audio:GetVoiceLength("story_v_out_417081", "417081012", "story_v_out_417081.awb") / 1000

					if var_53_23 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_15
					end

					if var_53_18.prefab_name ~= "" and arg_50_1.actors_[var_53_18.prefab_name] ~= nil then
						local var_53_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_18.prefab_name].transform, "story_v_out_417081", "417081012", "story_v_out_417081.awb")

						arg_50_1:RecordAudio("417081012", var_53_24)
						arg_50_1:RecordAudio("417081012", var_53_24)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417081", "417081012", "story_v_out_417081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417081", "417081012", "story_v_out_417081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_25 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_25 and arg_50_1.time_ < var_53_15 + var_53_25 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417081013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417081013
		arg_54_1.duration_ = 3.2

		local var_54_0 = {
			zh = 2.533,
			ja = 3.2
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
				arg_54_0:Play417081014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1034"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								local var_57_4 = Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, var_57_3)
								local var_57_5 = Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, var_57_3)
								local var_57_6 = Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, var_57_3)

								iter_57_1.color = Color.New(var_57_4, var_57_5, var_57_6)
							else
								local var_57_7 = Mathf.Lerp(iter_57_1.color.r, 1, var_57_3)

								iter_57_1.color = Color.New(var_57_7, var_57_7, var_57_7)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_8 = arg_54_1.actors_["10128"]
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10128 == nil then
				arg_54_1.var_.actorSpriteComps10128 = var_57_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_10 = 0.2

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_10 and not isNil(var_57_8) then
				local var_57_11 = (arg_54_1.time_ - var_57_9) / var_57_10

				if arg_54_1.var_.actorSpriteComps10128 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_57_5 then
							if arg_54_1.isInRecall_ then
								local var_57_12 = Mathf.Lerp(iter_57_5.color.r, arg_54_1.hightColor2.r, var_57_11)
								local var_57_13 = Mathf.Lerp(iter_57_5.color.g, arg_54_1.hightColor2.g, var_57_11)
								local var_57_14 = Mathf.Lerp(iter_57_5.color.b, arg_54_1.hightColor2.b, var_57_11)

								iter_57_5.color = Color.New(var_57_12, var_57_13, var_57_14)
							else
								local var_57_15 = Mathf.Lerp(iter_57_5.color.r, 0.5, var_57_11)

								iter_57_5.color = Color.New(var_57_15, var_57_15, var_57_15)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_9 + var_57_10 and arg_54_1.time_ < var_57_9 + var_57_10 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10128 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_57_7 then
						if arg_54_1.isInRecall_ then
							iter_57_7.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10128 = nil
			end

			local var_57_16 = arg_54_1.actors_["1034"].transform
			local var_57_17 = 0

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.var_.moveOldPos1034 = var_57_16.localPosition
				var_57_16.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1034", 2)

				local var_57_18 = var_57_16.childCount

				for iter_57_8 = 0, var_57_18 - 1 do
					local var_57_19 = var_57_16:GetChild(iter_57_8)

					if var_57_19.name == "split_6" or not string.find(var_57_19.name, "split") then
						var_57_19.gameObject:SetActive(true)
					else
						var_57_19.gameObject:SetActive(false)
					end
				end
			end

			local var_57_20 = 0.001

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_20 then
				local var_57_21 = (arg_54_1.time_ - var_57_17) / var_57_20
				local var_57_22 = Vector3.New(-390, -331.9, -324)

				var_57_16.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1034, var_57_22, var_57_21)
			end

			if arg_54_1.time_ >= var_57_17 + var_57_20 and arg_54_1.time_ < var_57_17 + var_57_20 + arg_57_0 then
				var_57_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_57_23 = 0
			local var_57_24 = 0.3

			if var_57_23 < arg_54_1.time_ and arg_54_1.time_ <= var_57_23 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_25 = arg_54_1:FormatText(StoryNameCfg[1109].name)

				arg_54_1.leftNameTxt_.text = var_57_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_26 = arg_54_1:GetWordFromCfg(417081013)
				local var_57_27 = arg_54_1:FormatText(var_57_26.content)

				arg_54_1.text_.text = var_57_27

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_28 = 12
				local var_57_29 = utf8.len(var_57_27)
				local var_57_30 = var_57_28 <= 0 and var_57_24 or var_57_24 * (var_57_29 / var_57_28)

				if var_57_30 > 0 and var_57_24 < var_57_30 then
					arg_54_1.talkMaxDuration = var_57_30

					if var_57_30 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_30 + var_57_23
					end
				end

				arg_54_1.text_.text = var_57_27
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081013", "story_v_out_417081.awb") ~= 0 then
					local var_57_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081013", "story_v_out_417081.awb") / 1000

					if var_57_31 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_31 + var_57_23
					end

					if var_57_26.prefab_name ~= "" and arg_54_1.actors_[var_57_26.prefab_name] ~= nil then
						local var_57_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_26.prefab_name].transform, "story_v_out_417081", "417081013", "story_v_out_417081.awb")

						arg_54_1:RecordAudio("417081013", var_57_32)
						arg_54_1:RecordAudio("417081013", var_57_32)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417081", "417081013", "story_v_out_417081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417081", "417081013", "story_v_out_417081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_33 = math.max(var_57_24, arg_54_1.talkMaxDuration)

			if var_57_23 <= arg_54_1.time_ and arg_54_1.time_ < var_57_23 + var_57_33 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_23) / var_57_33

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_23 + var_57_33 and arg_54_1.time_ < var_57_23 + var_57_33 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play417081014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417081014
		arg_58_1.duration_ = 15.57

		local var_58_0 = {
			zh = 11.666,
			ja = 15.566
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
				arg_58_0:Play417081015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10128"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 1, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_8 = arg_58_1.actors_["1034"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								local var_61_12 = Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, var_61_11)
								local var_61_13 = Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, var_61_11)
								local var_61_14 = Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, var_61_11)

								iter_61_5.color = Color.New(var_61_12, var_61_13, var_61_14)
							else
								local var_61_15 = Mathf.Lerp(iter_61_5.color.r, 0.5, var_61_11)

								iter_61_5.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_16 = 0
			local var_61_17 = 1.35

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_18 = arg_58_1:FormatText(StoryNameCfg[595].name)

				arg_58_1.leftNameTxt_.text = var_61_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_19 = arg_58_1:GetWordFromCfg(417081014)
				local var_61_20 = arg_58_1:FormatText(var_61_19.content)

				arg_58_1.text_.text = var_61_20

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_21 = 54
				local var_61_22 = utf8.len(var_61_20)
				local var_61_23 = var_61_21 <= 0 and var_61_17 or var_61_17 * (var_61_22 / var_61_21)

				if var_61_23 > 0 and var_61_17 < var_61_23 then
					arg_58_1.talkMaxDuration = var_61_23

					if var_61_23 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_16
					end
				end

				arg_58_1.text_.text = var_61_20
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081014", "story_v_out_417081.awb") ~= 0 then
					local var_61_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081014", "story_v_out_417081.awb") / 1000

					if var_61_24 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_24 + var_61_16
					end

					if var_61_19.prefab_name ~= "" and arg_58_1.actors_[var_61_19.prefab_name] ~= nil then
						local var_61_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_19.prefab_name].transform, "story_v_out_417081", "417081014", "story_v_out_417081.awb")

						arg_58_1:RecordAudio("417081014", var_61_25)
						arg_58_1:RecordAudio("417081014", var_61_25)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417081", "417081014", "story_v_out_417081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417081", "417081014", "story_v_out_417081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_26 = math.max(var_61_17, arg_58_1.talkMaxDuration)

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_26 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_16) / var_61_26

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_16 + var_61_26 and arg_58_1.time_ < var_61_16 + var_61_26 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417081015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417081015
		arg_62_1.duration_ = 4.27

		local var_62_0 = {
			zh = 2.033,
			ja = 4.266
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
				arg_62_0:Play417081016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1034"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1034 == nil then
				arg_62_1.var_.actorSpriteComps1034 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps1034 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								local var_65_4 = Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, var_65_3)
								local var_65_5 = Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, var_65_3)
								local var_65_6 = Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, var_65_3)

								iter_65_1.color = Color.New(var_65_4, var_65_5, var_65_6)
							else
								local var_65_7 = Mathf.Lerp(iter_65_1.color.r, 1, var_65_3)

								iter_65_1.color = Color.New(var_65_7, var_65_7, var_65_7)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1034 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1034 = nil
			end

			local var_65_8 = arg_62_1.actors_["10128"]
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = var_65_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_10 = 0.2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 and not isNil(var_65_8) then
				local var_65_11 = (arg_62_1.time_ - var_65_9) / var_65_10

				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								local var_65_12 = Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, var_65_11)
								local var_65_13 = Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, var_65_11)
								local var_65_14 = Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, var_65_11)

								iter_65_5.color = Color.New(var_65_12, var_65_13, var_65_14)
							else
								local var_65_15 = Mathf.Lerp(iter_65_5.color.r, 0.5, var_65_11)

								iter_65_5.color = Color.New(var_65_15, var_65_15, var_65_15)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_7 then
						if arg_62_1.isInRecall_ then
							iter_65_7.color = arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_65_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_16 = 0
			local var_65_17 = 0.15

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_18 = arg_62_1:FormatText(StoryNameCfg[1109].name)

				arg_62_1.leftNameTxt_.text = var_65_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_19 = arg_62_1:GetWordFromCfg(417081015)
				local var_65_20 = arg_62_1:FormatText(var_65_19.content)

				arg_62_1.text_.text = var_65_20

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_21 = 6
				local var_65_22 = utf8.len(var_65_20)
				local var_65_23 = var_65_21 <= 0 and var_65_17 or var_65_17 * (var_65_22 / var_65_21)

				if var_65_23 > 0 and var_65_17 < var_65_23 then
					arg_62_1.talkMaxDuration = var_65_23

					if var_65_23 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_16
					end
				end

				arg_62_1.text_.text = var_65_20
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081015", "story_v_out_417081.awb") ~= 0 then
					local var_65_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081015", "story_v_out_417081.awb") / 1000

					if var_65_24 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_24 + var_65_16
					end

					if var_65_19.prefab_name ~= "" and arg_62_1.actors_[var_65_19.prefab_name] ~= nil then
						local var_65_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_19.prefab_name].transform, "story_v_out_417081", "417081015", "story_v_out_417081.awb")

						arg_62_1:RecordAudio("417081015", var_65_25)
						arg_62_1:RecordAudio("417081015", var_65_25)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417081", "417081015", "story_v_out_417081.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417081", "417081015", "story_v_out_417081.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_26 = math.max(var_65_17, arg_62_1.talkMaxDuration)

			if var_65_16 <= arg_62_1.time_ and arg_62_1.time_ < var_65_16 + var_65_26 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_16) / var_65_26

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_16 + var_65_26 and arg_62_1.time_ < var_65_16 + var_65_26 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417081016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417081016
		arg_66_1.duration_ = 3.1

		local var_66_0 = {
			zh = 3.1,
			ja = 2.633
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417081017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10128"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps10128 == nil then
				arg_66_1.var_.actorSpriteComps10128 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps10128 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 1, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps10128 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps10128 = nil
			end

			local var_69_8 = arg_66_1.actors_["1034"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								local var_69_12 = Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, var_69_11)
								local var_69_13 = Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, var_69_11)
								local var_69_14 = Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, var_69_11)

								iter_69_5.color = Color.New(var_69_12, var_69_13, var_69_14)
							else
								local var_69_15 = Mathf.Lerp(iter_69_5.color.r, 0.5, var_69_11)

								iter_69_5.color = Color.New(var_69_15, var_69_15, var_69_15)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_16 = arg_66_1.actors_["10128"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos10128 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("10128", 4)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "split_4" or not string.find(var_69_19.name, "split") then
						var_69_19.gameObject:SetActive(true)
					else
						var_69_19.gameObject:SetActive(false)
					end
				end
			end

			local var_69_20 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(390, -347, -300)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10128, var_69_22, var_69_21)
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_69_23 = 0
			local var_69_24 = 0.3

			if var_69_23 < arg_66_1.time_ and arg_66_1.time_ <= var_69_23 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_25 = arg_66_1:FormatText(StoryNameCfg[595].name)

				arg_66_1.leftNameTxt_.text = var_69_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_26 = arg_66_1:GetWordFromCfg(417081016)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.text_.text = var_69_27

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_28 = 12
				local var_69_29 = utf8.len(var_69_27)
				local var_69_30 = var_69_28 <= 0 and var_69_24 or var_69_24 * (var_69_29 / var_69_28)

				if var_69_30 > 0 and var_69_24 < var_69_30 then
					arg_66_1.talkMaxDuration = var_69_30

					if var_69_30 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_30 + var_69_23
					end
				end

				arg_66_1.text_.text = var_69_27
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081016", "story_v_out_417081.awb") ~= 0 then
					local var_69_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081016", "story_v_out_417081.awb") / 1000

					if var_69_31 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_31 + var_69_23
					end

					if var_69_26.prefab_name ~= "" and arg_66_1.actors_[var_69_26.prefab_name] ~= nil then
						local var_69_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_26.prefab_name].transform, "story_v_out_417081", "417081016", "story_v_out_417081.awb")

						arg_66_1:RecordAudio("417081016", var_69_32)
						arg_66_1:RecordAudio("417081016", var_69_32)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417081", "417081016", "story_v_out_417081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417081", "417081016", "story_v_out_417081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_33 = math.max(var_69_24, arg_66_1.talkMaxDuration)

			if var_69_23 <= arg_66_1.time_ and arg_66_1.time_ < var_69_23 + var_69_33 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_23) / var_69_33

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_23 + var_69_33 and arg_66_1.time_ < var_69_23 + var_69_33 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play417081017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417081017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417081018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10128"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 0.5, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_8 = 0.351708099944517
			local var_73_9 = 1

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				local var_73_10 = "play"
				local var_73_11 = "effect"

				arg_70_1:AudioAction(var_73_10, var_73_11, "se_story_136", "se_story_136_car", "")
			end

			local var_73_12 = 0
			local var_73_13 = 1.225

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(417081017)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_16 = 49
				local var_73_17 = utf8.len(var_73_15)
				local var_73_18 = var_73_16 <= 0 and var_73_13 or var_73_13 * (var_73_17 / var_73_16)

				if var_73_18 > 0 and var_73_13 < var_73_18 then
					arg_70_1.talkMaxDuration = var_73_18

					if var_73_18 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_19 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_19 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_19

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_19 and arg_70_1.time_ < var_73_12 + var_73_19 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417081018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417081018
		arg_74_1.duration_ = 3.93

		local var_74_0 = {
			zh = 3.866,
			ja = 3.933
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417081019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1034"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 == nil then
				arg_74_1.var_.actorSpriteComps1034 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1034 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 1, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			local var_77_8 = arg_74_1.actors_["1034"].transform
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.var_.moveOldPos1034 = var_77_8.localPosition
				var_77_8.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1034", 2)

				local var_77_10 = var_77_8.childCount

				for iter_77_4 = 0, var_77_10 - 1 do
					local var_77_11 = var_77_8:GetChild(iter_77_4)

					if var_77_11.name == "" or not string.find(var_77_11.name, "split") then
						var_77_11.gameObject:SetActive(true)
					else
						var_77_11.gameObject:SetActive(false)
					end
				end
			end

			local var_77_12 = 0.001

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_12 then
				local var_77_13 = (arg_74_1.time_ - var_77_9) / var_77_12
				local var_77_14 = Vector3.New(-390, -331.9, -324)

				var_77_8.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1034, var_77_14, var_77_13)
			end

			if arg_74_1.time_ >= var_77_9 + var_77_12 and arg_74_1.time_ < var_77_9 + var_77_12 + arg_77_0 then
				var_77_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_77_15 = 0
			local var_77_16 = 0.225

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[1109].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(417081018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 9
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081018", "story_v_out_417081.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_417081", "417081018", "story_v_out_417081.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_417081", "417081018", "story_v_out_417081.awb")

						arg_74_1:RecordAudio("417081018", var_77_24)
						arg_74_1:RecordAudio("417081018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417081", "417081018", "story_v_out_417081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417081", "417081018", "story_v_out_417081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play417081019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417081019
		arg_78_1.duration_ = 2.07

		local var_78_0 = {
			zh = 2.066,
			ja = 1.6
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417081020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10128"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 1, var_81_3)

								iter_81_1.color = Color.New(var_81_7, var_81_7, var_81_7)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_8 = arg_78_1.actors_["1034"]
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = var_81_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_10 = 0.2

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_10 and not isNil(var_81_8) then
				local var_81_11 = (arg_78_1.time_ - var_81_9) / var_81_10

				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_81_5 then
							if arg_78_1.isInRecall_ then
								local var_81_12 = Mathf.Lerp(iter_81_5.color.r, arg_78_1.hightColor2.r, var_81_11)
								local var_81_13 = Mathf.Lerp(iter_81_5.color.g, arg_78_1.hightColor2.g, var_81_11)
								local var_81_14 = Mathf.Lerp(iter_81_5.color.b, arg_78_1.hightColor2.b, var_81_11)

								iter_81_5.color = Color.New(var_81_12, var_81_13, var_81_14)
							else
								local var_81_15 = Mathf.Lerp(iter_81_5.color.r, 0.5, var_81_11)

								iter_81_5.color = Color.New(var_81_15, var_81_15, var_81_15)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_10 and arg_78_1.time_ < var_81_9 + var_81_10 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_7 then
						if arg_78_1.isInRecall_ then
							iter_81_7.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_16 = 0
			local var_81_17 = 0.225

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_18 = arg_78_1:FormatText(StoryNameCfg[595].name)

				arg_78_1.leftNameTxt_.text = var_81_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_19 = arg_78_1:GetWordFromCfg(417081019)
				local var_81_20 = arg_78_1:FormatText(var_81_19.content)

				arg_78_1.text_.text = var_81_20

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_21 = 9
				local var_81_22 = utf8.len(var_81_20)
				local var_81_23 = var_81_21 <= 0 and var_81_17 or var_81_17 * (var_81_22 / var_81_21)

				if var_81_23 > 0 and var_81_17 < var_81_23 then
					arg_78_1.talkMaxDuration = var_81_23

					if var_81_23 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_16
					end
				end

				arg_78_1.text_.text = var_81_20
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081019", "story_v_out_417081.awb") ~= 0 then
					local var_81_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081019", "story_v_out_417081.awb") / 1000

					if var_81_24 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_16
					end

					if var_81_19.prefab_name ~= "" and arg_78_1.actors_[var_81_19.prefab_name] ~= nil then
						local var_81_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_19.prefab_name].transform, "story_v_out_417081", "417081019", "story_v_out_417081.awb")

						arg_78_1:RecordAudio("417081019", var_81_25)
						arg_78_1:RecordAudio("417081019", var_81_25)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417081", "417081019", "story_v_out_417081.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417081", "417081019", "story_v_out_417081.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_26 = math.max(var_81_17, arg_78_1.talkMaxDuration)

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_26 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_16) / var_81_26

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_16 + var_81_26 and arg_78_1.time_ < var_81_16 + var_81_26 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417081020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417081020
		arg_82_1.duration_ = 8.93

		local var_82_0 = {
			zh = 6.1,
			ja = 8.933
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
				arg_82_0:Play417081021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1034"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1034 == nil then
				arg_82_1.var_.actorSpriteComps1034 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1034 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 1, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1034 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1034 = nil
			end

			local var_85_8 = arg_82_1.actors_["10128"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10128 == nil then
				arg_82_1.var_.actorSpriteComps10128 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.2

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps10128 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 0.5, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10128 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10128 = nil
			end

			local var_85_16 = 0
			local var_85_17 = 0.725

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_18 = arg_82_1:FormatText(StoryNameCfg[1109].name)

				arg_82_1.leftNameTxt_.text = var_85_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(417081020)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 29
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_17 or var_85_17 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_17 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23

					if var_85_23 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_16
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081020", "story_v_out_417081.awb") ~= 0 then
					local var_85_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081020", "story_v_out_417081.awb") / 1000

					if var_85_24 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_16
					end

					if var_85_19.prefab_name ~= "" and arg_82_1.actors_[var_85_19.prefab_name] ~= nil then
						local var_85_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_19.prefab_name].transform, "story_v_out_417081", "417081020", "story_v_out_417081.awb")

						arg_82_1:RecordAudio("417081020", var_85_25)
						arg_82_1:RecordAudio("417081020", var_85_25)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417081", "417081020", "story_v_out_417081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417081", "417081020", "story_v_out_417081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_26 = math.max(var_85_17, arg_82_1.talkMaxDuration)

			if var_85_16 <= arg_82_1.time_ and arg_82_1.time_ < var_85_16 + var_85_26 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_16) / var_85_26

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_16 + var_85_26 and arg_82_1.time_ < var_85_16 + var_85_26 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417081021
		arg_86_1.duration_ = 11.6

		local var_86_0 = {
			zh = 10.033,
			ja = 11.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10128"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10128 == nil then
				arg_86_1.var_.actorSpriteComps10128 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10128 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 1, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10128 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10128 = nil
			end

			local var_89_8 = arg_86_1.actors_["1034"]
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1034 == nil then
				arg_86_1.var_.actorSpriteComps1034 = var_89_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_10 = 0.2

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 and not isNil(var_89_8) then
				local var_89_11 = (arg_86_1.time_ - var_89_9) / var_89_10

				if arg_86_1.var_.actorSpriteComps1034 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								local var_89_12 = Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor2.r, var_89_11)
								local var_89_13 = Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor2.g, var_89_11)
								local var_89_14 = Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor2.b, var_89_11)

								iter_89_5.color = Color.New(var_89_12, var_89_13, var_89_14)
							else
								local var_89_15 = Mathf.Lerp(iter_89_5.color.r, 0.5, var_89_11)

								iter_89_5.color = Color.New(var_89_15, var_89_15, var_89_15)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1034 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_89_7 then
						if arg_86_1.isInRecall_ then
							iter_89_7.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1034 = nil
			end

			local var_89_16 = arg_86_1.actors_["10128"].transform
			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_16.localPosition
				var_89_16.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 4)

				local var_89_18 = var_89_16.childCount

				for iter_89_8 = 0, var_89_18 - 1 do
					local var_89_19 = var_89_16:GetChild(iter_89_8)

					if var_89_19.name == "split_1" or not string.find(var_89_19.name, "split") then
						var_89_19.gameObject:SetActive(true)
					else
						var_89_19.gameObject:SetActive(false)
					end
				end
			end

			local var_89_20 = 0.001

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_20 then
				local var_89_21 = (arg_86_1.time_ - var_89_17) / var_89_20
				local var_89_22 = Vector3.New(390, -347, -300)

				var_89_16.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, var_89_22, var_89_21)
			end

			if arg_86_1.time_ >= var_89_17 + var_89_20 and arg_86_1.time_ < var_89_17 + var_89_20 + arg_89_0 then
				var_89_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_89_23 = 0
			local var_89_24 = 1.025

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_25 = arg_86_1:FormatText(StoryNameCfg[595].name)

				arg_86_1.leftNameTxt_.text = var_89_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_26 = arg_86_1:GetWordFromCfg(417081021)
				local var_89_27 = arg_86_1:FormatText(var_89_26.content)

				arg_86_1.text_.text = var_89_27

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_28 = 41
				local var_89_29 = utf8.len(var_89_27)
				local var_89_30 = var_89_28 <= 0 and var_89_24 or var_89_24 * (var_89_29 / var_89_28)

				if var_89_30 > 0 and var_89_24 < var_89_30 then
					arg_86_1.talkMaxDuration = var_89_30

					if var_89_30 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_30 + var_89_23
					end
				end

				arg_86_1.text_.text = var_89_27
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081021", "story_v_out_417081.awb") ~= 0 then
					local var_89_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081021", "story_v_out_417081.awb") / 1000

					if var_89_31 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_31 + var_89_23
					end

					if var_89_26.prefab_name ~= "" and arg_86_1.actors_[var_89_26.prefab_name] ~= nil then
						local var_89_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_26.prefab_name].transform, "story_v_out_417081", "417081021", "story_v_out_417081.awb")

						arg_86_1:RecordAudio("417081021", var_89_32)
						arg_86_1:RecordAudio("417081021", var_89_32)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417081", "417081021", "story_v_out_417081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417081", "417081021", "story_v_out_417081.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = math.max(var_89_24, arg_86_1.talkMaxDuration)

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_33 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_23) / var_89_33

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_23 + var_89_33 and arg_86_1.time_ < var_89_23 + var_89_33 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play417081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417081022
		arg_90_1.duration_ = 6.57

		local var_90_0 = {
			zh = 3.266,
			ja = 6.566
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
				arg_90_0:Play417081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1034"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1034 == nil then
				arg_90_1.var_.actorSpriteComps1034 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1034 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1034 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1034 = nil
			end

			local var_93_8 = arg_90_1.actors_["10128"]
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps10128 == nil then
				arg_90_1.var_.actorSpriteComps10128 = var_93_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_10 = 0.2

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_10 and not isNil(var_93_8) then
				local var_93_11 = (arg_90_1.time_ - var_93_9) / var_93_10

				if arg_90_1.var_.actorSpriteComps10128 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								local var_93_12 = Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor2.r, var_93_11)
								local var_93_13 = Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor2.g, var_93_11)
								local var_93_14 = Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor2.b, var_93_11)

								iter_93_5.color = Color.New(var_93_12, var_93_13, var_93_14)
							else
								local var_93_15 = Mathf.Lerp(iter_93_5.color.r, 0.5, var_93_11)

								iter_93_5.color = Color.New(var_93_15, var_93_15, var_93_15)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_9 + var_93_10 and arg_90_1.time_ < var_93_9 + var_93_10 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps10128 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_93_7 then
						if arg_90_1.isInRecall_ then
							iter_93_7.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10128 = nil
			end

			local var_93_16 = arg_90_1.actors_["1034"].transform
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.var_.moveOldPos1034 = var_93_16.localPosition
				var_93_16.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1034", 2)

				local var_93_18 = var_93_16.childCount

				for iter_93_8 = 0, var_93_18 - 1 do
					local var_93_19 = var_93_16:GetChild(iter_93_8)

					if var_93_19.name == "split_4" or not string.find(var_93_19.name, "split") then
						var_93_19.gameObject:SetActive(true)
					else
						var_93_19.gameObject:SetActive(false)
					end
				end
			end

			local var_93_20 = 0.001

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_20 then
				local var_93_21 = (arg_90_1.time_ - var_93_17) / var_93_20
				local var_93_22 = Vector3.New(-390, -331.9, -324)

				var_93_16.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1034, var_93_22, var_93_21)
			end

			if arg_90_1.time_ >= var_93_17 + var_93_20 and arg_90_1.time_ < var_93_17 + var_93_20 + arg_93_0 then
				var_93_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_93_23 = 0
			local var_93_24 = 0.325

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_25 = arg_90_1:FormatText(StoryNameCfg[1109].name)

				arg_90_1.leftNameTxt_.text = var_93_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_26 = arg_90_1:GetWordFromCfg(417081022)
				local var_93_27 = arg_90_1:FormatText(var_93_26.content)

				arg_90_1.text_.text = var_93_27

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_28 = 13
				local var_93_29 = utf8.len(var_93_27)
				local var_93_30 = var_93_28 <= 0 and var_93_24 or var_93_24 * (var_93_29 / var_93_28)

				if var_93_30 > 0 and var_93_24 < var_93_30 then
					arg_90_1.talkMaxDuration = var_93_30

					if var_93_30 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_30 + var_93_23
					end
				end

				arg_90_1.text_.text = var_93_27
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081022", "story_v_out_417081.awb") ~= 0 then
					local var_93_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081022", "story_v_out_417081.awb") / 1000

					if var_93_31 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_31 + var_93_23
					end

					if var_93_26.prefab_name ~= "" and arg_90_1.actors_[var_93_26.prefab_name] ~= nil then
						local var_93_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_26.prefab_name].transform, "story_v_out_417081", "417081022", "story_v_out_417081.awb")

						arg_90_1:RecordAudio("417081022", var_93_32)
						arg_90_1:RecordAudio("417081022", var_93_32)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417081", "417081022", "story_v_out_417081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417081", "417081022", "story_v_out_417081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_33 = math.max(var_93_24, arg_90_1.talkMaxDuration)

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_33 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_23) / var_93_33

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_23 + var_93_33 and arg_90_1.time_ < var_93_23 + var_93_33 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play417081023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417081023
		arg_94_1.duration_ = 16.03

		local var_94_0 = {
			zh = 7.966,
			ja = 16.033
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
				arg_94_0:Play417081024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.95

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1109].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(417081023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081023", "story_v_out_417081.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_417081", "417081023", "story_v_out_417081.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_417081", "417081023", "story_v_out_417081.awb")

						arg_94_1:RecordAudio("417081023", var_97_9)
						arg_94_1:RecordAudio("417081023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417081", "417081023", "story_v_out_417081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417081", "417081023", "story_v_out_417081.awb")
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
	Play417081024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417081024
		arg_98_1.duration_ = 8.9

		local var_98_0 = {
			zh = 7.6,
			ja = 8.9
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
				arg_98_0:Play417081025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.925

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[1109].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(417081024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 37
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081024", "story_v_out_417081.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417081", "417081024", "story_v_out_417081.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_417081", "417081024", "story_v_out_417081.awb")

						arg_98_1:RecordAudio("417081024", var_101_9)
						arg_98_1:RecordAudio("417081024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417081", "417081024", "story_v_out_417081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417081", "417081024", "story_v_out_417081.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417081025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417081025
		arg_102_1.duration_ = 7.77

		local var_102_0 = {
			zh = 7.766,
			ja = 7.066
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
				arg_102_0:Play417081026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1034"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1034 = var_105_0.localPosition
				var_105_0.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("1034", 2)

				local var_105_2 = var_105_0.childCount

				for iter_105_0 = 0, var_105_2 - 1 do
					local var_105_3 = var_105_0:GetChild(iter_105_0)

					if var_105_3.name == "split_6" or not string.find(var_105_3.name, "split") then
						var_105_3.gameObject:SetActive(true)
					else
						var_105_3.gameObject:SetActive(false)
					end
				end
			end

			local var_105_4 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_4 then
				local var_105_5 = (arg_102_1.time_ - var_105_1) / var_105_4
				local var_105_6 = Vector3.New(-390, -331.9, -324)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1034, var_105_6, var_105_5)
			end

			if arg_102_1.time_ >= var_105_1 + var_105_4 and arg_102_1.time_ < var_105_1 + var_105_4 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_105_7 = 0
			local var_105_8 = 0.9

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_9 = arg_102_1:FormatText(StoryNameCfg[1109].name)

				arg_102_1.leftNameTxt_.text = var_105_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(417081025)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_12 = 36
				local var_105_13 = utf8.len(var_105_11)
				local var_105_14 = var_105_12 <= 0 and var_105_8 or var_105_8 * (var_105_13 / var_105_12)

				if var_105_14 > 0 and var_105_8 < var_105_14 then
					arg_102_1.talkMaxDuration = var_105_14

					if var_105_14 + var_105_7 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_7
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081025", "story_v_out_417081.awb") ~= 0 then
					local var_105_15 = manager.audio:GetVoiceLength("story_v_out_417081", "417081025", "story_v_out_417081.awb") / 1000

					if var_105_15 + var_105_7 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_7
					end

					if var_105_10.prefab_name ~= "" and arg_102_1.actors_[var_105_10.prefab_name] ~= nil then
						local var_105_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_10.prefab_name].transform, "story_v_out_417081", "417081025", "story_v_out_417081.awb")

						arg_102_1:RecordAudio("417081025", var_105_16)
						arg_102_1:RecordAudio("417081025", var_105_16)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417081", "417081025", "story_v_out_417081.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417081", "417081025", "story_v_out_417081.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_17 = math.max(var_105_8, arg_102_1.talkMaxDuration)

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_17 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_7) / var_105_17

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_7 + var_105_17 and arg_102_1.time_ < var_105_7 + var_105_17 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play417081026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417081026
		arg_106_1.duration_ = 2.7

		local var_106_0 = {
			zh = 2.466,
			ja = 2.7
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
				arg_106_0:Play417081027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10128"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10128 == nil then
				arg_106_1.var_.actorSpriteComps10128 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps10128 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10128 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10128 = nil
			end

			local var_109_8 = arg_106_1.actors_["1034"]
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps1034 == nil then
				arg_106_1.var_.actorSpriteComps1034 = var_109_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_10 = 0.2

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_10 and not isNil(var_109_8) then
				local var_109_11 = (arg_106_1.time_ - var_109_9) / var_109_10

				if arg_106_1.var_.actorSpriteComps1034 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								local var_109_12 = Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, var_109_11)
								local var_109_13 = Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, var_109_11)
								local var_109_14 = Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, var_109_11)

								iter_109_5.color = Color.New(var_109_12, var_109_13, var_109_14)
							else
								local var_109_15 = Mathf.Lerp(iter_109_5.color.r, 0.5, var_109_11)

								iter_109_5.color = Color.New(var_109_15, var_109_15, var_109_15)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_9 + var_109_10 and arg_106_1.time_ < var_109_9 + var_109_10 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps1034 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_109_7 then
						if arg_106_1.isInRecall_ then
							iter_109_7.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1034 = nil
			end

			local var_109_16 = 0
			local var_109_17 = 0.35

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_18 = arg_106_1:FormatText(StoryNameCfg[595].name)

				arg_106_1.leftNameTxt_.text = var_109_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_19 = arg_106_1:GetWordFromCfg(417081026)
				local var_109_20 = arg_106_1:FormatText(var_109_19.content)

				arg_106_1.text_.text = var_109_20

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_21 = 14
				local var_109_22 = utf8.len(var_109_20)
				local var_109_23 = var_109_21 <= 0 and var_109_17 or var_109_17 * (var_109_22 / var_109_21)

				if var_109_23 > 0 and var_109_17 < var_109_23 then
					arg_106_1.talkMaxDuration = var_109_23

					if var_109_23 + var_109_16 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_16
					end
				end

				arg_106_1.text_.text = var_109_20
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081026", "story_v_out_417081.awb") ~= 0 then
					local var_109_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081026", "story_v_out_417081.awb") / 1000

					if var_109_24 + var_109_16 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_24 + var_109_16
					end

					if var_109_19.prefab_name ~= "" and arg_106_1.actors_[var_109_19.prefab_name] ~= nil then
						local var_109_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_19.prefab_name].transform, "story_v_out_417081", "417081026", "story_v_out_417081.awb")

						arg_106_1:RecordAudio("417081026", var_109_25)
						arg_106_1:RecordAudio("417081026", var_109_25)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417081", "417081026", "story_v_out_417081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417081", "417081026", "story_v_out_417081.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_26 = math.max(var_109_17, arg_106_1.talkMaxDuration)

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_26 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_16) / var_109_26

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_16 + var_109_26 and arg_106_1.time_ < var_109_16 + var_109_26 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417081027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417081027
		arg_110_1.duration_ = 8.9

		local var_110_0 = {
			zh = 5.166,
			ja = 8.9
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play417081028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1034"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1034 == nil then
				arg_110_1.var_.actorSpriteComps1034 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps1034 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 1, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1034 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1034 = nil
			end

			local var_113_8 = arg_110_1.actors_["10128"]
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps10128 == nil then
				arg_110_1.var_.actorSpriteComps10128 = var_113_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_10 = 0.2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 and not isNil(var_113_8) then
				local var_113_11 = (arg_110_1.time_ - var_113_9) / var_113_10

				if arg_110_1.var_.actorSpriteComps10128 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								local var_113_12 = Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor2.r, var_113_11)
								local var_113_13 = Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor2.g, var_113_11)
								local var_113_14 = Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor2.b, var_113_11)

								iter_113_5.color = Color.New(var_113_12, var_113_13, var_113_14)
							else
								local var_113_15 = Mathf.Lerp(iter_113_5.color.r, 0.5, var_113_11)

								iter_113_5.color = Color.New(var_113_15, var_113_15, var_113_15)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps10128 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_113_7 then
						if arg_110_1.isInRecall_ then
							iter_113_7.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps10128 = nil
			end

			local var_113_16 = arg_110_1.actors_["1034"].transform
			local var_113_17 = 0

			if var_113_17 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.var_.moveOldPos1034 = var_113_16.localPosition
				var_113_16.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1034", 2)

				local var_113_18 = var_113_16.childCount

				for iter_113_8 = 0, var_113_18 - 1 do
					local var_113_19 = var_113_16:GetChild(iter_113_8)

					if var_113_19.name == "" or not string.find(var_113_19.name, "split") then
						var_113_19.gameObject:SetActive(true)
					else
						var_113_19.gameObject:SetActive(false)
					end
				end
			end

			local var_113_20 = 0.001

			if var_113_17 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_20 then
				local var_113_21 = (arg_110_1.time_ - var_113_17) / var_113_20
				local var_113_22 = Vector3.New(-390, -331.9, -324)

				var_113_16.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1034, var_113_22, var_113_21)
			end

			if arg_110_1.time_ >= var_113_17 + var_113_20 and arg_110_1.time_ < var_113_17 + var_113_20 + arg_113_0 then
				var_113_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_113_23 = 0
			local var_113_24 = 0.575

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_25 = arg_110_1:FormatText(StoryNameCfg[1109].name)

				arg_110_1.leftNameTxt_.text = var_113_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_26 = arg_110_1:GetWordFromCfg(417081027)
				local var_113_27 = arg_110_1:FormatText(var_113_26.content)

				arg_110_1.text_.text = var_113_27

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_28 = 23
				local var_113_29 = utf8.len(var_113_27)
				local var_113_30 = var_113_28 <= 0 and var_113_24 or var_113_24 * (var_113_29 / var_113_28)

				if var_113_30 > 0 and var_113_24 < var_113_30 then
					arg_110_1.talkMaxDuration = var_113_30

					if var_113_30 + var_113_23 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_30 + var_113_23
					end
				end

				arg_110_1.text_.text = var_113_27
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081027", "story_v_out_417081.awb") ~= 0 then
					local var_113_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081027", "story_v_out_417081.awb") / 1000

					if var_113_31 + var_113_23 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_23
					end

					if var_113_26.prefab_name ~= "" and arg_110_1.actors_[var_113_26.prefab_name] ~= nil then
						local var_113_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_26.prefab_name].transform, "story_v_out_417081", "417081027", "story_v_out_417081.awb")

						arg_110_1:RecordAudio("417081027", var_113_32)
						arg_110_1:RecordAudio("417081027", var_113_32)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417081", "417081027", "story_v_out_417081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417081", "417081027", "story_v_out_417081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_33 = math.max(var_113_24, arg_110_1.talkMaxDuration)

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_33 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_23) / var_113_33

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_23 + var_113_33 and arg_110_1.time_ < var_113_23 + var_113_33 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play417081028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417081028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417081029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1034"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1034 == nil then
				arg_114_1.var_.actorSpriteComps1034 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps1034 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 0.5, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1034 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps1034 = nil
			end

			local var_117_8 = arg_114_1.actors_["10128"].transform
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.var_.moveOldPos10128 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10128", 7)

				local var_117_10 = var_117_8.childCount

				for iter_117_4 = 0, var_117_10 - 1 do
					local var_117_11 = var_117_8:GetChild(iter_117_4)

					if var_117_11.name == "" or not string.find(var_117_11.name, "split") then
						var_117_11.gameObject:SetActive(true)
					else
						var_117_11.gameObject:SetActive(false)
					end
				end
			end

			local var_117_12 = 0.001

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_12 then
				local var_117_13 = (arg_114_1.time_ - var_117_9) / var_117_12
				local var_117_14 = Vector3.New(0, -2000, -300)

				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10128, var_117_14, var_117_13)
			end

			if arg_114_1.time_ >= var_117_9 + var_117_12 and arg_114_1.time_ < var_117_9 + var_117_12 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_117_15 = arg_114_1.actors_["1034"].transform
			local var_117_16 = 0

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.var_.moveOldPos1034 = var_117_15.localPosition
				var_117_15.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("1034", 7)

				local var_117_17 = var_117_15.childCount

				for iter_117_5 = 0, var_117_17 - 1 do
					local var_117_18 = var_117_15:GetChild(iter_117_5)

					if var_117_18.name == "" or not string.find(var_117_18.name, "split") then
						var_117_18.gameObject:SetActive(true)
					else
						var_117_18.gameObject:SetActive(false)
					end
				end
			end

			local var_117_19 = 0.001

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_16) / var_117_19
				local var_117_21 = Vector3.New(0, -2000, 0)

				var_117_15.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1034, var_117_21, var_117_20)
			end

			if arg_114_1.time_ >= var_117_16 + var_117_19 and arg_114_1.time_ < var_117_16 + var_117_19 + arg_117_0 then
				var_117_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_22 = 0.2
			local var_117_23 = 1

			if var_117_22 < arg_114_1.time_ and arg_114_1.time_ <= var_117_22 + arg_117_0 then
				local var_117_24 = "play"
				local var_117_25 = "effect"

				arg_114_1:AudioAction(var_117_24, var_117_25, "se_story_1310", "se_story_1310_footstep08", "")
			end

			local var_117_26 = 0
			local var_117_27 = 1.325

			if var_117_26 < arg_114_1.time_ and arg_114_1.time_ <= var_117_26 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_28 = arg_114_1:GetWordFromCfg(417081028)
				local var_117_29 = arg_114_1:FormatText(var_117_28.content)

				arg_114_1.text_.text = var_117_29

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_30 = 53
				local var_117_31 = utf8.len(var_117_29)
				local var_117_32 = var_117_30 <= 0 and var_117_27 or var_117_27 * (var_117_31 / var_117_30)

				if var_117_32 > 0 and var_117_27 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32

					if var_117_32 + var_117_26 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_26
					end
				end

				arg_114_1.text_.text = var_117_29
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = math.max(var_117_27, arg_114_1.talkMaxDuration)

			if var_117_26 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_33 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_33

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_33 and arg_114_1.time_ < var_117_26 + var_117_33 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play417081029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417081029
		arg_118_1.duration_ = 1.73

		local var_118_0 = {
			zh = 1.3,
			ja = 1.733
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play417081030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10128"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10128 == nil then
				arg_118_1.var_.actorSpriteComps10128 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps10128 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10128 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps10128 = nil
			end

			local var_121_8 = arg_118_1.actors_["10128"].transform
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.var_.moveOldPos10128 = var_121_8.localPosition
				var_121_8.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10128", 3)

				local var_121_10 = var_121_8.childCount

				for iter_121_4 = 0, var_121_10 - 1 do
					local var_121_11 = var_121_8:GetChild(iter_121_4)

					if var_121_11.name == "split_6" or not string.find(var_121_11.name, "split") then
						var_121_11.gameObject:SetActive(true)
					else
						var_121_11.gameObject:SetActive(false)
					end
				end
			end

			local var_121_12 = 0.001

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_9) / var_121_12
				local var_121_14 = Vector3.New(0, -347, -300)

				var_121_8.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10128, var_121_14, var_121_13)
			end

			if arg_118_1.time_ >= var_121_9 + var_121_12 and arg_118_1.time_ < var_121_9 + var_121_12 + arg_121_0 then
				var_121_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_121_15 = 0
			local var_121_16 = 0.125

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[595].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(417081029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 5
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081029", "story_v_out_417081.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_417081", "417081029", "story_v_out_417081.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_417081", "417081029", "story_v_out_417081.awb")

						arg_118_1:RecordAudio("417081029", var_121_24)
						arg_118_1:RecordAudio("417081029", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417081", "417081029", "story_v_out_417081.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417081", "417081029", "story_v_out_417081.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play417081030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417081030
		arg_122_1.duration_ = 8.1

		local var_122_0 = {
			zh = 3.8,
			ja = 8.1
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
				arg_122_0:Play417081031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10128"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps10128 == nil then
				arg_122_1.var_.actorSpriteComps10128 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps10128 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 0.5, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps10128 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps10128 = nil
			end

			local var_125_8 = 0
			local var_125_9 = 0.475

			if var_125_8 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_10 = arg_122_1:FormatText(StoryNameCfg[1110].name)

				arg_122_1.leftNameTxt_.text = var_125_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_11 = arg_122_1:GetWordFromCfg(417081030)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 19
				local var_125_14 = utf8.len(var_125_12)
				local var_125_15 = var_125_13 <= 0 and var_125_9 or var_125_9 * (var_125_14 / var_125_13)

				if var_125_15 > 0 and var_125_9 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081030", "story_v_out_417081.awb") ~= 0 then
					local var_125_16 = manager.audio:GetVoiceLength("story_v_out_417081", "417081030", "story_v_out_417081.awb") / 1000

					if var_125_16 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_16 + var_125_8
					end

					if var_125_11.prefab_name ~= "" and arg_122_1.actors_[var_125_11.prefab_name] ~= nil then
						local var_125_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_11.prefab_name].transform, "story_v_out_417081", "417081030", "story_v_out_417081.awb")

						arg_122_1:RecordAudio("417081030", var_125_17)
						arg_122_1:RecordAudio("417081030", var_125_17)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417081", "417081030", "story_v_out_417081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417081", "417081030", "story_v_out_417081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_18 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_18 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_18

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_18 and arg_122_1.time_ < var_125_8 + var_125_18 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417081031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417081031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417081032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.5
			local var_129_1 = 1

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				local var_129_2 = "play"
				local var_129_3 = "effect"

				arg_126_1:AudioAction(var_129_2, var_129_3, "se_story_1310", "se_story_1310_surround02", "")
			end

			local var_129_4 = 0
			local var_129_5 = 1.65

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(417081031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 66
				local var_129_9 = utf8.len(var_129_7)
				local var_129_10 = var_129_8 <= 0 and var_129_5 or var_129_5 * (var_129_9 / var_129_8)

				if var_129_10 > 0 and var_129_5 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_11 and arg_126_1.time_ < var_129_4 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417081032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417081032
		arg_130_1.duration_ = 2.27

		local var_130_0 = {
			zh = 2.266,
			ja = 2.066
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
				arg_130_0:Play417081033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "1052"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(var_133_1, arg_130_1.canvasGo_.transform)

					var_133_2.transform:SetSiblingIndex(1)

					var_133_2.name = var_133_0
					var_133_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_130_1.actors_[var_133_0] = var_133_2

					local var_133_3 = var_133_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_130_1.isInRecall_ then
						for iter_133_0, iter_133_1 in ipairs(var_133_3) do
							iter_133_1.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_133_4 = arg_130_1.actors_["1052"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.actorSpriteComps1052 == nil then
				arg_130_1.var_.actorSpriteComps1052 = var_133_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_6 = 0.2

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.actorSpriteComps1052 then
					for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_133_3 then
							if arg_130_1.isInRecall_ then
								local var_133_8 = Mathf.Lerp(iter_133_3.color.r, arg_130_1.hightColor1.r, var_133_7)
								local var_133_9 = Mathf.Lerp(iter_133_3.color.g, arg_130_1.hightColor1.g, var_133_7)
								local var_133_10 = Mathf.Lerp(iter_133_3.color.b, arg_130_1.hightColor1.b, var_133_7)

								iter_133_3.color = Color.New(var_133_8, var_133_9, var_133_10)
							else
								local var_133_11 = Mathf.Lerp(iter_133_3.color.r, 1, var_133_7)

								iter_133_3.color = Color.New(var_133_11, var_133_11, var_133_11)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.actorSpriteComps1052 then
				for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_133_5 then
						if arg_130_1.isInRecall_ then
							iter_133_5.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_133_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1052 = nil
			end

			local var_133_12 = 0
			local var_133_13 = 0.325

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[36].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_15 = arg_130_1:GetWordFromCfg(417081032)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 13
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081032", "story_v_out_417081.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_417081", "417081032", "story_v_out_417081.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_417081", "417081032", "story_v_out_417081.awb")

						arg_130_1:RecordAudio("417081032", var_133_21)
						arg_130_1:RecordAudio("417081032", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417081", "417081032", "story_v_out_417081.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417081", "417081032", "story_v_out_417081.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417081033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417081033
		arg_134_1.duration_ = 2.3

		local var_134_0 = {
			zh = 1.566,
			ja = 2.3
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
				arg_134_0:Play417081034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10128"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10128 == nil then
				arg_134_1.var_.actorSpriteComps10128 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps10128 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 1, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10128 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10128 = nil
			end

			local var_137_8 = arg_134_1.actors_["1052"]
			local var_137_9 = 0

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps1052 == nil then
				arg_134_1.var_.actorSpriteComps1052 = var_137_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_10 = 0.2

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_10 and not isNil(var_137_8) then
				local var_137_11 = (arg_134_1.time_ - var_137_9) / var_137_10

				if arg_134_1.var_.actorSpriteComps1052 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_137_5 then
							if arg_134_1.isInRecall_ then
								local var_137_12 = Mathf.Lerp(iter_137_5.color.r, arg_134_1.hightColor2.r, var_137_11)
								local var_137_13 = Mathf.Lerp(iter_137_5.color.g, arg_134_1.hightColor2.g, var_137_11)
								local var_137_14 = Mathf.Lerp(iter_137_5.color.b, arg_134_1.hightColor2.b, var_137_11)

								iter_137_5.color = Color.New(var_137_12, var_137_13, var_137_14)
							else
								local var_137_15 = Mathf.Lerp(iter_137_5.color.r, 0.5, var_137_11)

								iter_137_5.color = Color.New(var_137_15, var_137_15, var_137_15)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_9 + var_137_10 and arg_134_1.time_ < var_137_9 + var_137_10 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps1052 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_137_7 then
						if arg_134_1.isInRecall_ then
							iter_137_7.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1052 = nil
			end

			local var_137_16 = arg_134_1.actors_["10128"].transform
			local var_137_17 = 0

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.var_.moveOldPos10128 = var_137_16.localPosition
				var_137_16.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("10128", 3)

				local var_137_18 = var_137_16.childCount

				for iter_137_8 = 0, var_137_18 - 1 do
					local var_137_19 = var_137_16:GetChild(iter_137_8)

					if var_137_19.name == "" or not string.find(var_137_19.name, "split") then
						var_137_19.gameObject:SetActive(true)
					else
						var_137_19.gameObject:SetActive(false)
					end
				end
			end

			local var_137_20 = 0.001

			if var_137_17 <= arg_134_1.time_ and arg_134_1.time_ < var_137_17 + var_137_20 then
				local var_137_21 = (arg_134_1.time_ - var_137_17) / var_137_20
				local var_137_22 = Vector3.New(0, -347, -300)

				var_137_16.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10128, var_137_22, var_137_21)
			end

			if arg_134_1.time_ >= var_137_17 + var_137_20 and arg_134_1.time_ < var_137_17 + var_137_20 + arg_137_0 then
				var_137_16.localPosition = Vector3.New(0, -347, -300)
			end

			local var_137_23 = 0
			local var_137_24 = 0.175

			if var_137_23 < arg_134_1.time_ and arg_134_1.time_ <= var_137_23 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_25 = arg_134_1:FormatText(StoryNameCfg[595].name)

				arg_134_1.leftNameTxt_.text = var_137_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_26 = arg_134_1:GetWordFromCfg(417081033)
				local var_137_27 = arg_134_1:FormatText(var_137_26.content)

				arg_134_1.text_.text = var_137_27

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_28 = 7
				local var_137_29 = utf8.len(var_137_27)
				local var_137_30 = var_137_28 <= 0 and var_137_24 or var_137_24 * (var_137_29 / var_137_28)

				if var_137_30 > 0 and var_137_24 < var_137_30 then
					arg_134_1.talkMaxDuration = var_137_30

					if var_137_30 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_30 + var_137_23
					end
				end

				arg_134_1.text_.text = var_137_27
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081033", "story_v_out_417081.awb") ~= 0 then
					local var_137_31 = manager.audio:GetVoiceLength("story_v_out_417081", "417081033", "story_v_out_417081.awb") / 1000

					if var_137_31 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_31 + var_137_23
					end

					if var_137_26.prefab_name ~= "" and arg_134_1.actors_[var_137_26.prefab_name] ~= nil then
						local var_137_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_26.prefab_name].transform, "story_v_out_417081", "417081033", "story_v_out_417081.awb")

						arg_134_1:RecordAudio("417081033", var_137_32)
						arg_134_1:RecordAudio("417081033", var_137_32)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417081", "417081033", "story_v_out_417081.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417081", "417081033", "story_v_out_417081.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_33 = math.max(var_137_24, arg_134_1.talkMaxDuration)

			if var_137_23 <= arg_134_1.time_ and arg_134_1.time_ < var_137_23 + var_137_33 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_23) / var_137_33

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_23 + var_137_33 and arg_134_1.time_ < var_137_23 + var_137_33 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play417081034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417081034
		arg_138_1.duration_ = 7.37

		local var_138_0 = {
			zh = 3.4,
			ja = 7.366
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417081035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = "10113"

			if arg_138_1.actors_[var_141_0] == nil then
				local var_141_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_141_1) then
					local var_141_2 = Object.Instantiate(var_141_1, arg_138_1.canvasGo_.transform)

					var_141_2.transform:SetSiblingIndex(1)

					var_141_2.name = var_141_0
					var_141_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_138_1.actors_[var_141_0] = var_141_2

					local var_141_3 = var_141_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_138_1.isInRecall_ then
						for iter_141_0, iter_141_1 in ipairs(var_141_3) do
							iter_141_1.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_141_4 = arg_138_1.actors_["10113"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.actorSpriteComps10113 == nil then
				arg_138_1.var_.actorSpriteComps10113 = var_141_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_6 = 0.2

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.actorSpriteComps10113 then
					for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_141_3 then
							if arg_138_1.isInRecall_ then
								local var_141_8 = Mathf.Lerp(iter_141_3.color.r, arg_138_1.hightColor1.r, var_141_7)
								local var_141_9 = Mathf.Lerp(iter_141_3.color.g, arg_138_1.hightColor1.g, var_141_7)
								local var_141_10 = Mathf.Lerp(iter_141_3.color.b, arg_138_1.hightColor1.b, var_141_7)

								iter_141_3.color = Color.New(var_141_8, var_141_9, var_141_10)
							else
								local var_141_11 = Mathf.Lerp(iter_141_3.color.r, 1, var_141_7)

								iter_141_3.color = Color.New(var_141_11, var_141_11, var_141_11)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.actorSpriteComps10113 then
				for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_141_5 then
						if arg_138_1.isInRecall_ then
							iter_141_5.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10113 = nil
			end

			local var_141_12 = arg_138_1.actors_["10128"]
			local var_141_13 = 0

			if var_141_13 < arg_138_1.time_ and arg_138_1.time_ <= var_141_13 + arg_141_0 and not isNil(var_141_12) and arg_138_1.var_.actorSpriteComps10128 == nil then
				arg_138_1.var_.actorSpriteComps10128 = var_141_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_14 = 0.2

			if var_141_13 <= arg_138_1.time_ and arg_138_1.time_ < var_141_13 + var_141_14 and not isNil(var_141_12) then
				local var_141_15 = (arg_138_1.time_ - var_141_13) / var_141_14

				if arg_138_1.var_.actorSpriteComps10128 then
					for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_141_7 then
							if arg_138_1.isInRecall_ then
								local var_141_16 = Mathf.Lerp(iter_141_7.color.r, arg_138_1.hightColor2.r, var_141_15)
								local var_141_17 = Mathf.Lerp(iter_141_7.color.g, arg_138_1.hightColor2.g, var_141_15)
								local var_141_18 = Mathf.Lerp(iter_141_7.color.b, arg_138_1.hightColor2.b, var_141_15)

								iter_141_7.color = Color.New(var_141_16, var_141_17, var_141_18)
							else
								local var_141_19 = Mathf.Lerp(iter_141_7.color.r, 0.5, var_141_15)

								iter_141_7.color = Color.New(var_141_19, var_141_19, var_141_19)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_13 + var_141_14 and arg_138_1.time_ < var_141_13 + var_141_14 + arg_141_0 and not isNil(var_141_12) and arg_138_1.var_.actorSpriteComps10128 then
				for iter_141_8, iter_141_9 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_141_9 then
						if arg_138_1.isInRecall_ then
							iter_141_9.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10128 = nil
			end

			local var_141_20 = arg_138_1.actors_["10113"].transform
			local var_141_21 = 0

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.var_.moveOldPos10113 = var_141_20.localPosition
				var_141_20.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10113", 3)

				local var_141_22 = var_141_20.childCount

				for iter_141_10 = 0, var_141_22 - 1 do
					local var_141_23 = var_141_20:GetChild(iter_141_10)

					if var_141_23.name == "" or not string.find(var_141_23.name, "split") then
						var_141_23.gameObject:SetActive(true)
					else
						var_141_23.gameObject:SetActive(false)
					end
				end
			end

			local var_141_24 = 0.001

			if var_141_21 <= arg_138_1.time_ and arg_138_1.time_ < var_141_21 + var_141_24 then
				local var_141_25 = (arg_138_1.time_ - var_141_21) / var_141_24
				local var_141_26 = Vector3.New(-30.38, -328.4, -517.4)

				var_141_20.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10113, var_141_26, var_141_25)
			end

			if arg_138_1.time_ >= var_141_21 + var_141_24 and arg_138_1.time_ < var_141_21 + var_141_24 + arg_141_0 then
				var_141_20.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_141_27 = arg_138_1.actors_["10128"].transform
			local var_141_28 = 0

			if var_141_28 < arg_138_1.time_ and arg_138_1.time_ <= var_141_28 + arg_141_0 then
				arg_138_1.var_.moveOldPos10128 = var_141_27.localPosition
				var_141_27.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10128", 7)

				local var_141_29 = var_141_27.childCount

				for iter_141_11 = 0, var_141_29 - 1 do
					local var_141_30 = var_141_27:GetChild(iter_141_11)

					if var_141_30.name == "" or not string.find(var_141_30.name, "split") then
						var_141_30.gameObject:SetActive(true)
					else
						var_141_30.gameObject:SetActive(false)
					end
				end
			end

			local var_141_31 = 0.001

			if var_141_28 <= arg_138_1.time_ and arg_138_1.time_ < var_141_28 + var_141_31 then
				local var_141_32 = (arg_138_1.time_ - var_141_28) / var_141_31
				local var_141_33 = Vector3.New(0, -2000, -300)

				var_141_27.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10128, var_141_33, var_141_32)
			end

			if arg_138_1.time_ >= var_141_28 + var_141_31 and arg_138_1.time_ < var_141_28 + var_141_31 + arg_141_0 then
				var_141_27.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_141_34 = 0
			local var_141_35 = 0.4

			if var_141_34 < arg_138_1.time_ and arg_138_1.time_ <= var_141_34 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_36 = arg_138_1:FormatText(StoryNameCfg[1117].name)

				arg_138_1.leftNameTxt_.text = var_141_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_37 = arg_138_1:GetWordFromCfg(417081034)
				local var_141_38 = arg_138_1:FormatText(var_141_37.content)

				arg_138_1.text_.text = var_141_38

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_39 = 16
				local var_141_40 = utf8.len(var_141_38)
				local var_141_41 = var_141_39 <= 0 and var_141_35 or var_141_35 * (var_141_40 / var_141_39)

				if var_141_41 > 0 and var_141_35 < var_141_41 then
					arg_138_1.talkMaxDuration = var_141_41

					if var_141_41 + var_141_34 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_41 + var_141_34
					end
				end

				arg_138_1.text_.text = var_141_38
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081034", "story_v_out_417081.awb") ~= 0 then
					local var_141_42 = manager.audio:GetVoiceLength("story_v_out_417081", "417081034", "story_v_out_417081.awb") / 1000

					if var_141_42 + var_141_34 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_42 + var_141_34
					end

					if var_141_37.prefab_name ~= "" and arg_138_1.actors_[var_141_37.prefab_name] ~= nil then
						local var_141_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_37.prefab_name].transform, "story_v_out_417081", "417081034", "story_v_out_417081.awb")

						arg_138_1:RecordAudio("417081034", var_141_43)
						arg_138_1:RecordAudio("417081034", var_141_43)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417081", "417081034", "story_v_out_417081.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417081", "417081034", "story_v_out_417081.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_44 = math.max(var_141_35, arg_138_1.talkMaxDuration)

			if var_141_34 <= arg_138_1.time_ and arg_138_1.time_ < var_141_34 + var_141_44 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_34) / var_141_44

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_34 + var_141_44 and arg_138_1.time_ < var_141_34 + var_141_44 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play417081035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417081035
		arg_142_1.duration_ = 3.8

		local var_142_0 = {
			zh = 3.8,
			ja = 3.2
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
				arg_142_0:Play417081036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10128"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10128 == nil then
				arg_142_1.var_.actorSpriteComps10128 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps10128 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								local var_145_4 = Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, var_145_3)
								local var_145_5 = Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, var_145_3)
								local var_145_6 = Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, var_145_3)

								iter_145_1.color = Color.New(var_145_4, var_145_5, var_145_6)
							else
								local var_145_7 = Mathf.Lerp(iter_145_1.color.r, 1, var_145_3)

								iter_145_1.color = Color.New(var_145_7, var_145_7, var_145_7)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10128 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_145_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10128 = nil
			end

			local var_145_8 = arg_142_1.actors_["10113"]
			local var_145_9 = 0

			if var_145_9 < arg_142_1.time_ and arg_142_1.time_ <= var_145_9 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps10113 == nil then
				arg_142_1.var_.actorSpriteComps10113 = var_145_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_10 = 0.2

			if var_145_9 <= arg_142_1.time_ and arg_142_1.time_ < var_145_9 + var_145_10 and not isNil(var_145_8) then
				local var_145_11 = (arg_142_1.time_ - var_145_9) / var_145_10

				if arg_142_1.var_.actorSpriteComps10113 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								local var_145_12 = Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, var_145_11)
								local var_145_13 = Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, var_145_11)
								local var_145_14 = Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, var_145_11)

								iter_145_5.color = Color.New(var_145_12, var_145_13, var_145_14)
							else
								local var_145_15 = Mathf.Lerp(iter_145_5.color.r, 0.5, var_145_11)

								iter_145_5.color = Color.New(var_145_15, var_145_15, var_145_15)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_9 + var_145_10 and arg_142_1.time_ < var_145_9 + var_145_10 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps10113 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_145_7 then
						if arg_142_1.isInRecall_ then
							iter_145_7.color = arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_145_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10113 = nil
			end

			local var_145_16 = arg_142_1.actors_["10113"].transform
			local var_145_17 = 0

			if var_145_17 < arg_142_1.time_ and arg_142_1.time_ <= var_145_17 + arg_145_0 then
				arg_142_1.var_.moveOldPos10113 = var_145_16.localPosition
				var_145_16.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10113", 7)

				local var_145_18 = var_145_16.childCount

				for iter_145_8 = 0, var_145_18 - 1 do
					local var_145_19 = var_145_16:GetChild(iter_145_8)

					if var_145_19.name == "" or not string.find(var_145_19.name, "split") then
						var_145_19.gameObject:SetActive(true)
					else
						var_145_19.gameObject:SetActive(false)
					end
				end
			end

			local var_145_20 = 0.001

			if var_145_17 <= arg_142_1.time_ and arg_142_1.time_ < var_145_17 + var_145_20 then
				local var_145_21 = (arg_142_1.time_ - var_145_17) / var_145_20
				local var_145_22 = Vector3.New(0, -2000, 0)

				var_145_16.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10113, var_145_22, var_145_21)
			end

			if arg_142_1.time_ >= var_145_17 + var_145_20 and arg_142_1.time_ < var_145_17 + var_145_20 + arg_145_0 then
				var_145_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_145_23 = arg_142_1.actors_["10128"].transform
			local var_145_24 = 0

			if var_145_24 < arg_142_1.time_ and arg_142_1.time_ <= var_145_24 + arg_145_0 then
				arg_142_1.var_.moveOldPos10128 = var_145_23.localPosition
				var_145_23.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10128", 3)

				local var_145_25 = var_145_23.childCount

				for iter_145_9 = 0, var_145_25 - 1 do
					local var_145_26 = var_145_23:GetChild(iter_145_9)

					if var_145_26.name == "" or not string.find(var_145_26.name, "split") then
						var_145_26.gameObject:SetActive(true)
					else
						var_145_26.gameObject:SetActive(false)
					end
				end
			end

			local var_145_27 = 0.001

			if var_145_24 <= arg_142_1.time_ and arg_142_1.time_ < var_145_24 + var_145_27 then
				local var_145_28 = (arg_142_1.time_ - var_145_24) / var_145_27
				local var_145_29 = Vector3.New(0, -347, -300)

				var_145_23.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10128, var_145_29, var_145_28)
			end

			if arg_142_1.time_ >= var_145_24 + var_145_27 and arg_142_1.time_ < var_145_24 + var_145_27 + arg_145_0 then
				var_145_23.localPosition = Vector3.New(0, -347, -300)
			end

			local var_145_30 = 0
			local var_145_31 = 0.4

			if var_145_30 < arg_142_1.time_ and arg_142_1.time_ <= var_145_30 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_32 = arg_142_1:FormatText(StoryNameCfg[595].name)

				arg_142_1.leftNameTxt_.text = var_145_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_33 = arg_142_1:GetWordFromCfg(417081035)
				local var_145_34 = arg_142_1:FormatText(var_145_33.content)

				arg_142_1.text_.text = var_145_34

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_35 = 16
				local var_145_36 = utf8.len(var_145_34)
				local var_145_37 = var_145_35 <= 0 and var_145_31 or var_145_31 * (var_145_36 / var_145_35)

				if var_145_37 > 0 and var_145_31 < var_145_37 then
					arg_142_1.talkMaxDuration = var_145_37

					if var_145_37 + var_145_30 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_37 + var_145_30
					end
				end

				arg_142_1.text_.text = var_145_34
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081035", "story_v_out_417081.awb") ~= 0 then
					local var_145_38 = manager.audio:GetVoiceLength("story_v_out_417081", "417081035", "story_v_out_417081.awb") / 1000

					if var_145_38 + var_145_30 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_38 + var_145_30
					end

					if var_145_33.prefab_name ~= "" and arg_142_1.actors_[var_145_33.prefab_name] ~= nil then
						local var_145_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_33.prefab_name].transform, "story_v_out_417081", "417081035", "story_v_out_417081.awb")

						arg_142_1:RecordAudio("417081035", var_145_39)
						arg_142_1:RecordAudio("417081035", var_145_39)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417081", "417081035", "story_v_out_417081.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417081", "417081035", "story_v_out_417081.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_40 = math.max(var_145_31, arg_142_1.talkMaxDuration)

			if var_145_30 <= arg_142_1.time_ and arg_142_1.time_ < var_145_30 + var_145_40 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_30) / var_145_40

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_30 + var_145_40 and arg_142_1.time_ < var_145_30 + var_145_40 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play417081036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417081036
		arg_146_1.duration_ = 9

		local var_146_0 = {
			zh = 5,
			ja = 9
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
				arg_146_0:Play417081037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10113"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10113 == nil then
				arg_146_1.var_.actorSpriteComps10113 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10113 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor1.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor1.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor1.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 1, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10113 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_149_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10113 = nil
			end

			local var_149_8 = arg_146_1.actors_["10128"]
			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps10128 == nil then
				arg_146_1.var_.actorSpriteComps10128 = var_149_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_10 = 0.2

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_10 and not isNil(var_149_8) then
				local var_149_11 = (arg_146_1.time_ - var_149_9) / var_149_10

				if arg_146_1.var_.actorSpriteComps10128 then
					for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_149_5 then
							if arg_146_1.isInRecall_ then
								local var_149_12 = Mathf.Lerp(iter_149_5.color.r, arg_146_1.hightColor2.r, var_149_11)
								local var_149_13 = Mathf.Lerp(iter_149_5.color.g, arg_146_1.hightColor2.g, var_149_11)
								local var_149_14 = Mathf.Lerp(iter_149_5.color.b, arg_146_1.hightColor2.b, var_149_11)

								iter_149_5.color = Color.New(var_149_12, var_149_13, var_149_14)
							else
								local var_149_15 = Mathf.Lerp(iter_149_5.color.r, 0.5, var_149_11)

								iter_149_5.color = Color.New(var_149_15, var_149_15, var_149_15)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_9 + var_149_10 and arg_146_1.time_ < var_149_9 + var_149_10 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps10128 then
				for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_149_7 then
						if arg_146_1.isInRecall_ then
							iter_149_7.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10128 = nil
			end

			local var_149_16 = arg_146_1.actors_["10113"].transform
			local var_149_17 = 0

			if var_149_17 < arg_146_1.time_ and arg_146_1.time_ <= var_149_17 + arg_149_0 then
				arg_146_1.var_.moveOldPos10113 = var_149_16.localPosition
				var_149_16.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("10113", 3)

				local var_149_18 = var_149_16.childCount

				for iter_149_8 = 0, var_149_18 - 1 do
					local var_149_19 = var_149_16:GetChild(iter_149_8)

					if var_149_19.name == "split_1" or not string.find(var_149_19.name, "split") then
						var_149_19.gameObject:SetActive(true)
					else
						var_149_19.gameObject:SetActive(false)
					end
				end
			end

			local var_149_20 = 0.001

			if var_149_17 <= arg_146_1.time_ and arg_146_1.time_ < var_149_17 + var_149_20 then
				local var_149_21 = (arg_146_1.time_ - var_149_17) / var_149_20
				local var_149_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_149_16.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10113, var_149_22, var_149_21)
			end

			if arg_146_1.time_ >= var_149_17 + var_149_20 and arg_146_1.time_ < var_149_17 + var_149_20 + arg_149_0 then
				var_149_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_149_23 = arg_146_1.actors_["10128"].transform
			local var_149_24 = 0

			if var_149_24 < arg_146_1.time_ and arg_146_1.time_ <= var_149_24 + arg_149_0 then
				arg_146_1.var_.moveOldPos10128 = var_149_23.localPosition
				var_149_23.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("10128", 7)

				local var_149_25 = var_149_23.childCount

				for iter_149_9 = 0, var_149_25 - 1 do
					local var_149_26 = var_149_23:GetChild(iter_149_9)

					if var_149_26.name == "" or not string.find(var_149_26.name, "split") then
						var_149_26.gameObject:SetActive(true)
					else
						var_149_26.gameObject:SetActive(false)
					end
				end
			end

			local var_149_27 = 0.001

			if var_149_24 <= arg_146_1.time_ and arg_146_1.time_ < var_149_24 + var_149_27 then
				local var_149_28 = (arg_146_1.time_ - var_149_24) / var_149_27
				local var_149_29 = Vector3.New(0, -2000, -300)

				var_149_23.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10128, var_149_29, var_149_28)
			end

			if arg_146_1.time_ >= var_149_24 + var_149_27 and arg_146_1.time_ < var_149_24 + var_149_27 + arg_149_0 then
				var_149_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_149_30 = 0
			local var_149_31 = 0.575

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_32 = arg_146_1:FormatText(StoryNameCfg[1117].name)

				arg_146_1.leftNameTxt_.text = var_149_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_33 = arg_146_1:GetWordFromCfg(417081036)
				local var_149_34 = arg_146_1:FormatText(var_149_33.content)

				arg_146_1.text_.text = var_149_34

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_35 = 23
				local var_149_36 = utf8.len(var_149_34)
				local var_149_37 = var_149_35 <= 0 and var_149_31 or var_149_31 * (var_149_36 / var_149_35)

				if var_149_37 > 0 and var_149_31 < var_149_37 then
					arg_146_1.talkMaxDuration = var_149_37

					if var_149_37 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_37 + var_149_30
					end
				end

				arg_146_1.text_.text = var_149_34
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081036", "story_v_out_417081.awb") ~= 0 then
					local var_149_38 = manager.audio:GetVoiceLength("story_v_out_417081", "417081036", "story_v_out_417081.awb") / 1000

					if var_149_38 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_38 + var_149_30
					end

					if var_149_33.prefab_name ~= "" and arg_146_1.actors_[var_149_33.prefab_name] ~= nil then
						local var_149_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_33.prefab_name].transform, "story_v_out_417081", "417081036", "story_v_out_417081.awb")

						arg_146_1:RecordAudio("417081036", var_149_39)
						arg_146_1:RecordAudio("417081036", var_149_39)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417081", "417081036", "story_v_out_417081.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417081", "417081036", "story_v_out_417081.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_40 = math.max(var_149_31, arg_146_1.talkMaxDuration)

			if var_149_30 <= arg_146_1.time_ and arg_146_1.time_ < var_149_30 + var_149_40 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_30) / var_149_40

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_30 + var_149_40 and arg_146_1.time_ < var_149_30 + var_149_40 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play417081037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417081037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417081038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10113"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10113 == nil then
				arg_150_1.var_.actorSpriteComps10113 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10113 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor2.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor2.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor2.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 0.5, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10113 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10113 = nil
			end

			local var_153_8 = 0
			local var_153_9 = 1.35

			if var_153_8 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(417081037)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_12 = 54
				local var_153_13 = utf8.len(var_153_11)
				local var_153_14 = var_153_12 <= 0 and var_153_9 or var_153_9 * (var_153_13 / var_153_12)

				if var_153_14 > 0 and var_153_9 < var_153_14 then
					arg_150_1.talkMaxDuration = var_153_14

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_15 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_15 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_15

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_15 and arg_150_1.time_ < var_153_8 + var_153_15 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417081038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417081038
		arg_154_1.duration_ = 5.77

		local var_154_0 = {
			zh = 4.8,
			ja = 5.766
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
				arg_154_0:Play417081039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10113"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10113 == nil then
				arg_154_1.var_.actorSpriteComps10113 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps10113 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 1, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10113 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10113 = nil
			end

			local var_157_8 = arg_154_1.actors_["10113"].transform
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.var_.moveOldPos10113 = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("10113", 3)

				local var_157_10 = var_157_8.childCount

				for iter_157_4 = 0, var_157_10 - 1 do
					local var_157_11 = var_157_8:GetChild(iter_157_4)

					if var_157_11.name == "" or not string.find(var_157_11.name, "split") then
						var_157_11.gameObject:SetActive(true)
					else
						var_157_11.gameObject:SetActive(false)
					end
				end
			end

			local var_157_12 = 0.001

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_12 then
				local var_157_13 = (arg_154_1.time_ - var_157_9) / var_157_12
				local var_157_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10113, var_157_14, var_157_13)
			end

			if arg_154_1.time_ >= var_157_9 + var_157_12 and arg_154_1.time_ < var_157_9 + var_157_12 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_157_15 = 0
			local var_157_16 = 0.55

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[1117].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(417081038)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_20 = 22
				local var_157_21 = utf8.len(var_157_19)
				local var_157_22 = var_157_20 <= 0 and var_157_16 or var_157_16 * (var_157_21 / var_157_20)

				if var_157_22 > 0 and var_157_16 < var_157_22 then
					arg_154_1.talkMaxDuration = var_157_22

					if var_157_22 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081038", "story_v_out_417081.awb") ~= 0 then
					local var_157_23 = manager.audio:GetVoiceLength("story_v_out_417081", "417081038", "story_v_out_417081.awb") / 1000

					if var_157_23 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_15
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_out_417081", "417081038", "story_v_out_417081.awb")

						arg_154_1:RecordAudio("417081038", var_157_24)
						arg_154_1:RecordAudio("417081038", var_157_24)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417081", "417081038", "story_v_out_417081.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417081", "417081038", "story_v_out_417081.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_25 and arg_154_1.time_ < var_157_15 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play417081039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417081039
		arg_158_1.duration_ = 2.53

		local var_158_0 = {
			zh = 1.466,
			ja = 2.533
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
				arg_158_0:Play417081040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.125

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[1117].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(417081039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 5
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081039", "story_v_out_417081.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_417081", "417081039", "story_v_out_417081.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_417081", "417081039", "story_v_out_417081.awb")

						arg_158_1:RecordAudio("417081039", var_161_9)
						arg_158_1:RecordAudio("417081039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_417081", "417081039", "story_v_out_417081.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_417081", "417081039", "story_v_out_417081.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417081040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417081040
		arg_162_1.duration_ = 10.8

		local var_162_0 = {
			zh = 7.899999999999,
			ja = 10.799999999999
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417081041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = "B04a"

			if arg_162_1.bgs_[var_165_0] == nil then
				local var_165_1 = Object.Instantiate(arg_162_1.paintGo_)

				var_165_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_165_0)
				var_165_1.name = var_165_0
				var_165_1.transform.parent = arg_162_1.stage_.transform
				var_165_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.bgs_[var_165_0] = var_165_1
			end

			local var_165_2 = 1.999999999999

			if var_165_2 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				local var_165_3 = manager.ui.mainCamera.transform.localPosition
				local var_165_4 = Vector3.New(0, 0, 10) + Vector3.New(var_165_3.x, var_165_3.y, 0)
				local var_165_5 = arg_162_1.bgs_.B04a

				var_165_5.transform.localPosition = var_165_4
				var_165_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_6 = var_165_5:GetComponent("SpriteRenderer")

				if var_165_6 and var_165_6.sprite then
					local var_165_7 = (var_165_5.transform.localPosition - var_165_3).z
					local var_165_8 = manager.ui.mainCameraCom_
					local var_165_9 = 2 * var_165_7 * Mathf.Tan(var_165_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_165_10 = var_165_9 * var_165_8.aspect
					local var_165_11 = var_165_6.sprite.bounds.size.x
					local var_165_12 = var_165_6.sprite.bounds.size.y
					local var_165_13 = var_165_10 / var_165_11
					local var_165_14 = var_165_9 / var_165_12
					local var_165_15 = var_165_14 < var_165_13 and var_165_13 or var_165_14

					var_165_5.transform.localScale = Vector3.New(var_165_15, var_165_15, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "B04a" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_16 = 1.999999999999

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			local var_165_17 = 0.3

			if arg_162_1.time_ >= var_165_16 + var_165_17 and arg_162_1.time_ < var_165_16 + var_165_17 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_18 = 0

			if var_165_18 < arg_162_1.time_ and arg_162_1.time_ <= var_165_18 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_19 = 2

			if var_165_18 <= arg_162_1.time_ and arg_162_1.time_ < var_165_18 + var_165_19 then
				local var_165_20 = (arg_162_1.time_ - var_165_18) / var_165_19
				local var_165_21 = Color.New(0, 0, 0)

				var_165_21.a = Mathf.Lerp(0, 1, var_165_20)
				arg_162_1.mask_.color = var_165_21
			end

			if arg_162_1.time_ >= var_165_18 + var_165_19 and arg_162_1.time_ < var_165_18 + var_165_19 + arg_165_0 then
				local var_165_22 = Color.New(0, 0, 0)

				var_165_22.a = 1
				arg_162_1.mask_.color = var_165_22
			end

			local var_165_23 = 1.999999999999

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_24 = 2

			if var_165_23 <= arg_162_1.time_ and arg_162_1.time_ < var_165_23 + var_165_24 then
				local var_165_25 = (arg_162_1.time_ - var_165_23) / var_165_24
				local var_165_26 = Color.New(0, 0, 0)

				var_165_26.a = Mathf.Lerp(1, 0, var_165_25)
				arg_162_1.mask_.color = var_165_26
			end

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 then
				local var_165_27 = Color.New(0, 0, 0)
				local var_165_28 = 0

				arg_162_1.mask_.enabled = false
				var_165_27.a = var_165_28
				arg_162_1.mask_.color = var_165_27
			end

			local var_165_29 = arg_162_1.actors_["10113"]
			local var_165_30 = 1.999999999999

			if var_165_30 < arg_162_1.time_ and arg_162_1.time_ <= var_165_30 + arg_165_0 and not isNil(var_165_29) and arg_162_1.var_.actorSpriteComps10113 == nil then
				arg_162_1.var_.actorSpriteComps10113 = var_165_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_31 = 0.2

			if var_165_30 <= arg_162_1.time_ and arg_162_1.time_ < var_165_30 + var_165_31 and not isNil(var_165_29) then
				local var_165_32 = (arg_162_1.time_ - var_165_30) / var_165_31

				if arg_162_1.var_.actorSpriteComps10113 then
					for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_165_3 then
							if arg_162_1.isInRecall_ then
								local var_165_33 = Mathf.Lerp(iter_165_3.color.r, arg_162_1.hightColor2.r, var_165_32)
								local var_165_34 = Mathf.Lerp(iter_165_3.color.g, arg_162_1.hightColor2.g, var_165_32)
								local var_165_35 = Mathf.Lerp(iter_165_3.color.b, arg_162_1.hightColor2.b, var_165_32)

								iter_165_3.color = Color.New(var_165_33, var_165_34, var_165_35)
							else
								local var_165_36 = Mathf.Lerp(iter_165_3.color.r, 0.5, var_165_32)

								iter_165_3.color = Color.New(var_165_36, var_165_36, var_165_36)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_30 + var_165_31 and arg_162_1.time_ < var_165_30 + var_165_31 + arg_165_0 and not isNil(var_165_29) and arg_162_1.var_.actorSpriteComps10113 then
				for iter_165_4, iter_165_5 in pairs(arg_162_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_165_5 then
						if arg_162_1.isInRecall_ then
							iter_165_5.color = arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_165_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps10113 = nil
			end

			local var_165_37 = arg_162_1.actors_["10113"].transform
			local var_165_38 = 1.999999999999

			if var_165_38 < arg_162_1.time_ and arg_162_1.time_ <= var_165_38 + arg_165_0 then
				arg_162_1.var_.moveOldPos10113 = var_165_37.localPosition
				var_165_37.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10113", 7)

				local var_165_39 = var_165_37.childCount

				for iter_165_6 = 0, var_165_39 - 1 do
					local var_165_40 = var_165_37:GetChild(iter_165_6)

					if var_165_40.name == "" or not string.find(var_165_40.name, "split") then
						var_165_40.gameObject:SetActive(true)
					else
						var_165_40.gameObject:SetActive(false)
					end
				end
			end

			local var_165_41 = 0.001

			if var_165_38 <= arg_162_1.time_ and arg_162_1.time_ < var_165_38 + var_165_41 then
				local var_165_42 = (arg_162_1.time_ - var_165_38) / var_165_41
				local var_165_43 = Vector3.New(0, -2000, 0)

				var_165_37.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10113, var_165_43, var_165_42)
			end

			if arg_162_1.time_ >= var_165_38 + var_165_41 and arg_162_1.time_ < var_165_38 + var_165_41 + arg_165_0 then
				var_165_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_165_44 = 0
			local var_165_45 = 0.2

			if var_165_44 < arg_162_1.time_ and arg_162_1.time_ <= var_165_44 + arg_165_0 then
				local var_165_46 = "play"
				local var_165_47 = "music"

				arg_162_1:AudioAction(var_165_46, var_165_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_165_48 = ""
				local var_165_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_165_49 ~= "" then
					if arg_162_1.bgmTxt_.text ~= var_165_49 and arg_162_1.bgmTxt_.text ~= "" then
						if arg_162_1.bgmTxt2_.text ~= "" then
							arg_162_1.bgmTxt_.text = arg_162_1.bgmTxt2_.text
						end

						arg_162_1.bgmTxt2_.text = var_165_49

						arg_162_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_162_1.bgmTxt_.text = var_165_49
						arg_162_1.bgmTxt2_.text = var_165_49
					end

					if arg_162_1.bgmTimer then
						arg_162_1.bgmTimer:Stop()

						arg_162_1.bgmTimer = nil
					end

					if arg_162_1.settingData.show_music_name == 1 then
						arg_162_1.musicController:SetSelectedState("show")
						arg_162_1.musicAnimator_:Play("open", 0, 0)

						if arg_162_1.settingData.music_time ~= 0 then
							arg_162_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_162_1.settingData.music_time), function()
								if arg_162_1 == nil or isNil(arg_162_1.bgmTxt_) then
									return
								end

								arg_162_1.musicController:SetSelectedState("hide")
								arg_162_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_165_50 = 1.83333333333333
			local var_165_51 = 1

			if var_165_50 < arg_162_1.time_ and arg_162_1.time_ <= var_165_50 + arg_165_0 then
				local var_165_52 = "play"
				local var_165_53 = "music"

				arg_162_1:AudioAction(var_165_52, var_165_53, "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_165_54 = ""
				local var_165_55 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if var_165_55 ~= "" then
					if arg_162_1.bgmTxt_.text ~= var_165_55 and arg_162_1.bgmTxt_.text ~= "" then
						if arg_162_1.bgmTxt2_.text ~= "" then
							arg_162_1.bgmTxt_.text = arg_162_1.bgmTxt2_.text
						end

						arg_162_1.bgmTxt2_.text = var_165_55

						arg_162_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_162_1.bgmTxt_.text = var_165_55
						arg_162_1.bgmTxt2_.text = var_165_55
					end

					if arg_162_1.bgmTimer then
						arg_162_1.bgmTimer:Stop()

						arg_162_1.bgmTimer = nil
					end

					if arg_162_1.settingData.show_music_name == 1 then
						arg_162_1.musicController:SetSelectedState("show")
						arg_162_1.musicAnimator_:Play("open", 0, 0)

						if arg_162_1.settingData.music_time ~= 0 then
							arg_162_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_162_1.settingData.music_time), function()
								if arg_162_1 == nil or isNil(arg_162_1.bgmTxt_) then
									return
								end

								arg_162_1.musicController:SetSelectedState("hide")
								arg_162_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_56 = 3.999999999999
			local var_165_57 = 0.5

			if var_165_56 < arg_162_1.time_ and arg_162_1.time_ <= var_165_56 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_58 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_58:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_162_1.dialogCg_.alpha = arg_168_0
				end))
				var_165_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_59 = arg_162_1:FormatText(StoryNameCfg[1109].name)

				arg_162_1.leftNameTxt_.text = var_165_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_60 = arg_162_1:GetWordFromCfg(417081040)
				local var_165_61 = arg_162_1:FormatText(var_165_60.content)

				arg_162_1.text_.text = var_165_61

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_62 = 20
				local var_165_63 = utf8.len(var_165_61)
				local var_165_64 = var_165_62 <= 0 and var_165_57 or var_165_57 * (var_165_63 / var_165_62)

				if var_165_64 > 0 and var_165_57 < var_165_64 then
					arg_162_1.talkMaxDuration = var_165_64
					var_165_56 = var_165_56 + 0.3

					if var_165_64 + var_165_56 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_64 + var_165_56
					end
				end

				arg_162_1.text_.text = var_165_61
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081040", "story_v_out_417081.awb") ~= 0 then
					local var_165_65 = manager.audio:GetVoiceLength("story_v_out_417081", "417081040", "story_v_out_417081.awb") / 1000

					if var_165_65 + var_165_56 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_65 + var_165_56
					end

					if var_165_60.prefab_name ~= "" and arg_162_1.actors_[var_165_60.prefab_name] ~= nil then
						local var_165_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_60.prefab_name].transform, "story_v_out_417081", "417081040", "story_v_out_417081.awb")

						arg_162_1:RecordAudio("417081040", var_165_66)
						arg_162_1:RecordAudio("417081040", var_165_66)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417081", "417081040", "story_v_out_417081.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417081", "417081040", "story_v_out_417081.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_67 = var_165_56 + 0.3
			local var_165_68 = math.max(var_165_57, arg_162_1.talkMaxDuration)

			if var_165_67 <= arg_162_1.time_ and arg_162_1.time_ < var_165_67 + var_165_68 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_67) / var_165_68

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_67 + var_165_68 and arg_162_1.time_ < var_165_67 + var_165_68 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play417081041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417081041
		arg_170_1.duration_ = 5.53

		local var_170_0 = {
			zh = 5.2,
			ja = 5.533
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
				arg_170_0:Play417081042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10113"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10113 == nil then
				arg_170_1.var_.actorSpriteComps10113 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10113 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10113 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10113 = nil
			end

			local var_173_8 = arg_170_1.actors_["1034"]
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps1034 == nil then
				arg_170_1.var_.actorSpriteComps1034 = var_173_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_10 = 0.2

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 and not isNil(var_173_8) then
				local var_173_11 = (arg_170_1.time_ - var_173_9) / var_173_10

				if arg_170_1.var_.actorSpriteComps1034 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								local var_173_12 = Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, var_173_11)
								local var_173_13 = Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, var_173_11)
								local var_173_14 = Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, var_173_11)

								iter_173_5.color = Color.New(var_173_12, var_173_13, var_173_14)
							else
								local var_173_15 = Mathf.Lerp(iter_173_5.color.r, 0.5, var_173_11)

								iter_173_5.color = Color.New(var_173_15, var_173_15, var_173_15)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps1034 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_173_7 then
						if arg_170_1.isInRecall_ then
							iter_173_7.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1034 = nil
			end

			local var_173_16 = 0
			local var_173_17 = 0.65

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_18 = arg_170_1:FormatText(StoryNameCfg[1117].name)

				arg_170_1.leftNameTxt_.text = var_173_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_170_1.callingController_:SetSelectedState("calling")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_19 = arg_170_1:GetWordFromCfg(417081041)
				local var_173_20 = arg_170_1:FormatText(var_173_19.content)

				arg_170_1.text_.text = var_173_20

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_21 = 26
				local var_173_22 = utf8.len(var_173_20)
				local var_173_23 = var_173_21 <= 0 and var_173_17 or var_173_17 * (var_173_22 / var_173_21)

				if var_173_23 > 0 and var_173_17 < var_173_23 then
					arg_170_1.talkMaxDuration = var_173_23

					if var_173_23 + var_173_16 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_23 + var_173_16
					end
				end

				arg_170_1.text_.text = var_173_20
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081041", "story_v_out_417081.awb") ~= 0 then
					local var_173_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081041", "story_v_out_417081.awb") / 1000

					if var_173_24 + var_173_16 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_24 + var_173_16
					end

					if var_173_19.prefab_name ~= "" and arg_170_1.actors_[var_173_19.prefab_name] ~= nil then
						local var_173_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_19.prefab_name].transform, "story_v_out_417081", "417081041", "story_v_out_417081.awb")

						arg_170_1:RecordAudio("417081041", var_173_25)
						arg_170_1:RecordAudio("417081041", var_173_25)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417081", "417081041", "story_v_out_417081.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417081", "417081041", "story_v_out_417081.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_26 = math.max(var_173_17, arg_170_1.talkMaxDuration)

			if var_173_16 <= arg_170_1.time_ and arg_170_1.time_ < var_173_16 + var_173_26 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_16) / var_173_26

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_16 + var_173_26 and arg_170_1.time_ < var_173_16 + var_173_26 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417081042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417081042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417081043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10113"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10113 == nil then
				arg_174_1.var_.actorSpriteComps10113 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps10113 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 0.5, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10113 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10113 = nil
			end

			local var_177_8 = 0
			local var_177_9 = 1.075

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(417081042)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 43
				local var_177_13 = utf8.len(var_177_11)
				local var_177_14 = var_177_12 <= 0 and var_177_9 or var_177_9 * (var_177_13 / var_177_12)

				if var_177_14 > 0 and var_177_9 < var_177_14 then
					arg_174_1.talkMaxDuration = var_177_14

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_15 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_15 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_15

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_15 and arg_174_1.time_ < var_177_8 + var_177_15 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play417081043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417081043
		arg_178_1.duration_ = 2.7

		local var_178_0 = {
			zh = 1.4,
			ja = 2.7
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
				arg_178_0:Play417081044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1034"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1034 == nil then
				arg_178_1.var_.actorSpriteComps1034 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps1034 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 1, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1034 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps1034 = nil
			end

			local var_181_8 = arg_178_1.actors_["1034"].transform
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.var_.moveOldPos1034 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1034", 3)

				local var_181_10 = var_181_8.childCount

				for iter_181_4 = 0, var_181_10 - 1 do
					local var_181_11 = var_181_8:GetChild(iter_181_4)

					if var_181_11.name == "" or not string.find(var_181_11.name, "split") then
						var_181_11.gameObject:SetActive(true)
					else
						var_181_11.gameObject:SetActive(false)
					end
				end
			end

			local var_181_12 = 0.001

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_12 then
				local var_181_13 = (arg_178_1.time_ - var_181_9) / var_181_12
				local var_181_14 = Vector3.New(0, -331.9, -324)

				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1034, var_181_14, var_181_13)
			end

			if arg_178_1.time_ >= var_181_9 + var_181_12 and arg_178_1.time_ < var_181_9 + var_181_12 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_181_15 = 0
			local var_181_16 = 0.2

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[1109].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(417081043)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 8
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081043", "story_v_out_417081.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_417081", "417081043", "story_v_out_417081.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_417081", "417081043", "story_v_out_417081.awb")

						arg_178_1:RecordAudio("417081043", var_181_24)
						arg_178_1:RecordAudio("417081043", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417081", "417081043", "story_v_out_417081.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417081", "417081043", "story_v_out_417081.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417081044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417081044
		arg_182_1.duration_ = 2.13

		local var_182_0 = {
			zh = 1.366,
			ja = 2.133
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
				arg_182_0:Play417081045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10128"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10128 == nil then
				arg_182_1.var_.actorSpriteComps10128 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps10128 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10128 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10128 = nil
			end

			local var_185_8 = arg_182_1.actors_["1034"]
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps1034 == nil then
				arg_182_1.var_.actorSpriteComps1034 = var_185_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_10 = 0.2

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_10 and not isNil(var_185_8) then
				local var_185_11 = (arg_182_1.time_ - var_185_9) / var_185_10

				if arg_182_1.var_.actorSpriteComps1034 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								local var_185_12 = Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, var_185_11)
								local var_185_13 = Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, var_185_11)
								local var_185_14 = Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, var_185_11)

								iter_185_5.color = Color.New(var_185_12, var_185_13, var_185_14)
							else
								local var_185_15 = Mathf.Lerp(iter_185_5.color.r, 0.5, var_185_11)

								iter_185_5.color = Color.New(var_185_15, var_185_15, var_185_15)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_9 + var_185_10 and arg_182_1.time_ < var_185_9 + var_185_10 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps1034 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_185_7 then
						if arg_182_1.isInRecall_ then
							iter_185_7.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1034 = nil
			end

			local var_185_16 = 0
			local var_185_17 = 0.2

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_18 = arg_182_1:FormatText(StoryNameCfg[595].name)

				arg_182_1.leftNameTxt_.text = var_185_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_182_1.callingController_:SetSelectedState("calling")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_19 = arg_182_1:GetWordFromCfg(417081044)
				local var_185_20 = arg_182_1:FormatText(var_185_19.content)

				arg_182_1.text_.text = var_185_20

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_21 = 8
				local var_185_22 = utf8.len(var_185_20)
				local var_185_23 = var_185_21 <= 0 and var_185_17 or var_185_17 * (var_185_22 / var_185_21)

				if var_185_23 > 0 and var_185_17 < var_185_23 then
					arg_182_1.talkMaxDuration = var_185_23

					if var_185_23 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_16
					end
				end

				arg_182_1.text_.text = var_185_20
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081044", "story_v_out_417081.awb") ~= 0 then
					local var_185_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081044", "story_v_out_417081.awb") / 1000

					if var_185_24 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_24 + var_185_16
					end

					if var_185_19.prefab_name ~= "" and arg_182_1.actors_[var_185_19.prefab_name] ~= nil then
						local var_185_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_19.prefab_name].transform, "story_v_out_417081", "417081044", "story_v_out_417081.awb")

						arg_182_1:RecordAudio("417081044", var_185_25)
						arg_182_1:RecordAudio("417081044", var_185_25)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417081", "417081044", "story_v_out_417081.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417081", "417081044", "story_v_out_417081.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_26 = math.max(var_185_17, arg_182_1.talkMaxDuration)

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_26 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_16) / var_185_26

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_16 + var_185_26 and arg_182_1.time_ < var_185_16 + var_185_26 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play417081045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417081045
		arg_186_1.duration_ = 4

		local var_186_0 = {
			zh = 2.466,
			ja = 4
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
				arg_186_0:Play417081046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10113"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10113 == nil then
				arg_186_1.var_.actorSpriteComps10113 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10113 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 1, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10113 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10113 = nil
			end

			local var_189_8 = arg_186_1.actors_["10128"]
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps10128 == nil then
				arg_186_1.var_.actorSpriteComps10128 = var_189_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_10 = 0.2

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 and not isNil(var_189_8) then
				local var_189_11 = (arg_186_1.time_ - var_189_9) / var_189_10

				if arg_186_1.var_.actorSpriteComps10128 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								local var_189_12 = Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, var_189_11)
								local var_189_13 = Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, var_189_11)
								local var_189_14 = Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, var_189_11)

								iter_189_5.color = Color.New(var_189_12, var_189_13, var_189_14)
							else
								local var_189_15 = Mathf.Lerp(iter_189_5.color.r, 0.5, var_189_11)

								iter_189_5.color = Color.New(var_189_15, var_189_15, var_189_15)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps10128 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_189_7 then
						if arg_186_1.isInRecall_ then
							iter_189_7.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10128 = nil
			end

			local var_189_16 = 0
			local var_189_17 = 0.3

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_18 = arg_186_1:FormatText(StoryNameCfg[1117].name)

				arg_186_1.leftNameTxt_.text = var_189_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_6")

				arg_186_1.callingController_:SetSelectedState("calling")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_19 = arg_186_1:GetWordFromCfg(417081045)
				local var_189_20 = arg_186_1:FormatText(var_189_19.content)

				arg_186_1.text_.text = var_189_20

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_21 = 12
				local var_189_22 = utf8.len(var_189_20)
				local var_189_23 = var_189_21 <= 0 and var_189_17 or var_189_17 * (var_189_22 / var_189_21)

				if var_189_23 > 0 and var_189_17 < var_189_23 then
					arg_186_1.talkMaxDuration = var_189_23

					if var_189_23 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_16
					end
				end

				arg_186_1.text_.text = var_189_20
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081045", "story_v_out_417081.awb") ~= 0 then
					local var_189_24 = manager.audio:GetVoiceLength("story_v_out_417081", "417081045", "story_v_out_417081.awb") / 1000

					if var_189_24 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_16
					end

					if var_189_19.prefab_name ~= "" and arg_186_1.actors_[var_189_19.prefab_name] ~= nil then
						local var_189_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_19.prefab_name].transform, "story_v_out_417081", "417081045", "story_v_out_417081.awb")

						arg_186_1:RecordAudio("417081045", var_189_25)
						arg_186_1:RecordAudio("417081045", var_189_25)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417081", "417081045", "story_v_out_417081.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417081", "417081045", "story_v_out_417081.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = math.max(var_189_17, arg_186_1.talkMaxDuration)

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_16) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_16 + var_189_26 and arg_186_1.time_ < var_189_16 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417081046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417081046
		arg_190_1.duration_ = 1.57

		local var_190_0 = {
			zh = 1.433333333332,
			ja = 1.566
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
			arg_190_1.auto_ = false
		end

		function arg_190_1.playNext_(arg_192_0)
			arg_190_1.onStoryFinished_()
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.433333333333333
			local var_193_1 = 1

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				local var_193_2 = "play"
				local var_193_3 = "effect"

				arg_190_1:AudioAction(var_193_2, var_193_3, "se_story_1310", "se_story_1310_surround", "")
			end

			local var_193_4 = 0
			local var_193_5 = 0.075

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_6 = arg_190_1:FormatText(StoryNameCfg[1117].name)

				arg_190_1.leftNameTxt_.text = var_193_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_6")

				arg_190_1.callingController_:SetSelectedState("calling")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_7 = arg_190_1:GetWordFromCfg(417081046)
				local var_193_8 = arg_190_1:FormatText(var_193_7.content)

				arg_190_1.text_.text = var_193_8

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 3
				local var_193_10 = utf8.len(var_193_8)
				local var_193_11 = var_193_9 <= 0 and var_193_5 or var_193_5 * (var_193_10 / var_193_9)

				if var_193_11 > 0 and var_193_5 < var_193_11 then
					arg_190_1.talkMaxDuration = var_193_11

					if var_193_11 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_8
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417081", "417081046", "story_v_out_417081.awb") ~= 0 then
					local var_193_12 = manager.audio:GetVoiceLength("story_v_out_417081", "417081046", "story_v_out_417081.awb") / 1000

					if var_193_12 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_4
					end

					if var_193_7.prefab_name ~= "" and arg_190_1.actors_[var_193_7.prefab_name] ~= nil then
						local var_193_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_7.prefab_name].transform, "story_v_out_417081", "417081046", "story_v_out_417081.awb")

						arg_190_1:RecordAudio("417081046", var_193_13)
						arg_190_1:RecordAudio("417081046", var_193_13)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_417081", "417081046", "story_v_out_417081.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_417081", "417081046", "story_v_out_417081.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_14 and arg_190_1.time_ < var_193_4 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B01",
		"TextureConfig/Background/B04a"
	},
	voices = {
		"story_v_out_417081.awb"
	}
}
