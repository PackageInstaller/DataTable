return {
	Play417031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417031001
		arg_1_1.duration_ = 14.03

		local var_1_0 = {
			zh = 11.433,
			ja = 14.033
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
				arg_1_0:Play417031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST77a"

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
				local var_4_5 = arg_1_1.bgs_.ST77a

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
					if iter_4_0 ~= "ST77a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0
			local var_4_17 = 0.2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_18 = "play"
				local var_4_19 = "music"

				arg_1_1:AudioAction(var_4_18, var_4_19, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = ""
				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_21 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 0.25
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

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

			local var_4_28 = 0
			local var_4_29 = 3
			local var_4_30 = "ST77a"

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_30)

				arg_1_1.timestampColorController_:SetSelectedState("hot")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_31 = arg_1_1:GetWordFromCfg(501009)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_timeText_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_33 = arg_1_1:GetWordFromCfg(501010)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_siteText_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_35 = 3

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_36 = 1.2

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Color.New(0, 0, 0)

				var_4_38.a = Mathf.Lerp(0, 1, var_4_37)
				arg_1_1.mask_.color = var_4_38
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				local var_4_39 = Color.New(0, 0, 0)

				var_4_39.a = 1
				arg_1_1.mask_.color = var_4_39
			end

			local var_4_40 = 4.2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_41 = 1.2

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41
				local var_4_43 = Color.New(0, 0, 0)

				var_4_43.a = Mathf.Lerp(1, 0, var_4_42)
				arg_1_1.mask_.color = var_4_43
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				local var_4_44 = Color.New(0, 0, 0)
				local var_4_45 = 0

				arg_1_1.mask_.enabled = false
				var_4_44.a = var_4_45
				arg_1_1.mask_.color = var_4_44
			end

			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_47 = 1

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_46) / var_4_47
				local var_4_49 = Color.New(0, 0, 0)

				var_4_49.a = Mathf.Lerp(1, 0, var_4_48)
				arg_1_1.mask_.color = var_4_49
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				local var_4_50 = Color.New(0, 0, 0)
				local var_4_51 = 0

				arg_1_1.mask_.enabled = false
				var_4_50.a = var_4_51
				arg_1_1.mask_.color = var_4_50
			end

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_53 = 3

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 5.4
			local var_4_55 = 0.775

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[1109].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_58 = arg_1_1:GetWordFromCfg(417031001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 31
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031001", "story_v_out_417031.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_417031", "417031001", "story_v_out_417031.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_417031", "417031001", "story_v_out_417031.awb")

						arg_1_1:RecordAudio("417031001", var_4_64)
						arg_1_1:RecordAudio("417031001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417031", "417031001", "story_v_out_417031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417031", "417031001", "story_v_out_417031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417031002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417031002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417031003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "10022"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(var_13_1, arg_10_1.canvasGo_.transform)

					var_13_2.transform:SetSiblingIndex(1)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs(var_13_3) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_4 = arg_10_1.actors_["10022"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps10022 == nil then
				arg_10_1.var_.actorSpriteComps10022 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps10022 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								local var_13_8 = Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor2.r, var_13_7)
								local var_13_9 = Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor2.g, var_13_7)
								local var_13_10 = Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor2.b, var_13_7)

								iter_13_3.color = Color.New(var_13_8, var_13_9, var_13_10)
							else
								local var_13_11 = Mathf.Lerp(iter_13_3.color.r, 0.5, var_13_7)

								iter_13_3.color = Color.New(var_13_11, var_13_11, var_13_11)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps10022 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_13_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps10022 = nil
			end

			local var_13_12 = 0.05
			local var_13_13 = 1

			if var_13_12 < arg_10_1.time_ and arg_10_1.time_ <= var_13_12 + arg_13_0 then
				local var_13_14 = "play"
				local var_13_15 = "effect"

				arg_10_1:AudioAction(var_13_14, var_13_15, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_13_16 = 0
			local var_13_17 = 1.25

			if var_13_16 < arg_10_1.time_ and arg_10_1.time_ <= var_13_16 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_18 = arg_10_1:GetWordFromCfg(417031002)
				local var_13_19 = arg_10_1:FormatText(var_13_18.content)

				arg_10_1.text_.text = var_13_19

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_20 = 50
				local var_13_21 = utf8.len(var_13_19)
				local var_13_22 = var_13_20 <= 0 and var_13_17 or var_13_17 * (var_13_21 / var_13_20)

				if var_13_22 > 0 and var_13_17 < var_13_22 then
					arg_10_1.talkMaxDuration = var_13_22

					if var_13_22 + var_13_16 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_22 + var_13_16
					end
				end

				arg_10_1.text_.text = var_13_19
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_23 = math.max(var_13_17, arg_10_1.talkMaxDuration)

			if var_13_16 <= arg_10_1.time_ and arg_10_1.time_ < var_13_16 + var_13_23 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_16) / var_13_23

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_16 + var_13_23 and arg_10_1.time_ < var_13_16 + var_13_23 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417031003
		arg_14_1.duration_ = 9.1

		local var_14_0 = {
			zh = 6.2,
			ja = 9.1
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.825

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_2 = arg_14_1:FormatText(StoryNameCfg[1109].name)

				arg_14_1.leftNameTxt_.text = var_17_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_3 = arg_14_1:GetWordFromCfg(417031003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 33
				local var_17_6 = utf8.len(var_17_4)
				local var_17_7 = var_17_5 <= 0 and var_17_1 or var_17_1 * (var_17_6 / var_17_5)

				if var_17_7 > 0 and var_17_1 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031003", "story_v_out_417031.awb") ~= 0 then
					local var_17_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031003", "story_v_out_417031.awb") / 1000

					if var_17_8 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_8 + var_17_0
					end

					if var_17_3.prefab_name ~= "" and arg_14_1.actors_[var_17_3.prefab_name] ~= nil then
						local var_17_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_3.prefab_name].transform, "story_v_out_417031", "417031003", "story_v_out_417031.awb")

						arg_14_1:RecordAudio("417031003", var_17_9)
						arg_14_1:RecordAudio("417031003", var_17_9)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417031", "417031003", "story_v_out_417031.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417031", "417031003", "story_v_out_417031.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_10 and arg_14_1.time_ < var_17_0 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417031004
		arg_18_1.duration_ = 10.6

		local var_18_0 = {
			zh = 9.4,
			ja = 10.6
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
				arg_18_0:Play417031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.25

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[1109].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(417031004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031004", "story_v_out_417031.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031004", "story_v_out_417031.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417031", "417031004", "story_v_out_417031.awb")

						arg_18_1:RecordAudio("417031004", var_21_9)
						arg_18_1:RecordAudio("417031004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417031", "417031004", "story_v_out_417031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417031", "417031004", "story_v_out_417031.awb")
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
	Play417031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417031005
		arg_22_1.duration_ = 10

		local var_22_0 = {
			zh = 10,
			ja = 9.133
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
				arg_22_0:Play417031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 1.25

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[1109].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(417031005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031005", "story_v_out_417031.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031005", "story_v_out_417031.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_417031", "417031005", "story_v_out_417031.awb")

						arg_22_1:RecordAudio("417031005", var_25_9)
						arg_22_1:RecordAudio("417031005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417031", "417031005", "story_v_out_417031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417031", "417031005", "story_v_out_417031.awb")
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
	Play417031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417031006
		arg_26_1.duration_ = 12.97

		local var_26_0 = {
			zh = 6.366,
			ja = 12.966
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
				arg_26_0:Play417031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.775

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[1109].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(417031006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 31
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031006", "story_v_out_417031.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031006", "story_v_out_417031.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_417031", "417031006", "story_v_out_417031.awb")

						arg_26_1:RecordAudio("417031006", var_29_9)
						arg_26_1:RecordAudio("417031006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417031", "417031006", "story_v_out_417031.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417031", "417031006", "story_v_out_417031.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417031007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.4
			local var_33_1 = 1

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				local var_33_2 = "play"
				local var_33_3 = "effect"

				arg_30_1:AudioAction(var_33_2, var_33_3, "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_33_4 = 0
			local var_33_5 = 1.675

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(417031007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_8 = 67
				local var_33_9 = utf8.len(var_33_7)
				local var_33_10 = var_33_8 <= 0 and var_33_5 or var_33_5 * (var_33_9 / var_33_8)

				if var_33_10 > 0 and var_33_5 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_11 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_11 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_11

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_11 and arg_30_1.time_ < var_33_4 + var_33_11 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417031008
		arg_34_1.duration_ = 2.97

		local var_34_0 = {
			zh = 1.633,
			ja = 2.966
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
				arg_34_0:Play417031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "1015"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1015")

				if not isNil(var_37_1) then
					local var_37_2 = Object.Instantiate(var_37_1, arg_34_1.canvasGo_.transform)

					var_37_2.transform:SetSiblingIndex(1)

					var_37_2.name = var_37_0
					var_37_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_34_1.actors_[var_37_0] = var_37_2

					local var_37_3 = var_37_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_34_1.isInRecall_ then
						for iter_37_0, iter_37_1 in ipairs(var_37_3) do
							iter_37_1.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_37_4 = arg_34_1.actors_["1015"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.actorSpriteComps1015 == nil then
				arg_34_1.var_.actorSpriteComps1015 = var_37_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_6 = 0.2

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.actorSpriteComps1015 then
					for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_37_3 then
							if arg_34_1.isInRecall_ then
								local var_37_8 = Mathf.Lerp(iter_37_3.color.r, arg_34_1.hightColor1.r, var_37_7)
								local var_37_9 = Mathf.Lerp(iter_37_3.color.g, arg_34_1.hightColor1.g, var_37_7)
								local var_37_10 = Mathf.Lerp(iter_37_3.color.b, arg_34_1.hightColor1.b, var_37_7)

								iter_37_3.color = Color.New(var_37_8, var_37_9, var_37_10)
							else
								local var_37_11 = Mathf.Lerp(iter_37_3.color.r, 1, var_37_7)

								iter_37_3.color = Color.New(var_37_11, var_37_11, var_37_11)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.actorSpriteComps1015 then
				for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_37_5 then
						if arg_34_1.isInRecall_ then
							iter_37_5.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1015 = nil
			end

			local var_37_12 = arg_34_1.actors_["1015"].transform
			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1.var_.moveOldPos1015 = var_37_12.localPosition
				var_37_12.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1015", 3)

				local var_37_14 = var_37_12.childCount

				for iter_37_6 = 0, var_37_14 - 1 do
					local var_37_15 = var_37_12:GetChild(iter_37_6)

					if var_37_15.name == "" or not string.find(var_37_15.name, "split") then
						var_37_15.gameObject:SetActive(true)
					else
						var_37_15.gameObject:SetActive(false)
					end
				end
			end

			local var_37_16 = 0.001

			if var_37_13 <= arg_34_1.time_ and arg_34_1.time_ < var_37_13 + var_37_16 then
				local var_37_17 = (arg_34_1.time_ - var_37_13) / var_37_16
				local var_37_18 = Vector3.New(0, -340, -288)

				var_37_12.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1015, var_37_18, var_37_17)
			end

			if arg_34_1.time_ >= var_37_13 + var_37_16 and arg_34_1.time_ < var_37_13 + var_37_16 + arg_37_0 then
				var_37_12.localPosition = Vector3.New(0, -340, -288)
			end

			local var_37_19 = 0
			local var_37_20 = 0.175

			if var_37_19 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_21 = arg_34_1:FormatText(StoryNameCfg[479].name)

				arg_34_1.leftNameTxt_.text = var_37_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_22 = arg_34_1:GetWordFromCfg(417031008)
				local var_37_23 = arg_34_1:FormatText(var_37_22.content)

				arg_34_1.text_.text = var_37_23

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_24 = 7
				local var_37_25 = utf8.len(var_37_23)
				local var_37_26 = var_37_24 <= 0 and var_37_20 or var_37_20 * (var_37_25 / var_37_24)

				if var_37_26 > 0 and var_37_20 < var_37_26 then
					arg_34_1.talkMaxDuration = var_37_26

					if var_37_26 + var_37_19 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_26 + var_37_19
					end
				end

				arg_34_1.text_.text = var_37_23
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031008", "story_v_out_417031.awb") ~= 0 then
					local var_37_27 = manager.audio:GetVoiceLength("story_v_out_417031", "417031008", "story_v_out_417031.awb") / 1000

					if var_37_27 + var_37_19 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_27 + var_37_19
					end

					if var_37_22.prefab_name ~= "" and arg_34_1.actors_[var_37_22.prefab_name] ~= nil then
						local var_37_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_22.prefab_name].transform, "story_v_out_417031", "417031008", "story_v_out_417031.awb")

						arg_34_1:RecordAudio("417031008", var_37_28)
						arg_34_1:RecordAudio("417031008", var_37_28)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417031", "417031008", "story_v_out_417031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417031", "417031008", "story_v_out_417031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_29 = math.max(var_37_20, arg_34_1.talkMaxDuration)

			if var_37_19 <= arg_34_1.time_ and arg_34_1.time_ < var_37_19 + var_37_29 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_19) / var_37_29

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_19 + var_37_29 and arg_34_1.time_ < var_37_19 + var_37_29 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417031009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1015"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1015 == nil then
				arg_38_1.var_.actorSpriteComps1015 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1015 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor2.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor2.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor2.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 0.5, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1015 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1015 = nil
			end

			local var_41_8 = 0.05
			local var_41_9 = 1

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				local var_41_10 = "play"
				local var_41_11 = "effect"

				arg_38_1:AudioAction(var_41_10, var_41_11, "se_story_1310", "se_story_1310_hit", "")
			end

			local var_41_12 = 0
			local var_41_13 = 0.75

			if var_41_12 < arg_38_1.time_ and arg_38_1.time_ <= var_41_12 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_14 = arg_38_1:GetWordFromCfg(417031009)
				local var_41_15 = arg_38_1:FormatText(var_41_14.content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 30
				local var_41_17 = utf8.len(var_41_15)
				local var_41_18 = var_41_16 <= 0 and var_41_13 or var_41_13 * (var_41_17 / var_41_16)

				if var_41_18 > 0 and var_41_13 < var_41_18 then
					arg_38_1.talkMaxDuration = var_41_18

					if var_41_18 + var_41_12 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_18 + var_41_12
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_19 = math.max(var_41_13, arg_38_1.talkMaxDuration)

			if var_41_12 <= arg_38_1.time_ and arg_38_1.time_ < var_41_12 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_12) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_12 + var_41_19 and arg_38_1.time_ < var_41_12 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417031010
		arg_42_1.duration_ = 2.53

		local var_42_0 = {
			zh = 2.533,
			ja = 1.733
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
				arg_42_0:Play417031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1015"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1015 == nil then
				arg_42_1.var_.actorSpriteComps1015 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1015 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 1, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1015 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1015 = nil
			end

			local var_45_8 = arg_42_1.actors_["1015"].transform
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 then
				arg_42_1.var_.moveOldPos1015 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1015", 3)

				local var_45_10 = var_45_8.childCount

				for iter_45_4 = 0, var_45_10 - 1 do
					local var_45_11 = var_45_8:GetChild(iter_45_4)

					if var_45_11.name == "split_5" or not string.find(var_45_11.name, "split") then
						var_45_11.gameObject:SetActive(true)
					else
						var_45_11.gameObject:SetActive(false)
					end
				end
			end

			local var_45_12 = 0.001

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_12 then
				local var_45_13 = (arg_42_1.time_ - var_45_9) / var_45_12
				local var_45_14 = Vector3.New(0, -340, -288)

				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1015, var_45_14, var_45_13)
			end

			if arg_42_1.time_ >= var_45_9 + var_45_12 and arg_42_1.time_ < var_45_9 + var_45_12 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(0, -340, -288)
			end

			local var_45_15 = 0
			local var_45_16 = 0.2

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_17 = arg_42_1:FormatText(StoryNameCfg[479].name)

				arg_42_1.leftNameTxt_.text = var_45_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_18 = arg_42_1:GetWordFromCfg(417031010)
				local var_45_19 = arg_42_1:FormatText(var_45_18.content)

				arg_42_1.text_.text = var_45_19

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_20 = 8
				local var_45_21 = utf8.len(var_45_19)
				local var_45_22 = var_45_20 <= 0 and var_45_16 or var_45_16 * (var_45_21 / var_45_20)

				if var_45_22 > 0 and var_45_16 < var_45_22 then
					arg_42_1.talkMaxDuration = var_45_22

					if var_45_22 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_22 + var_45_15
					end
				end

				arg_42_1.text_.text = var_45_19
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031010", "story_v_out_417031.awb") ~= 0 then
					local var_45_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031010", "story_v_out_417031.awb") / 1000

					if var_45_23 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_15
					end

					if var_45_18.prefab_name ~= "" and arg_42_1.actors_[var_45_18.prefab_name] ~= nil then
						local var_45_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_18.prefab_name].transform, "story_v_out_417031", "417031010", "story_v_out_417031.awb")

						arg_42_1:RecordAudio("417031010", var_45_24)
						arg_42_1:RecordAudio("417031010", var_45_24)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417031", "417031010", "story_v_out_417031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417031", "417031010", "story_v_out_417031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_25 = math.max(var_45_16, arg_42_1.talkMaxDuration)

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_25 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_15) / var_45_25

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_15 + var_45_25 and arg_42_1.time_ < var_45_15 + var_45_25 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play417031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417031011
		arg_46_1.duration_ = 4.63

		local var_46_0 = {
			zh = 1.766,
			ja = 4.633
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
				arg_46_0:Play417031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "1034"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(var_49_1, arg_46_1.canvasGo_.transform)

					var_49_2.transform:SetSiblingIndex(1)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs(var_49_3) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_4 = arg_46_1.actors_["1034"]
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = var_49_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_6 = 0.2

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 and not isNil(var_49_4) then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6

				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								local var_49_8 = Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, var_49_7)
								local var_49_9 = Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, var_49_7)
								local var_49_10 = Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, var_49_7)

								iter_49_3.color = Color.New(var_49_8, var_49_9, var_49_10)
							else
								local var_49_11 = Mathf.Lerp(iter_49_3.color.r, 1, var_49_7)

								iter_49_3.color = Color.New(var_49_11, var_49_11, var_49_11)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_5 then
						if arg_46_1.isInRecall_ then
							iter_49_5.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_12 = arg_46_1.actors_["1015"]
			local var_49_13 = 0

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 and not isNil(var_49_12) and arg_46_1.var_.actorSpriteComps1015 == nil then
				arg_46_1.var_.actorSpriteComps1015 = var_49_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_14 = 0.2

			if var_49_13 <= arg_46_1.time_ and arg_46_1.time_ < var_49_13 + var_49_14 and not isNil(var_49_12) then
				local var_49_15 = (arg_46_1.time_ - var_49_13) / var_49_14

				if arg_46_1.var_.actorSpriteComps1015 then
					for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_49_7 then
							if arg_46_1.isInRecall_ then
								local var_49_16 = Mathf.Lerp(iter_49_7.color.r, arg_46_1.hightColor2.r, var_49_15)
								local var_49_17 = Mathf.Lerp(iter_49_7.color.g, arg_46_1.hightColor2.g, var_49_15)
								local var_49_18 = Mathf.Lerp(iter_49_7.color.b, arg_46_1.hightColor2.b, var_49_15)

								iter_49_7.color = Color.New(var_49_16, var_49_17, var_49_18)
							else
								local var_49_19 = Mathf.Lerp(iter_49_7.color.r, 0.5, var_49_15)

								iter_49_7.color = Color.New(var_49_19, var_49_19, var_49_19)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_13 + var_49_14 and arg_46_1.time_ < var_49_13 + var_49_14 + arg_49_0 and not isNil(var_49_12) and arg_46_1.var_.actorSpriteComps1015 then
				for iter_49_8, iter_49_9 in pairs(arg_46_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_49_9 then
						if arg_46_1.isInRecall_ then
							iter_49_9.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1015 = nil
			end

			local var_49_20 = arg_46_1.actors_["1015"].transform
			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1.var_.moveOldPos1015 = var_49_20.localPosition
				var_49_20.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1015", 7)

				local var_49_22 = var_49_20.childCount

				for iter_49_10 = 0, var_49_22 - 1 do
					local var_49_23 = var_49_20:GetChild(iter_49_10)

					if var_49_23.name == "" or not string.find(var_49_23.name, "split") then
						var_49_23.gameObject:SetActive(true)
					else
						var_49_23.gameObject:SetActive(false)
					end
				end
			end

			local var_49_24 = 0.001

			if var_49_21 <= arg_46_1.time_ and arg_46_1.time_ < var_49_21 + var_49_24 then
				local var_49_25 = (arg_46_1.time_ - var_49_21) / var_49_24
				local var_49_26 = Vector3.New(0, -2000, 0)

				var_49_20.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1015, var_49_26, var_49_25)
			end

			if arg_46_1.time_ >= var_49_21 + var_49_24 and arg_46_1.time_ < var_49_21 + var_49_24 + arg_49_0 then
				var_49_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_27 = arg_46_1.actors_["1034"].transform
			local var_49_28 = 0

			if var_49_28 < arg_46_1.time_ and arg_46_1.time_ <= var_49_28 + arg_49_0 then
				arg_46_1.var_.moveOldPos1034 = var_49_27.localPosition
				var_49_27.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1034", 3)

				local var_49_29 = var_49_27.childCount

				for iter_49_11 = 0, var_49_29 - 1 do
					local var_49_30 = var_49_27:GetChild(iter_49_11)

					if var_49_30.name == "split_6" or not string.find(var_49_30.name, "split") then
						var_49_30.gameObject:SetActive(true)
					else
						var_49_30.gameObject:SetActive(false)
					end
				end
			end

			local var_49_31 = 0.001

			if var_49_28 <= arg_46_1.time_ and arg_46_1.time_ < var_49_28 + var_49_31 then
				local var_49_32 = (arg_46_1.time_ - var_49_28) / var_49_31
				local var_49_33 = Vector3.New(0, -331.9, -324)

				var_49_27.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1034, var_49_33, var_49_32)
			end

			if arg_46_1.time_ >= var_49_28 + var_49_31 and arg_46_1.time_ < var_49_28 + var_49_31 + arg_49_0 then
				var_49_27.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_49_34 = 0
			local var_49_35 = 0.2

			if var_49_34 < arg_46_1.time_ and arg_46_1.time_ <= var_49_34 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_36 = arg_46_1:FormatText(StoryNameCfg[1109].name)

				arg_46_1.leftNameTxt_.text = var_49_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_37 = arg_46_1:GetWordFromCfg(417031011)
				local var_49_38 = arg_46_1:FormatText(var_49_37.content)

				arg_46_1.text_.text = var_49_38

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_39 = 8
				local var_49_40 = utf8.len(var_49_38)
				local var_49_41 = var_49_39 <= 0 and var_49_35 or var_49_35 * (var_49_40 / var_49_39)

				if var_49_41 > 0 and var_49_35 < var_49_41 then
					arg_46_1.talkMaxDuration = var_49_41

					if var_49_41 + var_49_34 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_41 + var_49_34
					end
				end

				arg_46_1.text_.text = var_49_38
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031011", "story_v_out_417031.awb") ~= 0 then
					local var_49_42 = manager.audio:GetVoiceLength("story_v_out_417031", "417031011", "story_v_out_417031.awb") / 1000

					if var_49_42 + var_49_34 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_42 + var_49_34
					end

					if var_49_37.prefab_name ~= "" and arg_46_1.actors_[var_49_37.prefab_name] ~= nil then
						local var_49_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_37.prefab_name].transform, "story_v_out_417031", "417031011", "story_v_out_417031.awb")

						arg_46_1:RecordAudio("417031011", var_49_43)
						arg_46_1:RecordAudio("417031011", var_49_43)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417031", "417031011", "story_v_out_417031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417031", "417031011", "story_v_out_417031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_44 = math.max(var_49_35, arg_46_1.talkMaxDuration)

			if var_49_34 <= arg_46_1.time_ and arg_46_1.time_ < var_49_34 + var_49_44 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_34) / var_49_44

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_34 + var_49_44 and arg_46_1.time_ < var_49_34 + var_49_44 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
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
	Play417031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417031012
		arg_50_1.duration_ = 4.8

		local var_50_0 = {
			zh = 4.8,
			ja = 4.133
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
				arg_50_0:Play417031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1015"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1015 == nil then
				arg_50_1.var_.actorSpriteComps1015 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps1015 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1015 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps1015 = nil
			end

			local var_53_8 = arg_50_1.actors_["1034"]
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps1034 == nil then
				arg_50_1.var_.actorSpriteComps1034 = var_53_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_10 = 0.2

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_10 and not isNil(var_53_8) then
				local var_53_11 = (arg_50_1.time_ - var_53_9) / var_53_10

				if arg_50_1.var_.actorSpriteComps1034 then
					for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_53_5 then
							if arg_50_1.isInRecall_ then
								local var_53_12 = Mathf.Lerp(iter_53_5.color.r, arg_50_1.hightColor2.r, var_53_11)
								local var_53_13 = Mathf.Lerp(iter_53_5.color.g, arg_50_1.hightColor2.g, var_53_11)
								local var_53_14 = Mathf.Lerp(iter_53_5.color.b, arg_50_1.hightColor2.b, var_53_11)

								iter_53_5.color = Color.New(var_53_12, var_53_13, var_53_14)
							else
								local var_53_15 = Mathf.Lerp(iter_53_5.color.r, 0.5, var_53_11)

								iter_53_5.color = Color.New(var_53_15, var_53_15, var_53_15)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_9 + var_53_10 and arg_50_1.time_ < var_53_9 + var_53_10 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps1034 then
				for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_53_7 then
						if arg_50_1.isInRecall_ then
							iter_53_7.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps1034 = nil
			end

			local var_53_16 = arg_50_1.actors_["1034"].transform
			local var_53_17 = 0

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_16.localPosition
				var_53_16.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 4)

				local var_53_18 = var_53_16.childCount

				for iter_53_8 = 0, var_53_18 - 1 do
					local var_53_19 = var_53_16:GetChild(iter_53_8)

					if var_53_19.name == "split_6" or not string.find(var_53_19.name, "split") then
						var_53_19.gameObject:SetActive(true)
					else
						var_53_19.gameObject:SetActive(false)
					end
				end
			end

			local var_53_20 = 0.001

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_20 then
				local var_53_21 = (arg_50_1.time_ - var_53_17) / var_53_20
				local var_53_22 = Vector3.New(373.7, -331.9, -324)

				var_53_16.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, var_53_22, var_53_21)
			end

			if arg_50_1.time_ >= var_53_17 + var_53_20 and arg_50_1.time_ < var_53_17 + var_53_20 + arg_53_0 then
				var_53_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_53_23 = arg_50_1.actors_["1015"].transform
			local var_53_24 = 0

			if var_53_24 < arg_50_1.time_ and arg_50_1.time_ <= var_53_24 + arg_53_0 then
				arg_50_1.var_.moveOldPos1015 = var_53_23.localPosition
				var_53_23.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1015", 2)

				local var_53_25 = var_53_23.childCount

				for iter_53_9 = 0, var_53_25 - 1 do
					local var_53_26 = var_53_23:GetChild(iter_53_9)

					if var_53_26.name == "split_4" or not string.find(var_53_26.name, "split") then
						var_53_26.gameObject:SetActive(true)
					else
						var_53_26.gameObject:SetActive(false)
					end
				end
			end

			local var_53_27 = 0.001

			if var_53_24 <= arg_50_1.time_ and arg_50_1.time_ < var_53_24 + var_53_27 then
				local var_53_28 = (arg_50_1.time_ - var_53_24) / var_53_27
				local var_53_29 = Vector3.New(-390, -340, -288)

				var_53_23.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1015, var_53_29, var_53_28)
			end

			if arg_50_1.time_ >= var_53_24 + var_53_27 and arg_50_1.time_ < var_53_24 + var_53_27 + arg_53_0 then
				var_53_23.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_53_30 = 0
			local var_53_31 = 0.675

			if var_53_30 < arg_50_1.time_ and arg_50_1.time_ <= var_53_30 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_32 = arg_50_1:FormatText(StoryNameCfg[479].name)

				arg_50_1.leftNameTxt_.text = var_53_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_33 = arg_50_1:GetWordFromCfg(417031012)
				local var_53_34 = arg_50_1:FormatText(var_53_33.content)

				arg_50_1.text_.text = var_53_34

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_35 = 27
				local var_53_36 = utf8.len(var_53_34)
				local var_53_37 = var_53_35 <= 0 and var_53_31 or var_53_31 * (var_53_36 / var_53_35)

				if var_53_37 > 0 and var_53_31 < var_53_37 then
					arg_50_1.talkMaxDuration = var_53_37

					if var_53_37 + var_53_30 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_37 + var_53_30
					end
				end

				arg_50_1.text_.text = var_53_34
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031012", "story_v_out_417031.awb") ~= 0 then
					local var_53_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031012", "story_v_out_417031.awb") / 1000

					if var_53_38 + var_53_30 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_38 + var_53_30
					end

					if var_53_33.prefab_name ~= "" and arg_50_1.actors_[var_53_33.prefab_name] ~= nil then
						local var_53_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_33.prefab_name].transform, "story_v_out_417031", "417031012", "story_v_out_417031.awb")

						arg_50_1:RecordAudio("417031012", var_53_39)
						arg_50_1:RecordAudio("417031012", var_53_39)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417031", "417031012", "story_v_out_417031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417031", "417031012", "story_v_out_417031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_40 = math.max(var_53_31, arg_50_1.talkMaxDuration)

			if var_53_30 <= arg_50_1.time_ and arg_50_1.time_ < var_53_30 + var_53_40 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_30) / var_53_40

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_30 + var_53_40 and arg_50_1.time_ < var_53_30 + var_53_40 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "1015",
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
	Play417031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417031013
		arg_54_1.duration_ = 8.8

		local var_54_0 = {
			zh = 6.133,
			ja = 8.8
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
				arg_54_0:Play417031014(arg_54_1)
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

			local var_57_8 = arg_54_1.actors_["1015"]
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps1015 == nil then
				arg_54_1.var_.actorSpriteComps1015 = var_57_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_10 = 0.2

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_10 and not isNil(var_57_8) then
				local var_57_11 = (arg_54_1.time_ - var_57_9) / var_57_10

				if arg_54_1.var_.actorSpriteComps1015 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_54_1.time_ >= var_57_9 + var_57_10 and arg_54_1.time_ < var_57_9 + var_57_10 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps1015 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_57_7 then
						if arg_54_1.isInRecall_ then
							iter_57_7.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1015 = nil
			end

			local var_57_16 = 0
			local var_57_17 = 0.775

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_18 = arg_54_1:FormatText(StoryNameCfg[1109].name)

				arg_54_1.leftNameTxt_.text = var_57_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_19 = arg_54_1:GetWordFromCfg(417031013)
				local var_57_20 = arg_54_1:FormatText(var_57_19.content)

				arg_54_1.text_.text = var_57_20

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_21 = 31
				local var_57_22 = utf8.len(var_57_20)
				local var_57_23 = var_57_21 <= 0 and var_57_17 or var_57_17 * (var_57_22 / var_57_21)

				if var_57_23 > 0 and var_57_17 < var_57_23 then
					arg_54_1.talkMaxDuration = var_57_23

					if var_57_23 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_16
					end
				end

				arg_54_1.text_.text = var_57_20
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031013", "story_v_out_417031.awb") ~= 0 then
					local var_57_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031013", "story_v_out_417031.awb") / 1000

					if var_57_24 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_24 + var_57_16
					end

					if var_57_19.prefab_name ~= "" and arg_54_1.actors_[var_57_19.prefab_name] ~= nil then
						local var_57_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_19.prefab_name].transform, "story_v_out_417031", "417031013", "story_v_out_417031.awb")

						arg_54_1:RecordAudio("417031013", var_57_25)
						arg_54_1:RecordAudio("417031013", var_57_25)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417031", "417031013", "story_v_out_417031.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417031", "417031013", "story_v_out_417031.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_26 = math.max(var_57_17, arg_54_1.talkMaxDuration)

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_26 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_16) / var_57_26

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_16 + var_57_26 and arg_54_1.time_ < var_57_16 + var_57_26 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417031014
		arg_58_1.duration_ = 7.83

		local var_58_0 = {
			zh = 7.7,
			ja = 7.833
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
				arg_58_0:Play417031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.95

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1109].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(417031014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031014", "story_v_out_417031.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031014", "story_v_out_417031.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_417031", "417031014", "story_v_out_417031.awb")

						arg_58_1:RecordAudio("417031014", var_61_9)
						arg_58_1:RecordAudio("417031014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417031", "417031014", "story_v_out_417031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417031", "417031014", "story_v_out_417031.awb")
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
	Play417031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417031015
		arg_62_1.duration_ = 11.4

		local var_62_0 = {
			zh = 6.833,
			ja = 11.4
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
				arg_62_0:Play417031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1034"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1034 = var_65_0.localPosition
				var_65_0.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1034", 4)

				local var_65_2 = var_65_0.childCount

				for iter_65_0 = 0, var_65_2 - 1 do
					local var_65_3 = var_65_0:GetChild(iter_65_0)

					if var_65_3.name == "split_6" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_4 then
				local var_65_5 = (arg_62_1.time_ - var_65_1) / var_65_4
				local var_65_6 = Vector3.New(373.7, -331.9, -324)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1034, var_65_6, var_65_5)
			end

			if arg_62_1.time_ >= var_65_1 + var_65_4 and arg_62_1.time_ < var_65_1 + var_65_4 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_65_7 = 0
			local var_65_8 = 0.725

			if var_65_7 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_9 = arg_62_1:FormatText(StoryNameCfg[1109].name)

				arg_62_1.leftNameTxt_.text = var_65_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(417031015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_12 = 29
				local var_65_13 = utf8.len(var_65_11)
				local var_65_14 = var_65_12 <= 0 and var_65_8 or var_65_8 * (var_65_13 / var_65_12)

				if var_65_14 > 0 and var_65_8 < var_65_14 then
					arg_62_1.talkMaxDuration = var_65_14

					if var_65_14 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_7
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031015", "story_v_out_417031.awb") ~= 0 then
					local var_65_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031015", "story_v_out_417031.awb") / 1000

					if var_65_15 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_15 + var_65_7
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_417031", "417031015", "story_v_out_417031.awb")

						arg_62_1:RecordAudio("417031015", var_65_16)
						arg_62_1:RecordAudio("417031015", var_65_16)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417031", "417031015", "story_v_out_417031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417031", "417031015", "story_v_out_417031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_17 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_17 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_17

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_17 and arg_62_1.time_ < var_65_7 + var_65_17 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play417031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417031016
		arg_66_1.duration_ = 3.8

		local var_66_0 = {
			zh = 3.8,
			ja = 3
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
				arg_66_0:Play417031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1015"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1015 == nil then
				arg_66_1.var_.actorSpriteComps1015 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps1015 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1015 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1015 = nil
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

			local var_69_16 = arg_66_1.actors_["1015"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos1015 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1015", 2)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "" or not string.find(var_69_19.name, "split") then
						var_69_19.gameObject:SetActive(true)
					else
						var_69_19.gameObject:SetActive(false)
					end
				end
			end

			local var_69_20 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(-390, -340, -288)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1015, var_69_22, var_69_21)
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_69_23 = 0
			local var_69_24 = 0.45

			if var_69_23 < arg_66_1.time_ and arg_66_1.time_ <= var_69_23 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_25 = arg_66_1:FormatText(StoryNameCfg[479].name)

				arg_66_1.leftNameTxt_.text = var_69_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_26 = arg_66_1:GetWordFromCfg(417031016)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.text_.text = var_69_27

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031016", "story_v_out_417031.awb") ~= 0 then
					local var_69_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031016", "story_v_out_417031.awb") / 1000

					if var_69_31 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_31 + var_69_23
					end

					if var_69_26.prefab_name ~= "" and arg_66_1.actors_[var_69_26.prefab_name] ~= nil then
						local var_69_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_26.prefab_name].transform, "story_v_out_417031", "417031016", "story_v_out_417031.awb")

						arg_66_1:RecordAudio("417031016", var_69_32)
						arg_66_1:RecordAudio("417031016", var_69_32)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417031", "417031016", "story_v_out_417031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417031", "417031016", "story_v_out_417031.awb")
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
				actorName = "1015",
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
	Play417031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417031017
		arg_70_1.duration_ = 2.57

		local var_70_0 = {
			zh = 1.633,
			ja = 2.566
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1034"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			local var_73_8 = arg_70_1.actors_["1015"]
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps1015 == nil then
				arg_70_1.var_.actorSpriteComps1015 = var_73_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_10 = 0.2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 and not isNil(var_73_8) then
				local var_73_11 = (arg_70_1.time_ - var_73_9) / var_73_10

				if arg_70_1.var_.actorSpriteComps1015 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_12 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, var_73_11)
								local var_73_13 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, var_73_11)
								local var_73_14 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, var_73_11)

								iter_73_5.color = Color.New(var_73_12, var_73_13, var_73_14)
							else
								local var_73_15 = Mathf.Lerp(iter_73_5.color.r, 0.5, var_73_11)

								iter_73_5.color = Color.New(var_73_15, var_73_15, var_73_15)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps1015 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1015 = nil
			end

			local var_73_16 = 0
			local var_73_17 = 0.15

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_18 = arg_70_1:FormatText(StoryNameCfg[1109].name)

				arg_70_1.leftNameTxt_.text = var_73_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_19 = arg_70_1:GetWordFromCfg(417031017)
				local var_73_20 = arg_70_1:FormatText(var_73_19.content)

				arg_70_1.text_.text = var_73_20

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 6
				local var_73_22 = utf8.len(var_73_20)
				local var_73_23 = var_73_21 <= 0 and var_73_17 or var_73_17 * (var_73_22 / var_73_21)

				if var_73_23 > 0 and var_73_17 < var_73_23 then
					arg_70_1.talkMaxDuration = var_73_23

					if var_73_23 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_16
					end
				end

				arg_70_1.text_.text = var_73_20
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031017", "story_v_out_417031.awb") ~= 0 then
					local var_73_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031017", "story_v_out_417031.awb") / 1000

					if var_73_24 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_24 + var_73_16
					end

					if var_73_19.prefab_name ~= "" and arg_70_1.actors_[var_73_19.prefab_name] ~= nil then
						local var_73_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_19.prefab_name].transform, "story_v_out_417031", "417031017", "story_v_out_417031.awb")

						arg_70_1:RecordAudio("417031017", var_73_25)
						arg_70_1:RecordAudio("417031017", var_73_25)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417031", "417031017", "story_v_out_417031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417031", "417031017", "story_v_out_417031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_26 = math.max(var_73_17, arg_70_1.talkMaxDuration)

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_26 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_16) / var_73_26

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_16 + var_73_26 and arg_70_1.time_ < var_73_16 + var_73_26 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417031018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417031019(arg_74_1)
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
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 0.5, var_77_3)

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
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			local var_77_8 = 0.01
			local var_77_9 = 1

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				local var_77_10 = "play"
				local var_77_11 = "effect"

				arg_74_1:AudioAction(var_77_10, var_77_11, "se_story_1310", "se_story_1310_pad", "")
			end

			local var_77_12 = 0
			local var_77_13 = 1.575

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_14 = arg_74_1:GetWordFromCfg(417031018)
				local var_77_15 = arg_74_1:FormatText(var_77_14.content)

				arg_74_1.text_.text = var_77_15

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_16 = 63
				local var_77_17 = utf8.len(var_77_15)
				local var_77_18 = var_77_16 <= 0 and var_77_13 or var_77_13 * (var_77_17 / var_77_16)

				if var_77_18 > 0 and var_77_13 < var_77_18 then
					arg_74_1.talkMaxDuration = var_77_18

					if var_77_18 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_15
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_19 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_19 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_19

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_19 and arg_74_1.time_ < var_77_12 + var_77_19 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417031019
		arg_78_1.duration_ = 10.8

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1015"].transform
			local var_81_1 = 1.266

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1015 = var_81_0.localPosition
				var_81_0.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1015", 7)

				local var_81_2 = var_81_0.childCount

				for iter_81_0 = 0, var_81_2 - 1 do
					local var_81_3 = var_81_0:GetChild(iter_81_0)

					if var_81_3.name == "" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_4 then
				local var_81_5 = (arg_78_1.time_ - var_81_1) / var_81_4
				local var_81_6 = Vector3.New(0, -2000, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1015, var_81_6, var_81_5)
			end

			if arg_78_1.time_ >= var_81_1 + var_81_4 and arg_78_1.time_ < var_81_1 + var_81_4 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_7 = arg_78_1.actors_["1034"].transform
			local var_81_8 = 1.266

			if var_81_8 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_7.localPosition
				var_81_7.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 7)

				local var_81_9 = var_81_7.childCount

				for iter_81_1 = 0, var_81_9 - 1 do
					local var_81_10 = var_81_7:GetChild(iter_81_1)

					if var_81_10.name == "" or not string.find(var_81_10.name, "split") then
						var_81_10.gameObject:SetActive(true)
					else
						var_81_10.gameObject:SetActive(false)
					end
				end
			end

			local var_81_11 = 0.001

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_8) / var_81_11
				local var_81_13 = Vector3.New(0, -2000, 0)

				var_81_7.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, var_81_13, var_81_12)
			end

			if arg_78_1.time_ >= var_81_8 + var_81_11 and arg_78_1.time_ < var_81_8 + var_81_11 + arg_81_0 then
				var_81_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_14 = 1.3

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.cswbg_:SetActive(true)

				local var_81_15 = arg_78_1.cswt_:GetComponent("RectTransform")

				arg_78_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_81_15.offsetMin = Vector2.New(400, 105)
				var_81_15.offsetMax = Vector2.New(-400, -200)

				local var_81_16 = arg_78_1:GetWordFromCfg(419094)
				local var_81_17 = arg_78_1:FormatText(var_81_16.content)

				arg_78_1.cswt_.text = var_81_17

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.cswt_)

				arg_78_1.cswt_.fontSize = 92
				arg_78_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_78_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_81_18 = 1.3

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				local var_81_19 = arg_78_1.fswbg_.transform:Find("textbox/adapt/content") or arg_78_1.fswbg_.transform:Find("textbox/content")
				local var_81_20 = arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_81_21 = var_81_19:GetComponent("Text")
				local var_81_22 = var_81_19:GetComponent("RectTransform")

				var_81_21.alignment = UnityEngine.TextAnchor.LowerCenter
				var_81_22.offsetMin = Vector2.New(0, 0)
				var_81_22.offsetMax = Vector2.New(0, 0)
			end

			local var_81_23 = 1.3

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(true)
				arg_78_1.dialog_:SetActive(false)

				arg_78_1.fswtw_.percent = 0

				local var_81_24 = arg_78_1:GetWordFromCfg(417031019)
				local var_81_25 = arg_78_1:FormatText(var_81_24.content)

				arg_78_1.fswt_.text = var_81_25

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.fswt_)

				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_78_1.fswtw_:SetDirty()

				arg_78_1.typewritterCharCountI18N = 0

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_26 = 2.3

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_27 = 43
			local var_81_28 = 2.86666666666667
			local var_81_29 = arg_78_1:GetWordFromCfg(417031019)
			local var_81_30 = arg_78_1:FormatText(var_81_29.content)
			local var_81_31, var_81_32 = arg_78_1:GetPercentByPara(var_81_30, 1)

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_33 = var_81_27 <= 0 and var_81_28 or var_81_28 * ((var_81_32 - arg_78_1.typewritterCharCountI18N) / var_81_27)

				if var_81_33 > 0 and var_81_28 < var_81_33 then
					arg_78_1.talkMaxDuration = var_81_33

					if var_81_33 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_33 + var_81_26
					end
				end
			end

			local var_81_34 = 2.86666666666667
			local var_81_35 = math.max(var_81_34, arg_78_1.talkMaxDuration)

			if var_81_26 <= arg_78_1.time_ and arg_78_1.time_ < var_81_26 + var_81_35 then
				local var_81_36 = (arg_78_1.time_ - var_81_26) / var_81_35

				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_31, var_81_36)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= var_81_26 + var_81_35 and arg_78_1.time_ < var_81_26 + var_81_35 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_31

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_32
			end

			local var_81_37 = 0

			if var_81_37 < arg_78_1.time_ and arg_78_1.time_ <= var_81_37 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_38 = 1.3

			if var_81_37 <= arg_78_1.time_ and arg_78_1.time_ < var_81_37 + var_81_38 then
				local var_81_39 = (arg_78_1.time_ - var_81_37) / var_81_38
				local var_81_40 = Color.New(0, 0, 0)

				var_81_40.a = Mathf.Lerp(0, 1, var_81_39)
				arg_78_1.mask_.color = var_81_40
			end

			if arg_78_1.time_ >= var_81_37 + var_81_38 and arg_78_1.time_ < var_81_37 + var_81_38 + arg_81_0 then
				local var_81_41 = Color.New(0, 0, 0)

				var_81_41.a = 1
				arg_78_1.mask_.color = var_81_41
			end

			local var_81_42 = 1.3

			if var_81_42 < arg_78_1.time_ and arg_78_1.time_ <= var_81_42 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_43 = 2

			if var_81_42 <= arg_78_1.time_ and arg_78_1.time_ < var_81_42 + var_81_43 then
				local var_81_44 = (arg_78_1.time_ - var_81_42) / var_81_43
				local var_81_45 = Color.New(0, 0, 0)

				var_81_45.a = Mathf.Lerp(1, 0, var_81_44)
				arg_78_1.mask_.color = var_81_45
			end

			if arg_78_1.time_ >= var_81_42 + var_81_43 and arg_78_1.time_ < var_81_42 + var_81_43 + arg_81_0 then
				local var_81_46 = Color.New(0, 0, 0)
				local var_81_47 = 0

				arg_78_1.mask_.enabled = false
				var_81_46.a = var_81_47
				arg_78_1.mask_.color = var_81_46
			end

			local var_81_48 = "STblack"

			if arg_78_1.bgs_[var_81_48] == nil then
				local var_81_49 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_49:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_48)
				var_81_49.name = var_81_48
				var_81_49.transform.parent = arg_78_1.stage_.transform
				var_81_49.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_48] = var_81_49
			end

			local var_81_50 = 1.3

			if var_81_50 < arg_78_1.time_ and arg_78_1.time_ <= var_81_50 + arg_81_0 then
				local var_81_51 = manager.ui.mainCamera.transform.localPosition
				local var_81_52 = Vector3.New(0, 0, 10) + Vector3.New(var_81_51.x, var_81_51.y, 0)
				local var_81_53 = arg_78_1.bgs_.STblack

				var_81_53.transform.localPosition = var_81_52
				var_81_53.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_54 = var_81_53:GetComponent("SpriteRenderer")

				if var_81_54 and var_81_54.sprite then
					local var_81_55 = (var_81_53.transform.localPosition - var_81_51).z
					local var_81_56 = manager.ui.mainCameraCom_
					local var_81_57 = 2 * var_81_55 * Mathf.Tan(var_81_56.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_58 = var_81_57 * var_81_56.aspect
					local var_81_59 = var_81_54.sprite.bounds.size.x
					local var_81_60 = var_81_54.sprite.bounds.size.y
					local var_81_61 = var_81_58 / var_81_59
					local var_81_62 = var_81_57 / var_81_60
					local var_81_63 = var_81_62 < var_81_61 and var_81_61 or var_81_62

					var_81_53.transform.localScale = Vector3.New(var_81_63, var_81_63, 0)
				end

				for iter_81_2, iter_81_3 in pairs(arg_78_1.bgs_) do
					if iter_81_2 ~= "STblack" then
						iter_81_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_64 = 2.3
			local var_81_65 = 8.5
			local var_81_66 = manager.audio:GetVoiceLength("story_v_out_417031", "417031019", "") / 1000

			if var_81_66 > 0 and var_81_65 < var_81_66 and var_81_66 + var_81_64 > arg_78_1.duration_ then
				local var_81_67 = var_81_66

				arg_78_1.duration_ = var_81_66 + var_81_64
			end

			if var_81_64 < arg_78_1.time_ and arg_78_1.time_ <= var_81_64 + arg_81_0 then
				local var_81_68 = "play"
				local var_81_69 = "voice"

				arg_78_1:AudioAction(var_81_68, var_81_69, "story_v_out_417031", "417031019", "")
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play417031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417031020
		arg_82_1.duration_ = 10.37

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.fswbg_:SetActive(true)
				arg_82_1.dialog_:SetActive(false)

				arg_82_1.fswtw_.percent = 0

				local var_85_1 = arg_82_1:GetWordFromCfg(417031020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.fswt_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.fswt_)

				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_82_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_82_1.fswtw_:SetDirty()

				arg_82_1.typewritterCharCountI18N = 0

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_3 = 0.566666666666667

			if var_85_3 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.var_.oldValueTypewriter = arg_82_1.fswtw_.percent

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_4 = 49
			local var_85_5 = 3.33333333333333
			local var_85_6 = arg_82_1:GetWordFromCfg(417031020)
			local var_85_7 = arg_82_1:FormatText(var_85_6.content)
			local var_85_8, var_85_9 = arg_82_1:GetPercentByPara(var_85_7, 1)

			if var_85_3 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				local var_85_10 = var_85_4 <= 0 and var_85_5 or var_85_5 * ((var_85_9 - arg_82_1.typewritterCharCountI18N) / var_85_4)

				if var_85_10 > 0 and var_85_5 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_3 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_3
					end
				end
			end

			local var_85_11 = 3.33333333333333
			local var_85_12 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_3 + var_85_12 then
				local var_85_13 = (arg_82_1.time_ - var_85_3) / var_85_12

				arg_82_1.fswtw_.percent = Mathf.Lerp(arg_82_1.var_.oldValueTypewriter, var_85_8, var_85_13)
				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_82_1.fswtw_:SetDirty()
			end

			if arg_82_1.time_ >= var_85_3 + var_85_12 and arg_82_1.time_ < var_85_3 + var_85_12 + arg_85_0 then
				arg_82_1.fswtw_.percent = var_85_8

				arg_82_1.fswtw_:SetDirty()
				arg_82_1:ShowNextGo(true)

				arg_82_1.typewritterCharCountI18N = var_85_9
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_15 = 0.566666666666667

			if arg_82_1.time_ >= var_85_14 + var_85_15 and arg_82_1.time_ < var_85_14 + var_85_15 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_16 = 0.566666666666667
			local var_85_17 = 9.8
			local var_85_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031020", "") / 1000

			if var_85_18 > 0 and var_85_17 < var_85_18 and var_85_18 + var_85_16 > arg_82_1.duration_ then
				local var_85_19 = var_85_18

				arg_82_1.duration_ = var_85_18 + var_85_16
			end

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				local var_85_20 = "play"
				local var_85_21 = "voice"

				arg_82_1:AudioAction(var_85_20, var_85_21, "story_v_out_417031", "417031020", "")
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417031021
		arg_86_1.duration_ = 12.2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.fswbg_:SetActive(true)
				arg_86_1.dialog_:SetActive(false)

				arg_86_1.fswtw_.percent = 0

				local var_89_1 = arg_86_1:GetWordFromCfg(417031021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.fswt_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.fswt_)

				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_86_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_86_1.fswtw_:SetDirty()

				arg_86_1.typewritterCharCountI18N = 0

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_3 = 0.566666666666667

			if var_89_3 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.var_.oldValueTypewriter = arg_86_1.fswtw_.percent

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_4 = 53
			local var_89_5 = 3.53333333333333
			local var_89_6 = arg_86_1:GetWordFromCfg(417031021)
			local var_89_7 = arg_86_1:FormatText(var_89_6.content)
			local var_89_8, var_89_9 = arg_86_1:GetPercentByPara(var_89_7, 1)

			if var_89_3 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				local var_89_10 = var_89_4 <= 0 and var_89_5 or var_89_5 * ((var_89_9 - arg_86_1.typewritterCharCountI18N) / var_89_4)

				if var_89_10 > 0 and var_89_5 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_3
					end
				end
			end

			local var_89_11 = 3.53333333333333
			local var_89_12 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_3) / var_89_12

				arg_86_1.fswtw_.percent = Mathf.Lerp(arg_86_1.var_.oldValueTypewriter, var_89_8, var_89_13)
				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_86_1.fswtw_:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_12 and arg_86_1.time_ < var_89_3 + var_89_12 + arg_89_0 then
				arg_86_1.fswtw_.percent = var_89_8

				arg_86_1.fswtw_:SetDirty()
				arg_86_1:ShowNextGo(true)

				arg_86_1.typewritterCharCountI18N = var_89_9
			end

			local var_89_14 = 0

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_15 = 0.566666666666667

			if arg_86_1.time_ >= var_89_14 + var_89_15 and arg_86_1.time_ < var_89_14 + var_89_15 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_16 = 0.566666666666667
			local var_89_17 = 11.633
			local var_89_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031021", "") / 1000

			if var_89_18 > 0 and var_89_17 < var_89_18 and var_89_18 + var_89_16 > arg_86_1.duration_ then
				local var_89_19 = var_89_18

				arg_86_1.duration_ = var_89_18 + var_89_16
			end

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				local var_89_20 = "play"
				local var_89_21 = "voice"

				arg_86_1:AudioAction(var_89_20, var_89_21, "story_v_out_417031", "417031021", "")
			end

			local var_89_22 = 0

			if var_89_22 < arg_86_1.time_ and arg_86_1.time_ <= var_89_22 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_23 = 0.566666666666667

			if arg_86_1.time_ >= var_89_22 + var_89_23 and arg_86_1.time_ < var_89_22 + var_89_23 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417031022
		arg_90_1.duration_ = 5.97

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.cswbg_:SetActive(true)

				local var_93_1 = arg_90_1.cswt_:GetComponent("RectTransform")

				arg_90_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_93_1.offsetMin = Vector2.New(400, 105)
				var_93_1.offsetMax = Vector2.New(-400, -200)

				local var_93_2 = arg_90_1:GetWordFromCfg(419095)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.cswt_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.cswt_)

				arg_90_1.cswt_.fontSize = 105
				arg_90_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_90_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_93_4 = 8.88178419700125e-16

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				local var_93_5 = arg_90_1.fswbg_.transform:Find("textbox/adapt/content") or arg_90_1.fswbg_.transform:Find("textbox/content")
				local var_93_6 = arg_90_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_93_7 = var_93_5:GetComponent("Text")
				local var_93_8 = var_93_5:GetComponent("RectTransform")

				var_93_7.alignment = UnityEngine.TextAnchor.LowerCenter
				var_93_8.offsetMin = Vector2.New(0, 0)
				var_93_8.offsetMax = Vector2.New(0, 0)
			end

			local var_93_9 = 8.88178419700125e-16

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.fswbg_:SetActive(true)
				arg_90_1.dialog_:SetActive(false)

				arg_90_1.fswtw_.percent = 0

				local var_93_10 = arg_90_1:GetWordFromCfg(417031022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.fswt_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.fswt_)

				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_90_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_90_1.fswtw_:SetDirty()

				arg_90_1.typewritterCharCountI18N = 0

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_12 = 1

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.var_.oldValueTypewriter = arg_90_1.fswtw_.percent

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_13 = 24
			local var_93_14 = 1.6
			local var_93_15 = arg_90_1:GetWordFromCfg(417031022)
			local var_93_16 = arg_90_1:FormatText(var_93_15.content)
			local var_93_17, var_93_18 = arg_90_1:GetPercentByPara(var_93_16, 1)

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				local var_93_19 = var_93_13 <= 0 and var_93_14 or var_93_14 * ((var_93_18 - arg_90_1.typewritterCharCountI18N) / var_93_13)

				if var_93_19 > 0 and var_93_14 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end
			end

			local var_93_20 = 1.6
			local var_93_21 = math.max(var_93_20, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_21 then
				local var_93_22 = (arg_90_1.time_ - var_93_12) / var_93_21

				arg_90_1.fswtw_.percent = Mathf.Lerp(arg_90_1.var_.oldValueTypewriter, var_93_17, var_93_22)
				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.fswtw_:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_21 and arg_90_1.time_ < var_93_12 + var_93_21 + arg_93_0 then
				arg_90_1.fswtw_.percent = var_93_17

				arg_90_1.fswtw_:SetDirty()
				arg_90_1:ShowNextGo(true)

				arg_90_1.typewritterCharCountI18N = var_93_18
			end

			local var_93_23 = 0

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_24 = 2

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_24 then
				local var_93_25 = (arg_90_1.time_ - var_93_23) / var_93_24
				local var_93_26 = Color.New(0, 0, 0)

				var_93_26.a = Mathf.Lerp(1, 0, var_93_25)
				arg_90_1.mask_.color = var_93_26
			end

			if arg_90_1.time_ >= var_93_23 + var_93_24 and arg_90_1.time_ < var_93_23 + var_93_24 + arg_93_0 then
				local var_93_27 = Color.New(0, 0, 0)
				local var_93_28 = 0

				arg_90_1.mask_.enabled = false
				var_93_27.a = var_93_28
				arg_90_1.mask_.color = var_93_27
			end

			local var_93_29 = 0

			if var_93_29 < arg_90_1.time_ and arg_90_1.time_ <= var_93_29 + arg_93_0 then
				local var_93_30 = manager.ui.mainCamera.transform.localPosition
				local var_93_31 = Vector3.New(0, 0, 10) + Vector3.New(var_93_30.x, var_93_30.y, 0)
				local var_93_32 = arg_90_1.bgs_.STblack

				var_93_32.transform.localPosition = var_93_31
				var_93_32.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_93_33 = var_93_32:GetComponent("SpriteRenderer")

				if var_93_33 and var_93_33.sprite then
					local var_93_34 = (var_93_32.transform.localPosition - var_93_30).z
					local var_93_35 = manager.ui.mainCameraCom_
					local var_93_36 = 2 * var_93_34 * Mathf.Tan(var_93_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_93_37 = var_93_36 * var_93_35.aspect
					local var_93_38 = var_93_33.sprite.bounds.size.x
					local var_93_39 = var_93_33.sprite.bounds.size.y
					local var_93_40 = var_93_37 / var_93_38
					local var_93_41 = var_93_36 / var_93_39
					local var_93_42 = var_93_41 < var_93_40 and var_93_40 or var_93_41

					var_93_32.transform.localScale = Vector3.New(var_93_42, var_93_42, 0)
				end

				for iter_93_0, iter_93_1 in pairs(arg_90_1.bgs_) do
					if iter_93_0 ~= "STblack" then
						iter_93_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_93_43 = 1
			local var_93_44 = 4.966
			local var_93_45 = manager.audio:GetVoiceLength("story_v_out_417031", "417031022", "") / 1000

			if var_93_45 > 0 and var_93_44 < var_93_45 and var_93_45 + var_93_43 > arg_90_1.duration_ then
				local var_93_46 = var_93_45

				arg_90_1.duration_ = var_93_45 + var_93_43
			end

			if var_93_43 < arg_90_1.time_ and arg_90_1.time_ <= var_93_43 + arg_93_0 then
				local var_93_47 = "play"
				local var_93_48 = "voice"

				arg_90_1:AudioAction(var_93_47, var_93_48, "story_v_out_417031", "417031022", "")
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417031023
		arg_94_1.duration_ = 6.3

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 8.88178419700125e-16

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.fswbg_:SetActive(true)
				arg_94_1.dialog_:SetActive(false)

				arg_94_1.fswtw_.percent = 0

				local var_97_1 = arg_94_1:GetWordFromCfg(417031023)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.fswt_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.fswt_)

				arg_94_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_94_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_94_1.fswtw_:SetDirty()

				arg_94_1.typewritterCharCountI18N = 0

				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_3 = 0.533333333333333

			if var_97_3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.var_.oldValueTypewriter = arg_94_1.fswtw_.percent

				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_4 = 33
			local var_97_5 = 2.2
			local var_97_6 = arg_94_1:GetWordFromCfg(417031023)
			local var_97_7 = arg_94_1:FormatText(var_97_6.content)
			local var_97_8, var_97_9 = arg_94_1:GetPercentByPara(var_97_7, 1)

			if var_97_3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				local var_97_10 = var_97_4 <= 0 and var_97_5 or var_97_5 * ((var_97_9 - arg_94_1.typewritterCharCountI18N) / var_97_4)

				if var_97_10 > 0 and var_97_5 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_3
					end
				end
			end

			local var_97_11 = 2.2
			local var_97_12 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_3) / var_97_12

				arg_94_1.fswtw_.percent = Mathf.Lerp(arg_94_1.var_.oldValueTypewriter, var_97_8, var_97_13)
				arg_94_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_94_1.fswtw_:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_12 and arg_94_1.time_ < var_97_3 + var_97_12 + arg_97_0 then
				arg_94_1.fswtw_.percent = var_97_8

				arg_94_1.fswtw_:SetDirty()
				arg_94_1:ShowNextGo(true)

				arg_94_1.typewritterCharCountI18N = var_97_9
			end

			local var_97_14 = 0

			if var_97_14 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			local var_97_15 = 0.533333333333333

			if arg_94_1.time_ >= var_97_14 + var_97_15 and arg_94_1.time_ < var_97_14 + var_97_15 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_16 = 0.533333333333333
			local var_97_17 = 5.766
			local var_97_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031023", "") / 1000

			if var_97_18 > 0 and var_97_17 < var_97_18 and var_97_18 + var_97_16 > arg_94_1.duration_ then
				local var_97_19 = var_97_18

				arg_94_1.duration_ = var_97_18 + var_97_16
			end

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				local var_97_20 = "play"
				local var_97_21 = "voice"

				arg_94_1:AudioAction(var_97_20, var_97_21, "story_v_out_417031", "417031023", "")
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417031024
		arg_98_1.duration_ = 8.37

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 8.88178419700125e-16

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.fswbg_:SetActive(true)
				arg_98_1.dialog_:SetActive(false)

				arg_98_1.fswtw_.percent = 0

				local var_101_1 = arg_98_1:GetWordFromCfg(417031024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.fswt_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.fswt_)

				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_98_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_98_1.fswtw_:SetDirty()

				arg_98_1.typewritterCharCountI18N = 0

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_3 = 0.0340000000000009

			if var_101_3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.var_.oldValueTypewriter = arg_98_1.fswtw_.percent

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_4 = 35
			local var_101_5 = 2.33333333333333
			local var_101_6 = arg_98_1:GetWordFromCfg(417031024)
			local var_101_7 = arg_98_1:FormatText(var_101_6.content)
			local var_101_8, var_101_9 = arg_98_1:GetPercentByPara(var_101_7, 1)

			if var_101_3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				local var_101_10 = var_101_4 <= 0 and var_101_5 or var_101_5 * ((var_101_9 - arg_98_1.typewritterCharCountI18N) / var_101_4)

				if var_101_10 > 0 and var_101_5 < var_101_10 then
					arg_98_1.talkMaxDuration = var_101_10

					if var_101_10 + var_101_3 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_3
					end
				end
			end

			local var_101_11 = 2.33333333333333
			local var_101_12 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_3) / var_101_12

				arg_98_1.fswtw_.percent = Mathf.Lerp(arg_98_1.var_.oldValueTypewriter, var_101_8, var_101_13)
				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_98_1.fswtw_:SetDirty()
			end

			if arg_98_1.time_ >= var_101_3 + var_101_12 and arg_98_1.time_ < var_101_3 + var_101_12 + arg_101_0 then
				arg_98_1.fswtw_.percent = var_101_8

				arg_98_1.fswtw_:SetDirty()
				arg_98_1:ShowNextGo(true)

				arg_98_1.typewritterCharCountI18N = var_101_9
			end

			local var_101_14 = 0.0340000000000009
			local var_101_15 = 8.333
			local var_101_16 = manager.audio:GetVoiceLength("story_v_out_417031", "417031024", "") / 1000

			if var_101_16 > 0 and var_101_15 < var_101_16 and var_101_16 + var_101_14 > arg_98_1.duration_ then
				local var_101_17 = var_101_16

				arg_98_1.duration_ = var_101_16 + var_101_14
			end

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				local var_101_18 = "play"
				local var_101_19 = "voice"

				arg_98_1:AudioAction(var_101_18, var_101_19, "story_v_out_417031", "417031024", "")
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417031025
		arg_102_1.duration_ = 10.47

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 8.88178419700125e-16

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.fswbg_:SetActive(true)
				arg_102_1.dialog_:SetActive(false)

				arg_102_1.fswtw_.percent = 0

				local var_105_1 = arg_102_1:GetWordFromCfg(417031025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.fswt_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.fswt_)

				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_102_1.fswtw_:SetDirty()

				arg_102_1.typewritterCharCountI18N = 0

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_3 = 0.0340000000000009

			if var_105_3 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_4 = 55
			local var_105_5 = 3.66666666666667
			local var_105_6 = arg_102_1:GetWordFromCfg(417031025)
			local var_105_7 = arg_102_1:FormatText(var_105_6.content)
			local var_105_8, var_105_9 = arg_102_1:GetPercentByPara(var_105_7, 1)

			if var_105_3 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_10 = var_105_4 <= 0 and var_105_5 or var_105_5 * ((var_105_9 - arg_102_1.typewritterCharCountI18N) / var_105_4)

				if var_105_10 > 0 and var_105_5 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_3
					end
				end
			end

			local var_105_11 = 3.66666666666667
			local var_105_12 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_3) / var_105_12

				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_8, var_105_13)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_12 and arg_102_1.time_ < var_105_3 + var_105_12 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_8

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_9
			end

			local var_105_14 = 0.0340000000000009
			local var_105_15 = 10.433
			local var_105_16 = manager.audio:GetVoiceLength("story_v_out_417031", "417031025", "") / 1000

			if var_105_16 > 0 and var_105_15 < var_105_16 and var_105_16 + var_105_14 > arg_102_1.duration_ then
				local var_105_17 = var_105_16

				arg_102_1.duration_ = var_105_16 + var_105_14
			end

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				local var_105_18 = "play"
				local var_105_19 = "voice"

				arg_102_1:AudioAction(var_105_18, var_105_19, "story_v_out_417031", "417031025", "")
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417031026
		arg_106_1.duration_ = 7.93

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play417031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.334

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				local var_109_1 = manager.ui.mainCamera.transform.localPosition
				local var_109_2 = Vector3.New(0, 0, 10) + Vector3.New(var_109_1.x, var_109_1.y, 0)
				local var_109_3 = arg_106_1.bgs_.ST77a

				var_109_3.transform.localPosition = var_109_2
				var_109_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_4 = var_109_3:GetComponent("SpriteRenderer")

				if var_109_4 and var_109_4.sprite then
					local var_109_5 = (var_109_3.transform.localPosition - var_109_1).z
					local var_109_6 = manager.ui.mainCameraCom_
					local var_109_7 = 2 * var_109_5 * Mathf.Tan(var_109_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_109_8 = var_109_7 * var_109_6.aspect
					local var_109_9 = var_109_4.sprite.bounds.size.x
					local var_109_10 = var_109_4.sprite.bounds.size.y
					local var_109_11 = var_109_8 / var_109_9
					local var_109_12 = var_109_7 / var_109_10
					local var_109_13 = var_109_12 < var_109_11 and var_109_11 or var_109_12

					var_109_3.transform.localScale = Vector3.New(var_109_13, var_109_13, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "ST77a" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_109_14 = 1.334

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1.cswbg_:SetActive(false)
			end

			local var_109_15 = 1.3

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_16 = 1.334

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_18 = 1.3

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_18 then
				local var_109_19 = (arg_106_1.time_ - var_109_17) / var_109_18
				local var_109_20 = Color.New(0, 0, 0)

				var_109_20.a = Mathf.Lerp(0, 1, var_109_19)
				arg_106_1.mask_.color = var_109_20
			end

			if arg_106_1.time_ >= var_109_17 + var_109_18 and arg_106_1.time_ < var_109_17 + var_109_18 + arg_109_0 then
				local var_109_21 = Color.New(0, 0, 0)

				var_109_21.a = 1
				arg_106_1.mask_.color = var_109_21
			end

			local var_109_22 = 1.3

			if var_109_22 < arg_106_1.time_ and arg_106_1.time_ <= var_109_22 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_23 = 2

			if var_109_22 <= arg_106_1.time_ and arg_106_1.time_ < var_109_22 + var_109_23 then
				local var_109_24 = (arg_106_1.time_ - var_109_22) / var_109_23
				local var_109_25 = Color.New(0, 0, 0)

				var_109_25.a = Mathf.Lerp(1, 0, var_109_24)
				arg_106_1.mask_.color = var_109_25
			end

			if arg_106_1.time_ >= var_109_22 + var_109_23 and arg_106_1.time_ < var_109_22 + var_109_23 + arg_109_0 then
				local var_109_26 = Color.New(0, 0, 0)
				local var_109_27 = 0

				arg_106_1.mask_.enabled = false
				var_109_26.a = var_109_27
				arg_106_1.mask_.color = var_109_26
			end

			local var_109_28 = 2.86666666666667
			local var_109_29 = 1

			if var_109_28 < arg_106_1.time_ and arg_106_1.time_ <= var_109_28 + arg_109_0 then
				local var_109_30 = "play"
				local var_109_31 = "effect"

				arg_106_1:AudioAction(var_109_30, var_109_31, "se_story_1310", "se_story_1310_teacup01", "")
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_32 = 2.93333333333333
			local var_109_33 = 1.2

			if var_109_32 < arg_106_1.time_ and arg_106_1.time_ <= var_109_32 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_34 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_34:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_35 = arg_106_1:GetWordFromCfg(417031026)
				local var_109_36 = arg_106_1:FormatText(var_109_35.content)

				arg_106_1.text_.text = var_109_36

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_37 = 48
				local var_109_38 = utf8.len(var_109_36)
				local var_109_39 = var_109_37 <= 0 and var_109_33 or var_109_33 * (var_109_38 / var_109_37)

				if var_109_39 > 0 and var_109_33 < var_109_39 then
					arg_106_1.talkMaxDuration = var_109_39
					var_109_32 = var_109_32 + 0.3

					if var_109_39 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_39 + var_109_32
					end
				end

				arg_106_1.text_.text = var_109_36
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_40 = var_109_32 + 0.3
			local var_109_41 = math.max(var_109_33, arg_106_1.talkMaxDuration)

			if var_109_40 <= arg_106_1.time_ and arg_106_1.time_ < var_109_40 + var_109_41 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_40) / var_109_41

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_40 + var_109_41 and arg_106_1.time_ < var_109_40 + var_109_41 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417031027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417031027
		arg_112_1.duration_ = 9.47

		local var_112_0 = {
			zh = 6.966,
			ja = 9.466
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
				arg_112_0:Play417031028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1034"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_8 = arg_112_1.actors_["1034"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos1034 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1034", 4)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "split_6" or not string.find(var_115_11.name, "split") then
						var_115_11.gameObject:SetActive(true)
					else
						var_115_11.gameObject:SetActive(false)
					end
				end
			end

			local var_115_12 = 0.001

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(373.7, -331.9, -324)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1034, var_115_14, var_115_13)
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_115_15 = 0
			local var_115_16 = 0.875

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[1109].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(417031027)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 34
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031027", "story_v_out_417031.awb") ~= 0 then
					local var_115_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031027", "story_v_out_417031.awb") / 1000

					if var_115_23 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_15
					end

					if var_115_18.prefab_name ~= "" and arg_112_1.actors_[var_115_18.prefab_name] ~= nil then
						local var_115_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_18.prefab_name].transform, "story_v_out_417031", "417031027", "story_v_out_417031.awb")

						arg_112_1:RecordAudio("417031027", var_115_24)
						arg_112_1:RecordAudio("417031027", var_115_24)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417031", "417031027", "story_v_out_417031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417031", "417031027", "story_v_out_417031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_25 and arg_112_1.time_ < var_115_15 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417031028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417031028
		arg_116_1.duration_ = 6.13

		local var_116_0 = {
			zh = 4.433,
			ja = 6.133
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
				arg_116_0:Play417031029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1015"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1015 == nil then
				arg_116_1.var_.actorSpriteComps1015 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1015 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1015 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1015 = nil
			end

			local var_119_8 = arg_116_1.actors_["1034"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								local var_119_12 = Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, var_119_11)
								local var_119_13 = Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, var_119_11)
								local var_119_14 = Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, var_119_11)

								iter_119_5.color = Color.New(var_119_12, var_119_13, var_119_14)
							else
								local var_119_15 = Mathf.Lerp(iter_119_5.color.r, 0.5, var_119_11)

								iter_119_5.color = Color.New(var_119_15, var_119_15, var_119_15)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_16 = arg_116_1.actors_["1015"].transform
			local var_119_17 = 0

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.var_.moveOldPos1015 = var_119_16.localPosition
				var_119_16.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1015", 2)

				local var_119_18 = var_119_16.childCount

				for iter_119_8 = 0, var_119_18 - 1 do
					local var_119_19 = var_119_16:GetChild(iter_119_8)

					if var_119_19.name == "" or not string.find(var_119_19.name, "split") then
						var_119_19.gameObject:SetActive(true)
					else
						var_119_19.gameObject:SetActive(false)
					end
				end
			end

			local var_119_20 = 0.001

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_20 then
				local var_119_21 = (arg_116_1.time_ - var_119_17) / var_119_20
				local var_119_22 = Vector3.New(-390, -340, -288)

				var_119_16.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1015, var_119_22, var_119_21)
			end

			if arg_116_1.time_ >= var_119_17 + var_119_20 and arg_116_1.time_ < var_119_17 + var_119_20 + arg_119_0 then
				var_119_16.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_119_23 = 0
			local var_119_24 = 0.5

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_25 = arg_116_1:FormatText(StoryNameCfg[479].name)

				arg_116_1.leftNameTxt_.text = var_119_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(417031028)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 20
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_24 or var_119_24 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_24 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031028", "story_v_out_417031.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031028", "story_v_out_417031.awb") / 1000

					if var_119_31 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_out_417031", "417031028", "story_v_out_417031.awb")

						arg_116_1:RecordAudio("417031028", var_119_32)
						arg_116_1:RecordAudio("417031028", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417031", "417031028", "story_v_out_417031.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417031", "417031028", "story_v_out_417031.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_33 and arg_116_1.time_ < var_119_23 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play417031029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417031029
		arg_120_1.duration_ = 10.8

		local var_120_0 = {
			zh = 5.266,
			ja = 10.8
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417031030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1034"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1034 == nil then
				arg_120_1.var_.actorSpriteComps1034 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps1034 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1034 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1034 = nil
			end

			local var_123_8 = arg_120_1.actors_["1015"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps1015 == nil then
				arg_120_1.var_.actorSpriteComps1015 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps1015 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps1015 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1015 = nil
			end

			local var_123_16 = 0
			local var_123_17 = 0.625

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_18 = arg_120_1:FormatText(StoryNameCfg[1109].name)

				arg_120_1.leftNameTxt_.text = var_123_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(417031029)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 25
				local var_123_22 = utf8.len(var_123_20)
				local var_123_23 = var_123_21 <= 0 and var_123_17 or var_123_17 * (var_123_22 / var_123_21)

				if var_123_23 > 0 and var_123_17 < var_123_23 then
					arg_120_1.talkMaxDuration = var_123_23

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031029", "story_v_out_417031.awb") ~= 0 then
					local var_123_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031029", "story_v_out_417031.awb") / 1000

					if var_123_24 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_out_417031", "417031029", "story_v_out_417031.awb")

						arg_120_1:RecordAudio("417031029", var_123_25)
						arg_120_1:RecordAudio("417031029", var_123_25)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417031", "417031029", "story_v_out_417031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417031", "417031029", "story_v_out_417031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_26 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_16) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_16 + var_123_26 and arg_120_1.time_ < var_123_16 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417031030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417031030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417031031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1034"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_8 = arg_124_1.actors_["1015"].transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.moveOldPos1015 = var_127_8.localPosition
				var_127_8.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1015", 7)

				local var_127_10 = var_127_8.childCount

				for iter_127_4 = 0, var_127_10 - 1 do
					local var_127_11 = var_127_8:GetChild(iter_127_4)

					if var_127_11.name == "" or not string.find(var_127_11.name, "split") then
						var_127_11.gameObject:SetActive(true)
					else
						var_127_11.gameObject:SetActive(false)
					end
				end
			end

			local var_127_12 = 0.001

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_12 then
				local var_127_13 = (arg_124_1.time_ - var_127_9) / var_127_12
				local var_127_14 = Vector3.New(0, -2000, 0)

				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1015, var_127_14, var_127_13)
			end

			if arg_124_1.time_ >= var_127_9 + var_127_12 and arg_124_1.time_ < var_127_9 + var_127_12 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_127_15 = arg_124_1.actors_["1034"].transform
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.var_.moveOldPos1034 = var_127_15.localPosition
				var_127_15.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1034", 7)

				local var_127_17 = var_127_15.childCount

				for iter_127_5 = 0, var_127_17 - 1 do
					local var_127_18 = var_127_15:GetChild(iter_127_5)

					if var_127_18.name == "" or not string.find(var_127_18.name, "split") then
						var_127_18.gameObject:SetActive(true)
					else
						var_127_18.gameObject:SetActive(false)
					end
				end
			end

			local var_127_19 = 0.001

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_16) / var_127_19
				local var_127_21 = Vector3.New(0, -2000, 0)

				var_127_15.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1034, var_127_21, var_127_20)
			end

			if arg_124_1.time_ >= var_127_16 + var_127_19 and arg_124_1.time_ < var_127_16 + var_127_19 + arg_127_0 then
				var_127_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_127_22 = 0.05
			local var_127_23 = 1

			if var_127_22 < arg_124_1.time_ and arg_124_1.time_ <= var_127_22 + arg_127_0 then
				local var_127_24 = "play"
				local var_127_25 = "effect"

				arg_124_1:AudioAction(var_127_24, var_127_25, "se_story_121_04", "se_story_121_04_tea", "")
			end

			local var_127_26 = 0
			local var_127_27 = 0.95

			if var_127_26 < arg_124_1.time_ and arg_124_1.time_ <= var_127_26 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_28 = arg_124_1:GetWordFromCfg(417031030)
				local var_127_29 = arg_124_1:FormatText(var_127_28.content)

				arg_124_1.text_.text = var_127_29

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_30 = 38
				local var_127_31 = utf8.len(var_127_29)
				local var_127_32 = var_127_30 <= 0 and var_127_27 or var_127_27 * (var_127_31 / var_127_30)

				if var_127_32 > 0 and var_127_27 < var_127_32 then
					arg_124_1.talkMaxDuration = var_127_32

					if var_127_32 + var_127_26 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_32 + var_127_26
					end
				end

				arg_124_1.text_.text = var_127_29
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_27, arg_124_1.talkMaxDuration)

			if var_127_26 <= arg_124_1.time_ and arg_124_1.time_ < var_127_26 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_26) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_26 + var_127_33 and arg_124_1.time_ < var_127_26 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417031031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417031031
		arg_128_1.duration_ = 3.13

		local var_128_0 = {
			zh = 3.133,
			ja = 2.2
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417031032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1015"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1015 == nil then
				arg_128_1.var_.actorSpriteComps1015 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1015 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 1, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1015 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1015 = nil
			end

			local var_131_8 = arg_128_1.actors_["1015"].transform
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.var_.moveOldPos1015 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1015", 2)

				local var_131_10 = var_131_8.childCount

				for iter_131_4 = 0, var_131_10 - 1 do
					local var_131_11 = var_131_8:GetChild(iter_131_4)

					if var_131_11.name == "" or not string.find(var_131_11.name, "split") then
						var_131_11.gameObject:SetActive(true)
					else
						var_131_11.gameObject:SetActive(false)
					end
				end
			end

			local var_131_12 = 0.001

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_12 then
				local var_131_13 = (arg_128_1.time_ - var_131_9) / var_131_12
				local var_131_14 = Vector3.New(-390, -340, -288)

				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1015, var_131_14, var_131_13)
			end

			if arg_128_1.time_ >= var_131_9 + var_131_12 and arg_128_1.time_ < var_131_9 + var_131_12 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_131_15 = 0
			local var_131_16 = 0.15

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[479].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(417031031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 6
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031031", "story_v_out_417031.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031031", "story_v_out_417031.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_417031", "417031031", "story_v_out_417031.awb")

						arg_128_1:RecordAudio("417031031", var_131_24)
						arg_128_1:RecordAudio("417031031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417031", "417031031", "story_v_out_417031.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417031", "417031031", "story_v_out_417031.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play417031032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417031032
		arg_132_1.duration_ = 3.13

		local var_132_0 = {
			zh = 2.066,
			ja = 3.133
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play417031033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1034"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_8 = arg_132_1.actors_["1015"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1015 == nil then
				arg_132_1.var_.actorSpriteComps1015 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1015 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 0.5, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1015 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1015 = nil
			end

			local var_135_16 = arg_132_1.actors_["1034"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos1034 = var_135_16.localPosition
				var_135_16.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1034", 4)

				local var_135_18 = var_135_16.childCount

				for iter_135_8 = 0, var_135_18 - 1 do
					local var_135_19 = var_135_16:GetChild(iter_135_8)

					if var_135_19.name == "split_6" or not string.find(var_135_19.name, "split") then
						var_135_19.gameObject:SetActive(true)
					else
						var_135_19.gameObject:SetActive(false)
					end
				end
			end

			local var_135_20 = 0.001

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_20 then
				local var_135_21 = (arg_132_1.time_ - var_135_17) / var_135_20
				local var_135_22 = Vector3.New(373.7, -331.9, -324)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1034, var_135_22, var_135_21)
			end

			if arg_132_1.time_ >= var_135_17 + var_135_20 and arg_132_1.time_ < var_135_17 + var_135_20 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_135_23 = 0
			local var_135_24 = 0.2

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_25 = arg_132_1:FormatText(StoryNameCfg[1109].name)

				arg_132_1.leftNameTxt_.text = var_135_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_26 = arg_132_1:GetWordFromCfg(417031032)
				local var_135_27 = arg_132_1:FormatText(var_135_26.content)

				arg_132_1.text_.text = var_135_27

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_28 = 8
				local var_135_29 = utf8.len(var_135_27)
				local var_135_30 = var_135_28 <= 0 and var_135_24 or var_135_24 * (var_135_29 / var_135_28)

				if var_135_30 > 0 and var_135_24 < var_135_30 then
					arg_132_1.talkMaxDuration = var_135_30

					if var_135_30 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_30 + var_135_23
					end
				end

				arg_132_1.text_.text = var_135_27
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031032", "story_v_out_417031.awb") ~= 0 then
					local var_135_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031032", "story_v_out_417031.awb") / 1000

					if var_135_31 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_31 + var_135_23
					end

					if var_135_26.prefab_name ~= "" and arg_132_1.actors_[var_135_26.prefab_name] ~= nil then
						local var_135_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_26.prefab_name].transform, "story_v_out_417031", "417031032", "story_v_out_417031.awb")

						arg_132_1:RecordAudio("417031032", var_135_32)
						arg_132_1:RecordAudio("417031032", var_135_32)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417031", "417031032", "story_v_out_417031.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417031", "417031032", "story_v_out_417031.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_33 = math.max(var_135_24, arg_132_1.talkMaxDuration)

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_33 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_23) / var_135_33

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_23 + var_135_33 and arg_132_1.time_ < var_135_23 + var_135_33 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play417031033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417031033
		arg_136_1.duration_ = 7.87

		local var_136_0 = {
			zh = 5.233,
			ja = 7.866
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417031034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1015"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1015 == nil then
				arg_136_1.var_.actorSpriteComps1015 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps1015 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 1, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1015 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1015 = nil
			end

			local var_139_8 = arg_136_1.actors_["1034"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 0.2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								local var_139_12 = Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor2.r, var_139_11)
								local var_139_13 = Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor2.g, var_139_11)
								local var_139_14 = Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor2.b, var_139_11)

								iter_139_5.color = Color.New(var_139_12, var_139_13, var_139_14)
							else
								local var_139_15 = Mathf.Lerp(iter_139_5.color.r, 0.5, var_139_11)

								iter_139_5.color = Color.New(var_139_15, var_139_15, var_139_15)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_16 = arg_136_1.actors_["1015"].transform
			local var_139_17 = 0

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.var_.moveOldPos1015 = var_139_16.localPosition
				var_139_16.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1015", 2)

				local var_139_18 = var_139_16.childCount

				for iter_139_8 = 0, var_139_18 - 1 do
					local var_139_19 = var_139_16:GetChild(iter_139_8)

					if var_139_19.name == "split_1" or not string.find(var_139_19.name, "split") then
						var_139_19.gameObject:SetActive(true)
					else
						var_139_19.gameObject:SetActive(false)
					end
				end
			end

			local var_139_20 = 0.001

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_20 then
				local var_139_21 = (arg_136_1.time_ - var_139_17) / var_139_20
				local var_139_22 = Vector3.New(-390, -340, -288)

				var_139_16.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1015, var_139_22, var_139_21)
			end

			if arg_136_1.time_ >= var_139_17 + var_139_20 and arg_136_1.time_ < var_139_17 + var_139_20 + arg_139_0 then
				var_139_16.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_139_23 = 0
			local var_139_24 = 0.625

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_25 = arg_136_1:FormatText(StoryNameCfg[479].name)

				arg_136_1.leftNameTxt_.text = var_139_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_26 = arg_136_1:GetWordFromCfg(417031033)
				local var_139_27 = arg_136_1:FormatText(var_139_26.content)

				arg_136_1.text_.text = var_139_27

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_28 = 25
				local var_139_29 = utf8.len(var_139_27)
				local var_139_30 = var_139_28 <= 0 and var_139_24 or var_139_24 * (var_139_29 / var_139_28)

				if var_139_30 > 0 and var_139_24 < var_139_30 then
					arg_136_1.talkMaxDuration = var_139_30

					if var_139_30 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_30 + var_139_23
					end
				end

				arg_136_1.text_.text = var_139_27
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031033", "story_v_out_417031.awb") ~= 0 then
					local var_139_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031033", "story_v_out_417031.awb") / 1000

					if var_139_31 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_31 + var_139_23
					end

					if var_139_26.prefab_name ~= "" and arg_136_1.actors_[var_139_26.prefab_name] ~= nil then
						local var_139_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_26.prefab_name].transform, "story_v_out_417031", "417031033", "story_v_out_417031.awb")

						arg_136_1:RecordAudio("417031033", var_139_32)
						arg_136_1:RecordAudio("417031033", var_139_32)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417031", "417031033", "story_v_out_417031.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417031", "417031033", "story_v_out_417031.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_33 = math.max(var_139_24, arg_136_1.talkMaxDuration)

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_33 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_23) / var_139_33

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_23 + var_139_33 and arg_136_1.time_ < var_139_23 + var_139_33 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play417031034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417031034
		arg_140_1.duration_ = 5.9

		local var_140_0 = {
			zh = 4.7,
			ja = 5.9
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417031035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1034"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 1, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_8 = arg_140_1.actors_["1015"]
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 and not isNil(var_143_8) and arg_140_1.var_.actorSpriteComps1015 == nil then
				arg_140_1.var_.actorSpriteComps1015 = var_143_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_10 = 0.2

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_10 and not isNil(var_143_8) then
				local var_143_11 = (arg_140_1.time_ - var_143_9) / var_143_10

				if arg_140_1.var_.actorSpriteComps1015 then
					for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_143_5 then
							if arg_140_1.isInRecall_ then
								local var_143_12 = Mathf.Lerp(iter_143_5.color.r, arg_140_1.hightColor2.r, var_143_11)
								local var_143_13 = Mathf.Lerp(iter_143_5.color.g, arg_140_1.hightColor2.g, var_143_11)
								local var_143_14 = Mathf.Lerp(iter_143_5.color.b, arg_140_1.hightColor2.b, var_143_11)

								iter_143_5.color = Color.New(var_143_12, var_143_13, var_143_14)
							else
								local var_143_15 = Mathf.Lerp(iter_143_5.color.r, 0.5, var_143_11)

								iter_143_5.color = Color.New(var_143_15, var_143_15, var_143_15)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_9 + var_143_10 and arg_140_1.time_ < var_143_9 + var_143_10 + arg_143_0 and not isNil(var_143_8) and arg_140_1.var_.actorSpriteComps1015 then
				for iter_143_6, iter_143_7 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_143_7 then
						if arg_140_1.isInRecall_ then
							iter_143_7.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1015 = nil
			end

			local var_143_16 = 0
			local var_143_17 = 0.55

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_18 = arg_140_1:FormatText(StoryNameCfg[1109].name)

				arg_140_1.leftNameTxt_.text = var_143_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_19 = arg_140_1:GetWordFromCfg(417031034)
				local var_143_20 = arg_140_1:FormatText(var_143_19.content)

				arg_140_1.text_.text = var_143_20

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_21 = 22
				local var_143_22 = utf8.len(var_143_20)
				local var_143_23 = var_143_21 <= 0 and var_143_17 or var_143_17 * (var_143_22 / var_143_21)

				if var_143_23 > 0 and var_143_17 < var_143_23 then
					arg_140_1.talkMaxDuration = var_143_23

					if var_143_23 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_16
					end
				end

				arg_140_1.text_.text = var_143_20
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031034", "story_v_out_417031.awb") ~= 0 then
					local var_143_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031034", "story_v_out_417031.awb") / 1000

					if var_143_24 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_24 + var_143_16
					end

					if var_143_19.prefab_name ~= "" and arg_140_1.actors_[var_143_19.prefab_name] ~= nil then
						local var_143_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_19.prefab_name].transform, "story_v_out_417031", "417031034", "story_v_out_417031.awb")

						arg_140_1:RecordAudio("417031034", var_143_25)
						arg_140_1:RecordAudio("417031034", var_143_25)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417031", "417031034", "story_v_out_417031.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417031", "417031034", "story_v_out_417031.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_26 = math.max(var_143_17, arg_140_1.talkMaxDuration)

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_26 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_16) / var_143_26

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_16 + var_143_26 and arg_140_1.time_ < var_143_16 + var_143_26 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417031035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417031035
		arg_144_1.duration_ = 4.87

		local var_144_0 = {
			zh = 3.333,
			ja = 4.866
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417031036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1015"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1015 == nil then
				arg_144_1.var_.actorSpriteComps1015 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps1015 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 1, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1015 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1015 = nil
			end

			local var_147_8 = arg_144_1.actors_["1034"]
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps1034 == nil then
				arg_144_1.var_.actorSpriteComps1034 = var_147_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_10 = 0.2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 and not isNil(var_147_8) then
				local var_147_11 = (arg_144_1.time_ - var_147_9) / var_147_10

				if arg_144_1.var_.actorSpriteComps1034 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								local var_147_12 = Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor2.r, var_147_11)
								local var_147_13 = Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor2.g, var_147_11)
								local var_147_14 = Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor2.b, var_147_11)

								iter_147_5.color = Color.New(var_147_12, var_147_13, var_147_14)
							else
								local var_147_15 = Mathf.Lerp(iter_147_5.color.r, 0.5, var_147_11)

								iter_147_5.color = Color.New(var_147_15, var_147_15, var_147_15)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps1034 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_147_7 then
						if arg_144_1.isInRecall_ then
							iter_147_7.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1034 = nil
			end

			local var_147_16 = 0
			local var_147_17 = 0.425

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_18 = arg_144_1:FormatText(StoryNameCfg[479].name)

				arg_144_1.leftNameTxt_.text = var_147_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_19 = arg_144_1:GetWordFromCfg(417031035)
				local var_147_20 = arg_144_1:FormatText(var_147_19.content)

				arg_144_1.text_.text = var_147_20

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_21 = 17
				local var_147_22 = utf8.len(var_147_20)
				local var_147_23 = var_147_21 <= 0 and var_147_17 or var_147_17 * (var_147_22 / var_147_21)

				if var_147_23 > 0 and var_147_17 < var_147_23 then
					arg_144_1.talkMaxDuration = var_147_23

					if var_147_23 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_16
					end
				end

				arg_144_1.text_.text = var_147_20
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031035", "story_v_out_417031.awb") ~= 0 then
					local var_147_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031035", "story_v_out_417031.awb") / 1000

					if var_147_24 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_16
					end

					if var_147_19.prefab_name ~= "" and arg_144_1.actors_[var_147_19.prefab_name] ~= nil then
						local var_147_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_19.prefab_name].transform, "story_v_out_417031", "417031035", "story_v_out_417031.awb")

						arg_144_1:RecordAudio("417031035", var_147_25)
						arg_144_1:RecordAudio("417031035", var_147_25)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417031", "417031035", "story_v_out_417031.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417031", "417031035", "story_v_out_417031.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_26 = math.max(var_147_17, arg_144_1.talkMaxDuration)

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_26 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_16) / var_147_26

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_16 + var_147_26 and arg_144_1.time_ < var_147_16 + var_147_26 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417031036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417031036
		arg_148_1.duration_ = 6.73

		local var_148_0 = {
			zh = 5.533,
			ja = 6.733
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417031037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1034"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_8 = arg_148_1.actors_["1015"]
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps1015 == nil then
				arg_148_1.var_.actorSpriteComps1015 = var_151_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_10 = 0.2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 and not isNil(var_151_8) then
				local var_151_11 = (arg_148_1.time_ - var_151_9) / var_151_10

				if arg_148_1.var_.actorSpriteComps1015 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								local var_151_12 = Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, var_151_11)
								local var_151_13 = Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, var_151_11)
								local var_151_14 = Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, var_151_11)

								iter_151_5.color = Color.New(var_151_12, var_151_13, var_151_14)
							else
								local var_151_15 = Mathf.Lerp(iter_151_5.color.r, 0.5, var_151_11)

								iter_151_5.color = Color.New(var_151_15, var_151_15, var_151_15)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps1015 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_151_7 then
						if arg_148_1.isInRecall_ then
							iter_151_7.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1015 = nil
			end

			local var_151_16 = arg_148_1.actors_["1034"].transform
			local var_151_17 = 0

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				arg_148_1.var_.moveOldPos1034 = var_151_16.localPosition
				var_151_16.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1034", 4)

				local var_151_18 = var_151_16.childCount

				for iter_151_8 = 0, var_151_18 - 1 do
					local var_151_19 = var_151_16:GetChild(iter_151_8)

					if var_151_19.name == "split_3" or not string.find(var_151_19.name, "split") then
						var_151_19.gameObject:SetActive(true)
					else
						var_151_19.gameObject:SetActive(false)
					end
				end
			end

			local var_151_20 = 0.001

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_20 then
				local var_151_21 = (arg_148_1.time_ - var_151_17) / var_151_20
				local var_151_22 = Vector3.New(373.7, -331.9, -324)

				var_151_16.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1034, var_151_22, var_151_21)
			end

			if arg_148_1.time_ >= var_151_17 + var_151_20 and arg_148_1.time_ < var_151_17 + var_151_20 + arg_151_0 then
				var_151_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_151_23 = 0
			local var_151_24 = 0.675

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_25 = arg_148_1:FormatText(StoryNameCfg[1109].name)

				arg_148_1.leftNameTxt_.text = var_151_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_26 = arg_148_1:GetWordFromCfg(417031036)
				local var_151_27 = arg_148_1:FormatText(var_151_26.content)

				arg_148_1.text_.text = var_151_27

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_28 = 27
				local var_151_29 = utf8.len(var_151_27)
				local var_151_30 = var_151_28 <= 0 and var_151_24 or var_151_24 * (var_151_29 / var_151_28)

				if var_151_30 > 0 and var_151_24 < var_151_30 then
					arg_148_1.talkMaxDuration = var_151_30

					if var_151_30 + var_151_23 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_30 + var_151_23
					end
				end

				arg_148_1.text_.text = var_151_27
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031036", "story_v_out_417031.awb") ~= 0 then
					local var_151_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031036", "story_v_out_417031.awb") / 1000

					if var_151_31 + var_151_23 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_31 + var_151_23
					end

					if var_151_26.prefab_name ~= "" and arg_148_1.actors_[var_151_26.prefab_name] ~= nil then
						local var_151_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_26.prefab_name].transform, "story_v_out_417031", "417031036", "story_v_out_417031.awb")

						arg_148_1:RecordAudio("417031036", var_151_32)
						arg_148_1:RecordAudio("417031036", var_151_32)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417031", "417031036", "story_v_out_417031.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417031", "417031036", "story_v_out_417031.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_33 = math.max(var_151_24, arg_148_1.talkMaxDuration)

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_33 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_23) / var_151_33

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_23 + var_151_33 and arg_148_1.time_ < var_151_23 + var_151_33 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417031037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417031037
		arg_152_1.duration_ = 3.63

		local var_152_0 = {
			zh = 3.633,
			ja = 3.6
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417031038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1015"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1015 == nil then
				arg_152_1.var_.actorSpriteComps1015 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1015 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 1, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1015 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1015 = nil
			end

			local var_155_8 = arg_152_1.actors_["1034"]
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps1034 == nil then
				arg_152_1.var_.actorSpriteComps1034 = var_155_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_10 = 0.2

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_10 and not isNil(var_155_8) then
				local var_155_11 = (arg_152_1.time_ - var_155_9) / var_155_10

				if arg_152_1.var_.actorSpriteComps1034 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_155_5 then
							if arg_152_1.isInRecall_ then
								local var_155_12 = Mathf.Lerp(iter_155_5.color.r, arg_152_1.hightColor2.r, var_155_11)
								local var_155_13 = Mathf.Lerp(iter_155_5.color.g, arg_152_1.hightColor2.g, var_155_11)
								local var_155_14 = Mathf.Lerp(iter_155_5.color.b, arg_152_1.hightColor2.b, var_155_11)

								iter_155_5.color = Color.New(var_155_12, var_155_13, var_155_14)
							else
								local var_155_15 = Mathf.Lerp(iter_155_5.color.r, 0.5, var_155_11)

								iter_155_5.color = Color.New(var_155_15, var_155_15, var_155_15)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_9 + var_155_10 and arg_152_1.time_ < var_155_9 + var_155_10 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps1034 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_155_7 then
						if arg_152_1.isInRecall_ then
							iter_155_7.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1034 = nil
			end

			local var_155_16 = arg_152_1.actors_["1015"].transform
			local var_155_17 = 0

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				arg_152_1.var_.moveOldPos1015 = var_155_16.localPosition
				var_155_16.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1015", 2)

				local var_155_18 = var_155_16.childCount

				for iter_155_8 = 0, var_155_18 - 1 do
					local var_155_19 = var_155_16:GetChild(iter_155_8)

					if var_155_19.name == "" or not string.find(var_155_19.name, "split") then
						var_155_19.gameObject:SetActive(true)
					else
						var_155_19.gameObject:SetActive(false)
					end
				end
			end

			local var_155_20 = 0.001

			if var_155_17 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_20 then
				local var_155_21 = (arg_152_1.time_ - var_155_17) / var_155_20
				local var_155_22 = Vector3.New(-390, -340, -288)

				var_155_16.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1015, var_155_22, var_155_21)
			end

			if arg_152_1.time_ >= var_155_17 + var_155_20 and arg_152_1.time_ < var_155_17 + var_155_20 + arg_155_0 then
				var_155_16.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_155_23 = 0
			local var_155_24 = 0.425

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_25 = arg_152_1:FormatText(StoryNameCfg[479].name)

				arg_152_1.leftNameTxt_.text = var_155_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_26 = arg_152_1:GetWordFromCfg(417031037)
				local var_155_27 = arg_152_1:FormatText(var_155_26.content)

				arg_152_1.text_.text = var_155_27

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_28 = 17
				local var_155_29 = utf8.len(var_155_27)
				local var_155_30 = var_155_28 <= 0 and var_155_24 or var_155_24 * (var_155_29 / var_155_28)

				if var_155_30 > 0 and var_155_24 < var_155_30 then
					arg_152_1.talkMaxDuration = var_155_30

					if var_155_30 + var_155_23 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_30 + var_155_23
					end
				end

				arg_152_1.text_.text = var_155_27
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031037", "story_v_out_417031.awb") ~= 0 then
					local var_155_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031037", "story_v_out_417031.awb") / 1000

					if var_155_31 + var_155_23 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_31 + var_155_23
					end

					if var_155_26.prefab_name ~= "" and arg_152_1.actors_[var_155_26.prefab_name] ~= nil then
						local var_155_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_26.prefab_name].transform, "story_v_out_417031", "417031037", "story_v_out_417031.awb")

						arg_152_1:RecordAudio("417031037", var_155_32)
						arg_152_1:RecordAudio("417031037", var_155_32)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417031", "417031037", "story_v_out_417031.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417031", "417031037", "story_v_out_417031.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_33 = math.max(var_155_24, arg_152_1.talkMaxDuration)

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_33 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_23) / var_155_33

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_23 + var_155_33 and arg_152_1.time_ < var_155_23 + var_155_33 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play417031038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417031038
		arg_156_1.duration_ = 13.8

		local var_156_0 = {
			zh = 13.8,
			ja = 7.6
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417031039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1034"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor1.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor1.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor1.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 1, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_8 = arg_156_1.actors_["1015"]
			local var_159_9 = 0

			if var_159_9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 and not isNil(var_159_8) and arg_156_1.var_.actorSpriteComps1015 == nil then
				arg_156_1.var_.actorSpriteComps1015 = var_159_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_10 = 0.2

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 and not isNil(var_159_8) then
				local var_159_11 = (arg_156_1.time_ - var_159_9) / var_159_10

				if arg_156_1.var_.actorSpriteComps1015 then
					for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_159_5 then
							if arg_156_1.isInRecall_ then
								local var_159_12 = Mathf.Lerp(iter_159_5.color.r, arg_156_1.hightColor2.r, var_159_11)
								local var_159_13 = Mathf.Lerp(iter_159_5.color.g, arg_156_1.hightColor2.g, var_159_11)
								local var_159_14 = Mathf.Lerp(iter_159_5.color.b, arg_156_1.hightColor2.b, var_159_11)

								iter_159_5.color = Color.New(var_159_12, var_159_13, var_159_14)
							else
								local var_159_15 = Mathf.Lerp(iter_159_5.color.r, 0.5, var_159_11)

								iter_159_5.color = Color.New(var_159_15, var_159_15, var_159_15)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 and not isNil(var_159_8) and arg_156_1.var_.actorSpriteComps1015 then
				for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_159_7 then
						if arg_156_1.isInRecall_ then
							iter_159_7.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1015 = nil
			end

			local var_159_16 = 0
			local var_159_17 = 1.3

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_18 = arg_156_1:FormatText(StoryNameCfg[1109].name)

				arg_156_1.leftNameTxt_.text = var_159_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_19 = arg_156_1:GetWordFromCfg(417031038)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 52
				local var_159_22 = utf8.len(var_159_20)
				local var_159_23 = var_159_21 <= 0 and var_159_17 or var_159_17 * (var_159_22 / var_159_21)

				if var_159_23 > 0 and var_159_17 < var_159_23 then
					arg_156_1.talkMaxDuration = var_159_23

					if var_159_23 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_16
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031038", "story_v_out_417031.awb") ~= 0 then
					local var_159_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031038", "story_v_out_417031.awb") / 1000

					if var_159_24 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_24 + var_159_16
					end

					if var_159_19.prefab_name ~= "" and arg_156_1.actors_[var_159_19.prefab_name] ~= nil then
						local var_159_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_19.prefab_name].transform, "story_v_out_417031", "417031038", "story_v_out_417031.awb")

						arg_156_1:RecordAudio("417031038", var_159_25)
						arg_156_1:RecordAudio("417031038", var_159_25)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417031", "417031038", "story_v_out_417031.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417031", "417031038", "story_v_out_417031.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_26 = math.max(var_159_17, arg_156_1.talkMaxDuration)

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_16) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_16 + var_159_26 and arg_156_1.time_ < var_159_16 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417031039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417031039
		arg_160_1.duration_ = 8.9

		local var_160_0 = {
			zh = 5.9,
			ja = 8.9
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417031040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.725

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[1109].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(417031039)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 29
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031039", "story_v_out_417031.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031039", "story_v_out_417031.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_417031", "417031039", "story_v_out_417031.awb")

						arg_160_1:RecordAudio("417031039", var_163_9)
						arg_160_1:RecordAudio("417031039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417031", "417031039", "story_v_out_417031.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417031", "417031039", "story_v_out_417031.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417031040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417031040
		arg_164_1.duration_ = 9.73

		local var_164_0 = {
			zh = 9.266,
			ja = 9.733
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417031041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1034"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1034 = var_167_0.localPosition
				var_167_0.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("1034", 4)

				local var_167_2 = var_167_0.childCount

				for iter_167_0 = 0, var_167_2 - 1 do
					local var_167_3 = var_167_0:GetChild(iter_167_0)

					if var_167_3.name == "split_4" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_4 then
				local var_167_5 = (arg_164_1.time_ - var_167_1) / var_167_4
				local var_167_6 = Vector3.New(373.7, -331.9, -324)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1034, var_167_6, var_167_5)
			end

			if arg_164_1.time_ >= var_167_1 + var_167_4 and arg_164_1.time_ < var_167_1 + var_167_4 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_167_7 = 0
			local var_167_8 = 0.875

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_9 = arg_164_1:FormatText(StoryNameCfg[1109].name)

				arg_164_1.leftNameTxt_.text = var_167_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(417031040)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_12 = 35
				local var_167_13 = utf8.len(var_167_11)
				local var_167_14 = var_167_12 <= 0 and var_167_8 or var_167_8 * (var_167_13 / var_167_12)

				if var_167_14 > 0 and var_167_8 < var_167_14 then
					arg_164_1.talkMaxDuration = var_167_14

					if var_167_14 + var_167_7 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_7
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031040", "story_v_out_417031.awb") ~= 0 then
					local var_167_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031040", "story_v_out_417031.awb") / 1000

					if var_167_15 + var_167_7 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_7
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_417031", "417031040", "story_v_out_417031.awb")

						arg_164_1:RecordAudio("417031040", var_167_16)
						arg_164_1:RecordAudio("417031040", var_167_16)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417031", "417031040", "story_v_out_417031.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417031", "417031040", "story_v_out_417031.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_17 = math.max(var_167_8, arg_164_1.talkMaxDuration)

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_17 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_7) / var_167_17

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_7 + var_167_17 and arg_164_1.time_ < var_167_7 + var_167_17 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417031041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417031041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417031042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1034"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								local var_171_4 = Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor2.r, var_171_3)
								local var_171_5 = Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor2.g, var_171_3)
								local var_171_6 = Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor2.b, var_171_3)

								iter_171_1.color = Color.New(var_171_4, var_171_5, var_171_6)
							else
								local var_171_7 = Mathf.Lerp(iter_171_1.color.r, 0.5, var_171_3)

								iter_171_1.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_8 = arg_168_1.actors_["1015"].transform
			local var_171_9 = 0

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				arg_168_1.var_.moveOldPos1015 = var_171_8.localPosition
				var_171_8.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1015", 7)

				local var_171_10 = var_171_8.childCount

				for iter_171_4 = 0, var_171_10 - 1 do
					local var_171_11 = var_171_8:GetChild(iter_171_4)

					if var_171_11.name == "" or not string.find(var_171_11.name, "split") then
						var_171_11.gameObject:SetActive(true)
					else
						var_171_11.gameObject:SetActive(false)
					end
				end
			end

			local var_171_12 = 0.001

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_12 then
				local var_171_13 = (arg_168_1.time_ - var_171_9) / var_171_12
				local var_171_14 = Vector3.New(0, -2000, 0)

				var_171_8.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1015, var_171_14, var_171_13)
			end

			if arg_168_1.time_ >= var_171_9 + var_171_12 and arg_168_1.time_ < var_171_9 + var_171_12 + arg_171_0 then
				var_171_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_171_15 = arg_168_1.actors_["1034"].transform
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.var_.moveOldPos1034 = var_171_15.localPosition
				var_171_15.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1034", 7)

				local var_171_17 = var_171_15.childCount

				for iter_171_5 = 0, var_171_17 - 1 do
					local var_171_18 = var_171_15:GetChild(iter_171_5)

					if var_171_18.name == "" or not string.find(var_171_18.name, "split") then
						var_171_18.gameObject:SetActive(true)
					else
						var_171_18.gameObject:SetActive(false)
					end
				end
			end

			local var_171_19 = 0.001

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_19 then
				local var_171_20 = (arg_168_1.time_ - var_171_16) / var_171_19
				local var_171_21 = Vector3.New(0, -2000, 0)

				var_171_15.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1034, var_171_21, var_171_20)
			end

			if arg_168_1.time_ >= var_171_16 + var_171_19 and arg_168_1.time_ < var_171_16 + var_171_19 + arg_171_0 then
				var_171_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_171_22 = 0
			local var_171_23 = 1.3

			if var_171_22 < arg_168_1.time_ and arg_168_1.time_ <= var_171_22 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_24 = arg_168_1:GetWordFromCfg(417031041)
				local var_171_25 = arg_168_1:FormatText(var_171_24.content)

				arg_168_1.text_.text = var_171_25

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_26 = 52
				local var_171_27 = utf8.len(var_171_25)
				local var_171_28 = var_171_26 <= 0 and var_171_23 or var_171_23 * (var_171_27 / var_171_26)

				if var_171_28 > 0 and var_171_23 < var_171_28 then
					arg_168_1.talkMaxDuration = var_171_28

					if var_171_28 + var_171_22 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_22
					end
				end

				arg_168_1.text_.text = var_171_25
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_29 = math.max(var_171_23, arg_168_1.talkMaxDuration)

			if var_171_22 <= arg_168_1.time_ and arg_168_1.time_ < var_171_22 + var_171_29 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_22) / var_171_29

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_22 + var_171_29 and arg_168_1.time_ < var_171_22 + var_171_29 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
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

		arg_168_1:InitPlayNodeList()
	end,
	Play417031042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417031042
		arg_172_1.duration_ = 6

		local var_172_0 = {
			zh = 4.833,
			ja = 6
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417031043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1015"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1015 == nil then
				arg_172_1.var_.actorSpriteComps1015 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps1015 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								local var_175_4 = Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, var_175_3)
								local var_175_5 = Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, var_175_3)
								local var_175_6 = Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, var_175_3)

								iter_175_1.color = Color.New(var_175_4, var_175_5, var_175_6)
							else
								local var_175_7 = Mathf.Lerp(iter_175_1.color.r, 1, var_175_3)

								iter_175_1.color = Color.New(var_175_7, var_175_7, var_175_7)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1015 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1015 = nil
			end

			local var_175_8 = arg_172_1.actors_["1015"].transform
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.var_.moveOldPos1015 = var_175_8.localPosition
				var_175_8.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1015", 2)

				local var_175_10 = var_175_8.childCount

				for iter_175_4 = 0, var_175_10 - 1 do
					local var_175_11 = var_175_8:GetChild(iter_175_4)

					if var_175_11.name == "split_4" or not string.find(var_175_11.name, "split") then
						var_175_11.gameObject:SetActive(true)
					else
						var_175_11.gameObject:SetActive(false)
					end
				end
			end

			local var_175_12 = 0.001

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_12 then
				local var_175_13 = (arg_172_1.time_ - var_175_9) / var_175_12
				local var_175_14 = Vector3.New(-390, -340, -288)

				var_175_8.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1015, var_175_14, var_175_13)
			end

			if arg_172_1.time_ >= var_175_9 + var_175_12 and arg_172_1.time_ < var_175_9 + var_175_12 + arg_175_0 then
				var_175_8.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_175_15 = 0
			local var_175_16 = 0.65

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[479].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(417031042)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 26
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031042", "story_v_out_417031.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031042", "story_v_out_417031.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_417031", "417031042", "story_v_out_417031.awb")

						arg_172_1:RecordAudio("417031042", var_175_24)
						arg_172_1:RecordAudio("417031042", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417031", "417031042", "story_v_out_417031.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417031", "417031042", "story_v_out_417031.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play417031043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417031043
		arg_176_1.duration_ = 9.2

		local var_176_0 = {
			zh = 7.033,
			ja = 9.2
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417031044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1034"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 1, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_8 = arg_176_1.actors_["1015"]
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps1015 == nil then
				arg_176_1.var_.actorSpriteComps1015 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_10 = 0.2

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 and not isNil(var_179_8) then
				local var_179_11 = (arg_176_1.time_ - var_179_9) / var_179_10

				if arg_176_1.var_.actorSpriteComps1015 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								local var_179_12 = Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, var_179_11)
								local var_179_13 = Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, var_179_11)
								local var_179_14 = Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, var_179_11)

								iter_179_5.color = Color.New(var_179_12, var_179_13, var_179_14)
							else
								local var_179_15 = Mathf.Lerp(iter_179_5.color.r, 0.5, var_179_11)

								iter_179_5.color = Color.New(var_179_15, var_179_15, var_179_15)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps1015 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_179_7 then
						if arg_176_1.isInRecall_ then
							iter_179_7.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1015 = nil
			end

			local var_179_16 = arg_176_1.actors_["1034"].transform
			local var_179_17 = 0

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.var_.moveOldPos1034 = var_179_16.localPosition
				var_179_16.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1034", 4)

				local var_179_18 = var_179_16.childCount

				for iter_179_8 = 0, var_179_18 - 1 do
					local var_179_19 = var_179_16:GetChild(iter_179_8)

					if var_179_19.name == "split_6" or not string.find(var_179_19.name, "split") then
						var_179_19.gameObject:SetActive(true)
					else
						var_179_19.gameObject:SetActive(false)
					end
				end
			end

			local var_179_20 = 0.001

			if var_179_17 <= arg_176_1.time_ and arg_176_1.time_ < var_179_17 + var_179_20 then
				local var_179_21 = (arg_176_1.time_ - var_179_17) / var_179_20
				local var_179_22 = Vector3.New(373.7, -331.9, -324)

				var_179_16.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1034, var_179_22, var_179_21)
			end

			if arg_176_1.time_ >= var_179_17 + var_179_20 and arg_176_1.time_ < var_179_17 + var_179_20 + arg_179_0 then
				var_179_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_179_23 = 0
			local var_179_24 = 0.825

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_25 = arg_176_1:FormatText(StoryNameCfg[1109].name)

				arg_176_1.leftNameTxt_.text = var_179_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_26 = arg_176_1:GetWordFromCfg(417031043)
				local var_179_27 = arg_176_1:FormatText(var_179_26.content)

				arg_176_1.text_.text = var_179_27

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_28 = 33
				local var_179_29 = utf8.len(var_179_27)
				local var_179_30 = var_179_28 <= 0 and var_179_24 or var_179_24 * (var_179_29 / var_179_28)

				if var_179_30 > 0 and var_179_24 < var_179_30 then
					arg_176_1.talkMaxDuration = var_179_30

					if var_179_30 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_30 + var_179_23
					end
				end

				arg_176_1.text_.text = var_179_27
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031043", "story_v_out_417031.awb") ~= 0 then
					local var_179_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031043", "story_v_out_417031.awb") / 1000

					if var_179_31 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_31 + var_179_23
					end

					if var_179_26.prefab_name ~= "" and arg_176_1.actors_[var_179_26.prefab_name] ~= nil then
						local var_179_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_26.prefab_name].transform, "story_v_out_417031", "417031043", "story_v_out_417031.awb")

						arg_176_1:RecordAudio("417031043", var_179_32)
						arg_176_1:RecordAudio("417031043", var_179_32)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417031", "417031043", "story_v_out_417031.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417031", "417031043", "story_v_out_417031.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_33 = math.max(var_179_24, arg_176_1.talkMaxDuration)

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_33 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_23) / var_179_33

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_23 + var_179_33 and arg_176_1.time_ < var_179_23 + var_179_33 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play417031044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417031044
		arg_180_1.duration_ = 8.23

		local var_180_0 = {
			zh = 8.233,
			ja = 7.266
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417031045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1015"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1015 == nil then
				arg_180_1.var_.actorSpriteComps1015 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1015 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 1, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1015 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1015 = nil
			end

			local var_183_8 = arg_180_1.actors_["1034"]
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_10 = 0.2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 and not isNil(var_183_8) then
				local var_183_11 = (arg_180_1.time_ - var_183_9) / var_183_10

				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								local var_183_12 = Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, var_183_11)
								local var_183_13 = Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, var_183_11)
								local var_183_14 = Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, var_183_11)

								iter_183_5.color = Color.New(var_183_12, var_183_13, var_183_14)
							else
								local var_183_15 = Mathf.Lerp(iter_183_5.color.r, 0.5, var_183_11)

								iter_183_5.color = Color.New(var_183_15, var_183_15, var_183_15)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_7 then
						if arg_180_1.isInRecall_ then
							iter_183_7.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_16 = 0
			local var_183_17 = 0.975

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_18 = arg_180_1:FormatText(StoryNameCfg[479].name)

				arg_180_1.leftNameTxt_.text = var_183_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_19 = arg_180_1:GetWordFromCfg(417031044)
				local var_183_20 = arg_180_1:FormatText(var_183_19.content)

				arg_180_1.text_.text = var_183_20

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_21 = 39
				local var_183_22 = utf8.len(var_183_20)
				local var_183_23 = var_183_21 <= 0 and var_183_17 or var_183_17 * (var_183_22 / var_183_21)

				if var_183_23 > 0 and var_183_17 < var_183_23 then
					arg_180_1.talkMaxDuration = var_183_23

					if var_183_23 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_16
					end
				end

				arg_180_1.text_.text = var_183_20
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031044", "story_v_out_417031.awb") ~= 0 then
					local var_183_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031044", "story_v_out_417031.awb") / 1000

					if var_183_24 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_24 + var_183_16
					end

					if var_183_19.prefab_name ~= "" and arg_180_1.actors_[var_183_19.prefab_name] ~= nil then
						local var_183_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_19.prefab_name].transform, "story_v_out_417031", "417031044", "story_v_out_417031.awb")

						arg_180_1:RecordAudio("417031044", var_183_25)
						arg_180_1:RecordAudio("417031044", var_183_25)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417031", "417031044", "story_v_out_417031.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417031", "417031044", "story_v_out_417031.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_26 = math.max(var_183_17, arg_180_1.talkMaxDuration)

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_26 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_16) / var_183_26

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_16 + var_183_26 and arg_180_1.time_ < var_183_16 + var_183_26 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417031045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417031045
		arg_184_1.duration_ = 10.47

		local var_184_0 = {
			zh = 5.066,
			ja = 10.466
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417031046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1034"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1034 == nil then
				arg_184_1.var_.actorSpriteComps1034 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps1034 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 1, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1034 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1034 = nil
			end

			local var_187_8 = arg_184_1.actors_["1015"]
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps1015 == nil then
				arg_184_1.var_.actorSpriteComps1015 = var_187_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_10 = 0.2

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_10 and not isNil(var_187_8) then
				local var_187_11 = (arg_184_1.time_ - var_187_9) / var_187_10

				if arg_184_1.var_.actorSpriteComps1015 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								local var_187_12 = Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, var_187_11)
								local var_187_13 = Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, var_187_11)
								local var_187_14 = Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, var_187_11)

								iter_187_5.color = Color.New(var_187_12, var_187_13, var_187_14)
							else
								local var_187_15 = Mathf.Lerp(iter_187_5.color.r, 0.5, var_187_11)

								iter_187_5.color = Color.New(var_187_15, var_187_15, var_187_15)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_9 + var_187_10 and arg_184_1.time_ < var_187_9 + var_187_10 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps1015 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_187_7 then
						if arg_184_1.isInRecall_ then
							iter_187_7.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1015 = nil
			end

			local var_187_16 = 0
			local var_187_17 = 0.575

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_18 = arg_184_1:FormatText(StoryNameCfg[1109].name)

				arg_184_1.leftNameTxt_.text = var_187_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_19 = arg_184_1:GetWordFromCfg(417031045)
				local var_187_20 = arg_184_1:FormatText(var_187_19.content)

				arg_184_1.text_.text = var_187_20

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_21 = 23
				local var_187_22 = utf8.len(var_187_20)
				local var_187_23 = var_187_21 <= 0 and var_187_17 or var_187_17 * (var_187_22 / var_187_21)

				if var_187_23 > 0 and var_187_17 < var_187_23 then
					arg_184_1.talkMaxDuration = var_187_23

					if var_187_23 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_16
					end
				end

				arg_184_1.text_.text = var_187_20
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031045", "story_v_out_417031.awb") ~= 0 then
					local var_187_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031045", "story_v_out_417031.awb") / 1000

					if var_187_24 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_16
					end

					if var_187_19.prefab_name ~= "" and arg_184_1.actors_[var_187_19.prefab_name] ~= nil then
						local var_187_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_19.prefab_name].transform, "story_v_out_417031", "417031045", "story_v_out_417031.awb")

						arg_184_1:RecordAudio("417031045", var_187_25)
						arg_184_1:RecordAudio("417031045", var_187_25)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417031", "417031045", "story_v_out_417031.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417031", "417031045", "story_v_out_417031.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_26 = math.max(var_187_17, arg_184_1.talkMaxDuration)

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_26 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_16) / var_187_26

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_16 + var_187_26 and arg_184_1.time_ < var_187_16 + var_187_26 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417031046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417031046
		arg_188_1.duration_ = 9.53

		local var_188_0 = {
			zh = 9.533,
			ja = 5.733
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417031047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1015"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1015 == nil then
				arg_188_1.var_.actorSpriteComps1015 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps1015 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 1, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1015 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1015 = nil
			end

			local var_191_8 = arg_188_1.actors_["1034"]
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_10 = 0.2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 and not isNil(var_191_8) then
				local var_191_11 = (arg_188_1.time_ - var_191_9) / var_191_10

				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								local var_191_12 = Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, var_191_11)
								local var_191_13 = Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, var_191_11)
								local var_191_14 = Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, var_191_11)

								iter_191_5.color = Color.New(var_191_12, var_191_13, var_191_14)
							else
								local var_191_15 = Mathf.Lerp(iter_191_5.color.r, 0.5, var_191_11)

								iter_191_5.color = Color.New(var_191_15, var_191_15, var_191_15)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_16 = arg_188_1.actors_["1015"].transform
			local var_191_17 = 0

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.var_.moveOldPos1015 = var_191_16.localPosition
				var_191_16.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1015", 2)

				local var_191_18 = var_191_16.childCount

				for iter_191_8 = 0, var_191_18 - 1 do
					local var_191_19 = var_191_16:GetChild(iter_191_8)

					if var_191_19.name == "split_2" or not string.find(var_191_19.name, "split") then
						var_191_19.gameObject:SetActive(true)
					else
						var_191_19.gameObject:SetActive(false)
					end
				end
			end

			local var_191_20 = 0.001

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_17) / var_191_20
				local var_191_22 = Vector3.New(-390, -340, -288)

				var_191_16.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1015, var_191_22, var_191_21)
			end

			if arg_188_1.time_ >= var_191_17 + var_191_20 and arg_188_1.time_ < var_191_17 + var_191_20 + arg_191_0 then
				var_191_16.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_191_23 = 0
			local var_191_24 = 0.925

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_25 = arg_188_1:FormatText(StoryNameCfg[479].name)

				arg_188_1.leftNameTxt_.text = var_191_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_26 = arg_188_1:GetWordFromCfg(417031046)
				local var_191_27 = arg_188_1:FormatText(var_191_26.content)

				arg_188_1.text_.text = var_191_27

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_28 = 37
				local var_191_29 = utf8.len(var_191_27)
				local var_191_30 = var_191_28 <= 0 and var_191_24 or var_191_24 * (var_191_29 / var_191_28)

				if var_191_30 > 0 and var_191_24 < var_191_30 then
					arg_188_1.talkMaxDuration = var_191_30

					if var_191_30 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_30 + var_191_23
					end
				end

				arg_188_1.text_.text = var_191_27
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031046", "story_v_out_417031.awb") ~= 0 then
					local var_191_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031046", "story_v_out_417031.awb") / 1000

					if var_191_31 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_31 + var_191_23
					end

					if var_191_26.prefab_name ~= "" and arg_188_1.actors_[var_191_26.prefab_name] ~= nil then
						local var_191_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_26.prefab_name].transform, "story_v_out_417031", "417031046", "story_v_out_417031.awb")

						arg_188_1:RecordAudio("417031046", var_191_32)
						arg_188_1:RecordAudio("417031046", var_191_32)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417031", "417031046", "story_v_out_417031.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417031", "417031046", "story_v_out_417031.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_33 = math.max(var_191_24, arg_188_1.talkMaxDuration)

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_33 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_23) / var_191_33

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_23 + var_191_33 and arg_188_1.time_ < var_191_23 + var_191_33 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play417031047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417031047
		arg_192_1.duration_ = 6.43

		local var_192_0 = {
			zh = 6.43266666666667,
			ja = 2.29966666666667
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417031048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1034"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_8 = arg_192_1.actors_["1015"]
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps1015 == nil then
				arg_192_1.var_.actorSpriteComps1015 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_10 = 0.2

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_10 and not isNil(var_195_8) then
				local var_195_11 = (arg_192_1.time_ - var_195_9) / var_195_10

				if arg_192_1.var_.actorSpriteComps1015 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								local var_195_12 = Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, var_195_11)
								local var_195_13 = Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, var_195_11)
								local var_195_14 = Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, var_195_11)

								iter_195_5.color = Color.New(var_195_12, var_195_13, var_195_14)
							else
								local var_195_15 = Mathf.Lerp(iter_195_5.color.r, 0.5, var_195_11)

								iter_195_5.color = Color.New(var_195_15, var_195_15, var_195_15)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_9 + var_195_10 and arg_192_1.time_ < var_195_9 + var_195_10 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps1015 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_195_7 then
						if arg_192_1.isInRecall_ then
							iter_195_7.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1015 = nil
			end

			local var_195_16 = arg_192_1.actors_["1034"].transform
			local var_195_17 = 0

			if var_195_17 < arg_192_1.time_ and arg_192_1.time_ <= var_195_17 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_16.localPosition
				var_195_16.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 7)

				local var_195_18 = var_195_16.childCount

				for iter_195_8 = 0, var_195_18 - 1 do
					local var_195_19 = var_195_16:GetChild(iter_195_8)

					if var_195_19.name == "split_8" or not string.find(var_195_19.name, "split") then
						var_195_19.gameObject:SetActive(true)
					else
						var_195_19.gameObject:SetActive(false)
					end
				end
			end

			local var_195_20 = 0.001

			if var_195_17 <= arg_192_1.time_ and arg_192_1.time_ < var_195_17 + var_195_20 then
				local var_195_21 = (arg_192_1.time_ - var_195_17) / var_195_20
				local var_195_22 = Vector3.New(0, -2000, 0)

				var_195_16.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1034, var_195_22, var_195_21)
			end

			if arg_192_1.time_ >= var_195_17 + var_195_20 and arg_192_1.time_ < var_195_17 + var_195_20 + arg_195_0 then
				var_195_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_195_23 = arg_192_1.actors_["1015"].transform
			local var_195_24 = 0

			if var_195_24 < arg_192_1.time_ and arg_192_1.time_ <= var_195_24 + arg_195_0 then
				arg_192_1.var_.moveOldPos1015 = var_195_23.localPosition
				var_195_23.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1015", 7)

				local var_195_25 = var_195_23.childCount

				for iter_195_9 = 0, var_195_25 - 1 do
					local var_195_26 = var_195_23:GetChild(iter_195_9)

					if var_195_26.name == "" or not string.find(var_195_26.name, "split") then
						var_195_26.gameObject:SetActive(true)
					else
						var_195_26.gameObject:SetActive(false)
					end
				end
			end

			local var_195_27 = 0.001

			if var_195_24 <= arg_192_1.time_ and arg_192_1.time_ < var_195_24 + var_195_27 then
				local var_195_28 = (arg_192_1.time_ - var_195_24) / var_195_27
				local var_195_29 = Vector3.New(0, -2000, 0)

				var_195_23.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1015, var_195_29, var_195_28)
			end

			if arg_192_1.time_ >= var_195_24 + var_195_27 and arg_192_1.time_ < var_195_24 + var_195_27 + arg_195_0 then
				var_195_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_195_30 = 0

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			local var_195_31 = 0.691666666666667

			if arg_192_1.time_ >= var_195_30 + var_195_31 and arg_192_1.time_ < var_195_30 + var_195_31 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_32 = 0.333333333332
			local var_195_33 = 1

			if var_195_32 < arg_192_1.time_ and arg_192_1.time_ <= var_195_32 + arg_195_0 then
				local var_195_34 = "play"
				local var_195_35 = "effect"

				arg_192_1:AudioAction(var_195_34, var_195_35, "se_story_1310", "se_story_1310_hitdoor", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_36 = 0.566666666666667
			local var_195_37 = 0.125

			if var_195_36 < arg_192_1.time_ and arg_192_1.time_ <= var_195_36 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_38 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_38:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_39 = arg_192_1:FormatText(StoryNameCfg[1109].name)

				arg_192_1.leftNameTxt_.text = var_195_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_40 = arg_192_1:GetWordFromCfg(417031047)
				local var_195_41 = arg_192_1:FormatText(var_195_40.content)

				arg_192_1.text_.text = var_195_41

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_42 = 5
				local var_195_43 = utf8.len(var_195_41)
				local var_195_44 = var_195_42 <= 0 and var_195_37 or var_195_37 * (var_195_43 / var_195_42)

				if var_195_44 > 0 and var_195_37 < var_195_44 then
					arg_192_1.talkMaxDuration = var_195_44
					var_195_36 = var_195_36 + 0.3

					if var_195_44 + var_195_36 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_44 + var_195_36
					end
				end

				arg_192_1.text_.text = var_195_41
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031047", "story_v_out_417031.awb") ~= 0 then
					local var_195_45 = manager.audio:GetVoiceLength("story_v_out_417031", "417031047", "story_v_out_417031.awb") / 1000

					if var_195_45 + var_195_36 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_45 + var_195_36
					end

					if var_195_40.prefab_name ~= "" and arg_192_1.actors_[var_195_40.prefab_name] ~= nil then
						local var_195_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_40.prefab_name].transform, "story_v_out_417031", "417031047", "story_v_out_417031.awb")

						arg_192_1:RecordAudio("417031047", var_195_46)
						arg_192_1:RecordAudio("417031047", var_195_46)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417031", "417031047", "story_v_out_417031.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417031", "417031047", "story_v_out_417031.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_47 = var_195_36 + 0.3
			local var_195_48 = math.max(var_195_37, arg_192_1.talkMaxDuration)

			if var_195_47 <= arg_192_1.time_ and arg_192_1.time_ < var_195_47 + var_195_48 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_47) / var_195_48

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_47 + var_195_48 and arg_192_1.time_ < var_195_47 + var_195_48 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play417031048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417031048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417031049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1034"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 0.5, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_8 = 0
			local var_201_9 = 1.25

			if var_201_8 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(417031048)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 50
				local var_201_13 = utf8.len(var_201_11)
				local var_201_14 = var_201_12 <= 0 and var_201_9 or var_201_9 * (var_201_13 / var_201_12)

				if var_201_14 > 0 and var_201_9 < var_201_14 then
					arg_198_1.talkMaxDuration = var_201_14

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_15 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_15 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_15

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_15 and arg_198_1.time_ < var_201_8 + var_201_15 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417031049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417031049
		arg_202_1.duration_ = 14.37

		local var_202_0 = {
			zh = 9.833,
			ja = 14.366
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
				arg_202_0:Play417031050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1034"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 1, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_8 = arg_202_1.actors_["1034"].transform
			local var_205_9 = 0

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 then
				arg_202_1.var_.moveOldPos1034 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1034", 3)

				local var_205_10 = var_205_8.childCount

				for iter_205_4 = 0, var_205_10 - 1 do
					local var_205_11 = var_205_8:GetChild(iter_205_4)

					if var_205_11.name == "split_6" or not string.find(var_205_11.name, "split") then
						var_205_11.gameObject:SetActive(true)
					else
						var_205_11.gameObject:SetActive(false)
					end
				end
			end

			local var_205_12 = 0.001

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_12 then
				local var_205_13 = (arg_202_1.time_ - var_205_9) / var_205_12
				local var_205_14 = Vector3.New(0, -331.9, -324)

				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1034, var_205_14, var_205_13)
			end

			if arg_202_1.time_ >= var_205_9 + var_205_12 and arg_202_1.time_ < var_205_9 + var_205_12 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_205_15 = 0
			local var_205_16 = 1.075

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_17 = arg_202_1:FormatText(StoryNameCfg[1109].name)

				arg_202_1.leftNameTxt_.text = var_205_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_18 = arg_202_1:GetWordFromCfg(417031049)
				local var_205_19 = arg_202_1:FormatText(var_205_18.content)

				arg_202_1.text_.text = var_205_19

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_20 = 43
				local var_205_21 = utf8.len(var_205_19)
				local var_205_22 = var_205_20 <= 0 and var_205_16 or var_205_16 * (var_205_21 / var_205_20)

				if var_205_22 > 0 and var_205_16 < var_205_22 then
					arg_202_1.talkMaxDuration = var_205_22

					if var_205_22 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_19
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031049", "story_v_out_417031.awb") ~= 0 then
					local var_205_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031049", "story_v_out_417031.awb") / 1000

					if var_205_23 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_15
					end

					if var_205_18.prefab_name ~= "" and arg_202_1.actors_[var_205_18.prefab_name] ~= nil then
						local var_205_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_18.prefab_name].transform, "story_v_out_417031", "417031049", "story_v_out_417031.awb")

						arg_202_1:RecordAudio("417031049", var_205_24)
						arg_202_1:RecordAudio("417031049", var_205_24)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417031", "417031049", "story_v_out_417031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417031", "417031049", "story_v_out_417031.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_25 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_25 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_25

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_25 and arg_202_1.time_ < var_205_15 + var_205_25 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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

		arg_202_1:InitPlayNodeList()
	end,
	Play417031050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417031050
		arg_206_1.duration_ = 7.8

		local var_206_0 = {
			zh = 5.733,
			ja = 7.8
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
				arg_206_0:Play417031051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1015"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1015 == nil then
				arg_206_1.var_.actorSpriteComps1015 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1015 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1015 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1015 = nil
			end

			local var_209_8 = arg_206_1.actors_["1034"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_16 = arg_206_1.actors_["1015"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos1015 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1015", 3)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(0, -340, -288)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1015, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(0, -340, -288)
			end

			local var_209_23 = arg_206_1.actors_["1034"].transform
			local var_209_24 = 0

			if var_209_24 < arg_206_1.time_ and arg_206_1.time_ <= var_209_24 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_23.localPosition
				var_209_23.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 7)

				local var_209_25 = var_209_23.childCount

				for iter_209_9 = 0, var_209_25 - 1 do
					local var_209_26 = var_209_23:GetChild(iter_209_9)

					if var_209_26.name == "" or not string.find(var_209_26.name, "split") then
						var_209_26.gameObject:SetActive(true)
					else
						var_209_26.gameObject:SetActive(false)
					end
				end
			end

			local var_209_27 = 0.001

			if var_209_24 <= arg_206_1.time_ and arg_206_1.time_ < var_209_24 + var_209_27 then
				local var_209_28 = (arg_206_1.time_ - var_209_24) / var_209_27
				local var_209_29 = Vector3.New(0, -2000, 0)

				var_209_23.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, var_209_29, var_209_28)
			end

			if arg_206_1.time_ >= var_209_24 + var_209_27 and arg_206_1.time_ < var_209_24 + var_209_27 + arg_209_0 then
				var_209_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_30 = 0
			local var_209_31 = 0.7

			if var_209_30 < arg_206_1.time_ and arg_206_1.time_ <= var_209_30 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_32 = arg_206_1:FormatText(StoryNameCfg[479].name)

				arg_206_1.leftNameTxt_.text = var_209_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_33 = arg_206_1:GetWordFromCfg(417031050)
				local var_209_34 = arg_206_1:FormatText(var_209_33.content)

				arg_206_1.text_.text = var_209_34

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_35 = 28
				local var_209_36 = utf8.len(var_209_34)
				local var_209_37 = var_209_35 <= 0 and var_209_31 or var_209_31 * (var_209_36 / var_209_35)

				if var_209_37 > 0 and var_209_31 < var_209_37 then
					arg_206_1.talkMaxDuration = var_209_37

					if var_209_37 + var_209_30 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_37 + var_209_30
					end
				end

				arg_206_1.text_.text = var_209_34
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031050", "story_v_out_417031.awb") ~= 0 then
					local var_209_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031050", "story_v_out_417031.awb") / 1000

					if var_209_38 + var_209_30 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_38 + var_209_30
					end

					if var_209_33.prefab_name ~= "" and arg_206_1.actors_[var_209_33.prefab_name] ~= nil then
						local var_209_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_33.prefab_name].transform, "story_v_out_417031", "417031050", "story_v_out_417031.awb")

						arg_206_1:RecordAudio("417031050", var_209_39)
						arg_206_1:RecordAudio("417031050", var_209_39)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417031", "417031050", "story_v_out_417031.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417031", "417031050", "story_v_out_417031.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_40 = math.max(var_209_31, arg_206_1.talkMaxDuration)

			if var_209_30 <= arg_206_1.time_ and arg_206_1.time_ < var_209_30 + var_209_40 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_30) / var_209_40

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_30 + var_209_40 and arg_206_1.time_ < var_209_30 + var_209_40 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
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

		arg_206_1:InitPlayNodeList()
	end,
	Play417031051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417031051
		arg_210_1.duration_ = 1.37

		local var_210_0 = {
			zh = 1.133,
			ja = 1.366
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
				arg_210_0:Play417031052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1034"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 1, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_8 = arg_210_1.actors_["1015"]
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1015 == nil then
				arg_210_1.var_.actorSpriteComps1015 = var_213_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_10 = 0.2

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_10 and not isNil(var_213_8) then
				local var_213_11 = (arg_210_1.time_ - var_213_9) / var_213_10

				if arg_210_1.var_.actorSpriteComps1015 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								local var_213_12 = Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, var_213_11)
								local var_213_13 = Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, var_213_11)
								local var_213_14 = Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, var_213_11)

								iter_213_5.color = Color.New(var_213_12, var_213_13, var_213_14)
							else
								local var_213_15 = Mathf.Lerp(iter_213_5.color.r, 0.5, var_213_11)

								iter_213_5.color = Color.New(var_213_15, var_213_15, var_213_15)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_10 and arg_210_1.time_ < var_213_9 + var_213_10 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1015 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_213_7 then
						if arg_210_1.isInRecall_ then
							iter_213_7.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1015 = nil
			end

			local var_213_16 = 0
			local var_213_17 = 0.05

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_18 = arg_210_1:FormatText(StoryNameCfg[1109].name)

				arg_210_1.leftNameTxt_.text = var_213_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_19 = arg_210_1:GetWordFromCfg(417031051)
				local var_213_20 = arg_210_1:FormatText(var_213_19.content)

				arg_210_1.text_.text = var_213_20

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_21 = 2
				local var_213_22 = utf8.len(var_213_20)
				local var_213_23 = var_213_21 <= 0 and var_213_17 or var_213_17 * (var_213_22 / var_213_21)

				if var_213_23 > 0 and var_213_17 < var_213_23 then
					arg_210_1.talkMaxDuration = var_213_23

					if var_213_23 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_16
					end
				end

				arg_210_1.text_.text = var_213_20
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031051", "story_v_out_417031.awb") ~= 0 then
					local var_213_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031051", "story_v_out_417031.awb") / 1000

					if var_213_24 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_24 + var_213_16
					end

					if var_213_19.prefab_name ~= "" and arg_210_1.actors_[var_213_19.prefab_name] ~= nil then
						local var_213_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_19.prefab_name].transform, "story_v_out_417031", "417031051", "story_v_out_417031.awb")

						arg_210_1:RecordAudio("417031051", var_213_25)
						arg_210_1:RecordAudio("417031051", var_213_25)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417031", "417031051", "story_v_out_417031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417031", "417031051", "story_v_out_417031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_26 = math.max(var_213_17, arg_210_1.talkMaxDuration)

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_26 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_16) / var_213_26

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_16 + var_213_26 and arg_210_1.time_ < var_213_16 + var_213_26 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417031052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417031052
		arg_214_1.duration_ = 8.2

		local var_214_0 = {
			zh = 8.2,
			ja = 7
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
				arg_214_0:Play417031053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1015"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1015 == nil then
				arg_214_1.var_.actorSpriteComps1015 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps1015 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 1, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1015 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps1015 = nil
			end

			local var_217_8 = arg_214_1.actors_["1034"]
			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps1034 == nil then
				arg_214_1.var_.actorSpriteComps1034 = var_217_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_10 = 0.2

			if var_217_9 <= arg_214_1.time_ and arg_214_1.time_ < var_217_9 + var_217_10 and not isNil(var_217_8) then
				local var_217_11 = (arg_214_1.time_ - var_217_9) / var_217_10

				if arg_214_1.var_.actorSpriteComps1034 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								local var_217_12 = Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, var_217_11)
								local var_217_13 = Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, var_217_11)
								local var_217_14 = Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, var_217_11)

								iter_217_5.color = Color.New(var_217_12, var_217_13, var_217_14)
							else
								local var_217_15 = Mathf.Lerp(iter_217_5.color.r, 0.5, var_217_11)

								iter_217_5.color = Color.New(var_217_15, var_217_15, var_217_15)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_9 + var_217_10 and arg_214_1.time_ < var_217_9 + var_217_10 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps1034 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_217_7 then
						if arg_214_1.isInRecall_ then
							iter_217_7.color = arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_217_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps1034 = nil
			end

			local var_217_16 = 0
			local var_217_17 = 1.1

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_18 = arg_214_1:FormatText(StoryNameCfg[479].name)

				arg_214_1.leftNameTxt_.text = var_217_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_19 = arg_214_1:GetWordFromCfg(417031052)
				local var_217_20 = arg_214_1:FormatText(var_217_19.content)

				arg_214_1.text_.text = var_217_20

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_21 = 44
				local var_217_22 = utf8.len(var_217_20)
				local var_217_23 = var_217_21 <= 0 and var_217_17 or var_217_17 * (var_217_22 / var_217_21)

				if var_217_23 > 0 and var_217_17 < var_217_23 then
					arg_214_1.talkMaxDuration = var_217_23

					if var_217_23 + var_217_16 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_16
					end
				end

				arg_214_1.text_.text = var_217_20
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031052", "story_v_out_417031.awb") ~= 0 then
					local var_217_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031052", "story_v_out_417031.awb") / 1000

					if var_217_24 + var_217_16 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_24 + var_217_16
					end

					if var_217_19.prefab_name ~= "" and arg_214_1.actors_[var_217_19.prefab_name] ~= nil then
						local var_217_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_19.prefab_name].transform, "story_v_out_417031", "417031052", "story_v_out_417031.awb")

						arg_214_1:RecordAudio("417031052", var_217_25)
						arg_214_1:RecordAudio("417031052", var_217_25)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417031", "417031052", "story_v_out_417031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417031", "417031052", "story_v_out_417031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_26 = math.max(var_217_17, arg_214_1.talkMaxDuration)

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_26 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_16) / var_217_26

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_16 + var_217_26 and arg_214_1.time_ < var_217_16 + var_217_26 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417031053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417031053
		arg_218_1.duration_ = 10.37

		local var_218_0 = {
			zh = 9.8,
			ja = 10.366
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417031054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1015"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1015 = var_221_0.localPosition
				var_221_0.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1015", 3)

				local var_221_2 = var_221_0.childCount

				for iter_221_0 = 0, var_221_2 - 1 do
					local var_221_3 = var_221_0:GetChild(iter_221_0)

					if var_221_3.name == "" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_4 then
				local var_221_5 = (arg_218_1.time_ - var_221_1) / var_221_4
				local var_221_6 = Vector3.New(0, -340, -288)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1015, var_221_6, var_221_5)
			end

			if arg_218_1.time_ >= var_221_1 + var_221_4 and arg_218_1.time_ < var_221_1 + var_221_4 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -340, -288)
			end

			local var_221_7 = 0
			local var_221_8 = 0.975

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_9 = arg_218_1:FormatText(StoryNameCfg[479].name)

				arg_218_1.leftNameTxt_.text = var_221_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(417031053)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_12 = 39
				local var_221_13 = utf8.len(var_221_11)
				local var_221_14 = var_221_12 <= 0 and var_221_8 or var_221_8 * (var_221_13 / var_221_12)

				if var_221_14 > 0 and var_221_8 < var_221_14 then
					arg_218_1.talkMaxDuration = var_221_14

					if var_221_14 + var_221_7 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_7
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031053", "story_v_out_417031.awb") ~= 0 then
					local var_221_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031053", "story_v_out_417031.awb") / 1000

					if var_221_15 + var_221_7 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_15 + var_221_7
					end

					if var_221_10.prefab_name ~= "" and arg_218_1.actors_[var_221_10.prefab_name] ~= nil then
						local var_221_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_10.prefab_name].transform, "story_v_out_417031", "417031053", "story_v_out_417031.awb")

						arg_218_1:RecordAudio("417031053", var_221_16)
						arg_218_1:RecordAudio("417031053", var_221_16)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417031", "417031053", "story_v_out_417031.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417031", "417031053", "story_v_out_417031.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_17 = math.max(var_221_8, arg_218_1.talkMaxDuration)

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_17 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_7) / var_221_17

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_7 + var_221_17 and arg_218_1.time_ < var_221_7 + var_221_17 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play417031054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417031054
		arg_222_1.duration_ = 8.2

		local var_222_0 = {
			zh = 5.566,
			ja = 8.2
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
				arg_222_0:Play417031055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1015"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1015 = var_225_0.localPosition
				var_225_0.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1015", 3)

				local var_225_2 = var_225_0.childCount

				for iter_225_0 = 0, var_225_2 - 1 do
					local var_225_3 = var_225_0:GetChild(iter_225_0)

					if var_225_3.name == "split_4" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_4 then
				local var_225_5 = (arg_222_1.time_ - var_225_1) / var_225_4
				local var_225_6 = Vector3.New(0, -340, -288)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1015, var_225_6, var_225_5)
			end

			if arg_222_1.time_ >= var_225_1 + var_225_4 and arg_222_1.time_ < var_225_1 + var_225_4 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -340, -288)
			end

			local var_225_7 = 0
			local var_225_8 = 0.525

			if var_225_7 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_9 = arg_222_1:FormatText(StoryNameCfg[479].name)

				arg_222_1.leftNameTxt_.text = var_225_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(417031054)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_12 = 21
				local var_225_13 = utf8.len(var_225_11)
				local var_225_14 = var_225_12 <= 0 and var_225_8 or var_225_8 * (var_225_13 / var_225_12)

				if var_225_14 > 0 and var_225_8 < var_225_14 then
					arg_222_1.talkMaxDuration = var_225_14

					if var_225_14 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_7
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031054", "story_v_out_417031.awb") ~= 0 then
					local var_225_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031054", "story_v_out_417031.awb") / 1000

					if var_225_15 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_7
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_417031", "417031054", "story_v_out_417031.awb")

						arg_222_1:RecordAudio("417031054", var_225_16)
						arg_222_1:RecordAudio("417031054", var_225_16)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417031", "417031054", "story_v_out_417031.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417031", "417031054", "story_v_out_417031.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_17 = math.max(var_225_8, arg_222_1.talkMaxDuration)

			if var_225_7 <= arg_222_1.time_ and arg_222_1.time_ < var_225_7 + var_225_17 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_7) / var_225_17

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_7 + var_225_17 and arg_222_1.time_ < var_225_7 + var_225_17 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play417031055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417031055
		arg_226_1.duration_ = 6.52

		local var_226_0 = {
			zh = 5.983,
			ja = 6.516
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
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417031056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = "I07a"

			if arg_226_1.bgs_[var_229_0] == nil then
				local var_229_1 = Object.Instantiate(arg_226_1.paintGo_)

				var_229_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_229_0)
				var_229_1.name = var_229_0
				var_229_1.transform.parent = arg_226_1.stage_.transform
				var_229_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.bgs_[var_229_0] = var_229_1
			end

			local var_229_2 = 2

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				local var_229_3 = manager.ui.mainCamera.transform.localPosition
				local var_229_4 = Vector3.New(0, 0, 10) + Vector3.New(var_229_3.x, var_229_3.y, 0)
				local var_229_5 = arg_226_1.bgs_.I07a

				var_229_5.transform.localPosition = var_229_4
				var_229_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_229_6 = var_229_5:GetComponent("SpriteRenderer")

				if var_229_6 and var_229_6.sprite then
					local var_229_7 = (var_229_5.transform.localPosition - var_229_3).z
					local var_229_8 = manager.ui.mainCameraCom_
					local var_229_9 = 2 * var_229_7 * Mathf.Tan(var_229_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_229_10 = var_229_9 * var_229_8.aspect
					local var_229_11 = var_229_6.sprite.bounds.size.x
					local var_229_12 = var_229_6.sprite.bounds.size.y
					local var_229_13 = var_229_10 / var_229_11
					local var_229_14 = var_229_9 / var_229_12
					local var_229_15 = var_229_14 < var_229_13 and var_229_13 or var_229_14

					var_229_5.transform.localScale = Vector3.New(var_229_15, var_229_15, 0)
				end

				for iter_229_0, iter_229_1 in pairs(arg_226_1.bgs_) do
					if iter_229_0 ~= "I07a" then
						iter_229_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1.allBtn_.enabled = false
			end

			local var_229_17 = 0.3

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 then
				arg_226_1.allBtn_.enabled = true
			end

			local var_229_18 = 0

			if var_229_18 < arg_226_1.time_ and arg_226_1.time_ <= var_229_18 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_19 = 2

			if var_229_18 <= arg_226_1.time_ and arg_226_1.time_ < var_229_18 + var_229_19 then
				local var_229_20 = (arg_226_1.time_ - var_229_18) / var_229_19
				local var_229_21 = Color.New(0, 0, 0)

				var_229_21.a = Mathf.Lerp(0, 1, var_229_20)
				arg_226_1.mask_.color = var_229_21
			end

			if arg_226_1.time_ >= var_229_18 + var_229_19 and arg_226_1.time_ < var_229_18 + var_229_19 + arg_229_0 then
				local var_229_22 = Color.New(0, 0, 0)

				var_229_22.a = 1
				arg_226_1.mask_.color = var_229_22
			end

			local var_229_23 = 2

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_24 = 2

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_24 then
				local var_229_25 = (arg_226_1.time_ - var_229_23) / var_229_24
				local var_229_26 = Color.New(0, 0, 0)

				var_229_26.a = Mathf.Lerp(1, 0, var_229_25)
				arg_226_1.mask_.color = var_229_26
			end

			if arg_226_1.time_ >= var_229_23 + var_229_24 and arg_226_1.time_ < var_229_23 + var_229_24 + arg_229_0 then
				local var_229_27 = Color.New(0, 0, 0)
				local var_229_28 = 0

				arg_226_1.mask_.enabled = false
				var_229_27.a = var_229_28
				arg_226_1.mask_.color = var_229_27
			end

			local var_229_29 = arg_226_1.actors_["1015"].transform
			local var_229_30 = 1.96666666666667

			if var_229_30 < arg_226_1.time_ and arg_226_1.time_ <= var_229_30 + arg_229_0 then
				arg_226_1.var_.moveOldPos1015 = var_229_29.localPosition
				var_229_29.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1015", 7)

				local var_229_31 = var_229_29.childCount

				for iter_229_2 = 0, var_229_31 - 1 do
					local var_229_32 = var_229_29:GetChild(iter_229_2)

					if var_229_32.name == "" or not string.find(var_229_32.name, "split") then
						var_229_32.gameObject:SetActive(true)
					else
						var_229_32.gameObject:SetActive(false)
					end
				end
			end

			local var_229_33 = 0.001

			if var_229_30 <= arg_226_1.time_ and arg_226_1.time_ < var_229_30 + var_229_33 then
				local var_229_34 = (arg_226_1.time_ - var_229_30) / var_229_33
				local var_229_35 = Vector3.New(0, -2000, 0)

				var_229_29.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1015, var_229_35, var_229_34)
			end

			if arg_226_1.time_ >= var_229_30 + var_229_33 and arg_226_1.time_ < var_229_30 + var_229_33 + arg_229_0 then
				var_229_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_36 = arg_226_1.actors_["1034"].transform
			local var_229_37 = 1.96666666666667

			if var_229_37 < arg_226_1.time_ and arg_226_1.time_ <= var_229_37 + arg_229_0 then
				arg_226_1.var_.moveOldPos1034 = var_229_36.localPosition
				var_229_36.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1034", 7)

				local var_229_38 = var_229_36.childCount

				for iter_229_3 = 0, var_229_38 - 1 do
					local var_229_39 = var_229_36:GetChild(iter_229_3)

					if var_229_39.name == "" or not string.find(var_229_39.name, "split") then
						var_229_39.gameObject:SetActive(true)
					else
						var_229_39.gameObject:SetActive(false)
					end
				end
			end

			local var_229_40 = 0.001

			if var_229_37 <= arg_226_1.time_ and arg_226_1.time_ < var_229_37 + var_229_40 then
				local var_229_41 = (arg_226_1.time_ - var_229_37) / var_229_40
				local var_229_42 = Vector3.New(0, -2000, 0)

				var_229_36.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1034, var_229_42, var_229_41)
			end

			if arg_226_1.time_ >= var_229_37 + var_229_40 and arg_226_1.time_ < var_229_37 + var_229_40 + arg_229_0 then
				var_229_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_43 = 2.00066666666667

			arg_226_1.isInRecall_ = true

			if var_229_43 < arg_226_1.time_ and arg_226_1.time_ <= var_229_43 + arg_229_0 then
				arg_226_1.screenFilterGo_:SetActive(true)

				arg_226_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_226_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_226_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_229_4, iter_229_5 in pairs(arg_226_1.actors_) do
					local var_229_44 = iter_229_5:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_229_6, iter_229_7 in ipairs(var_229_44) do
						if iter_229_7.color.r > 0.51 then
							iter_229_7.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_229_7.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_229_45 = 0.0166666666666667

			if var_229_43 <= arg_226_1.time_ and arg_226_1.time_ < var_229_43 + var_229_45 then
				local var_229_46 = (arg_226_1.time_ - var_229_43) / var_229_45

				arg_226_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_229_46)
			end

			if arg_226_1.time_ >= var_229_43 + var_229_45 and arg_226_1.time_ < var_229_43 + var_229_45 + arg_229_0 then
				arg_226_1.screenFilterEffect_.weight = 1
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_47 = 3.75
			local var_229_48 = 0.25

			if var_229_47 < arg_226_1.time_ and arg_226_1.time_ <= var_229_47 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_49 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_49:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_50 = arg_226_1:FormatText(StoryNameCfg[1118].name)

				arg_226_1.leftNameTxt_.text = var_229_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_226_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_229_51 = arg_226_1:GetWordFromCfg(417031055)
				local var_229_52 = arg_226_1:FormatText(var_229_51.content)

				arg_226_1.text_.text = var_229_52

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_53 = 10
				local var_229_54 = utf8.len(var_229_52)
				local var_229_55 = var_229_53 <= 0 and var_229_48 or var_229_48 * (var_229_54 / var_229_53)

				if var_229_55 > 0 and var_229_48 < var_229_55 then
					arg_226_1.talkMaxDuration = var_229_55
					var_229_47 = var_229_47 + 0.3

					if var_229_55 + var_229_47 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_55 + var_229_47
					end
				end

				arg_226_1.text_.text = var_229_52
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031055", "story_v_out_417031.awb") ~= 0 then
					local var_229_56 = manager.audio:GetVoiceLength("story_v_out_417031", "417031055", "story_v_out_417031.awb") / 1000

					if var_229_56 + var_229_47 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_56 + var_229_47
					end

					if var_229_51.prefab_name ~= "" and arg_226_1.actors_[var_229_51.prefab_name] ~= nil then
						local var_229_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_51.prefab_name].transform, "story_v_out_417031", "417031055", "story_v_out_417031.awb")

						arg_226_1:RecordAudio("417031055", var_229_57)
						arg_226_1:RecordAudio("417031055", var_229_57)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417031", "417031055", "story_v_out_417031.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417031", "417031055", "story_v_out_417031.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_58 = var_229_47 + 0.3
			local var_229_59 = math.max(var_229_48, arg_226_1.talkMaxDuration)

			if var_229_58 <= arg_226_1.time_ and arg_226_1.time_ < var_229_58 + var_229_59 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_58) / var_229_59

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_58 + var_229_59 and arg_226_1.time_ < var_229_58 + var_229_59 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play417031056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 417031056
		arg_232_1.duration_ = 4.1

		local var_232_0 = {
			zh = 1.466,
			ja = 4.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play417031057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1034"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1034 == nil then
				arg_232_1.var_.actorSpriteComps1034 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps1034 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 1, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1034 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps1034 = nil
			end

			local var_235_8 = arg_232_1.actors_["1034"].transform
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.var_.moveOldPos1034 = var_235_8.localPosition
				var_235_8.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1034", 3)

				local var_235_10 = var_235_8.childCount

				for iter_235_4 = 0, var_235_10 - 1 do
					local var_235_11 = var_235_8:GetChild(iter_235_4)

					if var_235_11.name == "" or not string.find(var_235_11.name, "split") then
						var_235_11.gameObject:SetActive(true)
					else
						var_235_11.gameObject:SetActive(false)
					end
				end
			end

			local var_235_12 = 0.001

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_12 then
				local var_235_13 = (arg_232_1.time_ - var_235_9) / var_235_12
				local var_235_14 = Vector3.New(0, -331.9, -324)

				var_235_8.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1034, var_235_14, var_235_13)
			end

			if arg_232_1.time_ >= var_235_9 + var_235_12 and arg_232_1.time_ < var_235_9 + var_235_12 + arg_235_0 then
				var_235_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_235_15 = 0
			local var_235_16 = 0.125

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_17 = arg_232_1:FormatText(StoryNameCfg[1109].name)

				arg_232_1.leftNameTxt_.text = var_235_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(417031056)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_20 = 5
				local var_235_21 = utf8.len(var_235_19)
				local var_235_22 = var_235_20 <= 0 and var_235_16 or var_235_16 * (var_235_21 / var_235_20)

				if var_235_22 > 0 and var_235_16 < var_235_22 then
					arg_232_1.talkMaxDuration = var_235_22

					if var_235_22 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031056", "story_v_out_417031.awb") ~= 0 then
					local var_235_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031056", "story_v_out_417031.awb") / 1000

					if var_235_23 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_15
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_out_417031", "417031056", "story_v_out_417031.awb")

						arg_232_1:RecordAudio("417031056", var_235_24)
						arg_232_1:RecordAudio("417031056", var_235_24)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_417031", "417031056", "story_v_out_417031.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_417031", "417031056", "story_v_out_417031.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_25 and arg_232_1.time_ < var_235_15 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play417031057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417031057
		arg_236_1.duration_ = 7.6

		local var_236_0 = {
			zh = 7.033,
			ja = 7.6
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417031058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1034"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps1034 == nil then
				arg_236_1.var_.actorSpriteComps1034 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps1034 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 0.5, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps1034 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps1034 = nil
			end

			local var_239_8 = 0
			local var_239_9 = 0.575

			if var_239_8 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_10 = arg_236_1:FormatText(StoryNameCfg[1118].name)

				arg_236_1.leftNameTxt_.text = var_239_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_236_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_239_11 = arg_236_1:GetWordFromCfg(417031057)
				local var_239_12 = arg_236_1:FormatText(var_239_11.content)

				arg_236_1.text_.text = var_239_12

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 23
				local var_239_14 = utf8.len(var_239_12)
				local var_239_15 = var_239_13 <= 0 and var_239_9 or var_239_9 * (var_239_14 / var_239_13)

				if var_239_15 > 0 and var_239_9 < var_239_15 then
					arg_236_1.talkMaxDuration = var_239_15

					if var_239_15 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_15 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_12
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031057", "story_v_out_417031.awb") ~= 0 then
					local var_239_16 = manager.audio:GetVoiceLength("story_v_out_417031", "417031057", "story_v_out_417031.awb") / 1000

					if var_239_16 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_16 + var_239_8
					end

					if var_239_11.prefab_name ~= "" and arg_236_1.actors_[var_239_11.prefab_name] ~= nil then
						local var_239_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_11.prefab_name].transform, "story_v_out_417031", "417031057", "story_v_out_417031.awb")

						arg_236_1:RecordAudio("417031057", var_239_17)
						arg_236_1:RecordAudio("417031057", var_239_17)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_417031", "417031057", "story_v_out_417031.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_417031", "417031057", "story_v_out_417031.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_18 = math.max(var_239_9, arg_236_1.talkMaxDuration)

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_18 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_8) / var_239_18

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_8 + var_239_18 and arg_236_1.time_ < var_239_8 + var_239_18 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417031058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417031058
		arg_240_1.duration_ = 11.33

		local var_240_0 = {
			zh = 11.333,
			ja = 9.633
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play417031059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.075

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[1118].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(417031058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 43
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031058", "story_v_out_417031.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031058", "story_v_out_417031.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_417031", "417031058", "story_v_out_417031.awb")

						arg_240_1:RecordAudio("417031058", var_243_9)
						arg_240_1:RecordAudio("417031058", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417031", "417031058", "story_v_out_417031.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417031", "417031058", "story_v_out_417031.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417031059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417031059
		arg_244_1.duration_ = 3.77

		local var_244_0 = {
			zh = 3.366,
			ja = 3.766
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417031060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1034"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1034 == nil then
				arg_244_1.var_.actorSpriteComps1034 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps1034 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1034 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1034 = nil
			end

			local var_247_8 = arg_244_1.actors_["1034"].transform
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.var_.moveOldPos1034 = var_247_8.localPosition
				var_247_8.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1034", 3)

				local var_247_10 = var_247_8.childCount

				for iter_247_4 = 0, var_247_10 - 1 do
					local var_247_11 = var_247_8:GetChild(iter_247_4)

					if var_247_11.name == "split_6" or not string.find(var_247_11.name, "split") then
						var_247_11.gameObject:SetActive(true)
					else
						var_247_11.gameObject:SetActive(false)
					end
				end
			end

			local var_247_12 = 0.001

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_12 then
				local var_247_13 = (arg_244_1.time_ - var_247_9) / var_247_12
				local var_247_14 = Vector3.New(0, -331.9, -324)

				var_247_8.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1034, var_247_14, var_247_13)
			end

			if arg_244_1.time_ >= var_247_9 + var_247_12 and arg_244_1.time_ < var_247_9 + var_247_12 + arg_247_0 then
				var_247_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_247_15 = 0
			local var_247_16 = 0.475

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[1109].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(417031059)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 19
				local var_247_21 = utf8.len(var_247_19)
				local var_247_22 = var_247_20 <= 0 and var_247_16 or var_247_16 * (var_247_21 / var_247_20)

				if var_247_22 > 0 and var_247_16 < var_247_22 then
					arg_244_1.talkMaxDuration = var_247_22

					if var_247_22 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_22 + var_247_15
					end
				end

				arg_244_1.text_.text = var_247_19
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031059", "story_v_out_417031.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031059", "story_v_out_417031.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_out_417031", "417031059", "story_v_out_417031.awb")

						arg_244_1:RecordAudio("417031059", var_247_24)
						arg_244_1:RecordAudio("417031059", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417031", "417031059", "story_v_out_417031.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417031", "417031059", "story_v_out_417031.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_25 = math.max(var_247_16, arg_244_1.talkMaxDuration)

			if var_247_15 <= arg_244_1.time_ and arg_244_1.time_ < var_247_15 + var_247_25 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_15) / var_247_25

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_15 + var_247_25 and arg_244_1.time_ < var_247_15 + var_247_25 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play417031060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417031060
		arg_248_1.duration_ = 9.37

		local var_248_0 = {
			zh = 9.366,
			ja = 8.633
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417031061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1034"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps1034 == nil then
				arg_248_1.var_.actorSpriteComps1034 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps1034 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor2.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor2.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor2.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 0.5, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps1034 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1034 = nil
			end

			local var_251_8 = 0
			local var_251_9 = 0.875

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_10 = arg_248_1:FormatText(StoryNameCfg[1118].name)

				arg_248_1.leftNameTxt_.text = var_251_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_11 = arg_248_1:GetWordFromCfg(417031060)
				local var_251_12 = arg_248_1:FormatText(var_251_11.content)

				arg_248_1.text_.text = var_251_12

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 35
				local var_251_14 = utf8.len(var_251_12)
				local var_251_15 = var_251_13 <= 0 and var_251_9 or var_251_9 * (var_251_14 / var_251_13)

				if var_251_15 > 0 and var_251_9 < var_251_15 then
					arg_248_1.talkMaxDuration = var_251_15

					if var_251_15 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_15 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_12
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031060", "story_v_out_417031.awb") ~= 0 then
					local var_251_16 = manager.audio:GetVoiceLength("story_v_out_417031", "417031060", "story_v_out_417031.awb") / 1000

					if var_251_16 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_16 + var_251_8
					end

					if var_251_11.prefab_name ~= "" and arg_248_1.actors_[var_251_11.prefab_name] ~= nil then
						local var_251_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_11.prefab_name].transform, "story_v_out_417031", "417031060", "story_v_out_417031.awb")

						arg_248_1:RecordAudio("417031060", var_251_17)
						arg_248_1:RecordAudio("417031060", var_251_17)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417031", "417031060", "story_v_out_417031.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417031", "417031060", "story_v_out_417031.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_18 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_18 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_18

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_18 and arg_248_1.time_ < var_251_8 + var_251_18 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417031061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417031061
		arg_252_1.duration_ = 8.13

		local var_252_0 = {
			zh = 7.666,
			ja = 8.133
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417031062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.625

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[1118].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(417031061)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 25
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031061", "story_v_out_417031.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031061", "story_v_out_417031.awb") / 1000

					if var_255_8 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_0
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_417031", "417031061", "story_v_out_417031.awb")

						arg_252_1:RecordAudio("417031061", var_255_9)
						arg_252_1:RecordAudio("417031061", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417031", "417031061", "story_v_out_417031.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417031", "417031061", "story_v_out_417031.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_10 and arg_252_1.time_ < var_255_0 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417031062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417031062
		arg_256_1.duration_ = 8.9

		local var_256_0 = {
			zh = 8.899999999999,
			ja = 6.965999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417031063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = "ST04c"

			if arg_256_1.bgs_[var_259_0] == nil then
				local var_259_1 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_259_0)
				var_259_1.name = var_259_0
				var_259_1.transform.parent = arg_256_1.stage_.transform
				var_259_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_[var_259_0] = var_259_1
			end

			local var_259_2 = 2

			if var_259_2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				local var_259_3 = manager.ui.mainCamera.transform.localPosition
				local var_259_4 = Vector3.New(0, 0, 10) + Vector3.New(var_259_3.x, var_259_3.y, 0)
				local var_259_5 = arg_256_1.bgs_.ST04c

				var_259_5.transform.localPosition = var_259_4
				var_259_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_6 = var_259_5:GetComponent("SpriteRenderer")

				if var_259_6 and var_259_6.sprite then
					local var_259_7 = (var_259_5.transform.localPosition - var_259_3).z
					local var_259_8 = manager.ui.mainCameraCom_
					local var_259_9 = 2 * var_259_7 * Mathf.Tan(var_259_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_259_10 = var_259_9 * var_259_8.aspect
					local var_259_11 = var_259_6.sprite.bounds.size.x
					local var_259_12 = var_259_6.sprite.bounds.size.y
					local var_259_13 = var_259_10 / var_259_11
					local var_259_14 = var_259_9 / var_259_12
					local var_259_15 = var_259_14 < var_259_13 and var_259_13 or var_259_14

					var_259_5.transform.localScale = Vector3.New(var_259_15, var_259_15, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "ST04c" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_16 = 2

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			local var_259_17 = 0.3

			if arg_256_1.time_ >= var_259_16 + var_259_17 and arg_256_1.time_ < var_259_16 + var_259_17 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_18 = 0

			if var_259_18 < arg_256_1.time_ and arg_256_1.time_ <= var_259_18 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_19 = 2

			if var_259_18 <= arg_256_1.time_ and arg_256_1.time_ < var_259_18 + var_259_19 then
				local var_259_20 = (arg_256_1.time_ - var_259_18) / var_259_19
				local var_259_21 = Color.New(0, 0, 0)

				var_259_21.a = Mathf.Lerp(0, 1, var_259_20)
				arg_256_1.mask_.color = var_259_21
			end

			if arg_256_1.time_ >= var_259_18 + var_259_19 and arg_256_1.time_ < var_259_18 + var_259_19 + arg_259_0 then
				local var_259_22 = Color.New(0, 0, 0)

				var_259_22.a = 1
				arg_256_1.mask_.color = var_259_22
			end

			local var_259_23 = 2

			if var_259_23 < arg_256_1.time_ and arg_256_1.time_ <= var_259_23 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_24 = 2

			if var_259_23 <= arg_256_1.time_ and arg_256_1.time_ < var_259_23 + var_259_24 then
				local var_259_25 = (arg_256_1.time_ - var_259_23) / var_259_24
				local var_259_26 = Color.New(0, 0, 0)

				var_259_26.a = Mathf.Lerp(1, 0, var_259_25)
				arg_256_1.mask_.color = var_259_26
			end

			if arg_256_1.time_ >= var_259_23 + var_259_24 and arg_256_1.time_ < var_259_23 + var_259_24 + arg_259_0 then
				local var_259_27 = Color.New(0, 0, 0)
				local var_259_28 = 0

				arg_256_1.mask_.enabled = false
				var_259_27.a = var_259_28
				arg_256_1.mask_.color = var_259_27
			end

			local var_259_29 = arg_256_1.actors_["1034"].transform
			local var_259_30 = 1.966

			if var_259_30 < arg_256_1.time_ and arg_256_1.time_ <= var_259_30 + arg_259_0 then
				arg_256_1.var_.moveOldPos1034 = var_259_29.localPosition
				var_259_29.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("1034", 7)

				local var_259_31 = var_259_29.childCount

				for iter_259_2 = 0, var_259_31 - 1 do
					local var_259_32 = var_259_29:GetChild(iter_259_2)

					if var_259_32.name == "" or not string.find(var_259_32.name, "split") then
						var_259_32.gameObject:SetActive(true)
					else
						var_259_32.gameObject:SetActive(false)
					end
				end
			end

			local var_259_33 = 0.001

			if var_259_30 <= arg_256_1.time_ and arg_256_1.time_ < var_259_30 + var_259_33 then
				local var_259_34 = (arg_256_1.time_ - var_259_30) / var_259_33
				local var_259_35 = Vector3.New(0, -2000, 0)

				var_259_29.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1034, var_259_35, var_259_34)
			end

			if arg_256_1.time_ >= var_259_30 + var_259_33 and arg_256_1.time_ < var_259_30 + var_259_33 + arg_259_0 then
				var_259_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_259_36 = 2

			arg_256_1.isInRecall_ = false

			if var_259_36 < arg_256_1.time_ and arg_256_1.time_ <= var_259_36 + arg_259_0 then
				arg_256_1.screenFilterGo_:SetActive(false)

				for iter_259_3, iter_259_4 in pairs(arg_256_1.actors_) do
					local var_259_37 = iter_259_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_259_5, iter_259_6 in ipairs(var_259_37) do
						if iter_259_6.color.r > 0.51 then
							iter_259_6.color = Color.New(1, 1, 1)
						else
							iter_259_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_259_38 = 0.0166666666666667

			if var_259_36 <= arg_256_1.time_ and arg_256_1.time_ < var_259_36 + var_259_38 then
				local var_259_39 = (arg_256_1.time_ - var_259_36) / var_259_38

				arg_256_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_259_39)
			end

			if arg_256_1.time_ >= var_259_36 + var_259_38 and arg_256_1.time_ < var_259_36 + var_259_38 + arg_259_0 then
				arg_256_1.screenFilterEffect_.weight = 0
			end

			local var_259_40 = 1.53333333333333
			local var_259_41 = 1

			if var_259_40 < arg_256_1.time_ and arg_256_1.time_ <= var_259_40 + arg_259_0 then
				local var_259_42 = "play"
				local var_259_43 = "effect"

				arg_256_1:AudioAction(var_259_42, var_259_43, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_259_44 = 0.966
			local var_259_45 = 0.2

			if var_259_44 < arg_256_1.time_ and arg_256_1.time_ <= var_259_44 + arg_259_0 then
				local var_259_46 = "play"
				local var_259_47 = "music"

				arg_256_1:AudioAction(var_259_46, var_259_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_259_48 = ""
				local var_259_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_259_49 ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_49 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_49

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_49
						arg_256_1.bgmTxt2_.text = var_259_49
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_50 = 3.699999999999
			local var_259_51 = 0.575

			if var_259_50 < arg_256_1.time_ and arg_256_1.time_ <= var_259_50 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_52 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_52:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_256_1.dialogCg_.alpha = arg_261_0
				end))
				var_259_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_53 = arg_256_1:FormatText(StoryNameCfg[1109].name)

				arg_256_1.leftNameTxt_.text = var_259_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_54 = arg_256_1:GetWordFromCfg(417031062)
				local var_259_55 = arg_256_1:FormatText(var_259_54.content)

				arg_256_1.text_.text = var_259_55

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_56 = 23
				local var_259_57 = utf8.len(var_259_55)
				local var_259_58 = var_259_56 <= 0 and var_259_51 or var_259_51 * (var_259_57 / var_259_56)

				if var_259_58 > 0 and var_259_51 < var_259_58 then
					arg_256_1.talkMaxDuration = var_259_58
					var_259_50 = var_259_50 + 0.3

					if var_259_58 + var_259_50 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_58 + var_259_50
					end
				end

				arg_256_1.text_.text = var_259_55
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031062", "story_v_out_417031.awb") ~= 0 then
					local var_259_59 = manager.audio:GetVoiceLength("story_v_out_417031", "417031062", "story_v_out_417031.awb") / 1000

					if var_259_59 + var_259_50 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_59 + var_259_50
					end

					if var_259_54.prefab_name ~= "" and arg_256_1.actors_[var_259_54.prefab_name] ~= nil then
						local var_259_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_54.prefab_name].transform, "story_v_out_417031", "417031062", "story_v_out_417031.awb")

						arg_256_1:RecordAudio("417031062", var_259_60)
						arg_256_1:RecordAudio("417031062", var_259_60)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417031", "417031062", "story_v_out_417031.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417031", "417031062", "story_v_out_417031.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_61 = var_259_50 + 0.3
			local var_259_62 = math.max(var_259_51, arg_256_1.talkMaxDuration)

			if var_259_61 <= arg_256_1.time_ and arg_256_1.time_ < var_259_61 + var_259_62 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_61) / var_259_62

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_61 + var_259_62 and arg_256_1.time_ < var_259_61 + var_259_62 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play417031063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417031063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play417031064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1.5

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(417031063)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 60
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play417031064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417031064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play417031065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.425

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(417031064)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 57
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417031065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417031065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play417031066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.05
			local var_274_1 = 1

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				local var_274_2 = "play"
				local var_274_3 = "effect"

				arg_271_1:AudioAction(var_274_2, var_274_3, "se_story_side_1058", "se_story_side_1058_splash", "")
			end

			local var_274_4 = 0
			local var_274_5 = 1.225

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(417031065)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_8 = 49
				local var_274_9 = utf8.len(var_274_7)
				local var_274_10 = var_274_8 <= 0 and var_274_5 or var_274_5 * (var_274_9 / var_274_8)

				if var_274_10 > 0 and var_274_5 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_11 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_11 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_11

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_11 and arg_271_1.time_ < var_274_4 + var_274_11 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play417031066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417031066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play417031067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1034"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1034 == nil then
				arg_275_1.var_.actorSpriteComps1034 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1034 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1034 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1034 = nil
			end

			local var_278_8 = arg_275_1.actors_["1034"].transform
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.var_.moveOldPos1034 = var_278_8.localPosition
				var_278_8.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("1034", 3)

				local var_278_10 = var_278_8.childCount

				for iter_278_4 = 0, var_278_10 - 1 do
					local var_278_11 = var_278_8:GetChild(iter_278_4)

					if var_278_11.name == "split_4" or not string.find(var_278_11.name, "split") then
						var_278_11.gameObject:SetActive(true)
					else
						var_278_11.gameObject:SetActive(false)
					end
				end
			end

			local var_278_12 = 0.001

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_12 then
				local var_278_13 = (arg_275_1.time_ - var_278_9) / var_278_12
				local var_278_14 = Vector3.New(0, -331.9, -324)

				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1034, var_278_14, var_278_13)
			end

			if arg_275_1.time_ >= var_278_9 + var_278_12 and arg_275_1.time_ < var_278_9 + var_278_12 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_278_15 = 0.05
			local var_278_16 = 1

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				local var_278_17 = "play"
				local var_278_18 = "effect"

				arg_275_1:AudioAction(var_278_17, var_278_18, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_278_19 = 0
			local var_278_20 = 0.05

			if var_278_19 < arg_275_1.time_ and arg_275_1.time_ <= var_278_19 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_21 = arg_275_1:FormatText(StoryNameCfg[1109].name)

				arg_275_1.leftNameTxt_.text = var_278_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_22 = arg_275_1:GetWordFromCfg(417031066)
				local var_278_23 = arg_275_1:FormatText(var_278_22.content)

				arg_275_1.text_.text = var_278_23

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_24 = 2
				local var_278_25 = utf8.len(var_278_23)
				local var_278_26 = var_278_24 <= 0 and var_278_20 or var_278_20 * (var_278_25 / var_278_24)

				if var_278_26 > 0 and var_278_20 < var_278_26 then
					arg_275_1.talkMaxDuration = var_278_26

					if var_278_26 + var_278_19 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_26 + var_278_19
					end
				end

				arg_275_1.text_.text = var_278_23
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_27 = math.max(var_278_20, arg_275_1.talkMaxDuration)

			if var_278_19 <= arg_275_1.time_ and arg_275_1.time_ < var_278_19 + var_278_27 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_19) / var_278_27

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_19 + var_278_27 and arg_275_1.time_ < var_278_19 + var_278_27 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play417031067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417031067
		arg_279_1.duration_ = 2.57

		local var_279_0 = {
			zh = 2,
			ja = 2.566
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
				arg_279_0:Play417031068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.125

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_2 = arg_279_1:FormatText(StoryNameCfg[1109].name)

				arg_279_1.leftNameTxt_.text = var_282_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:GetWordFromCfg(417031067)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 5
				local var_282_6 = utf8.len(var_282_4)
				local var_282_7 = var_282_5 <= 0 and var_282_1 or var_282_1 * (var_282_6 / var_282_5)

				if var_282_7 > 0 and var_282_1 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031067", "story_v_out_417031.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031067", "story_v_out_417031.awb") / 1000

					if var_282_8 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_0
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_417031", "417031067", "story_v_out_417031.awb")

						arg_279_1:RecordAudio("417031067", var_282_9)
						arg_279_1:RecordAudio("417031067", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417031", "417031067", "story_v_out_417031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417031", "417031067", "story_v_out_417031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_10 and arg_279_1.time_ < var_282_0 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play417031068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417031068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play417031069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1034"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1034 == nil then
				arg_283_1.var_.actorSpriteComps1034 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps1034 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1034 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1034 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 1.325

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(417031068)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_12 = 53
				local var_286_13 = utf8.len(var_286_11)
				local var_286_14 = var_286_12 <= 0 and var_286_9 or var_286_9 * (var_286_13 / var_286_12)

				if var_286_14 > 0 and var_286_9 < var_286_14 then
					arg_283_1.talkMaxDuration = var_286_14

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_15 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_15 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_15

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_15 and arg_283_1.time_ < var_286_8 + var_286_15 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play417031069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417031069
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			zh = 5.833,
			ja = 7.3
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
				arg_287_0:Play417031070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.675

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[1114].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_287_1.callingController_:SetSelectedState("calling")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(417031069)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 27
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031069", "story_v_out_417031.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031069", "story_v_out_417031.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_417031", "417031069", "story_v_out_417031.awb")

						arg_287_1:RecordAudio("417031069", var_290_9)
						arg_287_1:RecordAudio("417031069", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_417031", "417031069", "story_v_out_417031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_417031", "417031069", "story_v_out_417031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play417031070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417031070
		arg_291_1.duration_ = 8.83

		local var_291_0 = {
			zh = 5.3,
			ja = 8.833
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play417031071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1034"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1034 == nil then
				arg_291_1.var_.actorSpriteComps1034 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1034 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 1, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1034 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1034 = nil
			end

			local var_294_8 = arg_291_1.actors_["1034"].transform
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034 = var_294_8.localPosition
				var_294_8.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1034", 3)

				local var_294_10 = var_294_8.childCount

				for iter_294_4 = 0, var_294_10 - 1 do
					local var_294_11 = var_294_8:GetChild(iter_294_4)

					if var_294_11.name == "split_6" or not string.find(var_294_11.name, "split") then
						var_294_11.gameObject:SetActive(true)
					else
						var_294_11.gameObject:SetActive(false)
					end
				end
			end

			local var_294_12 = 0.001

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_9) / var_294_12
				local var_294_14 = Vector3.New(0, -331.9, -324)

				var_294_8.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034, var_294_14, var_294_13)
			end

			if arg_291_1.time_ >= var_294_9 + var_294_12 and arg_291_1.time_ < var_294_9 + var_294_12 + arg_294_0 then
				var_294_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_294_15 = 0
			local var_294_16 = 0.6

			if var_294_15 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_17 = arg_291_1:FormatText(StoryNameCfg[1109].name)

				arg_291_1.leftNameTxt_.text = var_294_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_18 = arg_291_1:GetWordFromCfg(417031070)
				local var_294_19 = arg_291_1:FormatText(var_294_18.content)

				arg_291_1.text_.text = var_294_19

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_20 = 24
				local var_294_21 = utf8.len(var_294_19)
				local var_294_22 = var_294_20 <= 0 and var_294_16 or var_294_16 * (var_294_21 / var_294_20)

				if var_294_22 > 0 and var_294_16 < var_294_22 then
					arg_291_1.talkMaxDuration = var_294_22

					if var_294_22 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_22 + var_294_15
					end
				end

				arg_291_1.text_.text = var_294_19
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031070", "story_v_out_417031.awb") ~= 0 then
					local var_294_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031070", "story_v_out_417031.awb") / 1000

					if var_294_23 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_15
					end

					if var_294_18.prefab_name ~= "" and arg_291_1.actors_[var_294_18.prefab_name] ~= nil then
						local var_294_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_18.prefab_name].transform, "story_v_out_417031", "417031070", "story_v_out_417031.awb")

						arg_291_1:RecordAudio("417031070", var_294_24)
						arg_291_1:RecordAudio("417031070", var_294_24)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_417031", "417031070", "story_v_out_417031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_417031", "417031070", "story_v_out_417031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_25 = math.max(var_294_16, arg_291_1.talkMaxDuration)

			if var_294_15 <= arg_291_1.time_ and arg_291_1.time_ < var_294_15 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_15) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_15 + var_294_25 and arg_291_1.time_ < var_294_15 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play417031071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417031071
		arg_295_1.duration_ = 7.97

		local var_295_0 = {
			zh = 5.7,
			ja = 7.966
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
				arg_295_0:Play417031072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1034"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1034 == nil then
				arg_295_1.var_.actorSpriteComps1034 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps1034 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 0.5, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1034 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1034 = nil
			end

			local var_298_8 = 0
			local var_298_9 = 0.775

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_10 = arg_295_1:FormatText(StoryNameCfg[1114].name)

				arg_295_1.leftNameTxt_.text = var_298_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_295_1.callingController_:SetSelectedState("calling")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_11 = arg_295_1:GetWordFromCfg(417031071)
				local var_298_12 = arg_295_1:FormatText(var_298_11.content)

				arg_295_1.text_.text = var_298_12

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 31
				local var_298_14 = utf8.len(var_298_12)
				local var_298_15 = var_298_13 <= 0 and var_298_9 or var_298_9 * (var_298_14 / var_298_13)

				if var_298_15 > 0 and var_298_9 < var_298_15 then
					arg_295_1.talkMaxDuration = var_298_15

					if var_298_15 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_15 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_12
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031071", "story_v_out_417031.awb") ~= 0 then
					local var_298_16 = manager.audio:GetVoiceLength("story_v_out_417031", "417031071", "story_v_out_417031.awb") / 1000

					if var_298_16 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_16 + var_298_8
					end

					if var_298_11.prefab_name ~= "" and arg_295_1.actors_[var_298_11.prefab_name] ~= nil then
						local var_298_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_11.prefab_name].transform, "story_v_out_417031", "417031071", "story_v_out_417031.awb")

						arg_295_1:RecordAudio("417031071", var_298_17)
						arg_295_1:RecordAudio("417031071", var_298_17)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417031", "417031071", "story_v_out_417031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417031", "417031071", "story_v_out_417031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_18 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_18 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_18

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_18 and arg_295_1.time_ < var_298_8 + var_298_18 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play417031072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 417031072
		arg_299_1.duration_ = 3.87

		local var_299_0 = {
			zh = 2.433,
			ja = 3.866
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
				arg_299_0:Play417031073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1034"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1034 == nil then
				arg_299_1.var_.actorSpriteComps1034 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps1034 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 1, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1034 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1034 = nil
			end

			local var_302_8 = arg_299_1.actors_["1034"].transform
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 then
				arg_299_1.var_.moveOldPos1034 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1034", 3)

				local var_302_10 = var_302_8.childCount

				for iter_302_4 = 0, var_302_10 - 1 do
					local var_302_11 = var_302_8:GetChild(iter_302_4)

					if var_302_11.name == "split_6" or not string.find(var_302_11.name, "split") then
						var_302_11.gameObject:SetActive(true)
					else
						var_302_11.gameObject:SetActive(false)
					end
				end
			end

			local var_302_12 = 0.001

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_12 then
				local var_302_13 = (arg_299_1.time_ - var_302_9) / var_302_12
				local var_302_14 = Vector3.New(0, -331.9, -324)

				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1034, var_302_14, var_302_13)
			end

			if arg_299_1.time_ >= var_302_9 + var_302_12 and arg_299_1.time_ < var_302_9 + var_302_12 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_302_15 = 0
			local var_302_16 = 0.275

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[1109].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(417031072)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 11
				local var_302_21 = utf8.len(var_302_19)
				local var_302_22 = var_302_20 <= 0 and var_302_16 or var_302_16 * (var_302_21 / var_302_20)

				if var_302_22 > 0 and var_302_16 < var_302_22 then
					arg_299_1.talkMaxDuration = var_302_22

					if var_302_22 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_22 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_19
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031072", "story_v_out_417031.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031072", "story_v_out_417031.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_417031", "417031072", "story_v_out_417031.awb")

						arg_299_1:RecordAudio("417031072", var_302_24)
						arg_299_1:RecordAudio("417031072", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_417031", "417031072", "story_v_out_417031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_417031", "417031072", "story_v_out_417031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_25 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_25 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_25

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_25 and arg_299_1.time_ < var_302_15 + var_302_25 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play417031073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 417031073
		arg_303_1.duration_ = 5.3

		local var_303_0 = {
			zh = 2.833,
			ja = 5.3
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
				arg_303_0:Play417031074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1034"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1034 == nil then
				arg_303_1.var_.actorSpriteComps1034 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1034 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 0.5, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1034 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1034 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 0.2

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				local var_306_10 = "play"
				local var_306_11 = "music"

				arg_303_1:AudioAction(var_306_10, var_306_11, "ui_battle", "ui_battle_stopbgm", "")

				local var_306_12 = ""
				local var_306_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_306_13 ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_13 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_13

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_13
						arg_303_1.bgmTxt2_.text = var_306_13
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_14 = 0.5
			local var_306_15 = 1

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				local var_306_16 = "play"
				local var_306_17 = "music"

				arg_303_1:AudioAction(var_306_16, var_306_17, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_306_18 = ""
				local var_306_19 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_306_19 ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_19 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_19

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_19
						arg_303_1.bgmTxt2_.text = var_306_19
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_20 = 0
			local var_306_21 = 0.325

			if var_306_20 < arg_303_1.time_ and arg_303_1.time_ <= var_306_20 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_22 = arg_303_1:FormatText(StoryNameCfg[1114].name)

				arg_303_1.leftNameTxt_.text = var_306_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_303_1.callingController_:SetSelectedState("calling")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_23 = arg_303_1:GetWordFromCfg(417031073)
				local var_306_24 = arg_303_1:FormatText(var_306_23.content)

				arg_303_1.text_.text = var_306_24

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_25 = 13
				local var_306_26 = utf8.len(var_306_24)
				local var_306_27 = var_306_25 <= 0 and var_306_21 or var_306_21 * (var_306_26 / var_306_25)

				if var_306_27 > 0 and var_306_21 < var_306_27 then
					arg_303_1.talkMaxDuration = var_306_27

					if var_306_27 + var_306_20 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_27 + var_306_20
					end
				end

				arg_303_1.text_.text = var_306_24
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031073", "story_v_out_417031.awb") ~= 0 then
					local var_306_28 = manager.audio:GetVoiceLength("story_v_out_417031", "417031073", "story_v_out_417031.awb") / 1000

					if var_306_28 + var_306_20 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_28 + var_306_20
					end

					if var_306_23.prefab_name ~= "" and arg_303_1.actors_[var_306_23.prefab_name] ~= nil then
						local var_306_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_23.prefab_name].transform, "story_v_out_417031", "417031073", "story_v_out_417031.awb")

						arg_303_1:RecordAudio("417031073", var_306_29)
						arg_303_1:RecordAudio("417031073", var_306_29)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_417031", "417031073", "story_v_out_417031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_417031", "417031073", "story_v_out_417031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_30 = math.max(var_306_21, arg_303_1.talkMaxDuration)

			if var_306_20 <= arg_303_1.time_ and arg_303_1.time_ < var_306_20 + var_306_30 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_20) / var_306_30

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_20 + var_306_30 and arg_303_1.time_ < var_306_20 + var_306_30 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play417031074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 417031074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play417031075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1034"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1034 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1034", 7)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(0, -2000, 0)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1034, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_312_7 = 0
			local var_312_8 = 0.7

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_9 = arg_309_1:GetWordFromCfg(417031074)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 57
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_8 or var_312_8 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_8 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_7 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_7
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_8, arg_309_1.talkMaxDuration)

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_7) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_7 + var_312_14 and arg_309_1.time_ < var_312_7 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play417031075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417031075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play417031076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 1.425

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

				local var_316_2 = arg_313_1:GetWordFromCfg(417031075)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 57
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
	Play417031076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 417031076
		arg_317_1.duration_ = 5.8

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play417031077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.334

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.cswbg_:SetActive(true)

				local var_320_1 = arg_317_1.cswt_:GetComponent("RectTransform")

				arg_317_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_320_1.offsetMin = Vector2.New(400, 105)
				var_320_1.offsetMax = Vector2.New(-400, -200)

				local var_320_2 = arg_317_1:GetWordFromCfg(419096)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.cswt_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.cswt_)

				arg_317_1.cswt_.fontSize = 105
				arg_317_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_317_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_320_4 = 1.3

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				local var_320_5 = arg_317_1.fswbg_.transform:Find("textbox/adapt/content") or arg_317_1.fswbg_.transform:Find("textbox/content")
				local var_320_6 = arg_317_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_320_7 = var_320_5:GetComponent("Text")
				local var_320_8 = var_320_5:GetComponent("RectTransform")

				var_320_7.alignment = UnityEngine.TextAnchor.LowerCenter
				var_320_8.offsetMin = Vector2.New(0, 0)
				var_320_8.offsetMax = Vector2.New(0, 0)
			end

			local var_320_9 = 1.3

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.fswbg_:SetActive(true)
				arg_317_1.dialog_:SetActive(false)

				arg_317_1.fswtw_.percent = 0

				local var_320_10 = arg_317_1:GetWordFromCfg(417031076)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.fswt_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.fswt_)

				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_317_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_317_1.fswtw_:SetDirty()

				arg_317_1.typewritterCharCountI18N = 0

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_12 = 1.93333333333333

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.var_.oldValueTypewriter = arg_317_1.fswtw_.percent

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_13 = 15
			local var_320_14 = 1
			local var_320_15 = arg_317_1:GetWordFromCfg(417031076)
			local var_320_16 = arg_317_1:FormatText(var_320_15.content)
			local var_320_17, var_320_18 = arg_317_1:GetPercentByPara(var_320_16, 1)

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				local var_320_19 = var_320_13 <= 0 and var_320_14 or var_320_14 * ((var_320_18 - arg_317_1.typewritterCharCountI18N) / var_320_13)

				if var_320_19 > 0 and var_320_14 < var_320_19 then
					arg_317_1.talkMaxDuration = var_320_19

					if var_320_19 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_12
					end
				end
			end

			local var_320_20 = 1
			local var_320_21 = math.max(var_320_20, arg_317_1.talkMaxDuration)

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_21 then
				local var_320_22 = (arg_317_1.time_ - var_320_12) / var_320_21

				arg_317_1.fswtw_.percent = Mathf.Lerp(arg_317_1.var_.oldValueTypewriter, var_320_17, var_320_22)
				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.fswtw_:SetDirty()
			end

			if arg_317_1.time_ >= var_320_12 + var_320_21 and arg_317_1.time_ < var_320_12 + var_320_21 + arg_320_0 then
				arg_317_1.fswtw_.percent = var_320_17

				arg_317_1.fswtw_:SetDirty()
				arg_317_1:ShowNextGo(true)

				arg_317_1.typewritterCharCountI18N = var_320_18
			end

			local var_320_23 = 0

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_24 = 1.3

			if var_320_23 <= arg_317_1.time_ and arg_317_1.time_ < var_320_23 + var_320_24 then
				local var_320_25 = (arg_317_1.time_ - var_320_23) / var_320_24
				local var_320_26 = Color.New(0, 0, 0)

				var_320_26.a = Mathf.Lerp(0, 1, var_320_25)
				arg_317_1.mask_.color = var_320_26
			end

			if arg_317_1.time_ >= var_320_23 + var_320_24 and arg_317_1.time_ < var_320_23 + var_320_24 + arg_320_0 then
				local var_320_27 = Color.New(0, 0, 0)

				var_320_27.a = 1
				arg_317_1.mask_.color = var_320_27
			end

			local var_320_28 = 1.3

			if var_320_28 < arg_317_1.time_ and arg_317_1.time_ <= var_320_28 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_29 = 2

			if var_320_28 <= arg_317_1.time_ and arg_317_1.time_ < var_320_28 + var_320_29 then
				local var_320_30 = (arg_317_1.time_ - var_320_28) / var_320_29
				local var_320_31 = Color.New(0, 0, 0)

				var_320_31.a = Mathf.Lerp(1, 0, var_320_30)
				arg_317_1.mask_.color = var_320_31
			end

			if arg_317_1.time_ >= var_320_28 + var_320_29 and arg_317_1.time_ < var_320_28 + var_320_29 + arg_320_0 then
				local var_320_32 = Color.New(0, 0, 0)
				local var_320_33 = 0

				arg_317_1.mask_.enabled = false
				var_320_32.a = var_320_33
				arg_317_1.mask_.color = var_320_32
			end

			local var_320_34 = 1.3

			if var_320_34 < arg_317_1.time_ and arg_317_1.time_ <= var_320_34 + arg_320_0 then
				local var_320_35 = manager.ui.mainCamera.transform.localPosition
				local var_320_36 = Vector3.New(0, 0, 10) + Vector3.New(var_320_35.x, var_320_35.y, 0)
				local var_320_37 = arg_317_1.bgs_.STblack

				var_320_37.transform.localPosition = var_320_36
				var_320_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_38 = var_320_37:GetComponent("SpriteRenderer")

				if var_320_38 and var_320_38.sprite then
					local var_320_39 = (var_320_37.transform.localPosition - var_320_35).z
					local var_320_40 = manager.ui.mainCameraCom_
					local var_320_41 = 2 * var_320_39 * Mathf.Tan(var_320_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_320_42 = var_320_41 * var_320_40.aspect
					local var_320_43 = var_320_38.sprite.bounds.size.x
					local var_320_44 = var_320_38.sprite.bounds.size.y
					local var_320_45 = var_320_42 / var_320_43
					local var_320_46 = var_320_41 / var_320_44
					local var_320_47 = var_320_46 < var_320_45 and var_320_45 or var_320_46

					var_320_37.transform.localScale = Vector3.New(var_320_47, var_320_47, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "STblack" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_48 = 0.533333333333333
			local var_320_49 = 1

			if var_320_48 < arg_317_1.time_ and arg_317_1.time_ <= var_320_48 + arg_320_0 then
				local var_320_50 = "stop"
				local var_320_51 = "effect"

				arg_317_1:AudioAction(var_320_50, var_320_51, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_320_52 = 1.93333333333333
			local var_320_53 = 3.866
			local var_320_54 = manager.audio:GetVoiceLength("story_v_out_417031", "417031076", "") / 1000

			if var_320_54 > 0 and var_320_53 < var_320_54 and var_320_54 + var_320_52 > arg_317_1.duration_ then
				local var_320_55 = var_320_54

				arg_317_1.duration_ = var_320_54 + var_320_52
			end

			if var_320_52 < arg_317_1.time_ and arg_317_1.time_ <= var_320_52 + arg_320_0 then
				local var_320_56 = "play"
				local var_320_57 = "voice"

				arg_317_1:AudioAction(var_320_56, var_320_57, "story_v_out_417031", "417031076", "")
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play417031077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 417031077
		arg_321_1.duration_ = 3.9

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play417031078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.fswbg_:SetActive(true)
				arg_321_1.dialog_:SetActive(false)

				arg_321_1.fswtw_.percent = 0

				local var_324_1 = arg_321_1:GetWordFromCfg(417031077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.fswt_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.fswt_)

				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_321_1.fswtw_:SetDirty()

				arg_321_1.typewritterCharCountI18N = 0

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_3 = 0.566666666666667

			if var_324_3 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_4 = 14
			local var_324_5 = 0.933333333333333
			local var_324_6 = arg_321_1:GetWordFromCfg(417031077)
			local var_324_7 = arg_321_1:FormatText(var_324_6.content)
			local var_324_8, var_324_9 = arg_321_1:GetPercentByPara(var_324_7, 1)

			if var_324_3 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_10 = var_324_4 <= 0 and var_324_5 or var_324_5 * ((var_324_9 - arg_321_1.typewritterCharCountI18N) / var_324_4)

				if var_324_10 > 0 and var_324_5 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_3
					end
				end
			end

			local var_324_11 = 0.933333333333333
			local var_324_12 = math.max(var_324_11, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_12 then
				local var_324_13 = (arg_321_1.time_ - var_324_3) / var_324_12

				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_8, var_324_13)
				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_12 and arg_321_1.time_ < var_324_3 + var_324_12 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_8

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_9
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			local var_324_15 = 0.566666666666667

			if arg_321_1.time_ >= var_324_14 + var_324_15 and arg_321_1.time_ < var_324_14 + var_324_15 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_16 = 0.566666666666667
			local var_324_17 = 3.333
			local var_324_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031077", "") / 1000

			if var_324_18 > 0 and var_324_17 < var_324_18 and var_324_18 + var_324_16 > arg_321_1.duration_ then
				local var_324_19 = var_324_18

				arg_321_1.duration_ = var_324_18 + var_324_16
			end

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				local var_324_20 = "play"
				local var_324_21 = "voice"

				arg_321_1:AudioAction(var_324_20, var_324_21, "story_v_out_417031", "417031077", "")
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play417031078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417031078
		arg_325_1.duration_ = 3.1

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play417031079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.fswbg_:SetActive(true)
				arg_325_1.dialog_:SetActive(false)

				arg_325_1.fswtw_.percent = 0

				local var_328_1 = arg_325_1:GetWordFromCfg(417031078)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.fswt_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.fswt_)

				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_325_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_325_1.fswtw_:SetDirty()

				arg_325_1.typewritterCharCountI18N = 0

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_3 = 0.566666666666667

			if var_328_3 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_4 = 10
			local var_328_5 = 0.666666666666667
			local var_328_6 = arg_325_1:GetWordFromCfg(417031078)
			local var_328_7 = arg_325_1:FormatText(var_328_6.content)
			local var_328_8, var_328_9 = arg_325_1:GetPercentByPara(var_328_7, 1)

			if var_328_3 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_10 = var_328_4 <= 0 and var_328_5 or var_328_5 * ((var_328_9 - arg_325_1.typewritterCharCountI18N) / var_328_4)

				if var_328_10 > 0 and var_328_5 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_3 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_3
					end
				end
			end

			local var_328_11 = 0.666666666666667
			local var_328_12 = math.max(var_328_11, arg_325_1.talkMaxDuration)

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_12 then
				local var_328_13 = (arg_325_1.time_ - var_328_3) / var_328_12

				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_8, var_328_13)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= var_328_3 + var_328_12 and arg_325_1.time_ < var_328_3 + var_328_12 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_8

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_9
			end

			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_15 = 0.566666666666667

			if arg_325_1.time_ >= var_328_14 + var_328_15 and arg_325_1.time_ < var_328_14 + var_328_15 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_16 = 0.566666666666667
			local var_328_17 = 2.533
			local var_328_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031078", "") / 1000

			if var_328_18 > 0 and var_328_17 < var_328_18 and var_328_18 + var_328_16 > arg_325_1.duration_ then
				local var_328_19 = var_328_18

				arg_325_1.duration_ = var_328_18 + var_328_16
			end

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				local var_328_20 = "play"
				local var_328_21 = "voice"

				arg_325_1:AudioAction(var_328_20, var_328_21, "story_v_out_417031", "417031078", "")
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417031079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 417031079
		arg_329_1.duration_ = 7.07

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play417031080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.fswbg_:SetActive(true)
				arg_329_1.dialog_:SetActive(false)

				arg_329_1.fswtw_.percent = 0

				local var_332_1 = arg_329_1:GetWordFromCfg(417031079)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.fswt_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.fswt_)

				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_329_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_329_1.fswtw_:SetDirty()

				arg_329_1.typewritterCharCountI18N = 0

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_3 = 0.666666666666667

			if var_332_3 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.var_.oldValueTypewriter = arg_329_1.fswtw_.percent

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_4 = 36
			local var_332_5 = 2.4
			local var_332_6 = arg_329_1:GetWordFromCfg(417031079)
			local var_332_7 = arg_329_1:FormatText(var_332_6.content)
			local var_332_8, var_332_9 = arg_329_1:GetPercentByPara(var_332_7, 1)

			if var_332_3 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				local var_332_10 = var_332_4 <= 0 and var_332_5 or var_332_5 * ((var_332_9 - arg_329_1.typewritterCharCountI18N) / var_332_4)

				if var_332_10 > 0 and var_332_5 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_3 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_3
					end
				end
			end

			local var_332_11 = 2.4
			local var_332_12 = math.max(var_332_11, arg_329_1.talkMaxDuration)

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_12 then
				local var_332_13 = (arg_329_1.time_ - var_332_3) / var_332_12

				arg_329_1.fswtw_.percent = Mathf.Lerp(arg_329_1.var_.oldValueTypewriter, var_332_8, var_332_13)
				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_329_1.fswtw_:SetDirty()
			end

			if arg_329_1.time_ >= var_332_3 + var_332_12 and arg_329_1.time_ < var_332_3 + var_332_12 + arg_332_0 then
				arg_329_1.fswtw_.percent = var_332_8

				arg_329_1.fswtw_:SetDirty()
				arg_329_1:ShowNextGo(true)

				arg_329_1.typewritterCharCountI18N = var_332_9
			end

			local var_332_14 = 0

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_15 = 0.666666666666667

			if arg_329_1.time_ >= var_332_14 + var_332_15 and arg_329_1.time_ < var_332_14 + var_332_15 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_16 = 0.666666666666667
			local var_332_17 = 6.4
			local var_332_18 = manager.audio:GetVoiceLength("story_v_out_417031", "417031079", "") / 1000

			if var_332_18 > 0 and var_332_17 < var_332_18 and var_332_18 + var_332_16 > arg_329_1.duration_ then
				local var_332_19 = var_332_18

				arg_329_1.duration_ = var_332_18 + var_332_16
			end

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				local var_332_20 = "play"
				local var_332_21 = "voice"

				arg_329_1:AudioAction(var_332_20, var_332_21, "story_v_out_417031", "417031079", "")
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play417031080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 417031080
		arg_333_1.duration_ = 7.53

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play417031081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1034"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1034 == nil then
				arg_333_1.var_.actorSpriteComps1034 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1034 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 0.5, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps1034 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1034 = nil
			end

			local var_336_8 = 1.034

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.cswbg_:SetActive(false)
			end

			local var_336_9 = 1

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 then
				arg_333_1.fswbg_:SetActive(false)
				arg_333_1.dialog_:SetActive(false)
				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_333_1:ShowNextGo(false)
			end

			local var_336_10 = 1.034

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1.fswbg_:SetActive(false)
				arg_333_1.dialog_:SetActive(false)
				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_333_1:ShowNextGo(false)
			end

			local var_336_11 = 0

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_12 = 1

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_12 then
				local var_336_13 = (arg_333_1.time_ - var_336_11) / var_336_12
				local var_336_14 = Color.New(0, 0, 0)

				var_336_14.a = Mathf.Lerp(0, 1, var_336_13)
				arg_333_1.mask_.color = var_336_14
			end

			if arg_333_1.time_ >= var_336_11 + var_336_12 and arg_333_1.time_ < var_336_11 + var_336_12 + arg_336_0 then
				local var_336_15 = Color.New(0, 0, 0)

				var_336_15.a = 1
				arg_333_1.mask_.color = var_336_15
			end

			local var_336_16 = 1

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_17 = 2

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_17 then
				local var_336_18 = (arg_333_1.time_ - var_336_16) / var_336_17
				local var_336_19 = Color.New(0, 0, 0)

				var_336_19.a = Mathf.Lerp(1, 0, var_336_18)
				arg_333_1.mask_.color = var_336_19
			end

			if arg_333_1.time_ >= var_336_16 + var_336_17 and arg_333_1.time_ < var_336_16 + var_336_17 + arg_336_0 then
				local var_336_20 = Color.New(0, 0, 0)
				local var_336_21 = 0

				arg_333_1.mask_.enabled = false
				var_336_20.a = var_336_21
				arg_333_1.mask_.color = var_336_20
			end

			local var_336_22 = 1

			if var_336_22 < arg_333_1.time_ and arg_333_1.time_ <= var_336_22 + arg_336_0 then
				local var_336_23 = manager.ui.mainCamera.transform.localPosition
				local var_336_24 = Vector3.New(0, 0, 10) + Vector3.New(var_336_23.x, var_336_23.y, 0)
				local var_336_25 = arg_333_1.bgs_.ST04c

				var_336_25.transform.localPosition = var_336_24
				var_336_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_26 = var_336_25:GetComponent("SpriteRenderer")

				if var_336_26 and var_336_26.sprite then
					local var_336_27 = (var_336_25.transform.localPosition - var_336_23).z
					local var_336_28 = manager.ui.mainCameraCom_
					local var_336_29 = 2 * var_336_27 * Mathf.Tan(var_336_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_336_30 = var_336_29 * var_336_28.aspect
					local var_336_31 = var_336_26.sprite.bounds.size.x
					local var_336_32 = var_336_26.sprite.bounds.size.y
					local var_336_33 = var_336_30 / var_336_31
					local var_336_34 = var_336_29 / var_336_32
					local var_336_35 = var_336_34 < var_336_33 and var_336_33 or var_336_34

					var_336_25.transform.localScale = Vector3.New(var_336_35, var_336_35, 0)
				end

				for iter_336_4, iter_336_5 in pairs(arg_333_1.bgs_) do
					if iter_336_4 ~= "ST04c" then
						iter_336_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_36 = 1
			local var_336_37 = 1

			if var_336_36 < arg_333_1.time_ and arg_333_1.time_ <= var_336_36 + arg_336_0 then
				local var_336_38 = "play"
				local var_336_39 = "effect"

				arg_333_1:AudioAction(var_336_38, var_336_39, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_40 = 2.53333333333333
			local var_336_41 = 1.55

			if var_336_40 < arg_333_1.time_ and arg_333_1.time_ <= var_336_40 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_42 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_42:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_43 = arg_333_1:GetWordFromCfg(417031080)
				local var_336_44 = arg_333_1:FormatText(var_336_43.content)

				arg_333_1.text_.text = var_336_44

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_45 = 62
				local var_336_46 = utf8.len(var_336_44)
				local var_336_47 = var_336_45 <= 0 and var_336_41 or var_336_41 * (var_336_46 / var_336_45)

				if var_336_47 > 0 and var_336_41 < var_336_47 then
					arg_333_1.talkMaxDuration = var_336_47
					var_336_40 = var_336_40 + 0.3

					if var_336_47 + var_336_40 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_47 + var_336_40
					end
				end

				arg_333_1.text_.text = var_336_44
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_48 = var_336_40 + 0.3
			local var_336_49 = math.max(var_336_41, arg_333_1.talkMaxDuration)

			if var_336_48 <= arg_333_1.time_ and arg_333_1.time_ < var_336_48 + var_336_49 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_48) / var_336_49

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_48 + var_336_49 and arg_333_1.time_ < var_336_48 + var_336_49 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play417031081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 417031081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play417031082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.5
			local var_342_1 = 1

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				local var_342_2 = "play"
				local var_342_3 = "effect"

				arg_339_1:AudioAction(var_342_2, var_342_3, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_342_4 = 0
			local var_342_5 = 0.9

			if var_342_4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(417031081)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_8 = 36
				local var_342_9 = utf8.len(var_342_7)
				local var_342_10 = var_342_8 <= 0 and var_342_5 or var_342_5 * (var_342_9 / var_342_8)

				if var_342_10 > 0 and var_342_5 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_11 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_11 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_11

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_11 and arg_339_1.time_ < var_342_4 + var_342_11 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play417031082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 417031082
		arg_343_1.duration_ = 7.67

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play417031083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = "I05e"

			if arg_343_1.bgs_[var_346_0] == nil then
				local var_346_1 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_346_0)
				var_346_1.name = var_346_0
				var_346_1.transform.parent = arg_343_1.stage_.transform
				var_346_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_[var_346_0] = var_346_1
			end

			local var_346_2 = 1.33333333333333

			if var_346_2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				local var_346_3 = manager.ui.mainCamera.transform.localPosition
				local var_346_4 = Vector3.New(0, 0, 10) + Vector3.New(var_346_3.x, var_346_3.y, 0)
				local var_346_5 = arg_343_1.bgs_.I05e

				var_346_5.transform.localPosition = var_346_4
				var_346_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_6 = var_346_5:GetComponent("SpriteRenderer")

				if var_346_6 and var_346_6.sprite then
					local var_346_7 = (var_346_5.transform.localPosition - var_346_3).z
					local var_346_8 = manager.ui.mainCameraCom_
					local var_346_9 = 2 * var_346_7 * Mathf.Tan(var_346_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_346_10 = var_346_9 * var_346_8.aspect
					local var_346_11 = var_346_6.sprite.bounds.size.x
					local var_346_12 = var_346_6.sprite.bounds.size.y
					local var_346_13 = var_346_10 / var_346_11
					local var_346_14 = var_346_9 / var_346_12
					local var_346_15 = var_346_14 < var_346_13 and var_346_13 or var_346_14

					var_346_5.transform.localScale = Vector3.New(var_346_15, var_346_15, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "I05e" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			local var_346_17 = 0.3

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_18 = 0

			if var_346_18 < arg_343_1.time_ and arg_343_1.time_ <= var_346_18 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_19 = 1.33333333333333

			if var_346_18 <= arg_343_1.time_ and arg_343_1.time_ < var_346_18 + var_346_19 then
				local var_346_20 = (arg_343_1.time_ - var_346_18) / var_346_19
				local var_346_21 = Color.New(0, 0, 0)

				var_346_21.a = Mathf.Lerp(0, 1, var_346_20)
				arg_343_1.mask_.color = var_346_21
			end

			if arg_343_1.time_ >= var_346_18 + var_346_19 and arg_343_1.time_ < var_346_18 + var_346_19 + arg_346_0 then
				local var_346_22 = Color.New(0, 0, 0)

				var_346_22.a = 1
				arg_343_1.mask_.color = var_346_22
			end

			local var_346_23 = 1.33333333333333

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_24 = 2

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_24 then
				local var_346_25 = (arg_343_1.time_ - var_346_23) / var_346_24
				local var_346_26 = Color.New(0, 0, 0)

				var_346_26.a = Mathf.Lerp(1, 0, var_346_25)
				arg_343_1.mask_.color = var_346_26
			end

			if arg_343_1.time_ >= var_346_23 + var_346_24 and arg_343_1.time_ < var_346_23 + var_346_24 + arg_346_0 then
				local var_346_27 = Color.New(0, 0, 0)
				local var_346_28 = 0

				arg_343_1.mask_.enabled = false
				var_346_27.a = var_346_28
				arg_343_1.mask_.color = var_346_27
			end

			local var_346_29 = 0.533333333333333
			local var_346_30 = 0.2

			if var_346_29 < arg_343_1.time_ and arg_343_1.time_ <= var_346_29 + arg_346_0 then
				local var_346_31 = "play"
				local var_346_32 = "music"

				arg_343_1:AudioAction(var_346_31, var_346_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_346_33 = ""
				local var_346_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_346_34 ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_34 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_34

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_34
						arg_343_1.bgmTxt2_.text = var_346_34
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_35 = 2.67363524367102
			local var_346_36 = 1.075

			if var_346_35 < arg_343_1.time_ and arg_343_1.time_ <= var_346_35 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_37 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_37:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_343_1.dialogCg_.alpha = arg_348_0
				end))
				var_346_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_38 = arg_343_1:GetWordFromCfg(417031082)
				local var_346_39 = arg_343_1:FormatText(var_346_38.content)

				arg_343_1.text_.text = var_346_39

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_40 = 43
				local var_346_41 = utf8.len(var_346_39)
				local var_346_42 = var_346_40 <= 0 and var_346_36 or var_346_36 * (var_346_41 / var_346_40)

				if var_346_42 > 0 and var_346_36 < var_346_42 then
					arg_343_1.talkMaxDuration = var_346_42
					var_346_35 = var_346_35 + 0.3

					if var_346_42 + var_346_35 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_42 + var_346_35
					end
				end

				arg_343_1.text_.text = var_346_39
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_43 = var_346_35 + 0.3
			local var_346_44 = math.max(var_346_36, arg_343_1.talkMaxDuration)

			if var_346_43 <= arg_343_1.time_ and arg_343_1.time_ < var_346_43 + var_346_44 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_43) / var_346_44

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_43 + var_346_44 and arg_343_1.time_ < var_346_43 + var_346_44 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play417031083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417031083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417031084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 1.1

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(417031083)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 44
				local var_353_5 = utf8.len(var_353_3)
				local var_353_6 = var_353_4 <= 0 and var_353_1 or var_353_1 * (var_353_5 / var_353_4)

				if var_353_6 > 0 and var_353_1 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_7 and arg_350_1.time_ < var_353_0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417031084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417031084
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417031085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 1.675

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(417031084)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 67
				local var_357_5 = utf8.len(var_357_3)
				local var_357_6 = var_357_4 <= 0 and var_357_1 or var_357_1 * (var_357_5 / var_357_4)

				if var_357_6 > 0 and var_357_1 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_7 and arg_354_1.time_ < var_357_0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417031085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417031085
		arg_358_1.duration_ = 8

		local var_358_0 = {
			zh = 8,
			ja = 7.633
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417031086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = "ST17"

			if arg_358_1.bgs_[var_361_0] == nil then
				local var_361_1 = Object.Instantiate(arg_358_1.paintGo_)

				var_361_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_361_0)
				var_361_1.name = var_361_0
				var_361_1.transform.parent = arg_358_1.stage_.transform
				var_361_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.bgs_[var_361_0] = var_361_1
			end

			local var_361_2 = 1.4

			if var_361_2 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				local var_361_3 = manager.ui.mainCamera.transform.localPosition
				local var_361_4 = Vector3.New(0, 0, 10) + Vector3.New(var_361_3.x, var_361_3.y, 0)
				local var_361_5 = arg_358_1.bgs_.ST17

				var_361_5.transform.localPosition = var_361_4
				var_361_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_361_6 = var_361_5:GetComponent("SpriteRenderer")

				if var_361_6 and var_361_6.sprite then
					local var_361_7 = (var_361_5.transform.localPosition - var_361_3).z
					local var_361_8 = manager.ui.mainCameraCom_
					local var_361_9 = 2 * var_361_7 * Mathf.Tan(var_361_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_361_10 = var_361_9 * var_361_8.aspect
					local var_361_11 = var_361_6.sprite.bounds.size.x
					local var_361_12 = var_361_6.sprite.bounds.size.y
					local var_361_13 = var_361_10 / var_361_11
					local var_361_14 = var_361_9 / var_361_12
					local var_361_15 = var_361_14 < var_361_13 and var_361_13 or var_361_14

					var_361_5.transform.localScale = Vector3.New(var_361_15, var_361_15, 0)
				end

				for iter_361_0, iter_361_1 in pairs(arg_358_1.bgs_) do
					if iter_361_0 ~= "ST17" then
						iter_361_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_361_16 = 0

			if var_361_16 < arg_358_1.time_ and arg_358_1.time_ <= var_361_16 + arg_361_0 then
				arg_358_1.allBtn_.enabled = false
			end

			local var_361_17 = 0.3

			if arg_358_1.time_ >= var_361_16 + var_361_17 and arg_358_1.time_ < var_361_16 + var_361_17 + arg_361_0 then
				arg_358_1.allBtn_.enabled = true
			end

			local var_361_18 = 0

			if var_361_18 < arg_358_1.time_ and arg_358_1.time_ <= var_361_18 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_19 = 1.4

			if var_361_18 <= arg_358_1.time_ and arg_358_1.time_ < var_361_18 + var_361_19 then
				local var_361_20 = (arg_358_1.time_ - var_361_18) / var_361_19
				local var_361_21 = Color.New(0, 0, 0)

				var_361_21.a = Mathf.Lerp(0, 1, var_361_20)
				arg_358_1.mask_.color = var_361_21
			end

			if arg_358_1.time_ >= var_361_18 + var_361_19 and arg_358_1.time_ < var_361_18 + var_361_19 + arg_361_0 then
				local var_361_22 = Color.New(0, 0, 0)

				var_361_22.a = 1
				arg_358_1.mask_.color = var_361_22
			end

			local var_361_23 = 1.4

			if var_361_23 < arg_358_1.time_ and arg_358_1.time_ <= var_361_23 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_24 = 2

			if var_361_23 <= arg_358_1.time_ and arg_358_1.time_ < var_361_23 + var_361_24 then
				local var_361_25 = (arg_358_1.time_ - var_361_23) / var_361_24
				local var_361_26 = Color.New(0, 0, 0)

				var_361_26.a = Mathf.Lerp(1, 0, var_361_25)
				arg_358_1.mask_.color = var_361_26
			end

			if arg_358_1.time_ >= var_361_23 + var_361_24 and arg_358_1.time_ < var_361_23 + var_361_24 + arg_361_0 then
				local var_361_27 = Color.New(0, 0, 0)
				local var_361_28 = 0

				arg_358_1.mask_.enabled = false
				var_361_27.a = var_361_28
				arg_358_1.mask_.color = var_361_27
			end

			local var_361_29 = "1060"

			if arg_358_1.actors_[var_361_29] == nil then
				local var_361_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_361_30) then
					local var_361_31 = Object.Instantiate(var_361_30, arg_358_1.canvasGo_.transform)

					var_361_31.transform:SetSiblingIndex(1)

					var_361_31.name = var_361_29
					var_361_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_358_1.actors_[var_361_29] = var_361_31

					local var_361_32 = var_361_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_358_1.isInRecall_ then
						for iter_361_2, iter_361_3 in ipairs(var_361_32) do
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_361_33 = arg_358_1.actors_["1060"]
			local var_361_34 = 3

			if var_361_34 < arg_358_1.time_ and arg_358_1.time_ <= var_361_34 + arg_361_0 and not isNil(var_361_33) and arg_358_1.var_.actorSpriteComps1060 == nil then
				arg_358_1.var_.actorSpriteComps1060 = var_361_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_35 = 0.2

			if var_361_34 <= arg_358_1.time_ and arg_358_1.time_ < var_361_34 + var_361_35 and not isNil(var_361_33) then
				local var_361_36 = (arg_358_1.time_ - var_361_34) / var_361_35

				if arg_358_1.var_.actorSpriteComps1060 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								local var_361_37 = Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor1.r, var_361_36)
								local var_361_38 = Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor1.g, var_361_36)
								local var_361_39 = Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor1.b, var_361_36)

								iter_361_5.color = Color.New(var_361_37, var_361_38, var_361_39)
							else
								local var_361_40 = Mathf.Lerp(iter_361_5.color.r, 1, var_361_36)

								iter_361_5.color = Color.New(var_361_40, var_361_40, var_361_40)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_34 + var_361_35 and arg_358_1.time_ < var_361_34 + var_361_35 + arg_361_0 and not isNil(var_361_33) and arg_358_1.var_.actorSpriteComps1060 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_361_7 then
						if arg_358_1.isInRecall_ then
							iter_361_7.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1060 = nil
			end

			local var_361_41 = arg_358_1.actors_["1060"].transform
			local var_361_42 = 3

			if var_361_42 < arg_358_1.time_ and arg_358_1.time_ <= var_361_42 + arg_361_0 then
				arg_358_1.var_.moveOldPos1060 = var_361_41.localPosition
				var_361_41.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1060", 3)

				local var_361_43 = var_361_41.childCount

				for iter_361_8 = 0, var_361_43 - 1 do
					local var_361_44 = var_361_41:GetChild(iter_361_8)

					if var_361_44.name == "split_1" or not string.find(var_361_44.name, "split") then
						var_361_44.gameObject:SetActive(true)
					else
						var_361_44.gameObject:SetActive(false)
					end
				end
			end

			local var_361_45 = 0.001

			if var_361_42 <= arg_358_1.time_ and arg_358_1.time_ < var_361_42 + var_361_45 then
				local var_361_46 = (arg_358_1.time_ - var_361_42) / var_361_45
				local var_361_47 = Vector3.New(33.4, -430.8, 6.9)

				var_361_41.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1060, var_361_47, var_361_46)
			end

			if arg_358_1.time_ >= var_361_42 + var_361_45 and arg_358_1.time_ < var_361_42 + var_361_45 + arg_361_0 then
				var_361_41.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_361_48 = arg_358_1.actors_["1060"]
			local var_361_49 = 3

			if var_361_49 < arg_358_1.time_ and arg_358_1.time_ <= var_361_49 + arg_361_0 then
				local var_361_50 = var_361_48:GetComponentInChildren(typeof(CanvasGroup))

				if var_361_50 then
					arg_358_1.var_.alphaOldValue1060 = var_361_50.alpha
					arg_358_1.var_.characterEffect1060 = var_361_50
				end

				arg_358_1.var_.alphaOldValue1060 = 0
			end

			local var_361_51 = 0.4

			if var_361_49 <= arg_358_1.time_ and arg_358_1.time_ < var_361_49 + var_361_51 then
				local var_361_52 = (arg_358_1.time_ - var_361_49) / var_361_51
				local var_361_53 = Mathf.Lerp(arg_358_1.var_.alphaOldValue1060, 1, var_361_52)

				if arg_358_1.var_.characterEffect1060 then
					arg_358_1.var_.characterEffect1060.alpha = var_361_53
				end
			end

			if arg_358_1.time_ >= var_361_49 + var_361_51 and arg_358_1.time_ < var_361_49 + var_361_51 + arg_361_0 and arg_358_1.var_.characterEffect1060 then
				arg_358_1.var_.characterEffect1060.alpha = 1
			end

			local var_361_54 = 0
			local var_361_55 = 0.2

			if var_361_54 < arg_358_1.time_ and arg_358_1.time_ <= var_361_54 + arg_361_0 then
				local var_361_56 = "play"
				local var_361_57 = "music"

				arg_358_1:AudioAction(var_361_56, var_361_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_361_58 = ""
				local var_361_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_361_59 ~= "" then
					if arg_358_1.bgmTxt_.text ~= var_361_59 and arg_358_1.bgmTxt_.text ~= "" then
						if arg_358_1.bgmTxt2_.text ~= "" then
							arg_358_1.bgmTxt_.text = arg_358_1.bgmTxt2_.text
						end

						arg_358_1.bgmTxt2_.text = var_361_59

						arg_358_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_358_1.bgmTxt_.text = var_361_59
						arg_358_1.bgmTxt2_.text = var_361_59
					end

					if arg_358_1.bgmTimer then
						arg_358_1.bgmTimer:Stop()

						arg_358_1.bgmTimer = nil
					end

					if arg_358_1.settingData.show_music_name == 1 then
						arg_358_1.musicController:SetSelectedState("show")
						arg_358_1.musicAnimator_:Play("open", 0, 0)

						if arg_358_1.settingData.music_time ~= 0 then
							arg_358_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_358_1.settingData.music_time), function()
								if arg_358_1 == nil or isNil(arg_358_1.bgmTxt_) then
									return
								end

								arg_358_1.musicController:SetSelectedState("hide")
								arg_358_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_361_60 = 1.2
			local var_361_61 = 1

			if var_361_60 < arg_358_1.time_ and arg_358_1.time_ <= var_361_60 + arg_361_0 then
				local var_361_62 = "play"
				local var_361_63 = "music"

				arg_358_1:AudioAction(var_361_62, var_361_63, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_361_64 = ""
				local var_361_65 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_361_65 ~= "" then
					if arg_358_1.bgmTxt_.text ~= var_361_65 and arg_358_1.bgmTxt_.text ~= "" then
						if arg_358_1.bgmTxt2_.text ~= "" then
							arg_358_1.bgmTxt_.text = arg_358_1.bgmTxt2_.text
						end

						arg_358_1.bgmTxt2_.text = var_361_65

						arg_358_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_358_1.bgmTxt_.text = var_361_65
						arg_358_1.bgmTxt2_.text = var_361_65
					end

					if arg_358_1.bgmTimer then
						arg_358_1.bgmTimer:Stop()

						arg_358_1.bgmTimer = nil
					end

					if arg_358_1.settingData.show_music_name == 1 then
						arg_358_1.musicController:SetSelectedState("show")
						arg_358_1.musicAnimator_:Play("open", 0, 0)

						if arg_358_1.settingData.music_time ~= 0 then
							arg_358_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_358_1.settingData.music_time), function()
								if arg_358_1 == nil or isNil(arg_358_1.bgmTxt_) then
									return
								end

								arg_358_1.musicController:SetSelectedState("hide")
								arg_358_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_361_66 = 0.2
			local var_361_67 = 1

			if var_361_66 < arg_358_1.time_ and arg_358_1.time_ <= var_361_66 + arg_361_0 then
				local var_361_68 = "stop"
				local var_361_69 = "effect"

				arg_358_1:AudioAction(var_361_68, var_361_69, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_358_1.frameCnt_ <= 1 then
				arg_358_1.dialog_:SetActive(false)
			end

			local var_361_70 = 3.4
			local var_361_71 = 0.6

			if var_361_70 < arg_358_1.time_ and arg_358_1.time_ <= var_361_70 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0

				arg_358_1.dialog_:SetActive(true)

				arg_358_1.dialogCg_.alpha = 0

				local var_361_72 = LeanTween.value(arg_358_1.dialog_, 0, 1, 0.3)

				var_361_72:setOnUpdate(LuaHelper.FloatAction(function(arg_364_0)
					arg_358_1.dialogCg_.alpha = arg_364_0
				end))
				var_361_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_358_1.dialog_)
					var_361_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_358_1.duration_ = arg_358_1.duration_ + 0.3

				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_73 = arg_358_1:FormatText(StoryNameCfg[584].name)

				arg_358_1.leftNameTxt_.text = var_361_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_74 = arg_358_1:GetWordFromCfg(417031085)
				local var_361_75 = arg_358_1:FormatText(var_361_74.content)

				arg_358_1.text_.text = var_361_75

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_76 = 24
				local var_361_77 = utf8.len(var_361_75)
				local var_361_78 = var_361_76 <= 0 and var_361_71 or var_361_71 * (var_361_77 / var_361_76)

				if var_361_78 > 0 and var_361_71 < var_361_78 then
					arg_358_1.talkMaxDuration = var_361_78
					var_361_70 = var_361_70 + 0.3

					if var_361_78 + var_361_70 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_78 + var_361_70
					end
				end

				arg_358_1.text_.text = var_361_75
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031085", "story_v_out_417031.awb") ~= 0 then
					local var_361_79 = manager.audio:GetVoiceLength("story_v_out_417031", "417031085", "story_v_out_417031.awb") / 1000

					if var_361_79 + var_361_70 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_79 + var_361_70
					end

					if var_361_74.prefab_name ~= "" and arg_358_1.actors_[var_361_74.prefab_name] ~= nil then
						local var_361_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_74.prefab_name].transform, "story_v_out_417031", "417031085", "story_v_out_417031.awb")

						arg_358_1:RecordAudio("417031085", var_361_80)
						arg_358_1:RecordAudio("417031085", var_361_80)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417031", "417031085", "story_v_out_417031.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417031", "417031085", "story_v_out_417031.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_81 = var_361_70 + 0.3
			local var_361_82 = math.max(var_361_71, arg_358_1.talkMaxDuration)

			if var_361_81 <= arg_358_1.time_ and arg_358_1.time_ < var_361_81 + var_361_82 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_81) / var_361_82

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_81 + var_361_82 and arg_358_1.time_ < var_361_81 + var_361_82 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play417031086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417031086
		arg_366_1.duration_ = 8.1

		local var_366_0 = {
			zh = 2.966,
			ja = 8.1
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417031087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1034"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1034 == nil then
				arg_366_1.var_.actorSpriteComps1034 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.2

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps1034 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								local var_369_4 = Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor1.r, var_369_3)
								local var_369_5 = Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor1.g, var_369_3)
								local var_369_6 = Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor1.b, var_369_3)

								iter_369_1.color = Color.New(var_369_4, var_369_5, var_369_6)
							else
								local var_369_7 = Mathf.Lerp(iter_369_1.color.r, 1, var_369_3)

								iter_369_1.color = Color.New(var_369_7, var_369_7, var_369_7)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1034 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_369_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps1034 = nil
			end

			local var_369_8 = arg_366_1.actors_["1060"]
			local var_369_9 = 0

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps1060 == nil then
				arg_366_1.var_.actorSpriteComps1060 = var_369_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_10 = 0.2

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_10 and not isNil(var_369_8) then
				local var_369_11 = (arg_366_1.time_ - var_369_9) / var_369_10

				if arg_366_1.var_.actorSpriteComps1060 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								local var_369_12 = Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, var_369_11)
								local var_369_13 = Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, var_369_11)
								local var_369_14 = Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, var_369_11)

								iter_369_5.color = Color.New(var_369_12, var_369_13, var_369_14)
							else
								local var_369_15 = Mathf.Lerp(iter_369_5.color.r, 0.5, var_369_11)

								iter_369_5.color = Color.New(var_369_15, var_369_15, var_369_15)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_9 + var_369_10 and arg_366_1.time_ < var_369_9 + var_369_10 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps1060 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_369_7 then
						if arg_366_1.isInRecall_ then
							iter_369_7.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps1060 = nil
			end

			local var_369_16 = arg_366_1.actors_["1060"].transform
			local var_369_17 = 0

			if var_369_17 < arg_366_1.time_ and arg_366_1.time_ <= var_369_17 + arg_369_0 then
				arg_366_1.var_.moveOldPos1060 = var_369_16.localPosition
				var_369_16.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1060", 7)

				local var_369_18 = var_369_16.childCount

				for iter_369_8 = 0, var_369_18 - 1 do
					local var_369_19 = var_369_16:GetChild(iter_369_8)

					if var_369_19.name == "" or not string.find(var_369_19.name, "split") then
						var_369_19.gameObject:SetActive(true)
					else
						var_369_19.gameObject:SetActive(false)
					end
				end
			end

			local var_369_20 = 0.001

			if var_369_17 <= arg_366_1.time_ and arg_366_1.time_ < var_369_17 + var_369_20 then
				local var_369_21 = (arg_366_1.time_ - var_369_17) / var_369_20
				local var_369_22 = Vector3.New(0, -2000, -40)

				var_369_16.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1060, var_369_22, var_369_21)
			end

			if arg_366_1.time_ >= var_369_17 + var_369_20 and arg_366_1.time_ < var_369_17 + var_369_20 + arg_369_0 then
				var_369_16.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_369_23 = arg_366_1.actors_["1034"].transform
			local var_369_24 = 0

			if var_369_24 < arg_366_1.time_ and arg_366_1.time_ <= var_369_24 + arg_369_0 then
				arg_366_1.var_.moveOldPos1034 = var_369_23.localPosition
				var_369_23.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1034", 3)

				local var_369_25 = var_369_23.childCount

				for iter_369_9 = 0, var_369_25 - 1 do
					local var_369_26 = var_369_23:GetChild(iter_369_9)

					if var_369_26.name == "" or not string.find(var_369_26.name, "split") then
						var_369_26.gameObject:SetActive(true)
					else
						var_369_26.gameObject:SetActive(false)
					end
				end
			end

			local var_369_27 = 0.001

			if var_369_24 <= arg_366_1.time_ and arg_366_1.time_ < var_369_24 + var_369_27 then
				local var_369_28 = (arg_366_1.time_ - var_369_24) / var_369_27
				local var_369_29 = Vector3.New(0, -331.9, -324)

				var_369_23.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1034, var_369_29, var_369_28)
			end

			if arg_366_1.time_ >= var_369_24 + var_369_27 and arg_366_1.time_ < var_369_24 + var_369_27 + arg_369_0 then
				var_369_23.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_369_30 = 0
			local var_369_31 = 0.375

			if var_369_30 < arg_366_1.time_ and arg_366_1.time_ <= var_369_30 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_32 = arg_366_1:FormatText(StoryNameCfg[1109].name)

				arg_366_1.leftNameTxt_.text = var_369_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_33 = arg_366_1:GetWordFromCfg(417031086)
				local var_369_34 = arg_366_1:FormatText(var_369_33.content)

				arg_366_1.text_.text = var_369_34

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_35 = 15
				local var_369_36 = utf8.len(var_369_34)
				local var_369_37 = var_369_35 <= 0 and var_369_31 or var_369_31 * (var_369_36 / var_369_35)

				if var_369_37 > 0 and var_369_31 < var_369_37 then
					arg_366_1.talkMaxDuration = var_369_37

					if var_369_37 + var_369_30 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_37 + var_369_30
					end
				end

				arg_366_1.text_.text = var_369_34
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031086", "story_v_out_417031.awb") ~= 0 then
					local var_369_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031086", "story_v_out_417031.awb") / 1000

					if var_369_38 + var_369_30 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_38 + var_369_30
					end

					if var_369_33.prefab_name ~= "" and arg_366_1.actors_[var_369_33.prefab_name] ~= nil then
						local var_369_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_33.prefab_name].transform, "story_v_out_417031", "417031086", "story_v_out_417031.awb")

						arg_366_1:RecordAudio("417031086", var_369_39)
						arg_366_1:RecordAudio("417031086", var_369_39)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417031", "417031086", "story_v_out_417031.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417031", "417031086", "story_v_out_417031.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_40 = math.max(var_369_31, arg_366_1.talkMaxDuration)

			if var_369_30 <= arg_366_1.time_ and arg_366_1.time_ < var_369_30 + var_369_40 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_30) / var_369_40

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_30 + var_369_40 and arg_366_1.time_ < var_369_30 + var_369_40 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_366_1:InitPlayNodeList()
	end,
	Play417031087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417031087
		arg_370_1.duration_ = 2

		local var_370_0 = {
			zh = 1.1,
			ja = 2
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417031088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1060"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1060 == nil then
				arg_370_1.var_.actorSpriteComps1060 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps1060 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								local var_373_4 = Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, var_373_3)
								local var_373_5 = Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, var_373_3)
								local var_373_6 = Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, var_373_3)

								iter_373_1.color = Color.New(var_373_4, var_373_5, var_373_6)
							else
								local var_373_7 = Mathf.Lerp(iter_373_1.color.r, 1, var_373_3)

								iter_373_1.color = Color.New(var_373_7, var_373_7, var_373_7)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1060 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1060 = nil
			end

			local var_373_8 = arg_370_1.actors_["1034"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1034 == nil then
				arg_370_1.var_.actorSpriteComps1034 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps1034 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								local var_373_12 = Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, var_373_11)
								local var_373_13 = Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, var_373_11)
								local var_373_14 = Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, var_373_11)

								iter_373_5.color = Color.New(var_373_12, var_373_13, var_373_14)
							else
								local var_373_15 = Mathf.Lerp(iter_373_5.color.r, 0.5, var_373_11)

								iter_373_5.color = Color.New(var_373_15, var_373_15, var_373_15)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1034 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1034 = nil
			end

			local var_373_16 = arg_370_1.actors_["1034"].transform
			local var_373_17 = 0

			if var_373_17 < arg_370_1.time_ and arg_370_1.time_ <= var_373_17 + arg_373_0 then
				arg_370_1.var_.moveOldPos1034 = var_373_16.localPosition
				var_373_16.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1034", 4)

				local var_373_18 = var_373_16.childCount

				for iter_373_8 = 0, var_373_18 - 1 do
					local var_373_19 = var_373_16:GetChild(iter_373_8)

					if var_373_19.name == "" or not string.find(var_373_19.name, "split") then
						var_373_19.gameObject:SetActive(true)
					else
						var_373_19.gameObject:SetActive(false)
					end
				end
			end

			local var_373_20 = 0.001

			if var_373_17 <= arg_370_1.time_ and arg_370_1.time_ < var_373_17 + var_373_20 then
				local var_373_21 = (arg_370_1.time_ - var_373_17) / var_373_20
				local var_373_22 = Vector3.New(373.7, -331.9, -324)

				var_373_16.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1034, var_373_22, var_373_21)
			end

			if arg_370_1.time_ >= var_373_17 + var_373_20 and arg_370_1.time_ < var_373_17 + var_373_20 + arg_373_0 then
				var_373_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_373_23 = arg_370_1.actors_["1060"].transform
			local var_373_24 = 0

			if var_373_24 < arg_370_1.time_ and arg_370_1.time_ <= var_373_24 + arg_373_0 then
				arg_370_1.var_.moveOldPos1060 = var_373_23.localPosition
				var_373_23.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1060", 2)

				local var_373_25 = var_373_23.childCount

				for iter_373_9 = 0, var_373_25 - 1 do
					local var_373_26 = var_373_23:GetChild(iter_373_9)

					if var_373_26.name == "split_5" or not string.find(var_373_26.name, "split") then
						var_373_26.gameObject:SetActive(true)
					else
						var_373_26.gameObject:SetActive(false)
					end
				end
			end

			local var_373_27 = 0.001

			if var_373_24 <= arg_370_1.time_ and arg_370_1.time_ < var_373_24 + var_373_27 then
				local var_373_28 = (arg_370_1.time_ - var_373_24) / var_373_27
				local var_373_29 = Vector3.New(-440.94, -430.8, 6.9)

				var_373_23.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1060, var_373_29, var_373_28)
			end

			if arg_370_1.time_ >= var_373_24 + var_373_27 and arg_370_1.time_ < var_373_24 + var_373_27 + arg_373_0 then
				var_373_23.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_373_30 = 0
			local var_373_31 = 0.05

			if var_373_30 < arg_370_1.time_ and arg_370_1.time_ <= var_373_30 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_32 = arg_370_1:FormatText(StoryNameCfg[584].name)

				arg_370_1.leftNameTxt_.text = var_373_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_33 = arg_370_1:GetWordFromCfg(417031087)
				local var_373_34 = arg_370_1:FormatText(var_373_33.content)

				arg_370_1.text_.text = var_373_34

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_35 = 2
				local var_373_36 = utf8.len(var_373_34)
				local var_373_37 = var_373_35 <= 0 and var_373_31 or var_373_31 * (var_373_36 / var_373_35)

				if var_373_37 > 0 and var_373_31 < var_373_37 then
					arg_370_1.talkMaxDuration = var_373_37

					if var_373_37 + var_373_30 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_37 + var_373_30
					end
				end

				arg_370_1.text_.text = var_373_34
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031087", "story_v_out_417031.awb") ~= 0 then
					local var_373_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031087", "story_v_out_417031.awb") / 1000

					if var_373_38 + var_373_30 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_38 + var_373_30
					end

					if var_373_33.prefab_name ~= "" and arg_370_1.actors_[var_373_33.prefab_name] ~= nil then
						local var_373_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_33.prefab_name].transform, "story_v_out_417031", "417031087", "story_v_out_417031.awb")

						arg_370_1:RecordAudio("417031087", var_373_39)
						arg_370_1:RecordAudio("417031087", var_373_39)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417031", "417031087", "story_v_out_417031.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417031", "417031087", "story_v_out_417031.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_40 = math.max(var_373_31, arg_370_1.talkMaxDuration)

			if var_373_30 <= arg_370_1.time_ and arg_370_1.time_ < var_373_30 + var_373_40 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_30) / var_373_40

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_30 + var_373_40 and arg_370_1.time_ < var_373_30 + var_373_40 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play417031088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417031088
		arg_374_1.duration_ = 9.4

		local var_374_0 = {
			zh = 7.033,
			ja = 9.4
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417031089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1034"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps1034 == nil then
				arg_374_1.var_.actorSpriteComps1034 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps1034 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								local var_377_4 = Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor1.r, var_377_3)
								local var_377_5 = Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor1.g, var_377_3)
								local var_377_6 = Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor1.b, var_377_3)

								iter_377_1.color = Color.New(var_377_4, var_377_5, var_377_6)
							else
								local var_377_7 = Mathf.Lerp(iter_377_1.color.r, 1, var_377_3)

								iter_377_1.color = Color.New(var_377_7, var_377_7, var_377_7)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps1034 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_377_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps1034 = nil
			end

			local var_377_8 = arg_374_1.actors_["1060"]
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1060 == nil then
				arg_374_1.var_.actorSpriteComps1060 = var_377_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_10 = 0.2

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 and not isNil(var_377_8) then
				local var_377_11 = (arg_374_1.time_ - var_377_9) / var_377_10

				if arg_374_1.var_.actorSpriteComps1060 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								local var_377_12 = Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor2.r, var_377_11)
								local var_377_13 = Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor2.g, var_377_11)
								local var_377_14 = Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor2.b, var_377_11)

								iter_377_5.color = Color.New(var_377_12, var_377_13, var_377_14)
							else
								local var_377_15 = Mathf.Lerp(iter_377_5.color.r, 0.5, var_377_11)

								iter_377_5.color = Color.New(var_377_15, var_377_15, var_377_15)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1060 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_377_7 then
						if arg_374_1.isInRecall_ then
							iter_377_7.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps1060 = nil
			end

			local var_377_16 = arg_374_1.actors_["1034"].transform
			local var_377_17 = 0

			if var_377_17 < arg_374_1.time_ and arg_374_1.time_ <= var_377_17 + arg_377_0 then
				arg_374_1.var_.moveOldPos1034 = var_377_16.localPosition
				var_377_16.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1034", 4)

				local var_377_18 = var_377_16.childCount

				for iter_377_8 = 0, var_377_18 - 1 do
					local var_377_19 = var_377_16:GetChild(iter_377_8)

					if var_377_19.name == "" or not string.find(var_377_19.name, "split") then
						var_377_19.gameObject:SetActive(true)
					else
						var_377_19.gameObject:SetActive(false)
					end
				end
			end

			local var_377_20 = 0.001

			if var_377_17 <= arg_374_1.time_ and arg_374_1.time_ < var_377_17 + var_377_20 then
				local var_377_21 = (arg_374_1.time_ - var_377_17) / var_377_20
				local var_377_22 = Vector3.New(373.7, -331.9, -324)

				var_377_16.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1034, var_377_22, var_377_21)
			end

			if arg_374_1.time_ >= var_377_17 + var_377_20 and arg_374_1.time_ < var_377_17 + var_377_20 + arg_377_0 then
				var_377_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_377_23 = 0
			local var_377_24 = 0.725

			if var_377_23 < arg_374_1.time_ and arg_374_1.time_ <= var_377_23 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_25 = arg_374_1:FormatText(StoryNameCfg[1109].name)

				arg_374_1.leftNameTxt_.text = var_377_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_26 = arg_374_1:GetWordFromCfg(417031088)
				local var_377_27 = arg_374_1:FormatText(var_377_26.content)

				arg_374_1.text_.text = var_377_27

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_28 = 29
				local var_377_29 = utf8.len(var_377_27)
				local var_377_30 = var_377_28 <= 0 and var_377_24 or var_377_24 * (var_377_29 / var_377_28)

				if var_377_30 > 0 and var_377_24 < var_377_30 then
					arg_374_1.talkMaxDuration = var_377_30

					if var_377_30 + var_377_23 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_30 + var_377_23
					end
				end

				arg_374_1.text_.text = var_377_27
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031088", "story_v_out_417031.awb") ~= 0 then
					local var_377_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031088", "story_v_out_417031.awb") / 1000

					if var_377_31 + var_377_23 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_31 + var_377_23
					end

					if var_377_26.prefab_name ~= "" and arg_374_1.actors_[var_377_26.prefab_name] ~= nil then
						local var_377_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_26.prefab_name].transform, "story_v_out_417031", "417031088", "story_v_out_417031.awb")

						arg_374_1:RecordAudio("417031088", var_377_32)
						arg_374_1:RecordAudio("417031088", var_377_32)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417031", "417031088", "story_v_out_417031.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417031", "417031088", "story_v_out_417031.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_33 = math.max(var_377_24, arg_374_1.talkMaxDuration)

			if var_377_23 <= arg_374_1.time_ and arg_374_1.time_ < var_377_23 + var_377_33 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_23) / var_377_33

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_23 + var_377_33 and arg_374_1.time_ < var_377_23 + var_377_33 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play417031089 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417031089
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play417031090(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1034"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps1034 == nil then
				arg_378_1.var_.actorSpriteComps1034 = var_381_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_2 = 0.2

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.actorSpriteComps1034 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								local var_381_4 = Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor2.r, var_381_3)
								local var_381_5 = Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor2.g, var_381_3)
								local var_381_6 = Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor2.b, var_381_3)

								iter_381_1.color = Color.New(var_381_4, var_381_5, var_381_6)
							else
								local var_381_7 = Mathf.Lerp(iter_381_1.color.r, 0.5, var_381_3)

								iter_381_1.color = Color.New(var_381_7, var_381_7, var_381_7)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps1034 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_381_3 then
						if arg_378_1.isInRecall_ then
							iter_381_3.color = arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_381_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps1034 = nil
			end

			local var_381_8 = arg_378_1.actors_["1060"].transform
			local var_381_9 = 0

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1.var_.moveOldPos1060 = var_381_8.localPosition
				var_381_8.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1060", 7)

				local var_381_10 = var_381_8.childCount

				for iter_381_4 = 0, var_381_10 - 1 do
					local var_381_11 = var_381_8:GetChild(iter_381_4)

					if var_381_11.name == "split_1" or not string.find(var_381_11.name, "split") then
						var_381_11.gameObject:SetActive(true)
					else
						var_381_11.gameObject:SetActive(false)
					end
				end
			end

			local var_381_12 = 0.001

			if var_381_9 <= arg_378_1.time_ and arg_378_1.time_ < var_381_9 + var_381_12 then
				local var_381_13 = (arg_378_1.time_ - var_381_9) / var_381_12
				local var_381_14 = Vector3.New(0, -2000, -40)

				var_381_8.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1060, var_381_14, var_381_13)
			end

			if arg_378_1.time_ >= var_381_9 + var_381_12 and arg_378_1.time_ < var_381_9 + var_381_12 + arg_381_0 then
				var_381_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_381_15 = arg_378_1.actors_["1034"].transform
			local var_381_16 = 0

			if var_381_16 < arg_378_1.time_ and arg_378_1.time_ <= var_381_16 + arg_381_0 then
				arg_378_1.var_.moveOldPos1034 = var_381_15.localPosition
				var_381_15.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1034", 7)

				local var_381_17 = var_381_15.childCount

				for iter_381_5 = 0, var_381_17 - 1 do
					local var_381_18 = var_381_15:GetChild(iter_381_5)

					if var_381_18.name == "" or not string.find(var_381_18.name, "split") then
						var_381_18.gameObject:SetActive(true)
					else
						var_381_18.gameObject:SetActive(false)
					end
				end
			end

			local var_381_19 = 0.001

			if var_381_16 <= arg_378_1.time_ and arg_378_1.time_ < var_381_16 + var_381_19 then
				local var_381_20 = (arg_378_1.time_ - var_381_16) / var_381_19
				local var_381_21 = Vector3.New(0, -2000, 0)

				var_381_15.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1034, var_381_21, var_381_20)
			end

			if arg_378_1.time_ >= var_381_16 + var_381_19 and arg_378_1.time_ < var_381_16 + var_381_19 + arg_381_0 then
				var_381_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_381_22 = 0.05
			local var_381_23 = 1

			if var_381_22 < arg_378_1.time_ and arg_378_1.time_ <= var_381_22 + arg_381_0 then
				local var_381_24 = "play"
				local var_381_25 = "effect"

				arg_378_1:AudioAction(var_381_24, var_381_25, "se_story_1310", "se_story_1310_coffeecup", "")
			end

			local var_381_26 = 0
			local var_381_27 = 1.55

			if var_381_26 < arg_378_1.time_ and arg_378_1.time_ <= var_381_26 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_28 = arg_378_1:GetWordFromCfg(417031089)
				local var_381_29 = arg_378_1:FormatText(var_381_28.content)

				arg_378_1.text_.text = var_381_29

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_30 = 62
				local var_381_31 = utf8.len(var_381_29)
				local var_381_32 = var_381_30 <= 0 and var_381_27 or var_381_27 * (var_381_31 / var_381_30)

				if var_381_32 > 0 and var_381_27 < var_381_32 then
					arg_378_1.talkMaxDuration = var_381_32

					if var_381_32 + var_381_26 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_32 + var_381_26
					end
				end

				arg_378_1.text_.text = var_381_29
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_33 = math.max(var_381_27, arg_378_1.talkMaxDuration)

			if var_381_26 <= arg_378_1.time_ and arg_378_1.time_ < var_381_26 + var_381_33 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_26) / var_381_33

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_26 + var_381_33 and arg_378_1.time_ < var_381_26 + var_381_33 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_378_1:InitPlayNodeList()
	end,
	Play417031090 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417031090
		arg_382_1.duration_ = 13.33

		local var_382_0 = {
			zh = 10.933,
			ja = 13.333
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play417031091(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1034"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps1034 == nil then
				arg_382_1.var_.actorSpriteComps1034 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps1034 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 1, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps1034 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps1034 = nil
			end

			local var_385_8 = arg_382_1.actors_["1034"].transform
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 then
				arg_382_1.var_.moveOldPos1034 = var_385_8.localPosition
				var_385_8.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1034", 3)

				local var_385_10 = var_385_8.childCount

				for iter_385_4 = 0, var_385_10 - 1 do
					local var_385_11 = var_385_8:GetChild(iter_385_4)

					if var_385_11.name == "" or not string.find(var_385_11.name, "split") then
						var_385_11.gameObject:SetActive(true)
					else
						var_385_11.gameObject:SetActive(false)
					end
				end
			end

			local var_385_12 = 0.001

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_12 then
				local var_385_13 = (arg_382_1.time_ - var_385_9) / var_385_12
				local var_385_14 = Vector3.New(0, -331.9, -324)

				var_385_8.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1034, var_385_14, var_385_13)
			end

			if arg_382_1.time_ >= var_385_9 + var_385_12 and arg_382_1.time_ < var_385_9 + var_385_12 + arg_385_0 then
				var_385_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_385_15 = 0
			local var_385_16 = 1.125

			if var_385_15 < arg_382_1.time_ and arg_382_1.time_ <= var_385_15 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_17 = arg_382_1:FormatText(StoryNameCfg[1109].name)

				arg_382_1.leftNameTxt_.text = var_385_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_18 = arg_382_1:GetWordFromCfg(417031090)
				local var_385_19 = arg_382_1:FormatText(var_385_18.content)

				arg_382_1.text_.text = var_385_19

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_20 = 45
				local var_385_21 = utf8.len(var_385_19)
				local var_385_22 = var_385_20 <= 0 and var_385_16 or var_385_16 * (var_385_21 / var_385_20)

				if var_385_22 > 0 and var_385_16 < var_385_22 then
					arg_382_1.talkMaxDuration = var_385_22

					if var_385_22 + var_385_15 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_22 + var_385_15
					end
				end

				arg_382_1.text_.text = var_385_19
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031090", "story_v_out_417031.awb") ~= 0 then
					local var_385_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031090", "story_v_out_417031.awb") / 1000

					if var_385_23 + var_385_15 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_23 + var_385_15
					end

					if var_385_18.prefab_name ~= "" and arg_382_1.actors_[var_385_18.prefab_name] ~= nil then
						local var_385_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_18.prefab_name].transform, "story_v_out_417031", "417031090", "story_v_out_417031.awb")

						arg_382_1:RecordAudio("417031090", var_385_24)
						arg_382_1:RecordAudio("417031090", var_385_24)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_417031", "417031090", "story_v_out_417031.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_417031", "417031090", "story_v_out_417031.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_25 = math.max(var_385_16, arg_382_1.talkMaxDuration)

			if var_385_15 <= arg_382_1.time_ and arg_382_1.time_ < var_385_15 + var_385_25 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_15) / var_385_25

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_15 + var_385_25 and arg_382_1.time_ < var_385_15 + var_385_25 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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

		arg_382_1:InitPlayNodeList()
	end,
	Play417031091 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 417031091
		arg_386_1.duration_ = 11.3

		local var_386_0 = {
			zh = 8.066,
			ja = 11.3
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play417031092(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.975

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[1109].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:GetWordFromCfg(417031091)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 39
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031091", "story_v_out_417031.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031091", "story_v_out_417031.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_out_417031", "417031091", "story_v_out_417031.awb")

						arg_386_1:RecordAudio("417031091", var_389_9)
						arg_386_1:RecordAudio("417031091", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_417031", "417031091", "story_v_out_417031.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_417031", "417031091", "story_v_out_417031.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_10 and arg_386_1.time_ < var_389_0 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play417031092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417031092
		arg_390_1.duration_ = 13

		local var_390_0 = {
			zh = 4.866,
			ja = 13
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play417031093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.55

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[1109].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(417031092)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 22
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031092", "story_v_out_417031.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031092", "story_v_out_417031.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_417031", "417031092", "story_v_out_417031.awb")

						arg_390_1:RecordAudio("417031092", var_393_9)
						arg_390_1:RecordAudio("417031092", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_417031", "417031092", "story_v_out_417031.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_417031", "417031092", "story_v_out_417031.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_10 and arg_390_1.time_ < var_393_0 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play417031093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 417031093
		arg_394_1.duration_ = 7.8

		local var_394_0 = {
			zh = 2.8,
			ja = 7.8
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play417031094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1060"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1060 == nil then
				arg_394_1.var_.actorSpriteComps1060 = var_397_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_2 = 0.2

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.actorSpriteComps1060 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								local var_397_4 = Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, var_397_3)
								local var_397_5 = Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, var_397_3)
								local var_397_6 = Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, var_397_3)

								iter_397_1.color = Color.New(var_397_4, var_397_5, var_397_6)
							else
								local var_397_7 = Mathf.Lerp(iter_397_1.color.r, 1, var_397_3)

								iter_397_1.color = Color.New(var_397_7, var_397_7, var_397_7)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.actorSpriteComps1060 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_397_3 then
						if arg_394_1.isInRecall_ then
							iter_397_3.color = arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_397_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps1060 = nil
			end

			local var_397_8 = arg_394_1.actors_["1034"]
			local var_397_9 = 0

			if var_397_9 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps1034 == nil then
				arg_394_1.var_.actorSpriteComps1034 = var_397_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_10 = 0.2

			if var_397_9 <= arg_394_1.time_ and arg_394_1.time_ < var_397_9 + var_397_10 and not isNil(var_397_8) then
				local var_397_11 = (arg_394_1.time_ - var_397_9) / var_397_10

				if arg_394_1.var_.actorSpriteComps1034 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								local var_397_12 = Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, var_397_11)
								local var_397_13 = Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, var_397_11)
								local var_397_14 = Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, var_397_11)

								iter_397_5.color = Color.New(var_397_12, var_397_13, var_397_14)
							else
								local var_397_15 = Mathf.Lerp(iter_397_5.color.r, 0.5, var_397_11)

								iter_397_5.color = Color.New(var_397_15, var_397_15, var_397_15)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_9 + var_397_10 and arg_394_1.time_ < var_397_9 + var_397_10 + arg_397_0 and not isNil(var_397_8) and arg_394_1.var_.actorSpriteComps1034 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_397_7 then
						if arg_394_1.isInRecall_ then
							iter_397_7.color = arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_397_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps1034 = nil
			end

			local var_397_16 = arg_394_1.actors_["1060"].transform
			local var_397_17 = 0

			if var_397_17 < arg_394_1.time_ and arg_394_1.time_ <= var_397_17 + arg_397_0 then
				arg_394_1.var_.moveOldPos1060 = var_397_16.localPosition
				var_397_16.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1060", 2)

				local var_397_18 = var_397_16.childCount

				for iter_397_8 = 0, var_397_18 - 1 do
					local var_397_19 = var_397_16:GetChild(iter_397_8)

					if var_397_19.name == "" or not string.find(var_397_19.name, "split") then
						var_397_19.gameObject:SetActive(true)
					else
						var_397_19.gameObject:SetActive(false)
					end
				end
			end

			local var_397_20 = 0.001

			if var_397_17 <= arg_394_1.time_ and arg_394_1.time_ < var_397_17 + var_397_20 then
				local var_397_21 = (arg_394_1.time_ - var_397_17) / var_397_20
				local var_397_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_397_16.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1060, var_397_22, var_397_21)
			end

			if arg_394_1.time_ >= var_397_17 + var_397_20 and arg_394_1.time_ < var_397_17 + var_397_20 + arg_397_0 then
				var_397_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_397_23 = arg_394_1.actors_["1034"].transform
			local var_397_24 = 0

			if var_397_24 < arg_394_1.time_ and arg_394_1.time_ <= var_397_24 + arg_397_0 then
				arg_394_1.var_.moveOldPos1034 = var_397_23.localPosition
				var_397_23.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1034", 4)

				local var_397_25 = var_397_23.childCount

				for iter_397_9 = 0, var_397_25 - 1 do
					local var_397_26 = var_397_23:GetChild(iter_397_9)

					if var_397_26.name == "" or not string.find(var_397_26.name, "split") then
						var_397_26.gameObject:SetActive(true)
					else
						var_397_26.gameObject:SetActive(false)
					end
				end
			end

			local var_397_27 = 0.001

			if var_397_24 <= arg_394_1.time_ and arg_394_1.time_ < var_397_24 + var_397_27 then
				local var_397_28 = (arg_394_1.time_ - var_397_24) / var_397_27
				local var_397_29 = Vector3.New(373.7, -331.9, -324)

				var_397_23.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1034, var_397_29, var_397_28)
			end

			if arg_394_1.time_ >= var_397_24 + var_397_27 and arg_394_1.time_ < var_397_24 + var_397_27 + arg_397_0 then
				var_397_23.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_397_30 = 0
			local var_397_31 = 0.3

			if var_397_30 < arg_394_1.time_ and arg_394_1.time_ <= var_397_30 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_32 = arg_394_1:FormatText(StoryNameCfg[584].name)

				arg_394_1.leftNameTxt_.text = var_397_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_33 = arg_394_1:GetWordFromCfg(417031093)
				local var_397_34 = arg_394_1:FormatText(var_397_33.content)

				arg_394_1.text_.text = var_397_34

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_35 = 12
				local var_397_36 = utf8.len(var_397_34)
				local var_397_37 = var_397_35 <= 0 and var_397_31 or var_397_31 * (var_397_36 / var_397_35)

				if var_397_37 > 0 and var_397_31 < var_397_37 then
					arg_394_1.talkMaxDuration = var_397_37

					if var_397_37 + var_397_30 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_37 + var_397_30
					end
				end

				arg_394_1.text_.text = var_397_34
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031093", "story_v_out_417031.awb") ~= 0 then
					local var_397_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031093", "story_v_out_417031.awb") / 1000

					if var_397_38 + var_397_30 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_38 + var_397_30
					end

					if var_397_33.prefab_name ~= "" and arg_394_1.actors_[var_397_33.prefab_name] ~= nil then
						local var_397_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_33.prefab_name].transform, "story_v_out_417031", "417031093", "story_v_out_417031.awb")

						arg_394_1:RecordAudio("417031093", var_397_39)
						arg_394_1:RecordAudio("417031093", var_397_39)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_417031", "417031093", "story_v_out_417031.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_417031", "417031093", "story_v_out_417031.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_40 = math.max(var_397_31, arg_394_1.talkMaxDuration)

			if var_397_30 <= arg_394_1.time_ and arg_394_1.time_ < var_397_30 + var_397_40 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_30) / var_397_40

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_30 + var_397_40 and arg_394_1.time_ < var_397_30 + var_397_40 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_394_1:InitPlayNodeList()
	end,
	Play417031094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 417031094
		arg_398_1.duration_ = 4.3

		local var_398_0 = {
			zh = 3.733,
			ja = 4.3
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play417031095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1034"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1034 == nil then
				arg_398_1.var_.actorSpriteComps1034 = var_401_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_2 = 0.2

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.actorSpriteComps1034 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								local var_401_4 = Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor1.r, var_401_3)
								local var_401_5 = Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor1.g, var_401_3)
								local var_401_6 = Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor1.b, var_401_3)

								iter_401_1.color = Color.New(var_401_4, var_401_5, var_401_6)
							else
								local var_401_7 = Mathf.Lerp(iter_401_1.color.r, 1, var_401_3)

								iter_401_1.color = Color.New(var_401_7, var_401_7, var_401_7)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1034 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_401_3 then
						if arg_398_1.isInRecall_ then
							iter_401_3.color = arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_401_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_398_1.var_.actorSpriteComps1034 = nil
			end

			local var_401_8 = arg_398_1.actors_["1060"]
			local var_401_9 = 0

			if var_401_9 < arg_398_1.time_ and arg_398_1.time_ <= var_401_9 + arg_401_0 and not isNil(var_401_8) and arg_398_1.var_.actorSpriteComps1060 == nil then
				arg_398_1.var_.actorSpriteComps1060 = var_401_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_10 = 0.2

			if var_401_9 <= arg_398_1.time_ and arg_398_1.time_ < var_401_9 + var_401_10 and not isNil(var_401_8) then
				local var_401_11 = (arg_398_1.time_ - var_401_9) / var_401_10

				if arg_398_1.var_.actorSpriteComps1060 then
					for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_401_5 then
							if arg_398_1.isInRecall_ then
								local var_401_12 = Mathf.Lerp(iter_401_5.color.r, arg_398_1.hightColor2.r, var_401_11)
								local var_401_13 = Mathf.Lerp(iter_401_5.color.g, arg_398_1.hightColor2.g, var_401_11)
								local var_401_14 = Mathf.Lerp(iter_401_5.color.b, arg_398_1.hightColor2.b, var_401_11)

								iter_401_5.color = Color.New(var_401_12, var_401_13, var_401_14)
							else
								local var_401_15 = Mathf.Lerp(iter_401_5.color.r, 0.5, var_401_11)

								iter_401_5.color = Color.New(var_401_15, var_401_15, var_401_15)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= var_401_9 + var_401_10 and arg_398_1.time_ < var_401_9 + var_401_10 + arg_401_0 and not isNil(var_401_8) and arg_398_1.var_.actorSpriteComps1060 then
				for iter_401_6, iter_401_7 in pairs(arg_398_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_401_7 then
						if arg_398_1.isInRecall_ then
							iter_401_7.color = arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_401_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_398_1.var_.actorSpriteComps1060 = nil
			end

			local var_401_16 = arg_398_1.actors_["1034"].transform
			local var_401_17 = 0

			if var_401_17 < arg_398_1.time_ and arg_398_1.time_ <= var_401_17 + arg_401_0 then
				arg_398_1.var_.moveOldPos1034 = var_401_16.localPosition
				var_401_16.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("1034", 4)

				local var_401_18 = var_401_16.childCount

				for iter_401_8 = 0, var_401_18 - 1 do
					local var_401_19 = var_401_16:GetChild(iter_401_8)

					if var_401_19.name == "split_4" or not string.find(var_401_19.name, "split") then
						var_401_19.gameObject:SetActive(true)
					else
						var_401_19.gameObject:SetActive(false)
					end
				end
			end

			local var_401_20 = 0.001

			if var_401_17 <= arg_398_1.time_ and arg_398_1.time_ < var_401_17 + var_401_20 then
				local var_401_21 = (arg_398_1.time_ - var_401_17) / var_401_20
				local var_401_22 = Vector3.New(373.7, -331.9, -324)

				var_401_16.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1034, var_401_22, var_401_21)
			end

			if arg_398_1.time_ >= var_401_17 + var_401_20 and arg_398_1.time_ < var_401_17 + var_401_20 + arg_401_0 then
				var_401_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_401_23 = 0
			local var_401_24 = 0.575

			if var_401_23 < arg_398_1.time_ and arg_398_1.time_ <= var_401_23 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_25 = arg_398_1:FormatText(StoryNameCfg[1109].name)

				arg_398_1.leftNameTxt_.text = var_401_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_26 = arg_398_1:GetWordFromCfg(417031094)
				local var_401_27 = arg_398_1:FormatText(var_401_26.content)

				arg_398_1.text_.text = var_401_27

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_28 = 23
				local var_401_29 = utf8.len(var_401_27)
				local var_401_30 = var_401_28 <= 0 and var_401_24 or var_401_24 * (var_401_29 / var_401_28)

				if var_401_30 > 0 and var_401_24 < var_401_30 then
					arg_398_1.talkMaxDuration = var_401_30

					if var_401_30 + var_401_23 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_30 + var_401_23
					end
				end

				arg_398_1.text_.text = var_401_27
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031094", "story_v_out_417031.awb") ~= 0 then
					local var_401_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031094", "story_v_out_417031.awb") / 1000

					if var_401_31 + var_401_23 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_31 + var_401_23
					end

					if var_401_26.prefab_name ~= "" and arg_398_1.actors_[var_401_26.prefab_name] ~= nil then
						local var_401_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_26.prefab_name].transform, "story_v_out_417031", "417031094", "story_v_out_417031.awb")

						arg_398_1:RecordAudio("417031094", var_401_32)
						arg_398_1:RecordAudio("417031094", var_401_32)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_417031", "417031094", "story_v_out_417031.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_417031", "417031094", "story_v_out_417031.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_33 = math.max(var_401_24, arg_398_1.talkMaxDuration)

			if var_401_23 <= arg_398_1.time_ and arg_398_1.time_ < var_401_23 + var_401_33 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_23) / var_401_33

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_23 + var_401_33 and arg_398_1.time_ < var_401_23 + var_401_33 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
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

		arg_398_1:InitPlayNodeList()
	end,
	Play417031095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 417031095
		arg_402_1.duration_ = 12.97

		local var_402_0 = {
			zh = 11,
			ja = 12.966
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play417031096(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1060"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1060 == nil then
				arg_402_1.var_.actorSpriteComps1060 = var_405_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_2 = 0.2

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.actorSpriteComps1060 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								local var_405_4 = Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor1.r, var_405_3)
								local var_405_5 = Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor1.g, var_405_3)
								local var_405_6 = Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor1.b, var_405_3)

								iter_405_1.color = Color.New(var_405_4, var_405_5, var_405_6)
							else
								local var_405_7 = Mathf.Lerp(iter_405_1.color.r, 1, var_405_3)

								iter_405_1.color = Color.New(var_405_7, var_405_7, var_405_7)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1060 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_405_3 then
						if arg_402_1.isInRecall_ then
							iter_405_3.color = arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_405_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps1060 = nil
			end

			local var_405_8 = arg_402_1.actors_["1034"]
			local var_405_9 = 0

			if var_405_9 < arg_402_1.time_ and arg_402_1.time_ <= var_405_9 + arg_405_0 and not isNil(var_405_8) and arg_402_1.var_.actorSpriteComps1034 == nil then
				arg_402_1.var_.actorSpriteComps1034 = var_405_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_10 = 0.2

			if var_405_9 <= arg_402_1.time_ and arg_402_1.time_ < var_405_9 + var_405_10 and not isNil(var_405_8) then
				local var_405_11 = (arg_402_1.time_ - var_405_9) / var_405_10

				if arg_402_1.var_.actorSpriteComps1034 then
					for iter_405_4, iter_405_5 in pairs(arg_402_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_405_5 then
							if arg_402_1.isInRecall_ then
								local var_405_12 = Mathf.Lerp(iter_405_5.color.r, arg_402_1.hightColor2.r, var_405_11)
								local var_405_13 = Mathf.Lerp(iter_405_5.color.g, arg_402_1.hightColor2.g, var_405_11)
								local var_405_14 = Mathf.Lerp(iter_405_5.color.b, arg_402_1.hightColor2.b, var_405_11)

								iter_405_5.color = Color.New(var_405_12, var_405_13, var_405_14)
							else
								local var_405_15 = Mathf.Lerp(iter_405_5.color.r, 0.5, var_405_11)

								iter_405_5.color = Color.New(var_405_15, var_405_15, var_405_15)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_9 + var_405_10 and arg_402_1.time_ < var_405_9 + var_405_10 + arg_405_0 and not isNil(var_405_8) and arg_402_1.var_.actorSpriteComps1034 then
				for iter_405_6, iter_405_7 in pairs(arg_402_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_405_7 then
						if arg_402_1.isInRecall_ then
							iter_405_7.color = arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_405_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps1034 = nil
			end

			local var_405_16 = 0
			local var_405_17 = 1.375

			if var_405_16 < arg_402_1.time_ and arg_402_1.time_ <= var_405_16 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_18 = arg_402_1:FormatText(StoryNameCfg[584].name)

				arg_402_1.leftNameTxt_.text = var_405_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_19 = arg_402_1:GetWordFromCfg(417031095)
				local var_405_20 = arg_402_1:FormatText(var_405_19.content)

				arg_402_1.text_.text = var_405_20

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_21 = 55
				local var_405_22 = utf8.len(var_405_20)
				local var_405_23 = var_405_21 <= 0 and var_405_17 or var_405_17 * (var_405_22 / var_405_21)

				if var_405_23 > 0 and var_405_17 < var_405_23 then
					arg_402_1.talkMaxDuration = var_405_23

					if var_405_23 + var_405_16 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_23 + var_405_16
					end
				end

				arg_402_1.text_.text = var_405_20
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031095", "story_v_out_417031.awb") ~= 0 then
					local var_405_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031095", "story_v_out_417031.awb") / 1000

					if var_405_24 + var_405_16 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_24 + var_405_16
					end

					if var_405_19.prefab_name ~= "" and arg_402_1.actors_[var_405_19.prefab_name] ~= nil then
						local var_405_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_19.prefab_name].transform, "story_v_out_417031", "417031095", "story_v_out_417031.awb")

						arg_402_1:RecordAudio("417031095", var_405_25)
						arg_402_1:RecordAudio("417031095", var_405_25)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_417031", "417031095", "story_v_out_417031.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_417031", "417031095", "story_v_out_417031.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_26 = math.max(var_405_17, arg_402_1.talkMaxDuration)

			if var_405_16 <= arg_402_1.time_ and arg_402_1.time_ < var_405_16 + var_405_26 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_16) / var_405_26

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_16 + var_405_26 and arg_402_1.time_ < var_405_16 + var_405_26 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play417031096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 417031096
		arg_406_1.duration_ = 8.2

		local var_406_0 = {
			zh = 4.666,
			ja = 8.2
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play417031097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1060"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1060 = var_409_0.localPosition
				var_409_0.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1060", 2)

				local var_409_2 = var_409_0.childCount

				for iter_409_0 = 0, var_409_2 - 1 do
					local var_409_3 = var_409_0:GetChild(iter_409_0)

					if var_409_3.name == "split_1" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_4 then
				local var_409_5 = (arg_406_1.time_ - var_409_1) / var_409_4
				local var_409_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1060, var_409_6, var_409_5)
			end

			if arg_406_1.time_ >= var_409_1 + var_409_4 and arg_406_1.time_ < var_409_1 + var_409_4 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_409_7 = 0
			local var_409_8 = 0.7

			if var_409_7 < arg_406_1.time_ and arg_406_1.time_ <= var_409_7 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_9 = arg_406_1:FormatText(StoryNameCfg[584].name)

				arg_406_1.leftNameTxt_.text = var_409_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_10 = arg_406_1:GetWordFromCfg(417031096)
				local var_409_11 = arg_406_1:FormatText(var_409_10.content)

				arg_406_1.text_.text = var_409_11

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_12 = 28
				local var_409_13 = utf8.len(var_409_11)
				local var_409_14 = var_409_12 <= 0 and var_409_8 or var_409_8 * (var_409_13 / var_409_12)

				if var_409_14 > 0 and var_409_8 < var_409_14 then
					arg_406_1.talkMaxDuration = var_409_14

					if var_409_14 + var_409_7 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_7
					end
				end

				arg_406_1.text_.text = var_409_11
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031096", "story_v_out_417031.awb") ~= 0 then
					local var_409_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031096", "story_v_out_417031.awb") / 1000

					if var_409_15 + var_409_7 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_15 + var_409_7
					end

					if var_409_10.prefab_name ~= "" and arg_406_1.actors_[var_409_10.prefab_name] ~= nil then
						local var_409_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_10.prefab_name].transform, "story_v_out_417031", "417031096", "story_v_out_417031.awb")

						arg_406_1:RecordAudio("417031096", var_409_16)
						arg_406_1:RecordAudio("417031096", var_409_16)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_417031", "417031096", "story_v_out_417031.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_417031", "417031096", "story_v_out_417031.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_17 = math.max(var_409_8, arg_406_1.talkMaxDuration)

			if var_409_7 <= arg_406_1.time_ and arg_406_1.time_ < var_409_7 + var_409_17 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_7) / var_409_17

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_7 + var_409_17 and arg_406_1.time_ < var_409_7 + var_409_17 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play417031097 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417031097
		arg_410_1.duration_ = 5.13

		local var_410_0 = {
			zh = 3.2,
			ja = 5.133
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417031098(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1034"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.actorSpriteComps1034 == nil then
				arg_410_1.var_.actorSpriteComps1034 = var_413_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_2 = 0.2

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.actorSpriteComps1034 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								local var_413_4 = Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, var_413_3)
								local var_413_5 = Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, var_413_3)
								local var_413_6 = Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, var_413_3)

								iter_413_1.color = Color.New(var_413_4, var_413_5, var_413_6)
							else
								local var_413_7 = Mathf.Lerp(iter_413_1.color.r, 1, var_413_3)

								iter_413_1.color = Color.New(var_413_7, var_413_7, var_413_7)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.actorSpriteComps1034 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_413_3 then
						if arg_410_1.isInRecall_ then
							iter_413_3.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps1034 = nil
			end

			local var_413_8 = arg_410_1.actors_["1060"]
			local var_413_9 = 0

			if var_413_9 < arg_410_1.time_ and arg_410_1.time_ <= var_413_9 + arg_413_0 and not isNil(var_413_8) and arg_410_1.var_.actorSpriteComps1060 == nil then
				arg_410_1.var_.actorSpriteComps1060 = var_413_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_10 = 0.2

			if var_413_9 <= arg_410_1.time_ and arg_410_1.time_ < var_413_9 + var_413_10 and not isNil(var_413_8) then
				local var_413_11 = (arg_410_1.time_ - var_413_9) / var_413_10

				if arg_410_1.var_.actorSpriteComps1060 then
					for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_413_5 then
							if arg_410_1.isInRecall_ then
								local var_413_12 = Mathf.Lerp(iter_413_5.color.r, arg_410_1.hightColor2.r, var_413_11)
								local var_413_13 = Mathf.Lerp(iter_413_5.color.g, arg_410_1.hightColor2.g, var_413_11)
								local var_413_14 = Mathf.Lerp(iter_413_5.color.b, arg_410_1.hightColor2.b, var_413_11)

								iter_413_5.color = Color.New(var_413_12, var_413_13, var_413_14)
							else
								local var_413_15 = Mathf.Lerp(iter_413_5.color.r, 0.5, var_413_11)

								iter_413_5.color = Color.New(var_413_15, var_413_15, var_413_15)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_9 + var_413_10 and arg_410_1.time_ < var_413_9 + var_413_10 + arg_413_0 and not isNil(var_413_8) and arg_410_1.var_.actorSpriteComps1060 then
				for iter_413_6, iter_413_7 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_413_7 then
						if arg_410_1.isInRecall_ then
							iter_413_7.color = arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_413_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps1060 = nil
			end

			local var_413_16 = arg_410_1.actors_["1034"].transform
			local var_413_17 = 0

			if var_413_17 < arg_410_1.time_ and arg_410_1.time_ <= var_413_17 + arg_413_0 then
				arg_410_1.var_.moveOldPos1034 = var_413_16.localPosition
				var_413_16.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1034", 4)

				local var_413_18 = var_413_16.childCount

				for iter_413_8 = 0, var_413_18 - 1 do
					local var_413_19 = var_413_16:GetChild(iter_413_8)

					if var_413_19.name == "split_5" or not string.find(var_413_19.name, "split") then
						var_413_19.gameObject:SetActive(true)
					else
						var_413_19.gameObject:SetActive(false)
					end
				end
			end

			local var_413_20 = 0.001

			if var_413_17 <= arg_410_1.time_ and arg_410_1.time_ < var_413_17 + var_413_20 then
				local var_413_21 = (arg_410_1.time_ - var_413_17) / var_413_20
				local var_413_22 = Vector3.New(373.7, -331.9, -324)

				var_413_16.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1034, var_413_22, var_413_21)
			end

			if arg_410_1.time_ >= var_413_17 + var_413_20 and arg_410_1.time_ < var_413_17 + var_413_20 + arg_413_0 then
				var_413_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_413_23 = 0
			local var_413_24 = 0.4

			if var_413_23 < arg_410_1.time_ and arg_410_1.time_ <= var_413_23 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_25 = arg_410_1:FormatText(StoryNameCfg[1109].name)

				arg_410_1.leftNameTxt_.text = var_413_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_26 = arg_410_1:GetWordFromCfg(417031097)
				local var_413_27 = arg_410_1:FormatText(var_413_26.content)

				arg_410_1.text_.text = var_413_27

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_28 = 16
				local var_413_29 = utf8.len(var_413_27)
				local var_413_30 = var_413_28 <= 0 and var_413_24 or var_413_24 * (var_413_29 / var_413_28)

				if var_413_30 > 0 and var_413_24 < var_413_30 then
					arg_410_1.talkMaxDuration = var_413_30

					if var_413_30 + var_413_23 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_30 + var_413_23
					end
				end

				arg_410_1.text_.text = var_413_27
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031097", "story_v_out_417031.awb") ~= 0 then
					local var_413_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031097", "story_v_out_417031.awb") / 1000

					if var_413_31 + var_413_23 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_31 + var_413_23
					end

					if var_413_26.prefab_name ~= "" and arg_410_1.actors_[var_413_26.prefab_name] ~= nil then
						local var_413_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_26.prefab_name].transform, "story_v_out_417031", "417031097", "story_v_out_417031.awb")

						arg_410_1:RecordAudio("417031097", var_413_32)
						arg_410_1:RecordAudio("417031097", var_413_32)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_417031", "417031097", "story_v_out_417031.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_417031", "417031097", "story_v_out_417031.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_33 = math.max(var_413_24, arg_410_1.talkMaxDuration)

			if var_413_23 <= arg_410_1.time_ and arg_410_1.time_ < var_413_23 + var_413_33 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_23) / var_413_33

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_23 + var_413_33 and arg_410_1.time_ < var_413_23 + var_413_33 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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

		arg_410_1:InitPlayNodeList()
	end,
	Play417031098 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 417031098
		arg_414_1.duration_ = 11.83

		local var_414_0 = {
			zh = 7.3,
			ja = 11.833
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play417031099(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1060"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps1060 == nil then
				arg_414_1.var_.actorSpriteComps1060 = var_417_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_2 = 0.2

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.actorSpriteComps1060 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								local var_417_4 = Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor1.r, var_417_3)
								local var_417_5 = Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor1.g, var_417_3)
								local var_417_6 = Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor1.b, var_417_3)

								iter_417_1.color = Color.New(var_417_4, var_417_5, var_417_6)
							else
								local var_417_7 = Mathf.Lerp(iter_417_1.color.r, 1, var_417_3)

								iter_417_1.color = Color.New(var_417_7, var_417_7, var_417_7)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps1060 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_417_3 then
						if arg_414_1.isInRecall_ then
							iter_417_3.color = arg_414_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_417_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps1060 = nil
			end

			local var_417_8 = arg_414_1.actors_["1034"]
			local var_417_9 = 0

			if var_417_9 < arg_414_1.time_ and arg_414_1.time_ <= var_417_9 + arg_417_0 and not isNil(var_417_8) and arg_414_1.var_.actorSpriteComps1034 == nil then
				arg_414_1.var_.actorSpriteComps1034 = var_417_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_10 = 0.2

			if var_417_9 <= arg_414_1.time_ and arg_414_1.time_ < var_417_9 + var_417_10 and not isNil(var_417_8) then
				local var_417_11 = (arg_414_1.time_ - var_417_9) / var_417_10

				if arg_414_1.var_.actorSpriteComps1034 then
					for iter_417_4, iter_417_5 in pairs(arg_414_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_417_5 then
							if arg_414_1.isInRecall_ then
								local var_417_12 = Mathf.Lerp(iter_417_5.color.r, arg_414_1.hightColor2.r, var_417_11)
								local var_417_13 = Mathf.Lerp(iter_417_5.color.g, arg_414_1.hightColor2.g, var_417_11)
								local var_417_14 = Mathf.Lerp(iter_417_5.color.b, arg_414_1.hightColor2.b, var_417_11)

								iter_417_5.color = Color.New(var_417_12, var_417_13, var_417_14)
							else
								local var_417_15 = Mathf.Lerp(iter_417_5.color.r, 0.5, var_417_11)

								iter_417_5.color = Color.New(var_417_15, var_417_15, var_417_15)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= var_417_9 + var_417_10 and arg_414_1.time_ < var_417_9 + var_417_10 + arg_417_0 and not isNil(var_417_8) and arg_414_1.var_.actorSpriteComps1034 then
				for iter_417_6, iter_417_7 in pairs(arg_414_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_417_7 then
						if arg_414_1.isInRecall_ then
							iter_417_7.color = arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_417_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps1034 = nil
			end

			local var_417_16 = arg_414_1.actors_["1060"].transform
			local var_417_17 = 0

			if var_417_17 < arg_414_1.time_ and arg_414_1.time_ <= var_417_17 + arg_417_0 then
				arg_414_1.var_.moveOldPos1060 = var_417_16.localPosition
				var_417_16.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("1060", 2)

				local var_417_18 = var_417_16.childCount

				for iter_417_8 = 0, var_417_18 - 1 do
					local var_417_19 = var_417_16:GetChild(iter_417_8)

					if var_417_19.name == "split_4" or not string.find(var_417_19.name, "split") then
						var_417_19.gameObject:SetActive(true)
					else
						var_417_19.gameObject:SetActive(false)
					end
				end
			end

			local var_417_20 = 0.001

			if var_417_17 <= arg_414_1.time_ and arg_414_1.time_ < var_417_17 + var_417_20 then
				local var_417_21 = (arg_414_1.time_ - var_417_17) / var_417_20
				local var_417_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_417_16.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1060, var_417_22, var_417_21)
			end

			if arg_414_1.time_ >= var_417_17 + var_417_20 and arg_414_1.time_ < var_417_17 + var_417_20 + arg_417_0 then
				var_417_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_417_23 = 0
			local var_417_24 = 0.925

			if var_417_23 < arg_414_1.time_ and arg_414_1.time_ <= var_417_23 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_25 = arg_414_1:FormatText(StoryNameCfg[584].name)

				arg_414_1.leftNameTxt_.text = var_417_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_26 = arg_414_1:GetWordFromCfg(417031098)
				local var_417_27 = arg_414_1:FormatText(var_417_26.content)

				arg_414_1.text_.text = var_417_27

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_28 = 37
				local var_417_29 = utf8.len(var_417_27)
				local var_417_30 = var_417_28 <= 0 and var_417_24 or var_417_24 * (var_417_29 / var_417_28)

				if var_417_30 > 0 and var_417_24 < var_417_30 then
					arg_414_1.talkMaxDuration = var_417_30

					if var_417_30 + var_417_23 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_30 + var_417_23
					end
				end

				arg_414_1.text_.text = var_417_27
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031098", "story_v_out_417031.awb") ~= 0 then
					local var_417_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031098", "story_v_out_417031.awb") / 1000

					if var_417_31 + var_417_23 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_31 + var_417_23
					end

					if var_417_26.prefab_name ~= "" and arg_414_1.actors_[var_417_26.prefab_name] ~= nil then
						local var_417_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_26.prefab_name].transform, "story_v_out_417031", "417031098", "story_v_out_417031.awb")

						arg_414_1:RecordAudio("417031098", var_417_32)
						arg_414_1:RecordAudio("417031098", var_417_32)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_417031", "417031098", "story_v_out_417031.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_417031", "417031098", "story_v_out_417031.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_33 = math.max(var_417_24, arg_414_1.talkMaxDuration)

			if var_417_23 <= arg_414_1.time_ and arg_414_1.time_ < var_417_23 + var_417_33 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_23) / var_417_33

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_23 + var_417_33 and arg_414_1.time_ < var_417_23 + var_417_33 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play417031099 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 417031099
		arg_418_1.duration_ = 6.83

		local var_418_0 = {
			zh = 5.4,
			ja = 6.833
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play417031100(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.8

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_2 = arg_418_1:FormatText(StoryNameCfg[584].name)

				arg_418_1.leftNameTxt_.text = var_421_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_3 = arg_418_1:GetWordFromCfg(417031099)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 32
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_1 or var_421_1 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_1 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031099", "story_v_out_417031.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031099", "story_v_out_417031.awb") / 1000

					if var_421_8 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_0
					end

					if var_421_3.prefab_name ~= "" and arg_418_1.actors_[var_421_3.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_3.prefab_name].transform, "story_v_out_417031", "417031099", "story_v_out_417031.awb")

						arg_418_1:RecordAudio("417031099", var_421_9)
						arg_418_1:RecordAudio("417031099", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_417031", "417031099", "story_v_out_417031.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_417031", "417031099", "story_v_out_417031.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_10 and arg_418_1.time_ < var_421_0 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play417031100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 417031100
		arg_422_1.duration_ = 7.17

		local var_422_0 = {
			zh = 4.4,
			ja = 7.166
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play417031101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1034"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.actorSpriteComps1034 == nil then
				arg_422_1.var_.actorSpriteComps1034 = var_425_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_2 = 0.2

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.actorSpriteComps1034 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								local var_425_4 = Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, var_425_3)
								local var_425_5 = Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, var_425_3)
								local var_425_6 = Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, var_425_3)

								iter_425_1.color = Color.New(var_425_4, var_425_5, var_425_6)
							else
								local var_425_7 = Mathf.Lerp(iter_425_1.color.r, 1, var_425_3)

								iter_425_1.color = Color.New(var_425_7, var_425_7, var_425_7)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.actorSpriteComps1034 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_425_3 then
						if arg_422_1.isInRecall_ then
							iter_425_3.color = arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_425_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps1034 = nil
			end

			local var_425_8 = arg_422_1.actors_["1060"]
			local var_425_9 = 0

			if var_425_9 < arg_422_1.time_ and arg_422_1.time_ <= var_425_9 + arg_425_0 and not isNil(var_425_8) and arg_422_1.var_.actorSpriteComps1060 == nil then
				arg_422_1.var_.actorSpriteComps1060 = var_425_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_10 = 0.2

			if var_425_9 <= arg_422_1.time_ and arg_422_1.time_ < var_425_9 + var_425_10 and not isNil(var_425_8) then
				local var_425_11 = (arg_422_1.time_ - var_425_9) / var_425_10

				if arg_422_1.var_.actorSpriteComps1060 then
					for iter_425_4, iter_425_5 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_425_5 then
							if arg_422_1.isInRecall_ then
								local var_425_12 = Mathf.Lerp(iter_425_5.color.r, arg_422_1.hightColor2.r, var_425_11)
								local var_425_13 = Mathf.Lerp(iter_425_5.color.g, arg_422_1.hightColor2.g, var_425_11)
								local var_425_14 = Mathf.Lerp(iter_425_5.color.b, arg_422_1.hightColor2.b, var_425_11)

								iter_425_5.color = Color.New(var_425_12, var_425_13, var_425_14)
							else
								local var_425_15 = Mathf.Lerp(iter_425_5.color.r, 0.5, var_425_11)

								iter_425_5.color = Color.New(var_425_15, var_425_15, var_425_15)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_9 + var_425_10 and arg_422_1.time_ < var_425_9 + var_425_10 + arg_425_0 and not isNil(var_425_8) and arg_422_1.var_.actorSpriteComps1060 then
				for iter_425_6, iter_425_7 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_425_7 then
						if arg_422_1.isInRecall_ then
							iter_425_7.color = arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_425_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps1060 = nil
			end

			local var_425_16 = arg_422_1.actors_["1034"].transform
			local var_425_17 = 0

			if var_425_17 < arg_422_1.time_ and arg_422_1.time_ <= var_425_17 + arg_425_0 then
				arg_422_1.var_.moveOldPos1034 = var_425_16.localPosition
				var_425_16.localScale = Vector3.New(1, 1, 1)

				arg_422_1:CheckSpriteTmpPos("1034", 4)

				local var_425_18 = var_425_16.childCount

				for iter_425_8 = 0, var_425_18 - 1 do
					local var_425_19 = var_425_16:GetChild(iter_425_8)

					if var_425_19.name == "split_4" or not string.find(var_425_19.name, "split") then
						var_425_19.gameObject:SetActive(true)
					else
						var_425_19.gameObject:SetActive(false)
					end
				end
			end

			local var_425_20 = 0.001

			if var_425_17 <= arg_422_1.time_ and arg_422_1.time_ < var_425_17 + var_425_20 then
				local var_425_21 = (arg_422_1.time_ - var_425_17) / var_425_20
				local var_425_22 = Vector3.New(373.7, -331.9, -324)

				var_425_16.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1034, var_425_22, var_425_21)
			end

			if arg_422_1.time_ >= var_425_17 + var_425_20 and arg_422_1.time_ < var_425_17 + var_425_20 + arg_425_0 then
				var_425_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_425_23 = 0
			local var_425_24 = 0.4

			if var_425_23 < arg_422_1.time_ and arg_422_1.time_ <= var_425_23 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_25 = arg_422_1:FormatText(StoryNameCfg[1109].name)

				arg_422_1.leftNameTxt_.text = var_425_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_26 = arg_422_1:GetWordFromCfg(417031100)
				local var_425_27 = arg_422_1:FormatText(var_425_26.content)

				arg_422_1.text_.text = var_425_27

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_28 = 16
				local var_425_29 = utf8.len(var_425_27)
				local var_425_30 = var_425_28 <= 0 and var_425_24 or var_425_24 * (var_425_29 / var_425_28)

				if var_425_30 > 0 and var_425_24 < var_425_30 then
					arg_422_1.talkMaxDuration = var_425_30

					if var_425_30 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_30 + var_425_23
					end
				end

				arg_422_1.text_.text = var_425_27
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031100", "story_v_out_417031.awb") ~= 0 then
					local var_425_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031100", "story_v_out_417031.awb") / 1000

					if var_425_31 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_31 + var_425_23
					end

					if var_425_26.prefab_name ~= "" and arg_422_1.actors_[var_425_26.prefab_name] ~= nil then
						local var_425_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_26.prefab_name].transform, "story_v_out_417031", "417031100", "story_v_out_417031.awb")

						arg_422_1:RecordAudio("417031100", var_425_32)
						arg_422_1:RecordAudio("417031100", var_425_32)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_417031", "417031100", "story_v_out_417031.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_417031", "417031100", "story_v_out_417031.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_33 = math.max(var_425_24, arg_422_1.talkMaxDuration)

			if var_425_23 <= arg_422_1.time_ and arg_422_1.time_ < var_425_23 + var_425_33 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_23) / var_425_33

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_23 + var_425_33 and arg_422_1.time_ < var_425_23 + var_425_33 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
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

		arg_422_1:InitPlayNodeList()
	end,
	Play417031101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 417031101
		arg_426_1.duration_ = 12.33

		local var_426_0 = {
			zh = 9.933,
			ja = 12.333
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play417031102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1060"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.actorSpriteComps1060 == nil then
				arg_426_1.var_.actorSpriteComps1060 = var_429_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_2 = 0.2

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.actorSpriteComps1060 then
					for iter_429_0, iter_429_1 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_429_1 then
							if arg_426_1.isInRecall_ then
								local var_429_4 = Mathf.Lerp(iter_429_1.color.r, arg_426_1.hightColor1.r, var_429_3)
								local var_429_5 = Mathf.Lerp(iter_429_1.color.g, arg_426_1.hightColor1.g, var_429_3)
								local var_429_6 = Mathf.Lerp(iter_429_1.color.b, arg_426_1.hightColor1.b, var_429_3)

								iter_429_1.color = Color.New(var_429_4, var_429_5, var_429_6)
							else
								local var_429_7 = Mathf.Lerp(iter_429_1.color.r, 1, var_429_3)

								iter_429_1.color = Color.New(var_429_7, var_429_7, var_429_7)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.actorSpriteComps1060 then
				for iter_429_2, iter_429_3 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_429_3 then
						if arg_426_1.isInRecall_ then
							iter_429_3.color = arg_426_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_429_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_426_1.var_.actorSpriteComps1060 = nil
			end

			local var_429_8 = arg_426_1.actors_["1034"]
			local var_429_9 = 0

			if var_429_9 < arg_426_1.time_ and arg_426_1.time_ <= var_429_9 + arg_429_0 and not isNil(var_429_8) and arg_426_1.var_.actorSpriteComps1034 == nil then
				arg_426_1.var_.actorSpriteComps1034 = var_429_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_10 = 0.2

			if var_429_9 <= arg_426_1.time_ and arg_426_1.time_ < var_429_9 + var_429_10 and not isNil(var_429_8) then
				local var_429_11 = (arg_426_1.time_ - var_429_9) / var_429_10

				if arg_426_1.var_.actorSpriteComps1034 then
					for iter_429_4, iter_429_5 in pairs(arg_426_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_429_5 then
							if arg_426_1.isInRecall_ then
								local var_429_12 = Mathf.Lerp(iter_429_5.color.r, arg_426_1.hightColor2.r, var_429_11)
								local var_429_13 = Mathf.Lerp(iter_429_5.color.g, arg_426_1.hightColor2.g, var_429_11)
								local var_429_14 = Mathf.Lerp(iter_429_5.color.b, arg_426_1.hightColor2.b, var_429_11)

								iter_429_5.color = Color.New(var_429_12, var_429_13, var_429_14)
							else
								local var_429_15 = Mathf.Lerp(iter_429_5.color.r, 0.5, var_429_11)

								iter_429_5.color = Color.New(var_429_15, var_429_15, var_429_15)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= var_429_9 + var_429_10 and arg_426_1.time_ < var_429_9 + var_429_10 + arg_429_0 and not isNil(var_429_8) and arg_426_1.var_.actorSpriteComps1034 then
				for iter_429_6, iter_429_7 in pairs(arg_426_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_429_7 then
						if arg_426_1.isInRecall_ then
							iter_429_7.color = arg_426_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_429_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_426_1.var_.actorSpriteComps1034 = nil
			end

			local var_429_16 = arg_426_1.actors_["1060"].transform
			local var_429_17 = 0

			if var_429_17 < arg_426_1.time_ and arg_426_1.time_ <= var_429_17 + arg_429_0 then
				arg_426_1.var_.moveOldPos1060 = var_429_16.localPosition
				var_429_16.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("1060", 2)

				local var_429_18 = var_429_16.childCount

				for iter_429_8 = 0, var_429_18 - 1 do
					local var_429_19 = var_429_16:GetChild(iter_429_8)

					if var_429_19.name == "split_4" or not string.find(var_429_19.name, "split") then
						var_429_19.gameObject:SetActive(true)
					else
						var_429_19.gameObject:SetActive(false)
					end
				end
			end

			local var_429_20 = 0.001

			if var_429_17 <= arg_426_1.time_ and arg_426_1.time_ < var_429_17 + var_429_20 then
				local var_429_21 = (arg_426_1.time_ - var_429_17) / var_429_20
				local var_429_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_429_16.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1060, var_429_22, var_429_21)
			end

			if arg_426_1.time_ >= var_429_17 + var_429_20 and arg_426_1.time_ < var_429_17 + var_429_20 + arg_429_0 then
				var_429_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_429_23 = 0
			local var_429_24 = 1.2

			if var_429_23 < arg_426_1.time_ and arg_426_1.time_ <= var_429_23 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_25 = arg_426_1:FormatText(StoryNameCfg[584].name)

				arg_426_1.leftNameTxt_.text = var_429_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_26 = arg_426_1:GetWordFromCfg(417031101)
				local var_429_27 = arg_426_1:FormatText(var_429_26.content)

				arg_426_1.text_.text = var_429_27

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_28 = 48
				local var_429_29 = utf8.len(var_429_27)
				local var_429_30 = var_429_28 <= 0 and var_429_24 or var_429_24 * (var_429_29 / var_429_28)

				if var_429_30 > 0 and var_429_24 < var_429_30 then
					arg_426_1.talkMaxDuration = var_429_30

					if var_429_30 + var_429_23 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_30 + var_429_23
					end
				end

				arg_426_1.text_.text = var_429_27
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031101", "story_v_out_417031.awb") ~= 0 then
					local var_429_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031101", "story_v_out_417031.awb") / 1000

					if var_429_31 + var_429_23 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_31 + var_429_23
					end

					if var_429_26.prefab_name ~= "" and arg_426_1.actors_[var_429_26.prefab_name] ~= nil then
						local var_429_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_26.prefab_name].transform, "story_v_out_417031", "417031101", "story_v_out_417031.awb")

						arg_426_1:RecordAudio("417031101", var_429_32)
						arg_426_1:RecordAudio("417031101", var_429_32)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_417031", "417031101", "story_v_out_417031.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_417031", "417031101", "story_v_out_417031.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_33 = math.max(var_429_24, arg_426_1.talkMaxDuration)

			if var_429_23 <= arg_426_1.time_ and arg_426_1.time_ < var_429_23 + var_429_33 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_23) / var_429_33

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_23 + var_429_33 and arg_426_1.time_ < var_429_23 + var_429_33 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play417031102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 417031102
		arg_430_1.duration_ = 5.83

		local var_430_0 = {
			zh = 3.733,
			ja = 5.833
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play417031103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1034"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.actorSpriteComps1034 == nil then
				arg_430_1.var_.actorSpriteComps1034 = var_433_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_2 = 0.2

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.actorSpriteComps1034 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								local var_433_4 = Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor1.r, var_433_3)
								local var_433_5 = Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor1.g, var_433_3)
								local var_433_6 = Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor1.b, var_433_3)

								iter_433_1.color = Color.New(var_433_4, var_433_5, var_433_6)
							else
								local var_433_7 = Mathf.Lerp(iter_433_1.color.r, 1, var_433_3)

								iter_433_1.color = Color.New(var_433_7, var_433_7, var_433_7)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.actorSpriteComps1034 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_433_3 then
						if arg_430_1.isInRecall_ then
							iter_433_3.color = arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_433_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_430_1.var_.actorSpriteComps1034 = nil
			end

			local var_433_8 = arg_430_1.actors_["1060"]
			local var_433_9 = 0

			if var_433_9 < arg_430_1.time_ and arg_430_1.time_ <= var_433_9 + arg_433_0 and not isNil(var_433_8) and arg_430_1.var_.actorSpriteComps1060 == nil then
				arg_430_1.var_.actorSpriteComps1060 = var_433_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_10 = 0.2

			if var_433_9 <= arg_430_1.time_ and arg_430_1.time_ < var_433_9 + var_433_10 and not isNil(var_433_8) then
				local var_433_11 = (arg_430_1.time_ - var_433_9) / var_433_10

				if arg_430_1.var_.actorSpriteComps1060 then
					for iter_433_4, iter_433_5 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_433_5 then
							if arg_430_1.isInRecall_ then
								local var_433_12 = Mathf.Lerp(iter_433_5.color.r, arg_430_1.hightColor2.r, var_433_11)
								local var_433_13 = Mathf.Lerp(iter_433_5.color.g, arg_430_1.hightColor2.g, var_433_11)
								local var_433_14 = Mathf.Lerp(iter_433_5.color.b, arg_430_1.hightColor2.b, var_433_11)

								iter_433_5.color = Color.New(var_433_12, var_433_13, var_433_14)
							else
								local var_433_15 = Mathf.Lerp(iter_433_5.color.r, 0.5, var_433_11)

								iter_433_5.color = Color.New(var_433_15, var_433_15, var_433_15)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= var_433_9 + var_433_10 and arg_430_1.time_ < var_433_9 + var_433_10 + arg_433_0 and not isNil(var_433_8) and arg_430_1.var_.actorSpriteComps1060 then
				for iter_433_6, iter_433_7 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_433_7 then
						if arg_430_1.isInRecall_ then
							iter_433_7.color = arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_433_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_430_1.var_.actorSpriteComps1060 = nil
			end

			local var_433_16 = arg_430_1.actors_["1034"].transform
			local var_433_17 = 0

			if var_433_17 < arg_430_1.time_ and arg_430_1.time_ <= var_433_17 + arg_433_0 then
				arg_430_1.var_.moveOldPos1034 = var_433_16.localPosition
				var_433_16.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("1034", 4)

				local var_433_18 = var_433_16.childCount

				for iter_433_8 = 0, var_433_18 - 1 do
					local var_433_19 = var_433_16:GetChild(iter_433_8)

					if var_433_19.name == "split_7" or not string.find(var_433_19.name, "split") then
						var_433_19.gameObject:SetActive(true)
					else
						var_433_19.gameObject:SetActive(false)
					end
				end
			end

			local var_433_20 = 0.001

			if var_433_17 <= arg_430_1.time_ and arg_430_1.time_ < var_433_17 + var_433_20 then
				local var_433_21 = (arg_430_1.time_ - var_433_17) / var_433_20
				local var_433_22 = Vector3.New(373.7, -331.9, -324)

				var_433_16.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1034, var_433_22, var_433_21)
			end

			if arg_430_1.time_ >= var_433_17 + var_433_20 and arg_430_1.time_ < var_433_17 + var_433_20 + arg_433_0 then
				var_433_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_433_23 = 0
			local var_433_24 = 0.5

			if var_433_23 < arg_430_1.time_ and arg_430_1.time_ <= var_433_23 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_25 = arg_430_1:FormatText(StoryNameCfg[1109].name)

				arg_430_1.leftNameTxt_.text = var_433_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_26 = arg_430_1:GetWordFromCfg(417031102)
				local var_433_27 = arg_430_1:FormatText(var_433_26.content)

				arg_430_1.text_.text = var_433_27

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_28 = 20
				local var_433_29 = utf8.len(var_433_27)
				local var_433_30 = var_433_28 <= 0 and var_433_24 or var_433_24 * (var_433_29 / var_433_28)

				if var_433_30 > 0 and var_433_24 < var_433_30 then
					arg_430_1.talkMaxDuration = var_433_30

					if var_433_30 + var_433_23 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_30 + var_433_23
					end
				end

				arg_430_1.text_.text = var_433_27
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031102", "story_v_out_417031.awb") ~= 0 then
					local var_433_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031102", "story_v_out_417031.awb") / 1000

					if var_433_31 + var_433_23 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_31 + var_433_23
					end

					if var_433_26.prefab_name ~= "" and arg_430_1.actors_[var_433_26.prefab_name] ~= nil then
						local var_433_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_26.prefab_name].transform, "story_v_out_417031", "417031102", "story_v_out_417031.awb")

						arg_430_1:RecordAudio("417031102", var_433_32)
						arg_430_1:RecordAudio("417031102", var_433_32)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_417031", "417031102", "story_v_out_417031.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_417031", "417031102", "story_v_out_417031.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_33 = math.max(var_433_24, arg_430_1.talkMaxDuration)

			if var_433_23 <= arg_430_1.time_ and arg_430_1.time_ < var_433_23 + var_433_33 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_23) / var_433_33

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_23 + var_433_33 and arg_430_1.time_ < var_433_23 + var_433_33 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
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

		arg_430_1:InitPlayNodeList()
	end,
	Play417031103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 417031103
		arg_434_1.duration_ = 11.73

		local var_434_0 = {
			zh = 10.7,
			ja = 11.733
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play417031104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1060"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.actorSpriteComps1060 == nil then
				arg_434_1.var_.actorSpriteComps1060 = var_437_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_2 = 0.2

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.actorSpriteComps1060 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_437_1 then
							if arg_434_1.isInRecall_ then
								local var_437_4 = Mathf.Lerp(iter_437_1.color.r, arg_434_1.hightColor1.r, var_437_3)
								local var_437_5 = Mathf.Lerp(iter_437_1.color.g, arg_434_1.hightColor1.g, var_437_3)
								local var_437_6 = Mathf.Lerp(iter_437_1.color.b, arg_434_1.hightColor1.b, var_437_3)

								iter_437_1.color = Color.New(var_437_4, var_437_5, var_437_6)
							else
								local var_437_7 = Mathf.Lerp(iter_437_1.color.r, 1, var_437_3)

								iter_437_1.color = Color.New(var_437_7, var_437_7, var_437_7)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.actorSpriteComps1060 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_437_3 then
						if arg_434_1.isInRecall_ then
							iter_437_3.color = arg_434_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_437_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_434_1.var_.actorSpriteComps1060 = nil
			end

			local var_437_8 = arg_434_1.actors_["1034"]
			local var_437_9 = 0

			if var_437_9 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 and not isNil(var_437_8) and arg_434_1.var_.actorSpriteComps1034 == nil then
				arg_434_1.var_.actorSpriteComps1034 = var_437_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_10 = 0.2

			if var_437_9 <= arg_434_1.time_ and arg_434_1.time_ < var_437_9 + var_437_10 and not isNil(var_437_8) then
				local var_437_11 = (arg_434_1.time_ - var_437_9) / var_437_10

				if arg_434_1.var_.actorSpriteComps1034 then
					for iter_437_4, iter_437_5 in pairs(arg_434_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_437_5 then
							if arg_434_1.isInRecall_ then
								local var_437_12 = Mathf.Lerp(iter_437_5.color.r, arg_434_1.hightColor2.r, var_437_11)
								local var_437_13 = Mathf.Lerp(iter_437_5.color.g, arg_434_1.hightColor2.g, var_437_11)
								local var_437_14 = Mathf.Lerp(iter_437_5.color.b, arg_434_1.hightColor2.b, var_437_11)

								iter_437_5.color = Color.New(var_437_12, var_437_13, var_437_14)
							else
								local var_437_15 = Mathf.Lerp(iter_437_5.color.r, 0.5, var_437_11)

								iter_437_5.color = Color.New(var_437_15, var_437_15, var_437_15)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= var_437_9 + var_437_10 and arg_434_1.time_ < var_437_9 + var_437_10 + arg_437_0 and not isNil(var_437_8) and arg_434_1.var_.actorSpriteComps1034 then
				for iter_437_6, iter_437_7 in pairs(arg_434_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_437_7 then
						if arg_434_1.isInRecall_ then
							iter_437_7.color = arg_434_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_437_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_434_1.var_.actorSpriteComps1034 = nil
			end

			local var_437_16 = arg_434_1.actors_["1060"].transform
			local var_437_17 = 0

			if var_437_17 < arg_434_1.time_ and arg_434_1.time_ <= var_437_17 + arg_437_0 then
				arg_434_1.var_.moveOldPos1060 = var_437_16.localPosition
				var_437_16.localScale = Vector3.New(1, 1, 1)

				arg_434_1:CheckSpriteTmpPos("1060", 2)

				local var_437_18 = var_437_16.childCount

				for iter_437_8 = 0, var_437_18 - 1 do
					local var_437_19 = var_437_16:GetChild(iter_437_8)

					if var_437_19.name == "" or not string.find(var_437_19.name, "split") then
						var_437_19.gameObject:SetActive(true)
					else
						var_437_19.gameObject:SetActive(false)
					end
				end
			end

			local var_437_20 = 0.001

			if var_437_17 <= arg_434_1.time_ and arg_434_1.time_ < var_437_17 + var_437_20 then
				local var_437_21 = (arg_434_1.time_ - var_437_17) / var_437_20
				local var_437_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_437_16.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1060, var_437_22, var_437_21)
			end

			if arg_434_1.time_ >= var_437_17 + var_437_20 and arg_434_1.time_ < var_437_17 + var_437_20 + arg_437_0 then
				var_437_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_437_23 = 0
			local var_437_24 = 1.1

			if var_437_23 < arg_434_1.time_ and arg_434_1.time_ <= var_437_23 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_25 = arg_434_1:FormatText(StoryNameCfg[584].name)

				arg_434_1.leftNameTxt_.text = var_437_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_26 = arg_434_1:GetWordFromCfg(417031103)
				local var_437_27 = arg_434_1:FormatText(var_437_26.content)

				arg_434_1.text_.text = var_437_27

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_28 = 44
				local var_437_29 = utf8.len(var_437_27)
				local var_437_30 = var_437_28 <= 0 and var_437_24 or var_437_24 * (var_437_29 / var_437_28)

				if var_437_30 > 0 and var_437_24 < var_437_30 then
					arg_434_1.talkMaxDuration = var_437_30

					if var_437_30 + var_437_23 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_30 + var_437_23
					end
				end

				arg_434_1.text_.text = var_437_27
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031103", "story_v_out_417031.awb") ~= 0 then
					local var_437_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031103", "story_v_out_417031.awb") / 1000

					if var_437_31 + var_437_23 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_31 + var_437_23
					end

					if var_437_26.prefab_name ~= "" and arg_434_1.actors_[var_437_26.prefab_name] ~= nil then
						local var_437_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_26.prefab_name].transform, "story_v_out_417031", "417031103", "story_v_out_417031.awb")

						arg_434_1:RecordAudio("417031103", var_437_32)
						arg_434_1:RecordAudio("417031103", var_437_32)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_417031", "417031103", "story_v_out_417031.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_417031", "417031103", "story_v_out_417031.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_33 = math.max(var_437_24, arg_434_1.talkMaxDuration)

			if var_437_23 <= arg_434_1.time_ and arg_434_1.time_ < var_437_23 + var_437_33 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_23) / var_437_33

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_23 + var_437_33 and arg_434_1.time_ < var_437_23 + var_437_33 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play417031104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 417031104
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play417031105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1060"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.actorSpriteComps1060 == nil then
				arg_438_1.var_.actorSpriteComps1060 = var_441_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_2 = 0.2

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.actorSpriteComps1060 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								local var_441_4 = Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor2.r, var_441_3)
								local var_441_5 = Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor2.g, var_441_3)
								local var_441_6 = Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor2.b, var_441_3)

								iter_441_1.color = Color.New(var_441_4, var_441_5, var_441_6)
							else
								local var_441_7 = Mathf.Lerp(iter_441_1.color.r, 0.5, var_441_3)

								iter_441_1.color = Color.New(var_441_7, var_441_7, var_441_7)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.actorSpriteComps1060 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_441_3 then
						if arg_438_1.isInRecall_ then
							iter_441_3.color = arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_441_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_438_1.var_.actorSpriteComps1060 = nil
			end

			local var_441_8 = 0
			local var_441_9 = 1.575

			if var_441_8 < arg_438_1.time_ and arg_438_1.time_ <= var_441_8 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_10 = arg_438_1:GetWordFromCfg(417031104)
				local var_441_11 = arg_438_1:FormatText(var_441_10.content)

				arg_438_1.text_.text = var_441_11

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_12 = 63
				local var_441_13 = utf8.len(var_441_11)
				local var_441_14 = var_441_12 <= 0 and var_441_9 or var_441_9 * (var_441_13 / var_441_12)

				if var_441_14 > 0 and var_441_9 < var_441_14 then
					arg_438_1.talkMaxDuration = var_441_14

					if var_441_14 + var_441_8 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_14 + var_441_8
					end
				end

				arg_438_1.text_.text = var_441_11
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_15 = math.max(var_441_9, arg_438_1.talkMaxDuration)

			if var_441_8 <= arg_438_1.time_ and arg_438_1.time_ < var_441_8 + var_441_15 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_8) / var_441_15

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_8 + var_441_15 and arg_438_1.time_ < var_441_8 + var_441_15 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play417031105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 417031105
		arg_442_1.duration_ = 5.93

		local var_442_0 = {
			zh = 4.133,
			ja = 5.933
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play417031106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1034"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1034 == nil then
				arg_442_1.var_.actorSpriteComps1034 = var_445_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_2 = 0.2

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.actorSpriteComps1034 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								local var_445_4 = Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, var_445_3)
								local var_445_5 = Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, var_445_3)
								local var_445_6 = Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, var_445_3)

								iter_445_1.color = Color.New(var_445_4, var_445_5, var_445_6)
							else
								local var_445_7 = Mathf.Lerp(iter_445_1.color.r, 1, var_445_3)

								iter_445_1.color = Color.New(var_445_7, var_445_7, var_445_7)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1034 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_445_3 then
						if arg_442_1.isInRecall_ then
							iter_445_3.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_445_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps1034 = nil
			end

			local var_445_8 = arg_442_1.actors_["1034"].transform
			local var_445_9 = 0

			if var_445_9 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 then
				arg_442_1.var_.moveOldPos1034 = var_445_8.localPosition
				var_445_8.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1034", 4)

				local var_445_10 = var_445_8.childCount

				for iter_445_4 = 0, var_445_10 - 1 do
					local var_445_11 = var_445_8:GetChild(iter_445_4)

					if var_445_11.name == "split_7" or not string.find(var_445_11.name, "split") then
						var_445_11.gameObject:SetActive(true)
					else
						var_445_11.gameObject:SetActive(false)
					end
				end
			end

			local var_445_12 = 0.001

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_12 then
				local var_445_13 = (arg_442_1.time_ - var_445_9) / var_445_12
				local var_445_14 = Vector3.New(373.7, -331.9, -324)

				var_445_8.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1034, var_445_14, var_445_13)
			end

			if arg_442_1.time_ >= var_445_9 + var_445_12 and arg_442_1.time_ < var_445_9 + var_445_12 + arg_445_0 then
				var_445_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_445_15 = 0
			local var_445_16 = 0.625

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_17 = arg_442_1:FormatText(StoryNameCfg[1109].name)

				arg_442_1.leftNameTxt_.text = var_445_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_18 = arg_442_1:GetWordFromCfg(417031105)
				local var_445_19 = arg_442_1:FormatText(var_445_18.content)

				arg_442_1.text_.text = var_445_19

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_20 = 25
				local var_445_21 = utf8.len(var_445_19)
				local var_445_22 = var_445_20 <= 0 and var_445_16 or var_445_16 * (var_445_21 / var_445_20)

				if var_445_22 > 0 and var_445_16 < var_445_22 then
					arg_442_1.talkMaxDuration = var_445_22

					if var_445_22 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_15
					end
				end

				arg_442_1.text_.text = var_445_19
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031105", "story_v_out_417031.awb") ~= 0 then
					local var_445_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031105", "story_v_out_417031.awb") / 1000

					if var_445_23 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_23 + var_445_15
					end

					if var_445_18.prefab_name ~= "" and arg_442_1.actors_[var_445_18.prefab_name] ~= nil then
						local var_445_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_18.prefab_name].transform, "story_v_out_417031", "417031105", "story_v_out_417031.awb")

						arg_442_1:RecordAudio("417031105", var_445_24)
						arg_442_1:RecordAudio("417031105", var_445_24)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_417031", "417031105", "story_v_out_417031.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_417031", "417031105", "story_v_out_417031.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_25 = math.max(var_445_16, arg_442_1.talkMaxDuration)

			if var_445_15 <= arg_442_1.time_ and arg_442_1.time_ < var_445_15 + var_445_25 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_15) / var_445_25

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_15 + var_445_25 and arg_442_1.time_ < var_445_15 + var_445_25 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
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

		arg_442_1:InitPlayNodeList()
	end,
	Play417031106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 417031106
		arg_446_1.duration_ = 6.9

		local var_446_0 = {
			zh = 6.1,
			ja = 6.9
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play417031107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1060"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1060 == nil then
				arg_446_1.var_.actorSpriteComps1060 = var_449_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_2 = 0.2

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.actorSpriteComps1060 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								local var_449_4 = Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, var_449_3)
								local var_449_5 = Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, var_449_3)
								local var_449_6 = Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, var_449_3)

								iter_449_1.color = Color.New(var_449_4, var_449_5, var_449_6)
							else
								local var_449_7 = Mathf.Lerp(iter_449_1.color.r, 1, var_449_3)

								iter_449_1.color = Color.New(var_449_7, var_449_7, var_449_7)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1060 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_449_3 then
						if arg_446_1.isInRecall_ then
							iter_449_3.color = arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_449_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps1060 = nil
			end

			local var_449_8 = arg_446_1.actors_["1034"]
			local var_449_9 = 0

			if var_449_9 < arg_446_1.time_ and arg_446_1.time_ <= var_449_9 + arg_449_0 and not isNil(var_449_8) and arg_446_1.var_.actorSpriteComps1034 == nil then
				arg_446_1.var_.actorSpriteComps1034 = var_449_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_10 = 0.2

			if var_449_9 <= arg_446_1.time_ and arg_446_1.time_ < var_449_9 + var_449_10 and not isNil(var_449_8) then
				local var_449_11 = (arg_446_1.time_ - var_449_9) / var_449_10

				if arg_446_1.var_.actorSpriteComps1034 then
					for iter_449_4, iter_449_5 in pairs(arg_446_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_449_5 then
							if arg_446_1.isInRecall_ then
								local var_449_12 = Mathf.Lerp(iter_449_5.color.r, arg_446_1.hightColor2.r, var_449_11)
								local var_449_13 = Mathf.Lerp(iter_449_5.color.g, arg_446_1.hightColor2.g, var_449_11)
								local var_449_14 = Mathf.Lerp(iter_449_5.color.b, arg_446_1.hightColor2.b, var_449_11)

								iter_449_5.color = Color.New(var_449_12, var_449_13, var_449_14)
							else
								local var_449_15 = Mathf.Lerp(iter_449_5.color.r, 0.5, var_449_11)

								iter_449_5.color = Color.New(var_449_15, var_449_15, var_449_15)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= var_449_9 + var_449_10 and arg_446_1.time_ < var_449_9 + var_449_10 + arg_449_0 and not isNil(var_449_8) and arg_446_1.var_.actorSpriteComps1034 then
				for iter_449_6, iter_449_7 in pairs(arg_446_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_449_7 then
						if arg_446_1.isInRecall_ then
							iter_449_7.color = arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_449_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps1034 = nil
			end

			local var_449_16 = arg_446_1.actors_["1060"].transform
			local var_449_17 = 0

			if var_449_17 < arg_446_1.time_ and arg_446_1.time_ <= var_449_17 + arg_449_0 then
				arg_446_1.var_.moveOldPos1060 = var_449_16.localPosition
				var_449_16.localScale = Vector3.New(1, 1, 1)

				arg_446_1:CheckSpriteTmpPos("1060", 2)

				local var_449_18 = var_449_16.childCount

				for iter_449_8 = 0, var_449_18 - 1 do
					local var_449_19 = var_449_16:GetChild(iter_449_8)

					if var_449_19.name == "split_2" or not string.find(var_449_19.name, "split") then
						var_449_19.gameObject:SetActive(true)
					else
						var_449_19.gameObject:SetActive(false)
					end
				end
			end

			local var_449_20 = 0.001

			if var_449_17 <= arg_446_1.time_ and arg_446_1.time_ < var_449_17 + var_449_20 then
				local var_449_21 = (arg_446_1.time_ - var_449_17) / var_449_20
				local var_449_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_449_16.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1060, var_449_22, var_449_21)
			end

			if arg_446_1.time_ >= var_449_17 + var_449_20 and arg_446_1.time_ < var_449_17 + var_449_20 + arg_449_0 then
				var_449_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_449_23 = 0
			local var_449_24 = 0.65

			if var_449_23 < arg_446_1.time_ and arg_446_1.time_ <= var_449_23 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_25 = arg_446_1:FormatText(StoryNameCfg[584].name)

				arg_446_1.leftNameTxt_.text = var_449_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_26 = arg_446_1:GetWordFromCfg(417031106)
				local var_449_27 = arg_446_1:FormatText(var_449_26.content)

				arg_446_1.text_.text = var_449_27

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_28 = 26
				local var_449_29 = utf8.len(var_449_27)
				local var_449_30 = var_449_28 <= 0 and var_449_24 or var_449_24 * (var_449_29 / var_449_28)

				if var_449_30 > 0 and var_449_24 < var_449_30 then
					arg_446_1.talkMaxDuration = var_449_30

					if var_449_30 + var_449_23 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_30 + var_449_23
					end
				end

				arg_446_1.text_.text = var_449_27
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031106", "story_v_out_417031.awb") ~= 0 then
					local var_449_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031106", "story_v_out_417031.awb") / 1000

					if var_449_31 + var_449_23 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_31 + var_449_23
					end

					if var_449_26.prefab_name ~= "" and arg_446_1.actors_[var_449_26.prefab_name] ~= nil then
						local var_449_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_26.prefab_name].transform, "story_v_out_417031", "417031106", "story_v_out_417031.awb")

						arg_446_1:RecordAudio("417031106", var_449_32)
						arg_446_1:RecordAudio("417031106", var_449_32)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_417031", "417031106", "story_v_out_417031.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_417031", "417031106", "story_v_out_417031.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_33 = math.max(var_449_24, arg_446_1.talkMaxDuration)

			if var_449_23 <= arg_446_1.time_ and arg_446_1.time_ < var_449_23 + var_449_33 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_23) / var_449_33

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_23 + var_449_33 and arg_446_1.time_ < var_449_23 + var_449_33 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play417031107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 417031107
		arg_450_1.duration_ = 7.23

		local var_450_0 = {
			zh = 4.7,
			ja = 7.233
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play417031108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1034"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1034 == nil then
				arg_450_1.var_.actorSpriteComps1034 = var_453_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_2 = 0.2

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.actorSpriteComps1034 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								local var_453_4 = Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor1.r, var_453_3)
								local var_453_5 = Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor1.g, var_453_3)
								local var_453_6 = Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor1.b, var_453_3)

								iter_453_1.color = Color.New(var_453_4, var_453_5, var_453_6)
							else
								local var_453_7 = Mathf.Lerp(iter_453_1.color.r, 1, var_453_3)

								iter_453_1.color = Color.New(var_453_7, var_453_7, var_453_7)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1034 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_453_3 then
						if arg_450_1.isInRecall_ then
							iter_453_3.color = arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_453_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps1034 = nil
			end

			local var_453_8 = arg_450_1.actors_["1060"]
			local var_453_9 = 0

			if var_453_9 < arg_450_1.time_ and arg_450_1.time_ <= var_453_9 + arg_453_0 and not isNil(var_453_8) and arg_450_1.var_.actorSpriteComps1060 == nil then
				arg_450_1.var_.actorSpriteComps1060 = var_453_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_10 = 0.2

			if var_453_9 <= arg_450_1.time_ and arg_450_1.time_ < var_453_9 + var_453_10 and not isNil(var_453_8) then
				local var_453_11 = (arg_450_1.time_ - var_453_9) / var_453_10

				if arg_450_1.var_.actorSpriteComps1060 then
					for iter_453_4, iter_453_5 in pairs(arg_450_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_453_5 then
							if arg_450_1.isInRecall_ then
								local var_453_12 = Mathf.Lerp(iter_453_5.color.r, arg_450_1.hightColor2.r, var_453_11)
								local var_453_13 = Mathf.Lerp(iter_453_5.color.g, arg_450_1.hightColor2.g, var_453_11)
								local var_453_14 = Mathf.Lerp(iter_453_5.color.b, arg_450_1.hightColor2.b, var_453_11)

								iter_453_5.color = Color.New(var_453_12, var_453_13, var_453_14)
							else
								local var_453_15 = Mathf.Lerp(iter_453_5.color.r, 0.5, var_453_11)

								iter_453_5.color = Color.New(var_453_15, var_453_15, var_453_15)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= var_453_9 + var_453_10 and arg_450_1.time_ < var_453_9 + var_453_10 + arg_453_0 and not isNil(var_453_8) and arg_450_1.var_.actorSpriteComps1060 then
				for iter_453_6, iter_453_7 in pairs(arg_450_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_453_7 then
						if arg_450_1.isInRecall_ then
							iter_453_7.color = arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_453_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps1060 = nil
			end

			local var_453_16 = arg_450_1.actors_["1034"].transform
			local var_453_17 = 0

			if var_453_17 < arg_450_1.time_ and arg_450_1.time_ <= var_453_17 + arg_453_0 then
				arg_450_1.var_.moveOldPos1034 = var_453_16.localPosition
				var_453_16.localScale = Vector3.New(1, 1, 1)

				arg_450_1:CheckSpriteTmpPos("1034", 4)

				local var_453_18 = var_453_16.childCount

				for iter_453_8 = 0, var_453_18 - 1 do
					local var_453_19 = var_453_16:GetChild(iter_453_8)

					if var_453_19.name == "split_6" or not string.find(var_453_19.name, "split") then
						var_453_19.gameObject:SetActive(true)
					else
						var_453_19.gameObject:SetActive(false)
					end
				end
			end

			local var_453_20 = 0.001

			if var_453_17 <= arg_450_1.time_ and arg_450_1.time_ < var_453_17 + var_453_20 then
				local var_453_21 = (arg_450_1.time_ - var_453_17) / var_453_20
				local var_453_22 = Vector3.New(373.7, -331.9, -324)

				var_453_16.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1034, var_453_22, var_453_21)
			end

			if arg_450_1.time_ >= var_453_17 + var_453_20 and arg_450_1.time_ < var_453_17 + var_453_20 + arg_453_0 then
				var_453_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_453_23 = 0
			local var_453_24 = 0.4

			if var_453_23 < arg_450_1.time_ and arg_450_1.time_ <= var_453_23 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_25 = arg_450_1:FormatText(StoryNameCfg[1109].name)

				arg_450_1.leftNameTxt_.text = var_453_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_26 = arg_450_1:GetWordFromCfg(417031107)
				local var_453_27 = arg_450_1:FormatText(var_453_26.content)

				arg_450_1.text_.text = var_453_27

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_28 = 16
				local var_453_29 = utf8.len(var_453_27)
				local var_453_30 = var_453_28 <= 0 and var_453_24 or var_453_24 * (var_453_29 / var_453_28)

				if var_453_30 > 0 and var_453_24 < var_453_30 then
					arg_450_1.talkMaxDuration = var_453_30

					if var_453_30 + var_453_23 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_30 + var_453_23
					end
				end

				arg_450_1.text_.text = var_453_27
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031107", "story_v_out_417031.awb") ~= 0 then
					local var_453_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031107", "story_v_out_417031.awb") / 1000

					if var_453_31 + var_453_23 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_31 + var_453_23
					end

					if var_453_26.prefab_name ~= "" and arg_450_1.actors_[var_453_26.prefab_name] ~= nil then
						local var_453_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_26.prefab_name].transform, "story_v_out_417031", "417031107", "story_v_out_417031.awb")

						arg_450_1:RecordAudio("417031107", var_453_32)
						arg_450_1:RecordAudio("417031107", var_453_32)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_417031", "417031107", "story_v_out_417031.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_417031", "417031107", "story_v_out_417031.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_33 = math.max(var_453_24, arg_450_1.talkMaxDuration)

			if var_453_23 <= arg_450_1.time_ and arg_450_1.time_ < var_453_23 + var_453_33 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_23) / var_453_33

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_23 + var_453_33 and arg_450_1.time_ < var_453_23 + var_453_33 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
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

		arg_450_1:InitPlayNodeList()
	end,
	Play417031108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 417031108
		arg_454_1.duration_ = 8.4

		local var_454_0 = {
			zh = 5.233,
			ja = 8.4
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play417031109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1060"].transform
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.var_.moveOldPos1060 = var_457_0.localPosition
				var_457_0.localScale = Vector3.New(1, 1, 1)

				arg_454_1:CheckSpriteTmpPos("1060", 2)

				local var_457_2 = var_457_0.childCount

				for iter_457_0 = 0, var_457_2 - 1 do
					local var_457_3 = var_457_0:GetChild(iter_457_0)

					if var_457_3.name == "split_1" or not string.find(var_457_3.name, "split") then
						var_457_3.gameObject:SetActive(true)
					else
						var_457_3.gameObject:SetActive(false)
					end
				end
			end

			local var_457_4 = 0.001

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_4 then
				local var_457_5 = (arg_454_1.time_ - var_457_1) / var_457_4
				local var_457_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_457_0.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1060, var_457_6, var_457_5)
			end

			if arg_454_1.time_ >= var_457_1 + var_457_4 and arg_454_1.time_ < var_457_1 + var_457_4 + arg_457_0 then
				var_457_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_457_7 = 0
			local var_457_8 = 0.65

			if var_457_7 < arg_454_1.time_ and arg_454_1.time_ <= var_457_7 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_9 = arg_454_1:FormatText(StoryNameCfg[1109].name)

				arg_454_1.leftNameTxt_.text = var_457_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_10 = arg_454_1:GetWordFromCfg(417031108)
				local var_457_11 = arg_454_1:FormatText(var_457_10.content)

				arg_454_1.text_.text = var_457_11

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_12 = 26
				local var_457_13 = utf8.len(var_457_11)
				local var_457_14 = var_457_12 <= 0 and var_457_8 or var_457_8 * (var_457_13 / var_457_12)

				if var_457_14 > 0 and var_457_8 < var_457_14 then
					arg_454_1.talkMaxDuration = var_457_14

					if var_457_14 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_14 + var_457_7
					end
				end

				arg_454_1.text_.text = var_457_11
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031108", "story_v_out_417031.awb") ~= 0 then
					local var_457_15 = manager.audio:GetVoiceLength("story_v_out_417031", "417031108", "story_v_out_417031.awb") / 1000

					if var_457_15 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_15 + var_457_7
					end

					if var_457_10.prefab_name ~= "" and arg_454_1.actors_[var_457_10.prefab_name] ~= nil then
						local var_457_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_10.prefab_name].transform, "story_v_out_417031", "417031108", "story_v_out_417031.awb")

						arg_454_1:RecordAudio("417031108", var_457_16)
						arg_454_1:RecordAudio("417031108", var_457_16)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_417031", "417031108", "story_v_out_417031.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_417031", "417031108", "story_v_out_417031.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_17 = math.max(var_457_8, arg_454_1.talkMaxDuration)

			if var_457_7 <= arg_454_1.time_ and arg_454_1.time_ < var_457_7 + var_457_17 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_7) / var_457_17

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_7 + var_457_17 and arg_454_1.time_ < var_457_7 + var_457_17 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play417031109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 417031109
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play417031110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1034"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps1034 == nil then
				arg_458_1.var_.actorSpriteComps1034 = var_461_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_461_2 = 0.2

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.actorSpriteComps1034 then
					for iter_461_0, iter_461_1 in pairs(arg_458_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_461_1 then
							if arg_458_1.isInRecall_ then
								local var_461_4 = Mathf.Lerp(iter_461_1.color.r, arg_458_1.hightColor2.r, var_461_3)
								local var_461_5 = Mathf.Lerp(iter_461_1.color.g, arg_458_1.hightColor2.g, var_461_3)
								local var_461_6 = Mathf.Lerp(iter_461_1.color.b, arg_458_1.hightColor2.b, var_461_3)

								iter_461_1.color = Color.New(var_461_4, var_461_5, var_461_6)
							else
								local var_461_7 = Mathf.Lerp(iter_461_1.color.r, 0.5, var_461_3)

								iter_461_1.color = Color.New(var_461_7, var_461_7, var_461_7)
							end
						end
					end
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps1034 then
				for iter_461_2, iter_461_3 in pairs(arg_458_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_461_3 then
						if arg_458_1.isInRecall_ then
							iter_461_3.color = arg_458_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_461_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_458_1.var_.actorSpriteComps1034 = nil
			end

			local var_461_8 = arg_458_1.actors_["1034"].transform
			local var_461_9 = 0

			if var_461_9 < arg_458_1.time_ and arg_458_1.time_ <= var_461_9 + arg_461_0 then
				arg_458_1.var_.moveOldPos1034 = var_461_8.localPosition
				var_461_8.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1034", 7)

				local var_461_10 = var_461_8.childCount

				for iter_461_4 = 0, var_461_10 - 1 do
					local var_461_11 = var_461_8:GetChild(iter_461_4)

					if var_461_11.name == "" or not string.find(var_461_11.name, "split") then
						var_461_11.gameObject:SetActive(true)
					else
						var_461_11.gameObject:SetActive(false)
					end
				end
			end

			local var_461_12 = 0.001

			if var_461_9 <= arg_458_1.time_ and arg_458_1.time_ < var_461_9 + var_461_12 then
				local var_461_13 = (arg_458_1.time_ - var_461_9) / var_461_12
				local var_461_14 = Vector3.New(0, -2000, 0)

				var_461_8.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1034, var_461_14, var_461_13)
			end

			if arg_458_1.time_ >= var_461_9 + var_461_12 and arg_458_1.time_ < var_461_9 + var_461_12 + arg_461_0 then
				var_461_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_461_15 = arg_458_1.actors_["1060"].transform
			local var_461_16 = 0

			if var_461_16 < arg_458_1.time_ and arg_458_1.time_ <= var_461_16 + arg_461_0 then
				arg_458_1.var_.moveOldPos1060 = var_461_15.localPosition
				var_461_15.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1060", 7)

				local var_461_17 = var_461_15.childCount

				for iter_461_5 = 0, var_461_17 - 1 do
					local var_461_18 = var_461_15:GetChild(iter_461_5)

					if var_461_18.name == "split_1" or not string.find(var_461_18.name, "split") then
						var_461_18.gameObject:SetActive(true)
					else
						var_461_18.gameObject:SetActive(false)
					end
				end
			end

			local var_461_19 = 0.001

			if var_461_16 <= arg_458_1.time_ and arg_458_1.time_ < var_461_16 + var_461_19 then
				local var_461_20 = (arg_458_1.time_ - var_461_16) / var_461_19
				local var_461_21 = Vector3.New(0, -2000, -40)

				var_461_15.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1060, var_461_21, var_461_20)
			end

			if arg_458_1.time_ >= var_461_16 + var_461_19 and arg_458_1.time_ < var_461_16 + var_461_19 + arg_461_0 then
				var_461_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_461_22 = 0
			local var_461_23 = 1.225

			if var_461_22 < arg_458_1.time_ and arg_458_1.time_ <= var_461_22 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_24 = arg_458_1:GetWordFromCfg(417031109)
				local var_461_25 = arg_458_1:FormatText(var_461_24.content)

				arg_458_1.text_.text = var_461_25

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_26 = 49
				local var_461_27 = utf8.len(var_461_25)
				local var_461_28 = var_461_26 <= 0 and var_461_23 or var_461_23 * (var_461_27 / var_461_26)

				if var_461_28 > 0 and var_461_23 < var_461_28 then
					arg_458_1.talkMaxDuration = var_461_28

					if var_461_28 + var_461_22 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_28 + var_461_22
					end
				end

				arg_458_1.text_.text = var_461_25
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_29 = math.max(var_461_23, arg_458_1.talkMaxDuration)

			if var_461_22 <= arg_458_1.time_ and arg_458_1.time_ < var_461_22 + var_461_29 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_22) / var_461_29

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_22 + var_461_29 and arg_458_1.time_ < var_461_22 + var_461_29 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play417031110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 417031110
		arg_462_1.duration_ = 6.53

		local var_462_0 = {
			zh = 5.566,
			ja = 6.533
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play417031111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1034"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps1034 == nil then
				arg_462_1.var_.actorSpriteComps1034 = var_465_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_2 = 0.2

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.actorSpriteComps1034 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								local var_465_4 = Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor1.r, var_465_3)
								local var_465_5 = Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor1.g, var_465_3)
								local var_465_6 = Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor1.b, var_465_3)

								iter_465_1.color = Color.New(var_465_4, var_465_5, var_465_6)
							else
								local var_465_7 = Mathf.Lerp(iter_465_1.color.r, 1, var_465_3)

								iter_465_1.color = Color.New(var_465_7, var_465_7, var_465_7)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps1034 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_465_3 then
						if arg_462_1.isInRecall_ then
							iter_465_3.color = arg_462_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_465_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_462_1.var_.actorSpriteComps1034 = nil
			end

			local var_465_8 = arg_462_1.actors_["1034"].transform
			local var_465_9 = 0

			if var_465_9 < arg_462_1.time_ and arg_462_1.time_ <= var_465_9 + arg_465_0 then
				arg_462_1.var_.moveOldPos1034 = var_465_8.localPosition
				var_465_8.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("1034", 4)

				local var_465_10 = var_465_8.childCount

				for iter_465_4 = 0, var_465_10 - 1 do
					local var_465_11 = var_465_8:GetChild(iter_465_4)

					if var_465_11.name == "split_6" or not string.find(var_465_11.name, "split") then
						var_465_11.gameObject:SetActive(true)
					else
						var_465_11.gameObject:SetActive(false)
					end
				end
			end

			local var_465_12 = 0.001

			if var_465_9 <= arg_462_1.time_ and arg_462_1.time_ < var_465_9 + var_465_12 then
				local var_465_13 = (arg_462_1.time_ - var_465_9) / var_465_12
				local var_465_14 = Vector3.New(373.7, -331.9, -324)

				var_465_8.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1034, var_465_14, var_465_13)
			end

			if arg_462_1.time_ >= var_465_9 + var_465_12 and arg_462_1.time_ < var_465_9 + var_465_12 + arg_465_0 then
				var_465_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_465_15 = 0
			local var_465_16 = 0.5

			if var_465_15 < arg_462_1.time_ and arg_462_1.time_ <= var_465_15 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_17 = arg_462_1:FormatText(StoryNameCfg[1109].name)

				arg_462_1.leftNameTxt_.text = var_465_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_18 = arg_462_1:GetWordFromCfg(417031110)
				local var_465_19 = arg_462_1:FormatText(var_465_18.content)

				arg_462_1.text_.text = var_465_19

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_20 = 20
				local var_465_21 = utf8.len(var_465_19)
				local var_465_22 = var_465_20 <= 0 and var_465_16 or var_465_16 * (var_465_21 / var_465_20)

				if var_465_22 > 0 and var_465_16 < var_465_22 then
					arg_462_1.talkMaxDuration = var_465_22

					if var_465_22 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_22 + var_465_15
					end
				end

				arg_462_1.text_.text = var_465_19
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031110", "story_v_out_417031.awb") ~= 0 then
					local var_465_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031110", "story_v_out_417031.awb") / 1000

					if var_465_23 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_23 + var_465_15
					end

					if var_465_18.prefab_name ~= "" and arg_462_1.actors_[var_465_18.prefab_name] ~= nil then
						local var_465_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_18.prefab_name].transform, "story_v_out_417031", "417031110", "story_v_out_417031.awb")

						arg_462_1:RecordAudio("417031110", var_465_24)
						arg_462_1:RecordAudio("417031110", var_465_24)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_417031", "417031110", "story_v_out_417031.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_417031", "417031110", "story_v_out_417031.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_25 = math.max(var_465_16, arg_462_1.talkMaxDuration)

			if var_465_15 <= arg_462_1.time_ and arg_462_1.time_ < var_465_15 + var_465_25 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_15) / var_465_25

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_15 + var_465_25 and arg_462_1.time_ < var_465_15 + var_465_25 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	Play417031111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 417031111
		arg_466_1.duration_ = 5.6

		local var_466_0 = {
			zh = 5.233,
			ja = 5.6
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play417031112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1060"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps1060 == nil then
				arg_466_1.var_.actorSpriteComps1060 = var_469_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_2 = 0.2

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.actorSpriteComps1060 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_469_1 then
							if arg_466_1.isInRecall_ then
								local var_469_4 = Mathf.Lerp(iter_469_1.color.r, arg_466_1.hightColor1.r, var_469_3)
								local var_469_5 = Mathf.Lerp(iter_469_1.color.g, arg_466_1.hightColor1.g, var_469_3)
								local var_469_6 = Mathf.Lerp(iter_469_1.color.b, arg_466_1.hightColor1.b, var_469_3)

								iter_469_1.color = Color.New(var_469_4, var_469_5, var_469_6)
							else
								local var_469_7 = Mathf.Lerp(iter_469_1.color.r, 1, var_469_3)

								iter_469_1.color = Color.New(var_469_7, var_469_7, var_469_7)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps1060 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_469_3 then
						if arg_466_1.isInRecall_ then
							iter_469_3.color = arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_469_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_466_1.var_.actorSpriteComps1060 = nil
			end

			local var_469_8 = arg_466_1.actors_["1034"]
			local var_469_9 = 0

			if var_469_9 < arg_466_1.time_ and arg_466_1.time_ <= var_469_9 + arg_469_0 and not isNil(var_469_8) and arg_466_1.var_.actorSpriteComps1034 == nil then
				arg_466_1.var_.actorSpriteComps1034 = var_469_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_10 = 0.2

			if var_469_9 <= arg_466_1.time_ and arg_466_1.time_ < var_469_9 + var_469_10 and not isNil(var_469_8) then
				local var_469_11 = (arg_466_1.time_ - var_469_9) / var_469_10

				if arg_466_1.var_.actorSpriteComps1034 then
					for iter_469_4, iter_469_5 in pairs(arg_466_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_469_5 then
							if arg_466_1.isInRecall_ then
								local var_469_12 = Mathf.Lerp(iter_469_5.color.r, arg_466_1.hightColor2.r, var_469_11)
								local var_469_13 = Mathf.Lerp(iter_469_5.color.g, arg_466_1.hightColor2.g, var_469_11)
								local var_469_14 = Mathf.Lerp(iter_469_5.color.b, arg_466_1.hightColor2.b, var_469_11)

								iter_469_5.color = Color.New(var_469_12, var_469_13, var_469_14)
							else
								local var_469_15 = Mathf.Lerp(iter_469_5.color.r, 0.5, var_469_11)

								iter_469_5.color = Color.New(var_469_15, var_469_15, var_469_15)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= var_469_9 + var_469_10 and arg_466_1.time_ < var_469_9 + var_469_10 + arg_469_0 and not isNil(var_469_8) and arg_466_1.var_.actorSpriteComps1034 then
				for iter_469_6, iter_469_7 in pairs(arg_466_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_469_7 then
						if arg_466_1.isInRecall_ then
							iter_469_7.color = arg_466_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_469_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_466_1.var_.actorSpriteComps1034 = nil
			end

			local var_469_16 = arg_466_1.actors_["1060"].transform
			local var_469_17 = 0

			if var_469_17 < arg_466_1.time_ and arg_466_1.time_ <= var_469_17 + arg_469_0 then
				arg_466_1.var_.moveOldPos1060 = var_469_16.localPosition
				var_469_16.localScale = Vector3.New(1, 1, 1)

				arg_466_1:CheckSpriteTmpPos("1060", 2)

				local var_469_18 = var_469_16.childCount

				for iter_469_8 = 0, var_469_18 - 1 do
					local var_469_19 = var_469_16:GetChild(iter_469_8)

					if var_469_19.name == "split_1" or not string.find(var_469_19.name, "split") then
						var_469_19.gameObject:SetActive(true)
					else
						var_469_19.gameObject:SetActive(false)
					end
				end
			end

			local var_469_20 = 0.001

			if var_469_17 <= arg_466_1.time_ and arg_466_1.time_ < var_469_17 + var_469_20 then
				local var_469_21 = (arg_466_1.time_ - var_469_17) / var_469_20
				local var_469_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_469_16.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1060, var_469_22, var_469_21)
			end

			if arg_466_1.time_ >= var_469_17 + var_469_20 and arg_466_1.time_ < var_469_17 + var_469_20 + arg_469_0 then
				var_469_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_469_23 = 0
			local var_469_24 = 0.575

			if var_469_23 < arg_466_1.time_ and arg_466_1.time_ <= var_469_23 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_25 = arg_466_1:FormatText(StoryNameCfg[584].name)

				arg_466_1.leftNameTxt_.text = var_469_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_26 = arg_466_1:GetWordFromCfg(417031111)
				local var_469_27 = arg_466_1:FormatText(var_469_26.content)

				arg_466_1.text_.text = var_469_27

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_28 = 23
				local var_469_29 = utf8.len(var_469_27)
				local var_469_30 = var_469_28 <= 0 and var_469_24 or var_469_24 * (var_469_29 / var_469_28)

				if var_469_30 > 0 and var_469_24 < var_469_30 then
					arg_466_1.talkMaxDuration = var_469_30

					if var_469_30 + var_469_23 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_30 + var_469_23
					end
				end

				arg_466_1.text_.text = var_469_27
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031111", "story_v_out_417031.awb") ~= 0 then
					local var_469_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031111", "story_v_out_417031.awb") / 1000

					if var_469_31 + var_469_23 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_31 + var_469_23
					end

					if var_469_26.prefab_name ~= "" and arg_466_1.actors_[var_469_26.prefab_name] ~= nil then
						local var_469_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_26.prefab_name].transform, "story_v_out_417031", "417031111", "story_v_out_417031.awb")

						arg_466_1:RecordAudio("417031111", var_469_32)
						arg_466_1:RecordAudio("417031111", var_469_32)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_417031", "417031111", "story_v_out_417031.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_417031", "417031111", "story_v_out_417031.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_33 = math.max(var_469_24, arg_466_1.talkMaxDuration)

			if var_469_23 <= arg_466_1.time_ and arg_466_1.time_ < var_469_23 + var_469_33 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_23) / var_469_33

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_23 + var_469_33 and arg_466_1.time_ < var_469_23 + var_469_33 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play417031112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 417031112
		arg_470_1.duration_ = 12.97

		local var_470_0 = {
			zh = 9.366,
			ja = 12.966
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play417031113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1034"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.actorSpriteComps1034 == nil then
				arg_470_1.var_.actorSpriteComps1034 = var_473_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_473_2 = 0.2

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.actorSpriteComps1034 then
					for iter_473_0, iter_473_1 in pairs(arg_470_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_473_1 then
							if arg_470_1.isInRecall_ then
								local var_473_4 = Mathf.Lerp(iter_473_1.color.r, arg_470_1.hightColor1.r, var_473_3)
								local var_473_5 = Mathf.Lerp(iter_473_1.color.g, arg_470_1.hightColor1.g, var_473_3)
								local var_473_6 = Mathf.Lerp(iter_473_1.color.b, arg_470_1.hightColor1.b, var_473_3)

								iter_473_1.color = Color.New(var_473_4, var_473_5, var_473_6)
							else
								local var_473_7 = Mathf.Lerp(iter_473_1.color.r, 1, var_473_3)

								iter_473_1.color = Color.New(var_473_7, var_473_7, var_473_7)
							end
						end
					end
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.actorSpriteComps1034 then
				for iter_473_2, iter_473_3 in pairs(arg_470_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_473_3 then
						if arg_470_1.isInRecall_ then
							iter_473_3.color = arg_470_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_473_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_470_1.var_.actorSpriteComps1034 = nil
			end

			local var_473_8 = arg_470_1.actors_["1060"]
			local var_473_9 = 0

			if var_473_9 < arg_470_1.time_ and arg_470_1.time_ <= var_473_9 + arg_473_0 and not isNil(var_473_8) and arg_470_1.var_.actorSpriteComps1060 == nil then
				arg_470_1.var_.actorSpriteComps1060 = var_473_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_473_10 = 0.2

			if var_473_9 <= arg_470_1.time_ and arg_470_1.time_ < var_473_9 + var_473_10 and not isNil(var_473_8) then
				local var_473_11 = (arg_470_1.time_ - var_473_9) / var_473_10

				if arg_470_1.var_.actorSpriteComps1060 then
					for iter_473_4, iter_473_5 in pairs(arg_470_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_473_5 then
							if arg_470_1.isInRecall_ then
								local var_473_12 = Mathf.Lerp(iter_473_5.color.r, arg_470_1.hightColor2.r, var_473_11)
								local var_473_13 = Mathf.Lerp(iter_473_5.color.g, arg_470_1.hightColor2.g, var_473_11)
								local var_473_14 = Mathf.Lerp(iter_473_5.color.b, arg_470_1.hightColor2.b, var_473_11)

								iter_473_5.color = Color.New(var_473_12, var_473_13, var_473_14)
							else
								local var_473_15 = Mathf.Lerp(iter_473_5.color.r, 0.5, var_473_11)

								iter_473_5.color = Color.New(var_473_15, var_473_15, var_473_15)
							end
						end
					end
				end
			end

			if arg_470_1.time_ >= var_473_9 + var_473_10 and arg_470_1.time_ < var_473_9 + var_473_10 + arg_473_0 and not isNil(var_473_8) and arg_470_1.var_.actorSpriteComps1060 then
				for iter_473_6, iter_473_7 in pairs(arg_470_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_473_7 then
						if arg_470_1.isInRecall_ then
							iter_473_7.color = arg_470_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_473_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_470_1.var_.actorSpriteComps1060 = nil
			end

			local var_473_16 = 0
			local var_473_17 = 1.075

			if var_473_16 < arg_470_1.time_ and arg_470_1.time_ <= var_473_16 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_18 = arg_470_1:FormatText(StoryNameCfg[1109].name)

				arg_470_1.leftNameTxt_.text = var_473_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_19 = arg_470_1:GetWordFromCfg(417031112)
				local var_473_20 = arg_470_1:FormatText(var_473_19.content)

				arg_470_1.text_.text = var_473_20

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_21 = 43
				local var_473_22 = utf8.len(var_473_20)
				local var_473_23 = var_473_21 <= 0 and var_473_17 or var_473_17 * (var_473_22 / var_473_21)

				if var_473_23 > 0 and var_473_17 < var_473_23 then
					arg_470_1.talkMaxDuration = var_473_23

					if var_473_23 + var_473_16 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_23 + var_473_16
					end
				end

				arg_470_1.text_.text = var_473_20
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031112", "story_v_out_417031.awb") ~= 0 then
					local var_473_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031112", "story_v_out_417031.awb") / 1000

					if var_473_24 + var_473_16 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_24 + var_473_16
					end

					if var_473_19.prefab_name ~= "" and arg_470_1.actors_[var_473_19.prefab_name] ~= nil then
						local var_473_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_19.prefab_name].transform, "story_v_out_417031", "417031112", "story_v_out_417031.awb")

						arg_470_1:RecordAudio("417031112", var_473_25)
						arg_470_1:RecordAudio("417031112", var_473_25)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_417031", "417031112", "story_v_out_417031.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_417031", "417031112", "story_v_out_417031.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_26 = math.max(var_473_17, arg_470_1.talkMaxDuration)

			if var_473_16 <= arg_470_1.time_ and arg_470_1.time_ < var_473_16 + var_473_26 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_16) / var_473_26

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_16 + var_473_26 and arg_470_1.time_ < var_473_16 + var_473_26 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play417031113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 417031113
		arg_474_1.duration_ = 7.27

		local var_474_0 = {
			zh = 2.8,
			ja = 7.266
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play417031114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1060"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.actorSpriteComps1060 == nil then
				arg_474_1.var_.actorSpriteComps1060 = var_477_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_477_2 = 0.2

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.actorSpriteComps1060 then
					for iter_477_0, iter_477_1 in pairs(arg_474_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_477_1 then
							if arg_474_1.isInRecall_ then
								local var_477_4 = Mathf.Lerp(iter_477_1.color.r, arg_474_1.hightColor1.r, var_477_3)
								local var_477_5 = Mathf.Lerp(iter_477_1.color.g, arg_474_1.hightColor1.g, var_477_3)
								local var_477_6 = Mathf.Lerp(iter_477_1.color.b, arg_474_1.hightColor1.b, var_477_3)

								iter_477_1.color = Color.New(var_477_4, var_477_5, var_477_6)
							else
								local var_477_7 = Mathf.Lerp(iter_477_1.color.r, 1, var_477_3)

								iter_477_1.color = Color.New(var_477_7, var_477_7, var_477_7)
							end
						end
					end
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.actorSpriteComps1060 then
				for iter_477_2, iter_477_3 in pairs(arg_474_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_477_3 then
						if arg_474_1.isInRecall_ then
							iter_477_3.color = arg_474_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_477_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_474_1.var_.actorSpriteComps1060 = nil
			end

			local var_477_8 = arg_474_1.actors_["1034"]
			local var_477_9 = 0

			if var_477_9 < arg_474_1.time_ and arg_474_1.time_ <= var_477_9 + arg_477_0 and not isNil(var_477_8) and arg_474_1.var_.actorSpriteComps1034 == nil then
				arg_474_1.var_.actorSpriteComps1034 = var_477_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_477_10 = 0.2

			if var_477_9 <= arg_474_1.time_ and arg_474_1.time_ < var_477_9 + var_477_10 and not isNil(var_477_8) then
				local var_477_11 = (arg_474_1.time_ - var_477_9) / var_477_10

				if arg_474_1.var_.actorSpriteComps1034 then
					for iter_477_4, iter_477_5 in pairs(arg_474_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_477_5 then
							if arg_474_1.isInRecall_ then
								local var_477_12 = Mathf.Lerp(iter_477_5.color.r, arg_474_1.hightColor2.r, var_477_11)
								local var_477_13 = Mathf.Lerp(iter_477_5.color.g, arg_474_1.hightColor2.g, var_477_11)
								local var_477_14 = Mathf.Lerp(iter_477_5.color.b, arg_474_1.hightColor2.b, var_477_11)

								iter_477_5.color = Color.New(var_477_12, var_477_13, var_477_14)
							else
								local var_477_15 = Mathf.Lerp(iter_477_5.color.r, 0.5, var_477_11)

								iter_477_5.color = Color.New(var_477_15, var_477_15, var_477_15)
							end
						end
					end
				end
			end

			if arg_474_1.time_ >= var_477_9 + var_477_10 and arg_474_1.time_ < var_477_9 + var_477_10 + arg_477_0 and not isNil(var_477_8) and arg_474_1.var_.actorSpriteComps1034 then
				for iter_477_6, iter_477_7 in pairs(arg_474_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_477_7 then
						if arg_474_1.isInRecall_ then
							iter_477_7.color = arg_474_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_477_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_474_1.var_.actorSpriteComps1034 = nil
			end

			local var_477_16 = arg_474_1.actors_["1060"].transform
			local var_477_17 = 0

			if var_477_17 < arg_474_1.time_ and arg_474_1.time_ <= var_477_17 + arg_477_0 then
				arg_474_1.var_.moveOldPos1060 = var_477_16.localPosition
				var_477_16.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("1060", 2)

				local var_477_18 = var_477_16.childCount

				for iter_477_8 = 0, var_477_18 - 1 do
					local var_477_19 = var_477_16:GetChild(iter_477_8)

					if var_477_19.name == "" or not string.find(var_477_19.name, "split") then
						var_477_19.gameObject:SetActive(true)
					else
						var_477_19.gameObject:SetActive(false)
					end
				end
			end

			local var_477_20 = 0.001

			if var_477_17 <= arg_474_1.time_ and arg_474_1.time_ < var_477_17 + var_477_20 then
				local var_477_21 = (arg_474_1.time_ - var_477_17) / var_477_20
				local var_477_22 = Vector3.New(-440.94, -430.8, 6.9)

				var_477_16.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1060, var_477_22, var_477_21)
			end

			if arg_474_1.time_ >= var_477_17 + var_477_20 and arg_474_1.time_ < var_477_17 + var_477_20 + arg_477_0 then
				var_477_16.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_477_23 = 0
			local var_477_24 = 0.375

			if var_477_23 < arg_474_1.time_ and arg_474_1.time_ <= var_477_23 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_25 = arg_474_1:FormatText(StoryNameCfg[584].name)

				arg_474_1.leftNameTxt_.text = var_477_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_26 = arg_474_1:GetWordFromCfg(417031113)
				local var_477_27 = arg_474_1:FormatText(var_477_26.content)

				arg_474_1.text_.text = var_477_27

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_28 = 15
				local var_477_29 = utf8.len(var_477_27)
				local var_477_30 = var_477_28 <= 0 and var_477_24 or var_477_24 * (var_477_29 / var_477_28)

				if var_477_30 > 0 and var_477_24 < var_477_30 then
					arg_474_1.talkMaxDuration = var_477_30

					if var_477_30 + var_477_23 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_30 + var_477_23
					end
				end

				arg_474_1.text_.text = var_477_27
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031113", "story_v_out_417031.awb") ~= 0 then
					local var_477_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031113", "story_v_out_417031.awb") / 1000

					if var_477_31 + var_477_23 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_31 + var_477_23
					end

					if var_477_26.prefab_name ~= "" and arg_474_1.actors_[var_477_26.prefab_name] ~= nil then
						local var_477_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_26.prefab_name].transform, "story_v_out_417031", "417031113", "story_v_out_417031.awb")

						arg_474_1:RecordAudio("417031113", var_477_32)
						arg_474_1:RecordAudio("417031113", var_477_32)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_417031", "417031113", "story_v_out_417031.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_417031", "417031113", "story_v_out_417031.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_33 = math.max(var_477_24, arg_474_1.talkMaxDuration)

			if var_477_23 <= arg_474_1.time_ and arg_474_1.time_ < var_477_23 + var_477_33 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_23) / var_477_33

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_23 + var_477_33 and arg_474_1.time_ < var_477_23 + var_477_33 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play417031114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 417031114
		arg_478_1.duration_ = 2.8

		local var_478_0 = {
			zh = 2.8,
			ja = 1.733
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play417031115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1034"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.actorSpriteComps1034 == nil then
				arg_478_1.var_.actorSpriteComps1034 = var_481_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_2 = 0.2

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.actorSpriteComps1034 then
					for iter_481_0, iter_481_1 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_481_1 then
							if arg_478_1.isInRecall_ then
								local var_481_4 = Mathf.Lerp(iter_481_1.color.r, arg_478_1.hightColor1.r, var_481_3)
								local var_481_5 = Mathf.Lerp(iter_481_1.color.g, arg_478_1.hightColor1.g, var_481_3)
								local var_481_6 = Mathf.Lerp(iter_481_1.color.b, arg_478_1.hightColor1.b, var_481_3)

								iter_481_1.color = Color.New(var_481_4, var_481_5, var_481_6)
							else
								local var_481_7 = Mathf.Lerp(iter_481_1.color.r, 1, var_481_3)

								iter_481_1.color = Color.New(var_481_7, var_481_7, var_481_7)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.actorSpriteComps1034 then
				for iter_481_2, iter_481_3 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_481_3 then
						if arg_478_1.isInRecall_ then
							iter_481_3.color = arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_481_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps1034 = nil
			end

			local var_481_8 = arg_478_1.actors_["1060"]
			local var_481_9 = 0

			if var_481_9 < arg_478_1.time_ and arg_478_1.time_ <= var_481_9 + arg_481_0 and not isNil(var_481_8) and arg_478_1.var_.actorSpriteComps1060 == nil then
				arg_478_1.var_.actorSpriteComps1060 = var_481_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_10 = 0.2

			if var_481_9 <= arg_478_1.time_ and arg_478_1.time_ < var_481_9 + var_481_10 and not isNil(var_481_8) then
				local var_481_11 = (arg_478_1.time_ - var_481_9) / var_481_10

				if arg_478_1.var_.actorSpriteComps1060 then
					for iter_481_4, iter_481_5 in pairs(arg_478_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_481_5 then
							if arg_478_1.isInRecall_ then
								local var_481_12 = Mathf.Lerp(iter_481_5.color.r, arg_478_1.hightColor2.r, var_481_11)
								local var_481_13 = Mathf.Lerp(iter_481_5.color.g, arg_478_1.hightColor2.g, var_481_11)
								local var_481_14 = Mathf.Lerp(iter_481_5.color.b, arg_478_1.hightColor2.b, var_481_11)

								iter_481_5.color = Color.New(var_481_12, var_481_13, var_481_14)
							else
								local var_481_15 = Mathf.Lerp(iter_481_5.color.r, 0.5, var_481_11)

								iter_481_5.color = Color.New(var_481_15, var_481_15, var_481_15)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= var_481_9 + var_481_10 and arg_478_1.time_ < var_481_9 + var_481_10 + arg_481_0 and not isNil(var_481_8) and arg_478_1.var_.actorSpriteComps1060 then
				for iter_481_6, iter_481_7 in pairs(arg_478_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_481_7 then
						if arg_478_1.isInRecall_ then
							iter_481_7.color = arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_481_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps1060 = nil
			end

			local var_481_16 = arg_478_1.actors_["1034"].transform
			local var_481_17 = 0

			if var_481_17 < arg_478_1.time_ and arg_478_1.time_ <= var_481_17 + arg_481_0 then
				arg_478_1.var_.moveOldPos1034 = var_481_16.localPosition
				var_481_16.localScale = Vector3.New(1, 1, 1)

				arg_478_1:CheckSpriteTmpPos("1034", 4)

				local var_481_18 = var_481_16.childCount

				for iter_481_8 = 0, var_481_18 - 1 do
					local var_481_19 = var_481_16:GetChild(iter_481_8)

					if var_481_19.name == "split_6" or not string.find(var_481_19.name, "split") then
						var_481_19.gameObject:SetActive(true)
					else
						var_481_19.gameObject:SetActive(false)
					end
				end
			end

			local var_481_20 = 0.001

			if var_481_17 <= arg_478_1.time_ and arg_478_1.time_ < var_481_17 + var_481_20 then
				local var_481_21 = (arg_478_1.time_ - var_481_17) / var_481_20
				local var_481_22 = Vector3.New(373.7, -331.9, -324)

				var_481_16.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1034, var_481_22, var_481_21)
			end

			if arg_478_1.time_ >= var_481_17 + var_481_20 and arg_478_1.time_ < var_481_17 + var_481_20 + arg_481_0 then
				var_481_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_481_23 = 0
			local var_481_24 = 0.2

			if var_481_23 < arg_478_1.time_ and arg_478_1.time_ <= var_481_23 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_25 = arg_478_1:FormatText(StoryNameCfg[1109].name)

				arg_478_1.leftNameTxt_.text = var_481_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_26 = arg_478_1:GetWordFromCfg(417031114)
				local var_481_27 = arg_478_1:FormatText(var_481_26.content)

				arg_478_1.text_.text = var_481_27

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_28 = 8
				local var_481_29 = utf8.len(var_481_27)
				local var_481_30 = var_481_28 <= 0 and var_481_24 or var_481_24 * (var_481_29 / var_481_28)

				if var_481_30 > 0 and var_481_24 < var_481_30 then
					arg_478_1.talkMaxDuration = var_481_30

					if var_481_30 + var_481_23 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_30 + var_481_23
					end
				end

				arg_478_1.text_.text = var_481_27
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031114", "story_v_out_417031.awb") ~= 0 then
					local var_481_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031114", "story_v_out_417031.awb") / 1000

					if var_481_31 + var_481_23 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_31 + var_481_23
					end

					if var_481_26.prefab_name ~= "" and arg_478_1.actors_[var_481_26.prefab_name] ~= nil then
						local var_481_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_26.prefab_name].transform, "story_v_out_417031", "417031114", "story_v_out_417031.awb")

						arg_478_1:RecordAudio("417031114", var_481_32)
						arg_478_1:RecordAudio("417031114", var_481_32)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_417031", "417031114", "story_v_out_417031.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_417031", "417031114", "story_v_out_417031.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_33 = math.max(var_481_24, arg_478_1.talkMaxDuration)

			if var_481_23 <= arg_478_1.time_ and arg_478_1.time_ < var_481_23 + var_481_33 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_23) / var_481_33

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_23 + var_481_33 and arg_478_1.time_ < var_481_23 + var_481_33 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
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

		arg_478_1:InitPlayNodeList()
	end,
	Play417031115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 417031115
		arg_482_1.duration_ = 5.1

		local var_482_0 = {
			zh = 2.7,
			ja = 5.1
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play417031116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.325

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1109].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(417031115)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 13
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031115", "story_v_out_417031.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031115", "story_v_out_417031.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_417031", "417031115", "story_v_out_417031.awb")

						arg_482_1:RecordAudio("417031115", var_485_9)
						arg_482_1:RecordAudio("417031115", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_417031", "417031115", "story_v_out_417031.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_417031", "417031115", "story_v_out_417031.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play417031116 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 417031116
		arg_486_1.duration_ = 6.83

		local var_486_0 = {
			zh = 3.533,
			ja = 6.833
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play417031117(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1060"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps1060 == nil then
				arg_486_1.var_.actorSpriteComps1060 = var_489_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_2 = 0.2

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.actorSpriteComps1060 then
					for iter_489_0, iter_489_1 in pairs(arg_486_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_489_1 then
							if arg_486_1.isInRecall_ then
								local var_489_4 = Mathf.Lerp(iter_489_1.color.r, arg_486_1.hightColor1.r, var_489_3)
								local var_489_5 = Mathf.Lerp(iter_489_1.color.g, arg_486_1.hightColor1.g, var_489_3)
								local var_489_6 = Mathf.Lerp(iter_489_1.color.b, arg_486_1.hightColor1.b, var_489_3)

								iter_489_1.color = Color.New(var_489_4, var_489_5, var_489_6)
							else
								local var_489_7 = Mathf.Lerp(iter_489_1.color.r, 1, var_489_3)

								iter_489_1.color = Color.New(var_489_7, var_489_7, var_489_7)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps1060 then
				for iter_489_2, iter_489_3 in pairs(arg_486_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_489_3 then
						if arg_486_1.isInRecall_ then
							iter_489_3.color = arg_486_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_489_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_486_1.var_.actorSpriteComps1060 = nil
			end

			local var_489_8 = arg_486_1.actors_["1034"]
			local var_489_9 = 0

			if var_489_9 < arg_486_1.time_ and arg_486_1.time_ <= var_489_9 + arg_489_0 and not isNil(var_489_8) and arg_486_1.var_.actorSpriteComps1034 == nil then
				arg_486_1.var_.actorSpriteComps1034 = var_489_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_10 = 0.2

			if var_489_9 <= arg_486_1.time_ and arg_486_1.time_ < var_489_9 + var_489_10 and not isNil(var_489_8) then
				local var_489_11 = (arg_486_1.time_ - var_489_9) / var_489_10

				if arg_486_1.var_.actorSpriteComps1034 then
					for iter_489_4, iter_489_5 in pairs(arg_486_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_489_5 then
							if arg_486_1.isInRecall_ then
								local var_489_12 = Mathf.Lerp(iter_489_5.color.r, arg_486_1.hightColor2.r, var_489_11)
								local var_489_13 = Mathf.Lerp(iter_489_5.color.g, arg_486_1.hightColor2.g, var_489_11)
								local var_489_14 = Mathf.Lerp(iter_489_5.color.b, arg_486_1.hightColor2.b, var_489_11)

								iter_489_5.color = Color.New(var_489_12, var_489_13, var_489_14)
							else
								local var_489_15 = Mathf.Lerp(iter_489_5.color.r, 0.5, var_489_11)

								iter_489_5.color = Color.New(var_489_15, var_489_15, var_489_15)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= var_489_9 + var_489_10 and arg_486_1.time_ < var_489_9 + var_489_10 + arg_489_0 and not isNil(var_489_8) and arg_486_1.var_.actorSpriteComps1034 then
				for iter_489_6, iter_489_7 in pairs(arg_486_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_489_7 then
						if arg_486_1.isInRecall_ then
							iter_489_7.color = arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_489_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_486_1.var_.actorSpriteComps1034 = nil
			end

			local var_489_16 = 0
			local var_489_17 = 0.375

			if var_489_16 < arg_486_1.time_ and arg_486_1.time_ <= var_489_16 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_18 = arg_486_1:FormatText(StoryNameCfg[584].name)

				arg_486_1.leftNameTxt_.text = var_489_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_19 = arg_486_1:GetWordFromCfg(417031116)
				local var_489_20 = arg_486_1:FormatText(var_489_19.content)

				arg_486_1.text_.text = var_489_20

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_21 = 15
				local var_489_22 = utf8.len(var_489_20)
				local var_489_23 = var_489_21 <= 0 and var_489_17 or var_489_17 * (var_489_22 / var_489_21)

				if var_489_23 > 0 and var_489_17 < var_489_23 then
					arg_486_1.talkMaxDuration = var_489_23

					if var_489_23 + var_489_16 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_23 + var_489_16
					end
				end

				arg_486_1.text_.text = var_489_20
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031116", "story_v_out_417031.awb") ~= 0 then
					local var_489_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031116", "story_v_out_417031.awb") / 1000

					if var_489_24 + var_489_16 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_24 + var_489_16
					end

					if var_489_19.prefab_name ~= "" and arg_486_1.actors_[var_489_19.prefab_name] ~= nil then
						local var_489_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_19.prefab_name].transform, "story_v_out_417031", "417031116", "story_v_out_417031.awb")

						arg_486_1:RecordAudio("417031116", var_489_25)
						arg_486_1:RecordAudio("417031116", var_489_25)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_417031", "417031116", "story_v_out_417031.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_417031", "417031116", "story_v_out_417031.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_26 = math.max(var_489_17, arg_486_1.talkMaxDuration)

			if var_489_16 <= arg_486_1.time_ and arg_486_1.time_ < var_489_16 + var_489_26 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_16) / var_489_26

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_16 + var_489_26 and arg_486_1.time_ < var_489_16 + var_489_26 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play417031117 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 417031117
		arg_490_1.duration_ = 4.3

		local var_490_0 = {
			zh = 1.3,
			ja = 4.3
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play417031118(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1034"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1034 == nil then
				arg_490_1.var_.actorSpriteComps1034 = var_493_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_2 = 0.2

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.actorSpriteComps1034 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								local var_493_4 = Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, var_493_3)
								local var_493_5 = Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, var_493_3)
								local var_493_6 = Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, var_493_3)

								iter_493_1.color = Color.New(var_493_4, var_493_5, var_493_6)
							else
								local var_493_7 = Mathf.Lerp(iter_493_1.color.r, 1, var_493_3)

								iter_493_1.color = Color.New(var_493_7, var_493_7, var_493_7)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1034 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_493_3 then
						if arg_490_1.isInRecall_ then
							iter_493_3.color = arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_493_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_490_1.var_.actorSpriteComps1034 = nil
			end

			local var_493_8 = arg_490_1.actors_["1060"]
			local var_493_9 = 0

			if var_493_9 < arg_490_1.time_ and arg_490_1.time_ <= var_493_9 + arg_493_0 and not isNil(var_493_8) and arg_490_1.var_.actorSpriteComps1060 == nil then
				arg_490_1.var_.actorSpriteComps1060 = var_493_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_10 = 0.2

			if var_493_9 <= arg_490_1.time_ and arg_490_1.time_ < var_493_9 + var_493_10 and not isNil(var_493_8) then
				local var_493_11 = (arg_490_1.time_ - var_493_9) / var_493_10

				if arg_490_1.var_.actorSpriteComps1060 then
					for iter_493_4, iter_493_5 in pairs(arg_490_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_493_5 then
							if arg_490_1.isInRecall_ then
								local var_493_12 = Mathf.Lerp(iter_493_5.color.r, arg_490_1.hightColor2.r, var_493_11)
								local var_493_13 = Mathf.Lerp(iter_493_5.color.g, arg_490_1.hightColor2.g, var_493_11)
								local var_493_14 = Mathf.Lerp(iter_493_5.color.b, arg_490_1.hightColor2.b, var_493_11)

								iter_493_5.color = Color.New(var_493_12, var_493_13, var_493_14)
							else
								local var_493_15 = Mathf.Lerp(iter_493_5.color.r, 0.5, var_493_11)

								iter_493_5.color = Color.New(var_493_15, var_493_15, var_493_15)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= var_493_9 + var_493_10 and arg_490_1.time_ < var_493_9 + var_493_10 + arg_493_0 and not isNil(var_493_8) and arg_490_1.var_.actorSpriteComps1060 then
				for iter_493_6, iter_493_7 in pairs(arg_490_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_493_7 then
						if arg_490_1.isInRecall_ then
							iter_493_7.color = arg_490_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_493_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_490_1.var_.actorSpriteComps1060 = nil
			end

			local var_493_16 = arg_490_1.actors_["1034"].transform
			local var_493_17 = 0

			if var_493_17 < arg_490_1.time_ and arg_490_1.time_ <= var_493_17 + arg_493_0 then
				arg_490_1.var_.moveOldPos1034 = var_493_16.localPosition
				var_493_16.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("1034", 4)

				local var_493_18 = var_493_16.childCount

				for iter_493_8 = 0, var_493_18 - 1 do
					local var_493_19 = var_493_16:GetChild(iter_493_8)

					if var_493_19.name == "split_1" or not string.find(var_493_19.name, "split") then
						var_493_19.gameObject:SetActive(true)
					else
						var_493_19.gameObject:SetActive(false)
					end
				end
			end

			local var_493_20 = 0.001

			if var_493_17 <= arg_490_1.time_ and arg_490_1.time_ < var_493_17 + var_493_20 then
				local var_493_21 = (arg_490_1.time_ - var_493_17) / var_493_20
				local var_493_22 = Vector3.New(373.7, -331.9, -324)

				var_493_16.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1034, var_493_22, var_493_21)
			end

			if arg_490_1.time_ >= var_493_17 + var_493_20 and arg_490_1.time_ < var_493_17 + var_493_20 + arg_493_0 then
				var_493_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_493_23 = 0
			local var_493_24 = 0.1

			if var_493_23 < arg_490_1.time_ and arg_490_1.time_ <= var_493_23 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_25 = arg_490_1:FormatText(StoryNameCfg[1109].name)

				arg_490_1.leftNameTxt_.text = var_493_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_26 = arg_490_1:GetWordFromCfg(417031117)
				local var_493_27 = arg_490_1:FormatText(var_493_26.content)

				arg_490_1.text_.text = var_493_27

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_28 = 4
				local var_493_29 = utf8.len(var_493_27)
				local var_493_30 = var_493_28 <= 0 and var_493_24 or var_493_24 * (var_493_29 / var_493_28)

				if var_493_30 > 0 and var_493_24 < var_493_30 then
					arg_490_1.talkMaxDuration = var_493_30

					if var_493_30 + var_493_23 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_30 + var_493_23
					end
				end

				arg_490_1.text_.text = var_493_27
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031117", "story_v_out_417031.awb") ~= 0 then
					local var_493_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031117", "story_v_out_417031.awb") / 1000

					if var_493_31 + var_493_23 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_31 + var_493_23
					end

					if var_493_26.prefab_name ~= "" and arg_490_1.actors_[var_493_26.prefab_name] ~= nil then
						local var_493_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_26.prefab_name].transform, "story_v_out_417031", "417031117", "story_v_out_417031.awb")

						arg_490_1:RecordAudio("417031117", var_493_32)
						arg_490_1:RecordAudio("417031117", var_493_32)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_417031", "417031117", "story_v_out_417031.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_417031", "417031117", "story_v_out_417031.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_33 = math.max(var_493_24, arg_490_1.talkMaxDuration)

			if var_493_23 <= arg_490_1.time_ and arg_490_1.time_ < var_493_23 + var_493_33 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_23) / var_493_33

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_23 + var_493_33 and arg_490_1.time_ < var_493_23 + var_493_33 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
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

		arg_490_1:InitPlayNodeList()
	end,
	Play417031118 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 417031118
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play417031119(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1034"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1034 == nil then
				arg_494_1.var_.actorSpriteComps1034 = var_497_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_2 = 0.2

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.actorSpriteComps1034 then
					for iter_497_0, iter_497_1 in pairs(arg_494_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_497_1 then
							if arg_494_1.isInRecall_ then
								local var_497_4 = Mathf.Lerp(iter_497_1.color.r, arg_494_1.hightColor2.r, var_497_3)
								local var_497_5 = Mathf.Lerp(iter_497_1.color.g, arg_494_1.hightColor2.g, var_497_3)
								local var_497_6 = Mathf.Lerp(iter_497_1.color.b, arg_494_1.hightColor2.b, var_497_3)

								iter_497_1.color = Color.New(var_497_4, var_497_5, var_497_6)
							else
								local var_497_7 = Mathf.Lerp(iter_497_1.color.r, 0.5, var_497_3)

								iter_497_1.color = Color.New(var_497_7, var_497_7, var_497_7)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1034 then
				for iter_497_2, iter_497_3 in pairs(arg_494_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_497_3 then
						if arg_494_1.isInRecall_ then
							iter_497_3.color = arg_494_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_497_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_494_1.var_.actorSpriteComps1034 = nil
			end

			local var_497_8 = arg_494_1.actors_["1060"].transform
			local var_497_9 = 0

			if var_497_9 < arg_494_1.time_ and arg_494_1.time_ <= var_497_9 + arg_497_0 then
				arg_494_1.var_.moveOldPos1060 = var_497_8.localPosition
				var_497_8.localScale = Vector3.New(1, 1, 1)

				arg_494_1:CheckSpriteTmpPos("1060", 7)

				local var_497_10 = var_497_8.childCount

				for iter_497_4 = 0, var_497_10 - 1 do
					local var_497_11 = var_497_8:GetChild(iter_497_4)

					if var_497_11.name == "" or not string.find(var_497_11.name, "split") then
						var_497_11.gameObject:SetActive(true)
					else
						var_497_11.gameObject:SetActive(false)
					end
				end
			end

			local var_497_12 = 0.001

			if var_497_9 <= arg_494_1.time_ and arg_494_1.time_ < var_497_9 + var_497_12 then
				local var_497_13 = (arg_494_1.time_ - var_497_9) / var_497_12
				local var_497_14 = Vector3.New(0, -2000, -40)

				var_497_8.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1060, var_497_14, var_497_13)
			end

			if arg_494_1.time_ >= var_497_9 + var_497_12 and arg_494_1.time_ < var_497_9 + var_497_12 + arg_497_0 then
				var_497_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_497_15 = arg_494_1.actors_["1034"].transform
			local var_497_16 = 0

			if var_497_16 < arg_494_1.time_ and arg_494_1.time_ <= var_497_16 + arg_497_0 then
				arg_494_1.var_.moveOldPos1034 = var_497_15.localPosition
				var_497_15.localScale = Vector3.New(1, 1, 1)

				arg_494_1:CheckSpriteTmpPos("1034", 7)

				local var_497_17 = var_497_15.childCount

				for iter_497_5 = 0, var_497_17 - 1 do
					local var_497_18 = var_497_15:GetChild(iter_497_5)

					if var_497_18.name == "" or not string.find(var_497_18.name, "split") then
						var_497_18.gameObject:SetActive(true)
					else
						var_497_18.gameObject:SetActive(false)
					end
				end
			end

			local var_497_19 = 0.001

			if var_497_16 <= arg_494_1.time_ and arg_494_1.time_ < var_497_16 + var_497_19 then
				local var_497_20 = (arg_494_1.time_ - var_497_16) / var_497_19
				local var_497_21 = Vector3.New(0, -2000, 0)

				var_497_15.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1034, var_497_21, var_497_20)
			end

			if arg_494_1.time_ >= var_497_16 + var_497_19 and arg_494_1.time_ < var_497_16 + var_497_19 + arg_497_0 then
				var_497_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_497_22 = 0
			local var_497_23 = 0.6

			if var_497_22 < arg_494_1.time_ and arg_494_1.time_ <= var_497_22 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_24 = arg_494_1:GetWordFromCfg(417031118)
				local var_497_25 = arg_494_1:FormatText(var_497_24.content)

				arg_494_1.text_.text = var_497_25

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_26 = 24
				local var_497_27 = utf8.len(var_497_25)
				local var_497_28 = var_497_26 <= 0 and var_497_23 or var_497_23 * (var_497_27 / var_497_26)

				if var_497_28 > 0 and var_497_23 < var_497_28 then
					arg_494_1.talkMaxDuration = var_497_28

					if var_497_28 + var_497_22 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_28 + var_497_22
					end
				end

				arg_494_1.text_.text = var_497_25
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_29 = math.max(var_497_23, arg_494_1.talkMaxDuration)

			if var_497_22 <= arg_494_1.time_ and arg_494_1.time_ < var_497_22 + var_497_29 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_22) / var_497_29

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_22 + var_497_29 and arg_494_1.time_ < var_497_22 + var_497_29 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_494_1:InitPlayNodeList()
	end,
	Play417031119 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 417031119
		arg_498_1.duration_ = 6.2

		local var_498_0 = {
			zh = 6.2,
			ja = 5.5
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play417031120(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1034"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.actorSpriteComps1034 == nil then
				arg_498_1.var_.actorSpriteComps1034 = var_501_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_2 = 0.2

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.actorSpriteComps1034 then
					for iter_501_0, iter_501_1 in pairs(arg_498_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_501_1 then
							if arg_498_1.isInRecall_ then
								local var_501_4 = Mathf.Lerp(iter_501_1.color.r, arg_498_1.hightColor1.r, var_501_3)
								local var_501_5 = Mathf.Lerp(iter_501_1.color.g, arg_498_1.hightColor1.g, var_501_3)
								local var_501_6 = Mathf.Lerp(iter_501_1.color.b, arg_498_1.hightColor1.b, var_501_3)

								iter_501_1.color = Color.New(var_501_4, var_501_5, var_501_6)
							else
								local var_501_7 = Mathf.Lerp(iter_501_1.color.r, 1, var_501_3)

								iter_501_1.color = Color.New(var_501_7, var_501_7, var_501_7)
							end
						end
					end
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.actorSpriteComps1034 then
				for iter_501_2, iter_501_3 in pairs(arg_498_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_501_3 then
						if arg_498_1.isInRecall_ then
							iter_501_3.color = arg_498_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_501_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_498_1.var_.actorSpriteComps1034 = nil
			end

			local var_501_8 = arg_498_1.actors_["1034"].transform
			local var_501_9 = 0

			if var_501_9 < arg_498_1.time_ and arg_498_1.time_ <= var_501_9 + arg_501_0 then
				arg_498_1.var_.moveOldPos1034 = var_501_8.localPosition
				var_501_8.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("1034", 3)

				local var_501_10 = var_501_8.childCount

				for iter_501_4 = 0, var_501_10 - 1 do
					local var_501_11 = var_501_8:GetChild(iter_501_4)

					if var_501_11.name == "" or not string.find(var_501_11.name, "split") then
						var_501_11.gameObject:SetActive(true)
					else
						var_501_11.gameObject:SetActive(false)
					end
				end
			end

			local var_501_12 = 0.001

			if var_501_9 <= arg_498_1.time_ and arg_498_1.time_ < var_501_9 + var_501_12 then
				local var_501_13 = (arg_498_1.time_ - var_501_9) / var_501_12
				local var_501_14 = Vector3.New(0, -331.9, -324)

				var_501_8.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1034, var_501_14, var_501_13)
			end

			if arg_498_1.time_ >= var_501_9 + var_501_12 and arg_498_1.time_ < var_501_9 + var_501_12 + arg_501_0 then
				var_501_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_501_15 = 0
			local var_501_16 = 0.775

			if var_501_15 < arg_498_1.time_ and arg_498_1.time_ <= var_501_15 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_17 = arg_498_1:FormatText(StoryNameCfg[1109].name)

				arg_498_1.leftNameTxt_.text = var_501_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_18 = arg_498_1:GetWordFromCfg(417031119)
				local var_501_19 = arg_498_1:FormatText(var_501_18.content)

				arg_498_1.text_.text = var_501_19

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_20 = 31
				local var_501_21 = utf8.len(var_501_19)
				local var_501_22 = var_501_20 <= 0 and var_501_16 or var_501_16 * (var_501_21 / var_501_20)

				if var_501_22 > 0 and var_501_16 < var_501_22 then
					arg_498_1.talkMaxDuration = var_501_22

					if var_501_22 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_22 + var_501_15
					end
				end

				arg_498_1.text_.text = var_501_19
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031119", "story_v_out_417031.awb") ~= 0 then
					local var_501_23 = manager.audio:GetVoiceLength("story_v_out_417031", "417031119", "story_v_out_417031.awb") / 1000

					if var_501_23 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_23 + var_501_15
					end

					if var_501_18.prefab_name ~= "" and arg_498_1.actors_[var_501_18.prefab_name] ~= nil then
						local var_501_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_18.prefab_name].transform, "story_v_out_417031", "417031119", "story_v_out_417031.awb")

						arg_498_1:RecordAudio("417031119", var_501_24)
						arg_498_1:RecordAudio("417031119", var_501_24)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_417031", "417031119", "story_v_out_417031.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_417031", "417031119", "story_v_out_417031.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_25 = math.max(var_501_16, arg_498_1.talkMaxDuration)

			if var_501_15 <= arg_498_1.time_ and arg_498_1.time_ < var_501_15 + var_501_25 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_15) / var_501_25

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_15 + var_501_25 and arg_498_1.time_ < var_501_15 + var_501_25 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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

		arg_498_1:InitPlayNodeList()
	end,
	Play417031120 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 417031120
		arg_502_1.duration_ = 1.67

		local var_502_0 = {
			zh = 0.999999999999,
			ja = 1.666
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play417031121(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1060"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.actorSpriteComps1060 == nil then
				arg_502_1.var_.actorSpriteComps1060 = var_505_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_2 = 0.2

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.actorSpriteComps1060 then
					for iter_505_0, iter_505_1 in pairs(arg_502_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_505_1 then
							if arg_502_1.isInRecall_ then
								local var_505_4 = Mathf.Lerp(iter_505_1.color.r, arg_502_1.hightColor1.r, var_505_3)
								local var_505_5 = Mathf.Lerp(iter_505_1.color.g, arg_502_1.hightColor1.g, var_505_3)
								local var_505_6 = Mathf.Lerp(iter_505_1.color.b, arg_502_1.hightColor1.b, var_505_3)

								iter_505_1.color = Color.New(var_505_4, var_505_5, var_505_6)
							else
								local var_505_7 = Mathf.Lerp(iter_505_1.color.r, 1, var_505_3)

								iter_505_1.color = Color.New(var_505_7, var_505_7, var_505_7)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.actorSpriteComps1060 then
				for iter_505_2, iter_505_3 in pairs(arg_502_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_505_3 then
						if arg_502_1.isInRecall_ then
							iter_505_3.color = arg_502_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_505_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_502_1.var_.actorSpriteComps1060 = nil
			end

			local var_505_8 = arg_502_1.actors_["1034"]
			local var_505_9 = 0

			if var_505_9 < arg_502_1.time_ and arg_502_1.time_ <= var_505_9 + arg_505_0 and not isNil(var_505_8) and arg_502_1.var_.actorSpriteComps1034 == nil then
				arg_502_1.var_.actorSpriteComps1034 = var_505_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_10 = 0.2

			if var_505_9 <= arg_502_1.time_ and arg_502_1.time_ < var_505_9 + var_505_10 and not isNil(var_505_8) then
				local var_505_11 = (arg_502_1.time_ - var_505_9) / var_505_10

				if arg_502_1.var_.actorSpriteComps1034 then
					for iter_505_4, iter_505_5 in pairs(arg_502_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_505_5 then
							if arg_502_1.isInRecall_ then
								local var_505_12 = Mathf.Lerp(iter_505_5.color.r, arg_502_1.hightColor2.r, var_505_11)
								local var_505_13 = Mathf.Lerp(iter_505_5.color.g, arg_502_1.hightColor2.g, var_505_11)
								local var_505_14 = Mathf.Lerp(iter_505_5.color.b, arg_502_1.hightColor2.b, var_505_11)

								iter_505_5.color = Color.New(var_505_12, var_505_13, var_505_14)
							else
								local var_505_15 = Mathf.Lerp(iter_505_5.color.r, 0.5, var_505_11)

								iter_505_5.color = Color.New(var_505_15, var_505_15, var_505_15)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= var_505_9 + var_505_10 and arg_502_1.time_ < var_505_9 + var_505_10 + arg_505_0 and not isNil(var_505_8) and arg_502_1.var_.actorSpriteComps1034 then
				for iter_505_6, iter_505_7 in pairs(arg_502_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_505_7 then
						if arg_502_1.isInRecall_ then
							iter_505_7.color = arg_502_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_505_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_502_1.var_.actorSpriteComps1034 = nil
			end

			local var_505_16 = 0
			local var_505_17 = 0.075

			if var_505_16 < arg_502_1.time_ and arg_502_1.time_ <= var_505_16 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_18 = arg_502_1:FormatText(StoryNameCfg[584].name)

				arg_502_1.leftNameTxt_.text = var_505_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1060_split_1_1")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_19 = arg_502_1:GetWordFromCfg(417031120)
				local var_505_20 = arg_502_1:FormatText(var_505_19.content)

				arg_502_1.text_.text = var_505_20

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_21 = 3
				local var_505_22 = utf8.len(var_505_20)
				local var_505_23 = var_505_21 <= 0 and var_505_17 or var_505_17 * (var_505_22 / var_505_21)

				if var_505_23 > 0 and var_505_17 < var_505_23 then
					arg_502_1.talkMaxDuration = var_505_23

					if var_505_23 + var_505_16 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_23 + var_505_16
					end
				end

				arg_502_1.text_.text = var_505_20
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031120", "story_v_out_417031.awb") ~= 0 then
					local var_505_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031120", "story_v_out_417031.awb") / 1000

					if var_505_24 + var_505_16 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_24 + var_505_16
					end

					if var_505_19.prefab_name ~= "" and arg_502_1.actors_[var_505_19.prefab_name] ~= nil then
						local var_505_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_19.prefab_name].transform, "story_v_out_417031", "417031120", "story_v_out_417031.awb")

						arg_502_1:RecordAudio("417031120", var_505_25)
						arg_502_1:RecordAudio("417031120", var_505_25)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_417031", "417031120", "story_v_out_417031.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_417031", "417031120", "story_v_out_417031.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_26 = math.max(var_505_17, arg_502_1.talkMaxDuration)

			if var_505_16 <= arg_502_1.time_ and arg_502_1.time_ < var_505_16 + var_505_26 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_16) / var_505_26

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_16 + var_505_26 and arg_502_1.time_ < var_505_16 + var_505_26 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play417031121 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 417031121
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play417031122(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1034"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos1034 = var_509_0.localPosition
				var_509_0.localScale = Vector3.New(1, 1, 1)

				arg_506_1:CheckSpriteTmpPos("1034", 7)

				local var_509_2 = var_509_0.childCount

				for iter_509_0 = 0, var_509_2 - 1 do
					local var_509_3 = var_509_0:GetChild(iter_509_0)

					if var_509_3.name == "" or not string.find(var_509_3.name, "split") then
						var_509_3.gameObject:SetActive(true)
					else
						var_509_3.gameObject:SetActive(false)
					end
				end
			end

			local var_509_4 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_4 then
				local var_509_5 = (arg_506_1.time_ - var_509_1) / var_509_4
				local var_509_6 = Vector3.New(0, -2000, 0)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1034, var_509_6, var_509_5)
			end

			if arg_506_1.time_ >= var_509_1 + var_509_4 and arg_506_1.time_ < var_509_1 + var_509_4 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_509_7 = 0.225
			local var_509_8 = 1

			if var_509_7 < arg_506_1.time_ and arg_506_1.time_ <= var_509_7 + arg_509_0 then
				local var_509_9 = "play"
				local var_509_10 = "effect"

				arg_506_1:AudioAction(var_509_9, var_509_10, "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_509_11 = 0
			local var_509_12 = 1.225

			if var_509_11 < arg_506_1.time_ and arg_506_1.time_ <= var_509_11 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_13 = arg_506_1:GetWordFromCfg(417031121)
				local var_509_14 = arg_506_1:FormatText(var_509_13.content)

				arg_506_1.text_.text = var_509_14

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_15 = 49
				local var_509_16 = utf8.len(var_509_14)
				local var_509_17 = var_509_15 <= 0 and var_509_12 or var_509_12 * (var_509_16 / var_509_15)

				if var_509_17 > 0 and var_509_12 < var_509_17 then
					arg_506_1.talkMaxDuration = var_509_17

					if var_509_17 + var_509_11 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_17 + var_509_11
					end
				end

				arg_506_1.text_.text = var_509_14
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_18 = math.max(var_509_12, arg_506_1.talkMaxDuration)

			if var_509_11 <= arg_506_1.time_ and arg_506_1.time_ < var_509_11 + var_509_18 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_11) / var_509_18

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_11 + var_509_18 and arg_506_1.time_ < var_509_11 + var_509_18 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
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

		arg_506_1:InitPlayNodeList()
	end,
	Play417031122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 417031122
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play417031123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 0.875

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_2 = arg_510_1:GetWordFromCfg(417031122)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 35
				local var_513_5 = utf8.len(var_513_3)
				local var_513_6 = var_513_4 <= 0 and var_513_1 or var_513_1 * (var_513_5 / var_513_4)

				if var_513_6 > 0 and var_513_1 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_7 and arg_510_1.time_ < var_513_0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play417031123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 417031123
		arg_514_1.duration_ = 5.1

		local var_514_0 = {
			zh = 5.1,
			ja = 5
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play417031124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0
			local var_517_1 = 0.475

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_2 = arg_514_1:FormatText(StoryNameCfg[1109].name)

				arg_514_1.leftNameTxt_.text = var_517_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_3 = arg_514_1:GetWordFromCfg(417031123)
				local var_517_4 = arg_514_1:FormatText(var_517_3.content)

				arg_514_1.text_.text = var_517_4

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 19
				local var_517_6 = utf8.len(var_517_4)
				local var_517_7 = var_517_5 <= 0 and var_517_1 or var_517_1 * (var_517_6 / var_517_5)

				if var_517_7 > 0 and var_517_1 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_4
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031123", "story_v_out_417031.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031123", "story_v_out_417031.awb") / 1000

					if var_517_8 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_0
					end

					if var_517_3.prefab_name ~= "" and arg_514_1.actors_[var_517_3.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_3.prefab_name].transform, "story_v_out_417031", "417031123", "story_v_out_417031.awb")

						arg_514_1:RecordAudio("417031123", var_517_9)
						arg_514_1:RecordAudio("417031123", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_417031", "417031123", "story_v_out_417031.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_417031", "417031123", "story_v_out_417031.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_10 and arg_514_1.time_ < var_517_0 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play417031124 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 417031124
		arg_518_1.duration_ = 8.1

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play417031125(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 1.53333333333333

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				local var_521_1 = manager.ui.mainCamera.transform.localPosition
				local var_521_2 = Vector3.New(0, 0, 10) + Vector3.New(var_521_1.x, var_521_1.y, 0)
				local var_521_3 = arg_518_1.bgs_.ST77a

				var_521_3.transform.localPosition = var_521_2
				var_521_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_521_4 = var_521_3:GetComponent("SpriteRenderer")

				if var_521_4 and var_521_4.sprite then
					local var_521_5 = (var_521_3.transform.localPosition - var_521_1).z
					local var_521_6 = manager.ui.mainCameraCom_
					local var_521_7 = 2 * var_521_5 * Mathf.Tan(var_521_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_521_8 = var_521_7 * var_521_6.aspect
					local var_521_9 = var_521_4.sprite.bounds.size.x
					local var_521_10 = var_521_4.sprite.bounds.size.y
					local var_521_11 = var_521_8 / var_521_9
					local var_521_12 = var_521_7 / var_521_10
					local var_521_13 = var_521_12 < var_521_11 and var_521_11 or var_521_12

					var_521_3.transform.localScale = Vector3.New(var_521_13, var_521_13, 0)
				end

				for iter_521_0, iter_521_1 in pairs(arg_518_1.bgs_) do
					if iter_521_0 ~= "ST77a" then
						iter_521_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_521_14 = 0

			if var_521_14 < arg_518_1.time_ and arg_518_1.time_ <= var_521_14 + arg_521_0 then
				arg_518_1.allBtn_.enabled = false
			end

			local var_521_15 = 0.3

			if arg_518_1.time_ >= var_521_14 + var_521_15 and arg_518_1.time_ < var_521_14 + var_521_15 + arg_521_0 then
				arg_518_1.allBtn_.enabled = true
			end

			local var_521_16 = 0

			if var_521_16 < arg_518_1.time_ and arg_518_1.time_ <= var_521_16 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = true

				arg_518_1:SetGaussion(false)
			end

			local var_521_17 = 1.53333333333333

			if var_521_16 <= arg_518_1.time_ and arg_518_1.time_ < var_521_16 + var_521_17 then
				local var_521_18 = (arg_518_1.time_ - var_521_16) / var_521_17
				local var_521_19 = Color.New(0, 0, 0)

				var_521_19.a = Mathf.Lerp(0, 1, var_521_18)
				arg_518_1.mask_.color = var_521_19
			end

			if arg_518_1.time_ >= var_521_16 + var_521_17 and arg_518_1.time_ < var_521_16 + var_521_17 + arg_521_0 then
				local var_521_20 = Color.New(0, 0, 0)

				var_521_20.a = 1
				arg_518_1.mask_.color = var_521_20
			end

			local var_521_21 = 1.53333333333333

			if var_521_21 < arg_518_1.time_ and arg_518_1.time_ <= var_521_21 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = true

				arg_518_1:SetGaussion(false)
			end

			local var_521_22 = 2

			if var_521_21 <= arg_518_1.time_ and arg_518_1.time_ < var_521_21 + var_521_22 then
				local var_521_23 = (arg_518_1.time_ - var_521_21) / var_521_22
				local var_521_24 = Color.New(0, 0, 0)

				var_521_24.a = Mathf.Lerp(1, 0, var_521_23)
				arg_518_1.mask_.color = var_521_24
			end

			if arg_518_1.time_ >= var_521_21 + var_521_22 and arg_518_1.time_ < var_521_21 + var_521_22 + arg_521_0 then
				local var_521_25 = Color.New(0, 0, 0)
				local var_521_26 = 0

				arg_518_1.mask_.enabled = false
				var_521_25.a = var_521_26
				arg_518_1.mask_.color = var_521_25
			end

			local var_521_27 = 3.2
			local var_521_28 = 1

			if var_521_27 < arg_518_1.time_ and arg_518_1.time_ <= var_521_27 + arg_521_0 then
				local var_521_29 = "play"
				local var_521_30 = "effect"

				arg_518_1:AudioAction(var_521_29, var_521_30, "se_story_1310", "se_story_1310_coin01", "")
			end

			if arg_518_1.frameCnt_ <= 1 then
				arg_518_1.dialog_:SetActive(false)
			end

			local var_521_31 = 3.1
			local var_521_32 = 0.775

			if var_521_31 < arg_518_1.time_ and arg_518_1.time_ <= var_521_31 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0

				arg_518_1.dialog_:SetActive(true)

				arg_518_1.dialogCg_.alpha = 0

				local var_521_33 = LeanTween.value(arg_518_1.dialog_, 0, 1, 0.3)

				var_521_33:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_518_1.dialogCg_.alpha = arg_522_0
				end))
				var_521_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_518_1.dialog_)
					var_521_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_518_1.duration_ = arg_518_1.duration_ + 0.3

				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_34 = arg_518_1:GetWordFromCfg(417031124)
				local var_521_35 = arg_518_1:FormatText(var_521_34.content)

				arg_518_1.text_.text = var_521_35

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_36 = 31
				local var_521_37 = utf8.len(var_521_35)
				local var_521_38 = var_521_36 <= 0 and var_521_32 or var_521_32 * (var_521_37 / var_521_36)

				if var_521_38 > 0 and var_521_32 < var_521_38 then
					arg_518_1.talkMaxDuration = var_521_38
					var_521_31 = var_521_31 + 0.3

					if var_521_38 + var_521_31 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_38 + var_521_31
					end
				end

				arg_518_1.text_.text = var_521_35
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_39 = var_521_31 + 0.3
			local var_521_40 = math.max(var_521_32, arg_518_1.talkMaxDuration)

			if var_521_39 <= arg_518_1.time_ and arg_518_1.time_ < var_521_39 + var_521_40 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_39) / var_521_40

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_39 + var_521_40 and arg_518_1.time_ < var_521_39 + var_521_40 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play417031125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 417031125
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play417031126(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 1.275

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_2 = arg_524_1:GetWordFromCfg(417031125)
				local var_527_3 = arg_524_1:FormatText(var_527_2.content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_4 = 51
				local var_527_5 = utf8.len(var_527_3)
				local var_527_6 = var_527_4 <= 0 and var_527_1 or var_527_1 * (var_527_5 / var_527_4)

				if var_527_6 > 0 and var_527_1 < var_527_6 then
					arg_524_1.talkMaxDuration = var_527_6

					if var_527_6 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_6 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_7 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_7 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_7

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_7 and arg_524_1.time_ < var_527_0 + var_527_7 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play417031126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 417031126
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play417031127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.16666666666667
			local var_531_1 = 1

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				local var_531_2 = "play"
				local var_531_3 = "effect"

				arg_528_1:AudioAction(var_531_2, var_531_3, "se_story_1310", "se_story_1310_coin02", "")
			end

			local var_531_4 = 0
			local var_531_5 = 1.45

			if var_531_4 < arg_528_1.time_ and arg_528_1.time_ <= var_531_4 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_6 = arg_528_1:GetWordFromCfg(417031126)
				local var_531_7 = arg_528_1:FormatText(var_531_6.content)

				arg_528_1.text_.text = var_531_7

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_8 = 58
				local var_531_9 = utf8.len(var_531_7)
				local var_531_10 = var_531_8 <= 0 and var_531_5 or var_531_5 * (var_531_9 / var_531_8)

				if var_531_10 > 0 and var_531_5 < var_531_10 then
					arg_528_1.talkMaxDuration = var_531_10

					if var_531_10 + var_531_4 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_10 + var_531_4
					end
				end

				arg_528_1.text_.text = var_531_7
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_11 = math.max(var_531_5, arg_528_1.talkMaxDuration)

			if var_531_4 <= arg_528_1.time_ and arg_528_1.time_ < var_531_4 + var_531_11 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_4) / var_531_11

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_4 + var_531_11 and arg_528_1.time_ < var_531_4 + var_531_11 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play417031127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 417031127
		arg_532_1.duration_ = 8.23

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play417031128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = "SS1702"

			if arg_532_1.bgs_[var_535_0] == nil then
				local var_535_1 = Object.Instantiate(arg_532_1.paintGo_)

				var_535_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_535_0)
				var_535_1.name = var_535_0
				var_535_1.transform.parent = arg_532_1.stage_.transform
				var_535_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_532_1.bgs_[var_535_0] = var_535_1
			end

			local var_535_2 = 1.56666666666667

			if var_535_2 < arg_532_1.time_ and arg_532_1.time_ <= var_535_2 + arg_535_0 then
				local var_535_3 = manager.ui.mainCamera.transform.localPosition
				local var_535_4 = Vector3.New(0, 0, 10) + Vector3.New(var_535_3.x, var_535_3.y, 0)
				local var_535_5 = arg_532_1.bgs_.SS1702

				var_535_5.transform.localPosition = var_535_4
				var_535_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_535_6 = var_535_5:GetComponent("SpriteRenderer")

				if var_535_6 and var_535_6.sprite then
					local var_535_7 = (var_535_5.transform.localPosition - var_535_3).z
					local var_535_8 = manager.ui.mainCameraCom_
					local var_535_9 = 2 * var_535_7 * Mathf.Tan(var_535_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_535_10 = var_535_9 * var_535_8.aspect
					local var_535_11 = var_535_6.sprite.bounds.size.x
					local var_535_12 = var_535_6.sprite.bounds.size.y
					local var_535_13 = var_535_10 / var_535_11
					local var_535_14 = var_535_9 / var_535_12
					local var_535_15 = var_535_14 < var_535_13 and var_535_13 or var_535_14

					var_535_5.transform.localScale = Vector3.New(var_535_15, var_535_15, 0)
				end

				for iter_535_0, iter_535_1 in pairs(arg_532_1.bgs_) do
					if iter_535_0 ~= "SS1702" then
						iter_535_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_535_16 = 0

			if var_535_16 < arg_532_1.time_ and arg_532_1.time_ <= var_535_16 + arg_535_0 then
				arg_532_1.allBtn_.enabled = false
			end

			local var_535_17 = 0.3

			if arg_532_1.time_ >= var_535_16 + var_535_17 and arg_532_1.time_ < var_535_16 + var_535_17 + arg_535_0 then
				arg_532_1.allBtn_.enabled = true
			end

			local var_535_18 = 0

			if var_535_18 < arg_532_1.time_ and arg_532_1.time_ <= var_535_18 + arg_535_0 then
				arg_532_1.mask_.enabled = true
				arg_532_1.mask_.raycastTarget = true

				arg_532_1:SetGaussion(false)
			end

			local var_535_19 = 1.56666666666667

			if var_535_18 <= arg_532_1.time_ and arg_532_1.time_ < var_535_18 + var_535_19 then
				local var_535_20 = (arg_532_1.time_ - var_535_18) / var_535_19
				local var_535_21 = Color.New(0, 0, 0)

				var_535_21.a = Mathf.Lerp(0, 1, var_535_20)
				arg_532_1.mask_.color = var_535_21
			end

			if arg_532_1.time_ >= var_535_18 + var_535_19 and arg_532_1.time_ < var_535_18 + var_535_19 + arg_535_0 then
				local var_535_22 = Color.New(0, 0, 0)

				var_535_22.a = 1
				arg_532_1.mask_.color = var_535_22
			end

			local var_535_23 = 1.56666666666667

			if var_535_23 < arg_532_1.time_ and arg_532_1.time_ <= var_535_23 + arg_535_0 then
				arg_532_1.mask_.enabled = true
				arg_532_1.mask_.raycastTarget = true

				arg_532_1:SetGaussion(false)
			end

			local var_535_24 = 1.99999999999867

			if var_535_23 <= arg_532_1.time_ and arg_532_1.time_ < var_535_23 + var_535_24 then
				local var_535_25 = (arg_532_1.time_ - var_535_23) / var_535_24
				local var_535_26 = Color.New(0, 0, 0)

				var_535_26.a = Mathf.Lerp(1, 0, var_535_25)
				arg_532_1.mask_.color = var_535_26
			end

			if arg_532_1.time_ >= var_535_23 + var_535_24 and arg_532_1.time_ < var_535_23 + var_535_24 + arg_535_0 then
				local var_535_27 = Color.New(0, 0, 0)
				local var_535_28 = 0

				arg_532_1.mask_.enabled = false
				var_535_27.a = var_535_28
				arg_532_1.mask_.color = var_535_27
			end

			local var_535_29 = 1.56666666666667

			arg_532_1.isInRecall_ = true

			if var_535_29 < arg_532_1.time_ and arg_532_1.time_ <= var_535_29 + arg_535_0 then
				arg_532_1.screenFilterGo_:SetActive(true)

				arg_532_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_532_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_532_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_535_2, iter_535_3 in pairs(arg_532_1.actors_) do
					local var_535_30 = iter_535_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_535_4, iter_535_5 in ipairs(var_535_30) do
						if iter_535_5.color.r > 0.51 then
							iter_535_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_535_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_535_31 = 0.0166666666666667

			if var_535_29 <= arg_532_1.time_ and arg_532_1.time_ < var_535_29 + var_535_31 then
				local var_535_32 = (arg_532_1.time_ - var_535_29) / var_535_31

				arg_532_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_535_32)
			end

			if arg_532_1.time_ >= var_535_29 + var_535_31 and arg_532_1.time_ < var_535_29 + var_535_31 + arg_535_0 then
				arg_532_1.screenFilterEffect_.weight = 1
			end

			if arg_532_1.frameCnt_ <= 1 then
				arg_532_1.dialog_:SetActive(false)
			end

			local var_535_33 = 3.23333333333333
			local var_535_34 = 1.375

			if var_535_33 < arg_532_1.time_ and arg_532_1.time_ <= var_535_33 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0

				arg_532_1.dialog_:SetActive(true)

				arg_532_1.dialogCg_.alpha = 0

				local var_535_35 = LeanTween.value(arg_532_1.dialog_, 0, 1, 0.3)

				var_535_35:setOnUpdate(LuaHelper.FloatAction(function(arg_536_0)
					arg_532_1.dialogCg_.alpha = arg_536_0
				end))
				var_535_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_532_1.dialog_)
					var_535_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_532_1.duration_ = arg_532_1.duration_ + 0.3

				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_36 = arg_532_1:GetWordFromCfg(417031127)
				local var_535_37 = arg_532_1:FormatText(var_535_36.content)

				arg_532_1.text_.text = var_535_37

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_38 = 55
				local var_535_39 = utf8.len(var_535_37)
				local var_535_40 = var_535_38 <= 0 and var_535_34 or var_535_34 * (var_535_39 / var_535_38)

				if var_535_40 > 0 and var_535_34 < var_535_40 then
					arg_532_1.talkMaxDuration = var_535_40
					var_535_33 = var_535_33 + 0.3

					if var_535_40 + var_535_33 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_40 + var_535_33
					end
				end

				arg_532_1.text_.text = var_535_37
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_41 = var_535_33 + 0.3
			local var_535_42 = math.max(var_535_34, arg_532_1.talkMaxDuration)

			if var_535_41 <= arg_532_1.time_ and arg_532_1.time_ < var_535_41 + var_535_42 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_41) / var_535_42

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_41 + var_535_42 and arg_532_1.time_ < var_535_41 + var_535_42 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play417031128 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 417031128
		arg_538_1.duration_ = 1.3

		local var_538_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play417031129(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0
			local var_541_1 = 0.125

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_2 = arg_538_1:FormatText(StoryNameCfg[595].name)

				arg_538_1.leftNameTxt_.text = var_541_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_3 = arg_538_1:GetWordFromCfg(417031128)
				local var_541_4 = arg_538_1:FormatText(var_541_3.content)

				arg_538_1.text_.text = var_541_4

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_5 = 5
				local var_541_6 = utf8.len(var_541_4)
				local var_541_7 = var_541_5 <= 0 and var_541_1 or var_541_1 * (var_541_6 / var_541_5)

				if var_541_7 > 0 and var_541_1 < var_541_7 then
					arg_538_1.talkMaxDuration = var_541_7

					if var_541_7 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_0
					end
				end

				arg_538_1.text_.text = var_541_4
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031128", "story_v_out_417031.awb") ~= 0 then
					local var_541_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031128", "story_v_out_417031.awb") / 1000

					if var_541_8 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_8 + var_541_0
					end

					if var_541_3.prefab_name ~= "" and arg_538_1.actors_[var_541_3.prefab_name] ~= nil then
						local var_541_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_3.prefab_name].transform, "story_v_out_417031", "417031128", "story_v_out_417031.awb")

						arg_538_1:RecordAudio("417031128", var_541_9)
						arg_538_1:RecordAudio("417031128", var_541_9)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_417031", "417031128", "story_v_out_417031.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_417031", "417031128", "story_v_out_417031.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_10 = math.max(var_541_1, arg_538_1.talkMaxDuration)

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_10 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_0) / var_541_10

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_0 + var_541_10 and arg_538_1.time_ < var_541_0 + var_541_10 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play417031129 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 417031129
		arg_542_1.duration_ = 2.33

		local var_542_0 = {
			zh = 0.999999999999,
			ja = 2.333
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play417031130(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.075

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_2 = arg_542_1:FormatText(StoryNameCfg[1109].name)

				arg_542_1.leftNameTxt_.text = var_545_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_3 = arg_542_1:GetWordFromCfg(417031129)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 3
				local var_545_6 = utf8.len(var_545_4)
				local var_545_7 = var_545_5 <= 0 and var_545_1 or var_545_1 * (var_545_6 / var_545_5)

				if var_545_7 > 0 and var_545_1 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031129", "story_v_out_417031.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031129", "story_v_out_417031.awb") / 1000

					if var_545_8 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_0
					end

					if var_545_3.prefab_name ~= "" and arg_542_1.actors_[var_545_3.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_3.prefab_name].transform, "story_v_out_417031", "417031129", "story_v_out_417031.awb")

						arg_542_1:RecordAudio("417031129", var_545_9)
						arg_542_1:RecordAudio("417031129", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_417031", "417031129", "story_v_out_417031.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_417031", "417031129", "story_v_out_417031.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_10 and arg_542_1.time_ < var_545_0 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play417031130 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 417031130
		arg_546_1.duration_ = 5.63

		local var_546_0 = {
			zh = 5.233,
			ja = 5.633
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play417031131(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.7

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[595].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_3 = arg_546_1:GetWordFromCfg(417031130)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 28
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031130", "story_v_out_417031.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031130", "story_v_out_417031.awb") / 1000

					if var_549_8 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_0
					end

					if var_549_3.prefab_name ~= "" and arg_546_1.actors_[var_549_3.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_3.prefab_name].transform, "story_v_out_417031", "417031130", "story_v_out_417031.awb")

						arg_546_1:RecordAudio("417031130", var_549_9)
						arg_546_1:RecordAudio("417031130", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_417031", "417031130", "story_v_out_417031.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_417031", "417031130", "story_v_out_417031.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_10 and arg_546_1.time_ < var_549_0 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play417031131 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 417031131
		arg_550_1.duration_ = 5.3

		local var_550_0 = {
			zh = 2.9,
			ja = 5.3
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play417031132(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 0.45

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_2 = arg_550_1:FormatText(StoryNameCfg[595].name)

				arg_550_1.leftNameTxt_.text = var_553_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_3 = arg_550_1:GetWordFromCfg(417031131)
				local var_553_4 = arg_550_1:FormatText(var_553_3.content)

				arg_550_1.text_.text = var_553_4

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 18
				local var_553_6 = utf8.len(var_553_4)
				local var_553_7 = var_553_5 <= 0 and var_553_1 or var_553_1 * (var_553_6 / var_553_5)

				if var_553_7 > 0 and var_553_1 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_4
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031131", "story_v_out_417031.awb") ~= 0 then
					local var_553_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031131", "story_v_out_417031.awb") / 1000

					if var_553_8 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_8 + var_553_0
					end

					if var_553_3.prefab_name ~= "" and arg_550_1.actors_[var_553_3.prefab_name] ~= nil then
						local var_553_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_3.prefab_name].transform, "story_v_out_417031", "417031131", "story_v_out_417031.awb")

						arg_550_1:RecordAudio("417031131", var_553_9)
						arg_550_1:RecordAudio("417031131", var_553_9)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_417031", "417031131", "story_v_out_417031.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_417031", "417031131", "story_v_out_417031.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_10 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_10 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_10

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_10 and arg_550_1.time_ < var_553_0 + var_553_10 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play417031132 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 417031132
		arg_554_1.duration_ = 5.4

		local var_554_0 = {
			zh = 4.9,
			ja = 5.4
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play417031133(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.675

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[595].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_3 = arg_554_1:GetWordFromCfg(417031132)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 27
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031132", "story_v_out_417031.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031132", "story_v_out_417031.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_417031", "417031132", "story_v_out_417031.awb")

						arg_554_1:RecordAudio("417031132", var_557_9)
						arg_554_1:RecordAudio("417031132", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_417031", "417031132", "story_v_out_417031.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_417031", "417031132", "story_v_out_417031.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play417031133 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 417031133
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play417031134(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.05

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[1109].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_3 = arg_558_1:GetWordFromCfg(417031133)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 2
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_8 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_8 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_8

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_8 and arg_558_1.time_ < var_561_0 + var_561_8 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play417031134 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 417031134
		arg_562_1.duration_ = 3.7

		local var_562_0 = {
			zh = 2.8,
			ja = 3.7
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play417031135(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.3

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[595].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_3 = arg_562_1:GetWordFromCfg(417031134)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 12
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031134", "story_v_out_417031.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031134", "story_v_out_417031.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_out_417031", "417031134", "story_v_out_417031.awb")

						arg_562_1:RecordAudio("417031134", var_565_9)
						arg_562_1:RecordAudio("417031134", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_417031", "417031134", "story_v_out_417031.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_417031", "417031134", "story_v_out_417031.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play417031135 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 417031135
		arg_566_1.duration_ = 8.3

		local var_566_0 = {
			zh = 6.56633333333333,
			ja = 8.29933333333333
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play417031136(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 1.63333333333333

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				local var_569_1 = manager.ui.mainCamera.transform.localPosition
				local var_569_2 = Vector3.New(0, 0, 10) + Vector3.New(var_569_1.x, var_569_1.y, 0)
				local var_569_3 = arg_566_1.bgs_.ST77a

				var_569_3.transform.localPosition = var_569_2
				var_569_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_4 = var_569_3:GetComponent("SpriteRenderer")

				if var_569_4 and var_569_4.sprite then
					local var_569_5 = (var_569_3.transform.localPosition - var_569_1).z
					local var_569_6 = manager.ui.mainCameraCom_
					local var_569_7 = 2 * var_569_5 * Mathf.Tan(var_569_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_569_8 = var_569_7 * var_569_6.aspect
					local var_569_9 = var_569_4.sprite.bounds.size.x
					local var_569_10 = var_569_4.sprite.bounds.size.y
					local var_569_11 = var_569_8 / var_569_9
					local var_569_12 = var_569_7 / var_569_10
					local var_569_13 = var_569_12 < var_569_11 and var_569_11 or var_569_12

					var_569_3.transform.localScale = Vector3.New(var_569_13, var_569_13, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "ST77a" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_14 = 0

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_15 = 1.63333333333333

			if var_569_14 <= arg_566_1.time_ and arg_566_1.time_ < var_569_14 + var_569_15 then
				local var_569_16 = (arg_566_1.time_ - var_569_14) / var_569_15
				local var_569_17 = Color.New(0, 0, 0)

				var_569_17.a = Mathf.Lerp(0, 1, var_569_16)
				arg_566_1.mask_.color = var_569_17
			end

			if arg_566_1.time_ >= var_569_14 + var_569_15 and arg_566_1.time_ < var_569_14 + var_569_15 + arg_569_0 then
				local var_569_18 = Color.New(0, 0, 0)

				var_569_18.a = 1
				arg_566_1.mask_.color = var_569_18
			end

			local var_569_19 = 1.63333333333333

			if var_569_19 < arg_566_1.time_ and arg_566_1.time_ <= var_569_19 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_20 = 2

			if var_569_19 <= arg_566_1.time_ and arg_566_1.time_ < var_569_19 + var_569_20 then
				local var_569_21 = (arg_566_1.time_ - var_569_19) / var_569_20
				local var_569_22 = Color.New(0, 0, 0)

				var_569_22.a = Mathf.Lerp(1, 0, var_569_21)
				arg_566_1.mask_.color = var_569_22
			end

			if arg_566_1.time_ >= var_569_19 + var_569_20 and arg_566_1.time_ < var_569_19 + var_569_20 + arg_569_0 then
				local var_569_23 = Color.New(0, 0, 0)
				local var_569_24 = 0

				arg_566_1.mask_.enabled = false
				var_569_23.a = var_569_24
				arg_566_1.mask_.color = var_569_23
			end

			local var_569_25 = arg_566_1.actors_["1034"]
			local var_569_26 = 3.23333333333333

			if var_569_26 < arg_566_1.time_ and arg_566_1.time_ <= var_569_26 + arg_569_0 and not isNil(var_569_25) and arg_566_1.var_.actorSpriteComps1034 == nil then
				arg_566_1.var_.actorSpriteComps1034 = var_569_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_27 = 0.2

			if var_569_26 <= arg_566_1.time_ and arg_566_1.time_ < var_569_26 + var_569_27 and not isNil(var_569_25) then
				local var_569_28 = (arg_566_1.time_ - var_569_26) / var_569_27

				if arg_566_1.var_.actorSpriteComps1034 then
					for iter_569_2, iter_569_3 in pairs(arg_566_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_569_3 then
							if arg_566_1.isInRecall_ then
								local var_569_29 = Mathf.Lerp(iter_569_3.color.r, arg_566_1.hightColor1.r, var_569_28)
								local var_569_30 = Mathf.Lerp(iter_569_3.color.g, arg_566_1.hightColor1.g, var_569_28)
								local var_569_31 = Mathf.Lerp(iter_569_3.color.b, arg_566_1.hightColor1.b, var_569_28)

								iter_569_3.color = Color.New(var_569_29, var_569_30, var_569_31)
							else
								local var_569_32 = Mathf.Lerp(iter_569_3.color.r, 1, var_569_28)

								iter_569_3.color = Color.New(var_569_32, var_569_32, var_569_32)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= var_569_26 + var_569_27 and arg_566_1.time_ < var_569_26 + var_569_27 + arg_569_0 and not isNil(var_569_25) and arg_566_1.var_.actorSpriteComps1034 then
				for iter_569_4, iter_569_5 in pairs(arg_566_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_569_5 then
						if arg_566_1.isInRecall_ then
							iter_569_5.color = arg_566_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_569_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_566_1.var_.actorSpriteComps1034 = nil
			end

			local var_569_33 = arg_566_1.actors_["1034"].transform
			local var_569_34 = 3.23333333333333

			if var_569_34 < arg_566_1.time_ and arg_566_1.time_ <= var_569_34 + arg_569_0 then
				arg_566_1.var_.moveOldPos1034 = var_569_33.localPosition
				var_569_33.localScale = Vector3.New(1, 1, 1)

				arg_566_1:CheckSpriteTmpPos("1034", 3)

				local var_569_35 = var_569_33.childCount

				for iter_569_6 = 0, var_569_35 - 1 do
					local var_569_36 = var_569_33:GetChild(iter_569_6)

					if var_569_36.name == "" or not string.find(var_569_36.name, "split") then
						var_569_36.gameObject:SetActive(true)
					else
						var_569_36.gameObject:SetActive(false)
					end
				end
			end

			local var_569_37 = 0.001

			if var_569_34 <= arg_566_1.time_ and arg_566_1.time_ < var_569_34 + var_569_37 then
				local var_569_38 = (arg_566_1.time_ - var_569_34) / var_569_37
				local var_569_39 = Vector3.New(0, -331.9, -324)

				var_569_33.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1034, var_569_39, var_569_38)
			end

			if arg_566_1.time_ >= var_569_34 + var_569_37 and arg_566_1.time_ < var_569_34 + var_569_37 + arg_569_0 then
				var_569_33.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_569_40 = 1.63333333333333

			arg_566_1.isInRecall_ = false

			if var_569_40 < arg_566_1.time_ and arg_566_1.time_ <= var_569_40 + arg_569_0 then
				arg_566_1.screenFilterGo_:SetActive(false)

				for iter_569_7, iter_569_8 in pairs(arg_566_1.actors_) do
					local var_569_41 = iter_569_8:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_569_9, iter_569_10 in ipairs(var_569_41) do
						if iter_569_10.color.r > 0.51 then
							iter_569_10.color = Color.New(1, 1, 1)
						else
							iter_569_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_569_42 = 0.0166666666666667

			if var_569_40 <= arg_566_1.time_ and arg_566_1.time_ < var_569_40 + var_569_42 then
				local var_569_43 = (arg_566_1.time_ - var_569_40) / var_569_42

				arg_566_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_569_43)
			end

			if arg_566_1.time_ >= var_569_40 + var_569_42 and arg_566_1.time_ < var_569_40 + var_569_42 + arg_569_0 then
				arg_566_1.screenFilterEffect_.weight = 0
			end

			local var_569_44 = arg_566_1.actors_["1034"]
			local var_569_45 = 3.23333333333333

			if var_569_45 < arg_566_1.time_ and arg_566_1.time_ <= var_569_45 + arg_569_0 then
				local var_569_46 = var_569_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_569_46 then
					arg_566_1.var_.alphaOldValue1034 = var_569_46.alpha
					arg_566_1.var_.characterEffect1034 = var_569_46
				end

				arg_566_1.var_.alphaOldValue1034 = 0
			end

			local var_569_47 = 0.3

			if var_569_45 <= arg_566_1.time_ and arg_566_1.time_ < var_569_45 + var_569_47 then
				local var_569_48 = (arg_566_1.time_ - var_569_45) / var_569_47
				local var_569_49 = Mathf.Lerp(arg_566_1.var_.alphaOldValue1034, 1, var_569_48)

				if arg_566_1.var_.characterEffect1034 then
					arg_566_1.var_.characterEffect1034.alpha = var_569_49
				end
			end

			if arg_566_1.time_ >= var_569_45 + var_569_47 and arg_566_1.time_ < var_569_45 + var_569_47 + arg_569_0 and arg_566_1.var_.characterEffect1034 then
				arg_566_1.var_.characterEffect1034.alpha = 1
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_50 = 3.63333333333333
			local var_569_51 = 0.3

			if var_569_50 < arg_566_1.time_ and arg_566_1.time_ <= var_569_50 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_52 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_52:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_53 = arg_566_1:FormatText(StoryNameCfg[1109].name)

				arg_566_1.leftNameTxt_.text = var_569_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_54 = arg_566_1:GetWordFromCfg(417031135)
				local var_569_55 = arg_566_1:FormatText(var_569_54.content)

				arg_566_1.text_.text = var_569_55

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_56 = 12
				local var_569_57 = utf8.len(var_569_55)
				local var_569_58 = var_569_56 <= 0 and var_569_51 or var_569_51 * (var_569_57 / var_569_56)

				if var_569_58 > 0 and var_569_51 < var_569_58 then
					arg_566_1.talkMaxDuration = var_569_58
					var_569_50 = var_569_50 + 0.3

					if var_569_58 + var_569_50 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_58 + var_569_50
					end
				end

				arg_566_1.text_.text = var_569_55
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031135", "story_v_out_417031.awb") ~= 0 then
					local var_569_59 = manager.audio:GetVoiceLength("story_v_out_417031", "417031135", "story_v_out_417031.awb") / 1000

					if var_569_59 + var_569_50 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_59 + var_569_50
					end

					if var_569_54.prefab_name ~= "" and arg_566_1.actors_[var_569_54.prefab_name] ~= nil then
						local var_569_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_54.prefab_name].transform, "story_v_out_417031", "417031135", "story_v_out_417031.awb")

						arg_566_1:RecordAudio("417031135", var_569_60)
						arg_566_1:RecordAudio("417031135", var_569_60)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_417031", "417031135", "story_v_out_417031.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_417031", "417031135", "story_v_out_417031.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_61 = var_569_50 + 0.3
			local var_569_62 = math.max(var_569_51, arg_566_1.talkMaxDuration)

			if var_569_61 <= arg_566_1.time_ and arg_566_1.time_ < var_569_61 + var_569_62 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_61) / var_569_62

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_61 + var_569_62 and arg_566_1.time_ < var_569_61 + var_569_62 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play417031136 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 417031136
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play417031137(arg_572_1)
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
								local var_575_4 = Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor2.r, var_575_3)
								local var_575_5 = Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor2.g, var_575_3)
								local var_575_6 = Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor2.b, var_575_3)

								iter_575_1.color = Color.New(var_575_4, var_575_5, var_575_6)
							else
								local var_575_7 = Mathf.Lerp(iter_575_1.color.r, 0.5, var_575_3)

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
							iter_575_3.color = arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_575_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_572_1.var_.actorSpriteComps1034 = nil
			end

			local var_575_8 = 0
			local var_575_9 = 0.675

			if var_575_8 < arg_572_1.time_ and arg_572_1.time_ <= var_575_8 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_10 = arg_572_1:GetWordFromCfg(417031136)
				local var_575_11 = arg_572_1:FormatText(var_575_10.content)

				arg_572_1.text_.text = var_575_11

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_12 = 27
				local var_575_13 = utf8.len(var_575_11)
				local var_575_14 = var_575_12 <= 0 and var_575_9 or var_575_9 * (var_575_13 / var_575_12)

				if var_575_14 > 0 and var_575_9 < var_575_14 then
					arg_572_1.talkMaxDuration = var_575_14

					if var_575_14 + var_575_8 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_14 + var_575_8
					end
				end

				arg_572_1.text_.text = var_575_11
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_15 = math.max(var_575_9, arg_572_1.talkMaxDuration)

			if var_575_8 <= arg_572_1.time_ and arg_572_1.time_ < var_575_8 + var_575_15 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_8) / var_575_15

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_8 + var_575_15 and arg_572_1.time_ < var_575_8 + var_575_15 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play417031137 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 417031137
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play417031138(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 1.125

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_2 = arg_576_1:GetWordFromCfg(417031137)
				local var_579_3 = arg_576_1:FormatText(var_579_2.content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_4 = 45
				local var_579_5 = utf8.len(var_579_3)
				local var_579_6 = var_579_4 <= 0 and var_579_1 or var_579_1 * (var_579_5 / var_579_4)

				if var_579_6 > 0 and var_579_1 < var_579_6 then
					arg_576_1.talkMaxDuration = var_579_6

					if var_579_6 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_6 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_7 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_7 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_0) / var_579_7

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_7 and arg_576_1.time_ < var_579_0 + var_579_7 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play417031138 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 417031138
		arg_580_1.duration_ = 4.6

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
			arg_580_1.auto_ = false
		end

		function arg_580_1.playNext_(arg_582_0)
			arg_580_1.onStoryFinished_()
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["1034"].transform
			local var_583_1 = 1.266

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.var_.moveOldPos1034 = var_583_0.localPosition
				var_583_0.localScale = Vector3.New(1, 1, 1)

				arg_580_1:CheckSpriteTmpPos("1034", 7)

				local var_583_2 = var_583_0.childCount

				for iter_583_0 = 0, var_583_2 - 1 do
					local var_583_3 = var_583_0:GetChild(iter_583_0)

					if var_583_3.name == "" or not string.find(var_583_3.name, "split") then
						var_583_3.gameObject:SetActive(true)
					else
						var_583_3.gameObject:SetActive(false)
					end
				end
			end

			local var_583_4 = 0.001

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_4 then
				local var_583_5 = (arg_580_1.time_ - var_583_1) / var_583_4
				local var_583_6 = Vector3.New(0, -2000, 0)

				var_583_0.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1034, var_583_6, var_583_5)
			end

			if arg_580_1.time_ >= var_583_1 + var_583_4 and arg_580_1.time_ < var_583_1 + var_583_4 + arg_583_0 then
				var_583_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_583_7 = 1.334

			if var_583_7 < arg_580_1.time_ and arg_580_1.time_ <= var_583_7 + arg_583_0 then
				arg_580_1.cswbg_:SetActive(true)

				local var_583_8 = arg_580_1.cswt_:GetComponent("RectTransform")

				arg_580_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_583_8.offsetMin = Vector2.New(400, 105)
				var_583_8.offsetMax = Vector2.New(-400, -200)

				local var_583_9 = arg_580_1:GetWordFromCfg(419097)
				local var_583_10 = arg_580_1:FormatText(var_583_9.content)

				arg_580_1.cswt_.text = var_583_10

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.cswt_)

				arg_580_1.cswt_.fontSize = 72
				arg_580_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_580_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_580_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_583_11 = 1.3

			if var_583_11 < arg_580_1.time_ and arg_580_1.time_ <= var_583_11 + arg_583_0 then
				arg_580_1.fswbg_:SetActive(true)
				arg_580_1.dialog_:SetActive(false)

				arg_580_1.fswtw_.percent = 0

				local var_583_12 = arg_580_1:GetWordFromCfg(417031138)
				local var_583_13 = arg_580_1:FormatText(var_583_12.content)

				arg_580_1.fswt_.text = var_583_13

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.fswt_)

				arg_580_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_580_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_580_1.fswtw_:SetDirty()

				arg_580_1.typewritterCharCountI18N = 0

				SetActive(arg_580_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_580_1:ShowNextGo(false)
			end

			local var_583_14 = 1.93333333333333

			if var_583_14 < arg_580_1.time_ and arg_580_1.time_ <= var_583_14 + arg_583_0 then
				arg_580_1.var_.oldValueTypewriter = arg_580_1.fswtw_.percent

				SetActive(arg_580_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_580_1:ShowNextGo(false)
			end

			local var_583_15 = 11
			local var_583_16 = 0.733333333333333
			local var_583_17 = arg_580_1:GetWordFromCfg(417031138)
			local var_583_18 = arg_580_1:FormatText(var_583_17.content)
			local var_583_19, var_583_20 = arg_580_1:GetPercentByPara(var_583_18, 1)

			if var_583_14 < arg_580_1.time_ and arg_580_1.time_ <= var_583_14 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0

				local var_583_21 = var_583_15 <= 0 and var_583_16 or var_583_16 * ((var_583_20 - arg_580_1.typewritterCharCountI18N) / var_583_15)

				if var_583_21 > 0 and var_583_16 < var_583_21 then
					arg_580_1.talkMaxDuration = var_583_21

					if var_583_21 + var_583_14 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_21 + var_583_14
					end
				end
			end

			local var_583_22 = 0.733333333333333
			local var_583_23 = math.max(var_583_22, arg_580_1.talkMaxDuration)

			if var_583_14 <= arg_580_1.time_ and arg_580_1.time_ < var_583_14 + var_583_23 then
				local var_583_24 = (arg_580_1.time_ - var_583_14) / var_583_23

				arg_580_1.fswtw_.percent = Mathf.Lerp(arg_580_1.var_.oldValueTypewriter, var_583_19, var_583_24)
				arg_580_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_580_1.fswtw_:SetDirty()
			end

			if arg_580_1.time_ >= var_583_14 + var_583_23 and arg_580_1.time_ < var_583_14 + var_583_23 + arg_583_0 then
				arg_580_1.fswtw_.percent = var_583_19

				arg_580_1.fswtw_:SetDirty()
				arg_580_1:ShowNextGo(true)

				arg_580_1.typewritterCharCountI18N = var_583_20
			end

			local var_583_25 = 1.3

			if var_583_25 < arg_580_1.time_ and arg_580_1.time_ <= var_583_25 + arg_583_0 then
				local var_583_26 = manager.ui.mainCamera.transform.localPosition
				local var_583_27 = Vector3.New(0, 0, 10) + Vector3.New(var_583_26.x, var_583_26.y, 0)
				local var_583_28 = arg_580_1.bgs_.STblack

				var_583_28.transform.localPosition = var_583_27
				var_583_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_583_29 = var_583_28:GetComponent("SpriteRenderer")

				if var_583_29 and var_583_29.sprite then
					local var_583_30 = (var_583_28.transform.localPosition - var_583_26).z
					local var_583_31 = manager.ui.mainCameraCom_
					local var_583_32 = 2 * var_583_30 * Mathf.Tan(var_583_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_583_33 = var_583_32 * var_583_31.aspect
					local var_583_34 = var_583_29.sprite.bounds.size.x
					local var_583_35 = var_583_29.sprite.bounds.size.y
					local var_583_36 = var_583_33 / var_583_34
					local var_583_37 = var_583_32 / var_583_35
					local var_583_38 = var_583_37 < var_583_36 and var_583_36 or var_583_37

					var_583_28.transform.localScale = Vector3.New(var_583_38, var_583_38, 0)
				end

				for iter_583_1, iter_583_2 in pairs(arg_580_1.bgs_) do
					if iter_583_1 ~= "STblack" then
						iter_583_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_583_39 = 1.3

			if var_583_39 < arg_580_1.time_ and arg_580_1.time_ <= var_583_39 + arg_583_0 then
				local var_583_40 = arg_580_1.fswbg_.transform:Find("textbox/adapt/content") or arg_580_1.fswbg_.transform:Find("textbox/content")
				local var_583_41 = arg_580_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_583_42 = var_583_40:GetComponent("Text")
				local var_583_43 = var_583_40:GetComponent("RectTransform")

				var_583_42.alignment = UnityEngine.TextAnchor.LowerCenter
				var_583_43.offsetMin = Vector2.New(0, 0)
				var_583_43.offsetMax = Vector2.New(0, 0)
			end

			local var_583_44 = 0

			if var_583_44 < arg_580_1.time_ and arg_580_1.time_ <= var_583_44 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_45 = 1.3

			if var_583_44 <= arg_580_1.time_ and arg_580_1.time_ < var_583_44 + var_583_45 then
				local var_583_46 = (arg_580_1.time_ - var_583_44) / var_583_45
				local var_583_47 = Color.New(0, 0, 0)

				var_583_47.a = Mathf.Lerp(0, 1, var_583_46)
				arg_580_1.mask_.color = var_583_47
			end

			if arg_580_1.time_ >= var_583_44 + var_583_45 and arg_580_1.time_ < var_583_44 + var_583_45 + arg_583_0 then
				local var_583_48 = Color.New(0, 0, 0)

				var_583_48.a = 1
				arg_580_1.mask_.color = var_583_48
			end

			local var_583_49 = 1.3

			if var_583_49 < arg_580_1.time_ and arg_580_1.time_ <= var_583_49 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_50 = 2

			if var_583_49 <= arg_580_1.time_ and arg_580_1.time_ < var_583_49 + var_583_50 then
				local var_583_51 = (arg_580_1.time_ - var_583_49) / var_583_50
				local var_583_52 = Color.New(0, 0, 0)

				var_583_52.a = Mathf.Lerp(1, 0, var_583_51)
				arg_580_1.mask_.color = var_583_52
			end

			if arg_580_1.time_ >= var_583_49 + var_583_50 and arg_580_1.time_ < var_583_49 + var_583_50 + arg_583_0 then
				local var_583_53 = Color.New(0, 0, 0)
				local var_583_54 = 0

				arg_580_1.mask_.enabled = false
				var_583_53.a = var_583_54
				arg_580_1.mask_.color = var_583_53
			end

			local var_583_55 = 1.93333333333333
			local var_583_56 = 2.666
			local var_583_57 = manager.audio:GetVoiceLength("story_v_out_417031", "417031138", "") / 1000

			if var_583_57 > 0 and var_583_56 < var_583_57 and var_583_57 + var_583_55 > arg_580_1.duration_ then
				local var_583_58 = var_583_57

				arg_580_1.duration_ = var_583_57 + var_583_55
			end

			if var_583_55 < arg_580_1.time_ and arg_580_1.time_ <= var_583_55 + arg_583_0 then
				local var_583_59 = "play"
				local var_583_60 = "voice"

				arg_580_1:AudioAction(var_583_59, var_583_60, "story_v_out_417031", "417031138", "")
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0340000000000009,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST77a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST04c",
		"TextureConfig/Background/I05e",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/SS1702"
	},
	voices = {
		"story_v_out_417031.awb"
	}
}
