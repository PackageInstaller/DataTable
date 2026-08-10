return {
	Play425031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425031001
		arg_1_1.duration_ = 13.63

		local var_1_0 = {
			zh = 9.56600033333333,
			ja = 13.6330003333333
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
				arg_1_0:Play425031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "M01i"

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
				local var_4_5 = arg_1_1.bgs_.M01i

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
					if iter_4_0 ~= "M01i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 4.40000033333333

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.75

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0
			local var_4_19 = 1.999999999999
			local var_4_20 = "M01i"

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)

				arg_1_1.timestampColorController_:SetSelectedState("hot")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_21 = arg_1_1:GetWordFromCfg(501098)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_timeText_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_23 = arg_1_1:GetWordFromCfg(501099)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_siteText_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_25 = 2.00000033333333

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_26 = 1.2

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Color.New(0, 0, 0)

				var_4_28.a = Mathf.Lerp(0, 1, var_4_27)
				arg_1_1.mask_.color = var_4_28
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				local var_4_29 = Color.New(0, 0, 0)

				var_4_29.a = 1
				arg_1_1.mask_.color = var_4_29
			end

			local var_4_30 = 3.20000033333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_31 = 1.2

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Color.New(0, 0, 0)

				var_4_33.a = Mathf.Lerp(1, 0, var_4_32)
				arg_1_1.mask_.color = var_4_33
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				local var_4_34 = Color.New(0, 0, 0)
				local var_4_35 = 0

				arg_1_1.mask_.enabled = false
				var_4_34.a = var_4_35
				arg_1_1.mask_.color = var_4_34
			end

			local var_4_36 = 2.83333333333333
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_4_40 = 0
			local var_4_41 = 0.3

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_46 = 2.83333333333333
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 4.40000033333333
			local var_4_53 = 0.75

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[688].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_56 = arg_1_1:GetWordFromCfg(425031001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 30
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031001", "story_v_out_425031.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_425031", "425031001", "story_v_out_425031.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_425031", "425031001", "story_v_out_425031.awb")

						arg_1_1:RecordAudio("425031001", var_4_62)
						arg_1_1:RecordAudio("425031001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425031", "425031001", "story_v_out_425031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425031", "425031001", "story_v_out_425031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play425031002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425031002
		arg_10_1.duration_ = 7.73

		local var_10_0 = {
			zh = 4.666,
			ja = 7.733
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425031003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1086"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

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

			local var_13_4 = arg_10_1.actors_["1086"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1086 == nil then
				arg_10_1.var_.actorSpriteComps1086 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps1086 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								local var_13_8 = Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor1.r, var_13_7)
								local var_13_9 = Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor1.g, var_13_7)
								local var_13_10 = Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor1.b, var_13_7)

								iter_13_3.color = Color.New(var_13_8, var_13_9, var_13_10)
							else
								local var_13_11 = Mathf.Lerp(iter_13_3.color.r, 1, var_13_7)

								iter_13_3.color = Color.New(var_13_11, var_13_11, var_13_11)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1086 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_13_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1086 = nil
			end

			local var_13_12 = arg_10_1.actors_["1086"].transform
			local var_13_13 = 0

			if var_13_13 < arg_10_1.time_ and arg_10_1.time_ <= var_13_13 + arg_13_0 then
				arg_10_1.var_.moveOldPos1086 = var_13_12.localPosition
				var_13_12.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1086", 3)

				local var_13_14 = var_13_12.childCount

				for iter_13_6 = 0, var_13_14 - 1 do
					local var_13_15 = var_13_12:GetChild(iter_13_6)

					if var_13_15.name == "split_6" or not string.find(var_13_15.name, "split") then
						var_13_15.gameObject:SetActive(true)
					else
						var_13_15.gameObject:SetActive(false)
					end
				end
			end

			local var_13_16 = 0.001

			if var_13_13 <= arg_10_1.time_ and arg_10_1.time_ < var_13_13 + var_13_16 then
				local var_13_17 = (arg_10_1.time_ - var_13_13) / var_13_16
				local var_13_18 = Vector3.New(0, -404.2, -237.9)

				var_13_12.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1086, var_13_18, var_13_17)
			end

			if arg_10_1.time_ >= var_13_13 + var_13_16 and arg_10_1.time_ < var_13_13 + var_13_16 + arg_13_0 then
				var_13_12.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_13_19 = 0
			local var_13_20 = 0.475

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_21 = arg_10_1:FormatText(StoryNameCfg[1080].name)

				arg_10_1.leftNameTxt_.text = var_13_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_22 = arg_10_1:GetWordFromCfg(425031002)
				local var_13_23 = arg_10_1:FormatText(var_13_22.content)

				arg_10_1.text_.text = var_13_23

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_24 = 19
				local var_13_25 = utf8.len(var_13_23)
				local var_13_26 = var_13_24 <= 0 and var_13_20 or var_13_20 * (var_13_25 / var_13_24)

				if var_13_26 > 0 and var_13_20 < var_13_26 then
					arg_10_1.talkMaxDuration = var_13_26

					if var_13_26 + var_13_19 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_26 + var_13_19
					end
				end

				arg_10_1.text_.text = var_13_23
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031002", "story_v_out_425031.awb") ~= 0 then
					local var_13_27 = manager.audio:GetVoiceLength("story_v_out_425031", "425031002", "story_v_out_425031.awb") / 1000

					if var_13_27 + var_13_19 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_27 + var_13_19
					end

					if var_13_22.prefab_name ~= "" and arg_10_1.actors_[var_13_22.prefab_name] ~= nil then
						local var_13_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_22.prefab_name].transform, "story_v_out_425031", "425031002", "story_v_out_425031.awb")

						arg_10_1:RecordAudio("425031002", var_13_28)
						arg_10_1:RecordAudio("425031002", var_13_28)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_425031", "425031002", "story_v_out_425031.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_425031", "425031002", "story_v_out_425031.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_29 = math.max(var_13_20, arg_10_1.talkMaxDuration)

			if var_13_19 <= arg_10_1.time_ and arg_10_1.time_ < var_13_19 + var_13_29 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_19) / var_13_29

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_19 + var_13_29 and arg_10_1.time_ < var_13_19 + var_13_29 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play425031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425031003
		arg_14_1.duration_ = 1.03

		local var_14_0 = {
			zh = 0.999999999999,
			ja = 1.033
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
				arg_14_0:Play425031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1086"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1086 == nil then
				arg_14_1.var_.actorSpriteComps1086 = var_17_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.actorSpriteComps1086 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								local var_17_4 = Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor2.r, var_17_3)
								local var_17_5 = Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor2.g, var_17_3)
								local var_17_6 = Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor2.b, var_17_3)

								iter_17_1.color = Color.New(var_17_4, var_17_5, var_17_6)
							else
								local var_17_7 = Mathf.Lerp(iter_17_1.color.r, 0.5, var_17_3)

								iter_17_1.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1086 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_17_3 then
						if arg_14_1.isInRecall_ then
							iter_17_3.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1086 = nil
			end

			local var_17_8 = 0
			local var_17_9 = 0.075

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_10 = arg_14_1:FormatText(StoryNameCfg[688].name)

				arg_14_1.leftNameTxt_.text = var_17_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_11 = arg_14_1:GetWordFromCfg(425031003)
				local var_17_12 = arg_14_1:FormatText(var_17_11.content)

				arg_14_1.text_.text = var_17_12

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_13 = 3
				local var_17_14 = utf8.len(var_17_12)
				local var_17_15 = var_17_13 <= 0 and var_17_9 or var_17_9 * (var_17_14 / var_17_13)

				if var_17_15 > 0 and var_17_9 < var_17_15 then
					arg_14_1.talkMaxDuration = var_17_15

					if var_17_15 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_15 + var_17_8
					end
				end

				arg_14_1.text_.text = var_17_12
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031003", "story_v_out_425031.awb") ~= 0 then
					local var_17_16 = manager.audio:GetVoiceLength("story_v_out_425031", "425031003", "story_v_out_425031.awb") / 1000

					if var_17_16 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_16 + var_17_8
					end

					if var_17_11.prefab_name ~= "" and arg_14_1.actors_[var_17_11.prefab_name] ~= nil then
						local var_17_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_11.prefab_name].transform, "story_v_out_425031", "425031003", "story_v_out_425031.awb")

						arg_14_1:RecordAudio("425031003", var_17_17)
						arg_14_1:RecordAudio("425031003", var_17_17)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_425031", "425031003", "story_v_out_425031.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_425031", "425031003", "story_v_out_425031.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_18 = math.max(var_17_9, arg_14_1.talkMaxDuration)

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_18 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_8) / var_17_18

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_8 + var_17_18 and arg_14_1.time_ < var_17_8 + var_17_18 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play425031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425031004
		arg_18_1.duration_ = 8.93

		local var_18_0 = {
			zh = 5.4,
			ja = 8.933
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
				arg_18_0:Play425031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1086"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1086 == nil then
				arg_18_1.var_.actorSpriteComps1086 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1086 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 1, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1086 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1086 = nil
			end

			local var_21_8 = arg_18_1.actors_["1086"].transform
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.var_.moveOldPos1086 = var_21_8.localPosition
				var_21_8.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1086", 3)

				local var_21_10 = var_21_8.childCount

				for iter_21_4 = 0, var_21_10 - 1 do
					local var_21_11 = var_21_8:GetChild(iter_21_4)

					if var_21_11.name == "split_6" or not string.find(var_21_11.name, "split") then
						var_21_11.gameObject:SetActive(true)
					else
						var_21_11.gameObject:SetActive(false)
					end
				end
			end

			local var_21_12 = 0.001

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_9) / var_21_12
				local var_21_14 = Vector3.New(0, -404.2, -237.9)

				var_21_8.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1086, var_21_14, var_21_13)
			end

			if arg_18_1.time_ >= var_21_9 + var_21_12 and arg_18_1.time_ < var_21_9 + var_21_12 + arg_21_0 then
				var_21_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_21_15 = 0
			local var_21_16 = 0.7

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_17 = arg_18_1:FormatText(StoryNameCfg[1080].name)

				arg_18_1.leftNameTxt_.text = var_21_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_18 = arg_18_1:GetWordFromCfg(425031004)
				local var_21_19 = arg_18_1:FormatText(var_21_18.content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_20 = 28
				local var_21_21 = utf8.len(var_21_19)
				local var_21_22 = var_21_20 <= 0 and var_21_16 or var_21_16 * (var_21_21 / var_21_20)

				if var_21_22 > 0 and var_21_16 < var_21_22 then
					arg_18_1.talkMaxDuration = var_21_22

					if var_21_22 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_22 + var_21_15
					end
				end

				arg_18_1.text_.text = var_21_19
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031004", "story_v_out_425031.awb") ~= 0 then
					local var_21_23 = manager.audio:GetVoiceLength("story_v_out_425031", "425031004", "story_v_out_425031.awb") / 1000

					if var_21_23 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_15
					end

					if var_21_18.prefab_name ~= "" and arg_18_1.actors_[var_21_18.prefab_name] ~= nil then
						local var_21_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_18.prefab_name].transform, "story_v_out_425031", "425031004", "story_v_out_425031.awb")

						arg_18_1:RecordAudio("425031004", var_21_24)
						arg_18_1:RecordAudio("425031004", var_21_24)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425031", "425031004", "story_v_out_425031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425031", "425031004", "story_v_out_425031.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_25 = math.max(var_21_16, arg_18_1.talkMaxDuration)

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_25 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_15) / var_21_25

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_15 + var_21_25 and arg_18_1.time_ < var_21_15 + var_21_25 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play425031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425031005
		arg_22_1.duration_ = 4.1

		local var_22_0 = {
			zh = 4.1,
			ja = 3.9
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
				arg_22_0:Play425031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1086"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1086 == nil then
				arg_22_1.var_.actorSpriteComps1086 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1086 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								local var_25_4 = Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, var_25_3)
								local var_25_5 = Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, var_25_3)
								local var_25_6 = Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, var_25_3)

								iter_25_1.color = Color.New(var_25_4, var_25_5, var_25_6)
							else
								local var_25_7 = Mathf.Lerp(iter_25_1.color.r, 0.5, var_25_3)

								iter_25_1.color = Color.New(var_25_7, var_25_7, var_25_7)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1086 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1086 = nil
			end

			local var_25_8 = 0
			local var_25_9 = 0.5

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_10 = arg_22_1:FormatText(StoryNameCfg[1430].name)

				arg_22_1.leftNameTxt_.text = var_25_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_11 = arg_22_1:GetWordFromCfg(425031005)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.text_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 20
				local var_25_14 = utf8.len(var_25_12)
				local var_25_15 = var_25_13 <= 0 and var_25_9 or var_25_9 * (var_25_14 / var_25_13)

				if var_25_15 > 0 and var_25_9 < var_25_15 then
					arg_22_1.talkMaxDuration = var_25_15

					if var_25_15 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_15 + var_25_8
					end
				end

				arg_22_1.text_.text = var_25_12
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031005", "story_v_out_425031.awb") ~= 0 then
					local var_25_16 = manager.audio:GetVoiceLength("story_v_out_425031", "425031005", "story_v_out_425031.awb") / 1000

					if var_25_16 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_16 + var_25_8
					end

					if var_25_11.prefab_name ~= "" and arg_22_1.actors_[var_25_11.prefab_name] ~= nil then
						local var_25_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_11.prefab_name].transform, "story_v_out_425031", "425031005", "story_v_out_425031.awb")

						arg_22_1:RecordAudio("425031005", var_25_17)
						arg_22_1:RecordAudio("425031005", var_25_17)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_425031", "425031005", "story_v_out_425031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_425031", "425031005", "story_v_out_425031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_18 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_18 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_18

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_18 and arg_22_1.time_ < var_25_8 + var_25_18 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425031006
		arg_26_1.duration_ = 8.83

		local var_26_0 = {
			zh = 7.433,
			ja = 8.833
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
				arg_26_0:Play425031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1086"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 == nil then
				arg_26_1.var_.actorSpriteComps1086 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps1086 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1086 = nil
			end

			local var_29_8 = arg_26_1.actors_["1086"].transform
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.var_.moveOldPos1086 = var_29_8.localPosition
				var_29_8.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1086", 3)

				local var_29_10 = var_29_8.childCount

				for iter_29_4 = 0, var_29_10 - 1 do
					local var_29_11 = var_29_8:GetChild(iter_29_4)

					if var_29_11.name == "split_6" or not string.find(var_29_11.name, "split") then
						var_29_11.gameObject:SetActive(true)
					else
						var_29_11.gameObject:SetActive(false)
					end
				end
			end

			local var_29_12 = 0.001

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_12 then
				local var_29_13 = (arg_26_1.time_ - var_29_9) / var_29_12
				local var_29_14 = Vector3.New(0, -404.2, -237.9)

				var_29_8.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1086, var_29_14, var_29_13)
			end

			if arg_26_1.time_ >= var_29_9 + var_29_12 and arg_26_1.time_ < var_29_9 + var_29_12 + arg_29_0 then
				var_29_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_29_15 = 0
			local var_29_16 = 0.975

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[1080].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(425031006)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 39
				local var_29_21 = utf8.len(var_29_19)
				local var_29_22 = var_29_20 <= 0 and var_29_16 or var_29_16 * (var_29_21 / var_29_20)

				if var_29_22 > 0 and var_29_16 < var_29_22 then
					arg_26_1.talkMaxDuration = var_29_22

					if var_29_22 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_22 + var_29_15
					end
				end

				arg_26_1.text_.text = var_29_19
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031006", "story_v_out_425031.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_425031", "425031006", "story_v_out_425031.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_425031", "425031006", "story_v_out_425031.awb")

						arg_26_1:RecordAudio("425031006", var_29_24)
						arg_26_1:RecordAudio("425031006", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425031", "425031006", "story_v_out_425031.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425031", "425031006", "story_v_out_425031.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_25 = math.max(var_29_16, arg_26_1.talkMaxDuration)

			if var_29_15 <= arg_26_1.time_ and arg_26_1.time_ < var_29_15 + var_29_25 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_15) / var_29_25

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_15 + var_29_25 and arg_26_1.time_ < var_29_15 + var_29_25 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play425031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425031007
		arg_30_1.duration_ = 1.33

		local var_30_0 = {
			zh = 1.133,
			ja = 1.333
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
				arg_30_0:Play425031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1086"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos1086 = var_33_0.localPosition
				var_33_0.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1086", 3)

				local var_33_2 = var_33_0.childCount

				for iter_33_0 = 0, var_33_2 - 1 do
					local var_33_3 = var_33_0:GetChild(iter_33_0)

					if var_33_3.name == "split_4" then
						var_33_3:SetAsLastSibling()
						var_33_3.gameObject:SetActive(true)

						arg_30_1.var_.actorSpriteSplit1086 = var_33_3.gameObject:GetComponent(typeof(Image))

						arg_30_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_33_4 = 0.5

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_4 then
				local var_33_5 = (arg_30_1.time_ - var_33_1) / var_33_4
				local var_33_6 = Vector3.New(0, -404.2, -237.9)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1086, var_33_6, var_33_5)

				if arg_30_1.var_.actorSpriteSplit1086 ~= nil then
					arg_30_1.var_.actorSpriteSplit1086:SetAlpha(var_33_5)
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_4 and arg_30_1.time_ < var_33_1 + var_33_4 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_30_1.var_.actorSpriteSplit1086 ~= nil then
					arg_30_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_33_7 = 0

			if var_33_7 < arg_30_1.time_ and arg_30_1.time_ <= var_33_7 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_8 = 0.5

			if arg_30_1.time_ >= var_33_7 + var_33_8 and arg_30_1.time_ < var_33_7 + var_33_8 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_9 = 0
			local var_33_10 = 0.1

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_11 = arg_30_1:FormatText(StoryNameCfg[1080].name)

				arg_30_1.leftNameTxt_.text = var_33_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_12 = arg_30_1:GetWordFromCfg(425031007)
				local var_33_13 = arg_30_1:FormatText(var_33_12.content)

				arg_30_1.text_.text = var_33_13

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_14 = 4
				local var_33_15 = utf8.len(var_33_13)
				local var_33_16 = var_33_14 <= 0 and var_33_10 or var_33_10 * (var_33_15 / var_33_14)

				if var_33_16 > 0 and var_33_10 < var_33_16 then
					arg_30_1.talkMaxDuration = var_33_16

					if var_33_16 + var_33_9 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_16 + var_33_9
					end
				end

				arg_30_1.text_.text = var_33_13
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031007", "story_v_out_425031.awb") ~= 0 then
					local var_33_17 = manager.audio:GetVoiceLength("story_v_out_425031", "425031007", "story_v_out_425031.awb") / 1000

					if var_33_17 + var_33_9 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_17 + var_33_9
					end

					if var_33_12.prefab_name ~= "" and arg_30_1.actors_[var_33_12.prefab_name] ~= nil then
						local var_33_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_12.prefab_name].transform, "story_v_out_425031", "425031007", "story_v_out_425031.awb")

						arg_30_1:RecordAudio("425031007", var_33_18)
						arg_30_1:RecordAudio("425031007", var_33_18)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_425031", "425031007", "story_v_out_425031.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_425031", "425031007", "story_v_out_425031.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_19 = math.max(var_33_10, arg_30_1.talkMaxDuration)

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_19 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_9) / var_33_19

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_9 + var_33_19 and arg_30_1.time_ < var_33_9 + var_33_19 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play425031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425031008
		arg_34_1.duration_ = 2.2

		local var_34_0 = {
			zh = 1.8,
			ja = 2.2
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
				arg_34_0:Play425031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "1137"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

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

			local var_37_4 = arg_34_1.actors_["1137"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.actorSpriteComps1137 == nil then
				arg_34_1.var_.actorSpriteComps1137 = var_37_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_6 = 0.2

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.actorSpriteComps1137 then
					for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.actorSpriteComps1137 then
				for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_37_5 then
						if arg_34_1.isInRecall_ then
							iter_37_5.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1137 = nil
			end

			local var_37_12 = arg_34_1.actors_["1086"]
			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 and not isNil(var_37_12) and arg_34_1.var_.actorSpriteComps1086 == nil then
				arg_34_1.var_.actorSpriteComps1086 = var_37_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_14 = 0.2

			if var_37_13 <= arg_34_1.time_ and arg_34_1.time_ < var_37_13 + var_37_14 and not isNil(var_37_12) then
				local var_37_15 = (arg_34_1.time_ - var_37_13) / var_37_14

				if arg_34_1.var_.actorSpriteComps1086 then
					for iter_37_6, iter_37_7 in pairs(arg_34_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_37_7 then
							if arg_34_1.isInRecall_ then
								local var_37_16 = Mathf.Lerp(iter_37_7.color.r, arg_34_1.hightColor2.r, var_37_15)
								local var_37_17 = Mathf.Lerp(iter_37_7.color.g, arg_34_1.hightColor2.g, var_37_15)
								local var_37_18 = Mathf.Lerp(iter_37_7.color.b, arg_34_1.hightColor2.b, var_37_15)

								iter_37_7.color = Color.New(var_37_16, var_37_17, var_37_18)
							else
								local var_37_19 = Mathf.Lerp(iter_37_7.color.r, 0.5, var_37_15)

								iter_37_7.color = Color.New(var_37_19, var_37_19, var_37_19)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_13 + var_37_14 and arg_34_1.time_ < var_37_13 + var_37_14 + arg_37_0 and not isNil(var_37_12) and arg_34_1.var_.actorSpriteComps1086 then
				for iter_37_8, iter_37_9 in pairs(arg_34_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_37_9 then
						if arg_34_1.isInRecall_ then
							iter_37_9.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1086 = nil
			end

			local var_37_20 = arg_34_1.actors_["1137"].transform
			local var_37_21 = 0

			if var_37_21 < arg_34_1.time_ and arg_34_1.time_ <= var_37_21 + arg_37_0 then
				arg_34_1.var_.moveOldPos1137 = var_37_20.localPosition
				var_37_20.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1137", 2)

				local var_37_22 = var_37_20.childCount

				for iter_37_10 = 0, var_37_22 - 1 do
					local var_37_23 = var_37_20:GetChild(iter_37_10)

					if var_37_23.name == "" or not string.find(var_37_23.name, "split") then
						var_37_23.gameObject:SetActive(true)
					else
						var_37_23.gameObject:SetActive(false)
					end
				end
			end

			local var_37_24 = 0.001

			if var_37_21 <= arg_34_1.time_ and arg_34_1.time_ < var_37_21 + var_37_24 then
				local var_37_25 = (arg_34_1.time_ - var_37_21) / var_37_24
				local var_37_26 = Vector3.New(-390, -425, -200)

				var_37_20.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1137, var_37_26, var_37_25)
			end

			if arg_34_1.time_ >= var_37_21 + var_37_24 and arg_34_1.time_ < var_37_21 + var_37_24 + arg_37_0 then
				var_37_20.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_37_27 = arg_34_1.actors_["1086"].transform
			local var_37_28 = 0

			if var_37_28 < arg_34_1.time_ and arg_34_1.time_ <= var_37_28 + arg_37_0 then
				arg_34_1.var_.moveOldPos1086 = var_37_27.localPosition
				var_37_27.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1086", 4)

				local var_37_29 = var_37_27.childCount

				for iter_37_11 = 0, var_37_29 - 1 do
					local var_37_30 = var_37_27:GetChild(iter_37_11)

					if var_37_30.name == "" or not string.find(var_37_30.name, "split") then
						var_37_30.gameObject:SetActive(true)
					else
						var_37_30.gameObject:SetActive(false)
					end
				end
			end

			local var_37_31 = 0.001

			if var_37_28 <= arg_34_1.time_ and arg_34_1.time_ < var_37_28 + var_37_31 then
				local var_37_32 = (arg_34_1.time_ - var_37_28) / var_37_31
				local var_37_33 = Vector3.New(390, -404.2, -237.9)

				var_37_27.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1086, var_37_33, var_37_32)
			end

			if arg_34_1.time_ >= var_37_28 + var_37_31 and arg_34_1.time_ < var_37_28 + var_37_31 + arg_37_0 then
				var_37_27.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_37_34 = 0
			local var_37_35 = 0.15

			if var_37_34 < arg_34_1.time_ and arg_34_1.time_ <= var_37_34 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_36 = arg_34_1:FormatText(StoryNameCfg[15].name)

				arg_34_1.leftNameTxt_.text = var_37_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_37 = arg_34_1:GetWordFromCfg(425031008)
				local var_37_38 = arg_34_1:FormatText(var_37_37.content)

				arg_34_1.text_.text = var_37_38

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_39 = 6
				local var_37_40 = utf8.len(var_37_38)
				local var_37_41 = var_37_39 <= 0 and var_37_35 or var_37_35 * (var_37_40 / var_37_39)

				if var_37_41 > 0 and var_37_35 < var_37_41 then
					arg_34_1.talkMaxDuration = var_37_41

					if var_37_41 + var_37_34 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_41 + var_37_34
					end
				end

				arg_34_1.text_.text = var_37_38
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031008", "story_v_out_425031.awb") ~= 0 then
					local var_37_42 = manager.audio:GetVoiceLength("story_v_out_425031", "425031008", "story_v_out_425031.awb") / 1000

					if var_37_42 + var_37_34 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_42 + var_37_34
					end

					if var_37_37.prefab_name ~= "" and arg_34_1.actors_[var_37_37.prefab_name] ~= nil then
						local var_37_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_37.prefab_name].transform, "story_v_out_425031", "425031008", "story_v_out_425031.awb")

						arg_34_1:RecordAudio("425031008", var_37_43)
						arg_34_1:RecordAudio("425031008", var_37_43)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425031", "425031008", "story_v_out_425031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425031", "425031008", "story_v_out_425031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_44 = math.max(var_37_35, arg_34_1.talkMaxDuration)

			if var_37_34 <= arg_34_1.time_ and arg_34_1.time_ < var_37_34 + var_37_44 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_34) / var_37_44

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_34 + var_37_44 and arg_34_1.time_ < var_37_34 + var_37_44 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play425031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425031009
		arg_38_1.duration_ = 7.3

		local var_38_0 = {
			zh = 7.3,
			ja = 6.066
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
				arg_38_0:Play425031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1086"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1086 == nil then
				arg_38_1.var_.actorSpriteComps1086 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1086 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1086 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1086 = nil
			end

			local var_41_8 = arg_38_1.actors_["1137"]
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1137 == nil then
				arg_38_1.var_.actorSpriteComps1137 = var_41_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_10 = 0.2

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_10 and not isNil(var_41_8) then
				local var_41_11 = (arg_38_1.time_ - var_41_9) / var_41_10

				if arg_38_1.var_.actorSpriteComps1137 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								local var_41_12 = Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, var_41_11)
								local var_41_13 = Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, var_41_11)
								local var_41_14 = Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, var_41_11)

								iter_41_5.color = Color.New(var_41_12, var_41_13, var_41_14)
							else
								local var_41_15 = Mathf.Lerp(iter_41_5.color.r, 0.5, var_41_11)

								iter_41_5.color = Color.New(var_41_15, var_41_15, var_41_15)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_9 + var_41_10 and arg_38_1.time_ < var_41_9 + var_41_10 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1137 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_41_7 then
						if arg_38_1.isInRecall_ then
							iter_41_7.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1137 = nil
			end

			local var_41_16 = arg_38_1.actors_["1086"].transform
			local var_41_17 = 0

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 then
				arg_38_1.var_.moveOldPos1086 = var_41_16.localPosition
				var_41_16.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1086", 4)

				local var_41_18 = var_41_16.childCount

				for iter_41_8 = 0, var_41_18 - 1 do
					local var_41_19 = var_41_16:GetChild(iter_41_8)

					if var_41_19.name == "" or not string.find(var_41_19.name, "split") then
						var_41_19.gameObject:SetActive(true)
					else
						var_41_19.gameObject:SetActive(false)
					end
				end
			end

			local var_41_20 = 0.001

			if var_41_17 <= arg_38_1.time_ and arg_38_1.time_ < var_41_17 + var_41_20 then
				local var_41_21 = (arg_38_1.time_ - var_41_17) / var_41_20
				local var_41_22 = Vector3.New(390, -404.2, -237.9)

				var_41_16.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1086, var_41_22, var_41_21)
			end

			if arg_38_1.time_ >= var_41_17 + var_41_20 and arg_38_1.time_ < var_41_17 + var_41_20 + arg_41_0 then
				var_41_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_41_23 = 0
			local var_41_24 = 0.95

			if var_41_23 < arg_38_1.time_ and arg_38_1.time_ <= var_41_23 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_25 = arg_38_1:FormatText(StoryNameCfg[1080].name)

				arg_38_1.leftNameTxt_.text = var_41_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_26 = arg_38_1:GetWordFromCfg(425031009)
				local var_41_27 = arg_38_1:FormatText(var_41_26.content)

				arg_38_1.text_.text = var_41_27

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_28 = 38
				local var_41_29 = utf8.len(var_41_27)
				local var_41_30 = var_41_28 <= 0 and var_41_24 or var_41_24 * (var_41_29 / var_41_28)

				if var_41_30 > 0 and var_41_24 < var_41_30 then
					arg_38_1.talkMaxDuration = var_41_30

					if var_41_30 + var_41_23 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_30 + var_41_23
					end
				end

				arg_38_1.text_.text = var_41_27
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031009", "story_v_out_425031.awb") ~= 0 then
					local var_41_31 = manager.audio:GetVoiceLength("story_v_out_425031", "425031009", "story_v_out_425031.awb") / 1000

					if var_41_31 + var_41_23 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_31 + var_41_23
					end

					if var_41_26.prefab_name ~= "" and arg_38_1.actors_[var_41_26.prefab_name] ~= nil then
						local var_41_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_26.prefab_name].transform, "story_v_out_425031", "425031009", "story_v_out_425031.awb")

						arg_38_1:RecordAudio("425031009", var_41_32)
						arg_38_1:RecordAudio("425031009", var_41_32)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_425031", "425031009", "story_v_out_425031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_425031", "425031009", "story_v_out_425031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_33 = math.max(var_41_24, arg_38_1.talkMaxDuration)

			if var_41_23 <= arg_38_1.time_ and arg_38_1.time_ < var_41_23 + var_41_33 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_23) / var_41_33

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_23 + var_41_33 and arg_38_1.time_ < var_41_23 + var_41_33 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play425031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425031010
		arg_42_1.duration_ = 1.8

		local var_42_0 = {
			zh = 1.2,
			ja = 1.8
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
				arg_42_0:Play425031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1137"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1137 == nil then
				arg_42_1.var_.actorSpriteComps1137 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1137 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1137 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1137 = nil
			end

			local var_45_8 = arg_42_1.actors_["1086"]
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1086 == nil then
				arg_42_1.var_.actorSpriteComps1086 = var_45_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_10 = 0.2

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_10 and not isNil(var_45_8) then
				local var_45_11 = (arg_42_1.time_ - var_45_9) / var_45_10

				if arg_42_1.var_.actorSpriteComps1086 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								local var_45_12 = Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, var_45_11)
								local var_45_13 = Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, var_45_11)
								local var_45_14 = Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, var_45_11)

								iter_45_5.color = Color.New(var_45_12, var_45_13, var_45_14)
							else
								local var_45_15 = Mathf.Lerp(iter_45_5.color.r, 0.5, var_45_11)

								iter_45_5.color = Color.New(var_45_15, var_45_15, var_45_15)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_9 + var_45_10 and arg_42_1.time_ < var_45_9 + var_45_10 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1086 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_45_7 then
						if arg_42_1.isInRecall_ then
							iter_45_7.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1086 = nil
			end

			local var_45_16 = arg_42_1.actors_["1137"].transform
			local var_45_17 = 0

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 then
				arg_42_1.var_.moveOldPos1137 = var_45_16.localPosition
				var_45_16.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1137", 2)

				local var_45_18 = var_45_16.childCount

				for iter_45_8 = 0, var_45_18 - 1 do
					local var_45_19 = var_45_16:GetChild(iter_45_8)

					if var_45_19.name == "" or not string.find(var_45_19.name, "split") then
						var_45_19.gameObject:SetActive(true)
					else
						var_45_19.gameObject:SetActive(false)
					end
				end
			end

			local var_45_20 = 0.001

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_20 then
				local var_45_21 = (arg_42_1.time_ - var_45_17) / var_45_20
				local var_45_22 = Vector3.New(-390, -425, -200)

				var_45_16.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1137, var_45_22, var_45_21)
			end

			if arg_42_1.time_ >= var_45_17 + var_45_20 and arg_42_1.time_ < var_45_17 + var_45_20 + arg_45_0 then
				var_45_16.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_45_23 = 0
			local var_45_24 = 0.125

			if var_45_23 < arg_42_1.time_ and arg_42_1.time_ <= var_45_23 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_25 = arg_42_1:FormatText(StoryNameCfg[15].name)

				arg_42_1.leftNameTxt_.text = var_45_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_26 = arg_42_1:GetWordFromCfg(425031010)
				local var_45_27 = arg_42_1:FormatText(var_45_26.content)

				arg_42_1.text_.text = var_45_27

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_28 = 5
				local var_45_29 = utf8.len(var_45_27)
				local var_45_30 = var_45_28 <= 0 and var_45_24 or var_45_24 * (var_45_29 / var_45_28)

				if var_45_30 > 0 and var_45_24 < var_45_30 then
					arg_42_1.talkMaxDuration = var_45_30

					if var_45_30 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_30 + var_45_23
					end
				end

				arg_42_1.text_.text = var_45_27
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031010", "story_v_out_425031.awb") ~= 0 then
					local var_45_31 = manager.audio:GetVoiceLength("story_v_out_425031", "425031010", "story_v_out_425031.awb") / 1000

					if var_45_31 + var_45_23 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_31 + var_45_23
					end

					if var_45_26.prefab_name ~= "" and arg_42_1.actors_[var_45_26.prefab_name] ~= nil then
						local var_45_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_26.prefab_name].transform, "story_v_out_425031", "425031010", "story_v_out_425031.awb")

						arg_42_1:RecordAudio("425031010", var_45_32)
						arg_42_1:RecordAudio("425031010", var_45_32)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_425031", "425031010", "story_v_out_425031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_425031", "425031010", "story_v_out_425031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_33 = math.max(var_45_24, arg_42_1.talkMaxDuration)

			if var_45_23 <= arg_42_1.time_ and arg_42_1.time_ < var_45_23 + var_45_33 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_23) / var_45_33

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_23 + var_45_33 and arg_42_1.time_ < var_45_23 + var_45_33 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425031011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play425031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1137"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1137 = var_49_0.localPosition
				var_49_0.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1137", 7)

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
				local var_49_6 = Vector3.New(0, -2000, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1137, var_49_6, var_49_5)
			end

			if arg_46_1.time_ >= var_49_1 + var_49_4 and arg_46_1.time_ < var_49_1 + var_49_4 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_7 = arg_46_1.actors_["1086"].transform
			local var_49_8 = 0

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.var_.moveOldPos1086 = var_49_7.localPosition
				var_49_7.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1086", 7)

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

				var_49_7.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1086, var_49_13, var_49_12)
			end

			if arg_46_1.time_ >= var_49_8 + var_49_11 and arg_46_1.time_ < var_49_8 + var_49_11 + arg_49_0 then
				var_49_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_14 = 0
			local var_49_15 = 1.125

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

				local var_49_16 = arg_46_1:GetWordFromCfg(425031011)
				local var_49_17 = arg_46_1:FormatText(var_49_16.content)

				arg_46_1.text_.text = var_49_17

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_18 = 45
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play425031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425031012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play425031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.3

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(425031012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 52
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play425031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425031013
		arg_54_1.duration_ = 8.97

		local var_54_0 = {
			zh = 6.233,
			ja = 8.966
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
				arg_54_0:Play425031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1137"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1137 == nil then
				arg_54_1.var_.actorSpriteComps1137 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1137 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1137 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1137 = nil
			end

			local var_57_8 = arg_54_1.actors_["1137"].transform
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.var_.moveOldPos1137 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1137", 2)

				local var_57_10 = var_57_8.childCount

				for iter_57_4 = 0, var_57_10 - 1 do
					local var_57_11 = var_57_8:GetChild(iter_57_4)

					if var_57_11.name == "split_6" or not string.find(var_57_11.name, "split") then
						var_57_11.gameObject:SetActive(true)
					else
						var_57_11.gameObject:SetActive(false)
					end
				end
			end

			local var_57_12 = 0.001

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_12 then
				local var_57_13 = (arg_54_1.time_ - var_57_9) / var_57_12
				local var_57_14 = Vector3.New(-390, -425, -200)

				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1137, var_57_14, var_57_13)
			end

			if arg_54_1.time_ >= var_57_9 + var_57_12 and arg_54_1.time_ < var_57_9 + var_57_12 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_57_15 = 0
			local var_57_16 = 0.7

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[15].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(425031013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 28
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031013", "story_v_out_425031.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_425031", "425031013", "story_v_out_425031.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_425031", "425031013", "story_v_out_425031.awb")

						arg_54_1:RecordAudio("425031013", var_57_24)
						arg_54_1:RecordAudio("425031013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425031", "425031013", "story_v_out_425031.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425031", "425031013", "story_v_out_425031.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425031014
		arg_58_1.duration_ = 5.73

		local var_58_0 = {
			zh = 5.733,
			ja = 3.366
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
				arg_58_0:Play425031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1086"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1086 == nil then
				arg_58_1.var_.actorSpriteComps1086 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1086 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1086 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1086 = nil
			end

			local var_61_8 = arg_58_1.actors_["1137"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1137 == nil then
				arg_58_1.var_.actorSpriteComps1137 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps1137 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps1137 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1137 = nil
			end

			local var_61_16 = arg_58_1.actors_["1086"].transform
			local var_61_17 = 0

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 then
				arg_58_1.var_.moveOldPos1086 = var_61_16.localPosition
				var_61_16.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1086", 4)

				local var_61_18 = var_61_16.childCount

				for iter_61_8 = 0, var_61_18 - 1 do
					local var_61_19 = var_61_16:GetChild(iter_61_8)

					if var_61_19.name == "split_4" or not string.find(var_61_19.name, "split") then
						var_61_19.gameObject:SetActive(true)
					else
						var_61_19.gameObject:SetActive(false)
					end
				end
			end

			local var_61_20 = 0.001

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_20 then
				local var_61_21 = (arg_58_1.time_ - var_61_17) / var_61_20
				local var_61_22 = Vector3.New(390, -404.2, -237.9)

				var_61_16.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1086, var_61_22, var_61_21)
			end

			if arg_58_1.time_ >= var_61_17 + var_61_20 and arg_58_1.time_ < var_61_17 + var_61_20 + arg_61_0 then
				var_61_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_61_23 = 0
			local var_61_24 = 0.475

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_25 = arg_58_1:FormatText(StoryNameCfg[1080].name)

				arg_58_1.leftNameTxt_.text = var_61_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_26 = arg_58_1:GetWordFromCfg(425031014)
				local var_61_27 = arg_58_1:FormatText(var_61_26.content)

				arg_58_1.text_.text = var_61_27

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_28 = 19
				local var_61_29 = utf8.len(var_61_27)
				local var_61_30 = var_61_28 <= 0 and var_61_24 or var_61_24 * (var_61_29 / var_61_28)

				if var_61_30 > 0 and var_61_24 < var_61_30 then
					arg_58_1.talkMaxDuration = var_61_30

					if var_61_30 + var_61_23 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_30 + var_61_23
					end
				end

				arg_58_1.text_.text = var_61_27
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031014", "story_v_out_425031.awb") ~= 0 then
					local var_61_31 = manager.audio:GetVoiceLength("story_v_out_425031", "425031014", "story_v_out_425031.awb") / 1000

					if var_61_31 + var_61_23 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_31 + var_61_23
					end

					if var_61_26.prefab_name ~= "" and arg_58_1.actors_[var_61_26.prefab_name] ~= nil then
						local var_61_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_26.prefab_name].transform, "story_v_out_425031", "425031014", "story_v_out_425031.awb")

						arg_58_1:RecordAudio("425031014", var_61_32)
						arg_58_1:RecordAudio("425031014", var_61_32)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_425031", "425031014", "story_v_out_425031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_425031", "425031014", "story_v_out_425031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_33 = math.max(var_61_24, arg_58_1.talkMaxDuration)

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_33 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_23) / var_61_33

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_23 + var_61_33 and arg_58_1.time_ < var_61_23 + var_61_33 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play425031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425031015
		arg_62_1.duration_ = 3.4

		local var_62_0 = {
			zh = 1.966,
			ja = 3.4
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
				arg_62_0:Play425031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1137"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1137 == nil then
				arg_62_1.var_.actorSpriteComps1137 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps1137 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1137 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1137 = nil
			end

			local var_65_8 = arg_62_1.actors_["1086"]
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps1086 == nil then
				arg_62_1.var_.actorSpriteComps1086 = var_65_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_10 = 0.2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 and not isNil(var_65_8) then
				local var_65_11 = (arg_62_1.time_ - var_65_9) / var_65_10

				if arg_62_1.var_.actorSpriteComps1086 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps1086 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_65_7 then
						if arg_62_1.isInRecall_ then
							iter_65_7.color = arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_65_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1086 = nil
			end

			local var_65_16 = 0
			local var_65_17 = 0.225

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_18 = arg_62_1:FormatText(StoryNameCfg[15].name)

				arg_62_1.leftNameTxt_.text = var_65_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_19 = arg_62_1:GetWordFromCfg(425031015)
				local var_65_20 = arg_62_1:FormatText(var_65_19.content)

				arg_62_1.text_.text = var_65_20

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_21 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031015", "story_v_out_425031.awb") ~= 0 then
					local var_65_24 = manager.audio:GetVoiceLength("story_v_out_425031", "425031015", "story_v_out_425031.awb") / 1000

					if var_65_24 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_24 + var_65_16
					end

					if var_65_19.prefab_name ~= "" and arg_62_1.actors_[var_65_19.prefab_name] ~= nil then
						local var_65_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_19.prefab_name].transform, "story_v_out_425031", "425031015", "story_v_out_425031.awb")

						arg_62_1:RecordAudio("425031015", var_65_25)
						arg_62_1:RecordAudio("425031015", var_65_25)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_425031", "425031015", "story_v_out_425031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_425031", "425031015", "story_v_out_425031.awb")
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
	Play425031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425031016
		arg_66_1.duration_ = 16.2

		local var_66_0 = {
			zh = 7.533,
			ja = 16.2
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
				arg_66_0:Play425031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1086"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1086 == nil then
				arg_66_1.var_.actorSpriteComps1086 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps1086 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1086 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1086 = nil
			end

			local var_69_8 = arg_66_1.actors_["1137"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1137 == nil then
				arg_66_1.var_.actorSpriteComps1137 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps1137 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1137 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1137 = nil
			end

			local var_69_16 = arg_66_1.actors_["1086"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos1086 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1086", 4)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "split_1" then
						var_69_19:SetAsLastSibling()
						var_69_19.gameObject:SetActive(true)

						arg_66_1.var_.actorSpriteSplit1086 = var_69_19.gameObject:GetComponent(typeof(Image))

						arg_66_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_69_20 = 0.5

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(390, -404.2, -237.9)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1086, var_69_22, var_69_21)

				if arg_66_1.var_.actorSpriteSplit1086 ~= nil then
					arg_66_1.var_.actorSpriteSplit1086:SetAlpha(var_69_21)
				end
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(390, -404.2, -237.9)

				if arg_66_1.var_.actorSpriteSplit1086 ~= nil then
					arg_66_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_69_23 = 0
			local var_69_24 = 0.975

			if var_69_23 < arg_66_1.time_ and arg_66_1.time_ <= var_69_23 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_25 = arg_66_1:FormatText(StoryNameCfg[1080].name)

				arg_66_1.leftNameTxt_.text = var_69_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_26 = arg_66_1:GetWordFromCfg(425031016)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.text_.text = var_69_27

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_28 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_425031", "425031016", "story_v_out_425031.awb") ~= 0 then
					local var_69_31 = manager.audio:GetVoiceLength("story_v_out_425031", "425031016", "story_v_out_425031.awb") / 1000

					if var_69_31 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_31 + var_69_23
					end

					if var_69_26.prefab_name ~= "" and arg_66_1.actors_[var_69_26.prefab_name] ~= nil then
						local var_69_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_26.prefab_name].transform, "story_v_out_425031", "425031016", "story_v_out_425031.awb")

						arg_66_1:RecordAudio("425031016", var_69_32)
						arg_66_1:RecordAudio("425031016", var_69_32)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_425031", "425031016", "story_v_out_425031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_425031", "425031016", "story_v_out_425031.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play425031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425031017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
			arg_70_1.auto_ = false
		end

		function arg_70_1.playNext_(arg_72_0)
			arg_70_1.onStoryFinished_()
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1137"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1137 = var_73_0.localPosition
				var_73_0.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1137", 7)

				local var_73_2 = var_73_0.childCount

				for iter_73_0 = 0, var_73_2 - 1 do
					local var_73_3 = var_73_0:GetChild(iter_73_0)

					if var_73_3.name == "" or not string.find(var_73_3.name, "split") then
						var_73_3.gameObject:SetActive(true)
					else
						var_73_3.gameObject:SetActive(false)
					end
				end
			end

			local var_73_4 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_4 then
				local var_73_5 = (arg_70_1.time_ - var_73_1) / var_73_4
				local var_73_6 = Vector3.New(0, -2000, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1137, var_73_6, var_73_5)
			end

			if arg_70_1.time_ >= var_73_1 + var_73_4 and arg_70_1.time_ < var_73_1 + var_73_4 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_7 = arg_70_1.actors_["1086"].transform
			local var_73_8 = 0

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.var_.moveOldPos1086 = var_73_7.localPosition
				var_73_7.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1086", 7)

				local var_73_9 = var_73_7.childCount

				for iter_73_1 = 0, var_73_9 - 1 do
					local var_73_10 = var_73_7:GetChild(iter_73_1)

					if var_73_10.name == "" or not string.find(var_73_10.name, "split") then
						var_73_10.gameObject:SetActive(true)
					else
						var_73_10.gameObject:SetActive(false)
					end
				end
			end

			local var_73_11 = 0.001

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_11 then
				local var_73_12 = (arg_70_1.time_ - var_73_8) / var_73_11
				local var_73_13 = Vector3.New(0, -2000, 0)

				var_73_7.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1086, var_73_13, var_73_12)
			end

			if arg_70_1.time_ >= var_73_8 + var_73_11 and arg_70_1.time_ < var_73_8 + var_73_11 + arg_73_0 then
				var_73_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_14 = 0
			local var_73_15 = 0.95

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_16 = arg_70_1:GetWordFromCfg(425031017)
				local var_73_17 = arg_70_1:FormatText(var_73_16.content)

				arg_70_1.text_.text = var_73_17

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_18 = 38
				local var_73_19 = utf8.len(var_73_17)
				local var_73_20 = var_73_18 <= 0 and var_73_15 or var_73_15 * (var_73_19 / var_73_18)

				if var_73_20 > 0 and var_73_15 < var_73_20 then
					arg_70_1.talkMaxDuration = var_73_20

					if var_73_20 + var_73_14 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_20 + var_73_14
					end
				end

				arg_70_1.text_.text = var_73_17
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_21 = math.max(var_73_15, arg_70_1.talkMaxDuration)

			if var_73_14 <= arg_70_1.time_ and arg_70_1.time_ < var_73_14 + var_73_21 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_14) / var_73_21

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_14 + var_73_21 and arg_70_1.time_ < var_73_14 + var_73_21 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/M01i"
	},
	voices = {
		"story_v_out_425031.awb"
	}
}
