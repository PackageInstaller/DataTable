return {
	Play417101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417101001
		arg_1_1.duration_ = 7.1

		local var_1_0 = {
			zh = 7.1,
			ja = 6.8
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2102"

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
				local var_4_5 = arg_1_1.bgs_.ST2102

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
					if iter_4_0 ~= "ST2102" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 5.4

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

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

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

			local var_4_30 = 0.2
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_4_34 = 0

			arg_1_1.isInRecall_ = false

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(false)

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					local var_4_35 = iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_4, iter_4_5 in ipairs(var_4_35) do
						if iter_4_5.color.r > 0.51 then
							iter_4_5.color = Color.New(1, 1, 1)
						else
							iter_4_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_36 = 0.1

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_34) / var_4_36

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_4_37)
			end

			if arg_1_1.time_ >= var_4_34 + var_4_36 and arg_1_1.time_ < var_4_34 + var_4_36 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 0
			end

			local var_4_38 = 0
			local var_4_39 = 3
			local var_4_40 = "ST2102"

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_40)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_41 = arg_1_1:GetWordFromCfg(501035)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_timeText_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_43 = arg_1_1:GetWordFromCfg(501036)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_siteText_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_45 = 3

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_46 = 1.2

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Color.New(0, 0, 0)

				var_4_48.a = Mathf.Lerp(0, 1, var_4_47)
				arg_1_1.mask_.color = var_4_48
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				local var_4_49 = Color.New(0, 0, 0)

				var_4_49.a = 1
				arg_1_1.mask_.color = var_4_49
			end

			local var_4_50 = 4.2

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_51 = 1.2

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_50) / var_4_51
				local var_4_53 = Color.New(0, 0, 0)

				var_4_53.a = Mathf.Lerp(1, 0, var_4_52)
				arg_1_1.mask_.color = var_4_53
			end

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				local var_4_54 = Color.New(0, 0, 0)
				local var_4_55 = 0

				arg_1_1.mask_.enabled = false
				var_4_54.a = var_4_55
				arg_1_1.mask_.color = var_4_54
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_57 = 1

			if var_4_56 <= arg_1_1.time_ and arg_1_1.time_ < var_4_56 + var_4_57 then
				local var_4_58 = (arg_1_1.time_ - var_4_56) / var_4_57
				local var_4_59 = Color.New(0, 0, 0)

				var_4_59.a = Mathf.Lerp(1, 0, var_4_58)
				arg_1_1.mask_.color = var_4_59
			end

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				local var_4_60 = Color.New(0, 0, 0)
				local var_4_61 = 0

				arg_1_1.mask_.enabled = false
				var_4_60.a = var_4_61
				arg_1_1.mask_.color = var_4_60
			end

			local var_4_62 = 0

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_63 = 3

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_64 = 5.4
			local var_4_65 = 0.125

			if var_4_64 < arg_1_1.time_ and arg_1_1.time_ <= var_4_64 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_66 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_66:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_67 = arg_1_1:FormatText(StoryNameCfg[1134].name)

				arg_1_1.leftNameTxt_.text = var_4_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_68 = arg_1_1:GetWordFromCfg(417101001)
				local var_4_69 = arg_1_1:FormatText(var_4_68.content)

				arg_1_1.text_.text = var_4_69

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_70 = 5
				local var_4_71 = utf8.len(var_4_69)
				local var_4_72 = var_4_70 <= 0 and var_4_65 or var_4_65 * (var_4_71 / var_4_70)

				if var_4_72 > 0 and var_4_65 < var_4_72 then
					arg_1_1.talkMaxDuration = var_4_72
					var_4_64 = var_4_64 + 0.3

					if var_4_72 + var_4_64 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_72 + var_4_64
					end
				end

				arg_1_1.text_.text = var_4_69
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101001", "story_v_out_417101.awb") ~= 0 then
					local var_4_73 = manager.audio:GetVoiceLength("story_v_out_417101", "417101001", "story_v_out_417101.awb") / 1000

					if var_4_73 + var_4_64 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_73 + var_4_64
					end

					if var_4_68.prefab_name ~= "" and arg_1_1.actors_[var_4_68.prefab_name] ~= nil then
						local var_4_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_68.prefab_name].transform, "story_v_out_417101", "417101001", "story_v_out_417101.awb")

						arg_1_1:RecordAudio("417101001", var_4_74)
						arg_1_1:RecordAudio("417101001", var_4_74)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417101", "417101001", "story_v_out_417101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417101", "417101001", "story_v_out_417101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_75 = var_4_64 + 0.3
			local var_4_76 = math.max(var_4_65, arg_1_1.talkMaxDuration)

			if var_4_75 <= arg_1_1.time_ and arg_1_1.time_ < var_4_75 + var_4_76 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_75) / var_4_76

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_75 + var_4_76 and arg_1_1.time_ < var_4_75 + var_4_76 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417101002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417101002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417101003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 1.2

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

				local var_13_2 = arg_10_1:GetWordFromCfg(417101002)
				local var_13_3 = arg_10_1:FormatText(var_13_2.content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 48
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
	Play417101003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417101003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417101004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.8

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(417101003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 32
				local var_17_5 = utf8.len(var_17_3)
				local var_17_6 = var_17_4 <= 0 and var_17_1 or var_17_1 * (var_17_5 / var_17_4)

				if var_17_6 > 0 and var_17_1 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_7 and arg_14_1.time_ < var_17_0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417101004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417101004
		arg_18_1.duration_ = 6

		local var_18_0 = {
			zh = 5.3,
			ja = 6
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
				arg_18_0:Play417101005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.55

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[1134].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(417101004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101004", "story_v_out_417101.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101004", "story_v_out_417101.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417101", "417101004", "story_v_out_417101.awb")

						arg_18_1:RecordAudio("417101004", var_21_9)
						arg_18_1:RecordAudio("417101004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417101", "417101004", "story_v_out_417101.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417101", "417101004", "story_v_out_417101.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417101005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417101005
		arg_22_1.duration_ = 1.47

		local var_22_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_22_0:Play417101006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.075

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[1117].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(417101005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 3
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101005", "story_v_out_417101.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101005", "story_v_out_417101.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_417101", "417101005", "story_v_out_417101.awb")

						arg_22_1:RecordAudio("417101005", var_25_9)
						arg_22_1:RecordAudio("417101005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417101", "417101005", "story_v_out_417101.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417101", "417101005", "story_v_out_417101.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417101006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417101006
		arg_26_1.duration_ = 2.93

		local var_26_0 = {
			zh = 2.933,
			ja = 2.166
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
				arg_26_0:Play417101007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "1052"

			if arg_26_1.actors_[var_29_0] == nil then
				local var_29_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_29_1) then
					local var_29_2 = Object.Instantiate(var_29_1, arg_26_1.canvasGo_.transform)

					var_29_2.transform:SetSiblingIndex(1)

					var_29_2.name = var_29_0
					var_29_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_26_1.actors_[var_29_0] = var_29_2

					local var_29_3 = var_29_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_26_1.isInRecall_ then
						for iter_29_0, iter_29_1 in ipairs(var_29_3) do
							iter_29_1.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_29_4 = arg_26_1.actors_["1052"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps1052 == nil then
				arg_26_1.var_.actorSpriteComps1052 = var_29_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_6 = 0.2

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.actorSpriteComps1052 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_29_3 then
							if arg_26_1.isInRecall_ then
								local var_29_8 = Mathf.Lerp(iter_29_3.color.r, arg_26_1.hightColor2.r, var_29_7)
								local var_29_9 = Mathf.Lerp(iter_29_3.color.g, arg_26_1.hightColor2.g, var_29_7)
								local var_29_10 = Mathf.Lerp(iter_29_3.color.b, arg_26_1.hightColor2.b, var_29_7)

								iter_29_3.color = Color.New(var_29_8, var_29_9, var_29_10)
							else
								local var_29_11 = Mathf.Lerp(iter_29_3.color.r, 0.5, var_29_7)

								iter_29_3.color = Color.New(var_29_11, var_29_11, var_29_11)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps1052 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_29_5 then
						if arg_26_1.isInRecall_ then
							iter_29_5.color = arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_29_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1052 = nil
			end

			local var_29_12 = 0
			local var_29_13 = 0.25

			if var_29_12 < arg_26_1.time_ and arg_26_1.time_ <= var_29_12 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_14 = arg_26_1:FormatText(StoryNameCfg[1134].name)

				arg_26_1.leftNameTxt_.text = var_29_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_15 = arg_26_1:GetWordFromCfg(417101006)
				local var_29_16 = arg_26_1:FormatText(var_29_15.content)

				arg_26_1.text_.text = var_29_16

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_17 = 10
				local var_29_18 = utf8.len(var_29_16)
				local var_29_19 = var_29_17 <= 0 and var_29_13 or var_29_13 * (var_29_18 / var_29_17)

				if var_29_19 > 0 and var_29_13 < var_29_19 then
					arg_26_1.talkMaxDuration = var_29_19

					if var_29_19 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_19 + var_29_12
					end
				end

				arg_26_1.text_.text = var_29_16
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101006", "story_v_out_417101.awb") ~= 0 then
					local var_29_20 = manager.audio:GetVoiceLength("story_v_out_417101", "417101006", "story_v_out_417101.awb") / 1000

					if var_29_20 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_20 + var_29_12
					end

					if var_29_15.prefab_name ~= "" and arg_26_1.actors_[var_29_15.prefab_name] ~= nil then
						local var_29_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_15.prefab_name].transform, "story_v_out_417101", "417101006", "story_v_out_417101.awb")

						arg_26_1:RecordAudio("417101006", var_29_21)
						arg_26_1:RecordAudio("417101006", var_29_21)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417101", "417101006", "story_v_out_417101.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417101", "417101006", "story_v_out_417101.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_22 = math.max(var_29_13, arg_26_1.talkMaxDuration)

			if var_29_12 <= arg_26_1.time_ and arg_26_1.time_ < var_29_12 + var_29_22 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_12) / var_29_22

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_12 + var_29_22 and arg_26_1.time_ < var_29_12 + var_29_22 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417101007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417101007
		arg_30_1.duration_ = 7.63

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417101008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.26666666666667

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				local var_33_1 = manager.ui.mainCamera.transform.localPosition
				local var_33_2 = Vector3.New(0, 0, 10) + Vector3.New(var_33_1.x, var_33_1.y, 0)
				local var_33_3 = arg_30_1.bgs_.ST2102

				var_33_3.transform.localPosition = var_33_2
				var_33_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_4 = var_33_3:GetComponent("SpriteRenderer")

				if var_33_4 and var_33_4.sprite then
					local var_33_5 = (var_33_3.transform.localPosition - var_33_1).z
					local var_33_6 = manager.ui.mainCameraCom_
					local var_33_7 = 2 * var_33_5 * Mathf.Tan(var_33_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_8 = var_33_7 * var_33_6.aspect
					local var_33_9 = var_33_4.sprite.bounds.size.x
					local var_33_10 = var_33_4.sprite.bounds.size.y
					local var_33_11 = var_33_8 / var_33_9
					local var_33_12 = var_33_7 / var_33_10
					local var_33_13 = var_33_12 < var_33_11 and var_33_11 or var_33_12

					var_33_3.transform.localScale = Vector3.New(var_33_13, var_33_13, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "ST2102" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_14 = 0

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_15 = 1.26666666666667

			if var_33_14 <= arg_30_1.time_ and arg_30_1.time_ < var_33_14 + var_33_15 then
				local var_33_16 = (arg_30_1.time_ - var_33_14) / var_33_15
				local var_33_17 = Color.New(0, 0, 0)

				var_33_17.a = Mathf.Lerp(0, 1, var_33_16)
				arg_30_1.mask_.color = var_33_17
			end

			if arg_30_1.time_ >= var_33_14 + var_33_15 and arg_30_1.time_ < var_33_14 + var_33_15 + arg_33_0 then
				local var_33_18 = Color.New(0, 0, 0)

				var_33_18.a = 1
				arg_30_1.mask_.color = var_33_18
			end

			local var_33_19 = 1.26666666666667

			if var_33_19 < arg_30_1.time_ and arg_30_1.time_ <= var_33_19 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_20 = 1.73333333333333

			if var_33_19 <= arg_30_1.time_ and arg_30_1.time_ < var_33_19 + var_33_20 then
				local var_33_21 = (arg_30_1.time_ - var_33_19) / var_33_20
				local var_33_22 = Color.New(0, 0, 0)

				var_33_22.a = Mathf.Lerp(1, 0, var_33_21)
				arg_30_1.mask_.color = var_33_22
			end

			if arg_30_1.time_ >= var_33_19 + var_33_20 and arg_30_1.time_ < var_33_19 + var_33_20 + arg_33_0 then
				local var_33_23 = Color.New(0, 0, 0)
				local var_33_24 = 0

				arg_30_1.mask_.enabled = false
				var_33_23.a = var_33_24
				arg_30_1.mask_.color = var_33_23
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_25 = 2.63333333333333
			local var_33_26 = 1.6

			if var_33_25 < arg_30_1.time_ and arg_30_1.time_ <= var_33_25 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_27 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_27:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_28 = arg_30_1:GetWordFromCfg(417101007)
				local var_33_29 = arg_30_1:FormatText(var_33_28.content)

				arg_30_1.text_.text = var_33_29

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_30 = 64
				local var_33_31 = utf8.len(var_33_29)
				local var_33_32 = var_33_30 <= 0 and var_33_26 or var_33_26 * (var_33_31 / var_33_30)

				if var_33_32 > 0 and var_33_26 < var_33_32 then
					arg_30_1.talkMaxDuration = var_33_32
					var_33_25 = var_33_25 + 0.3

					if var_33_32 + var_33_25 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_32 + var_33_25
					end
				end

				arg_30_1.text_.text = var_33_29
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_33 = var_33_25 + 0.3
			local var_33_34 = math.max(var_33_26, arg_30_1.talkMaxDuration)

			if var_33_33 <= arg_30_1.time_ and arg_30_1.time_ < var_33_33 + var_33_34 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_33) / var_33_34

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_33 + var_33_34 and arg_30_1.time_ < var_33_33 + var_33_34 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417101008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 417101008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play417101009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.075

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(417101008)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 43
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play417101009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 417101009
		arg_40_1.duration_ = 1.1

		local var_40_0 = {
			zh = 1.033,
			ja = 1.1
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
				arg_40_0:Play417101010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "10113"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(var_43_1, arg_40_1.canvasGo_.transform)

					var_43_2.transform:SetSiblingIndex(1)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_40_1.isInRecall_ then
						for iter_43_0, iter_43_1 in ipairs(var_43_3) do
							iter_43_1.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_43_4 = arg_40_1.actors_["10113"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.actorSpriteComps10113 == nil then
				arg_40_1.var_.actorSpriteComps10113 = var_43_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_6 = 0.2

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.actorSpriteComps10113 then
					for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_43_3 then
							if arg_40_1.isInRecall_ then
								local var_43_8 = Mathf.Lerp(iter_43_3.color.r, arg_40_1.hightColor1.r, var_43_7)
								local var_43_9 = Mathf.Lerp(iter_43_3.color.g, arg_40_1.hightColor1.g, var_43_7)
								local var_43_10 = Mathf.Lerp(iter_43_3.color.b, arg_40_1.hightColor1.b, var_43_7)

								iter_43_3.color = Color.New(var_43_8, var_43_9, var_43_10)
							else
								local var_43_11 = Mathf.Lerp(iter_43_3.color.r, 1, var_43_7)

								iter_43_3.color = Color.New(var_43_11, var_43_11, var_43_11)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.actorSpriteComps10113 then
				for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_43_5 then
						if arg_40_1.isInRecall_ then
							iter_43_5.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10113 = nil
			end

			local var_43_12 = arg_40_1.actors_["10113"].transform
			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1.var_.moveOldPos10113 = var_43_12.localPosition
				var_43_12.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10113", 3)

				local var_43_14 = var_43_12.childCount

				for iter_43_6 = 0, var_43_14 - 1 do
					local var_43_15 = var_43_12:GetChild(iter_43_6)

					if var_43_15.name == "" or not string.find(var_43_15.name, "split") then
						var_43_15.gameObject:SetActive(true)
					else
						var_43_15.gameObject:SetActive(false)
					end
				end
			end

			local var_43_16 = 0.001

			if var_43_13 <= arg_40_1.time_ and arg_40_1.time_ < var_43_13 + var_43_16 then
				local var_43_17 = (arg_40_1.time_ - var_43_13) / var_43_16
				local var_43_18 = Vector3.New(-30.38, -328.4, -517.4)

				var_43_12.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10113, var_43_18, var_43_17)
			end

			if arg_40_1.time_ >= var_43_13 + var_43_16 and arg_40_1.time_ < var_43_13 + var_43_16 + arg_43_0 then
				var_43_12.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_43_19 = 0
			local var_43_20 = 0.075

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_21 = arg_40_1:FormatText(StoryNameCfg[1117].name)

				arg_40_1.leftNameTxt_.text = var_43_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_22 = arg_40_1:GetWordFromCfg(417101009)
				local var_43_23 = arg_40_1:FormatText(var_43_22.content)

				arg_40_1.text_.text = var_43_23

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_24 = 3
				local var_43_25 = utf8.len(var_43_23)
				local var_43_26 = var_43_24 <= 0 and var_43_20 or var_43_20 * (var_43_25 / var_43_24)

				if var_43_26 > 0 and var_43_20 < var_43_26 then
					arg_40_1.talkMaxDuration = var_43_26

					if var_43_26 + var_43_19 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_26 + var_43_19
					end
				end

				arg_40_1.text_.text = var_43_23
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101009", "story_v_out_417101.awb") ~= 0 then
					local var_43_27 = manager.audio:GetVoiceLength("story_v_out_417101", "417101009", "story_v_out_417101.awb") / 1000

					if var_43_27 + var_43_19 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_27 + var_43_19
					end

					if var_43_22.prefab_name ~= "" and arg_40_1.actors_[var_43_22.prefab_name] ~= nil then
						local var_43_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_22.prefab_name].transform, "story_v_out_417101", "417101009", "story_v_out_417101.awb")

						arg_40_1:RecordAudio("417101009", var_43_28)
						arg_40_1:RecordAudio("417101009", var_43_28)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_417101", "417101009", "story_v_out_417101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_417101", "417101009", "story_v_out_417101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_29 = math.max(var_43_20, arg_40_1.talkMaxDuration)

			if var_43_19 <= arg_40_1.time_ and arg_40_1.time_ < var_43_19 + var_43_29 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_19) / var_43_29

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_19 + var_43_29 and arg_40_1.time_ < var_43_19 + var_43_29 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play417101010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 417101010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play417101011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10113"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10113 == nil then
				arg_44_1.var_.actorSpriteComps10113 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps10113 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor2.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor2.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor2.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 0.5, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10113 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10113 = nil
			end

			local var_47_8 = 0
			local var_47_9 = 1.175

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(417101010)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_12 = 47
				local var_47_13 = utf8.len(var_47_11)
				local var_47_14 = var_47_12 <= 0 and var_47_9 or var_47_9 * (var_47_13 / var_47_12)

				if var_47_14 > 0 and var_47_9 < var_47_14 then
					arg_44_1.talkMaxDuration = var_47_14

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_15 and arg_44_1.time_ < var_47_8 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play417101011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417101011
		arg_48_1.duration_ = 10.63

		local var_48_0 = {
			zh = 10.633,
			ja = 6.333
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
				arg_48_0:Play417101012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.775

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[468].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(417101011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 31
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101011", "story_v_out_417101.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101011", "story_v_out_417101.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_417101", "417101011", "story_v_out_417101.awb")

						arg_48_1:RecordAudio("417101011", var_51_9)
						arg_48_1:RecordAudio("417101011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_417101", "417101011", "story_v_out_417101.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_417101", "417101011", "story_v_out_417101.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play417101012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417101012
		arg_52_1.duration_ = 10.9

		local var_52_0 = {
			zh = 6.6,
			ja = 10.9
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play417101013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10113"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10113 == nil then
				arg_52_1.var_.actorSpriteComps10113 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps10113 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 1, var_55_3)

								iter_55_1.color = Color.New(var_55_7, var_55_7, var_55_7)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10113 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10113 = nil
			end

			local var_55_8 = arg_52_1.actors_["10113"].transform
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.var_.moveOldPos10113 = var_55_8.localPosition
				var_55_8.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10113", 3)

				local var_55_10 = var_55_8.childCount

				for iter_55_4 = 0, var_55_10 - 1 do
					local var_55_11 = var_55_8:GetChild(iter_55_4)

					if var_55_11.name == "" or not string.find(var_55_11.name, "split") then
						var_55_11.gameObject:SetActive(true)
					else
						var_55_11.gameObject:SetActive(false)
					end
				end
			end

			local var_55_12 = 0.001

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_9) / var_55_12
				local var_55_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_55_8.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10113, var_55_14, var_55_13)
			end

			if arg_52_1.time_ >= var_55_9 + var_55_12 and arg_52_1.time_ < var_55_9 + var_55_12 + arg_55_0 then
				var_55_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_55_15 = 0
			local var_55_16 = 0.95

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[1117].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(417101012)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 38
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101012", "story_v_out_417101.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101012", "story_v_out_417101.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_417101", "417101012", "story_v_out_417101.awb")

						arg_52_1:RecordAudio("417101012", var_55_24)
						arg_52_1:RecordAudio("417101012", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417101", "417101012", "story_v_out_417101.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417101", "417101012", "story_v_out_417101.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play417101013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417101013
		arg_56_1.duration_ = 4.93

		local var_56_0 = {
			zh = 4.7,
			ja = 4.933
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
				arg_56_0:Play417101014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10113"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10113 == nil then
				arg_56_1.var_.actorSpriteComps10113 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps10113 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 0.5, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10113 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10113 = nil
			end

			local var_59_8 = 0
			local var_59_9 = 0.3

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_10 = arg_56_1:FormatText(StoryNameCfg[468].name)

				arg_56_1.leftNameTxt_.text = var_59_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_11 = arg_56_1:GetWordFromCfg(417101013)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 12
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_9 or var_59_9 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_9 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101013", "story_v_out_417101.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101013", "story_v_out_417101.awb") / 1000

					if var_59_16 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_8
					end

					if var_59_11.prefab_name ~= "" and arg_56_1.actors_[var_59_11.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_11.prefab_name].transform, "story_v_out_417101", "417101013", "story_v_out_417101.awb")

						arg_56_1:RecordAudio("417101013", var_59_17)
						arg_56_1:RecordAudio("417101013", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_417101", "417101013", "story_v_out_417101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_417101", "417101013", "story_v_out_417101.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_18 and arg_56_1.time_ < var_59_8 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417101014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417101014
		arg_60_1.duration_ = 8.47

		local var_60_0 = {
			zh = 5.233,
			ja = 8.466
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417101015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10113"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10113 == nil then
				arg_60_1.var_.actorSpriteComps10113 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps10113 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10113 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10113 = nil
			end

			local var_63_8 = arg_60_1.actors_["10113"].transform
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.var_.moveOldPos10113 = var_63_8.localPosition
				var_63_8.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("10113", 3)

				local var_63_10 = var_63_8.childCount

				for iter_63_4 = 0, var_63_10 - 1 do
					local var_63_11 = var_63_8:GetChild(iter_63_4)

					if var_63_11.name == "" or not string.find(var_63_11.name, "split") then
						var_63_11.gameObject:SetActive(true)
					else
						var_63_11.gameObject:SetActive(false)
					end
				end
			end

			local var_63_12 = 0.001

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_9) / var_63_12
				local var_63_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_63_8.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10113, var_63_14, var_63_13)
			end

			if arg_60_1.time_ >= var_63_9 + var_63_12 and arg_60_1.time_ < var_63_9 + var_63_12 + arg_63_0 then
				var_63_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_63_15 = 0
			local var_63_16 = 0.7

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[1117].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(417101014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 28
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101014", "story_v_out_417101.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101014", "story_v_out_417101.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_417101", "417101014", "story_v_out_417101.awb")

						arg_60_1:RecordAudio("417101014", var_63_24)
						arg_60_1:RecordAudio("417101014", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_417101", "417101014", "story_v_out_417101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_417101", "417101014", "story_v_out_417101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play417101015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417101015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417101016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10113"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10113 == nil then
				arg_64_1.var_.actorSpriteComps10113 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps10113 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 0.5, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10113 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10113 = nil
			end

			local var_67_8 = arg_64_1.actors_["10113"].transform
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.var_.moveOldPos10113 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10113", 7)

				local var_67_10 = var_67_8.childCount

				for iter_67_4 = 0, var_67_10 - 1 do
					local var_67_11 = var_67_8:GetChild(iter_67_4)

					if var_67_11.name == "" or not string.find(var_67_11.name, "split") then
						var_67_11.gameObject:SetActive(true)
					else
						var_67_11.gameObject:SetActive(false)
					end
				end
			end

			local var_67_12 = 0.001

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_9) / var_67_12
				local var_67_14 = Vector3.New(0, -2000, 0)

				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10113, var_67_14, var_67_13)
			end

			if arg_64_1.time_ >= var_67_9 + var_67_12 and arg_64_1.time_ < var_67_9 + var_67_12 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_15 = 0
			local var_67_16 = 1.175

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_17 = arg_64_1:GetWordFromCfg(417101015)
				local var_67_18 = arg_64_1:FormatText(var_67_17.content)

				arg_64_1.text_.text = var_67_18

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_19 = 47
				local var_67_20 = utf8.len(var_67_18)
				local var_67_21 = var_67_19 <= 0 and var_67_16 or var_67_16 * (var_67_20 / var_67_19)

				if var_67_21 > 0 and var_67_16 < var_67_21 then
					arg_64_1.talkMaxDuration = var_67_21

					if var_67_21 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_21 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_18
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_22 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_22 and arg_64_1.time_ < var_67_15 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play417101016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417101016
		arg_68_1.duration_ = 6.47

		local var_68_0 = {
			zh = 4.366,
			ja = 6.466
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
				arg_68_0:Play417101017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.4

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[468].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(417101016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101016", "story_v_out_417101.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101016", "story_v_out_417101.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_417101", "417101016", "story_v_out_417101.awb")

						arg_68_1:RecordAudio("417101016", var_71_9)
						arg_68_1:RecordAudio("417101016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417101", "417101016", "story_v_out_417101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417101", "417101016", "story_v_out_417101.awb")
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
	Play417101017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417101017
		arg_72_1.duration_ = 5.83

		local var_72_0 = {
			zh = 1.366,
			ja = 5.833
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
				arg_72_0:Play417101018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10113"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10113 == nil then
				arg_72_1.var_.actorSpriteComps10113 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps10113 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 1, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10113 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10113 = nil
			end

			local var_75_8 = arg_72_1.actors_["10113"].transform
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.var_.moveOldPos10113 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10113", 3)

				local var_75_10 = var_75_8.childCount

				for iter_75_4 = 0, var_75_10 - 1 do
					local var_75_11 = var_75_8:GetChild(iter_75_4)

					if var_75_11.name == "split_2" or not string.find(var_75_11.name, "split") then
						var_75_11.gameObject:SetActive(true)
					else
						var_75_11.gameObject:SetActive(false)
					end
				end
			end

			local var_75_12 = 0.001

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_9) / var_75_12
				local var_75_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10113, var_75_14, var_75_13)
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_75_15 = 0
			local var_75_16 = 0.175

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[1117].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_18 = arg_72_1:GetWordFromCfg(417101017)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 7
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101017", "story_v_out_417101.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101017", "story_v_out_417101.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_417101", "417101017", "story_v_out_417101.awb")

						arg_72_1:RecordAudio("417101017", var_75_24)
						arg_72_1:RecordAudio("417101017", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417101", "417101017", "story_v_out_417101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417101", "417101017", "story_v_out_417101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play417101018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417101018
		arg_76_1.duration_ = 5.37

		local var_76_0 = {
			zh = 5.366,
			ja = 3.966
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
				arg_76_0:Play417101019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10113"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10113 == nil then
				arg_76_1.var_.actorSpriteComps10113 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10113 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 0.5, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10113 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10113 = nil
			end

			local var_79_8 = 0
			local var_79_9 = 0.375

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_10 = arg_76_1:FormatText(StoryNameCfg[468].name)

				arg_76_1.leftNameTxt_.text = var_79_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_11 = arg_76_1:GetWordFromCfg(417101018)
				local var_79_12 = arg_76_1:FormatText(var_79_11.content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 15
				local var_79_14 = utf8.len(var_79_12)
				local var_79_15 = var_79_13 <= 0 and var_79_9 or var_79_9 * (var_79_14 / var_79_13)

				if var_79_15 > 0 and var_79_9 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101018", "story_v_out_417101.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101018", "story_v_out_417101.awb") / 1000

					if var_79_16 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_8
					end

					if var_79_11.prefab_name ~= "" and arg_76_1.actors_[var_79_11.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_11.prefab_name].transform, "story_v_out_417101", "417101018", "story_v_out_417101.awb")

						arg_76_1:RecordAudio("417101018", var_79_17)
						arg_76_1:RecordAudio("417101018", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417101", "417101018", "story_v_out_417101.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417101", "417101018", "story_v_out_417101.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_18 and arg_76_1.time_ < var_79_8 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play417101019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417101019
		arg_80_1.duration_ = 11.43

		local var_80_0 = {
			zh = 9.3,
			ja = 11.433
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play417101020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.8

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[468].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(417101019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 32
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101019", "story_v_out_417101.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101019", "story_v_out_417101.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_417101", "417101019", "story_v_out_417101.awb")

						arg_80_1:RecordAudio("417101019", var_83_9)
						arg_80_1:RecordAudio("417101019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417101", "417101019", "story_v_out_417101.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417101", "417101019", "story_v_out_417101.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play417101020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417101020
		arg_84_1.duration_ = 4.03

		local var_84_0 = {
			zh = 4.033,
			ja = 3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417101021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10113"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10113 == nil then
				arg_84_1.var_.actorSpriteComps10113 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps10113 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 1, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps10113 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10113 = nil
			end

			local var_87_8 = 0
			local var_87_9 = 0.4

			if var_87_8 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_10 = arg_84_1:FormatText(StoryNameCfg[1117].name)

				arg_84_1.leftNameTxt_.text = var_87_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_11 = arg_84_1:GetWordFromCfg(417101020)
				local var_87_12 = arg_84_1:FormatText(var_87_11.content)

				arg_84_1.text_.text = var_87_12

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 16
				local var_87_14 = utf8.len(var_87_12)
				local var_87_15 = var_87_13 <= 0 and var_87_9 or var_87_9 * (var_87_14 / var_87_13)

				if var_87_15 > 0 and var_87_9 < var_87_15 then
					arg_84_1.talkMaxDuration = var_87_15

					if var_87_15 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_15 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_12
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101020", "story_v_out_417101.awb") ~= 0 then
					local var_87_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101020", "story_v_out_417101.awb") / 1000

					if var_87_16 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_16 + var_87_8
					end

					if var_87_11.prefab_name ~= "" and arg_84_1.actors_[var_87_11.prefab_name] ~= nil then
						local var_87_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_11.prefab_name].transform, "story_v_out_417101", "417101020", "story_v_out_417101.awb")

						arg_84_1:RecordAudio("417101020", var_87_17)
						arg_84_1:RecordAudio("417101020", var_87_17)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417101", "417101020", "story_v_out_417101.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417101", "417101020", "story_v_out_417101.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_18 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_18 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_18

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_18 and arg_84_1.time_ < var_87_8 + var_87_18 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417101021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417101021
		arg_88_1.duration_ = 10.17

		local var_88_0 = {
			zh = 5.8,
			ja = 10.166
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417101022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10113"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10113 == nil then
				arg_88_1.var_.actorSpriteComps10113 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps10113 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 0.5, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10113 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10113 = nil
			end

			local var_91_8 = 0
			local var_91_9 = 0.425

			if var_91_8 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_10 = arg_88_1:FormatText(StoryNameCfg[468].name)

				arg_88_1.leftNameTxt_.text = var_91_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_11 = arg_88_1:GetWordFromCfg(417101021)
				local var_91_12 = arg_88_1:FormatText(var_91_11.content)

				arg_88_1.text_.text = var_91_12

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 17
				local var_91_14 = utf8.len(var_91_12)
				local var_91_15 = var_91_13 <= 0 and var_91_9 or var_91_9 * (var_91_14 / var_91_13)

				if var_91_15 > 0 and var_91_9 < var_91_15 then
					arg_88_1.talkMaxDuration = var_91_15

					if var_91_15 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_12
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101021", "story_v_out_417101.awb") ~= 0 then
					local var_91_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101021", "story_v_out_417101.awb") / 1000

					if var_91_16 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_8
					end

					if var_91_11.prefab_name ~= "" and arg_88_1.actors_[var_91_11.prefab_name] ~= nil then
						local var_91_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_11.prefab_name].transform, "story_v_out_417101", "417101021", "story_v_out_417101.awb")

						arg_88_1:RecordAudio("417101021", var_91_17)
						arg_88_1:RecordAudio("417101021", var_91_17)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417101", "417101021", "story_v_out_417101.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417101", "417101021", "story_v_out_417101.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_18 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_18 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_18

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_18 and arg_88_1.time_ < var_91_8 + var_91_18 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play417101022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417101022
		arg_92_1.duration_ = 8.27

		local var_92_0 = {
			zh = 8.266,
			ja = 7.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play417101023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10113"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10113 == nil then
				arg_92_1.var_.actorSpriteComps10113 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10113 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 1, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10113 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10113 = nil
			end

			local var_95_8 = arg_92_1.actors_["10113"].transform
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.var_.moveOldPos10113 = var_95_8.localPosition
				var_95_8.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10113", 3)

				local var_95_10 = var_95_8.childCount

				for iter_95_4 = 0, var_95_10 - 1 do
					local var_95_11 = var_95_8:GetChild(iter_95_4)

					if var_95_11.name == "split_1" or not string.find(var_95_11.name, "split") then
						var_95_11.gameObject:SetActive(true)
					else
						var_95_11.gameObject:SetActive(false)
					end
				end
			end

			local var_95_12 = 0.001

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_9) / var_95_12
				local var_95_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_95_8.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10113, var_95_14, var_95_13)
			end

			if arg_92_1.time_ >= var_95_9 + var_95_12 and arg_92_1.time_ < var_95_9 + var_95_12 + arg_95_0 then
				var_95_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_95_15 = 0
			local var_95_16 = 1.025

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_17 = arg_92_1:FormatText(StoryNameCfg[1117].name)

				arg_92_1.leftNameTxt_.text = var_95_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_18 = arg_92_1:GetWordFromCfg(417101022)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_20 = 41
				local var_95_21 = utf8.len(var_95_19)
				local var_95_22 = var_95_20 <= 0 and var_95_16 or var_95_16 * (var_95_21 / var_95_20)

				if var_95_22 > 0 and var_95_16 < var_95_22 then
					arg_92_1.talkMaxDuration = var_95_22

					if var_95_22 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101022", "story_v_out_417101.awb") ~= 0 then
					local var_95_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101022", "story_v_out_417101.awb") / 1000

					if var_95_23 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_15
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_out_417101", "417101022", "story_v_out_417101.awb")

						arg_92_1:RecordAudio("417101022", var_95_24)
						arg_92_1:RecordAudio("417101022", var_95_24)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417101", "417101022", "story_v_out_417101.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417101", "417101022", "story_v_out_417101.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_25 and arg_92_1.time_ < var_95_15 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play417101023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417101023
		arg_96_1.duration_ = 13.23

		local var_96_0 = {
			zh = 11.866,
			ja = 13.233
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play417101024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10113"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10113 == nil then
				arg_96_1.var_.actorSpriteComps10113 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10113 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10113 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10113 = nil
			end

			local var_99_8 = 0
			local var_99_9 = 1.025

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_10 = arg_96_1:FormatText(StoryNameCfg[468].name)

				arg_96_1.leftNameTxt_.text = var_99_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_11 = arg_96_1:GetWordFromCfg(417101023)
				local var_99_12 = arg_96_1:FormatText(var_99_11.content)

				arg_96_1.text_.text = var_99_12

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 41
				local var_99_14 = utf8.len(var_99_12)
				local var_99_15 = var_99_13 <= 0 and var_99_9 or var_99_9 * (var_99_14 / var_99_13)

				if var_99_15 > 0 and var_99_9 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_12
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101023", "story_v_out_417101.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101023", "story_v_out_417101.awb") / 1000

					if var_99_16 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_8
					end

					if var_99_11.prefab_name ~= "" and arg_96_1.actors_[var_99_11.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_11.prefab_name].transform, "story_v_out_417101", "417101023", "story_v_out_417101.awb")

						arg_96_1:RecordAudio("417101023", var_99_17)
						arg_96_1:RecordAudio("417101023", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417101", "417101023", "story_v_out_417101.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417101", "417101023", "story_v_out_417101.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_18 and arg_96_1.time_ < var_99_8 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play417101024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417101024
		arg_100_1.duration_ = 14.33

		local var_100_0 = {
			zh = 14.333,
			ja = 12.833
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417101025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.1

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[468].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(417101024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 44
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101024", "story_v_out_417101.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101024", "story_v_out_417101.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_417101", "417101024", "story_v_out_417101.awb")

						arg_100_1:RecordAudio("417101024", var_103_9)
						arg_100_1:RecordAudio("417101024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417101", "417101024", "story_v_out_417101.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417101", "417101024", "story_v_out_417101.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play417101025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417101025
		arg_104_1.duration_ = 1.57

		local var_104_0 = {
			zh = 1.1,
			ja = 1.566
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417101026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10113"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10113 == nil then
				arg_104_1.var_.actorSpriteComps10113 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10113 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 1, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10113 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10113 = nil
			end

			local var_107_8 = arg_104_1.actors_["10113"].transform
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.var_.moveOldPos10113 = var_107_8.localPosition
				var_107_8.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10113", 3)

				local var_107_10 = var_107_8.childCount

				for iter_107_4 = 0, var_107_10 - 1 do
					local var_107_11 = var_107_8:GetChild(iter_107_4)

					if var_107_11.name == "split_1" or not string.find(var_107_11.name, "split") then
						var_107_11.gameObject:SetActive(true)
					else
						var_107_11.gameObject:SetActive(false)
					end
				end
			end

			local var_107_12 = 0.001

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_12 then
				local var_107_13 = (arg_104_1.time_ - var_107_9) / var_107_12
				local var_107_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10113, var_107_14, var_107_13)
			end

			if arg_104_1.time_ >= var_107_9 + var_107_12 and arg_104_1.time_ < var_107_9 + var_107_12 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_107_15 = 0
			local var_107_16 = 0.125

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_17 = arg_104_1:FormatText(StoryNameCfg[1117].name)

				arg_104_1.leftNameTxt_.text = var_107_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(417101025)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 5
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_16 or var_107_16 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_16 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101025", "story_v_out_417101.awb") ~= 0 then
					local var_107_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101025", "story_v_out_417101.awb") / 1000

					if var_107_23 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_15
					end

					if var_107_18.prefab_name ~= "" and arg_104_1.actors_[var_107_18.prefab_name] ~= nil then
						local var_107_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_18.prefab_name].transform, "story_v_out_417101", "417101025", "story_v_out_417101.awb")

						arg_104_1:RecordAudio("417101025", var_107_24)
						arg_104_1:RecordAudio("417101025", var_107_24)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417101", "417101025", "story_v_out_417101.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417101", "417101025", "story_v_out_417101.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_25 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_25 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_25

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_25 and arg_104_1.time_ < var_107_15 + var_107_25 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play417101026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417101026
		arg_108_1.duration_ = 14.97

		local var_108_0 = {
			zh = 14.966,
			ja = 13.3
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
				arg_108_0:Play417101027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10113"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10113 == nil then
				arg_108_1.var_.actorSpriteComps10113 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps10113 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 0.5, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10113 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10113 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 1.15

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[468].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_11 = arg_108_1:GetWordFromCfg(417101026)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 46
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101026", "story_v_out_417101.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101026", "story_v_out_417101.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_417101", "417101026", "story_v_out_417101.awb")

						arg_108_1:RecordAudio("417101026", var_111_17)
						arg_108_1:RecordAudio("417101026", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417101", "417101026", "story_v_out_417101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417101", "417101026", "story_v_out_417101.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_18 and arg_108_1.time_ < var_111_8 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play417101027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417101027
		arg_112_1.duration_ = 8.4

		local var_112_0 = {
			zh = 8.4,
			ja = 5.666
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417101028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.55

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[468].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(417101027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 22
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101027", "story_v_out_417101.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101027", "story_v_out_417101.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_417101", "417101027", "story_v_out_417101.awb")

						arg_112_1:RecordAudio("417101027", var_115_9)
						arg_112_1:RecordAudio("417101027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417101", "417101027", "story_v_out_417101.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417101", "417101027", "story_v_out_417101.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417101028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417101028
		arg_116_1.duration_ = 8.6

		local var_116_0 = {
			zh = 8.133,
			ja = 8.6
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play417101029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = "ST73"

			if arg_116_1.bgs_[var_119_0] == nil then
				local var_119_1 = Object.Instantiate(arg_116_1.paintGo_)

				var_119_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_119_0)
				var_119_1.name = var_119_0
				var_119_1.transform.parent = arg_116_1.stage_.transform
				var_119_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.bgs_[var_119_0] = var_119_1
			end

			local var_119_2 = 1.7

			if var_119_2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				local var_119_3 = manager.ui.mainCamera.transform.localPosition
				local var_119_4 = Vector3.New(0, 0, 10) + Vector3.New(var_119_3.x, var_119_3.y, 0)
				local var_119_5 = arg_116_1.bgs_.ST73

				var_119_5.transform.localPosition = var_119_4
				var_119_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_6 = var_119_5:GetComponent("SpriteRenderer")

				if var_119_6 and var_119_6.sprite then
					local var_119_7 = (var_119_5.transform.localPosition - var_119_3).z
					local var_119_8 = manager.ui.mainCameraCom_
					local var_119_9 = 2 * var_119_7 * Mathf.Tan(var_119_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_119_10 = var_119_9 * var_119_8.aspect
					local var_119_11 = var_119_6.sprite.bounds.size.x
					local var_119_12 = var_119_6.sprite.bounds.size.y
					local var_119_13 = var_119_10 / var_119_11
					local var_119_14 = var_119_9 / var_119_12
					local var_119_15 = var_119_14 < var_119_13 and var_119_13 or var_119_14

					var_119_5.transform.localScale = Vector3.New(var_119_15, var_119_15, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "ST73" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_16 = 7.1

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_17 = 0.3

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_18 = 0

			if var_119_18 < arg_116_1.time_ and arg_116_1.time_ <= var_119_18 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_19 = 1.7

			if var_119_18 <= arg_116_1.time_ and arg_116_1.time_ < var_119_18 + var_119_19 then
				local var_119_20 = (arg_116_1.time_ - var_119_18) / var_119_19
				local var_119_21 = Color.New(0, 0, 0)

				var_119_21.a = Mathf.Lerp(0, 1, var_119_20)
				arg_116_1.mask_.color = var_119_21
			end

			if arg_116_1.time_ >= var_119_18 + var_119_19 and arg_116_1.time_ < var_119_18 + var_119_19 + arg_119_0 then
				local var_119_22 = Color.New(0, 0, 0)

				var_119_22.a = 1
				arg_116_1.mask_.color = var_119_22
			end

			local var_119_23 = arg_116_1.actors_["10113"].transform
			local var_119_24 = 1.66666666666667

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1.var_.moveOldPos10113 = var_119_23.localPosition
				var_119_23.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10113", 7)

				local var_119_25 = var_119_23.childCount

				for iter_119_2 = 0, var_119_25 - 1 do
					local var_119_26 = var_119_23:GetChild(iter_119_2)

					if var_119_26.name == "" or not string.find(var_119_26.name, "split") then
						var_119_26.gameObject:SetActive(true)
					else
						var_119_26.gameObject:SetActive(false)
					end
				end
			end

			local var_119_27 = 0.001

			if var_119_24 <= arg_116_1.time_ and arg_116_1.time_ < var_119_24 + var_119_27 then
				local var_119_28 = (arg_116_1.time_ - var_119_24) / var_119_27
				local var_119_29 = Vector3.New(0, -2000, 0)

				var_119_23.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10113, var_119_29, var_119_28)
			end

			if arg_116_1.time_ >= var_119_24 + var_119_27 and arg_116_1.time_ < var_119_24 + var_119_27 + arg_119_0 then
				var_119_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_30 = 0
			local var_119_31 = 0.2

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				local var_119_32 = "play"
				local var_119_33 = "music"

				arg_116_1:AudioAction(var_119_32, var_119_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_119_34 = ""
				local var_119_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_119_35 ~= "" then
					if arg_116_1.bgmTxt_.text ~= var_119_35 and arg_116_1.bgmTxt_.text ~= "" then
						if arg_116_1.bgmTxt2_.text ~= "" then
							arg_116_1.bgmTxt_.text = arg_116_1.bgmTxt2_.text
						end

						arg_116_1.bgmTxt2_.text = var_119_35

						arg_116_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_116_1.bgmTxt_.text = var_119_35
						arg_116_1.bgmTxt2_.text = var_119_35
					end

					if arg_116_1.bgmTimer then
						arg_116_1.bgmTimer:Stop()

						arg_116_1.bgmTimer = nil
					end

					if arg_116_1.settingData.show_music_name == 1 then
						arg_116_1.musicController:SetSelectedState("show")
						arg_116_1.musicAnimator_:Play("open", 0, 0)

						if arg_116_1.settingData.music_time ~= 0 then
							arg_116_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_116_1.settingData.music_time), function()
								if arg_116_1 == nil or isNil(arg_116_1.bgmTxt_) then
									return
								end

								arg_116_1.musicController:SetSelectedState("hide")
								arg_116_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_119_36 = 1.53333333333333
			local var_119_37 = 1

			if var_119_36 < arg_116_1.time_ and arg_116_1.time_ <= var_119_36 + arg_119_0 then
				local var_119_38 = "play"
				local var_119_39 = "music"

				arg_116_1:AudioAction(var_119_38, var_119_39, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_119_40 = ""
				local var_119_41 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_119_41 ~= "" then
					if arg_116_1.bgmTxt_.text ~= var_119_41 and arg_116_1.bgmTxt_.text ~= "" then
						if arg_116_1.bgmTxt2_.text ~= "" then
							arg_116_1.bgmTxt_.text = arg_116_1.bgmTxt2_.text
						end

						arg_116_1.bgmTxt2_.text = var_119_41

						arg_116_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_116_1.bgmTxt_.text = var_119_41
						arg_116_1.bgmTxt2_.text = var_119_41
					end

					if arg_116_1.bgmTimer then
						arg_116_1.bgmTimer:Stop()

						arg_116_1.bgmTimer = nil
					end

					if arg_116_1.settingData.show_music_name == 1 then
						arg_116_1.musicController:SetSelectedState("show")
						arg_116_1.musicAnimator_:Play("open", 0, 0)

						if arg_116_1.settingData.music_time ~= 0 then
							arg_116_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_116_1.settingData.music_time), function()
								if arg_116_1 == nil or isNil(arg_116_1.bgmTxt_) then
									return
								end

								arg_116_1.musicController:SetSelectedState("hide")
								arg_116_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_119_42 = 0.266666666666667
			local var_119_43 = 1

			if var_119_42 < arg_116_1.time_ and arg_116_1.time_ <= var_119_42 + arg_119_0 then
				local var_119_44 = "stop"
				local var_119_45 = "effect"

				arg_116_1:AudioAction(var_119_44, var_119_45, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_119_46 = 1.7
			local var_119_47 = 3
			local var_119_48 = "ST73"

			if var_119_46 < arg_116_1.time_ and arg_116_1.time_ <= var_119_46 + arg_119_0 then
				arg_116_1.timestampController_:SetSelectedState("show")
				arg_116_1.timestampAni_:Play("in")

				arg_116_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_119_48)

				arg_116_1.timestampColorController_:SetSelectedState("cold")
				arg_116_1.timeColdImg_:SetAlpha(0.031)

				local var_119_49 = arg_116_1:GetWordFromCfg(501037)
				local var_119_50 = arg_116_1:FormatText(var_119_49.content)

				arg_116_1.text_timeText_.text = var_119_50

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_timeText_)

				local var_119_51 = arg_116_1:GetWordFromCfg(501038)
				local var_119_52 = arg_116_1:FormatText(var_119_51.content)

				arg_116_1.text_siteText_.text = var_119_52

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_siteText_)
			end

			if arg_116_1.time_ >= var_119_46 + var_119_47 and arg_116_1.time_ < var_119_46 + var_119_47 + arg_119_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_116_1.timestampAni_, "out", function()
					arg_116_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_119_53 = 4.7

			if var_119_53 < arg_116_1.time_ and arg_116_1.time_ <= var_119_53 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_54 = 1.2

			if var_119_53 <= arg_116_1.time_ and arg_116_1.time_ < var_119_53 + var_119_54 then
				local var_119_55 = (arg_116_1.time_ - var_119_53) / var_119_54
				local var_119_56 = Color.New(0, 0, 0)

				var_119_56.a = Mathf.Lerp(0, 1, var_119_55)
				arg_116_1.mask_.color = var_119_56
			end

			if arg_116_1.time_ >= var_119_53 + var_119_54 and arg_116_1.time_ < var_119_53 + var_119_54 + arg_119_0 then
				local var_119_57 = Color.New(0, 0, 0)

				var_119_57.a = 1
				arg_116_1.mask_.color = var_119_57
			end

			local var_119_58 = 5.9

			if var_119_58 < arg_116_1.time_ and arg_116_1.time_ <= var_119_58 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_59 = 1.2

			if var_119_58 <= arg_116_1.time_ and arg_116_1.time_ < var_119_58 + var_119_59 then
				local var_119_60 = (arg_116_1.time_ - var_119_58) / var_119_59
				local var_119_61 = Color.New(0, 0, 0)

				var_119_61.a = Mathf.Lerp(1, 0, var_119_60)
				arg_116_1.mask_.color = var_119_61
			end

			if arg_116_1.time_ >= var_119_58 + var_119_59 and arg_116_1.time_ < var_119_58 + var_119_59 + arg_119_0 then
				local var_119_62 = Color.New(0, 0, 0)
				local var_119_63 = 0

				arg_116_1.mask_.enabled = false
				var_119_62.a = var_119_63
				arg_116_1.mask_.color = var_119_62
			end

			local var_119_64 = 1.7

			if var_119_64 < arg_116_1.time_ and arg_116_1.time_ <= var_119_64 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = false

				arg_116_1:SetGaussion(false)
			end

			local var_119_65 = 1

			if var_119_64 <= arg_116_1.time_ and arg_116_1.time_ < var_119_64 + var_119_65 then
				local var_119_66 = (arg_116_1.time_ - var_119_64) / var_119_65
				local var_119_67 = Color.New(0, 0, 0)

				var_119_67.a = Mathf.Lerp(1, 0, var_119_66)
				arg_116_1.mask_.color = var_119_67
			end

			if arg_116_1.time_ >= var_119_64 + var_119_65 and arg_116_1.time_ < var_119_64 + var_119_65 + arg_119_0 then
				local var_119_68 = Color.New(0, 0, 0)
				local var_119_69 = 0

				arg_116_1.mask_.enabled = false
				var_119_68.a = var_119_69
				arg_116_1.mask_.color = var_119_68
			end

			local var_119_70 = 1.7

			if var_119_70 < arg_116_1.time_ and arg_116_1.time_ <= var_119_70 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_71 = 3

			if arg_116_1.time_ >= var_119_70 + var_119_71 and arg_116_1.time_ < var_119_70 + var_119_71 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_72 = 7.1
			local var_119_73 = 0.075

			if var_119_72 < arg_116_1.time_ and arg_116_1.time_ <= var_119_72 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_74 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_74:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_116_1.dialogCg_.alpha = arg_123_0
				end))
				var_119_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_75 = arg_116_1:FormatText(StoryNameCfg[1110].name)

				arg_116_1.leftNameTxt_.text = var_119_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_76 = arg_116_1:GetWordFromCfg(417101028)
				local var_119_77 = arg_116_1:FormatText(var_119_76.content)

				arg_116_1.text_.text = var_119_77

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_78 = 3
				local var_119_79 = utf8.len(var_119_77)
				local var_119_80 = var_119_78 <= 0 and var_119_73 or var_119_73 * (var_119_79 / var_119_78)

				if var_119_80 > 0 and var_119_73 < var_119_80 then
					arg_116_1.talkMaxDuration = var_119_80
					var_119_72 = var_119_72 + 0.3

					if var_119_80 + var_119_72 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_80 + var_119_72
					end
				end

				arg_116_1.text_.text = var_119_77
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101028", "story_v_out_417101.awb") ~= 0 then
					local var_119_81 = manager.audio:GetVoiceLength("story_v_out_417101", "417101028", "story_v_out_417101.awb") / 1000

					if var_119_81 + var_119_72 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_81 + var_119_72
					end

					if var_119_76.prefab_name ~= "" and arg_116_1.actors_[var_119_76.prefab_name] ~= nil then
						local var_119_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_76.prefab_name].transform, "story_v_out_417101", "417101028", "story_v_out_417101.awb")

						arg_116_1:RecordAudio("417101028", var_119_82)
						arg_116_1:RecordAudio("417101028", var_119_82)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417101", "417101028", "story_v_out_417101.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417101", "417101028", "story_v_out_417101.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_83 = var_119_72 + 0.3
			local var_119_84 = math.max(var_119_73, arg_116_1.talkMaxDuration)

			if var_119_83 <= arg_116_1.time_ and arg_116_1.time_ < var_119_83 + var_119_84 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_83) / var_119_84

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_83 + var_119_84 and arg_116_1.time_ < var_119_83 + var_119_84 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play417101029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 417101029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play417101030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.2

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(417101029)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 48
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play417101030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 417101030
		arg_129_1.duration_ = 5.03

		local var_129_0 = {
			zh = 3.3,
			ja = 5.033
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play417101031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "10128"

			if arg_129_1.actors_[var_132_0] == nil then
				local var_132_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_132_1) then
					local var_132_2 = Object.Instantiate(var_132_1, arg_129_1.canvasGo_.transform)

					var_132_2.transform:SetSiblingIndex(1)

					var_132_2.name = var_132_0
					var_132_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_129_1.actors_[var_132_0] = var_132_2

					local var_132_3 = var_132_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_129_1.isInRecall_ then
						for iter_132_0, iter_132_1 in ipairs(var_132_3) do
							iter_132_1.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_132_4 = arg_129_1.actors_["10128"]
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.actorSpriteComps10128 == nil then
				arg_129_1.var_.actorSpriteComps10128 = var_132_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 0.2

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 and not isNil(var_132_4) then
				local var_132_7 = (arg_129_1.time_ - var_132_5) / var_132_6

				if arg_129_1.var_.actorSpriteComps10128 then
					for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_132_3 then
							if arg_129_1.isInRecall_ then
								local var_132_8 = Mathf.Lerp(iter_132_3.color.r, arg_129_1.hightColor1.r, var_132_7)
								local var_132_9 = Mathf.Lerp(iter_132_3.color.g, arg_129_1.hightColor1.g, var_132_7)
								local var_132_10 = Mathf.Lerp(iter_132_3.color.b, arg_129_1.hightColor1.b, var_132_7)

								iter_132_3.color = Color.New(var_132_8, var_132_9, var_132_10)
							else
								local var_132_11 = Mathf.Lerp(iter_132_3.color.r, 1, var_132_7)

								iter_132_3.color = Color.New(var_132_11, var_132_11, var_132_11)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.actorSpriteComps10128 then
				for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_132_5 then
						if arg_129_1.isInRecall_ then
							iter_132_5.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10128 = nil
			end

			local var_132_12 = arg_129_1.actors_["10128"].transform
			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1.var_.moveOldPos10128 = var_132_12.localPosition
				var_132_12.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10128", 3)

				local var_132_14 = var_132_12.childCount

				for iter_132_6 = 0, var_132_14 - 1 do
					local var_132_15 = var_132_12:GetChild(iter_132_6)

					if var_132_15.name == "split_6" or not string.find(var_132_15.name, "split") then
						var_132_15.gameObject:SetActive(true)
					else
						var_132_15.gameObject:SetActive(false)
					end
				end
			end

			local var_132_16 = 0.001

			if var_132_13 <= arg_129_1.time_ and arg_129_1.time_ < var_132_13 + var_132_16 then
				local var_132_17 = (arg_129_1.time_ - var_132_13) / var_132_16
				local var_132_18 = Vector3.New(0, -347, -300)

				var_132_12.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10128, var_132_18, var_132_17)
			end

			if arg_129_1.time_ >= var_132_13 + var_132_16 and arg_129_1.time_ < var_132_13 + var_132_16 + arg_132_0 then
				var_132_12.localPosition = Vector3.New(0, -347, -300)
			end

			local var_132_19 = 0
			local var_132_20 = 0.425

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_21 = arg_129_1:FormatText(StoryNameCfg[595].name)

				arg_129_1.leftNameTxt_.text = var_132_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_22 = arg_129_1:GetWordFromCfg(417101030)
				local var_132_23 = arg_129_1:FormatText(var_132_22.content)

				arg_129_1.text_.text = var_132_23

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_24 = 17
				local var_132_25 = utf8.len(var_132_23)
				local var_132_26 = var_132_24 <= 0 and var_132_20 or var_132_20 * (var_132_25 / var_132_24)

				if var_132_26 > 0 and var_132_20 < var_132_26 then
					arg_129_1.talkMaxDuration = var_132_26

					if var_132_26 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_26 + var_132_19
					end
				end

				arg_129_1.text_.text = var_132_23
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101030", "story_v_out_417101.awb") ~= 0 then
					local var_132_27 = manager.audio:GetVoiceLength("story_v_out_417101", "417101030", "story_v_out_417101.awb") / 1000

					if var_132_27 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_27 + var_132_19
					end

					if var_132_22.prefab_name ~= "" and arg_129_1.actors_[var_132_22.prefab_name] ~= nil then
						local var_132_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_22.prefab_name].transform, "story_v_out_417101", "417101030", "story_v_out_417101.awb")

						arg_129_1:RecordAudio("417101030", var_132_28)
						arg_129_1:RecordAudio("417101030", var_132_28)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_417101", "417101030", "story_v_out_417101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_417101", "417101030", "story_v_out_417101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_29 = math.max(var_132_20, arg_129_1.talkMaxDuration)

			if var_132_19 <= arg_129_1.time_ and arg_129_1.time_ < var_132_19 + var_132_29 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_19) / var_132_29

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_19 + var_132_29 and arg_129_1.time_ < var_132_19 + var_132_29 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play417101031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 417101031
		arg_133_1.duration_ = 6.67

		local var_133_0 = {
			zh = 5.6,
			ja = 6.666
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
				arg_133_0:Play417101032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10128"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10128 == nil then
				arg_133_1.var_.actorSpriteComps10128 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10128 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 0.5, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10128 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10128 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.725

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_10 = arg_133_1:FormatText(StoryNameCfg[1110].name)

				arg_133_1.leftNameTxt_.text = var_136_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_11 = arg_133_1:GetWordFromCfg(417101031)
				local var_136_12 = arg_133_1:FormatText(var_136_11.content)

				arg_133_1.text_.text = var_136_12

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 29
				local var_136_14 = utf8.len(var_136_12)
				local var_136_15 = var_136_13 <= 0 and var_136_9 or var_136_9 * (var_136_14 / var_136_13)

				if var_136_15 > 0 and var_136_9 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_12
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101031", "story_v_out_417101.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101031", "story_v_out_417101.awb") / 1000

					if var_136_16 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_8
					end

					if var_136_11.prefab_name ~= "" and arg_133_1.actors_[var_136_11.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_11.prefab_name].transform, "story_v_out_417101", "417101031", "story_v_out_417101.awb")

						arg_133_1:RecordAudio("417101031", var_136_17)
						arg_133_1:RecordAudio("417101031", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_417101", "417101031", "story_v_out_417101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_417101", "417101031", "story_v_out_417101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_18 and arg_133_1.time_ < var_136_8 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play417101032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 417101032
		arg_137_1.duration_ = 6.87

		local var_137_0 = {
			zh = 3.566,
			ja = 6.866
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play417101033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10128"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10128 == nil then
				arg_137_1.var_.actorSpriteComps10128 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10128 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 1, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10128 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10128 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.4

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[595].name)

				arg_137_1.leftNameTxt_.text = var_140_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_11 = arg_137_1:GetWordFromCfg(417101032)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 16
				local var_140_14 = utf8.len(var_140_12)
				local var_140_15 = var_140_13 <= 0 and var_140_9 or var_140_9 * (var_140_14 / var_140_13)

				if var_140_15 > 0 and var_140_9 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_12
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101032", "story_v_out_417101.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101032", "story_v_out_417101.awb") / 1000

					if var_140_16 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_8
					end

					if var_140_11.prefab_name ~= "" and arg_137_1.actors_[var_140_11.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_11.prefab_name].transform, "story_v_out_417101", "417101032", "story_v_out_417101.awb")

						arg_137_1:RecordAudio("417101032", var_140_17)
						arg_137_1:RecordAudio("417101032", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_417101", "417101032", "story_v_out_417101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_417101", "417101032", "story_v_out_417101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_18 and arg_137_1.time_ < var_140_8 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play417101033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 417101033
		arg_141_1.duration_ = 3.97

		local var_141_0 = {
			zh = 2.666,
			ja = 3.966
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
				arg_141_0:Play417101034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10128"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10128 == nil then
				arg_141_1.var_.actorSpriteComps10128 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10128 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10128 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10128 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.25

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_10 = arg_141_1:FormatText(StoryNameCfg[1110].name)

				arg_141_1.leftNameTxt_.text = var_144_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_11 = arg_141_1:GetWordFromCfg(417101033)
				local var_144_12 = arg_141_1:FormatText(var_144_11.content)

				arg_141_1.text_.text = var_144_12

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 10
				local var_144_14 = utf8.len(var_144_12)
				local var_144_15 = var_144_13 <= 0 and var_144_9 or var_144_9 * (var_144_14 / var_144_13)

				if var_144_15 > 0 and var_144_9 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_12
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101033", "story_v_out_417101.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101033", "story_v_out_417101.awb") / 1000

					if var_144_16 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_8
					end

					if var_144_11.prefab_name ~= "" and arg_141_1.actors_[var_144_11.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_11.prefab_name].transform, "story_v_out_417101", "417101033", "story_v_out_417101.awb")

						arg_141_1:RecordAudio("417101033", var_144_17)
						arg_141_1:RecordAudio("417101033", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_417101", "417101033", "story_v_out_417101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_417101", "417101033", "story_v_out_417101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_18 and arg_141_1.time_ < var_144_8 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play417101034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 417101034
		arg_145_1.duration_ = 8.17

		local var_145_0 = {
			zh = 5.6,
			ja = 8.166
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
				arg_145_0:Play417101035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10128"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10128 == nil then
				arg_145_1.var_.actorSpriteComps10128 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10128 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10128 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10128 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.775

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_10 = arg_145_1:FormatText(StoryNameCfg[595].name)

				arg_145_1.leftNameTxt_.text = var_148_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(417101034)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 31
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_9 or var_148_9 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_9 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101034", "story_v_out_417101.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101034", "story_v_out_417101.awb") / 1000

					if var_148_16 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_8
					end

					if var_148_11.prefab_name ~= "" and arg_145_1.actors_[var_148_11.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_11.prefab_name].transform, "story_v_out_417101", "417101034", "story_v_out_417101.awb")

						arg_145_1:RecordAudio("417101034", var_148_17)
						arg_145_1:RecordAudio("417101034", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_417101", "417101034", "story_v_out_417101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_417101", "417101034", "story_v_out_417101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_18 and arg_145_1.time_ < var_148_8 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play417101035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 417101035
		arg_149_1.duration_ = 8.1

		local var_149_0 = {
			zh = 3.6,
			ja = 8.1
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
				arg_149_0:Play417101036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.525

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[595].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(417101035)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101035", "story_v_out_417101.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101035", "story_v_out_417101.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_417101", "417101035", "story_v_out_417101.awb")

						arg_149_1:RecordAudio("417101035", var_152_9)
						arg_149_1:RecordAudio("417101035", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_417101", "417101035", "story_v_out_417101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_417101", "417101035", "story_v_out_417101.awb")
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
	Play417101036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 417101036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play417101037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10128"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10128 == nil then
				arg_153_1.var_.actorSpriteComps10128 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10128 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 0.5, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10128 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10128 = nil
			end

			local var_156_8 = arg_153_1.actors_["10128"].transform
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.var_.moveOldPos10128 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10128", 7)

				local var_156_10 = var_156_8.childCount

				for iter_156_4 = 0, var_156_10 - 1 do
					local var_156_11 = var_156_8:GetChild(iter_156_4)

					if var_156_11.name == "" or not string.find(var_156_11.name, "split") then
						var_156_11.gameObject:SetActive(true)
					else
						var_156_11.gameObject:SetActive(false)
					end
				end
			end

			local var_156_12 = 0.001

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_9) / var_156_12
				local var_156_14 = Vector3.New(0, -2000, -300)

				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10128, var_156_14, var_156_13)
			end

			if arg_153_1.time_ >= var_156_9 + var_156_12 and arg_153_1.time_ < var_156_9 + var_156_12 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_156_15 = 0
			local var_156_16 = 1.05

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_17 = arg_153_1:GetWordFromCfg(417101036)
				local var_156_18 = arg_153_1:FormatText(var_156_17.content)

				arg_153_1.text_.text = var_156_18

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 42
				local var_156_20 = utf8.len(var_156_18)
				local var_156_21 = var_156_19 <= 0 and var_156_16 or var_156_16 * (var_156_20 / var_156_19)

				if var_156_21 > 0 and var_156_16 < var_156_21 then
					arg_153_1.talkMaxDuration = var_156_21

					if var_156_21 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_21 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_18
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_22 and arg_153_1.time_ < var_156_15 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play417101037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 417101037
		arg_157_1.duration_ = 1.2

		local var_157_0 = {
			zh = 1,
			ja = 1.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play417101038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10128"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10128 == nil then
				arg_157_1.var_.actorSpriteComps10128 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10128 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10128 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10128 = nil
			end

			local var_160_8 = arg_157_1.actors_["10128"].transform
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.var_.moveOldPos10128 = var_160_8.localPosition
				var_160_8.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10128", 3)

				local var_160_10 = var_160_8.childCount

				for iter_160_4 = 0, var_160_10 - 1 do
					local var_160_11 = var_160_8:GetChild(iter_160_4)

					if var_160_11.name == "" or not string.find(var_160_11.name, "split") then
						var_160_11.gameObject:SetActive(true)
					else
						var_160_11.gameObject:SetActive(false)
					end
				end
			end

			local var_160_12 = 0.001

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_12 then
				local var_160_13 = (arg_157_1.time_ - var_160_9) / var_160_12
				local var_160_14 = Vector3.New(0, -347, -300)

				var_160_8.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10128, var_160_14, var_160_13)
			end

			if arg_157_1.time_ >= var_160_9 + var_160_12 and arg_157_1.time_ < var_160_9 + var_160_12 + arg_160_0 then
				var_160_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_160_15 = 0
			local var_160_16 = 0.075

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[595].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(417101037)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 3
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101037", "story_v_out_417101.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101037", "story_v_out_417101.awb") / 1000

					if var_160_23 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_15
					end

					if var_160_18.prefab_name ~= "" and arg_157_1.actors_[var_160_18.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_18.prefab_name].transform, "story_v_out_417101", "417101037", "story_v_out_417101.awb")

						arg_157_1:RecordAudio("417101037", var_160_24)
						arg_157_1:RecordAudio("417101037", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_417101", "417101037", "story_v_out_417101.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_417101", "417101037", "story_v_out_417101.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_25 and arg_157_1.time_ < var_160_15 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play417101038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 417101038
		arg_161_1.duration_ = 6

		local var_161_0 = {
			zh = 4.1,
			ja = 6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play417101039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10128"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10128 == nil then
				arg_161_1.var_.actorSpriteComps10128 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10128 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 0.5, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10128 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10128 = nil
			end

			local var_164_8 = 0
			local var_164_9 = 0.55

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_10 = arg_161_1:FormatText(StoryNameCfg[1110].name)

				arg_161_1.leftNameTxt_.text = var_164_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_11 = arg_161_1:GetWordFromCfg(417101038)
				local var_164_12 = arg_161_1:FormatText(var_164_11.content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 22
				local var_164_14 = utf8.len(var_164_12)
				local var_164_15 = var_164_13 <= 0 and var_164_9 or var_164_9 * (var_164_14 / var_164_13)

				if var_164_15 > 0 and var_164_9 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101038", "story_v_out_417101.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101038", "story_v_out_417101.awb") / 1000

					if var_164_16 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_8
					end

					if var_164_11.prefab_name ~= "" and arg_161_1.actors_[var_164_11.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_11.prefab_name].transform, "story_v_out_417101", "417101038", "story_v_out_417101.awb")

						arg_161_1:RecordAudio("417101038", var_164_17)
						arg_161_1:RecordAudio("417101038", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_417101", "417101038", "story_v_out_417101.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_417101", "417101038", "story_v_out_417101.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_18 and arg_161_1.time_ < var_164_8 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play417101039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 417101039
		arg_165_1.duration_ = 8

		local var_165_0 = {
			zh = 3.1,
			ja = 8
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
				arg_165_0:Play417101040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10128"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10128 == nil then
				arg_165_1.var_.actorSpriteComps10128 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10128 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10128 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10128 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.325

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_10 = arg_165_1:FormatText(StoryNameCfg[595].name)

				arg_165_1.leftNameTxt_.text = var_168_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:GetWordFromCfg(417101039)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 13
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_9 or var_168_9 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_9 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101039", "story_v_out_417101.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101039", "story_v_out_417101.awb") / 1000

					if var_168_16 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_8
					end

					if var_168_11.prefab_name ~= "" and arg_165_1.actors_[var_168_11.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_11.prefab_name].transform, "story_v_out_417101", "417101039", "story_v_out_417101.awb")

						arg_165_1:RecordAudio("417101039", var_168_17)
						arg_165_1:RecordAudio("417101039", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_417101", "417101039", "story_v_out_417101.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_417101", "417101039", "story_v_out_417101.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_18 and arg_165_1.time_ < var_168_8 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play417101040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 417101040
		arg_169_1.duration_ = 5.47

		local var_169_0 = {
			zh = 4.63266666666667,
			ja = 5.46666666666667
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play417101041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = "I16h"

			if arg_169_1.bgs_[var_172_0] == nil then
				local var_172_1 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_172_0)
				var_172_1.name = var_172_0
				var_172_1.transform.parent = arg_169_1.stage_.transform
				var_172_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_[var_172_0] = var_172_1
			end

			local var_172_2 = 1.999999999999

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				local var_172_3 = manager.ui.mainCamera.transform.localPosition
				local var_172_4 = Vector3.New(0, 0, 10) + Vector3.New(var_172_3.x, var_172_3.y, 0)
				local var_172_5 = arg_169_1.bgs_.I16h

				var_172_5.transform.localPosition = var_172_4
				var_172_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_6 = var_172_5:GetComponent("SpriteRenderer")

				if var_172_6 and var_172_6.sprite then
					local var_172_7 = (var_172_5.transform.localPosition - var_172_3).z
					local var_172_8 = manager.ui.mainCameraCom_
					local var_172_9 = 2 * var_172_7 * Mathf.Tan(var_172_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_10 = var_172_9 * var_172_8.aspect
					local var_172_11 = var_172_6.sprite.bounds.size.x
					local var_172_12 = var_172_6.sprite.bounds.size.y
					local var_172_13 = var_172_10 / var_172_11
					local var_172_14 = var_172_9 / var_172_12
					local var_172_15 = var_172_14 < var_172_13 and var_172_13 or var_172_14

					var_172_5.transform.localScale = Vector3.New(var_172_15, var_172_15, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "I16h" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_16 = 1.999999999999

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_17 = 0.3

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_18 = 0

			if var_172_18 < arg_169_1.time_ and arg_169_1.time_ <= var_172_18 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_19 = 2

			if var_172_18 <= arg_169_1.time_ and arg_169_1.time_ < var_172_18 + var_172_19 then
				local var_172_20 = (arg_169_1.time_ - var_172_18) / var_172_19
				local var_172_21 = Color.New(0, 0, 0)

				var_172_21.a = Mathf.Lerp(0, 1, var_172_20)
				arg_169_1.mask_.color = var_172_21
			end

			if arg_169_1.time_ >= var_172_18 + var_172_19 and arg_169_1.time_ < var_172_18 + var_172_19 + arg_172_0 then
				local var_172_22 = Color.New(0, 0, 0)

				var_172_22.a = 1
				arg_169_1.mask_.color = var_172_22
			end

			local var_172_23 = 1.999999999999

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_24 = 1.84166666666767

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_24 then
				local var_172_25 = (arg_169_1.time_ - var_172_23) / var_172_24
				local var_172_26 = Color.New(0, 0, 0)

				var_172_26.a = Mathf.Lerp(1, 0, var_172_25)
				arg_169_1.mask_.color = var_172_26
			end

			if arg_169_1.time_ >= var_172_23 + var_172_24 and arg_169_1.time_ < var_172_23 + var_172_24 + arg_172_0 then
				local var_172_27 = Color.New(0, 0, 0)
				local var_172_28 = 0

				arg_169_1.mask_.enabled = false
				var_172_27.a = var_172_28
				arg_169_1.mask_.color = var_172_27
			end

			local var_172_29 = arg_169_1.actors_["10128"].transform
			local var_172_30 = 1.965999999999

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.var_.moveOldPos10128 = var_172_29.localPosition
				var_172_29.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10128", 7)

				local var_172_31 = var_172_29.childCount

				for iter_172_2 = 0, var_172_31 - 1 do
					local var_172_32 = var_172_29:GetChild(iter_172_2)

					if var_172_32.name == "" or not string.find(var_172_32.name, "split") then
						var_172_32.gameObject:SetActive(true)
					else
						var_172_32.gameObject:SetActive(false)
					end
				end
			end

			local var_172_33 = 0.001

			if var_172_30 <= arg_169_1.time_ and arg_169_1.time_ < var_172_30 + var_172_33 then
				local var_172_34 = (arg_169_1.time_ - var_172_30) / var_172_33
				local var_172_35 = Vector3.New(0, -2000, -300)

				var_172_29.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10128, var_172_35, var_172_34)
			end

			if arg_169_1.time_ >= var_172_30 + var_172_33 and arg_169_1.time_ < var_172_30 + var_172_33 + arg_172_0 then
				var_172_29.localPosition = Vector3.New(0, -2000, -300)
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_36 = 3.76666666666667
			local var_172_37 = 0.075

			if var_172_36 < arg_169_1.time_ and arg_169_1.time_ <= var_172_36 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_38 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_38:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_39 = arg_169_1:FormatText(StoryNameCfg[595].name)

				arg_169_1.leftNameTxt_.text = var_172_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_2")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_40 = arg_169_1:GetWordFromCfg(417101040)
				local var_172_41 = arg_169_1:FormatText(var_172_40.content)

				arg_169_1.text_.text = var_172_41

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_42 = 3
				local var_172_43 = utf8.len(var_172_41)
				local var_172_44 = var_172_42 <= 0 and var_172_37 or var_172_37 * (var_172_43 / var_172_42)

				if var_172_44 > 0 and var_172_37 < var_172_44 then
					arg_169_1.talkMaxDuration = var_172_44
					var_172_36 = var_172_36 + 0.3

					if var_172_44 + var_172_36 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_44 + var_172_36
					end
				end

				arg_169_1.text_.text = var_172_41
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101040", "story_v_out_417101.awb") ~= 0 then
					local var_172_45 = manager.audio:GetVoiceLength("story_v_out_417101", "417101040", "story_v_out_417101.awb") / 1000

					if var_172_45 + var_172_36 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_45 + var_172_36
					end

					if var_172_40.prefab_name ~= "" and arg_169_1.actors_[var_172_40.prefab_name] ~= nil then
						local var_172_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_40.prefab_name].transform, "story_v_out_417101", "417101040", "story_v_out_417101.awb")

						arg_169_1:RecordAudio("417101040", var_172_46)
						arg_169_1:RecordAudio("417101040", var_172_46)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_417101", "417101040", "story_v_out_417101.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_417101", "417101040", "story_v_out_417101.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_47 = var_172_36 + 0.3
			local var_172_48 = math.max(var_172_37, arg_169_1.talkMaxDuration)

			if var_172_47 <= arg_169_1.time_ and arg_169_1.time_ < var_172_47 + var_172_48 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_47) / var_172_48

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_47 + var_172_48 and arg_169_1.time_ < var_172_47 + var_172_48 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.965999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play417101041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 417101041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play417101042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10128"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10128 == nil then
				arg_175_1.var_.actorSpriteComps10128 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps10128 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor2.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor2.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor2.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 0.5, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10128 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10128 = nil
			end

			local var_178_8 = 0.05
			local var_178_9 = 1

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				local var_178_10 = "play"
				local var_178_11 = "effect"

				arg_175_1:AudioAction(var_178_10, var_178_11, "se_story_1310", "se_story_1310_footsteps", "")
			end

			local var_178_12 = 0
			local var_178_13 = 0.575

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_14 = arg_175_1:GetWordFromCfg(417101041)
				local var_178_15 = arg_175_1:FormatText(var_178_14.content)

				arg_175_1.text_.text = var_178_15

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_16 = 23
				local var_178_17 = utf8.len(var_178_15)
				local var_178_18 = var_178_16 <= 0 and var_178_13 or var_178_13 * (var_178_17 / var_178_16)

				if var_178_18 > 0 and var_178_13 < var_178_18 then
					arg_175_1.talkMaxDuration = var_178_18

					if var_178_18 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_18 + var_178_12
					end
				end

				arg_175_1.text_.text = var_178_15
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_19 = math.max(var_178_13, arg_175_1.talkMaxDuration)

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_19 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_12) / var_178_19

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_12 + var_178_19 and arg_175_1.time_ < var_178_12 + var_178_19 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play417101042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 417101042
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play417101043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.25

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(417101042)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 50
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play417101043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 417101043
		arg_183_1.duration_ = 2.97

		local var_183_0 = {
			zh = 2.966,
			ja = 1.233
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
				arg_183_0:Play417101044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.175

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[468].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(417101043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101043", "story_v_out_417101.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101043", "story_v_out_417101.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_417101", "417101043", "story_v_out_417101.awb")

						arg_183_1:RecordAudio("417101043", var_186_9)
						arg_183_1:RecordAudio("417101043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_417101", "417101043", "story_v_out_417101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_417101", "417101043", "story_v_out_417101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play417101044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 417101044
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play417101045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.85

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

				local var_190_2 = arg_187_1:GetWordFromCfg(417101044)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 74
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
	Play417101045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 417101045
		arg_191_1.duration_ = 10.57

		local var_191_0 = {
			zh = 5.133,
			ja = 10.566
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play417101046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.5

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[468].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(417101045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101045", "story_v_out_417101.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101045", "story_v_out_417101.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_417101", "417101045", "story_v_out_417101.awb")

						arg_191_1:RecordAudio("417101045", var_194_9)
						arg_191_1:RecordAudio("417101045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_417101", "417101045", "story_v_out_417101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_417101", "417101045", "story_v_out_417101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play417101046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 417101046
		arg_195_1.duration_ = 4.63

		local var_195_0 = {
			zh = 4.466,
			ja = 4.633
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
				arg_195_0:Play417101047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10128"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10128 == nil then
				arg_195_1.var_.actorSpriteComps10128 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10128 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10128 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10128 = nil
			end

			local var_198_8 = arg_195_1.actors_["10128"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos10128 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10128", 3)

				local var_198_10 = var_198_8.childCount

				for iter_198_4 = 0, var_198_10 - 1 do
					local var_198_11 = var_198_8:GetChild(iter_198_4)

					if var_198_11.name == "" or not string.find(var_198_11.name, "split") then
						var_198_11.gameObject:SetActive(true)
					else
						var_198_11.gameObject:SetActive(false)
					end
				end
			end

			local var_198_12 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_9) / var_198_12
				local var_198_14 = Vector3.New(0, -347, -300)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10128, var_198_14, var_198_13)
			end

			if arg_195_1.time_ >= var_198_9 + var_198_12 and arg_195_1.time_ < var_198_9 + var_198_12 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_198_15 = 0
			local var_198_16 = 0.55

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[595].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(417101046)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101046", "story_v_out_417101.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101046", "story_v_out_417101.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_417101", "417101046", "story_v_out_417101.awb")

						arg_195_1:RecordAudio("417101046", var_198_24)
						arg_195_1:RecordAudio("417101046", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_417101", "417101046", "story_v_out_417101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_417101", "417101046", "story_v_out_417101.awb")
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
				actorName = "10128",
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
	Play417101047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 417101047
		arg_199_1.duration_ = 8.4

		local var_199_0 = {
			zh = 5.233,
			ja = 8.4
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play417101048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10128"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10128 == nil then
				arg_199_1.var_.actorSpriteComps10128 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10128 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10128 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10128 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.5

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[468].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(417101047)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 20
				local var_202_14 = utf8.len(var_202_12)
				local var_202_15 = var_202_13 <= 0 and var_202_9 or var_202_9 * (var_202_14 / var_202_13)

				if var_202_15 > 0 and var_202_9 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_12
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101047", "story_v_out_417101.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101047", "story_v_out_417101.awb") / 1000

					if var_202_16 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_8
					end

					if var_202_11.prefab_name ~= "" and arg_199_1.actors_[var_202_11.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_11.prefab_name].transform, "story_v_out_417101", "417101047", "story_v_out_417101.awb")

						arg_199_1:RecordAudio("417101047", var_202_17)
						arg_199_1:RecordAudio("417101047", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_417101", "417101047", "story_v_out_417101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_417101", "417101047", "story_v_out_417101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_18 and arg_199_1.time_ < var_202_8 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play417101048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 417101048
		arg_203_1.duration_ = 3.83

		local var_203_0 = {
			zh = 1.5,
			ja = 3.833
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
				arg_203_0:Play417101049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10128"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10128 == nil then
				arg_203_1.var_.actorSpriteComps10128 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10128 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10128 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10128 = nil
			end

			local var_206_8 = 0
			local var_206_9 = 0.175

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_10 = arg_203_1:FormatText(StoryNameCfg[595].name)

				arg_203_1.leftNameTxt_.text = var_206_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_11 = arg_203_1:GetWordFromCfg(417101048)
				local var_206_12 = arg_203_1:FormatText(var_206_11.content)

				arg_203_1.text_.text = var_206_12

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 7
				local var_206_14 = utf8.len(var_206_12)
				local var_206_15 = var_206_13 <= 0 and var_206_9 or var_206_9 * (var_206_14 / var_206_13)

				if var_206_15 > 0 and var_206_9 < var_206_15 then
					arg_203_1.talkMaxDuration = var_206_15

					if var_206_15 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_15 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_12
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101048", "story_v_out_417101.awb") ~= 0 then
					local var_206_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101048", "story_v_out_417101.awb") / 1000

					if var_206_16 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_16 + var_206_8
					end

					if var_206_11.prefab_name ~= "" and arg_203_1.actors_[var_206_11.prefab_name] ~= nil then
						local var_206_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_11.prefab_name].transform, "story_v_out_417101", "417101048", "story_v_out_417101.awb")

						arg_203_1:RecordAudio("417101048", var_206_17)
						arg_203_1:RecordAudio("417101048", var_206_17)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_417101", "417101048", "story_v_out_417101.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_417101", "417101048", "story_v_out_417101.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_18 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_18 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_18

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_18 and arg_203_1.time_ < var_206_8 + var_206_18 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play417101049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 417101049
		arg_207_1.duration_ = 11.03

		local var_207_0 = {
			zh = 11.033,
			ja = 4.766
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
				arg_207_0:Play417101050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10128"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10128 == nil then
				arg_207_1.var_.actorSpriteComps10128 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10128 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10128 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10128 = nil
			end

			local var_210_8 = 0
			local var_210_9 = 0.875

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_10 = arg_207_1:FormatText(StoryNameCfg[468].name)

				arg_207_1.leftNameTxt_.text = var_210_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_11 = arg_207_1:GetWordFromCfg(417101049)
				local var_210_12 = arg_207_1:FormatText(var_210_11.content)

				arg_207_1.text_.text = var_210_12

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 35
				local var_210_14 = utf8.len(var_210_12)
				local var_210_15 = var_210_13 <= 0 and var_210_9 or var_210_9 * (var_210_14 / var_210_13)

				if var_210_15 > 0 and var_210_9 < var_210_15 then
					arg_207_1.talkMaxDuration = var_210_15

					if var_210_15 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_12
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101049", "story_v_out_417101.awb") ~= 0 then
					local var_210_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101049", "story_v_out_417101.awb") / 1000

					if var_210_16 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_16 + var_210_8
					end

					if var_210_11.prefab_name ~= "" and arg_207_1.actors_[var_210_11.prefab_name] ~= nil then
						local var_210_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_11.prefab_name].transform, "story_v_out_417101", "417101049", "story_v_out_417101.awb")

						arg_207_1:RecordAudio("417101049", var_210_17)
						arg_207_1:RecordAudio("417101049", var_210_17)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_417101", "417101049", "story_v_out_417101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_417101", "417101049", "story_v_out_417101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_18 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_18 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_18

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_18 and arg_207_1.time_ < var_210_8 + var_210_18 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play417101050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 417101050
		arg_211_1.duration_ = 6.73

		local var_211_0 = {
			zh = 4.266,
			ja = 6.733
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
				arg_211_0:Play417101051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10128"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10128 == nil then
				arg_211_1.var_.actorSpriteComps10128 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps10128 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10128 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10128 = nil
			end

			local var_214_8 = arg_211_1.actors_["10128"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos10128 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10128", 3)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "split_2" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(0, -347, -300)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10128, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_214_15 = 0
			local var_214_16 = 0.475

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[595].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(417101050)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101050", "story_v_out_417101.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101050", "story_v_out_417101.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_417101", "417101050", "story_v_out_417101.awb")

						arg_211_1:RecordAudio("417101050", var_214_24)
						arg_211_1:RecordAudio("417101050", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_417101", "417101050", "story_v_out_417101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_417101", "417101050", "story_v_out_417101.awb")
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
				actorName = "10128",
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
	Play417101051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 417101051
		arg_215_1.duration_ = 8.73

		local var_215_0 = {
			zh = 8.733,
			ja = 8.1
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
				arg_215_0:Play417101052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.15

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[595].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:GetWordFromCfg(417101051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 46
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101051", "story_v_out_417101.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101051", "story_v_out_417101.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_417101", "417101051", "story_v_out_417101.awb")

						arg_215_1:RecordAudio("417101051", var_218_9)
						arg_215_1:RecordAudio("417101051", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_417101", "417101051", "story_v_out_417101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_417101", "417101051", "story_v_out_417101.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play417101052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 417101052
		arg_219_1.duration_ = 8.77

		local var_219_0 = {
			zh = 8.766,
			ja = 8.466
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play417101053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10128"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10128 == nil then
				arg_219_1.var_.actorSpriteComps10128 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps10128 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10128 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10128 = nil
			end

			local var_222_8 = 0
			local var_222_9 = 0.825

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_10 = arg_219_1:FormatText(StoryNameCfg[468].name)

				arg_219_1.leftNameTxt_.text = var_222_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_11 = arg_219_1:GetWordFromCfg(417101052)
				local var_222_12 = arg_219_1:FormatText(var_222_11.content)

				arg_219_1.text_.text = var_222_12

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 33
				local var_222_14 = utf8.len(var_222_12)
				local var_222_15 = var_222_13 <= 0 and var_222_9 or var_222_9 * (var_222_14 / var_222_13)

				if var_222_15 > 0 and var_222_9 < var_222_15 then
					arg_219_1.talkMaxDuration = var_222_15

					if var_222_15 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_15 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_12
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101052", "story_v_out_417101.awb") ~= 0 then
					local var_222_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101052", "story_v_out_417101.awb") / 1000

					if var_222_16 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_16 + var_222_8
					end

					if var_222_11.prefab_name ~= "" and arg_219_1.actors_[var_222_11.prefab_name] ~= nil then
						local var_222_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_11.prefab_name].transform, "story_v_out_417101", "417101052", "story_v_out_417101.awb")

						arg_219_1:RecordAudio("417101052", var_222_17)
						arg_219_1:RecordAudio("417101052", var_222_17)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_417101", "417101052", "story_v_out_417101.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_417101", "417101052", "story_v_out_417101.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_18 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_18 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_18

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_18 and arg_219_1.time_ < var_222_8 + var_222_18 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play417101053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 417101053
		arg_223_1.duration_ = 15.1

		local var_223_0 = {
			zh = 5.5,
			ja = 15.1
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
				arg_223_0:Play417101054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10128"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10128 == nil then
				arg_223_1.var_.actorSpriteComps10128 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10128 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10128 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10128 = nil
			end

			local var_226_8 = 0
			local var_226_9 = 0.575

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_10 = arg_223_1:FormatText(StoryNameCfg[595].name)

				arg_223_1.leftNameTxt_.text = var_226_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_11 = arg_223_1:GetWordFromCfg(417101053)
				local var_226_12 = arg_223_1:FormatText(var_226_11.content)

				arg_223_1.text_.text = var_226_12

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 23
				local var_226_14 = utf8.len(var_226_12)
				local var_226_15 = var_226_13 <= 0 and var_226_9 or var_226_9 * (var_226_14 / var_226_13)

				if var_226_15 > 0 and var_226_9 < var_226_15 then
					arg_223_1.talkMaxDuration = var_226_15

					if var_226_15 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_12
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101053", "story_v_out_417101.awb") ~= 0 then
					local var_226_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101053", "story_v_out_417101.awb") / 1000

					if var_226_16 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_8
					end

					if var_226_11.prefab_name ~= "" and arg_223_1.actors_[var_226_11.prefab_name] ~= nil then
						local var_226_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_11.prefab_name].transform, "story_v_out_417101", "417101053", "story_v_out_417101.awb")

						arg_223_1:RecordAudio("417101053", var_226_17)
						arg_223_1:RecordAudio("417101053", var_226_17)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_417101", "417101053", "story_v_out_417101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_417101", "417101053", "story_v_out_417101.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_18 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_18 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_18

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_18 and arg_223_1.time_ < var_226_8 + var_226_18 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play417101054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 417101054
		arg_227_1.duration_ = 5

		local var_227_0 = {
			zh = 1.7,
			ja = 5
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
				arg_227_0:Play417101055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10128"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10128 == nil then
				arg_227_1.var_.actorSpriteComps10128 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps10128 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 0.5, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10128 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10128 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.175

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_10 = arg_227_1:FormatText(StoryNameCfg[468].name)

				arg_227_1.leftNameTxt_.text = var_230_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_11 = arg_227_1:GetWordFromCfg(417101054)
				local var_230_12 = arg_227_1:FormatText(var_230_11.content)

				arg_227_1.text_.text = var_230_12

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 7
				local var_230_14 = utf8.len(var_230_12)
				local var_230_15 = var_230_13 <= 0 and var_230_9 or var_230_9 * (var_230_14 / var_230_13)

				if var_230_15 > 0 and var_230_9 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_12
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101054", "story_v_out_417101.awb") ~= 0 then
					local var_230_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101054", "story_v_out_417101.awb") / 1000

					if var_230_16 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_8
					end

					if var_230_11.prefab_name ~= "" and arg_227_1.actors_[var_230_11.prefab_name] ~= nil then
						local var_230_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_11.prefab_name].transform, "story_v_out_417101", "417101054", "story_v_out_417101.awb")

						arg_227_1:RecordAudio("417101054", var_230_17)
						arg_227_1:RecordAudio("417101054", var_230_17)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_417101", "417101054", "story_v_out_417101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_417101", "417101054", "story_v_out_417101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_18 and arg_227_1.time_ < var_230_8 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play417101055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 417101055
		arg_231_1.duration_ = 10.27

		local var_231_0 = {
			zh = 8.266,
			ja = 10.266
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
				arg_231_0:Play417101056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10128"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10128 == nil then
				arg_231_1.var_.actorSpriteComps10128 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10128 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10128 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10128 = nil
			end

			local var_234_8 = arg_231_1.actors_["10128"].transform
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.var_.moveOldPos10128 = var_234_8.localPosition
				var_234_8.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10128", 3)

				local var_234_10 = var_234_8.childCount

				for iter_234_4 = 0, var_234_10 - 1 do
					local var_234_11 = var_234_8:GetChild(iter_234_4)

					if var_234_11.name == "split_6" or not string.find(var_234_11.name, "split") then
						var_234_11.gameObject:SetActive(true)
					else
						var_234_11.gameObject:SetActive(false)
					end
				end
			end

			local var_234_12 = 0.001

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_9) / var_234_12
				local var_234_14 = Vector3.New(0, -347, -300)

				var_234_8.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10128, var_234_14, var_234_13)
			end

			if arg_231_1.time_ >= var_234_9 + var_234_12 and arg_231_1.time_ < var_234_9 + var_234_12 + arg_234_0 then
				var_234_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_234_15 = 0
			local var_234_16 = 1.025

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[595].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(417101055)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 41
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101055", "story_v_out_417101.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101055", "story_v_out_417101.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_417101", "417101055", "story_v_out_417101.awb")

						arg_231_1:RecordAudio("417101055", var_234_24)
						arg_231_1:RecordAudio("417101055", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_417101", "417101055", "story_v_out_417101.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_417101", "417101055", "story_v_out_417101.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play417101056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 417101056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play417101057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10128"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10128 == nil then
				arg_235_1.var_.actorSpriteComps10128 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10128 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10128 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10128 = nil
			end

			local var_238_8 = arg_235_1.actors_["10128"].transform
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.var_.moveOldPos10128 = var_238_8.localPosition
				var_238_8.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10128", 7)

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
				local var_238_14 = Vector3.New(0, -2000, -300)

				var_238_8.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10128, var_238_14, var_238_13)
			end

			if arg_235_1.time_ >= var_238_9 + var_238_12 and arg_235_1.time_ < var_238_9 + var_238_12 + arg_238_0 then
				var_238_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_238_15 = 0
			local var_238_16 = 0.825

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_17 = arg_235_1:GetWordFromCfg(417101056)
				local var_238_18 = arg_235_1:FormatText(var_238_17.content)

				arg_235_1.text_.text = var_238_18

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_19 = 33
				local var_238_20 = utf8.len(var_238_18)
				local var_238_21 = var_238_19 <= 0 and var_238_16 or var_238_16 * (var_238_20 / var_238_19)

				if var_238_21 > 0 and var_238_16 < var_238_21 then
					arg_235_1.talkMaxDuration = var_238_21

					if var_238_21 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_21 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_18
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_22 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_22 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_22

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_22 and arg_235_1.time_ < var_238_15 + var_238_22 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play417101057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 417101057
		arg_239_1.duration_ = 12.03

		local var_239_0 = {
			zh = 9.5,
			ja = 12.033
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
				arg_239_0:Play417101058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.075

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[468].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(417101057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 43
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101057", "story_v_out_417101.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101057", "story_v_out_417101.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_417101", "417101057", "story_v_out_417101.awb")

						arg_239_1:RecordAudio("417101057", var_242_9)
						arg_239_1:RecordAudio("417101057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_417101", "417101057", "story_v_out_417101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_417101", "417101057", "story_v_out_417101.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play417101058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 417101058
		arg_243_1.duration_ = 11.2

		local var_243_0 = {
			zh = 11.2,
			ja = 9.8
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
				arg_243_0:Play417101059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.05

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[468].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(417101058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 42
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101058", "story_v_out_417101.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101058", "story_v_out_417101.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_417101", "417101058", "story_v_out_417101.awb")

						arg_243_1:RecordAudio("417101058", var_246_9)
						arg_243_1:RecordAudio("417101058", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_417101", "417101058", "story_v_out_417101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_417101", "417101058", "story_v_out_417101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play417101059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417101059
		arg_247_1.duration_ = 9.5

		local var_247_0 = {
			zh = 7.533,
			ja = 9.5
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
				arg_247_0:Play417101060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.725

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[468].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(417101059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 29
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101059", "story_v_out_417101.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101059", "story_v_out_417101.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_417101", "417101059", "story_v_out_417101.awb")

						arg_247_1:RecordAudio("417101059", var_250_9)
						arg_247_1:RecordAudio("417101059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_417101", "417101059", "story_v_out_417101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_417101", "417101059", "story_v_out_417101.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play417101060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 417101060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play417101061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.2

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(417101060)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 48
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play417101061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 417101061
		arg_255_1.duration_ = 4.97

		local var_255_0 = {
			zh = 4.966,
			ja = 4.7
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
				arg_255_0:Play417101062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.4

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[468].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(417101061)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101061", "story_v_out_417101.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101061", "story_v_out_417101.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_417101", "417101061", "story_v_out_417101.awb")

						arg_255_1:RecordAudio("417101061", var_258_9)
						arg_255_1:RecordAudio("417101061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_417101", "417101061", "story_v_out_417101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_417101", "417101061", "story_v_out_417101.awb")
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
	Play417101062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 417101062
		arg_259_1.duration_ = 11.67

		local var_259_0 = {
			zh = 5.8,
			ja = 11.666
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
				arg_259_0:Play417101063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10128"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10128 == nil then
				arg_259_1.var_.actorSpriteComps10128 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10128 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10128 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10128 = nil
			end

			local var_262_8 = arg_259_1.actors_["10128"].transform
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1.var_.moveOldPos10128 = var_262_8.localPosition
				var_262_8.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10128", 3)

				local var_262_10 = var_262_8.childCount

				for iter_262_4 = 0, var_262_10 - 1 do
					local var_262_11 = var_262_8:GetChild(iter_262_4)

					if var_262_11.name == "" or not string.find(var_262_11.name, "split") then
						var_262_11.gameObject:SetActive(true)
					else
						var_262_11.gameObject:SetActive(false)
					end
				end
			end

			local var_262_12 = 0.001

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_12 then
				local var_262_13 = (arg_259_1.time_ - var_262_9) / var_262_12
				local var_262_14 = Vector3.New(0, -347, -300)

				var_262_8.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10128, var_262_14, var_262_13)
			end

			if arg_259_1.time_ >= var_262_9 + var_262_12 and arg_259_1.time_ < var_262_9 + var_262_12 + arg_262_0 then
				var_262_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_262_15 = 0
			local var_262_16 = 0.675

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[595].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(417101062)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 27
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101062", "story_v_out_417101.awb") ~= 0 then
					local var_262_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101062", "story_v_out_417101.awb") / 1000

					if var_262_23 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_15
					end

					if var_262_18.prefab_name ~= "" and arg_259_1.actors_[var_262_18.prefab_name] ~= nil then
						local var_262_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_18.prefab_name].transform, "story_v_out_417101", "417101062", "story_v_out_417101.awb")

						arg_259_1:RecordAudio("417101062", var_262_24)
						arg_259_1:RecordAudio("417101062", var_262_24)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_417101", "417101062", "story_v_out_417101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_417101", "417101062", "story_v_out_417101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_25 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_25 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_25

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_25 and arg_259_1.time_ < var_262_15 + var_262_25 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play417101063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417101063
		arg_263_1.duration_ = 5.33

		local var_263_0 = {
			zh = 4.733,
			ja = 5.333
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
				arg_263_0:Play417101064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10128"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10128 == nil then
				arg_263_1.var_.actorSpriteComps10128 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10128 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 0.5, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10128 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10128 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 0.375

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_10 = arg_263_1:FormatText(StoryNameCfg[468].name)

				arg_263_1.leftNameTxt_.text = var_266_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_11 = arg_263_1:GetWordFromCfg(417101063)
				local var_266_12 = arg_263_1:FormatText(var_266_11.content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 15
				local var_266_14 = utf8.len(var_266_12)
				local var_266_15 = var_266_13 <= 0 and var_266_9 or var_266_9 * (var_266_14 / var_266_13)

				if var_266_15 > 0 and var_266_9 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101063", "story_v_out_417101.awb") ~= 0 then
					local var_266_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101063", "story_v_out_417101.awb") / 1000

					if var_266_16 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_16 + var_266_8
					end

					if var_266_11.prefab_name ~= "" and arg_263_1.actors_[var_266_11.prefab_name] ~= nil then
						local var_266_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_11.prefab_name].transform, "story_v_out_417101", "417101063", "story_v_out_417101.awb")

						arg_263_1:RecordAudio("417101063", var_266_17)
						arg_263_1:RecordAudio("417101063", var_266_17)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_417101", "417101063", "story_v_out_417101.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_417101", "417101063", "story_v_out_417101.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_18 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_18 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_18

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_18 and arg_263_1.time_ < var_266_8 + var_266_18 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play417101064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417101064
		arg_267_1.duration_ = 9.83

		local var_267_0 = {
			zh = 5.6,
			ja = 9.833
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play417101065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10128"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10128 == nil then
				arg_267_1.var_.actorSpriteComps10128 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10128 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10128 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10128 = nil
			end

			local var_270_8 = 0
			local var_270_9 = 0.675

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_10 = arg_267_1:FormatText(StoryNameCfg[595].name)

				arg_267_1.leftNameTxt_.text = var_270_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_11 = arg_267_1:GetWordFromCfg(417101064)
				local var_270_12 = arg_267_1:FormatText(var_270_11.content)

				arg_267_1.text_.text = var_270_12

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_13 = 27
				local var_270_14 = utf8.len(var_270_12)
				local var_270_15 = var_270_13 <= 0 and var_270_9 or var_270_9 * (var_270_14 / var_270_13)

				if var_270_15 > 0 and var_270_9 < var_270_15 then
					arg_267_1.talkMaxDuration = var_270_15

					if var_270_15 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_15 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_12
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101064", "story_v_out_417101.awb") ~= 0 then
					local var_270_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101064", "story_v_out_417101.awb") / 1000

					if var_270_16 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_16 + var_270_8
					end

					if var_270_11.prefab_name ~= "" and arg_267_1.actors_[var_270_11.prefab_name] ~= nil then
						local var_270_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_11.prefab_name].transform, "story_v_out_417101", "417101064", "story_v_out_417101.awb")

						arg_267_1:RecordAudio("417101064", var_270_17)
						arg_267_1:RecordAudio("417101064", var_270_17)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_417101", "417101064", "story_v_out_417101.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_417101", "417101064", "story_v_out_417101.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_18 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_18 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_18

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_18 and arg_267_1.time_ < var_270_8 + var_270_18 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417101065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417101065
		arg_271_1.duration_ = 6.57

		local var_271_0 = {
			zh = 5.066,
			ja = 6.566
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
				arg_271_0:Play417101066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10128"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10128 == nil then
				arg_271_1.var_.actorSpriteComps10128 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10128 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10128 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10128 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 0.475

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_10 = arg_271_1:FormatText(StoryNameCfg[468].name)

				arg_271_1.leftNameTxt_.text = var_274_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_11 = arg_271_1:GetWordFromCfg(417101065)
				local var_274_12 = arg_271_1:FormatText(var_274_11.content)

				arg_271_1.text_.text = var_274_12

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 19
				local var_274_14 = utf8.len(var_274_12)
				local var_274_15 = var_274_13 <= 0 and var_274_9 or var_274_9 * (var_274_14 / var_274_13)

				if var_274_15 > 0 and var_274_9 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_12
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101065", "story_v_out_417101.awb") ~= 0 then
					local var_274_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101065", "story_v_out_417101.awb") / 1000

					if var_274_16 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_16 + var_274_8
					end

					if var_274_11.prefab_name ~= "" and arg_271_1.actors_[var_274_11.prefab_name] ~= nil then
						local var_274_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_11.prefab_name].transform, "story_v_out_417101", "417101065", "story_v_out_417101.awb")

						arg_271_1:RecordAudio("417101065", var_274_17)
						arg_271_1:RecordAudio("417101065", var_274_17)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_417101", "417101065", "story_v_out_417101.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_417101", "417101065", "story_v_out_417101.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_18 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_18 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_18

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_18 and arg_271_1.time_ < var_274_8 + var_274_18 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play417101066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417101066
		arg_275_1.duration_ = 14.47

		local var_275_0 = {
			zh = 13.866,
			ja = 14.466
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play417101067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 1.275

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[468].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(417101066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 51
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101066", "story_v_out_417101.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101066", "story_v_out_417101.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_417101", "417101066", "story_v_out_417101.awb")

						arg_275_1:RecordAudio("417101066", var_278_9)
						arg_275_1:RecordAudio("417101066", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_417101", "417101066", "story_v_out_417101.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_417101", "417101066", "story_v_out_417101.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play417101067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417101067
		arg_279_1.duration_ = 9.07

		local var_279_0 = {
			zh = 4.6,
			ja = 9.066
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
				arg_279_0:Play417101068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10128"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10128 == nil then
				arg_279_1.var_.actorSpriteComps10128 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10128 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10128 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10128 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.55

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_10 = arg_279_1:FormatText(StoryNameCfg[595].name)

				arg_279_1.leftNameTxt_.text = var_282_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_11 = arg_279_1:GetWordFromCfg(417101067)
				local var_282_12 = arg_279_1:FormatText(var_282_11.content)

				arg_279_1.text_.text = var_282_12

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 22
				local var_282_14 = utf8.len(var_282_12)
				local var_282_15 = var_282_13 <= 0 and var_282_9 or var_282_9 * (var_282_14 / var_282_13)

				if var_282_15 > 0 and var_282_9 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15

					if var_282_15 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_12
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101067", "story_v_out_417101.awb") ~= 0 then
					local var_282_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101067", "story_v_out_417101.awb") / 1000

					if var_282_16 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_16 + var_282_8
					end

					if var_282_11.prefab_name ~= "" and arg_279_1.actors_[var_282_11.prefab_name] ~= nil then
						local var_282_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_11.prefab_name].transform, "story_v_out_417101", "417101067", "story_v_out_417101.awb")

						arg_279_1:RecordAudio("417101067", var_282_17)
						arg_279_1:RecordAudio("417101067", var_282_17)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417101", "417101067", "story_v_out_417101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417101", "417101067", "story_v_out_417101.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_18 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_18 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_18

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_18 and arg_279_1.time_ < var_282_8 + var_282_18 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play417101068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417101068
		arg_283_1.duration_ = 2.67

		local var_283_0 = {
			zh = 1.2,
			ja = 2.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play417101069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10128"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10128 == nil then
				arg_283_1.var_.actorSpriteComps10128 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10128 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10128 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10128 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 0.1

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[468].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_11 = arg_283_1:GetWordFromCfg(417101068)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 4
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101068", "story_v_out_417101.awb") ~= 0 then
					local var_286_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101068", "story_v_out_417101.awb") / 1000

					if var_286_16 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_8
					end

					if var_286_11.prefab_name ~= "" and arg_283_1.actors_[var_286_11.prefab_name] ~= nil then
						local var_286_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_11.prefab_name].transform, "story_v_out_417101", "417101068", "story_v_out_417101.awb")

						arg_283_1:RecordAudio("417101068", var_286_17)
						arg_283_1:RecordAudio("417101068", var_286_17)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_417101", "417101068", "story_v_out_417101.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_417101", "417101068", "story_v_out_417101.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_18 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_18 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_18

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_18 and arg_283_1.time_ < var_286_8 + var_286_18 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play417101069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417101069
		arg_287_1.duration_ = 9.23

		local var_287_0 = {
			zh = 6.966,
			ja = 9.233
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play417101070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10128"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10128 == nil then
				arg_287_1.var_.actorSpriteComps10128 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10128 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10128 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10128 = nil
			end

			local var_290_8 = arg_287_1.actors_["10128"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos10128 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10128", 3)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_6" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(0, -347, -300)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10128, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_290_15 = 0
			local var_290_16 = 0.85

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[595].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(417101069)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 34
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101069", "story_v_out_417101.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101069", "story_v_out_417101.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_417101", "417101069", "story_v_out_417101.awb")

						arg_287_1:RecordAudio("417101069", var_290_24)
						arg_287_1:RecordAudio("417101069", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_417101", "417101069", "story_v_out_417101.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_417101", "417101069", "story_v_out_417101.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play417101070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417101070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play417101071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10128"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10128 == nil then
				arg_291_1.var_.actorSpriteComps10128 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps10128 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 0.5, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10128 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10128 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.8

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(417101070)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_12 = 32
				local var_294_13 = utf8.len(var_294_11)
				local var_294_14 = var_294_12 <= 0 and var_294_9 or var_294_9 * (var_294_13 / var_294_12)

				if var_294_14 > 0 and var_294_9 < var_294_14 then
					arg_291_1.talkMaxDuration = var_294_14

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_15 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_15 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_15

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_15 and arg_291_1.time_ < var_294_8 + var_294_15 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play417101071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417101071
		arg_295_1.duration_ = 11.1

		local var_295_0 = {
			zh = 4.366,
			ja = 11.1
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
				arg_295_0:Play417101072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10128"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10128 == nil then
				arg_295_1.var_.actorSpriteComps10128 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10128 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 1, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10128 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10128 = nil
			end

			local var_298_8 = arg_295_1.actors_["10128"].transform
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.var_.moveOldPos10128 = var_298_8.localPosition
				var_298_8.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10128", 3)

				local var_298_10 = var_298_8.childCount

				for iter_298_4 = 0, var_298_10 - 1 do
					local var_298_11 = var_298_8:GetChild(iter_298_4)

					if var_298_11.name == "split_6" or not string.find(var_298_11.name, "split") then
						var_298_11.gameObject:SetActive(true)
					else
						var_298_11.gameObject:SetActive(false)
					end
				end
			end

			local var_298_12 = 0.001

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_12 then
				local var_298_13 = (arg_295_1.time_ - var_298_9) / var_298_12
				local var_298_14 = Vector3.New(0, -347, -300)

				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10128, var_298_14, var_298_13)
			end

			if arg_295_1.time_ >= var_298_9 + var_298_12 and arg_295_1.time_ < var_298_9 + var_298_12 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_298_15 = 0
			local var_298_16 = 0.575

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_17 = arg_295_1:FormatText(StoryNameCfg[595].name)

				arg_295_1.leftNameTxt_.text = var_298_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:GetWordFromCfg(417101071)
				local var_298_19 = arg_295_1:FormatText(var_298_18.content)

				arg_295_1.text_.text = var_298_19

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 23
				local var_298_21 = utf8.len(var_298_19)
				local var_298_22 = var_298_20 <= 0 and var_298_16 or var_298_16 * (var_298_21 / var_298_20)

				if var_298_22 > 0 and var_298_16 < var_298_22 then
					arg_295_1.talkMaxDuration = var_298_22

					if var_298_22 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_22 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_19
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101071", "story_v_out_417101.awb") ~= 0 then
					local var_298_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101071", "story_v_out_417101.awb") / 1000

					if var_298_23 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_15
					end

					if var_298_18.prefab_name ~= "" and arg_295_1.actors_[var_298_18.prefab_name] ~= nil then
						local var_298_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_18.prefab_name].transform, "story_v_out_417101", "417101071", "story_v_out_417101.awb")

						arg_295_1:RecordAudio("417101071", var_298_24)
						arg_295_1:RecordAudio("417101071", var_298_24)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417101", "417101071", "story_v_out_417101.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417101", "417101071", "story_v_out_417101.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_25 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_25 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_25

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_25 and arg_295_1.time_ < var_298_15 + var_298_25 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play417101072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 417101072
		arg_299_1.duration_ = 8.33

		local var_299_0 = {
			zh = 7.2,
			ja = 8.333
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play417101073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10128"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10128 == nil then
				arg_299_1.var_.actorSpriteComps10128 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps10128 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor2.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor2.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor2.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 0.5, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10128 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10128 = nil
			end

			local var_302_8 = 0
			local var_302_9 = 0.575

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_10 = arg_299_1:FormatText(StoryNameCfg[468].name)

				arg_299_1.leftNameTxt_.text = var_302_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_11 = arg_299_1:GetWordFromCfg(417101072)
				local var_302_12 = arg_299_1:FormatText(var_302_11.content)

				arg_299_1.text_.text = var_302_12

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 23
				local var_302_14 = utf8.len(var_302_12)
				local var_302_15 = var_302_13 <= 0 and var_302_9 or var_302_9 * (var_302_14 / var_302_13)

				if var_302_15 > 0 and var_302_9 < var_302_15 then
					arg_299_1.talkMaxDuration = var_302_15

					if var_302_15 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_15 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_12
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101072", "story_v_out_417101.awb") ~= 0 then
					local var_302_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101072", "story_v_out_417101.awb") / 1000

					if var_302_16 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_16 + var_302_8
					end

					if var_302_11.prefab_name ~= "" and arg_299_1.actors_[var_302_11.prefab_name] ~= nil then
						local var_302_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_11.prefab_name].transform, "story_v_out_417101", "417101072", "story_v_out_417101.awb")

						arg_299_1:RecordAudio("417101072", var_302_17)
						arg_299_1:RecordAudio("417101072", var_302_17)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_417101", "417101072", "story_v_out_417101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_417101", "417101072", "story_v_out_417101.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_18 = math.max(var_302_9, arg_299_1.talkMaxDuration)

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_18 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_8) / var_302_18

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_8 + var_302_18 and arg_299_1.time_ < var_302_8 + var_302_18 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play417101073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 417101073
		arg_303_1.duration_ = 7.8

		local var_303_0 = {
			zh = 4.7,
			ja = 7.8
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play417101074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10128"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10128 == nil then
				arg_303_1.var_.actorSpriteComps10128 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps10128 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 1, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10128 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10128 = nil
			end

			local var_306_8 = arg_303_1.actors_["10128"].transform
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.var_.moveOldPos10128 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10128", 3)

				local var_306_10 = var_306_8.childCount

				for iter_306_4 = 0, var_306_10 - 1 do
					local var_306_11 = var_306_8:GetChild(iter_306_4)

					if var_306_11.name == "" or not string.find(var_306_11.name, "split") then
						var_306_11.gameObject:SetActive(true)
					else
						var_306_11.gameObject:SetActive(false)
					end
				end
			end

			local var_306_12 = 0.001

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_9) / var_306_12
				local var_306_14 = Vector3.New(0, -347, -300)

				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10128, var_306_14, var_306_13)
			end

			if arg_303_1.time_ >= var_306_9 + var_306_12 and arg_303_1.time_ < var_306_9 + var_306_12 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_306_15 = 0
			local var_306_16 = 0.625

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[595].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(417101073)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 25
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101073", "story_v_out_417101.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101073", "story_v_out_417101.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_out_417101", "417101073", "story_v_out_417101.awb")

						arg_303_1:RecordAudio("417101073", var_306_24)
						arg_303_1:RecordAudio("417101073", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_417101", "417101073", "story_v_out_417101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_417101", "417101073", "story_v_out_417101.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play417101074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 417101074
		arg_307_1.duration_ = 10.73

		local var_307_0 = {
			zh = 7.166,
			ja = 10.733
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play417101075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10128"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10128 == nil then
				arg_307_1.var_.actorSpriteComps10128 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10128 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								local var_310_4 = Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor2.r, var_310_3)
								local var_310_5 = Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor2.g, var_310_3)
								local var_310_6 = Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor2.b, var_310_3)

								iter_310_1.color = Color.New(var_310_4, var_310_5, var_310_6)
							else
								local var_310_7 = Mathf.Lerp(iter_310_1.color.r, 0.5, var_310_3)

								iter_310_1.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10128 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10128 = nil
			end

			local var_310_8 = 0
			local var_310_9 = 0.625

			if var_310_8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_10 = arg_307_1:FormatText(StoryNameCfg[468].name)

				arg_307_1.leftNameTxt_.text = var_310_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_11 = arg_307_1:GetWordFromCfg(417101074)
				local var_310_12 = arg_307_1:FormatText(var_310_11.content)

				arg_307_1.text_.text = var_310_12

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 25
				local var_310_14 = utf8.len(var_310_12)
				local var_310_15 = var_310_13 <= 0 and var_310_9 or var_310_9 * (var_310_14 / var_310_13)

				if var_310_15 > 0 and var_310_9 < var_310_15 then
					arg_307_1.talkMaxDuration = var_310_15

					if var_310_15 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_15 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_12
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101074", "story_v_out_417101.awb") ~= 0 then
					local var_310_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101074", "story_v_out_417101.awb") / 1000

					if var_310_16 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_16 + var_310_8
					end

					if var_310_11.prefab_name ~= "" and arg_307_1.actors_[var_310_11.prefab_name] ~= nil then
						local var_310_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_11.prefab_name].transform, "story_v_out_417101", "417101074", "story_v_out_417101.awb")

						arg_307_1:RecordAudio("417101074", var_310_17)
						arg_307_1:RecordAudio("417101074", var_310_17)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_417101", "417101074", "story_v_out_417101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_417101", "417101074", "story_v_out_417101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_18 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_18 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_18

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_18 and arg_307_1.time_ < var_310_8 + var_310_18 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play417101075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 417101075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play417101076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.775

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(417101075)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 31
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play417101076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 417101076
		arg_315_1.duration_ = 3.7

		local var_315_0 = {
			zh = 3.7,
			ja = 2.8
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play417101077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.35

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[468].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:GetWordFromCfg(417101076)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 14
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101076", "story_v_out_417101.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101076", "story_v_out_417101.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_417101", "417101076", "story_v_out_417101.awb")

						arg_315_1:RecordAudio("417101076", var_318_9)
						arg_315_1:RecordAudio("417101076", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_417101", "417101076", "story_v_out_417101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_417101", "417101076", "story_v_out_417101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play417101077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 417101077
		arg_319_1.duration_ = 10.1

		local var_319_0 = {
			zh = 8.433,
			ja = 10.1
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play417101078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.775

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[468].name)

				arg_319_1.leftNameTxt_.text = var_322_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:GetWordFromCfg(417101077)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 31
				local var_322_6 = utf8.len(var_322_4)
				local var_322_7 = var_322_5 <= 0 and var_322_1 or var_322_1 * (var_322_6 / var_322_5)

				if var_322_7 > 0 and var_322_1 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101077", "story_v_out_417101.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101077", "story_v_out_417101.awb") / 1000

					if var_322_8 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_0
					end

					if var_322_3.prefab_name ~= "" and arg_319_1.actors_[var_322_3.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_3.prefab_name].transform, "story_v_out_417101", "417101077", "story_v_out_417101.awb")

						arg_319_1:RecordAudio("417101077", var_322_9)
						arg_319_1:RecordAudio("417101077", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_417101", "417101077", "story_v_out_417101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_417101", "417101077", "story_v_out_417101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_10 and arg_319_1.time_ < var_322_0 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play417101078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 417101078
		arg_323_1.duration_ = 1.63

		local var_323_0 = {
			zh = 0.999999999999,
			ja = 1.633
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play417101079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10128"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10128 == nil then
				arg_323_1.var_.actorSpriteComps10128 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10128 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 1, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10128 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10128 = nil
			end

			local var_326_8 = arg_323_1.actors_["10128"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos10128 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10128", 3)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "split_2" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -347, -300)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10128, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_326_15 = 0
			local var_326_16 = 0.1

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[595].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(417101078)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 4
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101078", "story_v_out_417101.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101078", "story_v_out_417101.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_out_417101", "417101078", "story_v_out_417101.awb")

						arg_323_1:RecordAudio("417101078", var_326_24)
						arg_323_1:RecordAudio("417101078", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_417101", "417101078", "story_v_out_417101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_417101", "417101078", "story_v_out_417101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play417101079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 417101079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play417101080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10128"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10128 == nil then
				arg_327_1.var_.actorSpriteComps10128 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10128 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 0.5, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10128 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10128 = nil
			end

			local var_330_8 = arg_327_1.actors_["10128"].transform
			local var_330_9 = 0

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.var_.moveOldPos10128 = var_330_8.localPosition
				var_330_8.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10128", 7)

				local var_330_10 = var_330_8.childCount

				for iter_330_4 = 0, var_330_10 - 1 do
					local var_330_11 = var_330_8:GetChild(iter_330_4)

					if var_330_11.name == "" or not string.find(var_330_11.name, "split") then
						var_330_11.gameObject:SetActive(true)
					else
						var_330_11.gameObject:SetActive(false)
					end
				end
			end

			local var_330_12 = 0.001

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_12 then
				local var_330_13 = (arg_327_1.time_ - var_330_9) / var_330_12
				local var_330_14 = Vector3.New(0, -2000, -300)

				var_330_8.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10128, var_330_14, var_330_13)
			end

			if arg_327_1.time_ >= var_330_9 + var_330_12 and arg_327_1.time_ < var_330_9 + var_330_12 + arg_330_0 then
				var_330_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_330_15 = 0
			local var_330_16 = 0.975

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_17 = arg_327_1:GetWordFromCfg(417101079)
				local var_330_18 = arg_327_1:FormatText(var_330_17.content)

				arg_327_1.text_.text = var_330_18

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_19 = 39
				local var_330_20 = utf8.len(var_330_18)
				local var_330_21 = var_330_19 <= 0 and var_330_16 or var_330_16 * (var_330_20 / var_330_19)

				if var_330_21 > 0 and var_330_16 < var_330_21 then
					arg_327_1.talkMaxDuration = var_330_21

					if var_330_21 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_21 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_18
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_22 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_22 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_22

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_22 and arg_327_1.time_ < var_330_15 + var_330_22 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play417101080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 417101080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play417101081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.75

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(417101080)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 30
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play417101081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 417101081
		arg_335_1.duration_ = 1.97

		local var_335_0 = {
			zh = 1.366,
			ja = 1.966
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play417101082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.125

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[468].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(417101081)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 5
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101081", "story_v_out_417101.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101081", "story_v_out_417101.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_417101", "417101081", "story_v_out_417101.awb")

						arg_335_1:RecordAudio("417101081", var_338_9)
						arg_335_1:RecordAudio("417101081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_417101", "417101081", "story_v_out_417101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_417101", "417101081", "story_v_out_417101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play417101082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 417101082
		arg_339_1.duration_ = 6.13

		local var_339_0 = {
			zh = 5.1,
			ja = 6.133
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play417101083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10113"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10113 == nil then
				arg_339_1.var_.actorSpriteComps10113 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps10113 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 1, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10113 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10113 = nil
			end

			local var_342_8 = arg_339_1.actors_["10113"].transform
			local var_342_9 = 0

			if var_342_9 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 then
				arg_339_1.var_.moveOldPos10113 = var_342_8.localPosition
				var_342_8.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10113", 3)

				local var_342_10 = var_342_8.childCount

				for iter_342_4 = 0, var_342_10 - 1 do
					local var_342_11 = var_342_8:GetChild(iter_342_4)

					if var_342_11.name == "split_6" or not string.find(var_342_11.name, "split") then
						var_342_11.gameObject:SetActive(true)
					else
						var_342_11.gameObject:SetActive(false)
					end
				end
			end

			local var_342_12 = 0.001

			if var_342_9 <= arg_339_1.time_ and arg_339_1.time_ < var_342_9 + var_342_12 then
				local var_342_13 = (arg_339_1.time_ - var_342_9) / var_342_12
				local var_342_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_342_8.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10113, var_342_14, var_342_13)
			end

			if arg_339_1.time_ >= var_342_9 + var_342_12 and arg_339_1.time_ < var_342_9 + var_342_12 + arg_342_0 then
				var_342_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_342_15 = 0
			local var_342_16 = 0.7

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[1117].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(417101082)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 28
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101082", "story_v_out_417101.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101082", "story_v_out_417101.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_417101", "417101082", "story_v_out_417101.awb")

						arg_339_1:RecordAudio("417101082", var_342_24)
						arg_339_1:RecordAudio("417101082", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_417101", "417101082", "story_v_out_417101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_417101", "417101082", "story_v_out_417101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play417101083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 417101083
		arg_343_1.duration_ = 2.9

		local var_343_0 = {
			zh = 2.9,
			ja = 2.133
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play417101084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10128"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10128 == nil then
				arg_343_1.var_.actorSpriteComps10128 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps10128 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10128 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10128 = nil
			end

			local var_346_8 = arg_343_1.actors_["10113"]
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10113 == nil then
				arg_343_1.var_.actorSpriteComps10113 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_10 = 0.2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 and not isNil(var_346_8) then
				local var_346_11 = (arg_343_1.time_ - var_346_9) / var_346_10

				if arg_343_1.var_.actorSpriteComps10113 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								local var_346_12 = Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor2.r, var_346_11)
								local var_346_13 = Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor2.g, var_346_11)
								local var_346_14 = Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor2.b, var_346_11)

								iter_346_5.color = Color.New(var_346_12, var_346_13, var_346_14)
							else
								local var_346_15 = Mathf.Lerp(iter_346_5.color.r, 0.5, var_346_11)

								iter_346_5.color = Color.New(var_346_15, var_346_15, var_346_15)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10113 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_346_7 then
						if arg_343_1.isInRecall_ then
							iter_346_7.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10113 = nil
			end

			local var_346_16 = arg_343_1.actors_["10128"].transform
			local var_346_17 = 0

			if var_346_17 < arg_343_1.time_ and arg_343_1.time_ <= var_346_17 + arg_346_0 then
				arg_343_1.var_.moveOldPos10128 = var_346_16.localPosition
				var_346_16.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10128", 4)

				local var_346_18 = var_346_16.childCount

				for iter_346_8 = 0, var_346_18 - 1 do
					local var_346_19 = var_346_16:GetChild(iter_346_8)

					if var_346_19.name == "" or not string.find(var_346_19.name, "split") then
						var_346_19.gameObject:SetActive(true)
					else
						var_346_19.gameObject:SetActive(false)
					end
				end
			end

			local var_346_20 = 0.001

			if var_346_17 <= arg_343_1.time_ and arg_343_1.time_ < var_346_17 + var_346_20 then
				local var_346_21 = (arg_343_1.time_ - var_346_17) / var_346_20
				local var_346_22 = Vector3.New(390, -347, -300)

				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10128, var_346_22, var_346_21)
			end

			if arg_343_1.time_ >= var_346_17 + var_346_20 and arg_343_1.time_ < var_346_17 + var_346_20 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_346_23 = arg_343_1.actors_["10113"].transform
			local var_346_24 = 0

			if var_346_24 < arg_343_1.time_ and arg_343_1.time_ <= var_346_24 + arg_346_0 then
				arg_343_1.var_.moveOldPos10113 = var_346_23.localPosition
				var_346_23.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10113", 2)

				local var_346_25 = var_346_23.childCount

				for iter_346_9 = 0, var_346_25 - 1 do
					local var_346_26 = var_346_23:GetChild(iter_346_9)

					if var_346_26.name == "split_6" or not string.find(var_346_26.name, "split") then
						var_346_26.gameObject:SetActive(true)
					else
						var_346_26.gameObject:SetActive(false)
					end
				end
			end

			local var_346_27 = 0.001

			if var_346_24 <= arg_343_1.time_ and arg_343_1.time_ < var_346_24 + var_346_27 then
				local var_346_28 = (arg_343_1.time_ - var_346_24) / var_346_27
				local var_346_29 = Vector3.New(-403.26, -328.4, -517.4)

				var_346_23.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10113, var_346_29, var_346_28)
			end

			if arg_343_1.time_ >= var_346_24 + var_346_27 and arg_343_1.time_ < var_346_24 + var_346_27 + arg_346_0 then
				var_346_23.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_346_30 = 0
			local var_346_31 = 0.325

			if var_346_30 < arg_343_1.time_ and arg_343_1.time_ <= var_346_30 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_32 = arg_343_1:FormatText(StoryNameCfg[595].name)

				arg_343_1.leftNameTxt_.text = var_346_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_33 = arg_343_1:GetWordFromCfg(417101083)
				local var_346_34 = arg_343_1:FormatText(var_346_33.content)

				arg_343_1.text_.text = var_346_34

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_35 = 13
				local var_346_36 = utf8.len(var_346_34)
				local var_346_37 = var_346_35 <= 0 and var_346_31 or var_346_31 * (var_346_36 / var_346_35)

				if var_346_37 > 0 and var_346_31 < var_346_37 then
					arg_343_1.talkMaxDuration = var_346_37

					if var_346_37 + var_346_30 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_37 + var_346_30
					end
				end

				arg_343_1.text_.text = var_346_34
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101083", "story_v_out_417101.awb") ~= 0 then
					local var_346_38 = manager.audio:GetVoiceLength("story_v_out_417101", "417101083", "story_v_out_417101.awb") / 1000

					if var_346_38 + var_346_30 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_38 + var_346_30
					end

					if var_346_33.prefab_name ~= "" and arg_343_1.actors_[var_346_33.prefab_name] ~= nil then
						local var_346_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_33.prefab_name].transform, "story_v_out_417101", "417101083", "story_v_out_417101.awb")

						arg_343_1:RecordAudio("417101083", var_346_39)
						arg_343_1:RecordAudio("417101083", var_346_39)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_417101", "417101083", "story_v_out_417101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_417101", "417101083", "story_v_out_417101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_40 = math.max(var_346_31, arg_343_1.talkMaxDuration)

			if var_346_30 <= arg_343_1.time_ and arg_343_1.time_ < var_346_30 + var_346_40 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_30) / var_346_40

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_30 + var_346_40 and arg_343_1.time_ < var_346_30 + var_346_40 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play417101084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 417101084
		arg_347_1.duration_ = 7.57

		local var_347_0 = {
			zh = 2.6,
			ja = 7.566
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play417101085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10113"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10113 == nil then
				arg_347_1.var_.actorSpriteComps10113 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10113 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 1, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10113 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10113 = nil
			end

			local var_350_8 = arg_347_1.actors_["10128"]
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10128 == nil then
				arg_347_1.var_.actorSpriteComps10128 = var_350_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_10 = 0.2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 and not isNil(var_350_8) then
				local var_350_11 = (arg_347_1.time_ - var_350_9) / var_350_10

				if arg_347_1.var_.actorSpriteComps10128 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								local var_350_12 = Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, var_350_11)
								local var_350_13 = Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, var_350_11)
								local var_350_14 = Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, var_350_11)

								iter_350_5.color = Color.New(var_350_12, var_350_13, var_350_14)
							else
								local var_350_15 = Mathf.Lerp(iter_350_5.color.r, 0.5, var_350_11)

								iter_350_5.color = Color.New(var_350_15, var_350_15, var_350_15)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10128 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_350_7 then
						if arg_347_1.isInRecall_ then
							iter_350_7.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10128 = nil
			end

			local var_350_16 = 0
			local var_350_17 = 0.275

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_18 = arg_347_1:FormatText(StoryNameCfg[1117].name)

				arg_347_1.leftNameTxt_.text = var_350_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_19 = arg_347_1:GetWordFromCfg(417101084)
				local var_350_20 = arg_347_1:FormatText(var_350_19.content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_21 = 11
				local var_350_22 = utf8.len(var_350_20)
				local var_350_23 = var_350_21 <= 0 and var_350_17 or var_350_17 * (var_350_22 / var_350_21)

				if var_350_23 > 0 and var_350_17 < var_350_23 then
					arg_347_1.talkMaxDuration = var_350_23

					if var_350_23 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_16
					end
				end

				arg_347_1.text_.text = var_350_20
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101084", "story_v_out_417101.awb") ~= 0 then
					local var_350_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101084", "story_v_out_417101.awb") / 1000

					if var_350_24 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_16
					end

					if var_350_19.prefab_name ~= "" and arg_347_1.actors_[var_350_19.prefab_name] ~= nil then
						local var_350_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_19.prefab_name].transform, "story_v_out_417101", "417101084", "story_v_out_417101.awb")

						arg_347_1:RecordAudio("417101084", var_350_25)
						arg_347_1:RecordAudio("417101084", var_350_25)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_417101", "417101084", "story_v_out_417101.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_417101", "417101084", "story_v_out_417101.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_26 = math.max(var_350_17, arg_347_1.talkMaxDuration)

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_26 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_16) / var_350_26

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_16 + var_350_26 and arg_347_1.time_ < var_350_16 + var_350_26 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play417101085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 417101085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play417101086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10113"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10113 == nil then
				arg_351_1.var_.actorSpriteComps10113 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10113 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 0.5, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10113 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10113 = nil
			end

			local var_354_8 = 0
			local var_354_9 = 0.675

			if var_354_8 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(417101085)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_12 = 27
				local var_354_13 = utf8.len(var_354_11)
				local var_354_14 = var_354_12 <= 0 and var_354_9 or var_354_9 * (var_354_13 / var_354_12)

				if var_354_14 > 0 and var_354_9 < var_354_14 then
					arg_351_1.talkMaxDuration = var_354_14

					if var_354_14 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_15 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_15 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_8) / var_354_15

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_8 + var_354_15 and arg_351_1.time_ < var_354_8 + var_354_15 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play417101086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 417101086
		arg_355_1.duration_ = 6.43

		local var_355_0 = {
			zh = 4.533,
			ja = 6.433
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play417101087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10113"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10113 == nil then
				arg_355_1.var_.actorSpriteComps10113 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps10113 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								local var_358_4 = Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor1.r, var_358_3)
								local var_358_5 = Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor1.g, var_358_3)
								local var_358_6 = Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor1.b, var_358_3)

								iter_358_1.color = Color.New(var_358_4, var_358_5, var_358_6)
							else
								local var_358_7 = Mathf.Lerp(iter_358_1.color.r, 1, var_358_3)

								iter_358_1.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10113 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_358_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10113 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.65

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_10 = arg_355_1:FormatText(StoryNameCfg[1117].name)

				arg_355_1.leftNameTxt_.text = var_358_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_11 = arg_355_1:GetWordFromCfg(417101086)
				local var_358_12 = arg_355_1:FormatText(var_358_11.content)

				arg_355_1.text_.text = var_358_12

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 26
				local var_358_14 = utf8.len(var_358_12)
				local var_358_15 = var_358_13 <= 0 and var_358_9 or var_358_9 * (var_358_14 / var_358_13)

				if var_358_15 > 0 and var_358_9 < var_358_15 then
					arg_355_1.talkMaxDuration = var_358_15

					if var_358_15 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_15 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_12
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101086", "story_v_out_417101.awb") ~= 0 then
					local var_358_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101086", "story_v_out_417101.awb") / 1000

					if var_358_16 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_16 + var_358_8
					end

					if var_358_11.prefab_name ~= "" and arg_355_1.actors_[var_358_11.prefab_name] ~= nil then
						local var_358_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_11.prefab_name].transform, "story_v_out_417101", "417101086", "story_v_out_417101.awb")

						arg_355_1:RecordAudio("417101086", var_358_17)
						arg_355_1:RecordAudio("417101086", var_358_17)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_417101", "417101086", "story_v_out_417101.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_417101", "417101086", "story_v_out_417101.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_18 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_18 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_18

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_18 and arg_355_1.time_ < var_358_8 + var_358_18 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play417101087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 417101087
		arg_359_1.duration_ = 5.43

		local var_359_0 = {
			zh = 3.533,
			ja = 5.433
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play417101088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.45

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[1117].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(417101087)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 18
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101087", "story_v_out_417101.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101087", "story_v_out_417101.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_417101", "417101087", "story_v_out_417101.awb")

						arg_359_1:RecordAudio("417101087", var_362_9)
						arg_359_1:RecordAudio("417101087", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_417101", "417101087", "story_v_out_417101.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_417101", "417101087", "story_v_out_417101.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play417101088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 417101088
		arg_363_1.duration_ = 4.47

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play417101089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = "STblack"

			if arg_363_1.bgs_[var_366_0] == nil then
				local var_366_1 = Object.Instantiate(arg_363_1.paintGo_)

				var_366_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_366_0)
				var_366_1.name = var_366_0
				var_366_1.transform.parent = arg_363_1.stage_.transform
				var_366_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.bgs_[var_366_0] = var_366_1
			end

			local var_366_2 = 2

			if var_366_2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				local var_366_3 = manager.ui.mainCamera.transform.localPosition
				local var_366_4 = Vector3.New(0, 0, 10) + Vector3.New(var_366_3.x, var_366_3.y, 0)
				local var_366_5 = arg_363_1.bgs_.STblack

				var_366_5.transform.localPosition = var_366_4
				var_366_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_366_6 = var_366_5:GetComponent("SpriteRenderer")

				if var_366_6 and var_366_6.sprite then
					local var_366_7 = (var_366_5.transform.localPosition - var_366_3).z
					local var_366_8 = manager.ui.mainCameraCom_
					local var_366_9 = 2 * var_366_7 * Mathf.Tan(var_366_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_366_10 = var_366_9 * var_366_8.aspect
					local var_366_11 = var_366_6.sprite.bounds.size.x
					local var_366_12 = var_366_6.sprite.bounds.size.y
					local var_366_13 = var_366_10 / var_366_11
					local var_366_14 = var_366_9 / var_366_12
					local var_366_15 = var_366_14 < var_366_13 and var_366_13 or var_366_14

					var_366_5.transform.localScale = Vector3.New(var_366_15, var_366_15, 0)
				end

				for iter_366_0, iter_366_1 in pairs(arg_363_1.bgs_) do
					if iter_366_0 ~= "STblack" then
						iter_366_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_366_16 = 0

			if var_366_16 < arg_363_1.time_ and arg_363_1.time_ <= var_366_16 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			local var_366_17 = 0.3

			if arg_363_1.time_ >= var_366_16 + var_366_17 and arg_363_1.time_ < var_366_16 + var_366_17 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end

			local var_366_18 = 0

			if var_366_18 < arg_363_1.time_ and arg_363_1.time_ <= var_366_18 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_19 = 2

			if var_366_18 <= arg_363_1.time_ and arg_363_1.time_ < var_366_18 + var_366_19 then
				local var_366_20 = (arg_363_1.time_ - var_366_18) / var_366_19
				local var_366_21 = Color.New(0, 0, 0)

				var_366_21.a = Mathf.Lerp(0, 1, var_366_20)
				arg_363_1.mask_.color = var_366_21
			end

			if arg_363_1.time_ >= var_366_18 + var_366_19 and arg_363_1.time_ < var_366_18 + var_366_19 + arg_366_0 then
				local var_366_22 = Color.New(0, 0, 0)

				var_366_22.a = 1
				arg_363_1.mask_.color = var_366_22
			end

			local var_366_23 = 2

			if var_366_23 < arg_363_1.time_ and arg_363_1.time_ <= var_366_23 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_24 = 2

			if var_366_23 <= arg_363_1.time_ and arg_363_1.time_ < var_366_23 + var_366_24 then
				local var_366_25 = (arg_363_1.time_ - var_366_23) / var_366_24
				local var_366_26 = Color.New(0, 0, 0)

				var_366_26.a = Mathf.Lerp(1, 0, var_366_25)
				arg_363_1.mask_.color = var_366_26
			end

			if arg_363_1.time_ >= var_366_23 + var_366_24 and arg_363_1.time_ < var_366_23 + var_366_24 + arg_366_0 then
				local var_366_27 = Color.New(0, 0, 0)
				local var_366_28 = 0

				arg_363_1.mask_.enabled = false
				var_366_27.a = var_366_28
				arg_363_1.mask_.color = var_366_27
			end

			local var_366_29 = arg_363_1.actors_["10128"].transform
			local var_366_30 = 1.966

			if var_366_30 < arg_363_1.time_ and arg_363_1.time_ <= var_366_30 + arg_366_0 then
				arg_363_1.var_.moveOldPos10128 = var_366_29.localPosition
				var_366_29.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10128", 7)

				local var_366_31 = var_366_29.childCount

				for iter_366_2 = 0, var_366_31 - 1 do
					local var_366_32 = var_366_29:GetChild(iter_366_2)

					if var_366_32.name == "" or not string.find(var_366_32.name, "split") then
						var_366_32.gameObject:SetActive(true)
					else
						var_366_32.gameObject:SetActive(false)
					end
				end
			end

			local var_366_33 = 0.001

			if var_366_30 <= arg_363_1.time_ and arg_363_1.time_ < var_366_30 + var_366_33 then
				local var_366_34 = (arg_363_1.time_ - var_366_30) / var_366_33
				local var_366_35 = Vector3.New(0, -2000, -300)

				var_366_29.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10128, var_366_35, var_366_34)
			end

			if arg_363_1.time_ >= var_366_30 + var_366_33 and arg_363_1.time_ < var_366_30 + var_366_33 + arg_366_0 then
				var_366_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_366_36 = 2

			if var_366_36 < arg_363_1.time_ and arg_363_1.time_ <= var_366_36 + arg_366_0 then
				local var_366_37 = arg_363_1.fswbg_.transform:Find("textbox/adapt/content") or arg_363_1.fswbg_.transform:Find("textbox/content")
				local var_366_38 = arg_363_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_366_39 = var_366_37:GetComponent("Text")
				local var_366_40 = var_366_37:GetComponent("RectTransform")

				var_366_39.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_366_40.offsetMin = Vector2.New(0, 0)
				var_366_40.offsetMax = Vector2.New(0, 0)
			end

			local var_366_41 = 2

			if var_366_41 < arg_363_1.time_ and arg_363_1.time_ <= var_366_41 + arg_366_0 then
				arg_363_1.fswbg_:SetActive(true)
				arg_363_1.dialog_:SetActive(false)

				arg_363_1.fswtw_.percent = 0

				local var_366_42 = arg_363_1:GetWordFromCfg(417101088)
				local var_366_43 = arg_363_1:FormatText(var_366_42.content)

				arg_363_1.fswt_.text = var_366_43

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.fswt_)

				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_363_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_363_1.fswtw_:SetDirty()

				arg_363_1.typewritterCharCountI18N = 0

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_44 = 2.8

			if var_366_44 < arg_363_1.time_ and arg_363_1.time_ <= var_366_44 + arg_366_0 then
				arg_363_1.var_.oldValueTypewriter = arg_363_1.fswtw_.percent

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_45 = 10
			local var_366_46 = 0.666666666666667
			local var_366_47 = arg_363_1:GetWordFromCfg(417101088)
			local var_366_48 = arg_363_1:FormatText(var_366_47.content)
			local var_366_49, var_366_50 = arg_363_1:GetPercentByPara(var_366_48, 1)

			if var_366_44 < arg_363_1.time_ and arg_363_1.time_ <= var_366_44 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				local var_366_51 = var_366_45 <= 0 and var_366_46 or var_366_46 * ((var_366_50 - arg_363_1.typewritterCharCountI18N) / var_366_45)

				if var_366_51 > 0 and var_366_46 < var_366_51 then
					arg_363_1.talkMaxDuration = var_366_51

					if var_366_51 + var_366_44 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_51 + var_366_44
					end
				end
			end

			local var_366_52 = 0.666666666666667
			local var_366_53 = math.max(var_366_52, arg_363_1.talkMaxDuration)

			if var_366_44 <= arg_363_1.time_ and arg_363_1.time_ < var_366_44 + var_366_53 then
				local var_366_54 = (arg_363_1.time_ - var_366_44) / var_366_53

				arg_363_1.fswtw_.percent = Mathf.Lerp(arg_363_1.var_.oldValueTypewriter, var_366_49, var_366_54)
				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_363_1.fswtw_:SetDirty()
			end

			if arg_363_1.time_ >= var_366_44 + var_366_53 and arg_363_1.time_ < var_366_44 + var_366_53 + arg_366_0 then
				arg_363_1.fswtw_.percent = var_366_49

				arg_363_1.fswtw_:SetDirty()
				arg_363_1:ShowNextGo(true)

				arg_363_1.typewritterCharCountI18N = var_366_50
			end

			local var_366_55 = arg_363_1.actors_["10113"].transform
			local var_366_56 = 1.966

			if var_366_56 < arg_363_1.time_ and arg_363_1.time_ <= var_366_56 + arg_366_0 then
				arg_363_1.var_.moveOldPos10113 = var_366_55.localPosition
				var_366_55.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10113", 7)

				local var_366_57 = var_366_55.childCount

				for iter_366_3 = 0, var_366_57 - 1 do
					local var_366_58 = var_366_55:GetChild(iter_366_3)

					if var_366_58.name == "split_6" or not string.find(var_366_58.name, "split") then
						var_366_58.gameObject:SetActive(true)
					else
						var_366_58.gameObject:SetActive(false)
					end
				end
			end

			local var_366_59 = 0.001

			if var_366_56 <= arg_363_1.time_ and arg_363_1.time_ < var_366_56 + var_366_59 then
				local var_366_60 = (arg_363_1.time_ - var_366_56) / var_366_59
				local var_366_61 = Vector3.New(0, -2000, 0)

				var_366_55.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10113, var_366_61, var_366_60)
			end

			if arg_363_1.time_ >= var_366_56 + var_366_59 and arg_363_1.time_ < var_366_56 + var_366_59 + arg_366_0 then
				var_366_55.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_366_62 = 0.466666666666667
			local var_366_63 = 0.2

			if var_366_62 < arg_363_1.time_ and arg_363_1.time_ <= var_366_62 + arg_366_0 then
				local var_366_64 = "play"
				local var_366_65 = "music"

				arg_363_1:AudioAction(var_366_64, var_366_65, "ui_battle", "ui_battle_stopbgm", "")

				local var_366_66 = ""
				local var_366_67 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_366_67 ~= "" then
					if arg_363_1.bgmTxt_.text ~= var_366_67 and arg_363_1.bgmTxt_.text ~= "" then
						if arg_363_1.bgmTxt2_.text ~= "" then
							arg_363_1.bgmTxt_.text = arg_363_1.bgmTxt2_.text
						end

						arg_363_1.bgmTxt2_.text = var_366_67

						arg_363_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_363_1.bgmTxt_.text = var_366_67
						arg_363_1.bgmTxt2_.text = var_366_67
					end

					if arg_363_1.bgmTimer then
						arg_363_1.bgmTimer:Stop()

						arg_363_1.bgmTimer = nil
					end

					if arg_363_1.settingData.show_music_name == 1 then
						arg_363_1.musicController:SetSelectedState("show")
						arg_363_1.musicAnimator_:Play("open", 0, 0)

						if arg_363_1.settingData.music_time ~= 0 then
							arg_363_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_363_1.settingData.music_time), function()
								if arg_363_1 == nil or isNil(arg_363_1.bgmTxt_) then
									return
								end

								arg_363_1.musicController:SetSelectedState("hide")
								arg_363_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_366_68 = 2.63333333333333
			local var_366_69 = 1.833
			local var_366_70 = manager.audio:GetVoiceLength("story_v_out_417101", "417101088", "0") / 1000

			if var_366_70 > 0 and var_366_69 < var_366_70 and var_366_70 + var_366_68 > arg_363_1.duration_ then
				local var_366_71 = var_366_70

				arg_363_1.duration_ = var_366_70 + var_366_68
			end

			if var_366_68 < arg_363_1.time_ and arg_363_1.time_ <= var_366_68 + arg_366_0 then
				local var_366_72 = "play"
				local var_366_73 = "voice"

				arg_363_1:AudioAction(var_366_72, var_366_73, "story_v_out_417101", "417101088", "0")
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play417101089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 417101089
		arg_368_1.duration_ = 4.1

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play417101090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.fswbg_:SetActive(true)
				arg_368_1.dialog_:SetActive(false)

				arg_368_1.fswtw_.percent = 0

				local var_371_1 = arg_368_1:GetWordFromCfg(417101089)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.fswt_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.fswt_)

				arg_368_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_368_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_368_1.fswtw_:SetDirty()

				arg_368_1.typewritterCharCountI18N = 0

				SetActive(arg_368_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_368_1:ShowNextGo(false)
			end

			local var_371_3 = 0.800000000000001

			if var_371_3 < arg_368_1.time_ and arg_368_1.time_ <= var_371_3 + arg_371_0 then
				arg_368_1.var_.oldValueTypewriter = arg_368_1.fswtw_.percent

				SetActive(arg_368_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_368_1:ShowNextGo(false)
			end

			local var_371_4 = 17
			local var_371_5 = 0.666666666666667
			local var_371_6 = arg_368_1:GetWordFromCfg(417101089)
			local var_371_7 = arg_368_1:FormatText(var_371_6.content)
			local var_371_8, var_371_9 = arg_368_1:GetPercentByPara(var_371_7, 1)

			if var_371_3 < arg_368_1.time_ and arg_368_1.time_ <= var_371_3 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				local var_371_10 = var_371_4 <= 0 and var_371_5 or var_371_5 * ((var_371_9 - arg_368_1.typewritterCharCountI18N) / var_371_4)

				if var_371_10 > 0 and var_371_5 < var_371_10 then
					arg_368_1.talkMaxDuration = var_371_10

					if var_371_10 + var_371_3 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_3
					end
				end
			end

			local var_371_11 = 0.666666666666667
			local var_371_12 = math.max(var_371_11, arg_368_1.talkMaxDuration)

			if var_371_3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_3 + var_371_12 then
				local var_371_13 = (arg_368_1.time_ - var_371_3) / var_371_12

				arg_368_1.fswtw_.percent = Mathf.Lerp(arg_368_1.var_.oldValueTypewriter, var_371_8, var_371_13)
				arg_368_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_368_1.fswtw_:SetDirty()
			end

			if arg_368_1.time_ >= var_371_3 + var_371_12 and arg_368_1.time_ < var_371_3 + var_371_12 + arg_371_0 then
				arg_368_1.fswtw_.percent = var_371_8

				arg_368_1.fswtw_:SetDirty()
				arg_368_1:ShowNextGo(true)

				arg_368_1.typewritterCharCountI18N = var_371_9
			end

			local var_371_14 = 0.800000000000001
			local var_371_15 = 3.3
			local var_371_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101089", "0") / 1000

			if var_371_16 > 0 and var_371_15 < var_371_16 and var_371_16 + var_371_14 > arg_368_1.duration_ then
				local var_371_17 = var_371_16

				arg_368_1.duration_ = var_371_16 + var_371_14
			end

			if var_371_14 < arg_368_1.time_ and arg_368_1.time_ <= var_371_14 + arg_371_0 then
				local var_371_18 = "play"
				local var_371_19 = "voice"

				arg_368_1:AudioAction(var_371_18, var_371_19, "story_v_out_417101", "417101089", "0")
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play417101090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 417101090
		arg_372_1.duration_ = 5.67

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play417101091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.fswbg_:SetActive(true)
				arg_372_1.dialog_:SetActive(false)

				arg_372_1.fswtw_.percent = 0

				local var_375_1 = arg_372_1:GetWordFromCfg(417101090)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.fswt_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.fswt_)

				arg_372_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_372_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_372_1.fswtw_:SetDirty()

				arg_372_1.typewritterCharCountI18N = 0

				SetActive(arg_372_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_372_1:ShowNextGo(false)
			end

			local var_375_3 = 0.6

			if var_375_3 < arg_372_1.time_ and arg_372_1.time_ <= var_375_3 + arg_375_0 then
				arg_372_1.var_.oldValueTypewriter = arg_372_1.fswtw_.percent

				SetActive(arg_372_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_372_1:ShowNextGo(false)
			end

			local var_375_4 = 29
			local var_375_5 = 1.93333333333333
			local var_375_6 = arg_372_1:GetWordFromCfg(417101090)
			local var_375_7 = arg_372_1:FormatText(var_375_6.content)
			local var_375_8, var_375_9 = arg_372_1:GetPercentByPara(var_375_7, 1)

			if var_375_3 < arg_372_1.time_ and arg_372_1.time_ <= var_375_3 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				local var_375_10 = var_375_4 <= 0 and var_375_5 or var_375_5 * ((var_375_9 - arg_372_1.typewritterCharCountI18N) / var_375_4)

				if var_375_10 > 0 and var_375_5 < var_375_10 then
					arg_372_1.talkMaxDuration = var_375_10

					if var_375_10 + var_375_3 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_3
					end
				end
			end

			local var_375_11 = 1.93333333333333
			local var_375_12 = math.max(var_375_11, arg_372_1.talkMaxDuration)

			if var_375_3 <= arg_372_1.time_ and arg_372_1.time_ < var_375_3 + var_375_12 then
				local var_375_13 = (arg_372_1.time_ - var_375_3) / var_375_12

				arg_372_1.fswtw_.percent = Mathf.Lerp(arg_372_1.var_.oldValueTypewriter, var_375_8, var_375_13)
				arg_372_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_372_1.fswtw_:SetDirty()
			end

			if arg_372_1.time_ >= var_375_3 + var_375_12 and arg_372_1.time_ < var_375_3 + var_375_12 + arg_375_0 then
				arg_372_1.fswtw_.percent = var_375_8

				arg_372_1.fswtw_:SetDirty()
				arg_372_1:ShowNextGo(true)

				arg_372_1.typewritterCharCountI18N = var_375_9
			end

			local var_375_14 = 0.466666666666667
			local var_375_15 = 5.2
			local var_375_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101090", "0") / 1000

			if var_375_16 > 0 and var_375_15 < var_375_16 and var_375_16 + var_375_14 > arg_372_1.duration_ then
				local var_375_17 = var_375_16

				arg_372_1.duration_ = var_375_16 + var_375_14
			end

			if var_375_14 < arg_372_1.time_ and arg_372_1.time_ <= var_375_14 + arg_375_0 then
				local var_375_18 = "play"
				local var_375_19 = "voice"

				arg_372_1:AudioAction(var_375_18, var_375_19, "story_v_out_417101", "417101090", "0")
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play417101091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 417101091
		arg_376_1.duration_ = 5.8

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play417101092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.fswbg_:SetActive(true)
				arg_376_1.dialog_:SetActive(false)

				arg_376_1.fswtw_.percent = 0

				local var_379_1 = arg_376_1:GetWordFromCfg(417101091)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.fswt_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.fswt_)

				arg_376_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_376_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_376_1.fswtw_:SetDirty()

				arg_376_1.typewritterCharCountI18N = 0

				SetActive(arg_376_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_376_1:ShowNextGo(false)
			end

			local var_379_3 = 0.566666666666667

			if var_379_3 < arg_376_1.time_ and arg_376_1.time_ <= var_379_3 + arg_379_0 then
				arg_376_1.var_.oldValueTypewriter = arg_376_1.fswtw_.percent

				SetActive(arg_376_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_376_1:ShowNextGo(false)
			end

			local var_379_4 = 18
			local var_379_5 = 1.2
			local var_379_6 = arg_376_1:GetWordFromCfg(417101091)
			local var_379_7 = arg_376_1:FormatText(var_379_6.content)
			local var_379_8, var_379_9 = arg_376_1:GetPercentByPara(var_379_7, 1)

			if var_379_3 < arg_376_1.time_ and arg_376_1.time_ <= var_379_3 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0

				local var_379_10 = var_379_4 <= 0 and var_379_5 or var_379_5 * ((var_379_9 - arg_376_1.typewritterCharCountI18N) / var_379_4)

				if var_379_10 > 0 and var_379_5 < var_379_10 then
					arg_376_1.talkMaxDuration = var_379_10

					if var_379_10 + var_379_3 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_3
					end
				end
			end

			local var_379_11 = 1.2
			local var_379_12 = math.max(var_379_11, arg_376_1.talkMaxDuration)

			if var_379_3 <= arg_376_1.time_ and arg_376_1.time_ < var_379_3 + var_379_12 then
				local var_379_13 = (arg_376_1.time_ - var_379_3) / var_379_12

				arg_376_1.fswtw_.percent = Mathf.Lerp(arg_376_1.var_.oldValueTypewriter, var_379_8, var_379_13)
				arg_376_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_376_1.fswtw_:SetDirty()
			end

			if arg_376_1.time_ >= var_379_3 + var_379_12 and arg_376_1.time_ < var_379_3 + var_379_12 + arg_379_0 then
				arg_376_1.fswtw_.percent = var_379_8

				arg_376_1.fswtw_:SetDirty()
				arg_376_1:ShowNextGo(true)

				arg_376_1.typewritterCharCountI18N = var_379_9
			end

			local var_379_14 = 0.566666666666667
			local var_379_15 = 5.233
			local var_379_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101091", "0") / 1000

			if var_379_16 > 0 and var_379_15 < var_379_16 and var_379_16 + var_379_14 > arg_376_1.duration_ then
				local var_379_17 = var_379_16

				arg_376_1.duration_ = var_379_16 + var_379_14
			end

			if var_379_14 < arg_376_1.time_ and arg_376_1.time_ <= var_379_14 + arg_379_0 then
				local var_379_18 = "play"
				local var_379_19 = "voice"

				arg_376_1:AudioAction(var_379_18, var_379_19, "story_v_out_417101", "417101091", "0")
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play417101092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417101092
		arg_380_1.duration_ = 8.73

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play417101093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.fswbg_:SetActive(true)
				arg_380_1.dialog_:SetActive(false)

				arg_380_1.fswtw_.percent = 0

				local var_383_1 = arg_380_1:GetWordFromCfg(417101092)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.fswt_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.fswt_)

				arg_380_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_380_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_380_1.fswtw_:SetDirty()

				arg_380_1.typewritterCharCountI18N = 0

				SetActive(arg_380_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_380_1:ShowNextGo(false)
			end

			local var_383_3 = 0.800000000000001

			if var_383_3 < arg_380_1.time_ and arg_380_1.time_ <= var_383_3 + arg_383_0 then
				arg_380_1.var_.oldValueTypewriter = arg_380_1.fswtw_.percent

				SetActive(arg_380_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_380_1:ShowNextGo(false)
			end

			local var_383_4 = 43
			local var_383_5 = 2.86666666666667
			local var_383_6 = arg_380_1:GetWordFromCfg(417101092)
			local var_383_7 = arg_380_1:FormatText(var_383_6.content)
			local var_383_8, var_383_9 = arg_380_1:GetPercentByPara(var_383_7, 1)

			if var_383_3 < arg_380_1.time_ and arg_380_1.time_ <= var_383_3 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				local var_383_10 = var_383_4 <= 0 and var_383_5 or var_383_5 * ((var_383_9 - arg_380_1.typewritterCharCountI18N) / var_383_4)

				if var_383_10 > 0 and var_383_5 < var_383_10 then
					arg_380_1.talkMaxDuration = var_383_10

					if var_383_10 + var_383_3 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_3
					end
				end
			end

			local var_383_11 = 2.86666666666667
			local var_383_12 = math.max(var_383_11, arg_380_1.talkMaxDuration)

			if var_383_3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_3 + var_383_12 then
				local var_383_13 = (arg_380_1.time_ - var_383_3) / var_383_12

				arg_380_1.fswtw_.percent = Mathf.Lerp(arg_380_1.var_.oldValueTypewriter, var_383_8, var_383_13)
				arg_380_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_380_1.fswtw_:SetDirty()
			end

			if arg_380_1.time_ >= var_383_3 + var_383_12 and arg_380_1.time_ < var_383_3 + var_383_12 + arg_383_0 then
				arg_380_1.fswtw_.percent = var_383_8

				arg_380_1.fswtw_:SetDirty()
				arg_380_1:ShowNextGo(true)

				arg_380_1.typewritterCharCountI18N = var_383_9
			end

			local var_383_14 = 0.633333333333333
			local var_383_15 = 8.1
			local var_383_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101092", "0") / 1000

			if var_383_16 > 0 and var_383_15 < var_383_16 and var_383_16 + var_383_14 > arg_380_1.duration_ then
				local var_383_17 = var_383_16

				arg_380_1.duration_ = var_383_16 + var_383_14
			end

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				local var_383_18 = "play"
				local var_383_19 = "voice"

				arg_380_1:AudioAction(var_383_18, var_383_19, "story_v_out_417101", "417101092", "0")
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play417101093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417101093
		arg_384_1.duration_ = 7.6

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417101094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.fswbg_:SetActive(true)
				arg_384_1.dialog_:SetActive(false)

				arg_384_1.fswtw_.percent = 0

				local var_387_1 = arg_384_1:GetWordFromCfg(417101093)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.fswt_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.fswt_)

				arg_384_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_384_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_384_1.fswtw_:SetDirty()

				arg_384_1.typewritterCharCountI18N = 0

				SetActive(arg_384_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_384_1:ShowNextGo(false)
			end

			local var_387_3 = 0.566666666666667

			if var_387_3 < arg_384_1.time_ and arg_384_1.time_ <= var_387_3 + arg_387_0 then
				arg_384_1.var_.oldValueTypewriter = arg_384_1.fswtw_.percent

				SetActive(arg_384_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_384_1:ShowNextGo(false)
			end

			local var_387_4 = 37
			local var_387_5 = 2.46666666666667
			local var_387_6 = arg_384_1:GetWordFromCfg(417101093)
			local var_387_7 = arg_384_1:FormatText(var_387_6.content)
			local var_387_8, var_387_9 = arg_384_1:GetPercentByPara(var_387_7, 1)

			if var_387_3 < arg_384_1.time_ and arg_384_1.time_ <= var_387_3 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0

				local var_387_10 = var_387_4 <= 0 and var_387_5 or var_387_5 * ((var_387_9 - arg_384_1.typewritterCharCountI18N) / var_387_4)

				if var_387_10 > 0 and var_387_5 < var_387_10 then
					arg_384_1.talkMaxDuration = var_387_10

					if var_387_10 + var_387_3 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_3
					end
				end
			end

			local var_387_11 = 2.46666666666667
			local var_387_12 = math.max(var_387_11, arg_384_1.talkMaxDuration)

			if var_387_3 <= arg_384_1.time_ and arg_384_1.time_ < var_387_3 + var_387_12 then
				local var_387_13 = (arg_384_1.time_ - var_387_3) / var_387_12

				arg_384_1.fswtw_.percent = Mathf.Lerp(arg_384_1.var_.oldValueTypewriter, var_387_8, var_387_13)
				arg_384_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_384_1.fswtw_:SetDirty()
			end

			if arg_384_1.time_ >= var_387_3 + var_387_12 and arg_384_1.time_ < var_387_3 + var_387_12 + arg_387_0 then
				arg_384_1.fswtw_.percent = var_387_8

				arg_384_1.fswtw_:SetDirty()
				arg_384_1:ShowNextGo(true)

				arg_384_1.typewritterCharCountI18N = var_387_9
			end

			local var_387_14 = 0.566666666666667
			local var_387_15 = 7.033
			local var_387_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101093", "0") / 1000

			if var_387_16 > 0 and var_387_15 < var_387_16 and var_387_16 + var_387_14 > arg_384_1.duration_ then
				local var_387_17 = var_387_16

				arg_384_1.duration_ = var_387_16 + var_387_14
			end

			if var_387_14 < arg_384_1.time_ and arg_384_1.time_ <= var_387_14 + arg_387_0 then
				local var_387_18 = "play"
				local var_387_19 = "voice"

				arg_384_1:AudioAction(var_387_18, var_387_19, "story_v_out_417101", "417101093", "0")
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play417101094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417101094
		arg_388_1.duration_ = 5.7

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play417101095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.fswbg_:SetActive(true)
				arg_388_1.dialog_:SetActive(false)

				arg_388_1.fswtw_.percent = 0

				local var_391_1 = arg_388_1:GetWordFromCfg(417101094)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.fswt_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.fswt_)

				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_388_1.fswtw_:SetDirty()

				arg_388_1.typewritterCharCountI18N = 0

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_3 = 0.800000000000001

			if var_391_3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.var_.oldValueTypewriter = arg_388_1.fswtw_.percent

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_4 = 16
			local var_391_5 = 1.06666666666667
			local var_391_6 = arg_388_1:GetWordFromCfg(417101094)
			local var_391_7 = arg_388_1:FormatText(var_391_6.content)
			local var_391_8, var_391_9 = arg_388_1:GetPercentByPara(var_391_7, 1)

			if var_391_3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				local var_391_10 = var_391_4 <= 0 and var_391_5 or var_391_5 * ((var_391_9 - arg_388_1.typewritterCharCountI18N) / var_391_4)

				if var_391_10 > 0 and var_391_5 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_3 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_3
					end
				end
			end

			local var_391_11 = 1.06666666666667
			local var_391_12 = math.max(var_391_11, arg_388_1.talkMaxDuration)

			if var_391_3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_3 + var_391_12 then
				local var_391_13 = (arg_388_1.time_ - var_391_3) / var_391_12

				arg_388_1.fswtw_.percent = Mathf.Lerp(arg_388_1.var_.oldValueTypewriter, var_391_8, var_391_13)
				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.fswtw_:SetDirty()
			end

			if arg_388_1.time_ >= var_391_3 + var_391_12 and arg_388_1.time_ < var_391_3 + var_391_12 + arg_391_0 then
				arg_388_1.fswtw_.percent = var_391_8

				arg_388_1.fswtw_:SetDirty()
				arg_388_1:ShowNextGo(true)

				arg_388_1.typewritterCharCountI18N = var_391_9
			end

			local var_391_14 = 0.800000000000001
			local var_391_15 = 4.9
			local var_391_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101094", "0") / 1000

			if var_391_16 > 0 and var_391_15 < var_391_16 and var_391_16 + var_391_14 > arg_388_1.duration_ then
				local var_391_17 = var_391_16

				arg_388_1.duration_ = var_391_16 + var_391_14
			end

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				local var_391_18 = "play"
				local var_391_19 = "voice"

				arg_388_1:AudioAction(var_391_18, var_391_19, "story_v_out_417101", "417101094", "0")
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play417101095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 417101095
		arg_392_1.duration_ = 9.7

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play417101096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.fswbg_:SetActive(true)
				arg_392_1.dialog_:SetActive(false)

				arg_392_1.fswtw_.percent = 0

				local var_395_1 = arg_392_1:GetWordFromCfg(417101095)
				local var_395_2 = arg_392_1:FormatText(var_395_1.content)

				arg_392_1.fswt_.text = var_395_2

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.fswt_)

				arg_392_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_392_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_392_1.fswtw_:SetDirty()

				arg_392_1.typewritterCharCountI18N = 0

				SetActive(arg_392_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_392_1:ShowNextGo(false)
			end

			local var_395_3 = 0.633333333333333

			if var_395_3 < arg_392_1.time_ and arg_392_1.time_ <= var_395_3 + arg_395_0 then
				arg_392_1.var_.oldValueTypewriter = arg_392_1.fswtw_.percent

				SetActive(arg_392_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_392_1:ShowNextGo(false)
			end

			local var_395_4 = 44
			local var_395_5 = 2.93333333333333
			local var_395_6 = arg_392_1:GetWordFromCfg(417101095)
			local var_395_7 = arg_392_1:FormatText(var_395_6.content)
			local var_395_8, var_395_9 = arg_392_1:GetPercentByPara(var_395_7, 1)

			if var_395_3 < arg_392_1.time_ and arg_392_1.time_ <= var_395_3 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0

				local var_395_10 = var_395_4 <= 0 and var_395_5 or var_395_5 * ((var_395_9 - arg_392_1.typewritterCharCountI18N) / var_395_4)

				if var_395_10 > 0 and var_395_5 < var_395_10 then
					arg_392_1.talkMaxDuration = var_395_10

					if var_395_10 + var_395_3 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_3
					end
				end
			end

			local var_395_11 = 2.93333333333333
			local var_395_12 = math.max(var_395_11, arg_392_1.talkMaxDuration)

			if var_395_3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_3 + var_395_12 then
				local var_395_13 = (arg_392_1.time_ - var_395_3) / var_395_12

				arg_392_1.fswtw_.percent = Mathf.Lerp(arg_392_1.var_.oldValueTypewriter, var_395_8, var_395_13)
				arg_392_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_392_1.fswtw_:SetDirty()
			end

			if arg_392_1.time_ >= var_395_3 + var_395_12 and arg_392_1.time_ < var_395_3 + var_395_12 + arg_395_0 then
				arg_392_1.fswtw_.percent = var_395_8

				arg_392_1.fswtw_:SetDirty()
				arg_392_1:ShowNextGo(true)

				arg_392_1.typewritterCharCountI18N = var_395_9
			end

			local var_395_14 = 0.633333333333333
			local var_395_15 = 9.066
			local var_395_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101095", "0") / 1000

			if var_395_16 > 0 and var_395_15 < var_395_16 and var_395_16 + var_395_14 > arg_392_1.duration_ then
				local var_395_17 = var_395_16

				arg_392_1.duration_ = var_395_16 + var_395_14
			end

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				local var_395_18 = "play"
				local var_395_19 = "voice"

				arg_392_1:AudioAction(var_395_18, var_395_19, "story_v_out_417101", "417101095", "0")
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play417101096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 417101096
		arg_396_1.duration_ = 11.23

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play417101097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.fswbg_:SetActive(true)
				arg_396_1.dialog_:SetActive(false)

				arg_396_1.fswtw_.percent = 0

				local var_399_1 = arg_396_1:GetWordFromCfg(417101096)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.fswt_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.fswt_)

				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_396_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_396_1.fswtw_:SetDirty()

				arg_396_1.typewritterCharCountI18N = 0

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_3 = 0.800000000000001

			if var_399_3 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.var_.oldValueTypewriter = arg_396_1.fswtw_.percent

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_4 = 48
			local var_399_5 = 3.2
			local var_399_6 = arg_396_1:GetWordFromCfg(417101096)
			local var_399_7 = arg_396_1:FormatText(var_399_6.content)
			local var_399_8, var_399_9 = arg_396_1:GetPercentByPara(var_399_7, 1)

			if var_399_3 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0

				local var_399_10 = var_399_4 <= 0 and var_399_5 or var_399_5 * ((var_399_9 - arg_396_1.typewritterCharCountI18N) / var_399_4)

				if var_399_10 > 0 and var_399_5 < var_399_10 then
					arg_396_1.talkMaxDuration = var_399_10

					if var_399_10 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_10 + var_399_3
					end
				end
			end

			local var_399_11 = 3.2
			local var_399_12 = math.max(var_399_11, arg_396_1.talkMaxDuration)

			if var_399_3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_3 + var_399_12 then
				local var_399_13 = (arg_396_1.time_ - var_399_3) / var_399_12

				arg_396_1.fswtw_.percent = Mathf.Lerp(arg_396_1.var_.oldValueTypewriter, var_399_8, var_399_13)
				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_396_1.fswtw_:SetDirty()
			end

			if arg_396_1.time_ >= var_399_3 + var_399_12 and arg_396_1.time_ < var_399_3 + var_399_12 + arg_399_0 then
				arg_396_1.fswtw_.percent = var_399_8

				arg_396_1.fswtw_:SetDirty()
				arg_396_1:ShowNextGo(true)

				arg_396_1.typewritterCharCountI18N = var_399_9
			end

			local var_399_14 = 0.800000000000001
			local var_399_15 = 10.433
			local var_399_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101096", "0") / 1000

			if var_399_16 > 0 and var_399_15 < var_399_16 and var_399_16 + var_399_14 > arg_396_1.duration_ then
				local var_399_17 = var_399_16

				arg_396_1.duration_ = var_399_16 + var_399_14
			end

			if var_399_14 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 then
				local var_399_18 = "play"
				local var_399_19 = "voice"

				arg_396_1:AudioAction(var_399_18, var_399_19, "story_v_out_417101", "417101096", "0")
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play417101097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 417101097
		arg_400_1.duration_ = 12.77

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play417101098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				local var_403_1 = arg_400_1.fswbg_.transform:Find("textbox/adapt/content") or arg_400_1.fswbg_.transform:Find("textbox/content")
				local var_403_2 = arg_400_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_403_3 = var_403_1:GetComponent("Text")
				local var_403_4 = var_403_1:GetComponent("RectTransform")

				var_403_3.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_403_4.offsetMin = Vector2.New(0, 0)
				var_403_4.offsetMax = Vector2.New(0, 0)
			end

			local var_403_5 = 0.5
			local var_403_6 = 12.266
			local var_403_7 = manager.audio:GetVoiceLength("story_v_out_417101", "417101097", "0") / 1000

			if var_403_7 > 0 and var_403_6 < var_403_7 and var_403_7 + var_403_5 > arg_400_1.duration_ then
				local var_403_8 = var_403_7

				arg_400_1.duration_ = var_403_7 + var_403_5
			end

			if var_403_5 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				local var_403_9 = "play"
				local var_403_10 = "voice"

				arg_400_1:AudioAction(var_403_9, var_403_10, "story_v_out_417101", "417101097", "0")
			end

			local var_403_11 = 0

			if var_403_11 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 then
				arg_400_1.fswbg_:SetActive(true)
				arg_400_1.dialog_:SetActive(false)

				arg_400_1.fswtw_.percent = 0

				local var_403_12 = arg_400_1:GetWordFromCfg(417101097)
				local var_403_13 = arg_400_1:FormatText(var_403_12.content)

				arg_400_1.fswt_.text = var_403_13

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.fswt_)

				arg_400_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_400_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_400_1.fswtw_:SetDirty()

				arg_400_1.typewritterCharCountI18N = 0

				SetActive(arg_400_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_400_1:ShowNextGo(false)
			end

			local var_403_14 = 0.5

			if var_403_14 < arg_400_1.time_ and arg_400_1.time_ <= var_403_14 + arg_403_0 then
				arg_400_1.var_.oldValueTypewriter = arg_400_1.fswtw_.percent

				SetActive(arg_400_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_400_1:ShowNextGo(false)
			end

			local var_403_15 = 56
			local var_403_16 = 3.73333333333333
			local var_403_17 = arg_400_1:GetWordFromCfg(417101097)
			local var_403_18 = arg_400_1:FormatText(var_403_17.content)
			local var_403_19, var_403_20 = arg_400_1:GetPercentByPara(var_403_18, 1)

			if var_403_14 < arg_400_1.time_ and arg_400_1.time_ <= var_403_14 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				local var_403_21 = var_403_15 <= 0 and var_403_16 or var_403_16 * ((var_403_20 - arg_400_1.typewritterCharCountI18N) / var_403_15)

				if var_403_21 > 0 and var_403_16 < var_403_21 then
					arg_400_1.talkMaxDuration = var_403_21

					if var_403_21 + var_403_14 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_21 + var_403_14
					end
				end
			end

			local var_403_22 = 3.73333333333333
			local var_403_23 = math.max(var_403_22, arg_400_1.talkMaxDuration)

			if var_403_14 <= arg_400_1.time_ and arg_400_1.time_ < var_403_14 + var_403_23 then
				local var_403_24 = (arg_400_1.time_ - var_403_14) / var_403_23

				arg_400_1.fswtw_.percent = Mathf.Lerp(arg_400_1.var_.oldValueTypewriter, var_403_19, var_403_24)
				arg_400_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_400_1.fswtw_:SetDirty()
			end

			if arg_400_1.time_ >= var_403_14 + var_403_23 and arg_400_1.time_ < var_403_14 + var_403_23 + arg_403_0 then
				arg_400_1.fswtw_.percent = var_403_19

				arg_400_1.fswtw_:SetDirty()
				arg_400_1:ShowNextGo(true)

				arg_400_1.typewritterCharCountI18N = var_403_20
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play417101098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 417101098
		arg_404_1.duration_ = 7.8

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play417101099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.fswbg_:SetActive(true)
				arg_404_1.dialog_:SetActive(false)

				arg_404_1.fswtw_.percent = 0

				local var_407_1 = arg_404_1:GetWordFromCfg(417101098)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.fswt_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.fswt_)

				arg_404_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_404_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_404_1.fswtw_:SetDirty()

				arg_404_1.typewritterCharCountI18N = 0

				SetActive(arg_404_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_404_1:ShowNextGo(false)
			end

			local var_407_3 = 0.266666666666668

			if var_407_3 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.var_.oldValueTypewriter = arg_404_1.fswtw_.percent

				SetActive(arg_404_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_404_1:ShowNextGo(false)
			end

			local var_407_4 = 29
			local var_407_5 = 1.13333333333333
			local var_407_6 = arg_404_1:GetWordFromCfg(417101098)
			local var_407_7 = arg_404_1:FormatText(var_407_6.content)
			local var_407_8, var_407_9 = arg_404_1:GetPercentByPara(var_407_7, 1)

			if var_407_3 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0

				local var_407_10 = var_407_4 <= 0 and var_407_5 or var_407_5 * ((var_407_9 - arg_404_1.typewritterCharCountI18N) / var_407_4)

				if var_407_10 > 0 and var_407_5 < var_407_10 then
					arg_404_1.talkMaxDuration = var_407_10

					if var_407_10 + var_407_3 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_3
					end
				end
			end

			local var_407_11 = 1.13333333333333
			local var_407_12 = math.max(var_407_11, arg_404_1.talkMaxDuration)

			if var_407_3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_3 + var_407_12 then
				local var_407_13 = (arg_404_1.time_ - var_407_3) / var_407_12

				arg_404_1.fswtw_.percent = Mathf.Lerp(arg_404_1.var_.oldValueTypewriter, var_407_8, var_407_13)
				arg_404_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_404_1.fswtw_:SetDirty()
			end

			if arg_404_1.time_ >= var_407_3 + var_407_12 and arg_404_1.time_ < var_407_3 + var_407_12 + arg_407_0 then
				arg_404_1.fswtw_.percent = var_407_8

				arg_404_1.fswtw_:SetDirty()
				arg_404_1:ShowNextGo(true)

				arg_404_1.typewritterCharCountI18N = var_407_9
			end

			local var_407_14 = 0.166666666666667
			local var_407_15 = 7.633
			local var_407_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101098", "0") / 1000

			if var_407_16 > 0 and var_407_15 < var_407_16 and var_407_16 + var_407_14 > arg_404_1.duration_ then
				local var_407_17 = var_407_16

				arg_404_1.duration_ = var_407_16 + var_407_14
			end

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				local var_407_18 = "play"
				local var_407_19 = "voice"

				arg_404_1:AudioAction(var_407_18, var_407_19, "story_v_out_417101", "417101098", "0")
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play417101099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 417101099
		arg_408_1.duration_ = 11.2

		local var_408_0 = {
			zh = 11.2,
			ja = 10.666
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play417101100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = "ST2106"

			if arg_408_1.bgs_[var_411_0] == nil then
				local var_411_1 = Object.Instantiate(arg_408_1.paintGo_)

				var_411_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_411_0)
				var_411_1.name = var_411_0
				var_411_1.transform.parent = arg_408_1.stage_.transform
				var_411_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_408_1.bgs_[var_411_0] = var_411_1
			end

			local var_411_2 = 1.4

			if var_411_2 < arg_408_1.time_ and arg_408_1.time_ <= var_411_2 + arg_411_0 then
				local var_411_3 = manager.ui.mainCamera.transform.localPosition
				local var_411_4 = Vector3.New(0, 0, 10) + Vector3.New(var_411_3.x, var_411_3.y, 0)
				local var_411_5 = arg_408_1.bgs_.ST2106

				var_411_5.transform.localPosition = var_411_4
				var_411_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_6 = var_411_5:GetComponent("SpriteRenderer")

				if var_411_6 and var_411_6.sprite then
					local var_411_7 = (var_411_5.transform.localPosition - var_411_3).z
					local var_411_8 = manager.ui.mainCameraCom_
					local var_411_9 = 2 * var_411_7 * Mathf.Tan(var_411_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_411_10 = var_411_9 * var_411_8.aspect
					local var_411_11 = var_411_6.sprite.bounds.size.x
					local var_411_12 = var_411_6.sprite.bounds.size.y
					local var_411_13 = var_411_10 / var_411_11
					local var_411_14 = var_411_9 / var_411_12
					local var_411_15 = var_411_14 < var_411_13 and var_411_13 or var_411_14

					var_411_5.transform.localScale = Vector3.New(var_411_15, var_411_15, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "ST2106" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_16 = 1.4

			if var_411_16 < arg_408_1.time_ and arg_408_1.time_ <= var_411_16 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			local var_411_17 = 0.3

			if arg_408_1.time_ >= var_411_16 + var_411_17 and arg_408_1.time_ < var_411_16 + var_411_17 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_18 = 0

			if var_411_18 < arg_408_1.time_ and arg_408_1.time_ <= var_411_18 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_19 = 1.4

			if var_411_18 <= arg_408_1.time_ and arg_408_1.time_ < var_411_18 + var_411_19 then
				local var_411_20 = (arg_408_1.time_ - var_411_18) / var_411_19
				local var_411_21 = Color.New(0, 0, 0)

				var_411_21.a = Mathf.Lerp(0, 1, var_411_20)
				arg_408_1.mask_.color = var_411_21
			end

			if arg_408_1.time_ >= var_411_18 + var_411_19 and arg_408_1.time_ < var_411_18 + var_411_19 + arg_411_0 then
				local var_411_22 = Color.New(0, 0, 0)

				var_411_22.a = 1
				arg_408_1.mask_.color = var_411_22
			end

			local var_411_23 = 1.4

			if var_411_23 < arg_408_1.time_ and arg_408_1.time_ <= var_411_23 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_24 = 2

			if var_411_23 <= arg_408_1.time_ and arg_408_1.time_ < var_411_23 + var_411_24 then
				local var_411_25 = (arg_408_1.time_ - var_411_23) / var_411_24
				local var_411_26 = Color.New(0, 0, 0)

				var_411_26.a = Mathf.Lerp(1, 0, var_411_25)
				arg_408_1.mask_.color = var_411_26
			end

			if arg_408_1.time_ >= var_411_23 + var_411_24 and arg_408_1.time_ < var_411_23 + var_411_24 + arg_411_0 then
				local var_411_27 = Color.New(0, 0, 0)
				local var_411_28 = 0

				arg_408_1.mask_.enabled = false
				var_411_27.a = var_411_28
				arg_408_1.mask_.color = var_411_27
			end

			local var_411_29 = arg_408_1.actors_["10128"]
			local var_411_30 = 3.2

			if var_411_30 < arg_408_1.time_ and arg_408_1.time_ <= var_411_30 + arg_411_0 and not isNil(var_411_29) and arg_408_1.var_.actorSpriteComps10128 == nil then
				arg_408_1.var_.actorSpriteComps10128 = var_411_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_31 = 0.2

			if var_411_30 <= arg_408_1.time_ and arg_408_1.time_ < var_411_30 + var_411_31 and not isNil(var_411_29) then
				local var_411_32 = (arg_408_1.time_ - var_411_30) / var_411_31

				if arg_408_1.var_.actorSpriteComps10128 then
					for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_411_3 then
							if arg_408_1.isInRecall_ then
								local var_411_33 = Mathf.Lerp(iter_411_3.color.r, arg_408_1.hightColor1.r, var_411_32)
								local var_411_34 = Mathf.Lerp(iter_411_3.color.g, arg_408_1.hightColor1.g, var_411_32)
								local var_411_35 = Mathf.Lerp(iter_411_3.color.b, arg_408_1.hightColor1.b, var_411_32)

								iter_411_3.color = Color.New(var_411_33, var_411_34, var_411_35)
							else
								local var_411_36 = Mathf.Lerp(iter_411_3.color.r, 1, var_411_32)

								iter_411_3.color = Color.New(var_411_36, var_411_36, var_411_36)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= var_411_30 + var_411_31 and arg_408_1.time_ < var_411_30 + var_411_31 + arg_411_0 and not isNil(var_411_29) and arg_408_1.var_.actorSpriteComps10128 then
				for iter_411_4, iter_411_5 in pairs(arg_408_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_411_5 then
						if arg_408_1.isInRecall_ then
							iter_411_5.color = arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_411_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_408_1.var_.actorSpriteComps10128 = nil
			end

			local var_411_37 = arg_408_1.actors_["10128"].transform
			local var_411_38 = 3.2

			if var_411_38 < arg_408_1.time_ and arg_408_1.time_ <= var_411_38 + arg_411_0 then
				arg_408_1.var_.moveOldPos10128 = var_411_37.localPosition
				var_411_37.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10128", 3)

				local var_411_39 = var_411_37.childCount

				for iter_411_6 = 0, var_411_39 - 1 do
					local var_411_40 = var_411_37:GetChild(iter_411_6)

					if var_411_40.name == "split_6" or not string.find(var_411_40.name, "split") then
						var_411_40.gameObject:SetActive(true)
					else
						var_411_40.gameObject:SetActive(false)
					end
				end
			end

			local var_411_41 = 0.001

			if var_411_38 <= arg_408_1.time_ and arg_408_1.time_ < var_411_38 + var_411_41 then
				local var_411_42 = (arg_408_1.time_ - var_411_38) / var_411_41
				local var_411_43 = Vector3.New(0, -347, -300)

				var_411_37.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10128, var_411_43, var_411_42)
			end

			if arg_408_1.time_ >= var_411_38 + var_411_41 and arg_408_1.time_ < var_411_38 + var_411_41 + arg_411_0 then
				var_411_37.localPosition = Vector3.New(0, -347, -300)
			end

			local var_411_44 = arg_408_1.actors_["10128"]
			local var_411_45 = 3.199999999999

			if var_411_45 < arg_408_1.time_ and arg_408_1.time_ <= var_411_45 + arg_411_0 then
				local var_411_46 = var_411_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_411_46 then
					arg_408_1.var_.alphaOldValue10128 = var_411_46.alpha
					arg_408_1.var_.characterEffect10128 = var_411_46
				end

				arg_408_1.var_.alphaOldValue10128 = 0
			end

			local var_411_47 = 0.200000000001

			if var_411_45 <= arg_408_1.time_ and arg_408_1.time_ < var_411_45 + var_411_47 then
				local var_411_48 = (arg_408_1.time_ - var_411_45) / var_411_47
				local var_411_49 = Mathf.Lerp(arg_408_1.var_.alphaOldValue10128, 1, var_411_48)

				if arg_408_1.var_.characterEffect10128 then
					arg_408_1.var_.characterEffect10128.alpha = var_411_49
				end
			end

			if arg_408_1.time_ >= var_411_45 + var_411_47 and arg_408_1.time_ < var_411_45 + var_411_47 + arg_411_0 and arg_408_1.var_.characterEffect10128 then
				arg_408_1.var_.characterEffect10128.alpha = 1
			end

			local var_411_50 = 1.4

			if var_411_50 < arg_408_1.time_ and arg_408_1.time_ <= var_411_50 + arg_411_0 then
				arg_408_1.fswbg_:SetActive(false)
				arg_408_1.dialog_:SetActive(false)
				SetActive(arg_408_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_408_1:ShowNextGo(false)
			end

			local var_411_51 = 1.434

			if var_411_51 < arg_408_1.time_ and arg_408_1.time_ <= var_411_51 + arg_411_0 then
				arg_408_1.fswbg_:SetActive(false)
				arg_408_1.dialog_:SetActive(false)
				SetActive(arg_408_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_408_1:ShowNextGo(false)
			end

			local var_411_52 = 0
			local var_411_53 = 0.2

			if var_411_52 < arg_408_1.time_ and arg_408_1.time_ <= var_411_52 + arg_411_0 then
				local var_411_54 = "play"
				local var_411_55 = "music"

				arg_408_1:AudioAction(var_411_54, var_411_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_411_56 = ""
				local var_411_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_411_57 ~= "" then
					if arg_408_1.bgmTxt_.text ~= var_411_57 and arg_408_1.bgmTxt_.text ~= "" then
						if arg_408_1.bgmTxt2_.text ~= "" then
							arg_408_1.bgmTxt_.text = arg_408_1.bgmTxt2_.text
						end

						arg_408_1.bgmTxt2_.text = var_411_57

						arg_408_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_408_1.bgmTxt_.text = var_411_57
						arg_408_1.bgmTxt2_.text = var_411_57
					end

					if arg_408_1.bgmTimer then
						arg_408_1.bgmTimer:Stop()

						arg_408_1.bgmTimer = nil
					end

					if arg_408_1.settingData.show_music_name == 1 then
						arg_408_1.musicController:SetSelectedState("show")
						arg_408_1.musicAnimator_:Play("open", 0, 0)

						if arg_408_1.settingData.music_time ~= 0 then
							arg_408_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_408_1.settingData.music_time), function()
								if arg_408_1 == nil or isNil(arg_408_1.bgmTxt_) then
									return
								end

								arg_408_1.musicController:SetSelectedState("hide")
								arg_408_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_411_58 = 1.13333333333333
			local var_411_59 = 1

			if var_411_58 < arg_408_1.time_ and arg_408_1.time_ <= var_411_58 + arg_411_0 then
				local var_411_60 = "play"
				local var_411_61 = "music"

				arg_408_1:AudioAction(var_411_60, var_411_61, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_411_62 = ""
				local var_411_63 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_411_63 ~= "" then
					if arg_408_1.bgmTxt_.text ~= var_411_63 and arg_408_1.bgmTxt_.text ~= "" then
						if arg_408_1.bgmTxt2_.text ~= "" then
							arg_408_1.bgmTxt_.text = arg_408_1.bgmTxt2_.text
						end

						arg_408_1.bgmTxt2_.text = var_411_63

						arg_408_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_408_1.bgmTxt_.text = var_411_63
						arg_408_1.bgmTxt2_.text = var_411_63
					end

					if arg_408_1.bgmTimer then
						arg_408_1.bgmTimer:Stop()

						arg_408_1.bgmTimer = nil
					end

					if arg_408_1.settingData.show_music_name == 1 then
						arg_408_1.musicController:SetSelectedState("show")
						arg_408_1.musicAnimator_:Play("open", 0, 0)

						if arg_408_1.settingData.music_time ~= 0 then
							arg_408_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_408_1.settingData.music_time), function()
								if arg_408_1 == nil or isNil(arg_408_1.bgmTxt_) then
									return
								end

								arg_408_1.musicController:SetSelectedState("hide")
								arg_408_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_64 = 3.4
			local var_411_65 = 1.125

			if var_411_64 < arg_408_1.time_ and arg_408_1.time_ <= var_411_64 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_66 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_66:setOnUpdate(LuaHelper.FloatAction(function(arg_414_0)
					arg_408_1.dialogCg_.alpha = arg_414_0
				end))
				var_411_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_67 = arg_408_1:FormatText(StoryNameCfg[595].name)

				arg_408_1.leftNameTxt_.text = var_411_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_68 = arg_408_1:GetWordFromCfg(417101099)
				local var_411_69 = arg_408_1:FormatText(var_411_68.content)

				arg_408_1.text_.text = var_411_69

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_70 = 45
				local var_411_71 = utf8.len(var_411_69)
				local var_411_72 = var_411_70 <= 0 and var_411_65 or var_411_65 * (var_411_71 / var_411_70)

				if var_411_72 > 0 and var_411_65 < var_411_72 then
					arg_408_1.talkMaxDuration = var_411_72
					var_411_64 = var_411_64 + 0.3

					if var_411_72 + var_411_64 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_72 + var_411_64
					end
				end

				arg_408_1.text_.text = var_411_69
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101099", "story_v_out_417101.awb") ~= 0 then
					local var_411_73 = manager.audio:GetVoiceLength("story_v_out_417101", "417101099", "story_v_out_417101.awb") / 1000

					if var_411_73 + var_411_64 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_73 + var_411_64
					end

					if var_411_68.prefab_name ~= "" and arg_408_1.actors_[var_411_68.prefab_name] ~= nil then
						local var_411_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_68.prefab_name].transform, "story_v_out_417101", "417101099", "story_v_out_417101.awb")

						arg_408_1:RecordAudio("417101099", var_411_74)
						arg_408_1:RecordAudio("417101099", var_411_74)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_417101", "417101099", "story_v_out_417101.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_417101", "417101099", "story_v_out_417101.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_75 = var_411_64 + 0.3
			local var_411_76 = math.max(var_411_65, arg_408_1.talkMaxDuration)

			if var_411_75 <= arg_408_1.time_ and arg_408_1.time_ < var_411_75 + var_411_76 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_75) / var_411_76

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_75 + var_411_76 and arg_408_1.time_ < var_411_75 + var_411_76 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play417101100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 417101100
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play417101101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10128"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10128 == nil then
				arg_416_1.var_.actorSpriteComps10128 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps10128 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10128 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10128 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 1.425

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_10 = arg_416_1:GetWordFromCfg(417101100)
				local var_419_11 = arg_416_1:FormatText(var_419_10.content)

				arg_416_1.text_.text = var_419_11

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_12 = 57
				local var_419_13 = utf8.len(var_419_11)
				local var_419_14 = var_419_12 <= 0 and var_419_9 or var_419_9 * (var_419_13 / var_419_12)

				if var_419_14 > 0 and var_419_9 < var_419_14 then
					arg_416_1.talkMaxDuration = var_419_14

					if var_419_14 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_11
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_15 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_15 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_15

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_15 and arg_416_1.time_ < var_419_8 + var_419_15 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play417101101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 417101101
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play417101102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.7
			local var_423_1 = 1

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				local var_423_2 = "play"
				local var_423_3 = "effect"

				arg_420_1:AudioAction(var_423_2, var_423_3, "se_story_3", "se_story_3_wrongpassword", "")
			end

			local var_423_4 = 0
			local var_423_5 = 0.8

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_6 = arg_420_1:GetWordFromCfg(417101101)
				local var_423_7 = arg_420_1:FormatText(var_423_6.content)

				arg_420_1.text_.text = var_423_7

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_8 = 32
				local var_423_9 = utf8.len(var_423_7)
				local var_423_10 = var_423_8 <= 0 and var_423_5 or var_423_5 * (var_423_9 / var_423_8)

				if var_423_10 > 0 and var_423_5 < var_423_10 then
					arg_420_1.talkMaxDuration = var_423_10

					if var_423_10 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_4
					end
				end

				arg_420_1.text_.text = var_423_7
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_11 = math.max(var_423_5, arg_420_1.talkMaxDuration)

			if var_423_4 <= arg_420_1.time_ and arg_420_1.time_ < var_423_4 + var_423_11 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_4) / var_423_11

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_4 + var_423_11 and arg_420_1.time_ < var_423_4 + var_423_11 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play417101102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 417101102
		arg_424_1.duration_ = 8.83

		local var_424_0 = {
			zh = 4.233,
			ja = 8.833
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play417101103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.525

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_2 = arg_424_1:FormatText(StoryNameCfg[1112].name)

				arg_424_1.leftNameTxt_.text = var_427_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:GetWordFromCfg(417101102)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101102", "story_v_out_417101.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101102", "story_v_out_417101.awb") / 1000

					if var_427_8 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_0
					end

					if var_427_3.prefab_name ~= "" and arg_424_1.actors_[var_427_3.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_3.prefab_name].transform, "story_v_out_417101", "417101102", "story_v_out_417101.awb")

						arg_424_1:RecordAudio("417101102", var_427_9)
						arg_424_1:RecordAudio("417101102", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_417101", "417101102", "story_v_out_417101.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_417101", "417101102", "story_v_out_417101.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_10 and arg_424_1.time_ < var_427_0 + var_427_10 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play417101103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 417101103
		arg_428_1.duration_ = 6.47

		local var_428_0 = {
			zh = 6.466,
			ja = 4.033
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play417101104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10128"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps10128 == nil then
				arg_428_1.var_.actorSpriteComps10128 = var_431_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.actorSpriteComps10128 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								local var_431_4 = Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor1.r, var_431_3)
								local var_431_5 = Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor1.g, var_431_3)
								local var_431_6 = Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor1.b, var_431_3)

								iter_431_1.color = Color.New(var_431_4, var_431_5, var_431_6)
							else
								local var_431_7 = Mathf.Lerp(iter_431_1.color.r, 1, var_431_3)

								iter_431_1.color = Color.New(var_431_7, var_431_7, var_431_7)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps10128 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_431_3 then
						if arg_428_1.isInRecall_ then
							iter_431_3.color = arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_431_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps10128 = nil
			end

			local var_431_8 = arg_428_1.actors_["10128"].transform
			local var_431_9 = 0

			if var_431_9 < arg_428_1.time_ and arg_428_1.time_ <= var_431_9 + arg_431_0 then
				arg_428_1.var_.moveOldPos10128 = var_431_8.localPosition
				var_431_8.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10128", 3)

				local var_431_10 = var_431_8.childCount

				for iter_431_4 = 0, var_431_10 - 1 do
					local var_431_11 = var_431_8:GetChild(iter_431_4)

					if var_431_11.name == "split_5" or not string.find(var_431_11.name, "split") then
						var_431_11.gameObject:SetActive(true)
					else
						var_431_11.gameObject:SetActive(false)
					end
				end
			end

			local var_431_12 = 0.001

			if var_431_9 <= arg_428_1.time_ and arg_428_1.time_ < var_431_9 + var_431_12 then
				local var_431_13 = (arg_428_1.time_ - var_431_9) / var_431_12
				local var_431_14 = Vector3.New(0, -347, -300)

				var_431_8.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10128, var_431_14, var_431_13)
			end

			if arg_428_1.time_ >= var_431_9 + var_431_12 and arg_428_1.time_ < var_431_9 + var_431_12 + arg_431_0 then
				var_431_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_431_15 = 0
			local var_431_16 = 0.7

			if var_431_15 < arg_428_1.time_ and arg_428_1.time_ <= var_431_15 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_17 = arg_428_1:FormatText(StoryNameCfg[595].name)

				arg_428_1.leftNameTxt_.text = var_431_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_18 = arg_428_1:GetWordFromCfg(417101103)
				local var_431_19 = arg_428_1:FormatText(var_431_18.content)

				arg_428_1.text_.text = var_431_19

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_20 = 28
				local var_431_21 = utf8.len(var_431_19)
				local var_431_22 = var_431_20 <= 0 and var_431_16 or var_431_16 * (var_431_21 / var_431_20)

				if var_431_22 > 0 and var_431_16 < var_431_22 then
					arg_428_1.talkMaxDuration = var_431_22

					if var_431_22 + var_431_15 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_22 + var_431_15
					end
				end

				arg_428_1.text_.text = var_431_19
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101103", "story_v_out_417101.awb") ~= 0 then
					local var_431_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101103", "story_v_out_417101.awb") / 1000

					if var_431_23 + var_431_15 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_23 + var_431_15
					end

					if var_431_18.prefab_name ~= "" and arg_428_1.actors_[var_431_18.prefab_name] ~= nil then
						local var_431_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_18.prefab_name].transform, "story_v_out_417101", "417101103", "story_v_out_417101.awb")

						arg_428_1:RecordAudio("417101103", var_431_24)
						arg_428_1:RecordAudio("417101103", var_431_24)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_417101", "417101103", "story_v_out_417101.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_417101", "417101103", "story_v_out_417101.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_25 = math.max(var_431_16, arg_428_1.talkMaxDuration)

			if var_431_15 <= arg_428_1.time_ and arg_428_1.time_ < var_431_15 + var_431_25 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_15) / var_431_25

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_15 + var_431_25 and arg_428_1.time_ < var_431_15 + var_431_25 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play417101104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 417101104
		arg_432_1.duration_ = 11.17

		local var_432_0 = {
			zh = 10,
			ja = 11.166
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
				arg_432_0:Play417101105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["10128"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps10128 == nil then
				arg_432_1.var_.actorSpriteComps10128 = var_435_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_2 = 0.2

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.actorSpriteComps10128 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								local var_435_4 = Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor2.r, var_435_3)
								local var_435_5 = Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor2.g, var_435_3)
								local var_435_6 = Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor2.b, var_435_3)

								iter_435_1.color = Color.New(var_435_4, var_435_5, var_435_6)
							else
								local var_435_7 = Mathf.Lerp(iter_435_1.color.r, 0.5, var_435_3)

								iter_435_1.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps10128 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_435_3 then
						if arg_432_1.isInRecall_ then
							iter_435_3.color = arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_435_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps10128 = nil
			end

			local var_435_8 = 0
			local var_435_9 = 1.2

			if var_435_8 < arg_432_1.time_ and arg_432_1.time_ <= var_435_8 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_10 = arg_432_1:FormatText(StoryNameCfg[1112].name)

				arg_432_1.leftNameTxt_.text = var_435_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_11 = arg_432_1:GetWordFromCfg(417101104)
				local var_435_12 = arg_432_1:FormatText(var_435_11.content)

				arg_432_1.text_.text = var_435_12

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_13 = 48
				local var_435_14 = utf8.len(var_435_12)
				local var_435_15 = var_435_13 <= 0 and var_435_9 or var_435_9 * (var_435_14 / var_435_13)

				if var_435_15 > 0 and var_435_9 < var_435_15 then
					arg_432_1.talkMaxDuration = var_435_15

					if var_435_15 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_15 + var_435_8
					end
				end

				arg_432_1.text_.text = var_435_12
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101104", "story_v_out_417101.awb") ~= 0 then
					local var_435_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101104", "story_v_out_417101.awb") / 1000

					if var_435_16 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_16 + var_435_8
					end

					if var_435_11.prefab_name ~= "" and arg_432_1.actors_[var_435_11.prefab_name] ~= nil then
						local var_435_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_11.prefab_name].transform, "story_v_out_417101", "417101104", "story_v_out_417101.awb")

						arg_432_1:RecordAudio("417101104", var_435_17)
						arg_432_1:RecordAudio("417101104", var_435_17)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_417101", "417101104", "story_v_out_417101.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_417101", "417101104", "story_v_out_417101.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_18 = math.max(var_435_9, arg_432_1.talkMaxDuration)

			if var_435_8 <= arg_432_1.time_ and arg_432_1.time_ < var_435_8 + var_435_18 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_8) / var_435_18

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_8 + var_435_18 and arg_432_1.time_ < var_435_8 + var_435_18 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play417101105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 417101105
		arg_436_1.duration_ = 3.23

		local var_436_0 = {
			zh = 1,
			ja = 3.233
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play417101106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10128"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10128 == nil then
				arg_436_1.var_.actorSpriteComps10128 = var_439_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.actorSpriteComps10128 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								local var_439_4 = Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, var_439_3)
								local var_439_5 = Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, var_439_3)
								local var_439_6 = Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, var_439_3)

								iter_439_1.color = Color.New(var_439_4, var_439_5, var_439_6)
							else
								local var_439_7 = Mathf.Lerp(iter_439_1.color.r, 1, var_439_3)

								iter_439_1.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10128 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_439_3 then
						if arg_436_1.isInRecall_ then
							iter_439_3.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_439_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps10128 = nil
			end

			local var_439_8 = arg_436_1.actors_["10128"].transform
			local var_439_9 = 0

			if var_439_9 < arg_436_1.time_ and arg_436_1.time_ <= var_439_9 + arg_439_0 then
				arg_436_1.var_.moveOldPos10128 = var_439_8.localPosition
				var_439_8.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10128", 3)

				local var_439_10 = var_439_8.childCount

				for iter_439_4 = 0, var_439_10 - 1 do
					local var_439_11 = var_439_8:GetChild(iter_439_4)

					if var_439_11.name == "split_6" or not string.find(var_439_11.name, "split") then
						var_439_11.gameObject:SetActive(true)
					else
						var_439_11.gameObject:SetActive(false)
					end
				end
			end

			local var_439_12 = 0.001

			if var_439_9 <= arg_436_1.time_ and arg_436_1.time_ < var_439_9 + var_439_12 then
				local var_439_13 = (arg_436_1.time_ - var_439_9) / var_439_12
				local var_439_14 = Vector3.New(0, -347, -300)

				var_439_8.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10128, var_439_14, var_439_13)
			end

			if arg_436_1.time_ >= var_439_9 + var_439_12 and arg_436_1.time_ < var_439_9 + var_439_12 + arg_439_0 then
				var_439_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_439_15 = 0
			local var_439_16 = 0.125

			if var_439_15 < arg_436_1.time_ and arg_436_1.time_ <= var_439_15 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_17 = arg_436_1:FormatText(StoryNameCfg[595].name)

				arg_436_1.leftNameTxt_.text = var_439_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_18 = arg_436_1:GetWordFromCfg(417101105)
				local var_439_19 = arg_436_1:FormatText(var_439_18.content)

				arg_436_1.text_.text = var_439_19

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_20 = 5
				local var_439_21 = utf8.len(var_439_19)
				local var_439_22 = var_439_20 <= 0 and var_439_16 or var_439_16 * (var_439_21 / var_439_20)

				if var_439_22 > 0 and var_439_16 < var_439_22 then
					arg_436_1.talkMaxDuration = var_439_22

					if var_439_22 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_22 + var_439_15
					end
				end

				arg_436_1.text_.text = var_439_19
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101105", "story_v_out_417101.awb") ~= 0 then
					local var_439_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101105", "story_v_out_417101.awb") / 1000

					if var_439_23 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_23 + var_439_15
					end

					if var_439_18.prefab_name ~= "" and arg_436_1.actors_[var_439_18.prefab_name] ~= nil then
						local var_439_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_18.prefab_name].transform, "story_v_out_417101", "417101105", "story_v_out_417101.awb")

						arg_436_1:RecordAudio("417101105", var_439_24)
						arg_436_1:RecordAudio("417101105", var_439_24)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_417101", "417101105", "story_v_out_417101.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_417101", "417101105", "story_v_out_417101.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_25 = math.max(var_439_16, arg_436_1.talkMaxDuration)

			if var_439_15 <= arg_436_1.time_ and arg_436_1.time_ < var_439_15 + var_439_25 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_15) / var_439_25

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_15 + var_439_25 and arg_436_1.time_ < var_439_15 + var_439_25 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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

		arg_436_1:InitPlayNodeList()
	end,
	Play417101106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 417101106
		arg_440_1.duration_ = 5.57

		local var_440_0 = {
			zh = 2.833,
			ja = 5.566
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play417101107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10128"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10128 == nil then
				arg_440_1.var_.actorSpriteComps10128 = var_443_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_2 = 0.2

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.actorSpriteComps10128 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								local var_443_4 = Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor2.r, var_443_3)
								local var_443_5 = Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor2.g, var_443_3)
								local var_443_6 = Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor2.b, var_443_3)

								iter_443_1.color = Color.New(var_443_4, var_443_5, var_443_6)
							else
								local var_443_7 = Mathf.Lerp(iter_443_1.color.r, 0.5, var_443_3)

								iter_443_1.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10128 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_443_3 then
						if arg_440_1.isInRecall_ then
							iter_443_3.color = arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_443_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10128 = nil
			end

			local var_443_8 = 0
			local var_443_9 = 0.2

			if var_443_8 < arg_440_1.time_ and arg_440_1.time_ <= var_443_8 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_10 = arg_440_1:FormatText(StoryNameCfg[1112].name)

				arg_440_1.leftNameTxt_.text = var_443_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_11 = arg_440_1:GetWordFromCfg(417101106)
				local var_443_12 = arg_440_1:FormatText(var_443_11.content)

				arg_440_1.text_.text = var_443_12

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_13 = 8
				local var_443_14 = utf8.len(var_443_12)
				local var_443_15 = var_443_13 <= 0 and var_443_9 or var_443_9 * (var_443_14 / var_443_13)

				if var_443_15 > 0 and var_443_9 < var_443_15 then
					arg_440_1.talkMaxDuration = var_443_15

					if var_443_15 + var_443_8 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_15 + var_443_8
					end
				end

				arg_440_1.text_.text = var_443_12
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101106", "story_v_out_417101.awb") ~= 0 then
					local var_443_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101106", "story_v_out_417101.awb") / 1000

					if var_443_16 + var_443_8 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_16 + var_443_8
					end

					if var_443_11.prefab_name ~= "" and arg_440_1.actors_[var_443_11.prefab_name] ~= nil then
						local var_443_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_11.prefab_name].transform, "story_v_out_417101", "417101106", "story_v_out_417101.awb")

						arg_440_1:RecordAudio("417101106", var_443_17)
						arg_440_1:RecordAudio("417101106", var_443_17)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_417101", "417101106", "story_v_out_417101.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_417101", "417101106", "story_v_out_417101.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_18 = math.max(var_443_9, arg_440_1.talkMaxDuration)

			if var_443_8 <= arg_440_1.time_ and arg_440_1.time_ < var_443_8 + var_443_18 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_8) / var_443_18

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_8 + var_443_18 and arg_440_1.time_ < var_443_8 + var_443_18 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play417101107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 417101107
		arg_444_1.duration_ = 2.57

		local var_444_0 = {
			zh = 2.4,
			ja = 2.566
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
				arg_444_0:Play417101108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10128"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps10128 == nil then
				arg_444_1.var_.actorSpriteComps10128 = var_447_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.actorSpriteComps10128 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps10128 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_447_3 then
						if arg_444_1.isInRecall_ then
							iter_447_3.color = arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_447_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10128 = nil
			end

			local var_447_8 = 0
			local var_447_9 = 0.15

			if var_447_8 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_10 = arg_444_1:FormatText(StoryNameCfg[595].name)

				arg_444_1.leftNameTxt_.text = var_447_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_11 = arg_444_1:GetWordFromCfg(417101107)
				local var_447_12 = arg_444_1:FormatText(var_447_11.content)

				arg_444_1.text_.text = var_447_12

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_13 = 6
				local var_447_14 = utf8.len(var_447_12)
				local var_447_15 = var_447_13 <= 0 and var_447_9 or var_447_9 * (var_447_14 / var_447_13)

				if var_447_15 > 0 and var_447_9 < var_447_15 then
					arg_444_1.talkMaxDuration = var_447_15

					if var_447_15 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_15 + var_447_8
					end
				end

				arg_444_1.text_.text = var_447_12
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101107", "story_v_out_417101.awb") ~= 0 then
					local var_447_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101107", "story_v_out_417101.awb") / 1000

					if var_447_16 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_16 + var_447_8
					end

					if var_447_11.prefab_name ~= "" and arg_444_1.actors_[var_447_11.prefab_name] ~= nil then
						local var_447_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_11.prefab_name].transform, "story_v_out_417101", "417101107", "story_v_out_417101.awb")

						arg_444_1:RecordAudio("417101107", var_447_17)
						arg_444_1:RecordAudio("417101107", var_447_17)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_417101", "417101107", "story_v_out_417101.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_417101", "417101107", "story_v_out_417101.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_18 = math.max(var_447_9, arg_444_1.talkMaxDuration)

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_18 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_8) / var_447_18

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_8 + var_447_18 and arg_444_1.time_ < var_447_8 + var_447_18 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play417101108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 417101108
		arg_448_1.duration_ = 13.5

		local var_448_0 = {
			zh = 7.466,
			ja = 13.5
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play417101109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10128"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10128 == nil then
				arg_448_1.var_.actorSpriteComps10128 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps10128 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10128 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_451_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps10128 = nil
			end

			local var_451_8 = 0
			local var_451_9 = 0.9

			if var_451_8 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_10 = arg_448_1:FormatText(StoryNameCfg[1112].name)

				arg_448_1.leftNameTxt_.text = var_451_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_11 = arg_448_1:GetWordFromCfg(417101108)
				local var_451_12 = arg_448_1:FormatText(var_451_11.content)

				arg_448_1.text_.text = var_451_12

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101108", "story_v_out_417101.awb") ~= 0 then
					local var_451_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101108", "story_v_out_417101.awb") / 1000

					if var_451_16 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_16 + var_451_8
					end

					if var_451_11.prefab_name ~= "" and arg_448_1.actors_[var_451_11.prefab_name] ~= nil then
						local var_451_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_11.prefab_name].transform, "story_v_out_417101", "417101108", "story_v_out_417101.awb")

						arg_448_1:RecordAudio("417101108", var_451_17)
						arg_448_1:RecordAudio("417101108", var_451_17)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_417101", "417101108", "story_v_out_417101.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_417101", "417101108", "story_v_out_417101.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_18 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_18 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_18

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_18 and arg_448_1.time_ < var_451_8 + var_451_18 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play417101109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 417101109
		arg_452_1.duration_ = 3.23

		local var_452_0 = {
			zh = 3.233,
			ja = 1.766
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
				arg_452_0:Play417101110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["10128"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10128 == nil then
				arg_452_1.var_.actorSpriteComps10128 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps10128 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10128 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_455_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps10128 = nil
			end

			local var_455_8 = arg_452_1.actors_["10128"].transform
			local var_455_9 = 0

			if var_455_9 < arg_452_1.time_ and arg_452_1.time_ <= var_455_9 + arg_455_0 then
				arg_452_1.var_.moveOldPos10128 = var_455_8.localPosition
				var_455_8.localScale = Vector3.New(1, 1, 1)

				arg_452_1:CheckSpriteTmpPos("10128", 3)

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
				local var_455_14 = Vector3.New(0, -347, -300)

				var_455_8.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos10128, var_455_14, var_455_13)
			end

			if arg_452_1.time_ >= var_455_9 + var_455_12 and arg_452_1.time_ < var_455_9 + var_455_12 + arg_455_0 then
				var_455_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_455_15 = 0
			local var_455_16 = 0.4

			if var_455_15 < arg_452_1.time_ and arg_452_1.time_ <= var_455_15 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_17 = arg_452_1:FormatText(StoryNameCfg[595].name)

				arg_452_1.leftNameTxt_.text = var_455_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_18 = arg_452_1:GetWordFromCfg(417101109)
				local var_455_19 = arg_452_1:FormatText(var_455_18.content)

				arg_452_1.text_.text = var_455_19

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101109", "story_v_out_417101.awb") ~= 0 then
					local var_455_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101109", "story_v_out_417101.awb") / 1000

					if var_455_23 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_15
					end

					if var_455_18.prefab_name ~= "" and arg_452_1.actors_[var_455_18.prefab_name] ~= nil then
						local var_455_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_18.prefab_name].transform, "story_v_out_417101", "417101109", "story_v_out_417101.awb")

						arg_452_1:RecordAudio("417101109", var_455_24)
						arg_452_1:RecordAudio("417101109", var_455_24)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_417101", "417101109", "story_v_out_417101.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_417101", "417101109", "story_v_out_417101.awb")
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
				actorName = "10128",
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
	Play417101110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 417101110
		arg_456_1.duration_ = 4.13

		local var_456_0 = {
			zh = 4.133,
			ja = 2.6
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play417101111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["10128"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps10128 == nil then
				arg_456_1.var_.actorSpriteComps10128 = var_459_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.actorSpriteComps10128 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps10128 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_459_3 then
						if arg_456_1.isInRecall_ then
							iter_459_3.color = arg_456_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_459_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps10128 = nil
			end

			local var_459_8 = 0
			local var_459_9 = 0.35

			if var_459_8 < arg_456_1.time_ and arg_456_1.time_ <= var_459_8 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_10 = arg_456_1:FormatText(StoryNameCfg[1112].name)

				arg_456_1.leftNameTxt_.text = var_459_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_11 = arg_456_1:GetWordFromCfg(417101110)
				local var_459_12 = arg_456_1:FormatText(var_459_11.content)

				arg_456_1.text_.text = var_459_12

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_13 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101110", "story_v_out_417101.awb") ~= 0 then
					local var_459_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101110", "story_v_out_417101.awb") / 1000

					if var_459_16 + var_459_8 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_16 + var_459_8
					end

					if var_459_11.prefab_name ~= "" and arg_456_1.actors_[var_459_11.prefab_name] ~= nil then
						local var_459_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_11.prefab_name].transform, "story_v_out_417101", "417101110", "story_v_out_417101.awb")

						arg_456_1:RecordAudio("417101110", var_459_17)
						arg_456_1:RecordAudio("417101110", var_459_17)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_417101", "417101110", "story_v_out_417101.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_417101", "417101110", "story_v_out_417101.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_18 = math.max(var_459_9, arg_456_1.talkMaxDuration)

			if var_459_8 <= arg_456_1.time_ and arg_456_1.time_ < var_459_8 + var_459_18 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_8) / var_459_18

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_8 + var_459_18 and arg_456_1.time_ < var_459_8 + var_459_18 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play417101111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 417101111
		arg_460_1.duration_ = 6.67

		local var_460_0 = {
			zh = 6.666,
			ja = 5.633
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
				arg_460_0:Play417101112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["10128"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10128 == nil then
				arg_460_1.var_.actorSpriteComps10128 = var_463_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_2 = 0.2

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.actorSpriteComps10128 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10128 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_463_3 then
						if arg_460_1.isInRecall_ then
							iter_463_3.color = arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_463_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps10128 = nil
			end

			local var_463_8 = arg_460_1.actors_["10128"].transform
			local var_463_9 = 0

			if var_463_9 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 then
				arg_460_1.var_.moveOldPos10128 = var_463_8.localPosition
				var_463_8.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10128", 3)

				local var_463_10 = var_463_8.childCount

				for iter_463_4 = 0, var_463_10 - 1 do
					local var_463_11 = var_463_8:GetChild(iter_463_4)

					if var_463_11.name == "split_4" or not string.find(var_463_11.name, "split") then
						var_463_11.gameObject:SetActive(true)
					else
						var_463_11.gameObject:SetActive(false)
					end
				end
			end

			local var_463_12 = 0.001

			if var_463_9 <= arg_460_1.time_ and arg_460_1.time_ < var_463_9 + var_463_12 then
				local var_463_13 = (arg_460_1.time_ - var_463_9) / var_463_12
				local var_463_14 = Vector3.New(0, -347, -300)

				var_463_8.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10128, var_463_14, var_463_13)
			end

			if arg_460_1.time_ >= var_463_9 + var_463_12 and arg_460_1.time_ < var_463_9 + var_463_12 + arg_463_0 then
				var_463_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_463_15 = 0
			local var_463_16 = 0.5

			if var_463_15 < arg_460_1.time_ and arg_460_1.time_ <= var_463_15 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_17 = arg_460_1:FormatText(StoryNameCfg[595].name)

				arg_460_1.leftNameTxt_.text = var_463_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_18 = arg_460_1:GetWordFromCfg(417101111)
				local var_463_19 = arg_460_1:FormatText(var_463_18.content)

				arg_460_1.text_.text = var_463_19

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101111", "story_v_out_417101.awb") ~= 0 then
					local var_463_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101111", "story_v_out_417101.awb") / 1000

					if var_463_23 + var_463_15 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_23 + var_463_15
					end

					if var_463_18.prefab_name ~= "" and arg_460_1.actors_[var_463_18.prefab_name] ~= nil then
						local var_463_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_18.prefab_name].transform, "story_v_out_417101", "417101111", "story_v_out_417101.awb")

						arg_460_1:RecordAudio("417101111", var_463_24)
						arg_460_1:RecordAudio("417101111", var_463_24)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_417101", "417101111", "story_v_out_417101.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_417101", "417101111", "story_v_out_417101.awb")
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play417101112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 417101112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play417101113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["10128"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10128 == nil then
				arg_464_1.var_.actorSpriteComps10128 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps10128 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10128 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10128 = nil
			end

			local var_467_8 = arg_464_1.actors_["10128"].transform
			local var_467_9 = 0

			if var_467_9 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 then
				arg_464_1.var_.moveOldPos10128 = var_467_8.localPosition
				var_467_8.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10128", 7)

				local var_467_10 = var_467_8.childCount

				for iter_467_4 = 0, var_467_10 - 1 do
					local var_467_11 = var_467_8:GetChild(iter_467_4)

					if var_467_11.name == "" or not string.find(var_467_11.name, "split") then
						var_467_11.gameObject:SetActive(true)
					else
						var_467_11.gameObject:SetActive(false)
					end
				end
			end

			local var_467_12 = 0.001

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_12 then
				local var_467_13 = (arg_464_1.time_ - var_467_9) / var_467_12
				local var_467_14 = Vector3.New(0, -2000, -300)

				var_467_8.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10128, var_467_14, var_467_13)
			end

			if arg_464_1.time_ >= var_467_9 + var_467_12 and arg_464_1.time_ < var_467_9 + var_467_12 + arg_467_0 then
				var_467_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_467_15 = 0
			local var_467_16 = 0.6

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_17 = arg_464_1:GetWordFromCfg(417101112)
				local var_467_18 = arg_464_1:FormatText(var_467_17.content)

				arg_464_1.text_.text = var_467_18

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_19 = 24
				local var_467_20 = utf8.len(var_467_18)
				local var_467_21 = var_467_19 <= 0 and var_467_16 or var_467_16 * (var_467_20 / var_467_19)

				if var_467_21 > 0 and var_467_16 < var_467_21 then
					arg_464_1.talkMaxDuration = var_467_21

					if var_467_21 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_21 + var_467_15
					end
				end

				arg_464_1.text_.text = var_467_18
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_22 = math.max(var_467_16, arg_464_1.talkMaxDuration)

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_22 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_15) / var_467_22

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_15 + var_467_22 and arg_464_1.time_ < var_467_15 + var_467_22 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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

		arg_464_1:InitPlayNodeList()
	end,
	Play417101113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 417101113
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play417101114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 1.325

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(417101113)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 53
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play417101114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 417101114
		arg_472_1.duration_ = 1.47

		local var_472_0 = {
			zh = 1.466,
			ja = 1.433
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play417101115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.2

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[1112].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_3 = arg_472_1:GetWordFromCfg(417101114)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 8
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101114", "story_v_out_417101.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101114", "story_v_out_417101.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_417101", "417101114", "story_v_out_417101.awb")

						arg_472_1:RecordAudio("417101114", var_475_9)
						arg_472_1:RecordAudio("417101114", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_417101", "417101114", "story_v_out_417101.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_417101", "417101114", "story_v_out_417101.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play417101115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 417101115
		arg_476_1.duration_ = 1.07

		local var_476_0 = {
			zh = 1,
			ja = 1.066
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play417101116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["10128"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps10128 == nil then
				arg_476_1.var_.actorSpriteComps10128 = var_479_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_2 = 0.2

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.actorSpriteComps10128 then
					for iter_479_0, iter_479_1 in pairs(arg_476_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_479_1 then
							if arg_476_1.isInRecall_ then
								local var_479_4 = Mathf.Lerp(iter_479_1.color.r, arg_476_1.hightColor1.r, var_479_3)
								local var_479_5 = Mathf.Lerp(iter_479_1.color.g, arg_476_1.hightColor1.g, var_479_3)
								local var_479_6 = Mathf.Lerp(iter_479_1.color.b, arg_476_1.hightColor1.b, var_479_3)

								iter_479_1.color = Color.New(var_479_4, var_479_5, var_479_6)
							else
								local var_479_7 = Mathf.Lerp(iter_479_1.color.r, 1, var_479_3)

								iter_479_1.color = Color.New(var_479_7, var_479_7, var_479_7)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps10128 then
				for iter_479_2, iter_479_3 in pairs(arg_476_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_479_3 then
						if arg_476_1.isInRecall_ then
							iter_479_3.color = arg_476_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_479_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_476_1.var_.actorSpriteComps10128 = nil
			end

			local var_479_8 = arg_476_1.actors_["10128"].transform
			local var_479_9 = 0

			if var_479_9 < arg_476_1.time_ and arg_476_1.time_ <= var_479_9 + arg_479_0 then
				arg_476_1.var_.moveOldPos10128 = var_479_8.localPosition
				var_479_8.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10128", 3)

				local var_479_10 = var_479_8.childCount

				for iter_479_4 = 0, var_479_10 - 1 do
					local var_479_11 = var_479_8:GetChild(iter_479_4)

					if var_479_11.name == "" or not string.find(var_479_11.name, "split") then
						var_479_11.gameObject:SetActive(true)
					else
						var_479_11.gameObject:SetActive(false)
					end
				end
			end

			local var_479_12 = 0.001

			if var_479_9 <= arg_476_1.time_ and arg_476_1.time_ < var_479_9 + var_479_12 then
				local var_479_13 = (arg_476_1.time_ - var_479_9) / var_479_12
				local var_479_14 = Vector3.New(0, -347, -300)

				var_479_8.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10128, var_479_14, var_479_13)
			end

			if arg_476_1.time_ >= var_479_9 + var_479_12 and arg_476_1.time_ < var_479_9 + var_479_12 + arg_479_0 then
				var_479_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_479_15 = 0
			local var_479_16 = 0.1

			if var_479_15 < arg_476_1.time_ and arg_476_1.time_ <= var_479_15 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_17 = arg_476_1:FormatText(StoryNameCfg[595].name)

				arg_476_1.leftNameTxt_.text = var_479_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_18 = arg_476_1:GetWordFromCfg(417101115)
				local var_479_19 = arg_476_1:FormatText(var_479_18.content)

				arg_476_1.text_.text = var_479_19

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_20 = 4
				local var_479_21 = utf8.len(var_479_19)
				local var_479_22 = var_479_20 <= 0 and var_479_16 or var_479_16 * (var_479_21 / var_479_20)

				if var_479_22 > 0 and var_479_16 < var_479_22 then
					arg_476_1.talkMaxDuration = var_479_22

					if var_479_22 + var_479_15 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_22 + var_479_15
					end
				end

				arg_476_1.text_.text = var_479_19
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101115", "story_v_out_417101.awb") ~= 0 then
					local var_479_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101115", "story_v_out_417101.awb") / 1000

					if var_479_23 + var_479_15 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_23 + var_479_15
					end

					if var_479_18.prefab_name ~= "" and arg_476_1.actors_[var_479_18.prefab_name] ~= nil then
						local var_479_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_18.prefab_name].transform, "story_v_out_417101", "417101115", "story_v_out_417101.awb")

						arg_476_1:RecordAudio("417101115", var_479_24)
						arg_476_1:RecordAudio("417101115", var_479_24)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_417101", "417101115", "story_v_out_417101.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_417101", "417101115", "story_v_out_417101.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_25 = math.max(var_479_16, arg_476_1.talkMaxDuration)

			if var_479_15 <= arg_476_1.time_ and arg_476_1.time_ < var_479_15 + var_479_25 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_15) / var_479_25

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_15 + var_479_25 and arg_476_1.time_ < var_479_15 + var_479_25 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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

		arg_476_1:InitPlayNodeList()
	end,
	Play417101116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 417101116
		arg_480_1.duration_ = 8.37

		local var_480_0 = {
			zh = 6,
			ja = 8.366
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play417101117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10128"]
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10128 == nil then
				arg_480_1.var_.actorSpriteComps10128 = var_483_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_2 = 0.2

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 and not isNil(var_483_0) then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2

				if arg_480_1.var_.actorSpriteComps10128 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								local var_483_4 = Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor2.r, var_483_3)
								local var_483_5 = Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor2.g, var_483_3)
								local var_483_6 = Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor2.b, var_483_3)

								iter_483_1.color = Color.New(var_483_4, var_483_5, var_483_6)
							else
								local var_483_7 = Mathf.Lerp(iter_483_1.color.r, 0.5, var_483_3)

								iter_483_1.color = Color.New(var_483_7, var_483_7, var_483_7)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10128 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_483_3 then
						if arg_480_1.isInRecall_ then
							iter_483_3.color = arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_483_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps10128 = nil
			end

			local var_483_8 = 0
			local var_483_9 = 0.75

			if var_483_8 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_10 = arg_480_1:FormatText(StoryNameCfg[1112].name)

				arg_480_1.leftNameTxt_.text = var_483_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_11 = arg_480_1:GetWordFromCfg(417101116)
				local var_483_12 = arg_480_1:FormatText(var_483_11.content)

				arg_480_1.text_.text = var_483_12

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_13 = 30
				local var_483_14 = utf8.len(var_483_12)
				local var_483_15 = var_483_13 <= 0 and var_483_9 or var_483_9 * (var_483_14 / var_483_13)

				if var_483_15 > 0 and var_483_9 < var_483_15 then
					arg_480_1.talkMaxDuration = var_483_15

					if var_483_15 + var_483_8 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_15 + var_483_8
					end
				end

				arg_480_1.text_.text = var_483_12
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101116", "story_v_out_417101.awb") ~= 0 then
					local var_483_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101116", "story_v_out_417101.awb") / 1000

					if var_483_16 + var_483_8 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_16 + var_483_8
					end

					if var_483_11.prefab_name ~= "" and arg_480_1.actors_[var_483_11.prefab_name] ~= nil then
						local var_483_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_11.prefab_name].transform, "story_v_out_417101", "417101116", "story_v_out_417101.awb")

						arg_480_1:RecordAudio("417101116", var_483_17)
						arg_480_1:RecordAudio("417101116", var_483_17)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_417101", "417101116", "story_v_out_417101.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_417101", "417101116", "story_v_out_417101.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_18 = math.max(var_483_9, arg_480_1.talkMaxDuration)

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_18 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_8) / var_483_18

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_8 + var_483_18 and arg_480_1.time_ < var_483_8 + var_483_18 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play417101117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 417101117
		arg_484_1.duration_ = 8.57

		local var_484_0 = {
			zh = 6.466,
			ja = 8.566
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
				arg_484_0:Play417101118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.775

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[1112].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:GetWordFromCfg(417101117)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101117", "story_v_out_417101.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101117", "story_v_out_417101.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_417101", "417101117", "story_v_out_417101.awb")

						arg_484_1:RecordAudio("417101117", var_487_9)
						arg_484_1:RecordAudio("417101117", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_417101", "417101117", "story_v_out_417101.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_417101", "417101117", "story_v_out_417101.awb")
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
	Play417101118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 417101118
		arg_488_1.duration_ = 9.11

		local var_488_0 = {
			zh = 7.80630430285819,
			ja = 9.10630430285819
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play417101119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 2.5

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				local var_491_1 = manager.ui.mainCamera.transform.localPosition
				local var_491_2 = Vector3.New(0, 0, 10) + Vector3.New(var_491_1.x, var_491_1.y, 0)
				local var_491_3 = arg_488_1.bgs_.STblack

				var_491_3.transform.localPosition = var_491_2
				var_491_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_491_4 = var_491_3:GetComponent("SpriteRenderer")

				if var_491_4 and var_491_4.sprite then
					local var_491_5 = (var_491_3.transform.localPosition - var_491_1).z
					local var_491_6 = manager.ui.mainCameraCom_
					local var_491_7 = 2 * var_491_5 * Mathf.Tan(var_491_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_491_8 = var_491_7 * var_491_6.aspect
					local var_491_9 = var_491_4.sprite.bounds.size.x
					local var_491_10 = var_491_4.sprite.bounds.size.y
					local var_491_11 = var_491_8 / var_491_9
					local var_491_12 = var_491_7 / var_491_10
					local var_491_13 = var_491_12 < var_491_11 and var_491_11 or var_491_12

					var_491_3.transform.localScale = Vector3.New(var_491_13, var_491_13, 0)
				end

				for iter_491_0, iter_491_1 in pairs(arg_488_1.bgs_) do
					if iter_491_0 ~= "STblack" then
						iter_491_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_491_14 = "I07a"

			if arg_488_1.bgs_[var_491_14] == nil then
				local var_491_15 = Object.Instantiate(arg_488_1.paintGo_)

				var_491_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_491_14)
				var_491_15.name = var_491_14
				var_491_15.transform.parent = arg_488_1.stage_.transform
				var_491_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_488_1.bgs_[var_491_14] = var_491_15
			end

			local var_491_16 = 3.600000000001

			if var_491_16 < arg_488_1.time_ and arg_488_1.time_ <= var_491_16 + arg_491_0 then
				local var_491_17 = manager.ui.mainCamera.transform.localPosition
				local var_491_18 = Vector3.New(0, 0, 10) + Vector3.New(var_491_17.x, var_491_17.y, 0)
				local var_491_19 = arg_488_1.bgs_.I07a

				var_491_19.transform.localPosition = var_491_18
				var_491_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_491_20 = var_491_19:GetComponent("SpriteRenderer")

				if var_491_20 and var_491_20.sprite then
					local var_491_21 = (var_491_19.transform.localPosition - var_491_17).z
					local var_491_22 = manager.ui.mainCameraCom_
					local var_491_23 = 2 * var_491_21 * Mathf.Tan(var_491_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_491_24 = var_491_23 * var_491_22.aspect
					local var_491_25 = var_491_20.sprite.bounds.size.x
					local var_491_26 = var_491_20.sprite.bounds.size.y
					local var_491_27 = var_491_24 / var_491_25
					local var_491_28 = var_491_23 / var_491_26
					local var_491_29 = var_491_28 < var_491_27 and var_491_27 or var_491_28

					var_491_19.transform.localScale = Vector3.New(var_491_29, var_491_29, 0)
				end

				for iter_491_2, iter_491_3 in pairs(arg_488_1.bgs_) do
					if iter_491_2 ~= "I07a" then
						iter_491_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_491_30 = 2.699999999999

			if var_491_30 < arg_488_1.time_ and arg_488_1.time_ <= var_491_30 + arg_491_0 then
				arg_488_1.allBtn_.enabled = false
			end

			local var_491_31 = 0.3

			if arg_488_1.time_ >= var_491_30 + var_491_31 and arg_488_1.time_ < var_491_30 + var_491_31 + arg_491_0 then
				arg_488_1.allBtn_.enabled = true
			end

			local var_491_32 = 0

			if var_491_32 < arg_488_1.time_ and arg_488_1.time_ <= var_491_32 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_33 = 2.5

			if var_491_32 <= arg_488_1.time_ and arg_488_1.time_ < var_491_32 + var_491_33 then
				local var_491_34 = (arg_488_1.time_ - var_491_32) / var_491_33
				local var_491_35 = Color.New(0, 0, 0)

				var_491_35.a = Mathf.Lerp(0, 1, var_491_34)
				arg_488_1.mask_.color = var_491_35
			end

			if arg_488_1.time_ >= var_491_32 + var_491_33 and arg_488_1.time_ < var_491_32 + var_491_33 + arg_491_0 then
				local var_491_36 = Color.New(0, 0, 0)

				var_491_36.a = 1
				arg_488_1.mask_.color = var_491_36
			end

			local var_491_37 = 3.600000000001

			if var_491_37 < arg_488_1.time_ and arg_488_1.time_ <= var_491_37 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_38 = 2.46666666666567

			if var_491_37 <= arg_488_1.time_ and arg_488_1.time_ < var_491_37 + var_491_38 then
				local var_491_39 = (arg_488_1.time_ - var_491_37) / var_491_38
				local var_491_40 = Color.New(0, 0, 0)

				var_491_40.a = Mathf.Lerp(1, 0, var_491_39)
				arg_488_1.mask_.color = var_491_40
			end

			if arg_488_1.time_ >= var_491_37 + var_491_38 and arg_488_1.time_ < var_491_37 + var_491_38 + arg_491_0 then
				local var_491_41 = Color.New(0, 0, 0)
				local var_491_42 = 0

				arg_488_1.mask_.enabled = false
				var_491_41.a = var_491_42
				arg_488_1.mask_.color = var_491_41
			end

			local var_491_43 = "1034"

			if arg_488_1.actors_[var_491_43] == nil then
				local var_491_44 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_491_44) then
					local var_491_45 = Object.Instantiate(var_491_44, arg_488_1.canvasGo_.transform)

					var_491_45.transform:SetSiblingIndex(1)

					var_491_45.name = var_491_43
					var_491_45.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_488_1.actors_[var_491_43] = var_491_45

					local var_491_46 = var_491_45:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_488_1.isInRecall_ then
						for iter_491_4, iter_491_5 in ipairs(var_491_46) do
							iter_491_5.color = arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_491_47 = arg_488_1.actors_["1034"]
			local var_491_48 = 2.5

			if var_491_48 < arg_488_1.time_ and arg_488_1.time_ <= var_491_48 + arg_491_0 and not isNil(var_491_47) and arg_488_1.var_.actorSpriteComps1034 == nil then
				arg_488_1.var_.actorSpriteComps1034 = var_491_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_49 = 0.2

			if var_491_48 <= arg_488_1.time_ and arg_488_1.time_ < var_491_48 + var_491_49 and not isNil(var_491_47) then
				local var_491_50 = (arg_488_1.time_ - var_491_48) / var_491_49

				if arg_488_1.var_.actorSpriteComps1034 then
					for iter_491_6, iter_491_7 in pairs(arg_488_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_491_7 then
							if arg_488_1.isInRecall_ then
								local var_491_51 = Mathf.Lerp(iter_491_7.color.r, arg_488_1.hightColor1.r, var_491_50)
								local var_491_52 = Mathf.Lerp(iter_491_7.color.g, arg_488_1.hightColor1.g, var_491_50)
								local var_491_53 = Mathf.Lerp(iter_491_7.color.b, arg_488_1.hightColor1.b, var_491_50)

								iter_491_7.color = Color.New(var_491_51, var_491_52, var_491_53)
							else
								local var_491_54 = Mathf.Lerp(iter_491_7.color.r, 1, var_491_50)

								iter_491_7.color = Color.New(var_491_54, var_491_54, var_491_54)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= var_491_48 + var_491_49 and arg_488_1.time_ < var_491_48 + var_491_49 + arg_491_0 and not isNil(var_491_47) and arg_488_1.var_.actorSpriteComps1034 then
				for iter_491_8, iter_491_9 in pairs(arg_488_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_491_9 then
						if arg_488_1.isInRecall_ then
							iter_491_9.color = arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_491_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_488_1.var_.actorSpriteComps1034 = nil
			end

			local var_491_55 = arg_488_1.actors_["10128"].transform
			local var_491_56 = 2.5

			if var_491_56 < arg_488_1.time_ and arg_488_1.time_ <= var_491_56 + arg_491_0 then
				arg_488_1.var_.moveOldPos10128 = var_491_55.localPosition
				var_491_55.localScale = Vector3.New(1, 1, 1)

				arg_488_1:CheckSpriteTmpPos("10128", 7)

				local var_491_57 = var_491_55.childCount

				for iter_491_10 = 0, var_491_57 - 1 do
					local var_491_58 = var_491_55:GetChild(iter_491_10)

					if var_491_58.name == "" or not string.find(var_491_58.name, "split") then
						var_491_58.gameObject:SetActive(true)
					else
						var_491_58.gameObject:SetActive(false)
					end
				end
			end

			local var_491_59 = 0.001

			if var_491_56 <= arg_488_1.time_ and arg_488_1.time_ < var_491_56 + var_491_59 then
				local var_491_60 = (arg_488_1.time_ - var_491_56) / var_491_59
				local var_491_61 = Vector3.New(0, -2000, -300)

				var_491_55.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos10128, var_491_61, var_491_60)
			end

			if arg_488_1.time_ >= var_491_56 + var_491_59 and arg_488_1.time_ < var_491_56 + var_491_59 + arg_491_0 then
				var_491_55.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_491_62 = 0
			local var_491_63 = 0.2

			if var_491_62 < arg_488_1.time_ and arg_488_1.time_ <= var_491_62 + arg_491_0 then
				local var_491_64 = "play"
				local var_491_65 = "music"

				arg_488_1:AudioAction(var_491_64, var_491_65, "ui_battle", "ui_battle_stopbgm", "")

				local var_491_66 = ""
				local var_491_67 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_491_67 ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_67 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_67

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_67
						arg_488_1.bgmTxt2_.text = var_491_67
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_491_68 = 1.66666666666667
			local var_491_69 = 1

			if var_491_68 < arg_488_1.time_ and arg_488_1.time_ <= var_491_68 + arg_491_0 then
				local var_491_70 = "play"
				local var_491_71 = "music"

				arg_488_1:AudioAction(var_491_70, var_491_71, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_491_72 = ""
				local var_491_73 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_491_73 ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_73 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_73

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_73
						arg_488_1.bgmTxt2_.text = var_491_73
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_491_74 = 2.5

			if var_491_74 < arg_488_1.time_ and arg_488_1.time_ <= var_491_74 + arg_491_0 then
				arg_488_1.allBtn_.enabled = false
			end

			local var_491_75 = 1.100000000001

			if arg_488_1.time_ >= var_491_74 + var_491_75 and arg_488_1.time_ < var_491_74 + var_491_75 + arg_491_0 then
				arg_488_1.allBtn_.enabled = true
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_76 = 5.20630430285819
			local var_491_77 = 0.2

			if var_491_76 < arg_488_1.time_ and arg_488_1.time_ <= var_491_76 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_78 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_78:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_488_1.dialogCg_.alpha = arg_494_0
				end))
				var_491_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_79 = arg_488_1:FormatText(StoryNameCfg[1109].name)

				arg_488_1.leftNameTxt_.text = var_491_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_80 = arg_488_1:GetWordFromCfg(417101118)
				local var_491_81 = arg_488_1:FormatText(var_491_80.content)

				arg_488_1.text_.text = var_491_81

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_82 = 8
				local var_491_83 = utf8.len(var_491_81)
				local var_491_84 = var_491_82 <= 0 and var_491_77 or var_491_77 * (var_491_83 / var_491_82)

				if var_491_84 > 0 and var_491_77 < var_491_84 then
					arg_488_1.talkMaxDuration = var_491_84
					var_491_76 = var_491_76 + 0.3

					if var_491_84 + var_491_76 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_84 + var_491_76
					end
				end

				arg_488_1.text_.text = var_491_81
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101118", "story_v_out_417101.awb") ~= 0 then
					local var_491_85 = manager.audio:GetVoiceLength("story_v_out_417101", "417101118", "story_v_out_417101.awb") / 1000

					if var_491_85 + var_491_76 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_85 + var_491_76
					end

					if var_491_80.prefab_name ~= "" and arg_488_1.actors_[var_491_80.prefab_name] ~= nil then
						local var_491_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_80.prefab_name].transform, "story_v_out_417101", "417101118", "story_v_out_417101.awb")

						arg_488_1:RecordAudio("417101118", var_491_86)
						arg_488_1:RecordAudio("417101118", var_491_86)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_417101", "417101118", "story_v_out_417101.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_417101", "417101118", "story_v_out_417101.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_87 = var_491_76 + 0.3
			local var_491_88 = math.max(var_491_77, arg_488_1.talkMaxDuration)

			if var_491_87 <= arg_488_1.time_ and arg_488_1.time_ < var_491_87 + var_491_88 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_87) / var_491_88

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_87 + var_491_88 and arg_488_1.time_ < var_491_87 + var_491_88 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play417101119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 417101119
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play417101120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1034"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps1034 == nil then
				arg_496_1.var_.actorSpriteComps1034 = var_499_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_2 = 0.2

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.actorSpriteComps1034 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								local var_499_4 = Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor2.r, var_499_3)
								local var_499_5 = Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor2.g, var_499_3)
								local var_499_6 = Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor2.b, var_499_3)

								iter_499_1.color = Color.New(var_499_4, var_499_5, var_499_6)
							else
								local var_499_7 = Mathf.Lerp(iter_499_1.color.r, 0.5, var_499_3)

								iter_499_1.color = Color.New(var_499_7, var_499_7, var_499_7)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps1034 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_499_3 then
						if arg_496_1.isInRecall_ then
							iter_499_3.color = arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_499_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps1034 = nil
			end

			local var_499_8 = 0
			local var_499_9 = 1.125

			if var_499_8 < arg_496_1.time_ and arg_496_1.time_ <= var_499_8 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_10 = arg_496_1:GetWordFromCfg(417101119)
				local var_499_11 = arg_496_1:FormatText(var_499_10.content)

				arg_496_1.text_.text = var_499_11

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_12 = 45
				local var_499_13 = utf8.len(var_499_11)
				local var_499_14 = var_499_12 <= 0 and var_499_9 or var_499_9 * (var_499_13 / var_499_12)

				if var_499_14 > 0 and var_499_9 < var_499_14 then
					arg_496_1.talkMaxDuration = var_499_14

					if var_499_14 + var_499_8 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_14 + var_499_8
					end
				end

				arg_496_1.text_.text = var_499_11
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_15 = math.max(var_499_9, arg_496_1.talkMaxDuration)

			if var_499_8 <= arg_496_1.time_ and arg_496_1.time_ < var_499_8 + var_499_15 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_8) / var_499_15

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_8 + var_499_15 and arg_496_1.time_ < var_499_8 + var_499_15 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play417101120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 417101120
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play417101121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 1.6

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_2 = arg_500_1:GetWordFromCfg(417101120)
				local var_503_3 = arg_500_1:FormatText(var_503_2.content)

				arg_500_1.text_.text = var_503_3

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 64
				local var_503_5 = utf8.len(var_503_3)
				local var_503_6 = var_503_4 <= 0 and var_503_1 or var_503_1 * (var_503_5 / var_503_4)

				if var_503_6 > 0 and var_503_1 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_3
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_7 and arg_500_1.time_ < var_503_0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play417101121 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 417101121
		arg_504_1.duration_ = 2.3

		local var_504_0 = {
			zh = 0.999999999999,
			ja = 2.3
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play417101122(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1034"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.actorSpriteComps1034 == nil then
				arg_504_1.var_.actorSpriteComps1034 = var_507_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_507_2 = 0.2

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.actorSpriteComps1034 then
					for iter_507_0, iter_507_1 in pairs(arg_504_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_507_1 then
							if arg_504_1.isInRecall_ then
								local var_507_4 = Mathf.Lerp(iter_507_1.color.r, arg_504_1.hightColor1.r, var_507_3)
								local var_507_5 = Mathf.Lerp(iter_507_1.color.g, arg_504_1.hightColor1.g, var_507_3)
								local var_507_6 = Mathf.Lerp(iter_507_1.color.b, arg_504_1.hightColor1.b, var_507_3)

								iter_507_1.color = Color.New(var_507_4, var_507_5, var_507_6)
							else
								local var_507_7 = Mathf.Lerp(iter_507_1.color.r, 1, var_507_3)

								iter_507_1.color = Color.New(var_507_7, var_507_7, var_507_7)
							end
						end
					end
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.actorSpriteComps1034 then
				for iter_507_2, iter_507_3 in pairs(arg_504_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_507_3 then
						if arg_504_1.isInRecall_ then
							iter_507_3.color = arg_504_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_507_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_504_1.var_.actorSpriteComps1034 = nil
			end

			local var_507_8 = arg_504_1.actors_["1034"].transform
			local var_507_9 = 0

			if var_507_9 < arg_504_1.time_ and arg_504_1.time_ <= var_507_9 + arg_507_0 then
				arg_504_1.var_.moveOldPos1034 = var_507_8.localPosition
				var_507_8.localScale = Vector3.New(1, 1, 1)

				arg_504_1:CheckSpriteTmpPos("1034", 3)

				local var_507_10 = var_507_8.childCount

				for iter_507_4 = 0, var_507_10 - 1 do
					local var_507_11 = var_507_8:GetChild(iter_507_4)

					if var_507_11.name == "" or not string.find(var_507_11.name, "split") then
						var_507_11.gameObject:SetActive(true)
					else
						var_507_11.gameObject:SetActive(false)
					end
				end
			end

			local var_507_12 = 0.001

			if var_507_9 <= arg_504_1.time_ and arg_504_1.time_ < var_507_9 + var_507_12 then
				local var_507_13 = (arg_504_1.time_ - var_507_9) / var_507_12
				local var_507_14 = Vector3.New(0, -331.9, -324)

				var_507_8.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos1034, var_507_14, var_507_13)
			end

			if arg_504_1.time_ >= var_507_9 + var_507_12 and arg_504_1.time_ < var_507_9 + var_507_12 + arg_507_0 then
				var_507_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_507_15 = 0
			local var_507_16 = 0.075

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_17 = arg_504_1:FormatText(StoryNameCfg[1109].name)

				arg_504_1.leftNameTxt_.text = var_507_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_18 = arg_504_1:GetWordFromCfg(417101121)
				local var_507_19 = arg_504_1:FormatText(var_507_18.content)

				arg_504_1.text_.text = var_507_19

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_20 = 3
				local var_507_21 = utf8.len(var_507_19)
				local var_507_22 = var_507_20 <= 0 and var_507_16 or var_507_16 * (var_507_21 / var_507_20)

				if var_507_22 > 0 and var_507_16 < var_507_22 then
					arg_504_1.talkMaxDuration = var_507_22

					if var_507_22 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_22 + var_507_15
					end
				end

				arg_504_1.text_.text = var_507_19
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101121", "story_v_out_417101.awb") ~= 0 then
					local var_507_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101121", "story_v_out_417101.awb") / 1000

					if var_507_23 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_23 + var_507_15
					end

					if var_507_18.prefab_name ~= "" and arg_504_1.actors_[var_507_18.prefab_name] ~= nil then
						local var_507_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_18.prefab_name].transform, "story_v_out_417101", "417101121", "story_v_out_417101.awb")

						arg_504_1:RecordAudio("417101121", var_507_24)
						arg_504_1:RecordAudio("417101121", var_507_24)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_417101", "417101121", "story_v_out_417101.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_417101", "417101121", "story_v_out_417101.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_25 = math.max(var_507_16, arg_504_1.talkMaxDuration)

			if var_507_15 <= arg_504_1.time_ and arg_504_1.time_ < var_507_15 + var_507_25 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_15) / var_507_25

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_15 + var_507_25 and arg_504_1.time_ < var_507_15 + var_507_25 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
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

		arg_504_1:InitPlayNodeList()
	end,
	Play417101122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 417101122
		arg_508_1.duration_ = 1.53

		local var_508_0 = {
			zh = 1.1,
			ja = 1.533
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play417101123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1034"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps1034 == nil then
				arg_508_1.var_.actorSpriteComps1034 = var_511_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.actorSpriteComps1034 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								local var_511_4 = Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor2.r, var_511_3)
								local var_511_5 = Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor2.g, var_511_3)
								local var_511_6 = Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor2.b, var_511_3)

								iter_511_1.color = Color.New(var_511_4, var_511_5, var_511_6)
							else
								local var_511_7 = Mathf.Lerp(iter_511_1.color.r, 0.5, var_511_3)

								iter_511_1.color = Color.New(var_511_7, var_511_7, var_511_7)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps1034 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_511_3 then
						if arg_508_1.isInRecall_ then
							iter_511_3.color = arg_508_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_511_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_508_1.var_.actorSpriteComps1034 = nil
			end

			local var_511_8 = 0
			local var_511_9 = 0.1

			if var_511_8 < arg_508_1.time_ and arg_508_1.time_ <= var_511_8 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_10 = arg_508_1:FormatText(StoryNameCfg[1135].name)

				arg_508_1.leftNameTxt_.text = var_511_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_11 = arg_508_1:GetWordFromCfg(417101122)
				local var_511_12 = arg_508_1:FormatText(var_511_11.content)

				arg_508_1.text_.text = var_511_12

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_13 = 4
				local var_511_14 = utf8.len(var_511_12)
				local var_511_15 = var_511_13 <= 0 and var_511_9 or var_511_9 * (var_511_14 / var_511_13)

				if var_511_15 > 0 and var_511_9 < var_511_15 then
					arg_508_1.talkMaxDuration = var_511_15

					if var_511_15 + var_511_8 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_15 + var_511_8
					end
				end

				arg_508_1.text_.text = var_511_12
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101122", "story_v_out_417101.awb") ~= 0 then
					local var_511_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101122", "story_v_out_417101.awb") / 1000

					if var_511_16 + var_511_8 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_16 + var_511_8
					end

					if var_511_11.prefab_name ~= "" and arg_508_1.actors_[var_511_11.prefab_name] ~= nil then
						local var_511_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_11.prefab_name].transform, "story_v_out_417101", "417101122", "story_v_out_417101.awb")

						arg_508_1:RecordAudio("417101122", var_511_17)
						arg_508_1:RecordAudio("417101122", var_511_17)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_417101", "417101122", "story_v_out_417101.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_417101", "417101122", "story_v_out_417101.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_18 = math.max(var_511_9, arg_508_1.talkMaxDuration)

			if var_511_8 <= arg_508_1.time_ and arg_508_1.time_ < var_511_8 + var_511_18 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_8) / var_511_18

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_8 + var_511_18 and arg_508_1.time_ < var_511_8 + var_511_18 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play417101123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 417101123
		arg_512_1.duration_ = 3.83

		local var_512_0 = {
			zh = 2.1,
			ja = 3.833
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play417101124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1034"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps1034 == nil then
				arg_512_1.var_.actorSpriteComps1034 = var_515_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_2 = 0.2

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.actorSpriteComps1034 then
					for iter_515_0, iter_515_1 in pairs(arg_512_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_515_1 then
							if arg_512_1.isInRecall_ then
								local var_515_4 = Mathf.Lerp(iter_515_1.color.r, arg_512_1.hightColor1.r, var_515_3)
								local var_515_5 = Mathf.Lerp(iter_515_1.color.g, arg_512_1.hightColor1.g, var_515_3)
								local var_515_6 = Mathf.Lerp(iter_515_1.color.b, arg_512_1.hightColor1.b, var_515_3)

								iter_515_1.color = Color.New(var_515_4, var_515_5, var_515_6)
							else
								local var_515_7 = Mathf.Lerp(iter_515_1.color.r, 1, var_515_3)

								iter_515_1.color = Color.New(var_515_7, var_515_7, var_515_7)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps1034 then
				for iter_515_2, iter_515_3 in pairs(arg_512_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_515_3 then
						if arg_512_1.isInRecall_ then
							iter_515_3.color = arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_515_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_512_1.var_.actorSpriteComps1034 = nil
			end

			local var_515_8 = arg_512_1.actors_["1034"].transform
			local var_515_9 = 0

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 then
				arg_512_1.var_.moveOldPos1034 = var_515_8.localPosition
				var_515_8.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("1034", 3)

				local var_515_10 = var_515_8.childCount

				for iter_515_4 = 0, var_515_10 - 1 do
					local var_515_11 = var_515_8:GetChild(iter_515_4)

					if var_515_11.name == "split_4" or not string.find(var_515_11.name, "split") then
						var_515_11.gameObject:SetActive(true)
					else
						var_515_11.gameObject:SetActive(false)
					end
				end
			end

			local var_515_12 = 0.001

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_12 then
				local var_515_13 = (arg_512_1.time_ - var_515_9) / var_515_12
				local var_515_14 = Vector3.New(0, -331.9, -324)

				var_515_8.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos1034, var_515_14, var_515_13)
			end

			if arg_512_1.time_ >= var_515_9 + var_515_12 and arg_512_1.time_ < var_515_9 + var_515_12 + arg_515_0 then
				var_515_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_515_15 = 0
			local var_515_16 = 0.275

			if var_515_15 < arg_512_1.time_ and arg_512_1.time_ <= var_515_15 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_17 = arg_512_1:FormatText(StoryNameCfg[1109].name)

				arg_512_1.leftNameTxt_.text = var_515_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_18 = arg_512_1:GetWordFromCfg(417101123)
				local var_515_19 = arg_512_1:FormatText(var_515_18.content)

				arg_512_1.text_.text = var_515_19

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_20 = 11
				local var_515_21 = utf8.len(var_515_19)
				local var_515_22 = var_515_20 <= 0 and var_515_16 or var_515_16 * (var_515_21 / var_515_20)

				if var_515_22 > 0 and var_515_16 < var_515_22 then
					arg_512_1.talkMaxDuration = var_515_22

					if var_515_22 + var_515_15 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_22 + var_515_15
					end
				end

				arg_512_1.text_.text = var_515_19
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101123", "story_v_out_417101.awb") ~= 0 then
					local var_515_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101123", "story_v_out_417101.awb") / 1000

					if var_515_23 + var_515_15 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_23 + var_515_15
					end

					if var_515_18.prefab_name ~= "" and arg_512_1.actors_[var_515_18.prefab_name] ~= nil then
						local var_515_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_18.prefab_name].transform, "story_v_out_417101", "417101123", "story_v_out_417101.awb")

						arg_512_1:RecordAudio("417101123", var_515_24)
						arg_512_1:RecordAudio("417101123", var_515_24)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_417101", "417101123", "story_v_out_417101.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_417101", "417101123", "story_v_out_417101.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_25 = math.max(var_515_16, arg_512_1.talkMaxDuration)

			if var_515_15 <= arg_512_1.time_ and arg_512_1.time_ < var_515_15 + var_515_25 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_15) / var_515_25

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_15 + var_515_25 and arg_512_1.time_ < var_515_15 + var_515_25 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
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

		arg_512_1:InitPlayNodeList()
	end,
	Play417101124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 417101124
		arg_516_1.duration_ = 3.33

		local var_516_0 = {
			zh = 3.333,
			ja = 3.266
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play417101125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1034"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.actorSpriteComps1034 == nil then
				arg_516_1.var_.actorSpriteComps1034 = var_519_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_519_2 = 0.2

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.actorSpriteComps1034 then
					for iter_519_0, iter_519_1 in pairs(arg_516_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_519_1 then
							if arg_516_1.isInRecall_ then
								local var_519_4 = Mathf.Lerp(iter_519_1.color.r, arg_516_1.hightColor2.r, var_519_3)
								local var_519_5 = Mathf.Lerp(iter_519_1.color.g, arg_516_1.hightColor2.g, var_519_3)
								local var_519_6 = Mathf.Lerp(iter_519_1.color.b, arg_516_1.hightColor2.b, var_519_3)

								iter_519_1.color = Color.New(var_519_4, var_519_5, var_519_6)
							else
								local var_519_7 = Mathf.Lerp(iter_519_1.color.r, 0.5, var_519_3)

								iter_519_1.color = Color.New(var_519_7, var_519_7, var_519_7)
							end
						end
					end
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.actorSpriteComps1034 then
				for iter_519_2, iter_519_3 in pairs(arg_516_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_519_3 then
						if arg_516_1.isInRecall_ then
							iter_519_3.color = arg_516_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_519_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_516_1.var_.actorSpriteComps1034 = nil
			end

			local var_519_8 = 0
			local var_519_9 = 0.375

			if var_519_8 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_10 = arg_516_1:FormatText(StoryNameCfg[1135].name)

				arg_516_1.leftNameTxt_.text = var_519_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_11 = arg_516_1:GetWordFromCfg(417101124)
				local var_519_12 = arg_516_1:FormatText(var_519_11.content)

				arg_516_1.text_.text = var_519_12

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_13 = 15
				local var_519_14 = utf8.len(var_519_12)
				local var_519_15 = var_519_13 <= 0 and var_519_9 or var_519_9 * (var_519_14 / var_519_13)

				if var_519_15 > 0 and var_519_9 < var_519_15 then
					arg_516_1.talkMaxDuration = var_519_15

					if var_519_15 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_15 + var_519_8
					end
				end

				arg_516_1.text_.text = var_519_12
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101124", "story_v_out_417101.awb") ~= 0 then
					local var_519_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101124", "story_v_out_417101.awb") / 1000

					if var_519_16 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_16 + var_519_8
					end

					if var_519_11.prefab_name ~= "" and arg_516_1.actors_[var_519_11.prefab_name] ~= nil then
						local var_519_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_11.prefab_name].transform, "story_v_out_417101", "417101124", "story_v_out_417101.awb")

						arg_516_1:RecordAudio("417101124", var_519_17)
						arg_516_1:RecordAudio("417101124", var_519_17)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_417101", "417101124", "story_v_out_417101.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_417101", "417101124", "story_v_out_417101.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_18 = math.max(var_519_9, arg_516_1.talkMaxDuration)

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_18 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_8) / var_519_18

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_8 + var_519_18 and arg_516_1.time_ < var_519_8 + var_519_18 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play417101125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 417101125
		arg_520_1.duration_ = 5.93

		local var_520_0 = {
			zh = 5.933,
			ja = 4.466
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play417101126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["1034"]
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps1034 == nil then
				arg_520_1.var_.actorSpriteComps1034 = var_523_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_2 = 0.2

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 and not isNil(var_523_0) then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2

				if arg_520_1.var_.actorSpriteComps1034 then
					for iter_523_0, iter_523_1 in pairs(arg_520_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_523_1 then
							if arg_520_1.isInRecall_ then
								local var_523_4 = Mathf.Lerp(iter_523_1.color.r, arg_520_1.hightColor1.r, var_523_3)
								local var_523_5 = Mathf.Lerp(iter_523_1.color.g, arg_520_1.hightColor1.g, var_523_3)
								local var_523_6 = Mathf.Lerp(iter_523_1.color.b, arg_520_1.hightColor1.b, var_523_3)

								iter_523_1.color = Color.New(var_523_4, var_523_5, var_523_6)
							else
								local var_523_7 = Mathf.Lerp(iter_523_1.color.r, 1, var_523_3)

								iter_523_1.color = Color.New(var_523_7, var_523_7, var_523_7)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps1034 then
				for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_523_3 then
						if arg_520_1.isInRecall_ then
							iter_523_3.color = arg_520_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_523_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_520_1.var_.actorSpriteComps1034 = nil
			end

			local var_523_8 = "2078"

			if arg_520_1.actors_[var_523_8] == nil then
				local var_523_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "2078")

				if not isNil(var_523_9) then
					local var_523_10 = Object.Instantiate(var_523_9, arg_520_1.canvasGo_.transform)

					var_523_10.transform:SetSiblingIndex(1)

					var_523_10.name = var_523_8
					var_523_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_520_1.actors_[var_523_8] = var_523_10

					local var_523_11 = var_523_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_520_1.isInRecall_ then
						for iter_523_4, iter_523_5 in ipairs(var_523_11) do
							iter_523_5.color = arg_520_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_523_12 = arg_520_1.actors_["2078"]
			local var_523_13 = 0

			if var_523_13 < arg_520_1.time_ and arg_520_1.time_ <= var_523_13 + arg_523_0 and not isNil(var_523_12) and arg_520_1.var_.actorSpriteComps2078 == nil then
				arg_520_1.var_.actorSpriteComps2078 = var_523_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_14 = 0.2

			if var_523_13 <= arg_520_1.time_ and arg_520_1.time_ < var_523_13 + var_523_14 and not isNil(var_523_12) then
				local var_523_15 = (arg_520_1.time_ - var_523_13) / var_523_14

				if arg_520_1.var_.actorSpriteComps2078 then
					for iter_523_6, iter_523_7 in pairs(arg_520_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_523_7 then
							if arg_520_1.isInRecall_ then
								local var_523_16 = Mathf.Lerp(iter_523_7.color.r, arg_520_1.hightColor2.r, var_523_15)
								local var_523_17 = Mathf.Lerp(iter_523_7.color.g, arg_520_1.hightColor2.g, var_523_15)
								local var_523_18 = Mathf.Lerp(iter_523_7.color.b, arg_520_1.hightColor2.b, var_523_15)

								iter_523_7.color = Color.New(var_523_16, var_523_17, var_523_18)
							else
								local var_523_19 = Mathf.Lerp(iter_523_7.color.r, 0.5, var_523_15)

								iter_523_7.color = Color.New(var_523_19, var_523_19, var_523_19)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= var_523_13 + var_523_14 and arg_520_1.time_ < var_523_13 + var_523_14 + arg_523_0 and not isNil(var_523_12) and arg_520_1.var_.actorSpriteComps2078 then
				for iter_523_8, iter_523_9 in pairs(arg_520_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_523_9 then
						if arg_520_1.isInRecall_ then
							iter_523_9.color = arg_520_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_523_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_520_1.var_.actorSpriteComps2078 = nil
			end

			local var_523_20 = 0
			local var_523_21 = 0.7

			if var_523_20 < arg_520_1.time_ and arg_520_1.time_ <= var_523_20 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_22 = arg_520_1:FormatText(StoryNameCfg[1109].name)

				arg_520_1.leftNameTxt_.text = var_523_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_23 = arg_520_1:GetWordFromCfg(417101125)
				local var_523_24 = arg_520_1:FormatText(var_523_23.content)

				arg_520_1.text_.text = var_523_24

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_25 = 28
				local var_523_26 = utf8.len(var_523_24)
				local var_523_27 = var_523_25 <= 0 and var_523_21 or var_523_21 * (var_523_26 / var_523_25)

				if var_523_27 > 0 and var_523_21 < var_523_27 then
					arg_520_1.talkMaxDuration = var_523_27

					if var_523_27 + var_523_20 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_27 + var_523_20
					end
				end

				arg_520_1.text_.text = var_523_24
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101125", "story_v_out_417101.awb") ~= 0 then
					local var_523_28 = manager.audio:GetVoiceLength("story_v_out_417101", "417101125", "story_v_out_417101.awb") / 1000

					if var_523_28 + var_523_20 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_28 + var_523_20
					end

					if var_523_23.prefab_name ~= "" and arg_520_1.actors_[var_523_23.prefab_name] ~= nil then
						local var_523_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_23.prefab_name].transform, "story_v_out_417101", "417101125", "story_v_out_417101.awb")

						arg_520_1:RecordAudio("417101125", var_523_29)
						arg_520_1:RecordAudio("417101125", var_523_29)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_417101", "417101125", "story_v_out_417101.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_417101", "417101125", "story_v_out_417101.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_30 = math.max(var_523_21, arg_520_1.talkMaxDuration)

			if var_523_20 <= arg_520_1.time_ and arg_520_1.time_ < var_523_20 + var_523_30 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_20) / var_523_30

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_20 + var_523_30 and arg_520_1.time_ < var_523_20 + var_523_30 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play417101126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 417101126
		arg_524_1.duration_ = 2.83

		local var_524_0 = {
			zh = 2.233,
			ja = 2.833
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play417101127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["2078"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps2078 == nil then
				arg_524_1.var_.actorSpriteComps2078 = var_527_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_527_2 = 0.2

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.actorSpriteComps2078 then
					for iter_527_0, iter_527_1 in pairs(arg_524_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_527_1 then
							if arg_524_1.isInRecall_ then
								local var_527_4 = Mathf.Lerp(iter_527_1.color.r, arg_524_1.hightColor1.r, var_527_3)
								local var_527_5 = Mathf.Lerp(iter_527_1.color.g, arg_524_1.hightColor1.g, var_527_3)
								local var_527_6 = Mathf.Lerp(iter_527_1.color.b, arg_524_1.hightColor1.b, var_527_3)

								iter_527_1.color = Color.New(var_527_4, var_527_5, var_527_6)
							else
								local var_527_7 = Mathf.Lerp(iter_527_1.color.r, 1, var_527_3)

								iter_527_1.color = Color.New(var_527_7, var_527_7, var_527_7)
							end
						end
					end
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps2078 then
				for iter_527_2, iter_527_3 in pairs(arg_524_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_527_3 then
						if arg_524_1.isInRecall_ then
							iter_527_3.color = arg_524_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_527_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_524_1.var_.actorSpriteComps2078 = nil
			end

			local var_527_8 = arg_524_1.actors_["1034"]
			local var_527_9 = 0

			if var_527_9 < arg_524_1.time_ and arg_524_1.time_ <= var_527_9 + arg_527_0 and not isNil(var_527_8) and arg_524_1.var_.actorSpriteComps1034 == nil then
				arg_524_1.var_.actorSpriteComps1034 = var_527_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_527_10 = 0.2

			if var_527_9 <= arg_524_1.time_ and arg_524_1.time_ < var_527_9 + var_527_10 and not isNil(var_527_8) then
				local var_527_11 = (arg_524_1.time_ - var_527_9) / var_527_10

				if arg_524_1.var_.actorSpriteComps1034 then
					for iter_527_4, iter_527_5 in pairs(arg_524_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_527_5 then
							if arg_524_1.isInRecall_ then
								local var_527_12 = Mathf.Lerp(iter_527_5.color.r, arg_524_1.hightColor2.r, var_527_11)
								local var_527_13 = Mathf.Lerp(iter_527_5.color.g, arg_524_1.hightColor2.g, var_527_11)
								local var_527_14 = Mathf.Lerp(iter_527_5.color.b, arg_524_1.hightColor2.b, var_527_11)

								iter_527_5.color = Color.New(var_527_12, var_527_13, var_527_14)
							else
								local var_527_15 = Mathf.Lerp(iter_527_5.color.r, 0.5, var_527_11)

								iter_527_5.color = Color.New(var_527_15, var_527_15, var_527_15)
							end
						end
					end
				end
			end

			if arg_524_1.time_ >= var_527_9 + var_527_10 and arg_524_1.time_ < var_527_9 + var_527_10 + arg_527_0 and not isNil(var_527_8) and arg_524_1.var_.actorSpriteComps1034 then
				for iter_527_6, iter_527_7 in pairs(arg_524_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_527_7 then
						if arg_524_1.isInRecall_ then
							iter_527_7.color = arg_524_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_527_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_524_1.var_.actorSpriteComps1034 = nil
			end

			local var_527_16 = 0
			local var_527_17 = 0.225

			if var_527_16 < arg_524_1.time_ and arg_524_1.time_ <= var_527_16 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_18 = arg_524_1:FormatText(StoryNameCfg[1135].name)

				arg_524_1.leftNameTxt_.text = var_527_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_19 = arg_524_1:GetWordFromCfg(417101126)
				local var_527_20 = arg_524_1:FormatText(var_527_19.content)

				arg_524_1.text_.text = var_527_20

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_21 = 9
				local var_527_22 = utf8.len(var_527_20)
				local var_527_23 = var_527_21 <= 0 and var_527_17 or var_527_17 * (var_527_22 / var_527_21)

				if var_527_23 > 0 and var_527_17 < var_527_23 then
					arg_524_1.talkMaxDuration = var_527_23

					if var_527_23 + var_527_16 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_23 + var_527_16
					end
				end

				arg_524_1.text_.text = var_527_20
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101126", "story_v_out_417101.awb") ~= 0 then
					local var_527_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101126", "story_v_out_417101.awb") / 1000

					if var_527_24 + var_527_16 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_24 + var_527_16
					end

					if var_527_19.prefab_name ~= "" and arg_524_1.actors_[var_527_19.prefab_name] ~= nil then
						local var_527_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_19.prefab_name].transform, "story_v_out_417101", "417101126", "story_v_out_417101.awb")

						arg_524_1:RecordAudio("417101126", var_527_25)
						arg_524_1:RecordAudio("417101126", var_527_25)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_417101", "417101126", "story_v_out_417101.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_417101", "417101126", "story_v_out_417101.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_26 = math.max(var_527_17, arg_524_1.talkMaxDuration)

			if var_527_16 <= arg_524_1.time_ and arg_524_1.time_ < var_527_16 + var_527_26 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_16) / var_527_26

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_16 + var_527_26 and arg_524_1.time_ < var_527_16 + var_527_26 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play417101127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 417101127
		arg_528_1.duration_ = 6.67

		local var_528_0 = {
			zh = 4.6,
			ja = 6.666
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play417101128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.55

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[1135].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_3 = arg_528_1:GetWordFromCfg(417101127)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 22
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101127", "story_v_out_417101.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101127", "story_v_out_417101.awb") / 1000

					if var_531_8 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_0
					end

					if var_531_3.prefab_name ~= "" and arg_528_1.actors_[var_531_3.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_3.prefab_name].transform, "story_v_out_417101", "417101127", "story_v_out_417101.awb")

						arg_528_1:RecordAudio("417101127", var_531_9)
						arg_528_1:RecordAudio("417101127", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_417101", "417101127", "story_v_out_417101.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_417101", "417101127", "story_v_out_417101.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_10 and arg_528_1.time_ < var_531_0 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play417101128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 417101128
		arg_532_1.duration_ = 6.83

		local var_532_0 = {
			zh = 6.833,
			ja = 5.033
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play417101129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["1034"]
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps1034 == nil then
				arg_532_1.var_.actorSpriteComps1034 = var_535_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_535_2 = 0.2

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 and not isNil(var_535_0) then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2

				if arg_532_1.var_.actorSpriteComps1034 then
					for iter_535_0, iter_535_1 in pairs(arg_532_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_535_1 then
							if arg_532_1.isInRecall_ then
								local var_535_4 = Mathf.Lerp(iter_535_1.color.r, arg_532_1.hightColor1.r, var_535_3)
								local var_535_5 = Mathf.Lerp(iter_535_1.color.g, arg_532_1.hightColor1.g, var_535_3)
								local var_535_6 = Mathf.Lerp(iter_535_1.color.b, arg_532_1.hightColor1.b, var_535_3)

								iter_535_1.color = Color.New(var_535_4, var_535_5, var_535_6)
							else
								local var_535_7 = Mathf.Lerp(iter_535_1.color.r, 1, var_535_3)

								iter_535_1.color = Color.New(var_535_7, var_535_7, var_535_7)
							end
						end
					end
				end
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps1034 then
				for iter_535_2, iter_535_3 in pairs(arg_532_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_535_3 then
						if arg_532_1.isInRecall_ then
							iter_535_3.color = arg_532_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_535_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_532_1.var_.actorSpriteComps1034 = nil
			end

			local var_535_8 = arg_532_1.actors_["2078"]
			local var_535_9 = 0

			if var_535_9 < arg_532_1.time_ and arg_532_1.time_ <= var_535_9 + arg_535_0 and not isNil(var_535_8) and arg_532_1.var_.actorSpriteComps2078 == nil then
				arg_532_1.var_.actorSpriteComps2078 = var_535_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_535_10 = 0.2

			if var_535_9 <= arg_532_1.time_ and arg_532_1.time_ < var_535_9 + var_535_10 and not isNil(var_535_8) then
				local var_535_11 = (arg_532_1.time_ - var_535_9) / var_535_10

				if arg_532_1.var_.actorSpriteComps2078 then
					for iter_535_4, iter_535_5 in pairs(arg_532_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_535_5 then
							if arg_532_1.isInRecall_ then
								local var_535_12 = Mathf.Lerp(iter_535_5.color.r, arg_532_1.hightColor2.r, var_535_11)
								local var_535_13 = Mathf.Lerp(iter_535_5.color.g, arg_532_1.hightColor2.g, var_535_11)
								local var_535_14 = Mathf.Lerp(iter_535_5.color.b, arg_532_1.hightColor2.b, var_535_11)

								iter_535_5.color = Color.New(var_535_12, var_535_13, var_535_14)
							else
								local var_535_15 = Mathf.Lerp(iter_535_5.color.r, 0.5, var_535_11)

								iter_535_5.color = Color.New(var_535_15, var_535_15, var_535_15)
							end
						end
					end
				end
			end

			if arg_532_1.time_ >= var_535_9 + var_535_10 and arg_532_1.time_ < var_535_9 + var_535_10 + arg_535_0 and not isNil(var_535_8) and arg_532_1.var_.actorSpriteComps2078 then
				for iter_535_6, iter_535_7 in pairs(arg_532_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_535_7 then
						if arg_532_1.isInRecall_ then
							iter_535_7.color = arg_532_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_535_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_532_1.var_.actorSpriteComps2078 = nil
			end

			local var_535_16 = arg_532_1.actors_["1034"].transform
			local var_535_17 = 0

			if var_535_17 < arg_532_1.time_ and arg_532_1.time_ <= var_535_17 + arg_535_0 then
				arg_532_1.var_.moveOldPos1034 = var_535_16.localPosition
				var_535_16.localScale = Vector3.New(1, 1, 1)

				arg_532_1:CheckSpriteTmpPos("1034", 3)

				local var_535_18 = var_535_16.childCount

				for iter_535_8 = 0, var_535_18 - 1 do
					local var_535_19 = var_535_16:GetChild(iter_535_8)

					if var_535_19.name == "split_1" or not string.find(var_535_19.name, "split") then
						var_535_19.gameObject:SetActive(true)
					else
						var_535_19.gameObject:SetActive(false)
					end
				end
			end

			local var_535_20 = 0.001

			if var_535_17 <= arg_532_1.time_ and arg_532_1.time_ < var_535_17 + var_535_20 then
				local var_535_21 = (arg_532_1.time_ - var_535_17) / var_535_20
				local var_535_22 = Vector3.New(0, -331.9, -324)

				var_535_16.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1034, var_535_22, var_535_21)
			end

			if arg_532_1.time_ >= var_535_17 + var_535_20 and arg_532_1.time_ < var_535_17 + var_535_20 + arg_535_0 then
				var_535_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_535_23 = 0
			local var_535_24 = 0.75

			if var_535_23 < arg_532_1.time_ and arg_532_1.time_ <= var_535_23 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_25 = arg_532_1:FormatText(StoryNameCfg[1109].name)

				arg_532_1.leftNameTxt_.text = var_535_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_26 = arg_532_1:GetWordFromCfg(417101128)
				local var_535_27 = arg_532_1:FormatText(var_535_26.content)

				arg_532_1.text_.text = var_535_27

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_28 = 30
				local var_535_29 = utf8.len(var_535_27)
				local var_535_30 = var_535_28 <= 0 and var_535_24 or var_535_24 * (var_535_29 / var_535_28)

				if var_535_30 > 0 and var_535_24 < var_535_30 then
					arg_532_1.talkMaxDuration = var_535_30

					if var_535_30 + var_535_23 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_30 + var_535_23
					end
				end

				arg_532_1.text_.text = var_535_27
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101128", "story_v_out_417101.awb") ~= 0 then
					local var_535_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101128", "story_v_out_417101.awb") / 1000

					if var_535_31 + var_535_23 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_31 + var_535_23
					end

					if var_535_26.prefab_name ~= "" and arg_532_1.actors_[var_535_26.prefab_name] ~= nil then
						local var_535_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_26.prefab_name].transform, "story_v_out_417101", "417101128", "story_v_out_417101.awb")

						arg_532_1:RecordAudio("417101128", var_535_32)
						arg_532_1:RecordAudio("417101128", var_535_32)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_417101", "417101128", "story_v_out_417101.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_417101", "417101128", "story_v_out_417101.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_33 = math.max(var_535_24, arg_532_1.talkMaxDuration)

			if var_535_23 <= arg_532_1.time_ and arg_532_1.time_ < var_535_23 + var_535_33 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_23) / var_535_33

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_23 + var_535_33 and arg_532_1.time_ < var_535_23 + var_535_33 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
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

		arg_532_1:InitPlayNodeList()
	end,
	Play417101129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 417101129
		arg_536_1.duration_ = 9.83

		local var_536_0 = {
			zh = 3.666,
			ja = 9.833
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play417101130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1034"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps1034 == nil then
				arg_536_1.var_.actorSpriteComps1034 = var_539_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_539_2 = 0.2

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.actorSpriteComps1034 then
					for iter_539_0, iter_539_1 in pairs(arg_536_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_539_1 then
							if arg_536_1.isInRecall_ then
								local var_539_4 = Mathf.Lerp(iter_539_1.color.r, arg_536_1.hightColor2.r, var_539_3)
								local var_539_5 = Mathf.Lerp(iter_539_1.color.g, arg_536_1.hightColor2.g, var_539_3)
								local var_539_6 = Mathf.Lerp(iter_539_1.color.b, arg_536_1.hightColor2.b, var_539_3)

								iter_539_1.color = Color.New(var_539_4, var_539_5, var_539_6)
							else
								local var_539_7 = Mathf.Lerp(iter_539_1.color.r, 0.5, var_539_3)

								iter_539_1.color = Color.New(var_539_7, var_539_7, var_539_7)
							end
						end
					end
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps1034 then
				for iter_539_2, iter_539_3 in pairs(arg_536_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_539_3 then
						if arg_536_1.isInRecall_ then
							iter_539_3.color = arg_536_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_539_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_536_1.var_.actorSpriteComps1034 = nil
			end

			local var_539_8 = 0
			local var_539_9 = 0.425

			if var_539_8 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_10 = arg_536_1:FormatText(StoryNameCfg[1135].name)

				arg_536_1.leftNameTxt_.text = var_539_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_11 = arg_536_1:GetWordFromCfg(417101129)
				local var_539_12 = arg_536_1:FormatText(var_539_11.content)

				arg_536_1.text_.text = var_539_12

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_13 = 17
				local var_539_14 = utf8.len(var_539_12)
				local var_539_15 = var_539_13 <= 0 and var_539_9 or var_539_9 * (var_539_14 / var_539_13)

				if var_539_15 > 0 and var_539_9 < var_539_15 then
					arg_536_1.talkMaxDuration = var_539_15

					if var_539_15 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_15 + var_539_8
					end
				end

				arg_536_1.text_.text = var_539_12
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101129", "story_v_out_417101.awb") ~= 0 then
					local var_539_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101129", "story_v_out_417101.awb") / 1000

					if var_539_16 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_16 + var_539_8
					end

					if var_539_11.prefab_name ~= "" and arg_536_1.actors_[var_539_11.prefab_name] ~= nil then
						local var_539_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_11.prefab_name].transform, "story_v_out_417101", "417101129", "story_v_out_417101.awb")

						arg_536_1:RecordAudio("417101129", var_539_17)
						arg_536_1:RecordAudio("417101129", var_539_17)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_417101", "417101129", "story_v_out_417101.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_417101", "417101129", "story_v_out_417101.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_18 = math.max(var_539_9, arg_536_1.talkMaxDuration)

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_18 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_8) / var_539_18

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_8 + var_539_18 and arg_536_1.time_ < var_539_8 + var_539_18 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play417101130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 417101130
		arg_540_1.duration_ = 4.3

		local var_540_0 = {
			zh = 2.266,
			ja = 4.3
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play417101131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1034"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps1034 == nil then
				arg_540_1.var_.actorSpriteComps1034 = var_543_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_2 = 0.2

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.actorSpriteComps1034 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								local var_543_4 = Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor1.r, var_543_3)
								local var_543_5 = Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor1.g, var_543_3)
								local var_543_6 = Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor1.b, var_543_3)

								iter_543_1.color = Color.New(var_543_4, var_543_5, var_543_6)
							else
								local var_543_7 = Mathf.Lerp(iter_543_1.color.r, 1, var_543_3)

								iter_543_1.color = Color.New(var_543_7, var_543_7, var_543_7)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps1034 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_543_3 then
						if arg_540_1.isInRecall_ then
							iter_543_3.color = arg_540_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_543_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_540_1.var_.actorSpriteComps1034 = nil
			end

			local var_543_8 = arg_540_1.actors_["2078"]
			local var_543_9 = 0

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 and not isNil(var_543_8) and arg_540_1.var_.actorSpriteComps2078 == nil then
				arg_540_1.var_.actorSpriteComps2078 = var_543_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_10 = 0.2

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_10 and not isNil(var_543_8) then
				local var_543_11 = (arg_540_1.time_ - var_543_9) / var_543_10

				if arg_540_1.var_.actorSpriteComps2078 then
					for iter_543_4, iter_543_5 in pairs(arg_540_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_543_5 then
							if arg_540_1.isInRecall_ then
								local var_543_12 = Mathf.Lerp(iter_543_5.color.r, arg_540_1.hightColor2.r, var_543_11)
								local var_543_13 = Mathf.Lerp(iter_543_5.color.g, arg_540_1.hightColor2.g, var_543_11)
								local var_543_14 = Mathf.Lerp(iter_543_5.color.b, arg_540_1.hightColor2.b, var_543_11)

								iter_543_5.color = Color.New(var_543_12, var_543_13, var_543_14)
							else
								local var_543_15 = Mathf.Lerp(iter_543_5.color.r, 0.5, var_543_11)

								iter_543_5.color = Color.New(var_543_15, var_543_15, var_543_15)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= var_543_9 + var_543_10 and arg_540_1.time_ < var_543_9 + var_543_10 + arg_543_0 and not isNil(var_543_8) and arg_540_1.var_.actorSpriteComps2078 then
				for iter_543_6, iter_543_7 in pairs(arg_540_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_543_7 then
						if arg_540_1.isInRecall_ then
							iter_543_7.color = arg_540_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_543_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_540_1.var_.actorSpriteComps2078 = nil
			end

			local var_543_16 = arg_540_1.actors_["1034"].transform
			local var_543_17 = 0

			if var_543_17 < arg_540_1.time_ and arg_540_1.time_ <= var_543_17 + arg_543_0 then
				arg_540_1.var_.moveOldPos1034 = var_543_16.localPosition
				var_543_16.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("1034", 3)

				local var_543_18 = var_543_16.childCount

				for iter_543_8 = 0, var_543_18 - 1 do
					local var_543_19 = var_543_16:GetChild(iter_543_8)

					if var_543_19.name == "split_1" or not string.find(var_543_19.name, "split") then
						var_543_19.gameObject:SetActive(true)
					else
						var_543_19.gameObject:SetActive(false)
					end
				end
			end

			local var_543_20 = 0.001

			if var_543_17 <= arg_540_1.time_ and arg_540_1.time_ < var_543_17 + var_543_20 then
				local var_543_21 = (arg_540_1.time_ - var_543_17) / var_543_20
				local var_543_22 = Vector3.New(0, -331.9, -324)

				var_543_16.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1034, var_543_22, var_543_21)
			end

			if arg_540_1.time_ >= var_543_17 + var_543_20 and arg_540_1.time_ < var_543_17 + var_543_20 + arg_543_0 then
				var_543_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_543_23 = 0
			local var_543_24 = 0.25

			if var_543_23 < arg_540_1.time_ and arg_540_1.time_ <= var_543_23 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_25 = arg_540_1:FormatText(StoryNameCfg[1109].name)

				arg_540_1.leftNameTxt_.text = var_543_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_26 = arg_540_1:GetWordFromCfg(417101130)
				local var_543_27 = arg_540_1:FormatText(var_543_26.content)

				arg_540_1.text_.text = var_543_27

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_28 = 10
				local var_543_29 = utf8.len(var_543_27)
				local var_543_30 = var_543_28 <= 0 and var_543_24 or var_543_24 * (var_543_29 / var_543_28)

				if var_543_30 > 0 and var_543_24 < var_543_30 then
					arg_540_1.talkMaxDuration = var_543_30

					if var_543_30 + var_543_23 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_30 + var_543_23
					end
				end

				arg_540_1.text_.text = var_543_27
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101130", "story_v_out_417101.awb") ~= 0 then
					local var_543_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101130", "story_v_out_417101.awb") / 1000

					if var_543_31 + var_543_23 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_31 + var_543_23
					end

					if var_543_26.prefab_name ~= "" and arg_540_1.actors_[var_543_26.prefab_name] ~= nil then
						local var_543_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_26.prefab_name].transform, "story_v_out_417101", "417101130", "story_v_out_417101.awb")

						arg_540_1:RecordAudio("417101130", var_543_32)
						arg_540_1:RecordAudio("417101130", var_543_32)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_417101", "417101130", "story_v_out_417101.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_417101", "417101130", "story_v_out_417101.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_33 = math.max(var_543_24, arg_540_1.talkMaxDuration)

			if var_543_23 <= arg_540_1.time_ and arg_540_1.time_ < var_543_23 + var_543_33 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_23) / var_543_33

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_23 + var_543_33 and arg_540_1.time_ < var_543_23 + var_543_33 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play417101131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 417101131
		arg_544_1.duration_ = 8.93

		local var_544_0 = {
			zh = 8.3,
			ja = 8.933
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play417101132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["2078"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.actorSpriteComps2078 == nil then
				arg_544_1.var_.actorSpriteComps2078 = var_547_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_547_2 = 0.2

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.actorSpriteComps2078 then
					for iter_547_0, iter_547_1 in pairs(arg_544_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_547_1 then
							if arg_544_1.isInRecall_ then
								local var_547_4 = Mathf.Lerp(iter_547_1.color.r, arg_544_1.hightColor1.r, var_547_3)
								local var_547_5 = Mathf.Lerp(iter_547_1.color.g, arg_544_1.hightColor1.g, var_547_3)
								local var_547_6 = Mathf.Lerp(iter_547_1.color.b, arg_544_1.hightColor1.b, var_547_3)

								iter_547_1.color = Color.New(var_547_4, var_547_5, var_547_6)
							else
								local var_547_7 = Mathf.Lerp(iter_547_1.color.r, 1, var_547_3)

								iter_547_1.color = Color.New(var_547_7, var_547_7, var_547_7)
							end
						end
					end
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.actorSpriteComps2078 then
				for iter_547_2, iter_547_3 in pairs(arg_544_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_547_3 then
						if arg_544_1.isInRecall_ then
							iter_547_3.color = arg_544_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_547_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_544_1.var_.actorSpriteComps2078 = nil
			end

			local var_547_8 = arg_544_1.actors_["1034"]
			local var_547_9 = 0

			if var_547_9 < arg_544_1.time_ and arg_544_1.time_ <= var_547_9 + arg_547_0 and not isNil(var_547_8) and arg_544_1.var_.actorSpriteComps1034 == nil then
				arg_544_1.var_.actorSpriteComps1034 = var_547_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_547_10 = 0.2

			if var_547_9 <= arg_544_1.time_ and arg_544_1.time_ < var_547_9 + var_547_10 and not isNil(var_547_8) then
				local var_547_11 = (arg_544_1.time_ - var_547_9) / var_547_10

				if arg_544_1.var_.actorSpriteComps1034 then
					for iter_547_4, iter_547_5 in pairs(arg_544_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_547_5 then
							if arg_544_1.isInRecall_ then
								local var_547_12 = Mathf.Lerp(iter_547_5.color.r, arg_544_1.hightColor2.r, var_547_11)
								local var_547_13 = Mathf.Lerp(iter_547_5.color.g, arg_544_1.hightColor2.g, var_547_11)
								local var_547_14 = Mathf.Lerp(iter_547_5.color.b, arg_544_1.hightColor2.b, var_547_11)

								iter_547_5.color = Color.New(var_547_12, var_547_13, var_547_14)
							else
								local var_547_15 = Mathf.Lerp(iter_547_5.color.r, 0.5, var_547_11)

								iter_547_5.color = Color.New(var_547_15, var_547_15, var_547_15)
							end
						end
					end
				end
			end

			if arg_544_1.time_ >= var_547_9 + var_547_10 and arg_544_1.time_ < var_547_9 + var_547_10 + arg_547_0 and not isNil(var_547_8) and arg_544_1.var_.actorSpriteComps1034 then
				for iter_547_6, iter_547_7 in pairs(arg_544_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_547_7 then
						if arg_544_1.isInRecall_ then
							iter_547_7.color = arg_544_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_547_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_544_1.var_.actorSpriteComps1034 = nil
			end

			local var_547_16 = 0
			local var_547_17 = 0.975

			if var_547_16 < arg_544_1.time_ and arg_544_1.time_ <= var_547_16 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_18 = arg_544_1:FormatText(StoryNameCfg[1135].name)

				arg_544_1.leftNameTxt_.text = var_547_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_19 = arg_544_1:GetWordFromCfg(417101131)
				local var_547_20 = arg_544_1:FormatText(var_547_19.content)

				arg_544_1.text_.text = var_547_20

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_21 = 39
				local var_547_22 = utf8.len(var_547_20)
				local var_547_23 = var_547_21 <= 0 and var_547_17 or var_547_17 * (var_547_22 / var_547_21)

				if var_547_23 > 0 and var_547_17 < var_547_23 then
					arg_544_1.talkMaxDuration = var_547_23

					if var_547_23 + var_547_16 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_23 + var_547_16
					end
				end

				arg_544_1.text_.text = var_547_20
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101131", "story_v_out_417101.awb") ~= 0 then
					local var_547_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101131", "story_v_out_417101.awb") / 1000

					if var_547_24 + var_547_16 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_24 + var_547_16
					end

					if var_547_19.prefab_name ~= "" and arg_544_1.actors_[var_547_19.prefab_name] ~= nil then
						local var_547_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_19.prefab_name].transform, "story_v_out_417101", "417101131", "story_v_out_417101.awb")

						arg_544_1:RecordAudio("417101131", var_547_25)
						arg_544_1:RecordAudio("417101131", var_547_25)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_417101", "417101131", "story_v_out_417101.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_417101", "417101131", "story_v_out_417101.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_26 = math.max(var_547_17, arg_544_1.talkMaxDuration)

			if var_547_16 <= arg_544_1.time_ and arg_544_1.time_ < var_547_16 + var_547_26 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_16) / var_547_26

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_16 + var_547_26 and arg_544_1.time_ < var_547_16 + var_547_26 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play417101132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 417101132
		arg_548_1.duration_ = 10.3

		local var_548_0 = {
			zh = 10.3,
			ja = 8.833
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play417101133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1034"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps1034 == nil then
				arg_548_1.var_.actorSpriteComps1034 = var_551_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_2 = 0.2

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.actorSpriteComps1034 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								local var_551_4 = Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor1.r, var_551_3)
								local var_551_5 = Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor1.g, var_551_3)
								local var_551_6 = Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor1.b, var_551_3)

								iter_551_1.color = Color.New(var_551_4, var_551_5, var_551_6)
							else
								local var_551_7 = Mathf.Lerp(iter_551_1.color.r, 1, var_551_3)

								iter_551_1.color = Color.New(var_551_7, var_551_7, var_551_7)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps1034 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_551_3 then
						if arg_548_1.isInRecall_ then
							iter_551_3.color = arg_548_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_551_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_548_1.var_.actorSpriteComps1034 = nil
			end

			local var_551_8 = arg_548_1.actors_["2078"]
			local var_551_9 = 0

			if var_551_9 < arg_548_1.time_ and arg_548_1.time_ <= var_551_9 + arg_551_0 and not isNil(var_551_8) and arg_548_1.var_.actorSpriteComps2078 == nil then
				arg_548_1.var_.actorSpriteComps2078 = var_551_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_10 = 0.2

			if var_551_9 <= arg_548_1.time_ and arg_548_1.time_ < var_551_9 + var_551_10 and not isNil(var_551_8) then
				local var_551_11 = (arg_548_1.time_ - var_551_9) / var_551_10

				if arg_548_1.var_.actorSpriteComps2078 then
					for iter_551_4, iter_551_5 in pairs(arg_548_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_551_5 then
							if arg_548_1.isInRecall_ then
								local var_551_12 = Mathf.Lerp(iter_551_5.color.r, arg_548_1.hightColor2.r, var_551_11)
								local var_551_13 = Mathf.Lerp(iter_551_5.color.g, arg_548_1.hightColor2.g, var_551_11)
								local var_551_14 = Mathf.Lerp(iter_551_5.color.b, arg_548_1.hightColor2.b, var_551_11)

								iter_551_5.color = Color.New(var_551_12, var_551_13, var_551_14)
							else
								local var_551_15 = Mathf.Lerp(iter_551_5.color.r, 0.5, var_551_11)

								iter_551_5.color = Color.New(var_551_15, var_551_15, var_551_15)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= var_551_9 + var_551_10 and arg_548_1.time_ < var_551_9 + var_551_10 + arg_551_0 and not isNil(var_551_8) and arg_548_1.var_.actorSpriteComps2078 then
				for iter_551_6, iter_551_7 in pairs(arg_548_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_551_7 then
						if arg_548_1.isInRecall_ then
							iter_551_7.color = arg_548_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_551_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_548_1.var_.actorSpriteComps2078 = nil
			end

			local var_551_16 = arg_548_1.actors_["1034"].transform
			local var_551_17 = 0

			if var_551_17 < arg_548_1.time_ and arg_548_1.time_ <= var_551_17 + arg_551_0 then
				arg_548_1.var_.moveOldPos1034 = var_551_16.localPosition
				var_551_16.localScale = Vector3.New(1, 1, 1)

				arg_548_1:CheckSpriteTmpPos("1034", 3)

				local var_551_18 = var_551_16.childCount

				for iter_551_8 = 0, var_551_18 - 1 do
					local var_551_19 = var_551_16:GetChild(iter_551_8)

					if var_551_19.name == "split_7" or not string.find(var_551_19.name, "split") then
						var_551_19.gameObject:SetActive(true)
					else
						var_551_19.gameObject:SetActive(false)
					end
				end
			end

			local var_551_20 = 0.001

			if var_551_17 <= arg_548_1.time_ and arg_548_1.time_ < var_551_17 + var_551_20 then
				local var_551_21 = (arg_548_1.time_ - var_551_17) / var_551_20
				local var_551_22 = Vector3.New(0, -331.9, -324)

				var_551_16.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1034, var_551_22, var_551_21)
			end

			if arg_548_1.time_ >= var_551_17 + var_551_20 and arg_548_1.time_ < var_551_17 + var_551_20 + arg_551_0 then
				var_551_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_551_23 = 0
			local var_551_24 = 1.125

			if var_551_23 < arg_548_1.time_ and arg_548_1.time_ <= var_551_23 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_25 = arg_548_1:FormatText(StoryNameCfg[1109].name)

				arg_548_1.leftNameTxt_.text = var_551_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_26 = arg_548_1:GetWordFromCfg(417101132)
				local var_551_27 = arg_548_1:FormatText(var_551_26.content)

				arg_548_1.text_.text = var_551_27

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_28 = 45
				local var_551_29 = utf8.len(var_551_27)
				local var_551_30 = var_551_28 <= 0 and var_551_24 or var_551_24 * (var_551_29 / var_551_28)

				if var_551_30 > 0 and var_551_24 < var_551_30 then
					arg_548_1.talkMaxDuration = var_551_30

					if var_551_30 + var_551_23 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_30 + var_551_23
					end
				end

				arg_548_1.text_.text = var_551_27
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101132", "story_v_out_417101.awb") ~= 0 then
					local var_551_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101132", "story_v_out_417101.awb") / 1000

					if var_551_31 + var_551_23 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_31 + var_551_23
					end

					if var_551_26.prefab_name ~= "" and arg_548_1.actors_[var_551_26.prefab_name] ~= nil then
						local var_551_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_26.prefab_name].transform, "story_v_out_417101", "417101132", "story_v_out_417101.awb")

						arg_548_1:RecordAudio("417101132", var_551_32)
						arg_548_1:RecordAudio("417101132", var_551_32)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_417101", "417101132", "story_v_out_417101.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_417101", "417101132", "story_v_out_417101.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_33 = math.max(var_551_24, arg_548_1.talkMaxDuration)

			if var_551_23 <= arg_548_1.time_ and arg_548_1.time_ < var_551_23 + var_551_33 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_23) / var_551_33

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_23 + var_551_33 and arg_548_1.time_ < var_551_23 + var_551_33 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
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

		arg_548_1:InitPlayNodeList()
	end,
	Play417101133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 417101133
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play417101134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1034"]
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.actorSpriteComps1034 == nil then
				arg_552_1.var_.actorSpriteComps1034 = var_555_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_555_2 = 0.2

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 and not isNil(var_555_0) then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2

				if arg_552_1.var_.actorSpriteComps1034 then
					for iter_555_0, iter_555_1 in pairs(arg_552_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_555_1 then
							if arg_552_1.isInRecall_ then
								local var_555_4 = Mathf.Lerp(iter_555_1.color.r, arg_552_1.hightColor2.r, var_555_3)
								local var_555_5 = Mathf.Lerp(iter_555_1.color.g, arg_552_1.hightColor2.g, var_555_3)
								local var_555_6 = Mathf.Lerp(iter_555_1.color.b, arg_552_1.hightColor2.b, var_555_3)

								iter_555_1.color = Color.New(var_555_4, var_555_5, var_555_6)
							else
								local var_555_7 = Mathf.Lerp(iter_555_1.color.r, 0.5, var_555_3)

								iter_555_1.color = Color.New(var_555_7, var_555_7, var_555_7)
							end
						end
					end
				end
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.actorSpriteComps1034 then
				for iter_555_2, iter_555_3 in pairs(arg_552_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_555_3 then
						if arg_552_1.isInRecall_ then
							iter_555_3.color = arg_552_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_555_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_552_1.var_.actorSpriteComps1034 = nil
			end

			local var_555_8 = 0
			local var_555_9 = 0.55

			if var_555_8 < arg_552_1.time_ and arg_552_1.time_ <= var_555_8 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, false)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_10 = arg_552_1:GetWordFromCfg(417101133)
				local var_555_11 = arg_552_1:FormatText(var_555_10.content)

				arg_552_1.text_.text = var_555_11

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_12 = 22
				local var_555_13 = utf8.len(var_555_11)
				local var_555_14 = var_555_12 <= 0 and var_555_9 or var_555_9 * (var_555_13 / var_555_12)

				if var_555_14 > 0 and var_555_9 < var_555_14 then
					arg_552_1.talkMaxDuration = var_555_14

					if var_555_14 + var_555_8 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_14 + var_555_8
					end
				end

				arg_552_1.text_.text = var_555_11
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_15 = math.max(var_555_9, arg_552_1.talkMaxDuration)

			if var_555_8 <= arg_552_1.time_ and arg_552_1.time_ < var_555_8 + var_555_15 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_8) / var_555_15

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_8 + var_555_15 and arg_552_1.time_ < var_555_8 + var_555_15 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play417101134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 417101134
		arg_556_1.duration_ = 5.2

		local var_556_0 = {
			zh = 3.033,
			ja = 5.2
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play417101135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["2078"]
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.actorSpriteComps2078 == nil then
				arg_556_1.var_.actorSpriteComps2078 = var_559_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_2 = 0.2

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 and not isNil(var_559_0) then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2

				if arg_556_1.var_.actorSpriteComps2078 then
					for iter_559_0, iter_559_1 in pairs(arg_556_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_559_1 then
							if arg_556_1.isInRecall_ then
								local var_559_4 = Mathf.Lerp(iter_559_1.color.r, arg_556_1.hightColor1.r, var_559_3)
								local var_559_5 = Mathf.Lerp(iter_559_1.color.g, arg_556_1.hightColor1.g, var_559_3)
								local var_559_6 = Mathf.Lerp(iter_559_1.color.b, arg_556_1.hightColor1.b, var_559_3)

								iter_559_1.color = Color.New(var_559_4, var_559_5, var_559_6)
							else
								local var_559_7 = Mathf.Lerp(iter_559_1.color.r, 1, var_559_3)

								iter_559_1.color = Color.New(var_559_7, var_559_7, var_559_7)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.actorSpriteComps2078 then
				for iter_559_2, iter_559_3 in pairs(arg_556_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_559_3 then
						if arg_556_1.isInRecall_ then
							iter_559_3.color = arg_556_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_559_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_556_1.var_.actorSpriteComps2078 = nil
			end

			local var_559_8 = 0
			local var_559_9 = 0.4

			if var_559_8 < arg_556_1.time_ and arg_556_1.time_ <= var_559_8 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_10 = arg_556_1:FormatText(StoryNameCfg[1135].name)

				arg_556_1.leftNameTxt_.text = var_559_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_11 = arg_556_1:GetWordFromCfg(417101134)
				local var_559_12 = arg_556_1:FormatText(var_559_11.content)

				arg_556_1.text_.text = var_559_12

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_13 = 16
				local var_559_14 = utf8.len(var_559_12)
				local var_559_15 = var_559_13 <= 0 and var_559_9 or var_559_9 * (var_559_14 / var_559_13)

				if var_559_15 > 0 and var_559_9 < var_559_15 then
					arg_556_1.talkMaxDuration = var_559_15

					if var_559_15 + var_559_8 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_15 + var_559_8
					end
				end

				arg_556_1.text_.text = var_559_12
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101134", "story_v_out_417101.awb") ~= 0 then
					local var_559_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101134", "story_v_out_417101.awb") / 1000

					if var_559_16 + var_559_8 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_16 + var_559_8
					end

					if var_559_11.prefab_name ~= "" and arg_556_1.actors_[var_559_11.prefab_name] ~= nil then
						local var_559_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_11.prefab_name].transform, "story_v_out_417101", "417101134", "story_v_out_417101.awb")

						arg_556_1:RecordAudio("417101134", var_559_17)
						arg_556_1:RecordAudio("417101134", var_559_17)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_417101", "417101134", "story_v_out_417101.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_417101", "417101134", "story_v_out_417101.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_18 = math.max(var_559_9, arg_556_1.talkMaxDuration)

			if var_559_8 <= arg_556_1.time_ and arg_556_1.time_ < var_559_8 + var_559_18 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_8) / var_559_18

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_8 + var_559_18 and arg_556_1.time_ < var_559_8 + var_559_18 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play417101135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 417101135
		arg_560_1.duration_ = 6.3

		local var_560_0 = {
			zh = 2.866,
			ja = 6.3
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play417101136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1034"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps1034 == nil then
				arg_560_1.var_.actorSpriteComps1034 = var_563_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_2 = 0.2

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.actorSpriteComps1034 then
					for iter_563_0, iter_563_1 in pairs(arg_560_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_563_1 then
							if arg_560_1.isInRecall_ then
								local var_563_4 = Mathf.Lerp(iter_563_1.color.r, arg_560_1.hightColor1.r, var_563_3)
								local var_563_5 = Mathf.Lerp(iter_563_1.color.g, arg_560_1.hightColor1.g, var_563_3)
								local var_563_6 = Mathf.Lerp(iter_563_1.color.b, arg_560_1.hightColor1.b, var_563_3)

								iter_563_1.color = Color.New(var_563_4, var_563_5, var_563_6)
							else
								local var_563_7 = Mathf.Lerp(iter_563_1.color.r, 1, var_563_3)

								iter_563_1.color = Color.New(var_563_7, var_563_7, var_563_7)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps1034 then
				for iter_563_2, iter_563_3 in pairs(arg_560_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_563_3 then
						if arg_560_1.isInRecall_ then
							iter_563_3.color = arg_560_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_563_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_560_1.var_.actorSpriteComps1034 = nil
			end

			local var_563_8 = arg_560_1.actors_["2078"]
			local var_563_9 = 0

			if var_563_9 < arg_560_1.time_ and arg_560_1.time_ <= var_563_9 + arg_563_0 and not isNil(var_563_8) and arg_560_1.var_.actorSpriteComps2078 == nil then
				arg_560_1.var_.actorSpriteComps2078 = var_563_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_10 = 0.2

			if var_563_9 <= arg_560_1.time_ and arg_560_1.time_ < var_563_9 + var_563_10 and not isNil(var_563_8) then
				local var_563_11 = (arg_560_1.time_ - var_563_9) / var_563_10

				if arg_560_1.var_.actorSpriteComps2078 then
					for iter_563_4, iter_563_5 in pairs(arg_560_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_563_5 then
							if arg_560_1.isInRecall_ then
								local var_563_12 = Mathf.Lerp(iter_563_5.color.r, arg_560_1.hightColor2.r, var_563_11)
								local var_563_13 = Mathf.Lerp(iter_563_5.color.g, arg_560_1.hightColor2.g, var_563_11)
								local var_563_14 = Mathf.Lerp(iter_563_5.color.b, arg_560_1.hightColor2.b, var_563_11)

								iter_563_5.color = Color.New(var_563_12, var_563_13, var_563_14)
							else
								local var_563_15 = Mathf.Lerp(iter_563_5.color.r, 0.5, var_563_11)

								iter_563_5.color = Color.New(var_563_15, var_563_15, var_563_15)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= var_563_9 + var_563_10 and arg_560_1.time_ < var_563_9 + var_563_10 + arg_563_0 and not isNil(var_563_8) and arg_560_1.var_.actorSpriteComps2078 then
				for iter_563_6, iter_563_7 in pairs(arg_560_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_563_7 then
						if arg_560_1.isInRecall_ then
							iter_563_7.color = arg_560_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_563_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_560_1.var_.actorSpriteComps2078 = nil
			end

			local var_563_16 = arg_560_1.actors_["1034"].transform
			local var_563_17 = 0

			if var_563_17 < arg_560_1.time_ and arg_560_1.time_ <= var_563_17 + arg_563_0 then
				arg_560_1.var_.moveOldPos1034 = var_563_16.localPosition
				var_563_16.localScale = Vector3.New(1, 1, 1)

				arg_560_1:CheckSpriteTmpPos("1034", 3)

				local var_563_18 = var_563_16.childCount

				for iter_563_8 = 0, var_563_18 - 1 do
					local var_563_19 = var_563_16:GetChild(iter_563_8)

					if var_563_19.name == "" or not string.find(var_563_19.name, "split") then
						var_563_19.gameObject:SetActive(true)
					else
						var_563_19.gameObject:SetActive(false)
					end
				end
			end

			local var_563_20 = 0.001

			if var_563_17 <= arg_560_1.time_ and arg_560_1.time_ < var_563_17 + var_563_20 then
				local var_563_21 = (arg_560_1.time_ - var_563_17) / var_563_20
				local var_563_22 = Vector3.New(0, -331.9, -324)

				var_563_16.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos1034, var_563_22, var_563_21)
			end

			if arg_560_1.time_ >= var_563_17 + var_563_20 and arg_560_1.time_ < var_563_17 + var_563_20 + arg_563_0 then
				var_563_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_563_23 = 0
			local var_563_24 = 0.425

			if var_563_23 < arg_560_1.time_ and arg_560_1.time_ <= var_563_23 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_25 = arg_560_1:FormatText(StoryNameCfg[1109].name)

				arg_560_1.leftNameTxt_.text = var_563_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_26 = arg_560_1:GetWordFromCfg(417101135)
				local var_563_27 = arg_560_1:FormatText(var_563_26.content)

				arg_560_1.text_.text = var_563_27

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_28 = 17
				local var_563_29 = utf8.len(var_563_27)
				local var_563_30 = var_563_28 <= 0 and var_563_24 or var_563_24 * (var_563_29 / var_563_28)

				if var_563_30 > 0 and var_563_24 < var_563_30 then
					arg_560_1.talkMaxDuration = var_563_30

					if var_563_30 + var_563_23 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_30 + var_563_23
					end
				end

				arg_560_1.text_.text = var_563_27
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101135", "story_v_out_417101.awb") ~= 0 then
					local var_563_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101135", "story_v_out_417101.awb") / 1000

					if var_563_31 + var_563_23 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_31 + var_563_23
					end

					if var_563_26.prefab_name ~= "" and arg_560_1.actors_[var_563_26.prefab_name] ~= nil then
						local var_563_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_26.prefab_name].transform, "story_v_out_417101", "417101135", "story_v_out_417101.awb")

						arg_560_1:RecordAudio("417101135", var_563_32)
						arg_560_1:RecordAudio("417101135", var_563_32)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_417101", "417101135", "story_v_out_417101.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_417101", "417101135", "story_v_out_417101.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_33 = math.max(var_563_24, arg_560_1.talkMaxDuration)

			if var_563_23 <= arg_560_1.time_ and arg_560_1.time_ < var_563_23 + var_563_33 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_23) / var_563_33

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_23 + var_563_33 and arg_560_1.time_ < var_563_23 + var_563_33 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
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

		arg_560_1:InitPlayNodeList()
	end,
	Play417101136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 417101136
		arg_564_1.duration_ = 14.3

		local var_564_0 = {
			zh = 6.866,
			ja = 14.3
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play417101137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["2078"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps2078 == nil then
				arg_564_1.var_.actorSpriteComps2078 = var_567_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_2 = 0.2

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.actorSpriteComps2078 then
					for iter_567_0, iter_567_1 in pairs(arg_564_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_567_1 then
							if arg_564_1.isInRecall_ then
								local var_567_4 = Mathf.Lerp(iter_567_1.color.r, arg_564_1.hightColor1.r, var_567_3)
								local var_567_5 = Mathf.Lerp(iter_567_1.color.g, arg_564_1.hightColor1.g, var_567_3)
								local var_567_6 = Mathf.Lerp(iter_567_1.color.b, arg_564_1.hightColor1.b, var_567_3)

								iter_567_1.color = Color.New(var_567_4, var_567_5, var_567_6)
							else
								local var_567_7 = Mathf.Lerp(iter_567_1.color.r, 1, var_567_3)

								iter_567_1.color = Color.New(var_567_7, var_567_7, var_567_7)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps2078 then
				for iter_567_2, iter_567_3 in pairs(arg_564_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_567_3 then
						if arg_564_1.isInRecall_ then
							iter_567_3.color = arg_564_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_567_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_564_1.var_.actorSpriteComps2078 = nil
			end

			local var_567_8 = arg_564_1.actors_["1034"]
			local var_567_9 = 0

			if var_567_9 < arg_564_1.time_ and arg_564_1.time_ <= var_567_9 + arg_567_0 and not isNil(var_567_8) and arg_564_1.var_.actorSpriteComps1034 == nil then
				arg_564_1.var_.actorSpriteComps1034 = var_567_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_10 = 0.2

			if var_567_9 <= arg_564_1.time_ and arg_564_1.time_ < var_567_9 + var_567_10 and not isNil(var_567_8) then
				local var_567_11 = (arg_564_1.time_ - var_567_9) / var_567_10

				if arg_564_1.var_.actorSpriteComps1034 then
					for iter_567_4, iter_567_5 in pairs(arg_564_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_567_5 then
							if arg_564_1.isInRecall_ then
								local var_567_12 = Mathf.Lerp(iter_567_5.color.r, arg_564_1.hightColor2.r, var_567_11)
								local var_567_13 = Mathf.Lerp(iter_567_5.color.g, arg_564_1.hightColor2.g, var_567_11)
								local var_567_14 = Mathf.Lerp(iter_567_5.color.b, arg_564_1.hightColor2.b, var_567_11)

								iter_567_5.color = Color.New(var_567_12, var_567_13, var_567_14)
							else
								local var_567_15 = Mathf.Lerp(iter_567_5.color.r, 0.5, var_567_11)

								iter_567_5.color = Color.New(var_567_15, var_567_15, var_567_15)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= var_567_9 + var_567_10 and arg_564_1.time_ < var_567_9 + var_567_10 + arg_567_0 and not isNil(var_567_8) and arg_564_1.var_.actorSpriteComps1034 then
				for iter_567_6, iter_567_7 in pairs(arg_564_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_567_7 then
						if arg_564_1.isInRecall_ then
							iter_567_7.color = arg_564_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_567_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_564_1.var_.actorSpriteComps1034 = nil
			end

			local var_567_16 = 0
			local var_567_17 = 1.025

			if var_567_16 < arg_564_1.time_ and arg_564_1.time_ <= var_567_16 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_18 = arg_564_1:FormatText(StoryNameCfg[1135].name)

				arg_564_1.leftNameTxt_.text = var_567_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_19 = arg_564_1:GetWordFromCfg(417101136)
				local var_567_20 = arg_564_1:FormatText(var_567_19.content)

				arg_564_1.text_.text = var_567_20

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_21 = 41
				local var_567_22 = utf8.len(var_567_20)
				local var_567_23 = var_567_21 <= 0 and var_567_17 or var_567_17 * (var_567_22 / var_567_21)

				if var_567_23 > 0 and var_567_17 < var_567_23 then
					arg_564_1.talkMaxDuration = var_567_23

					if var_567_23 + var_567_16 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_23 + var_567_16
					end
				end

				arg_564_1.text_.text = var_567_20
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101136", "story_v_out_417101.awb") ~= 0 then
					local var_567_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101136", "story_v_out_417101.awb") / 1000

					if var_567_24 + var_567_16 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_24 + var_567_16
					end

					if var_567_19.prefab_name ~= "" and arg_564_1.actors_[var_567_19.prefab_name] ~= nil then
						local var_567_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_19.prefab_name].transform, "story_v_out_417101", "417101136", "story_v_out_417101.awb")

						arg_564_1:RecordAudio("417101136", var_567_25)
						arg_564_1:RecordAudio("417101136", var_567_25)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_417101", "417101136", "story_v_out_417101.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_417101", "417101136", "story_v_out_417101.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_26 = math.max(var_567_17, arg_564_1.talkMaxDuration)

			if var_567_16 <= arg_564_1.time_ and arg_564_1.time_ < var_567_16 + var_567_26 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_16) / var_567_26

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_16 + var_567_26 and arg_564_1.time_ < var_567_16 + var_567_26 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play417101137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 417101137
		arg_568_1.duration_ = 4.77

		local var_568_0 = {
			zh = 4.6,
			ja = 4.766
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play417101138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 0.55

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_2 = arg_568_1:FormatText(StoryNameCfg[1135].name)

				arg_568_1.leftNameTxt_.text = var_571_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_3 = arg_568_1:GetWordFromCfg(417101137)
				local var_571_4 = arg_568_1:FormatText(var_571_3.content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 22
				local var_571_6 = utf8.len(var_571_4)
				local var_571_7 = var_571_5 <= 0 and var_571_1 or var_571_1 * (var_571_6 / var_571_5)

				if var_571_7 > 0 and var_571_1 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101137", "story_v_out_417101.awb") ~= 0 then
					local var_571_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101137", "story_v_out_417101.awb") / 1000

					if var_571_8 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_8 + var_571_0
					end

					if var_571_3.prefab_name ~= "" and arg_568_1.actors_[var_571_3.prefab_name] ~= nil then
						local var_571_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_3.prefab_name].transform, "story_v_out_417101", "417101137", "story_v_out_417101.awb")

						arg_568_1:RecordAudio("417101137", var_571_9)
						arg_568_1:RecordAudio("417101137", var_571_9)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_417101", "417101137", "story_v_out_417101.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_417101", "417101137", "story_v_out_417101.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_10 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_10 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_10

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_10 and arg_568_1.time_ < var_571_0 + var_571_10 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play417101138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 417101138
		arg_572_1.duration_ = 1.4

		local var_572_0 = {
			zh = 0.999999999999,
			ja = 1.4
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play417101139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["1034"]
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps1034 == nil then
				arg_572_1.var_.actorSpriteComps1034 = var_575_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_2 = 0.2

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 and not isNil(var_575_0) then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2

				if arg_572_1.var_.actorSpriteComps1034 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								local var_575_4 = Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor1.r, var_575_3)
								local var_575_5 = Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor1.g, var_575_3)
								local var_575_6 = Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor1.b, var_575_3)

								iter_575_1.color = Color.New(var_575_4, var_575_5, var_575_6)
							else
								local var_575_7 = Mathf.Lerp(iter_575_1.color.r, 1, var_575_3)

								iter_575_1.color = Color.New(var_575_7, var_575_7, var_575_7)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps1034 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_575_3 then
						if arg_572_1.isInRecall_ then
							iter_575_3.color = arg_572_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_575_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_572_1.var_.actorSpriteComps1034 = nil
			end

			local var_575_8 = arg_572_1.actors_["2078"]
			local var_575_9 = 0

			if var_575_9 < arg_572_1.time_ and arg_572_1.time_ <= var_575_9 + arg_575_0 and not isNil(var_575_8) and arg_572_1.var_.actorSpriteComps2078 == nil then
				arg_572_1.var_.actorSpriteComps2078 = var_575_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_10 = 0.2

			if var_575_9 <= arg_572_1.time_ and arg_572_1.time_ < var_575_9 + var_575_10 and not isNil(var_575_8) then
				local var_575_11 = (arg_572_1.time_ - var_575_9) / var_575_10

				if arg_572_1.var_.actorSpriteComps2078 then
					for iter_575_4, iter_575_5 in pairs(arg_572_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_575_5 then
							if arg_572_1.isInRecall_ then
								local var_575_12 = Mathf.Lerp(iter_575_5.color.r, arg_572_1.hightColor2.r, var_575_11)
								local var_575_13 = Mathf.Lerp(iter_575_5.color.g, arg_572_1.hightColor2.g, var_575_11)
								local var_575_14 = Mathf.Lerp(iter_575_5.color.b, arg_572_1.hightColor2.b, var_575_11)

								iter_575_5.color = Color.New(var_575_12, var_575_13, var_575_14)
							else
								local var_575_15 = Mathf.Lerp(iter_575_5.color.r, 0.5, var_575_11)

								iter_575_5.color = Color.New(var_575_15, var_575_15, var_575_15)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= var_575_9 + var_575_10 and arg_572_1.time_ < var_575_9 + var_575_10 + arg_575_0 and not isNil(var_575_8) and arg_572_1.var_.actorSpriteComps2078 then
				for iter_575_6, iter_575_7 in pairs(arg_572_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_575_7 then
						if arg_572_1.isInRecall_ then
							iter_575_7.color = arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_575_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_572_1.var_.actorSpriteComps2078 = nil
			end

			local var_575_16 = arg_572_1.actors_["1034"].transform
			local var_575_17 = 0

			if var_575_17 < arg_572_1.time_ and arg_572_1.time_ <= var_575_17 + arg_575_0 then
				arg_572_1.var_.moveOldPos1034 = var_575_16.localPosition
				var_575_16.localScale = Vector3.New(1, 1, 1)

				arg_572_1:CheckSpriteTmpPos("1034", 3)

				local var_575_18 = var_575_16.childCount

				for iter_575_8 = 0, var_575_18 - 1 do
					local var_575_19 = var_575_16:GetChild(iter_575_8)

					if var_575_19.name == "" or not string.find(var_575_19.name, "split") then
						var_575_19.gameObject:SetActive(true)
					else
						var_575_19.gameObject:SetActive(false)
					end
				end
			end

			local var_575_20 = 0.001

			if var_575_17 <= arg_572_1.time_ and arg_572_1.time_ < var_575_17 + var_575_20 then
				local var_575_21 = (arg_572_1.time_ - var_575_17) / var_575_20
				local var_575_22 = Vector3.New(0, -331.9, -324)

				var_575_16.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1034, var_575_22, var_575_21)
			end

			if arg_572_1.time_ >= var_575_17 + var_575_20 and arg_572_1.time_ < var_575_17 + var_575_20 + arg_575_0 then
				var_575_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_575_23 = 0
			local var_575_24 = 0.05

			if var_575_23 < arg_572_1.time_ and arg_572_1.time_ <= var_575_23 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_25 = arg_572_1:FormatText(StoryNameCfg[1109].name)

				arg_572_1.leftNameTxt_.text = var_575_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_26 = arg_572_1:GetWordFromCfg(417101138)
				local var_575_27 = arg_572_1:FormatText(var_575_26.content)

				arg_572_1.text_.text = var_575_27

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_28 = 2
				local var_575_29 = utf8.len(var_575_27)
				local var_575_30 = var_575_28 <= 0 and var_575_24 or var_575_24 * (var_575_29 / var_575_28)

				if var_575_30 > 0 and var_575_24 < var_575_30 then
					arg_572_1.talkMaxDuration = var_575_30

					if var_575_30 + var_575_23 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_30 + var_575_23
					end
				end

				arg_572_1.text_.text = var_575_27
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101138", "story_v_out_417101.awb") ~= 0 then
					local var_575_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101138", "story_v_out_417101.awb") / 1000

					if var_575_31 + var_575_23 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_31 + var_575_23
					end

					if var_575_26.prefab_name ~= "" and arg_572_1.actors_[var_575_26.prefab_name] ~= nil then
						local var_575_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_26.prefab_name].transform, "story_v_out_417101", "417101138", "story_v_out_417101.awb")

						arg_572_1:RecordAudio("417101138", var_575_32)
						arg_572_1:RecordAudio("417101138", var_575_32)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_417101", "417101138", "story_v_out_417101.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_417101", "417101138", "story_v_out_417101.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_33 = math.max(var_575_24, arg_572_1.talkMaxDuration)

			if var_575_23 <= arg_572_1.time_ and arg_572_1.time_ < var_575_23 + var_575_33 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_23) / var_575_33

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_23 + var_575_33 and arg_572_1.time_ < var_575_23 + var_575_33 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
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

		arg_572_1:InitPlayNodeList()
	end,
	Play417101139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 417101139
		arg_576_1.duration_ = 7.9

		local var_576_0 = {
			zh = 7.9,
			ja = 7.133
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play417101140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["2078"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps2078 == nil then
				arg_576_1.var_.actorSpriteComps2078 = var_579_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_2 = 0.2

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.actorSpriteComps2078 then
					for iter_579_0, iter_579_1 in pairs(arg_576_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_579_1 then
							if arg_576_1.isInRecall_ then
								local var_579_4 = Mathf.Lerp(iter_579_1.color.r, arg_576_1.hightColor1.r, var_579_3)
								local var_579_5 = Mathf.Lerp(iter_579_1.color.g, arg_576_1.hightColor1.g, var_579_3)
								local var_579_6 = Mathf.Lerp(iter_579_1.color.b, arg_576_1.hightColor1.b, var_579_3)

								iter_579_1.color = Color.New(var_579_4, var_579_5, var_579_6)
							else
								local var_579_7 = Mathf.Lerp(iter_579_1.color.r, 1, var_579_3)

								iter_579_1.color = Color.New(var_579_7, var_579_7, var_579_7)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps2078 then
				for iter_579_2, iter_579_3 in pairs(arg_576_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_579_3 then
						if arg_576_1.isInRecall_ then
							iter_579_3.color = arg_576_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_579_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_576_1.var_.actorSpriteComps2078 = nil
			end

			local var_579_8 = arg_576_1.actors_["1034"]
			local var_579_9 = 0

			if var_579_9 < arg_576_1.time_ and arg_576_1.time_ <= var_579_9 + arg_579_0 and not isNil(var_579_8) and arg_576_1.var_.actorSpriteComps1034 == nil then
				arg_576_1.var_.actorSpriteComps1034 = var_579_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_10 = 0.2

			if var_579_9 <= arg_576_1.time_ and arg_576_1.time_ < var_579_9 + var_579_10 and not isNil(var_579_8) then
				local var_579_11 = (arg_576_1.time_ - var_579_9) / var_579_10

				if arg_576_1.var_.actorSpriteComps1034 then
					for iter_579_4, iter_579_5 in pairs(arg_576_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_579_5 then
							if arg_576_1.isInRecall_ then
								local var_579_12 = Mathf.Lerp(iter_579_5.color.r, arg_576_1.hightColor2.r, var_579_11)
								local var_579_13 = Mathf.Lerp(iter_579_5.color.g, arg_576_1.hightColor2.g, var_579_11)
								local var_579_14 = Mathf.Lerp(iter_579_5.color.b, arg_576_1.hightColor2.b, var_579_11)

								iter_579_5.color = Color.New(var_579_12, var_579_13, var_579_14)
							else
								local var_579_15 = Mathf.Lerp(iter_579_5.color.r, 0.5, var_579_11)

								iter_579_5.color = Color.New(var_579_15, var_579_15, var_579_15)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= var_579_9 + var_579_10 and arg_576_1.time_ < var_579_9 + var_579_10 + arg_579_0 and not isNil(var_579_8) and arg_576_1.var_.actorSpriteComps1034 then
				for iter_579_6, iter_579_7 in pairs(arg_576_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_579_7 then
						if arg_576_1.isInRecall_ then
							iter_579_7.color = arg_576_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_579_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_576_1.var_.actorSpriteComps1034 = nil
			end

			local var_579_16 = 0
			local var_579_17 = 0.8

			if var_579_16 < arg_576_1.time_ and arg_576_1.time_ <= var_579_16 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_18 = arg_576_1:FormatText(StoryNameCfg[1135].name)

				arg_576_1.leftNameTxt_.text = var_579_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_19 = arg_576_1:GetWordFromCfg(417101139)
				local var_579_20 = arg_576_1:FormatText(var_579_19.content)

				arg_576_1.text_.text = var_579_20

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_21 = 32
				local var_579_22 = utf8.len(var_579_20)
				local var_579_23 = var_579_21 <= 0 and var_579_17 or var_579_17 * (var_579_22 / var_579_21)

				if var_579_23 > 0 and var_579_17 < var_579_23 then
					arg_576_1.talkMaxDuration = var_579_23

					if var_579_23 + var_579_16 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_23 + var_579_16
					end
				end

				arg_576_1.text_.text = var_579_20
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101139", "story_v_out_417101.awb") ~= 0 then
					local var_579_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101139", "story_v_out_417101.awb") / 1000

					if var_579_24 + var_579_16 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_24 + var_579_16
					end

					if var_579_19.prefab_name ~= "" and arg_576_1.actors_[var_579_19.prefab_name] ~= nil then
						local var_579_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_19.prefab_name].transform, "story_v_out_417101", "417101139", "story_v_out_417101.awb")

						arg_576_1:RecordAudio("417101139", var_579_25)
						arg_576_1:RecordAudio("417101139", var_579_25)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_417101", "417101139", "story_v_out_417101.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_417101", "417101139", "story_v_out_417101.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_26 = math.max(var_579_17, arg_576_1.talkMaxDuration)

			if var_579_16 <= arg_576_1.time_ and arg_576_1.time_ < var_579_16 + var_579_26 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_16) / var_579_26

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_16 + var_579_26 and arg_576_1.time_ < var_579_16 + var_579_26 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play417101140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 417101140
		arg_580_1.duration_ = 8.8

		local var_580_0 = {
			zh = 6.7,
			ja = 8.8
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play417101141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0
			local var_583_1 = 0.85

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_2 = arg_580_1:FormatText(StoryNameCfg[1135].name)

				arg_580_1.leftNameTxt_.text = var_583_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_3 = arg_580_1:GetWordFromCfg(417101140)
				local var_583_4 = arg_580_1:FormatText(var_583_3.content)

				arg_580_1.text_.text = var_583_4

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_5 = 34
				local var_583_6 = utf8.len(var_583_4)
				local var_583_7 = var_583_5 <= 0 and var_583_1 or var_583_1 * (var_583_6 / var_583_5)

				if var_583_7 > 0 and var_583_1 < var_583_7 then
					arg_580_1.talkMaxDuration = var_583_7

					if var_583_7 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_4
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101140", "story_v_out_417101.awb") ~= 0 then
					local var_583_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101140", "story_v_out_417101.awb") / 1000

					if var_583_8 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_8 + var_583_0
					end

					if var_583_3.prefab_name ~= "" and arg_580_1.actors_[var_583_3.prefab_name] ~= nil then
						local var_583_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_3.prefab_name].transform, "story_v_out_417101", "417101140", "story_v_out_417101.awb")

						arg_580_1:RecordAudio("417101140", var_583_9)
						arg_580_1:RecordAudio("417101140", var_583_9)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_417101", "417101140", "story_v_out_417101.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_417101", "417101140", "story_v_out_417101.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_10 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_10 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_10

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_10 and arg_580_1.time_ < var_583_0 + var_583_10 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play417101141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 417101141
		arg_584_1.duration_ = 8.6

		local var_584_0 = {
			zh = 7.5,
			ja = 8.6
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play417101142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["1034"].transform
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 then
				arg_584_1.var_.moveOldPos1034 = var_587_0.localPosition
				var_587_0.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("1034", 3)

				local var_587_2 = var_587_0.childCount

				for iter_587_0 = 0, var_587_2 - 1 do
					local var_587_3 = var_587_0:GetChild(iter_587_0)

					if var_587_3.name == "" or not string.find(var_587_3.name, "split") then
						var_587_3.gameObject:SetActive(true)
					else
						var_587_3.gameObject:SetActive(false)
					end
				end
			end

			local var_587_4 = 0.001

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_4 then
				local var_587_5 = (arg_584_1.time_ - var_587_1) / var_587_4
				local var_587_6 = Vector3.New(0, -331.9, -324)

				var_587_0.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos1034, var_587_6, var_587_5)
			end

			if arg_584_1.time_ >= var_587_1 + var_587_4 and arg_584_1.time_ < var_587_1 + var_587_4 + arg_587_0 then
				var_587_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_587_7 = 0
			local var_587_8 = 0.85

			if var_587_7 < arg_584_1.time_ and arg_584_1.time_ <= var_587_7 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_9 = arg_584_1:FormatText(StoryNameCfg[1135].name)

				arg_584_1.leftNameTxt_.text = var_587_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, true)
				arg_584_1.iconController_:SetSelectedState("hero")

				arg_584_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_584_1.callingController_:SetSelectedState("normal")

				arg_584_1.keyicon_.color = Color.New(1, 1, 1)
				arg_584_1.icon_.color = Color.New(1, 1, 1)

				local var_587_10 = arg_584_1:GetWordFromCfg(417101141)
				local var_587_11 = arg_584_1:FormatText(var_587_10.content)

				arg_584_1.text_.text = var_587_11

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_12 = 34
				local var_587_13 = utf8.len(var_587_11)
				local var_587_14 = var_587_12 <= 0 and var_587_8 or var_587_8 * (var_587_13 / var_587_12)

				if var_587_14 > 0 and var_587_8 < var_587_14 then
					arg_584_1.talkMaxDuration = var_587_14

					if var_587_14 + var_587_7 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_14 + var_587_7
					end
				end

				arg_584_1.text_.text = var_587_11
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101141", "story_v_out_417101.awb") ~= 0 then
					local var_587_15 = manager.audio:GetVoiceLength("story_v_out_417101", "417101141", "story_v_out_417101.awb") / 1000

					if var_587_15 + var_587_7 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_15 + var_587_7
					end

					if var_587_10.prefab_name ~= "" and arg_584_1.actors_[var_587_10.prefab_name] ~= nil then
						local var_587_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_10.prefab_name].transform, "story_v_out_417101", "417101141", "story_v_out_417101.awb")

						arg_584_1:RecordAudio("417101141", var_587_16)
						arg_584_1:RecordAudio("417101141", var_587_16)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_417101", "417101141", "story_v_out_417101.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_417101", "417101141", "story_v_out_417101.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_17 = math.max(var_587_8, arg_584_1.talkMaxDuration)

			if var_587_7 <= arg_584_1.time_ and arg_584_1.time_ < var_587_7 + var_587_17 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_7) / var_587_17

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_7 + var_587_17 and arg_584_1.time_ < var_587_7 + var_587_17 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play417101142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 417101142
		arg_588_1.duration_ = 4.3

		local var_588_0 = {
			zh = 3.133,
			ja = 4.3
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play417101143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["1034"]
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps1034 == nil then
				arg_588_1.var_.actorSpriteComps1034 = var_591_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_2 = 0.2

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 and not isNil(var_591_0) then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2

				if arg_588_1.var_.actorSpriteComps1034 then
					for iter_591_0, iter_591_1 in pairs(arg_588_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_591_1 then
							if arg_588_1.isInRecall_ then
								local var_591_4 = Mathf.Lerp(iter_591_1.color.r, arg_588_1.hightColor1.r, var_591_3)
								local var_591_5 = Mathf.Lerp(iter_591_1.color.g, arg_588_1.hightColor1.g, var_591_3)
								local var_591_6 = Mathf.Lerp(iter_591_1.color.b, arg_588_1.hightColor1.b, var_591_3)

								iter_591_1.color = Color.New(var_591_4, var_591_5, var_591_6)
							else
								local var_591_7 = Mathf.Lerp(iter_591_1.color.r, 1, var_591_3)

								iter_591_1.color = Color.New(var_591_7, var_591_7, var_591_7)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps1034 then
				for iter_591_2, iter_591_3 in pairs(arg_588_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_591_3 then
						if arg_588_1.isInRecall_ then
							iter_591_3.color = arg_588_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_591_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_588_1.var_.actorSpriteComps1034 = nil
			end

			local var_591_8 = arg_588_1.actors_["2078"]
			local var_591_9 = 0

			if var_591_9 < arg_588_1.time_ and arg_588_1.time_ <= var_591_9 + arg_591_0 and not isNil(var_591_8) and arg_588_1.var_.actorSpriteComps2078 == nil then
				arg_588_1.var_.actorSpriteComps2078 = var_591_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_10 = 0.2

			if var_591_9 <= arg_588_1.time_ and arg_588_1.time_ < var_591_9 + var_591_10 and not isNil(var_591_8) then
				local var_591_11 = (arg_588_1.time_ - var_591_9) / var_591_10

				if arg_588_1.var_.actorSpriteComps2078 then
					for iter_591_4, iter_591_5 in pairs(arg_588_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_591_5 then
							if arg_588_1.isInRecall_ then
								local var_591_12 = Mathf.Lerp(iter_591_5.color.r, arg_588_1.hightColor2.r, var_591_11)
								local var_591_13 = Mathf.Lerp(iter_591_5.color.g, arg_588_1.hightColor2.g, var_591_11)
								local var_591_14 = Mathf.Lerp(iter_591_5.color.b, arg_588_1.hightColor2.b, var_591_11)

								iter_591_5.color = Color.New(var_591_12, var_591_13, var_591_14)
							else
								local var_591_15 = Mathf.Lerp(iter_591_5.color.r, 0.5, var_591_11)

								iter_591_5.color = Color.New(var_591_15, var_591_15, var_591_15)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= var_591_9 + var_591_10 and arg_588_1.time_ < var_591_9 + var_591_10 + arg_591_0 and not isNil(var_591_8) and arg_588_1.var_.actorSpriteComps2078 then
				for iter_591_6, iter_591_7 in pairs(arg_588_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_591_7 then
						if arg_588_1.isInRecall_ then
							iter_591_7.color = arg_588_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_591_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_588_1.var_.actorSpriteComps2078 = nil
			end

			local var_591_16 = arg_588_1.actors_["1034"].transform
			local var_591_17 = 0

			if var_591_17 < arg_588_1.time_ and arg_588_1.time_ <= var_591_17 + arg_591_0 then
				arg_588_1.var_.moveOldPos1034 = var_591_16.localPosition
				var_591_16.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("1034", 3)

				local var_591_18 = var_591_16.childCount

				for iter_591_8 = 0, var_591_18 - 1 do
					local var_591_19 = var_591_16:GetChild(iter_591_8)

					if var_591_19.name == "split_7" or not string.find(var_591_19.name, "split") then
						var_591_19.gameObject:SetActive(true)
					else
						var_591_19.gameObject:SetActive(false)
					end
				end
			end

			local var_591_20 = 0.001

			if var_591_17 <= arg_588_1.time_ and arg_588_1.time_ < var_591_17 + var_591_20 then
				local var_591_21 = (arg_588_1.time_ - var_591_17) / var_591_20
				local var_591_22 = Vector3.New(0, -331.9, -324)

				var_591_16.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos1034, var_591_22, var_591_21)
			end

			if arg_588_1.time_ >= var_591_17 + var_591_20 and arg_588_1.time_ < var_591_17 + var_591_20 + arg_591_0 then
				var_591_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_591_23 = 0
			local var_591_24 = 0.425

			if var_591_23 < arg_588_1.time_ and arg_588_1.time_ <= var_591_23 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_25 = arg_588_1:FormatText(StoryNameCfg[1109].name)

				arg_588_1.leftNameTxt_.text = var_591_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_26 = arg_588_1:GetWordFromCfg(417101142)
				local var_591_27 = arg_588_1:FormatText(var_591_26.content)

				arg_588_1.text_.text = var_591_27

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_28 = 17
				local var_591_29 = utf8.len(var_591_27)
				local var_591_30 = var_591_28 <= 0 and var_591_24 or var_591_24 * (var_591_29 / var_591_28)

				if var_591_30 > 0 and var_591_24 < var_591_30 then
					arg_588_1.talkMaxDuration = var_591_30

					if var_591_30 + var_591_23 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_30 + var_591_23
					end
				end

				arg_588_1.text_.text = var_591_27
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101142", "story_v_out_417101.awb") ~= 0 then
					local var_591_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101142", "story_v_out_417101.awb") / 1000

					if var_591_31 + var_591_23 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_31 + var_591_23
					end

					if var_591_26.prefab_name ~= "" and arg_588_1.actors_[var_591_26.prefab_name] ~= nil then
						local var_591_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_26.prefab_name].transform, "story_v_out_417101", "417101142", "story_v_out_417101.awb")

						arg_588_1:RecordAudio("417101142", var_591_32)
						arg_588_1:RecordAudio("417101142", var_591_32)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_417101", "417101142", "story_v_out_417101.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_417101", "417101142", "story_v_out_417101.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_33 = math.max(var_591_24, arg_588_1.talkMaxDuration)

			if var_591_23 <= arg_588_1.time_ and arg_588_1.time_ < var_591_23 + var_591_33 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_23) / var_591_33

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_23 + var_591_33 and arg_588_1.time_ < var_591_23 + var_591_33 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
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

		arg_588_1:InitPlayNodeList()
	end,
	Play417101143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 417101143
		arg_592_1.duration_ = 5.23

		local var_592_0 = {
			zh = 3.1,
			ja = 5.233
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play417101144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = arg_592_1.actors_["2078"]
			local var_595_1 = 0

			if var_595_1 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.actorSpriteComps2078 == nil then
				arg_592_1.var_.actorSpriteComps2078 = var_595_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_595_2 = 0.2

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_2 and not isNil(var_595_0) then
				local var_595_3 = (arg_592_1.time_ - var_595_1) / var_595_2

				if arg_592_1.var_.actorSpriteComps2078 then
					for iter_595_0, iter_595_1 in pairs(arg_592_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_595_1 then
							if arg_592_1.isInRecall_ then
								local var_595_4 = Mathf.Lerp(iter_595_1.color.r, arg_592_1.hightColor1.r, var_595_3)
								local var_595_5 = Mathf.Lerp(iter_595_1.color.g, arg_592_1.hightColor1.g, var_595_3)
								local var_595_6 = Mathf.Lerp(iter_595_1.color.b, arg_592_1.hightColor1.b, var_595_3)

								iter_595_1.color = Color.New(var_595_4, var_595_5, var_595_6)
							else
								local var_595_7 = Mathf.Lerp(iter_595_1.color.r, 1, var_595_3)

								iter_595_1.color = Color.New(var_595_7, var_595_7, var_595_7)
							end
						end
					end
				end
			end

			if arg_592_1.time_ >= var_595_1 + var_595_2 and arg_592_1.time_ < var_595_1 + var_595_2 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.actorSpriteComps2078 then
				for iter_595_2, iter_595_3 in pairs(arg_592_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_595_3 then
						if arg_592_1.isInRecall_ then
							iter_595_3.color = arg_592_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_595_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_592_1.var_.actorSpriteComps2078 = nil
			end

			local var_595_8 = arg_592_1.actors_["1034"]
			local var_595_9 = 0

			if var_595_9 < arg_592_1.time_ and arg_592_1.time_ <= var_595_9 + arg_595_0 and not isNil(var_595_8) and arg_592_1.var_.actorSpriteComps1034 == nil then
				arg_592_1.var_.actorSpriteComps1034 = var_595_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_595_10 = 0.2

			if var_595_9 <= arg_592_1.time_ and arg_592_1.time_ < var_595_9 + var_595_10 and not isNil(var_595_8) then
				local var_595_11 = (arg_592_1.time_ - var_595_9) / var_595_10

				if arg_592_1.var_.actorSpriteComps1034 then
					for iter_595_4, iter_595_5 in pairs(arg_592_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_595_5 then
							if arg_592_1.isInRecall_ then
								local var_595_12 = Mathf.Lerp(iter_595_5.color.r, arg_592_1.hightColor2.r, var_595_11)
								local var_595_13 = Mathf.Lerp(iter_595_5.color.g, arg_592_1.hightColor2.g, var_595_11)
								local var_595_14 = Mathf.Lerp(iter_595_5.color.b, arg_592_1.hightColor2.b, var_595_11)

								iter_595_5.color = Color.New(var_595_12, var_595_13, var_595_14)
							else
								local var_595_15 = Mathf.Lerp(iter_595_5.color.r, 0.5, var_595_11)

								iter_595_5.color = Color.New(var_595_15, var_595_15, var_595_15)
							end
						end
					end
				end
			end

			if arg_592_1.time_ >= var_595_9 + var_595_10 and arg_592_1.time_ < var_595_9 + var_595_10 + arg_595_0 and not isNil(var_595_8) and arg_592_1.var_.actorSpriteComps1034 then
				for iter_595_6, iter_595_7 in pairs(arg_592_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_595_7 then
						if arg_592_1.isInRecall_ then
							iter_595_7.color = arg_592_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_595_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_592_1.var_.actorSpriteComps1034 = nil
			end

			local var_595_16 = 0
			local var_595_17 = 0.375

			if var_595_16 < arg_592_1.time_ and arg_592_1.time_ <= var_595_16 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_18 = arg_592_1:FormatText(StoryNameCfg[1135].name)

				arg_592_1.leftNameTxt_.text = var_595_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_19 = arg_592_1:GetWordFromCfg(417101143)
				local var_595_20 = arg_592_1:FormatText(var_595_19.content)

				arg_592_1.text_.text = var_595_20

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_21 = 15
				local var_595_22 = utf8.len(var_595_20)
				local var_595_23 = var_595_21 <= 0 and var_595_17 or var_595_17 * (var_595_22 / var_595_21)

				if var_595_23 > 0 and var_595_17 < var_595_23 then
					arg_592_1.talkMaxDuration = var_595_23

					if var_595_23 + var_595_16 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_23 + var_595_16
					end
				end

				arg_592_1.text_.text = var_595_20
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101143", "story_v_out_417101.awb") ~= 0 then
					local var_595_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101143", "story_v_out_417101.awb") / 1000

					if var_595_24 + var_595_16 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_24 + var_595_16
					end

					if var_595_19.prefab_name ~= "" and arg_592_1.actors_[var_595_19.prefab_name] ~= nil then
						local var_595_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_19.prefab_name].transform, "story_v_out_417101", "417101143", "story_v_out_417101.awb")

						arg_592_1:RecordAudio("417101143", var_595_25)
						arg_592_1:RecordAudio("417101143", var_595_25)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_417101", "417101143", "story_v_out_417101.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_417101", "417101143", "story_v_out_417101.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_26 = math.max(var_595_17, arg_592_1.talkMaxDuration)

			if var_595_16 <= arg_592_1.time_ and arg_592_1.time_ < var_595_16 + var_595_26 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_16) / var_595_26

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_16 + var_595_26 and arg_592_1.time_ < var_595_16 + var_595_26 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play417101144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 417101144
		arg_596_1.duration_ = 2.47

		local var_596_0 = {
			zh = 2.466,
			ja = 1.433
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play417101145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1034"]
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.actorSpriteComps1034 == nil then
				arg_596_1.var_.actorSpriteComps1034 = var_599_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_599_2 = 0.2

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 and not isNil(var_599_0) then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2

				if arg_596_1.var_.actorSpriteComps1034 then
					for iter_599_0, iter_599_1 in pairs(arg_596_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_599_1 then
							if arg_596_1.isInRecall_ then
								local var_599_4 = Mathf.Lerp(iter_599_1.color.r, arg_596_1.hightColor1.r, var_599_3)
								local var_599_5 = Mathf.Lerp(iter_599_1.color.g, arg_596_1.hightColor1.g, var_599_3)
								local var_599_6 = Mathf.Lerp(iter_599_1.color.b, arg_596_1.hightColor1.b, var_599_3)

								iter_599_1.color = Color.New(var_599_4, var_599_5, var_599_6)
							else
								local var_599_7 = Mathf.Lerp(iter_599_1.color.r, 1, var_599_3)

								iter_599_1.color = Color.New(var_599_7, var_599_7, var_599_7)
							end
						end
					end
				end
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.actorSpriteComps1034 then
				for iter_599_2, iter_599_3 in pairs(arg_596_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_599_3 then
						if arg_596_1.isInRecall_ then
							iter_599_3.color = arg_596_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_599_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_596_1.var_.actorSpriteComps1034 = nil
			end

			local var_599_8 = arg_596_1.actors_["2078"]
			local var_599_9 = 0

			if var_599_9 < arg_596_1.time_ and arg_596_1.time_ <= var_599_9 + arg_599_0 and not isNil(var_599_8) and arg_596_1.var_.actorSpriteComps2078 == nil then
				arg_596_1.var_.actorSpriteComps2078 = var_599_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_599_10 = 0.2

			if var_599_9 <= arg_596_1.time_ and arg_596_1.time_ < var_599_9 + var_599_10 and not isNil(var_599_8) then
				local var_599_11 = (arg_596_1.time_ - var_599_9) / var_599_10

				if arg_596_1.var_.actorSpriteComps2078 then
					for iter_599_4, iter_599_5 in pairs(arg_596_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_599_5 then
							if arg_596_1.isInRecall_ then
								local var_599_12 = Mathf.Lerp(iter_599_5.color.r, arg_596_1.hightColor2.r, var_599_11)
								local var_599_13 = Mathf.Lerp(iter_599_5.color.g, arg_596_1.hightColor2.g, var_599_11)
								local var_599_14 = Mathf.Lerp(iter_599_5.color.b, arg_596_1.hightColor2.b, var_599_11)

								iter_599_5.color = Color.New(var_599_12, var_599_13, var_599_14)
							else
								local var_599_15 = Mathf.Lerp(iter_599_5.color.r, 0.5, var_599_11)

								iter_599_5.color = Color.New(var_599_15, var_599_15, var_599_15)
							end
						end
					end
				end
			end

			if arg_596_1.time_ >= var_599_9 + var_599_10 and arg_596_1.time_ < var_599_9 + var_599_10 + arg_599_0 and not isNil(var_599_8) and arg_596_1.var_.actorSpriteComps2078 then
				for iter_599_6, iter_599_7 in pairs(arg_596_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_599_7 then
						if arg_596_1.isInRecall_ then
							iter_599_7.color = arg_596_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_599_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_596_1.var_.actorSpriteComps2078 = nil
			end

			local var_599_16 = arg_596_1.actors_["1034"].transform
			local var_599_17 = 0

			if var_599_17 < arg_596_1.time_ and arg_596_1.time_ <= var_599_17 + arg_599_0 then
				arg_596_1.var_.moveOldPos1034 = var_599_16.localPosition
				var_599_16.localScale = Vector3.New(1, 1, 1)

				arg_596_1:CheckSpriteTmpPos("1034", 3)

				local var_599_18 = var_599_16.childCount

				for iter_599_8 = 0, var_599_18 - 1 do
					local var_599_19 = var_599_16:GetChild(iter_599_8)

					if var_599_19.name == "split_4" or not string.find(var_599_19.name, "split") then
						var_599_19.gameObject:SetActive(true)
					else
						var_599_19.gameObject:SetActive(false)
					end
				end
			end

			local var_599_20 = 0.001

			if var_599_17 <= arg_596_1.time_ and arg_596_1.time_ < var_599_17 + var_599_20 then
				local var_599_21 = (arg_596_1.time_ - var_599_17) / var_599_20
				local var_599_22 = Vector3.New(0, -331.9, -324)

				var_599_16.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos1034, var_599_22, var_599_21)
			end

			if arg_596_1.time_ >= var_599_17 + var_599_20 and arg_596_1.time_ < var_599_17 + var_599_20 + arg_599_0 then
				var_599_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_599_23 = 0
			local var_599_24 = 0.05

			if var_599_23 < arg_596_1.time_ and arg_596_1.time_ <= var_599_23 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_25 = arg_596_1:FormatText(StoryNameCfg[1109].name)

				arg_596_1.leftNameTxt_.text = var_599_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_26 = arg_596_1:GetWordFromCfg(417101144)
				local var_599_27 = arg_596_1:FormatText(var_599_26.content)

				arg_596_1.text_.text = var_599_27

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_28 = 2
				local var_599_29 = utf8.len(var_599_27)
				local var_599_30 = var_599_28 <= 0 and var_599_24 or var_599_24 * (var_599_29 / var_599_28)

				if var_599_30 > 0 and var_599_24 < var_599_30 then
					arg_596_1.talkMaxDuration = var_599_30

					if var_599_30 + var_599_23 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_30 + var_599_23
					end
				end

				arg_596_1.text_.text = var_599_27
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101144", "story_v_out_417101.awb") ~= 0 then
					local var_599_31 = manager.audio:GetVoiceLength("story_v_out_417101", "417101144", "story_v_out_417101.awb") / 1000

					if var_599_31 + var_599_23 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_31 + var_599_23
					end

					if var_599_26.prefab_name ~= "" and arg_596_1.actors_[var_599_26.prefab_name] ~= nil then
						local var_599_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_26.prefab_name].transform, "story_v_out_417101", "417101144", "story_v_out_417101.awb")

						arg_596_1:RecordAudio("417101144", var_599_32)
						arg_596_1:RecordAudio("417101144", var_599_32)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_417101", "417101144", "story_v_out_417101.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_417101", "417101144", "story_v_out_417101.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_33 = math.max(var_599_24, arg_596_1.talkMaxDuration)

			if var_599_23 <= arg_596_1.time_ and arg_596_1.time_ < var_599_23 + var_599_33 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_23) / var_599_33

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_23 + var_599_33 and arg_596_1.time_ < var_599_23 + var_599_33 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
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

		arg_596_1:InitPlayNodeList()
	end,
	Play417101145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 417101145
		arg_600_1.duration_ = 9.63

		local var_600_0 = {
			zh = 8.133,
			ja = 9.633
		}
		local var_600_1 = manager.audio:GetLocalizationFlag()

		if var_600_0[var_600_1] ~= nil then
			arg_600_1.duration_ = var_600_0[var_600_1]
		end

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play417101146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["2078"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.actorSpriteComps2078 == nil then
				arg_600_1.var_.actorSpriteComps2078 = var_603_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_603_2 = 0.2

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.actorSpriteComps2078 then
					for iter_603_0, iter_603_1 in pairs(arg_600_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_603_1 then
							if arg_600_1.isInRecall_ then
								local var_603_4 = Mathf.Lerp(iter_603_1.color.r, arg_600_1.hightColor1.r, var_603_3)
								local var_603_5 = Mathf.Lerp(iter_603_1.color.g, arg_600_1.hightColor1.g, var_603_3)
								local var_603_6 = Mathf.Lerp(iter_603_1.color.b, arg_600_1.hightColor1.b, var_603_3)

								iter_603_1.color = Color.New(var_603_4, var_603_5, var_603_6)
							else
								local var_603_7 = Mathf.Lerp(iter_603_1.color.r, 1, var_603_3)

								iter_603_1.color = Color.New(var_603_7, var_603_7, var_603_7)
							end
						end
					end
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.actorSpriteComps2078 then
				for iter_603_2, iter_603_3 in pairs(arg_600_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_603_3 then
						if arg_600_1.isInRecall_ then
							iter_603_3.color = arg_600_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_603_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_600_1.var_.actorSpriteComps2078 = nil
			end

			local var_603_8 = arg_600_1.actors_["1034"]
			local var_603_9 = 0

			if var_603_9 < arg_600_1.time_ and arg_600_1.time_ <= var_603_9 + arg_603_0 and not isNil(var_603_8) and arg_600_1.var_.actorSpriteComps1034 == nil then
				arg_600_1.var_.actorSpriteComps1034 = var_603_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_603_10 = 0.2

			if var_603_9 <= arg_600_1.time_ and arg_600_1.time_ < var_603_9 + var_603_10 and not isNil(var_603_8) then
				local var_603_11 = (arg_600_1.time_ - var_603_9) / var_603_10

				if arg_600_1.var_.actorSpriteComps1034 then
					for iter_603_4, iter_603_5 in pairs(arg_600_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_603_5 then
							if arg_600_1.isInRecall_ then
								local var_603_12 = Mathf.Lerp(iter_603_5.color.r, arg_600_1.hightColor2.r, var_603_11)
								local var_603_13 = Mathf.Lerp(iter_603_5.color.g, arg_600_1.hightColor2.g, var_603_11)
								local var_603_14 = Mathf.Lerp(iter_603_5.color.b, arg_600_1.hightColor2.b, var_603_11)

								iter_603_5.color = Color.New(var_603_12, var_603_13, var_603_14)
							else
								local var_603_15 = Mathf.Lerp(iter_603_5.color.r, 0.5, var_603_11)

								iter_603_5.color = Color.New(var_603_15, var_603_15, var_603_15)
							end
						end
					end
				end
			end

			if arg_600_1.time_ >= var_603_9 + var_603_10 and arg_600_1.time_ < var_603_9 + var_603_10 + arg_603_0 and not isNil(var_603_8) and arg_600_1.var_.actorSpriteComps1034 then
				for iter_603_6, iter_603_7 in pairs(arg_600_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_603_7 then
						if arg_600_1.isInRecall_ then
							iter_603_7.color = arg_600_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_603_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_600_1.var_.actorSpriteComps1034 = nil
			end

			local var_603_16 = 0
			local var_603_17 = 1.05

			if var_603_16 < arg_600_1.time_ and arg_600_1.time_ <= var_603_16 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_18 = arg_600_1:FormatText(StoryNameCfg[1135].name)

				arg_600_1.leftNameTxt_.text = var_603_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_19 = arg_600_1:GetWordFromCfg(417101145)
				local var_603_20 = arg_600_1:FormatText(var_603_19.content)

				arg_600_1.text_.text = var_603_20

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_21 = 42
				local var_603_22 = utf8.len(var_603_20)
				local var_603_23 = var_603_21 <= 0 and var_603_17 or var_603_17 * (var_603_22 / var_603_21)

				if var_603_23 > 0 and var_603_17 < var_603_23 then
					arg_600_1.talkMaxDuration = var_603_23

					if var_603_23 + var_603_16 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_23 + var_603_16
					end
				end

				arg_600_1.text_.text = var_603_20
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101145", "story_v_out_417101.awb") ~= 0 then
					local var_603_24 = manager.audio:GetVoiceLength("story_v_out_417101", "417101145", "story_v_out_417101.awb") / 1000

					if var_603_24 + var_603_16 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_24 + var_603_16
					end

					if var_603_19.prefab_name ~= "" and arg_600_1.actors_[var_603_19.prefab_name] ~= nil then
						local var_603_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_19.prefab_name].transform, "story_v_out_417101", "417101145", "story_v_out_417101.awb")

						arg_600_1:RecordAudio("417101145", var_603_25)
						arg_600_1:RecordAudio("417101145", var_603_25)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_out_417101", "417101145", "story_v_out_417101.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_out_417101", "417101145", "story_v_out_417101.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_26 = math.max(var_603_17, arg_600_1.talkMaxDuration)

			if var_603_16 <= arg_600_1.time_ and arg_600_1.time_ < var_603_16 + var_603_26 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_16) / var_603_26

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_16 + var_603_26 and arg_600_1.time_ < var_603_16 + var_603_26 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play417101146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 417101146
		arg_604_1.duration_ = 5.67

		local var_604_0 = {
			zh = 3.766,
			ja = 5.666
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play417101147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0
			local var_607_1 = 0.475

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_2 = arg_604_1:FormatText(StoryNameCfg[1135].name)

				arg_604_1.leftNameTxt_.text = var_607_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_3 = arg_604_1:GetWordFromCfg(417101146)
				local var_607_4 = arg_604_1:FormatText(var_607_3.content)

				arg_604_1.text_.text = var_607_4

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_5 = 19
				local var_607_6 = utf8.len(var_607_4)
				local var_607_7 = var_607_5 <= 0 and var_607_1 or var_607_1 * (var_607_6 / var_607_5)

				if var_607_7 > 0 and var_607_1 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_0
					end
				end

				arg_604_1.text_.text = var_607_4
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101146", "story_v_out_417101.awb") ~= 0 then
					local var_607_8 = manager.audio:GetVoiceLength("story_v_out_417101", "417101146", "story_v_out_417101.awb") / 1000

					if var_607_8 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_8 + var_607_0
					end

					if var_607_3.prefab_name ~= "" and arg_604_1.actors_[var_607_3.prefab_name] ~= nil then
						local var_607_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_3.prefab_name].transform, "story_v_out_417101", "417101146", "story_v_out_417101.awb")

						arg_604_1:RecordAudio("417101146", var_607_9)
						arg_604_1:RecordAudio("417101146", var_607_9)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_417101", "417101146", "story_v_out_417101.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_417101", "417101146", "story_v_out_417101.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_10 = math.max(var_607_1, arg_604_1.talkMaxDuration)

			if var_607_0 <= arg_604_1.time_ and arg_604_1.time_ < var_607_0 + var_607_10 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_0) / var_607_10

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_0 + var_607_10 and arg_604_1.time_ < var_607_0 + var_607_10 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play417101147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 417101147
		arg_608_1.duration_ = 5.7

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play417101148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["2078"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps2078 == nil then
				arg_608_1.var_.actorSpriteComps2078 = var_611_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_2 = 0.2

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.actorSpriteComps2078 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								local var_611_4 = Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor2.r, var_611_3)
								local var_611_5 = Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor2.g, var_611_3)
								local var_611_6 = Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor2.b, var_611_3)

								iter_611_1.color = Color.New(var_611_4, var_611_5, var_611_6)
							else
								local var_611_7 = Mathf.Lerp(iter_611_1.color.r, 0.5, var_611_3)

								iter_611_1.color = Color.New(var_611_7, var_611_7, var_611_7)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps2078 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_611_3 then
						if arg_608_1.isInRecall_ then
							iter_611_3.color = arg_608_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_611_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_608_1.var_.actorSpriteComps2078 = nil
			end

			local var_611_8 = arg_608_1.actors_["1034"].transform
			local var_611_9 = 0

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.var_.moveOldPos1034 = var_611_8.localPosition
				var_611_8.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("1034", 7)

				local var_611_10 = var_611_8.childCount

				for iter_611_4 = 0, var_611_10 - 1 do
					local var_611_11 = var_611_8:GetChild(iter_611_4)

					if var_611_11.name == "" or not string.find(var_611_11.name, "split") then
						var_611_11.gameObject:SetActive(true)
					else
						var_611_11.gameObject:SetActive(false)
					end
				end
			end

			local var_611_12 = 0.001

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_12 then
				local var_611_13 = (arg_608_1.time_ - var_611_9) / var_611_12
				local var_611_14 = Vector3.New(0, -2000, 0)

				var_611_8.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1034, var_611_14, var_611_13)
			end

			if arg_608_1.time_ >= var_611_9 + var_611_12 and arg_608_1.time_ < var_611_9 + var_611_12 + arg_611_0 then
				var_611_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_611_15 = 0.7
			local var_611_16 = 1

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				local var_611_17 = "play"
				local var_611_18 = "effect"

				arg_608_1:AudioAction(var_611_17, var_611_18, "se_story_128", "se_story_128_knock", "")
			end

			if arg_608_1.frameCnt_ <= 1 then
				arg_608_1.dialog_:SetActive(false)
			end

			local var_611_19 = 0.7
			local var_611_20 = 1.15

			if var_611_19 < arg_608_1.time_ and arg_608_1.time_ <= var_611_19 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0

				arg_608_1.dialog_:SetActive(true)

				arg_608_1.dialogCg_.alpha = 0

				local var_611_21 = LeanTween.value(arg_608_1.dialog_, 0, 1, 0.3)

				var_611_21:setOnUpdate(LuaHelper.FloatAction(function(arg_612_0)
					arg_608_1.dialogCg_.alpha = arg_612_0
				end))
				var_611_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_608_1.dialog_)
					var_611_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_608_1.duration_ = arg_608_1.duration_ + 0.3

				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_22 = arg_608_1:GetWordFromCfg(417101147)
				local var_611_23 = arg_608_1:FormatText(var_611_22.content)

				arg_608_1.text_.text = var_611_23

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_24 = 46
				local var_611_25 = utf8.len(var_611_23)
				local var_611_26 = var_611_24 <= 0 and var_611_20 or var_611_20 * (var_611_25 / var_611_24)

				if var_611_26 > 0 and var_611_20 < var_611_26 then
					arg_608_1.talkMaxDuration = var_611_26
					var_611_19 = var_611_19 + 0.3

					if var_611_26 + var_611_19 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_26 + var_611_19
					end
				end

				arg_608_1.text_.text = var_611_23
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_27 = var_611_19 + 0.3
			local var_611_28 = math.max(var_611_20, arg_608_1.talkMaxDuration)

			if var_611_27 <= arg_608_1.time_ and arg_608_1.time_ < var_611_27 + var_611_28 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_27) / var_611_28

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_27 + var_611_28 and arg_608_1.time_ < var_611_27 + var_611_28 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
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

		arg_608_1:InitPlayNodeList()
	end,
	Play417101148 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 417101148
		arg_614_1.duration_ = 5

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play417101149(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0.225
			local var_617_1 = 1

			if var_617_0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_0 + arg_617_0 then
				local var_617_2 = "play"
				local var_617_3 = "effect"

				arg_614_1:AudioAction(var_617_2, var_617_3, "se_story_120_04", "se_story_120_04_punch_hit", "")
			end

			local var_617_4 = 0
			local var_617_5 = 1.225

			if var_617_4 < arg_614_1.time_ and arg_614_1.time_ <= var_617_4 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, false)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_6 = arg_614_1:GetWordFromCfg(417101148)
				local var_617_7 = arg_614_1:FormatText(var_617_6.content)

				arg_614_1.text_.text = var_617_7

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_8 = 49
				local var_617_9 = utf8.len(var_617_7)
				local var_617_10 = var_617_8 <= 0 and var_617_5 or var_617_5 * (var_617_9 / var_617_8)

				if var_617_10 > 0 and var_617_5 < var_617_10 then
					arg_614_1.talkMaxDuration = var_617_10

					if var_617_10 + var_617_4 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_10 + var_617_4
					end
				end

				arg_614_1.text_.text = var_617_7
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)
				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_11 = math.max(var_617_5, arg_614_1.talkMaxDuration)

			if var_617_4 <= arg_614_1.time_ and arg_614_1.time_ < var_617_4 + var_617_11 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_4) / var_617_11

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_4 + var_617_11 and arg_614_1.time_ < var_617_4 + var_617_11 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play417101149 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 417101149
		arg_618_1.duration_ = 3.3

		local var_618_0 = {
			zh = 3.3,
			ja = 1.466
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play417101150(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["1034"]
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 and not isNil(var_621_0) and arg_618_1.var_.actorSpriteComps1034 == nil then
				arg_618_1.var_.actorSpriteComps1034 = var_621_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_621_2 = 0.2

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 and not isNil(var_621_0) then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2

				if arg_618_1.var_.actorSpriteComps1034 then
					for iter_621_0, iter_621_1 in pairs(arg_618_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_621_1 then
							if arg_618_1.isInRecall_ then
								local var_621_4 = Mathf.Lerp(iter_621_1.color.r, arg_618_1.hightColor1.r, var_621_3)
								local var_621_5 = Mathf.Lerp(iter_621_1.color.g, arg_618_1.hightColor1.g, var_621_3)
								local var_621_6 = Mathf.Lerp(iter_621_1.color.b, arg_618_1.hightColor1.b, var_621_3)

								iter_621_1.color = Color.New(var_621_4, var_621_5, var_621_6)
							else
								local var_621_7 = Mathf.Lerp(iter_621_1.color.r, 1, var_621_3)

								iter_621_1.color = Color.New(var_621_7, var_621_7, var_621_7)
							end
						end
					end
				end
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 and not isNil(var_621_0) and arg_618_1.var_.actorSpriteComps1034 then
				for iter_621_2, iter_621_3 in pairs(arg_618_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_621_3 then
						if arg_618_1.isInRecall_ then
							iter_621_3.color = arg_618_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_621_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_618_1.var_.actorSpriteComps1034 = nil
			end

			local var_621_8 = 0
			local var_621_9 = 0.35

			if var_621_8 < arg_618_1.time_ and arg_618_1.time_ <= var_621_8 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_10 = arg_618_1:FormatText(StoryNameCfg[1109].name)

				arg_618_1.leftNameTxt_.text = var_621_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, true)
				arg_618_1.iconController_:SetSelectedState("hero")

				arg_618_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_5")

				arg_618_1.callingController_:SetSelectedState("normal")

				arg_618_1.keyicon_.color = Color.New(1, 1, 1)
				arg_618_1.icon_.color = Color.New(1, 1, 1)

				local var_621_11 = arg_618_1:GetWordFromCfg(417101149)
				local var_621_12 = arg_618_1:FormatText(var_621_11.content)

				arg_618_1.text_.text = var_621_12

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_13 = 14
				local var_621_14 = utf8.len(var_621_12)
				local var_621_15 = var_621_13 <= 0 and var_621_9 or var_621_9 * (var_621_14 / var_621_13)

				if var_621_15 > 0 and var_621_9 < var_621_15 then
					arg_618_1.talkMaxDuration = var_621_15

					if var_621_15 + var_621_8 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_15 + var_621_8
					end
				end

				arg_618_1.text_.text = var_621_12
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101149", "story_v_out_417101.awb") ~= 0 then
					local var_621_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101149", "story_v_out_417101.awb") / 1000

					if var_621_16 + var_621_8 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_16 + var_621_8
					end

					if var_621_11.prefab_name ~= "" and arg_618_1.actors_[var_621_11.prefab_name] ~= nil then
						local var_621_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_11.prefab_name].transform, "story_v_out_417101", "417101149", "story_v_out_417101.awb")

						arg_618_1:RecordAudio("417101149", var_621_17)
						arg_618_1:RecordAudio("417101149", var_621_17)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_out_417101", "417101149", "story_v_out_417101.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_out_417101", "417101149", "story_v_out_417101.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_18 = math.max(var_621_9, arg_618_1.talkMaxDuration)

			if var_621_8 <= arg_618_1.time_ and arg_618_1.time_ < var_621_8 + var_621_18 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_8) / var_621_18

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_8 + var_621_18 and arg_618_1.time_ < var_621_8 + var_621_18 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play417101150 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 417101150
		arg_622_1.duration_ = 5

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play417101151(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["1034"]
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.actorSpriteComps1034 == nil then
				arg_622_1.var_.actorSpriteComps1034 = var_625_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_625_2 = 0.2

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_2 and not isNil(var_625_0) then
				local var_625_3 = (arg_622_1.time_ - var_625_1) / var_625_2

				if arg_622_1.var_.actorSpriteComps1034 then
					for iter_625_0, iter_625_1 in pairs(arg_622_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_625_1 then
							if arg_622_1.isInRecall_ then
								local var_625_4 = Mathf.Lerp(iter_625_1.color.r, arg_622_1.hightColor2.r, var_625_3)
								local var_625_5 = Mathf.Lerp(iter_625_1.color.g, arg_622_1.hightColor2.g, var_625_3)
								local var_625_6 = Mathf.Lerp(iter_625_1.color.b, arg_622_1.hightColor2.b, var_625_3)

								iter_625_1.color = Color.New(var_625_4, var_625_5, var_625_6)
							else
								local var_625_7 = Mathf.Lerp(iter_625_1.color.r, 0.5, var_625_3)

								iter_625_1.color = Color.New(var_625_7, var_625_7, var_625_7)
							end
						end
					end
				end
			end

			if arg_622_1.time_ >= var_625_1 + var_625_2 and arg_622_1.time_ < var_625_1 + var_625_2 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.actorSpriteComps1034 then
				for iter_625_2, iter_625_3 in pairs(arg_622_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_625_3 then
						if arg_622_1.isInRecall_ then
							iter_625_3.color = arg_622_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_625_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_622_1.var_.actorSpriteComps1034 = nil
			end

			local var_625_8 = 0
			local var_625_9 = 1

			if var_625_8 < arg_622_1.time_ and arg_622_1.time_ <= var_625_8 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, false)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_10 = arg_622_1:GetWordFromCfg(417101150)
				local var_625_11 = arg_622_1:FormatText(var_625_10.content)

				arg_622_1.text_.text = var_625_11

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_12 = 40
				local var_625_13 = utf8.len(var_625_11)
				local var_625_14 = var_625_12 <= 0 and var_625_9 or var_625_9 * (var_625_13 / var_625_12)

				if var_625_14 > 0 and var_625_9 < var_625_14 then
					arg_622_1.talkMaxDuration = var_625_14

					if var_625_14 + var_625_8 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_14 + var_625_8
					end
				end

				arg_622_1.text_.text = var_625_11
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_15 = math.max(var_625_9, arg_622_1.talkMaxDuration)

			if var_625_8 <= arg_622_1.time_ and arg_622_1.time_ < var_625_8 + var_625_15 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_8) / var_625_15

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_8 + var_625_15 and arg_622_1.time_ < var_625_8 + var_625_15 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play417101151 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 417101151
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play417101152(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0
			local var_629_1 = 1.15

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, false)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_2 = arg_626_1:GetWordFromCfg(417101151)
				local var_629_3 = arg_626_1:FormatText(var_629_2.content)

				arg_626_1.text_.text = var_629_3

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 46
				local var_629_5 = utf8.len(var_629_3)
				local var_629_6 = var_629_4 <= 0 and var_629_1 or var_629_1 * (var_629_5 / var_629_4)

				if var_629_6 > 0 and var_629_1 < var_629_6 then
					arg_626_1.talkMaxDuration = var_629_6

					if var_629_6 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_6 + var_629_0
					end
				end

				arg_626_1.text_.text = var_629_3
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_1, arg_626_1.talkMaxDuration)

			if var_629_0 <= arg_626_1.time_ and arg_626_1.time_ < var_629_0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_0 + var_629_7 and arg_626_1.time_ < var_629_0 + var_629_7 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play417101152 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 417101152
		arg_630_1.duration_ = 6.77

		local var_630_0 = {
			zh = 4.3,
			ja = 6.766
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play417101153(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = arg_630_1.actors_["1034"]
			local var_633_1 = 0

			if var_633_1 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 and not isNil(var_633_0) and arg_630_1.var_.actorSpriteComps1034 == nil then
				arg_630_1.var_.actorSpriteComps1034 = var_633_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_633_2 = 0.2

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_2 and not isNil(var_633_0) then
				local var_633_3 = (arg_630_1.time_ - var_633_1) / var_633_2

				if arg_630_1.var_.actorSpriteComps1034 then
					for iter_633_0, iter_633_1 in pairs(arg_630_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_633_1 then
							if arg_630_1.isInRecall_ then
								local var_633_4 = Mathf.Lerp(iter_633_1.color.r, arg_630_1.hightColor1.r, var_633_3)
								local var_633_5 = Mathf.Lerp(iter_633_1.color.g, arg_630_1.hightColor1.g, var_633_3)
								local var_633_6 = Mathf.Lerp(iter_633_1.color.b, arg_630_1.hightColor1.b, var_633_3)

								iter_633_1.color = Color.New(var_633_4, var_633_5, var_633_6)
							else
								local var_633_7 = Mathf.Lerp(iter_633_1.color.r, 1, var_633_3)

								iter_633_1.color = Color.New(var_633_7, var_633_7, var_633_7)
							end
						end
					end
				end
			end

			if arg_630_1.time_ >= var_633_1 + var_633_2 and arg_630_1.time_ < var_633_1 + var_633_2 + arg_633_0 and not isNil(var_633_0) and arg_630_1.var_.actorSpriteComps1034 then
				for iter_633_2, iter_633_3 in pairs(arg_630_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_633_3 then
						if arg_630_1.isInRecall_ then
							iter_633_3.color = arg_630_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_633_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_630_1.var_.actorSpriteComps1034 = nil
			end

			local var_633_8 = arg_630_1.actors_["1034"].transform
			local var_633_9 = 0

			if var_633_9 < arg_630_1.time_ and arg_630_1.time_ <= var_633_9 + arg_633_0 then
				arg_630_1.var_.moveOldPos1034 = var_633_8.localPosition
				var_633_8.localScale = Vector3.New(1, 1, 1)

				arg_630_1:CheckSpriteTmpPos("1034", 3)

				local var_633_10 = var_633_8.childCount

				for iter_633_4 = 0, var_633_10 - 1 do
					local var_633_11 = var_633_8:GetChild(iter_633_4)

					if var_633_11.name == "" or not string.find(var_633_11.name, "split") then
						var_633_11.gameObject:SetActive(true)
					else
						var_633_11.gameObject:SetActive(false)
					end
				end
			end

			local var_633_12 = 0.001

			if var_633_9 <= arg_630_1.time_ and arg_630_1.time_ < var_633_9 + var_633_12 then
				local var_633_13 = (arg_630_1.time_ - var_633_9) / var_633_12
				local var_633_14 = Vector3.New(0, -331.9, -324)

				var_633_8.localPosition = Vector3.Lerp(arg_630_1.var_.moveOldPos1034, var_633_14, var_633_13)
			end

			if arg_630_1.time_ >= var_633_9 + var_633_12 and arg_630_1.time_ < var_633_9 + var_633_12 + arg_633_0 then
				var_633_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_633_15 = 0
			local var_633_16 = 0.575

			if var_633_15 < arg_630_1.time_ and arg_630_1.time_ <= var_633_15 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_17 = arg_630_1:FormatText(StoryNameCfg[1109].name)

				arg_630_1.leftNameTxt_.text = var_633_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_18 = arg_630_1:GetWordFromCfg(417101152)
				local var_633_19 = arg_630_1:FormatText(var_633_18.content)

				arg_630_1.text_.text = var_633_19

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_20 = 23
				local var_633_21 = utf8.len(var_633_19)
				local var_633_22 = var_633_20 <= 0 and var_633_16 or var_633_16 * (var_633_21 / var_633_20)

				if var_633_22 > 0 and var_633_16 < var_633_22 then
					arg_630_1.talkMaxDuration = var_633_22

					if var_633_22 + var_633_15 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_22 + var_633_15
					end
				end

				arg_630_1.text_.text = var_633_19
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101152", "story_v_out_417101.awb") ~= 0 then
					local var_633_23 = manager.audio:GetVoiceLength("story_v_out_417101", "417101152", "story_v_out_417101.awb") / 1000

					if var_633_23 + var_633_15 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_23 + var_633_15
					end

					if var_633_18.prefab_name ~= "" and arg_630_1.actors_[var_633_18.prefab_name] ~= nil then
						local var_633_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_18.prefab_name].transform, "story_v_out_417101", "417101152", "story_v_out_417101.awb")

						arg_630_1:RecordAudio("417101152", var_633_24)
						arg_630_1:RecordAudio("417101152", var_633_24)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_417101", "417101152", "story_v_out_417101.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_417101", "417101152", "story_v_out_417101.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_25 = math.max(var_633_16, arg_630_1.talkMaxDuration)

			if var_633_15 <= arg_630_1.time_ and arg_630_1.time_ < var_633_15 + var_633_25 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_15) / var_633_25

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_15 + var_633_25 and arg_630_1.time_ < var_633_15 + var_633_25 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {
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

		arg_630_1:InitPlayNodeList()
	end,
	Play417101153 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 417101153
		arg_634_1.duration_ = 3.5

		local var_634_0 = {
			zh = 3.233,
			ja = 3.5
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
			arg_634_1.auto_ = false
		end

		function arg_634_1.playNext_(arg_636_0)
			arg_634_1.onStoryFinished_()
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["1034"]
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.actorSpriteComps1034 == nil then
				arg_634_1.var_.actorSpriteComps1034 = var_637_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_637_2 = 0.2

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_2 and not isNil(var_637_0) then
				local var_637_3 = (arg_634_1.time_ - var_637_1) / var_637_2

				if arg_634_1.var_.actorSpriteComps1034 then
					for iter_637_0, iter_637_1 in pairs(arg_634_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_637_1 then
							if arg_634_1.isInRecall_ then
								local var_637_4 = Mathf.Lerp(iter_637_1.color.r, arg_634_1.hightColor2.r, var_637_3)
								local var_637_5 = Mathf.Lerp(iter_637_1.color.g, arg_634_1.hightColor2.g, var_637_3)
								local var_637_6 = Mathf.Lerp(iter_637_1.color.b, arg_634_1.hightColor2.b, var_637_3)

								iter_637_1.color = Color.New(var_637_4, var_637_5, var_637_6)
							else
								local var_637_7 = Mathf.Lerp(iter_637_1.color.r, 0.5, var_637_3)

								iter_637_1.color = Color.New(var_637_7, var_637_7, var_637_7)
							end
						end
					end
				end
			end

			if arg_634_1.time_ >= var_637_1 + var_637_2 and arg_634_1.time_ < var_637_1 + var_637_2 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.actorSpriteComps1034 then
				for iter_637_2, iter_637_3 in pairs(arg_634_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_637_3 then
						if arg_634_1.isInRecall_ then
							iter_637_3.color = arg_634_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_637_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_634_1.var_.actorSpriteComps1034 = nil
			end

			local var_637_8 = 0
			local var_637_9 = 0.425

			if var_637_8 < arg_634_1.time_ and arg_634_1.time_ <= var_637_8 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_10 = arg_634_1:FormatText(StoryNameCfg[1136].name)

				arg_634_1.leftNameTxt_.text = var_637_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_11 = arg_634_1:GetWordFromCfg(417101153)
				local var_637_12 = arg_634_1:FormatText(var_637_11.content)

				arg_634_1.text_.text = var_637_12

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_13 = 17
				local var_637_14 = utf8.len(var_637_12)
				local var_637_15 = var_637_13 <= 0 and var_637_9 or var_637_9 * (var_637_14 / var_637_13)

				if var_637_15 > 0 and var_637_9 < var_637_15 then
					arg_634_1.talkMaxDuration = var_637_15

					if var_637_15 + var_637_8 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_15 + var_637_8
					end
				end

				arg_634_1.text_.text = var_637_12
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417101", "417101153", "story_v_out_417101.awb") ~= 0 then
					local var_637_16 = manager.audio:GetVoiceLength("story_v_out_417101", "417101153", "story_v_out_417101.awb") / 1000

					if var_637_16 + var_637_8 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_16 + var_637_8
					end

					if var_637_11.prefab_name ~= "" and arg_634_1.actors_[var_637_11.prefab_name] ~= nil then
						local var_637_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_11.prefab_name].transform, "story_v_out_417101", "417101153", "story_v_out_417101.awb")

						arg_634_1:RecordAudio("417101153", var_637_17)
						arg_634_1:RecordAudio("417101153", var_637_17)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_417101", "417101153", "story_v_out_417101.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_417101", "417101153", "story_v_out_417101.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_18 = math.max(var_637_9, arg_634_1.talkMaxDuration)

			if var_637_8 <= arg_634_1.time_ and arg_634_1.time_ < var_637_8 + var_637_18 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_8) / var_637_18

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_8 + var_637_18 and arg_634_1.time_ < var_637_8 + var_637_18 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2102",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/I16h",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2106",
		"TextureConfig/Background/I07a"
	},
	voices = {
		"story_v_out_417101.awb"
	}
}
