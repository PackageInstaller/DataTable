return {
	Play417041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417041001
		arg_1_1.duration_ = 12.47

		local var_1_0 = {
			zh = 9.7,
			ja = 12.466
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
				arg_1_0:Play417041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST27"

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
				local var_4_5 = arg_1_1.bgs_.ST27

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
					if iter_4_0 ~= "ST27" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

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

			local var_4_30 = 0
			local var_4_31 = 3
			local var_4_32 = "ST27"

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_32)

				arg_1_1.timestampColorController_:SetSelectedState("hot")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_33 = arg_1_1:GetWordFromCfg(501011)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_timeText_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_35 = arg_1_1:GetWordFromCfg(501012)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_siteText_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_37 = 3

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_38 = 1.2

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38
				local var_4_40 = Color.New(0, 0, 0)

				var_4_40.a = Mathf.Lerp(0, 1, var_4_39)
				arg_1_1.mask_.color = var_4_40
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				local var_4_41 = Color.New(0, 0, 0)

				var_4_41.a = 1
				arg_1_1.mask_.color = var_4_41
			end

			local var_4_42 = 4.2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_43 = 1.2

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43
				local var_4_45 = Color.New(0, 0, 0)

				var_4_45.a = Mathf.Lerp(1, 0, var_4_44)
				arg_1_1.mask_.color = var_4_45
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				local var_4_46 = Color.New(0, 0, 0)
				local var_4_47 = 0

				arg_1_1.mask_.enabled = false
				var_4_46.a = var_4_47
				arg_1_1.mask_.color = var_4_46
			end

			local var_4_48 = 0

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_49 = 1

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49
				local var_4_51 = Color.New(0, 0, 0)

				var_4_51.a = Mathf.Lerp(1, 0, var_4_50)
				arg_1_1.mask_.color = var_4_51
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				local var_4_52 = Color.New(0, 0, 0)
				local var_4_53 = 0

				arg_1_1.mask_.enabled = false
				var_4_52.a = var_4_53
				arg_1_1.mask_.color = var_4_52
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 3

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 5.4
			local var_4_57 = 0.475

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1119].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_60 = arg_1_1:GetWordFromCfg(417041001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 19
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041001", "story_v_out_417041.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_417041", "417041001", "story_v_out_417041.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_417041", "417041001", "story_v_out_417041.awb")

						arg_1_1:RecordAudio("417041001", var_4_66)
						arg_1_1:RecordAudio("417041001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417041", "417041001", "story_v_out_417041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417041", "417041001", "story_v_out_417041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417041002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417041002
		arg_10_1.duration_ = 4.07

		local var_10_0 = {
			zh = 1.866,
			ja = 4.066
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
				arg_10_0:Play417041003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1034"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

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

			local var_13_4 = arg_10_1.actors_["1034"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_13_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_12 = arg_10_1.actors_["1034"].transform
			local var_13_13 = 0

			if var_13_13 < arg_10_1.time_ and arg_10_1.time_ <= var_13_13 + arg_13_0 then
				arg_10_1.var_.moveOldPos1034 = var_13_12.localPosition
				var_13_12.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1034", 3)

				local var_13_14 = var_13_12.childCount

				for iter_13_6 = 0, var_13_14 - 1 do
					local var_13_15 = var_13_12:GetChild(iter_13_6)

					if var_13_15.name == "" or not string.find(var_13_15.name, "split") then
						var_13_15.gameObject:SetActive(true)
					else
						var_13_15.gameObject:SetActive(false)
					end
				end
			end

			local var_13_16 = 0.001

			if var_13_13 <= arg_10_1.time_ and arg_10_1.time_ < var_13_13 + var_13_16 then
				local var_13_17 = (arg_10_1.time_ - var_13_13) / var_13_16
				local var_13_18 = Vector3.New(0, -331.9, -324)

				var_13_12.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, var_13_18, var_13_17)
			end

			if arg_10_1.time_ >= var_13_13 + var_13_16 and arg_10_1.time_ < var_13_13 + var_13_16 + arg_13_0 then
				var_13_12.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_13_19 = 0
			local var_13_20 = 0.175

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_21 = arg_10_1:FormatText(StoryNameCfg[1109].name)

				arg_10_1.leftNameTxt_.text = var_13_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_22 = arg_10_1:GetWordFromCfg(417041002)
				local var_13_23 = arg_10_1:FormatText(var_13_22.content)

				arg_10_1.text_.text = var_13_23

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_24 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041002", "story_v_out_417041.awb") ~= 0 then
					local var_13_27 = manager.audio:GetVoiceLength("story_v_out_417041", "417041002", "story_v_out_417041.awb") / 1000

					if var_13_27 + var_13_19 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_27 + var_13_19
					end

					if var_13_22.prefab_name ~= "" and arg_10_1.actors_[var_13_22.prefab_name] ~= nil then
						local var_13_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_22.prefab_name].transform, "story_v_out_417041", "417041002", "story_v_out_417041.awb")

						arg_10_1:RecordAudio("417041002", var_13_28)
						arg_10_1:RecordAudio("417041002", var_13_28)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417041", "417041002", "story_v_out_417041.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417041", "417041002", "story_v_out_417041.awb")
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
				actorName = "1034",
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
	Play417041003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417041003
		arg_14_1.duration_ = 7.33

		local var_14_0 = {
			zh = 1.733,
			ja = 7.333
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
				arg_14_0:Play417041004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1034"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_3 then
						if arg_14_1.isInRecall_ then
							iter_17_3.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_8 = 0
			local var_17_9 = 0.225

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_10 = arg_14_1:FormatText(StoryNameCfg[1119].name)

				arg_14_1.leftNameTxt_.text = var_17_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_11 = arg_14_1:GetWordFromCfg(417041003)
				local var_17_12 = arg_14_1:FormatText(var_17_11.content)

				arg_14_1.text_.text = var_17_12

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_13 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041003", "story_v_out_417041.awb") ~= 0 then
					local var_17_16 = manager.audio:GetVoiceLength("story_v_out_417041", "417041003", "story_v_out_417041.awb") / 1000

					if var_17_16 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_16 + var_17_8
					end

					if var_17_11.prefab_name ~= "" and arg_14_1.actors_[var_17_11.prefab_name] ~= nil then
						local var_17_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_11.prefab_name].transform, "story_v_out_417041", "417041003", "story_v_out_417041.awb")

						arg_14_1:RecordAudio("417041003", var_17_17)
						arg_14_1:RecordAudio("417041003", var_17_17)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417041", "417041003", "story_v_out_417041.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417041", "417041003", "story_v_out_417041.awb")
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
	Play417041004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417041004
		arg_18_1.duration_ = 7.2

		local var_18_0 = {
			zh = 5.4,
			ja = 7.2
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
				arg_18_0:Play417041005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1034"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_8 = arg_18_1.actors_["1034"].transform
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.var_.moveOldPos1034 = var_21_8.localPosition
				var_21_8.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1034", 3)

				local var_21_10 = var_21_8.childCount

				for iter_21_4 = 0, var_21_10 - 1 do
					local var_21_11 = var_21_8:GetChild(iter_21_4)

					if var_21_11.name == "" or not string.find(var_21_11.name, "split") then
						var_21_11.gameObject:SetActive(true)
					else
						var_21_11.gameObject:SetActive(false)
					end
				end
			end

			local var_21_12 = 0.001

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_9) / var_21_12
				local var_21_14 = Vector3.New(0, -331.9, -324)

				var_21_8.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1034, var_21_14, var_21_13)
			end

			if arg_18_1.time_ >= var_21_9 + var_21_12 and arg_18_1.time_ < var_21_9 + var_21_12 + arg_21_0 then
				var_21_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_21_15 = 0
			local var_21_16 = 0.625

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_17 = arg_18_1:FormatText(StoryNameCfg[1109].name)

				arg_18_1.leftNameTxt_.text = var_21_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_18 = arg_18_1:GetWordFromCfg(417041004)
				local var_21_19 = arg_18_1:FormatText(var_21_18.content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041004", "story_v_out_417041.awb") ~= 0 then
					local var_21_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041004", "story_v_out_417041.awb") / 1000

					if var_21_23 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_15
					end

					if var_21_18.prefab_name ~= "" and arg_18_1.actors_[var_21_18.prefab_name] ~= nil then
						local var_21_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_18.prefab_name].transform, "story_v_out_417041", "417041004", "story_v_out_417041.awb")

						arg_18_1:RecordAudio("417041004", var_21_24)
						arg_18_1:RecordAudio("417041004", var_21_24)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417041", "417041004", "story_v_out_417041.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417041", "417041004", "story_v_out_417041.awb")
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
				actorName = "1034",
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
	Play417041005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417041005
		arg_22_1.duration_ = 6.7

		local var_22_0 = {
			zh = 4.233,
			ja = 6.7
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
				arg_22_0:Play417041006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1034"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_8 = 0
			local var_25_9 = 0.45

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_10 = arg_22_1:FormatText(StoryNameCfg[1119].name)

				arg_22_1.leftNameTxt_.text = var_25_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_11 = arg_22_1:GetWordFromCfg(417041005)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.text_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041005", "story_v_out_417041.awb") ~= 0 then
					local var_25_16 = manager.audio:GetVoiceLength("story_v_out_417041", "417041005", "story_v_out_417041.awb") / 1000

					if var_25_16 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_16 + var_25_8
					end

					if var_25_11.prefab_name ~= "" and arg_22_1.actors_[var_25_11.prefab_name] ~= nil then
						local var_25_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_11.prefab_name].transform, "story_v_out_417041", "417041005", "story_v_out_417041.awb")

						arg_22_1:RecordAudio("417041005", var_25_17)
						arg_22_1:RecordAudio("417041005", var_25_17)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417041", "417041005", "story_v_out_417041.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417041", "417041005", "story_v_out_417041.awb")
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
	Play417041006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417041006
		arg_26_1.duration_ = 1.13

		local var_26_0 = {
			zh = 0.999999999999,
			ja = 1.133
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
				arg_26_0:Play417041007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "10128"

			if arg_26_1.actors_[var_29_0] == nil then
				local var_29_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

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

			local var_29_4 = arg_26_1.actors_["10128"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps10128 == nil then
				arg_26_1.var_.actorSpriteComps10128 = var_29_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_6 = 0.2

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.actorSpriteComps10128 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_29_3 then
							if arg_26_1.isInRecall_ then
								local var_29_8 = Mathf.Lerp(iter_29_3.color.r, arg_26_1.hightColor1.r, var_29_7)
								local var_29_9 = Mathf.Lerp(iter_29_3.color.g, arg_26_1.hightColor1.g, var_29_7)
								local var_29_10 = Mathf.Lerp(iter_29_3.color.b, arg_26_1.hightColor1.b, var_29_7)

								iter_29_3.color = Color.New(var_29_8, var_29_9, var_29_10)
							else
								local var_29_11 = Mathf.Lerp(iter_29_3.color.r, 1, var_29_7)

								iter_29_3.color = Color.New(var_29_11, var_29_11, var_29_11)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps10128 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_29_5 then
						if arg_26_1.isInRecall_ then
							iter_29_5.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps10128 = nil
			end

			local var_29_12 = arg_26_1.actors_["1034"].transform
			local var_29_13 = 0

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1.var_.moveOldPos1034 = var_29_12.localPosition
				var_29_12.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1034", 7)

				local var_29_14 = var_29_12.childCount

				for iter_29_6 = 0, var_29_14 - 1 do
					local var_29_15 = var_29_12:GetChild(iter_29_6)

					if var_29_15.name == "" or not string.find(var_29_15.name, "split") then
						var_29_15.gameObject:SetActive(true)
					else
						var_29_15.gameObject:SetActive(false)
					end
				end
			end

			local var_29_16 = 0.001

			if var_29_13 <= arg_26_1.time_ and arg_26_1.time_ < var_29_13 + var_29_16 then
				local var_29_17 = (arg_26_1.time_ - var_29_13) / var_29_16
				local var_29_18 = Vector3.New(0, -2000, 0)

				var_29_12.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1034, var_29_18, var_29_17)
			end

			if arg_26_1.time_ >= var_29_13 + var_29_16 and arg_26_1.time_ < var_29_13 + var_29_16 + arg_29_0 then
				var_29_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_29_19 = arg_26_1.actors_["10128"].transform
			local var_29_20 = 0

			if var_29_20 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1.var_.moveOldPos10128 = var_29_19.localPosition
				var_29_19.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10128", 3)

				local var_29_21 = var_29_19.childCount

				for iter_29_7 = 0, var_29_21 - 1 do
					local var_29_22 = var_29_19:GetChild(iter_29_7)

					if var_29_22.name == "" or not string.find(var_29_22.name, "split") then
						var_29_22.gameObject:SetActive(true)
					else
						var_29_22.gameObject:SetActive(false)
					end
				end
			end

			local var_29_23 = 0.001

			if var_29_20 <= arg_26_1.time_ and arg_26_1.time_ < var_29_20 + var_29_23 then
				local var_29_24 = (arg_26_1.time_ - var_29_20) / var_29_23
				local var_29_25 = Vector3.New(0, -347, -300)

				var_29_19.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10128, var_29_25, var_29_24)
			end

			if arg_26_1.time_ >= var_29_20 + var_29_23 and arg_26_1.time_ < var_29_20 + var_29_23 + arg_29_0 then
				var_29_19.localPosition = Vector3.New(0, -347, -300)
			end

			local var_29_26 = 0
			local var_29_27 = 0.05

			if var_29_26 < arg_26_1.time_ and arg_26_1.time_ <= var_29_26 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_28 = arg_26_1:FormatText(StoryNameCfg[595].name)

				arg_26_1.leftNameTxt_.text = var_29_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_29 = arg_26_1:GetWordFromCfg(417041006)
				local var_29_30 = arg_26_1:FormatText(var_29_29.content)

				arg_26_1.text_.text = var_29_30

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_31 = 2
				local var_29_32 = utf8.len(var_29_30)
				local var_29_33 = var_29_31 <= 0 and var_29_27 or var_29_27 * (var_29_32 / var_29_31)

				if var_29_33 > 0 and var_29_27 < var_29_33 then
					arg_26_1.talkMaxDuration = var_29_33

					if var_29_33 + var_29_26 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_33 + var_29_26
					end
				end

				arg_26_1.text_.text = var_29_30
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041006", "story_v_out_417041.awb") ~= 0 then
					local var_29_34 = manager.audio:GetVoiceLength("story_v_out_417041", "417041006", "story_v_out_417041.awb") / 1000

					if var_29_34 + var_29_26 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_34 + var_29_26
					end

					if var_29_29.prefab_name ~= "" and arg_26_1.actors_[var_29_29.prefab_name] ~= nil then
						local var_29_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_29.prefab_name].transform, "story_v_out_417041", "417041006", "story_v_out_417041.awb")

						arg_26_1:RecordAudio("417041006", var_29_35)
						arg_26_1:RecordAudio("417041006", var_29_35)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417041", "417041006", "story_v_out_417041.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417041", "417041006", "story_v_out_417041.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_36 = math.max(var_29_27, arg_26_1.talkMaxDuration)

			if var_29_26 <= arg_26_1.time_ and arg_26_1.time_ < var_29_26 + var_29_36 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_26) / var_29_36

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_26 + var_29_36 and arg_26_1.time_ < var_29_26 + var_29_36 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
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

		arg_26_1:InitPlayNodeList()
	end,
	Play417041007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417041007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417041008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10128"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 0.5, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_8 = arg_30_1.actors_["10128"].transform
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = var_33_8.localPosition
				var_33_8.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 7)

				local var_33_10 = var_33_8.childCount

				for iter_33_4 = 0, var_33_10 - 1 do
					local var_33_11 = var_33_8:GetChild(iter_33_4)

					if var_33_11.name == "" or not string.find(var_33_11.name, "split") then
						var_33_11.gameObject:SetActive(true)
					else
						var_33_11.gameObject:SetActive(false)
					end
				end
			end

			local var_33_12 = 0.001

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_9) / var_33_12
				local var_33_14 = Vector3.New(0, -2000, -300)

				var_33_8.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, var_33_14, var_33_13)
			end

			if arg_30_1.time_ >= var_33_9 + var_33_12 and arg_30_1.time_ < var_33_9 + var_33_12 + arg_33_0 then
				var_33_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_33_15 = 0
			local var_33_16 = 1.275

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_17 = arg_30_1:GetWordFromCfg(417041007)
				local var_33_18 = arg_30_1:FormatText(var_33_17.content)

				arg_30_1.text_.text = var_33_18

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_19 = 51
				local var_33_20 = utf8.len(var_33_18)
				local var_33_21 = var_33_19 <= 0 and var_33_16 or var_33_16 * (var_33_20 / var_33_19)

				if var_33_21 > 0 and var_33_16 < var_33_21 then
					arg_30_1.talkMaxDuration = var_33_21

					if var_33_21 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_21 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_18
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_22 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_22 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_22

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_22 and arg_30_1.time_ < var_33_15 + var_33_22 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417041008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417041008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417041009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 1.7

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_2 = arg_34_1:GetWordFromCfg(417041008)
				local var_37_3 = arg_34_1:FormatText(var_37_2.content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 68
				local var_37_5 = utf8.len(var_37_3)
				local var_37_6 = var_37_4 <= 0 and var_37_1 or var_37_1 * (var_37_5 / var_37_4)

				if var_37_6 > 0 and var_37_1 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_7 and arg_34_1.time_ < var_37_0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417041009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417041009
		arg_38_1.duration_ = 10.23

		local var_38_0 = {
			zh = 6.566,
			ja = 10.233
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
				arg_38_0:Play417041010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.825

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[1119].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(417041009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 33
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041009", "story_v_out_417041.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041009", "story_v_out_417041.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_417041", "417041009", "story_v_out_417041.awb")

						arg_38_1:RecordAudio("417041009", var_41_9)
						arg_38_1:RecordAudio("417041009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417041", "417041009", "story_v_out_417041.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417041", "417041009", "story_v_out_417041.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417041010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417041010
		arg_42_1.duration_ = 8.23

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417041011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.5

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				local var_45_1 = manager.ui.mainCamera.transform.localPosition
				local var_45_2 = Vector3.New(0, 0, 10) + Vector3.New(var_45_1.x, var_45_1.y, 0)
				local var_45_3 = arg_42_1.bgs_.ST27

				var_45_3.transform.localPosition = var_45_2
				var_45_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_4 = var_45_3:GetComponent("SpriteRenderer")

				if var_45_4 and var_45_4.sprite then
					local var_45_5 = (var_45_3.transform.localPosition - var_45_1).z
					local var_45_6 = manager.ui.mainCameraCom_
					local var_45_7 = 2 * var_45_5 * Mathf.Tan(var_45_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_8 = var_45_7 * var_45_6.aspect
					local var_45_9 = var_45_4.sprite.bounds.size.x
					local var_45_10 = var_45_4.sprite.bounds.size.y
					local var_45_11 = var_45_8 / var_45_9
					local var_45_12 = var_45_7 / var_45_10
					local var_45_13 = var_45_12 < var_45_11 and var_45_11 or var_45_12

					var_45_3.transform.localScale = Vector3.New(var_45_13, var_45_13, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "ST27" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_14 = 0

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_15 = 0.3

			if arg_42_1.time_ >= var_45_14 + var_45_15 and arg_42_1.time_ < var_45_14 + var_45_15 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_17 = 1.5

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_17 then
				local var_45_18 = (arg_42_1.time_ - var_45_16) / var_45_17
				local var_45_19 = Color.New(0, 0, 0)

				var_45_19.a = Mathf.Lerp(0, 1, var_45_18)
				arg_42_1.mask_.color = var_45_19
			end

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 then
				local var_45_20 = Color.New(0, 0, 0)

				var_45_20.a = 1
				arg_42_1.mask_.color = var_45_20
			end

			local var_45_21 = 1.5

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_22 = 2

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_22 then
				local var_45_23 = (arg_42_1.time_ - var_45_21) / var_45_22
				local var_45_24 = Color.New(0, 0, 0)

				var_45_24.a = Mathf.Lerp(1, 0, var_45_23)
				arg_42_1.mask_.color = var_45_24
			end

			if arg_42_1.time_ >= var_45_21 + var_45_22 and arg_42_1.time_ < var_45_21 + var_45_22 + arg_45_0 then
				local var_45_25 = Color.New(0, 0, 0)
				local var_45_26 = 0

				arg_42_1.mask_.enabled = false
				var_45_25.a = var_45_26
				arg_42_1.mask_.color = var_45_25
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_27 = 3.23333333333333
			local var_45_28 = 0.875

			if var_45_27 < arg_42_1.time_ and arg_42_1.time_ <= var_45_27 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_29 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_29:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_30 = arg_42_1:GetWordFromCfg(417041010)
				local var_45_31 = arg_42_1:FormatText(var_45_30.content)

				arg_42_1.text_.text = var_45_31

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_32 = 35
				local var_45_33 = utf8.len(var_45_31)
				local var_45_34 = var_45_32 <= 0 and var_45_28 or var_45_28 * (var_45_33 / var_45_32)

				if var_45_34 > 0 and var_45_28 < var_45_34 then
					arg_42_1.talkMaxDuration = var_45_34
					var_45_27 = var_45_27 + 0.3

					if var_45_34 + var_45_27 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_34 + var_45_27
					end
				end

				arg_42_1.text_.text = var_45_31
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_35 = var_45_27 + 0.3
			local var_45_36 = math.max(var_45_28, arg_42_1.talkMaxDuration)

			if var_45_35 <= arg_42_1.time_ and arg_42_1.time_ < var_45_35 + var_45_36 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_35) / var_45_36

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_35 + var_45_36 and arg_42_1.time_ < var_45_35 + var_45_36 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417041011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417041011
		arg_48_1.duration_ = 9.23

		local var_48_0 = {
			zh = 9.233,
			ja = 8.766
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
				arg_48_0:Play417041012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1034"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1034 == nil then
				arg_48_1.var_.actorSpriteComps1034 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1034 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1034 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1034 = nil
			end

			local var_51_8 = arg_48_1.actors_["1034"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos1034 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1034", 2)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(-390, -331.9, -324)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1034, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_51_15 = 0
			local var_51_16 = 1.05

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[1109].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(417041011)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 42
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041011", "story_v_out_417041.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041011", "story_v_out_417041.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_417041", "417041011", "story_v_out_417041.awb")

						arg_48_1:RecordAudio("417041011", var_51_24)
						arg_48_1:RecordAudio("417041011", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_417041", "417041011", "story_v_out_417041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_417041", "417041011", "story_v_out_417041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play417041012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417041012
		arg_52_1.duration_ = 8.07

		local var_52_0 = {
			zh = 4.866,
			ja = 8.066
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
				arg_52_0:Play417041013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10128"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10128 == nil then
				arg_52_1.var_.actorSpriteComps10128 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps10128 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10128 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10128 = nil
			end

			local var_55_8 = arg_52_1.actors_["1034"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1034 == nil then
				arg_52_1.var_.actorSpriteComps1034 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps1034 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								local var_55_12 = Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, var_55_11)
								local var_55_13 = Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, var_55_11)
								local var_55_14 = Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, var_55_11)

								iter_55_5.color = Color.New(var_55_12, var_55_13, var_55_14)
							else
								local var_55_15 = Mathf.Lerp(iter_55_5.color.r, 0.5, var_55_11)

								iter_55_5.color = Color.New(var_55_15, var_55_15, var_55_15)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1034 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1034 = nil
			end

			local var_55_16 = arg_52_1.actors_["10128"].transform
			local var_55_17 = 0

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.var_.moveOldPos10128 = var_55_16.localPosition
				var_55_16.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10128", 4)

				local var_55_18 = var_55_16.childCount

				for iter_55_8 = 0, var_55_18 - 1 do
					local var_55_19 = var_55_16:GetChild(iter_55_8)

					if var_55_19.name == "" or not string.find(var_55_19.name, "split") then
						var_55_19.gameObject:SetActive(true)
					else
						var_55_19.gameObject:SetActive(false)
					end
				end
			end

			local var_55_20 = 0.001

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_20 then
				local var_55_21 = (arg_52_1.time_ - var_55_17) / var_55_20
				local var_55_22 = Vector3.New(390, -347, -300)

				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10128, var_55_22, var_55_21)
			end

			if arg_52_1.time_ >= var_55_17 + var_55_20 and arg_52_1.time_ < var_55_17 + var_55_20 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_55_23 = 0
			local var_55_24 = 0.65

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_25 = arg_52_1:FormatText(StoryNameCfg[595].name)

				arg_52_1.leftNameTxt_.text = var_55_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_26 = arg_52_1:GetWordFromCfg(417041012)
				local var_55_27 = arg_52_1:FormatText(var_55_26.content)

				arg_52_1.text_.text = var_55_27

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_28 = 26
				local var_55_29 = utf8.len(var_55_27)
				local var_55_30 = var_55_28 <= 0 and var_55_24 or var_55_24 * (var_55_29 / var_55_28)

				if var_55_30 > 0 and var_55_24 < var_55_30 then
					arg_52_1.talkMaxDuration = var_55_30

					if var_55_30 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_30 + var_55_23
					end
				end

				arg_52_1.text_.text = var_55_27
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041012", "story_v_out_417041.awb") ~= 0 then
					local var_55_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041012", "story_v_out_417041.awb") / 1000

					if var_55_31 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_31 + var_55_23
					end

					if var_55_26.prefab_name ~= "" and arg_52_1.actors_[var_55_26.prefab_name] ~= nil then
						local var_55_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_26.prefab_name].transform, "story_v_out_417041", "417041012", "story_v_out_417041.awb")

						arg_52_1:RecordAudio("417041012", var_55_32)
						arg_52_1:RecordAudio("417041012", var_55_32)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417041", "417041012", "story_v_out_417041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417041", "417041012", "story_v_out_417041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_33 = math.max(var_55_24, arg_52_1.talkMaxDuration)

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_33 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_23) / var_55_33

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_23 + var_55_33 and arg_52_1.time_ < var_55_23 + var_55_33 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play417041013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417041013
		arg_56_1.duration_ = 10.53

		local var_56_0 = {
			zh = 7.8,
			ja = 10.533
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
				arg_56_0:Play417041014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1034"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1034 == nil then
				arg_56_1.var_.actorSpriteComps1034 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1034 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 1, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1034 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1034 = nil
			end

			local var_59_8 = arg_56_1.actors_["10128"]
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps10128 == nil then
				arg_56_1.var_.actorSpriteComps10128 = var_59_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_10 = 0.2

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 and not isNil(var_59_8) then
				local var_59_11 = (arg_56_1.time_ - var_59_9) / var_59_10

				if arg_56_1.var_.actorSpriteComps10128 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								local var_59_12 = Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, var_59_11)
								local var_59_13 = Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, var_59_11)
								local var_59_14 = Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, var_59_11)

								iter_59_5.color = Color.New(var_59_12, var_59_13, var_59_14)
							else
								local var_59_15 = Mathf.Lerp(iter_59_5.color.r, 0.5, var_59_11)

								iter_59_5.color = Color.New(var_59_15, var_59_15, var_59_15)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps10128 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_59_7 then
						if arg_56_1.isInRecall_ then
							iter_59_7.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10128 = nil
			end

			local var_59_16 = 0
			local var_59_17 = 0.775

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_18 = arg_56_1:FormatText(StoryNameCfg[1109].name)

				arg_56_1.leftNameTxt_.text = var_59_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_19 = arg_56_1:GetWordFromCfg(417041013)
				local var_59_20 = arg_56_1:FormatText(var_59_19.content)

				arg_56_1.text_.text = var_59_20

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 31
				local var_59_22 = utf8.len(var_59_20)
				local var_59_23 = var_59_21 <= 0 and var_59_17 or var_59_17 * (var_59_22 / var_59_21)

				if var_59_23 > 0 and var_59_17 < var_59_23 then
					arg_56_1.talkMaxDuration = var_59_23

					if var_59_23 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_20
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041013", "story_v_out_417041.awb") ~= 0 then
					local var_59_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041013", "story_v_out_417041.awb") / 1000

					if var_59_24 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_24 + var_59_16
					end

					if var_59_19.prefab_name ~= "" and arg_56_1.actors_[var_59_19.prefab_name] ~= nil then
						local var_59_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_19.prefab_name].transform, "story_v_out_417041", "417041013", "story_v_out_417041.awb")

						arg_56_1:RecordAudio("417041013", var_59_25)
						arg_56_1:RecordAudio("417041013", var_59_25)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_417041", "417041013", "story_v_out_417041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_417041", "417041013", "story_v_out_417041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_26 = math.max(var_59_17, arg_56_1.talkMaxDuration)

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_26 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_26

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_26 and arg_56_1.time_ < var_59_16 + var_59_26 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417041014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417041014
		arg_60_1.duration_ = 8.73

		local var_60_0 = {
			zh = 6.566,
			ja = 8.733
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
				arg_60_0:Play417041015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1034"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1034 = var_63_0.localPosition
				var_63_0.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1034", 2)

				local var_63_2 = var_63_0.childCount

				for iter_63_0 = 0, var_63_2 - 1 do
					local var_63_3 = var_63_0:GetChild(iter_63_0)

					if var_63_3.name == "split_4" or not string.find(var_63_3.name, "split") then
						var_63_3.gameObject:SetActive(true)
					else
						var_63_3.gameObject:SetActive(false)
					end
				end
			end

			local var_63_4 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_4 then
				local var_63_5 = (arg_60_1.time_ - var_63_1) / var_63_4
				local var_63_6 = Vector3.New(-390, -331.9, -324)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1034, var_63_6, var_63_5)
			end

			if arg_60_1.time_ >= var_63_1 + var_63_4 and arg_60_1.time_ < var_63_1 + var_63_4 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_63_7 = 0
			local var_63_8 = 0.85

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_9 = arg_60_1:FormatText(StoryNameCfg[1109].name)

				arg_60_1.leftNameTxt_.text = var_63_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(417041014)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_12 = 34
				local var_63_13 = utf8.len(var_63_11)
				local var_63_14 = var_63_12 <= 0 and var_63_8 or var_63_8 * (var_63_13 / var_63_12)

				if var_63_14 > 0 and var_63_8 < var_63_14 then
					arg_60_1.talkMaxDuration = var_63_14

					if var_63_14 + var_63_7 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_7
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041014", "story_v_out_417041.awb") ~= 0 then
					local var_63_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041014", "story_v_out_417041.awb") / 1000

					if var_63_15 + var_63_7 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_7
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_out_417041", "417041014", "story_v_out_417041.awb")

						arg_60_1:RecordAudio("417041014", var_63_16)
						arg_60_1:RecordAudio("417041014", var_63_16)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_417041", "417041014", "story_v_out_417041.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_417041", "417041014", "story_v_out_417041.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_17 = math.max(var_63_8, arg_60_1.talkMaxDuration)

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_17 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_7) / var_63_17

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_7 + var_63_17 and arg_60_1.time_ < var_63_7 + var_63_17 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play417041015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417041015
		arg_64_1.duration_ = 6.93

		local var_64_0 = {
			zh = 4.633,
			ja = 6.933
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417041016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10128"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10128 == nil then
				arg_64_1.var_.actorSpriteComps10128 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps10128 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 1, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10128 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10128 = nil
			end

			local var_67_8 = arg_64_1.actors_["1034"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1034 == nil then
				arg_64_1.var_.actorSpriteComps1034 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps1034 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								local var_67_12 = Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, var_67_11)
								local var_67_13 = Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, var_67_11)
								local var_67_14 = Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, var_67_11)

								iter_67_5.color = Color.New(var_67_12, var_67_13, var_67_14)
							else
								local var_67_15 = Mathf.Lerp(iter_67_5.color.r, 0.5, var_67_11)

								iter_67_5.color = Color.New(var_67_15, var_67_15, var_67_15)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1034 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1034 = nil
			end

			local var_67_16 = 0
			local var_67_17 = 0.625

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_18 = arg_64_1:FormatText(StoryNameCfg[595].name)

				arg_64_1.leftNameTxt_.text = var_67_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_19 = arg_64_1:GetWordFromCfg(417041015)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 25
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_17 or var_67_17 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_17 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_16
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041015", "story_v_out_417041.awb") ~= 0 then
					local var_67_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041015", "story_v_out_417041.awb") / 1000

					if var_67_24 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_16
					end

					if var_67_19.prefab_name ~= "" and arg_64_1.actors_[var_67_19.prefab_name] ~= nil then
						local var_67_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_19.prefab_name].transform, "story_v_out_417041", "417041015", "story_v_out_417041.awb")

						arg_64_1:RecordAudio("417041015", var_67_25)
						arg_64_1:RecordAudio("417041015", var_67_25)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417041", "417041015", "story_v_out_417041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417041", "417041015", "story_v_out_417041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = math.max(var_67_17, arg_64_1.talkMaxDuration)

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_16) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_16 + var_67_26 and arg_64_1.time_ < var_67_16 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417041016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417041016
		arg_68_1.duration_ = 8.27

		local var_68_0 = {
			zh = 5.3,
			ja = 8.266
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
				arg_68_0:Play417041017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10128"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos10128 = var_71_0.localPosition
				var_71_0.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10128", 4)

				local var_71_2 = var_71_0.childCount

				for iter_71_0 = 0, var_71_2 - 1 do
					local var_71_3 = var_71_0:GetChild(iter_71_0)

					if var_71_3.name == "" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_4 then
				local var_71_5 = (arg_68_1.time_ - var_71_1) / var_71_4
				local var_71_6 = Vector3.New(390, -347, -300)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10128, var_71_6, var_71_5)
			end

			if arg_68_1.time_ >= var_71_1 + var_71_4 and arg_68_1.time_ < var_71_1 + var_71_4 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(390, -347, -300)
			end

			local var_71_7 = 0
			local var_71_8 = 0.725

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_9 = arg_68_1:FormatText(StoryNameCfg[595].name)

				arg_68_1.leftNameTxt_.text = var_71_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(417041016)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_12 = 29
				local var_71_13 = utf8.len(var_71_11)
				local var_71_14 = var_71_12 <= 0 and var_71_8 or var_71_8 * (var_71_13 / var_71_12)

				if var_71_14 > 0 and var_71_8 < var_71_14 then
					arg_68_1.talkMaxDuration = var_71_14

					if var_71_14 + var_71_7 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_7
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041016", "story_v_out_417041.awb") ~= 0 then
					local var_71_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041016", "story_v_out_417041.awb") / 1000

					if var_71_15 + var_71_7 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_7
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_out_417041", "417041016", "story_v_out_417041.awb")

						arg_68_1:RecordAudio("417041016", var_71_16)
						arg_68_1:RecordAudio("417041016", var_71_16)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417041", "417041016", "story_v_out_417041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417041", "417041016", "story_v_out_417041.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_17 = math.max(var_71_8, arg_68_1.talkMaxDuration)

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_17 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_7) / var_71_17

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_7 + var_71_17 and arg_68_1.time_ < var_71_7 + var_71_17 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play417041017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417041017
		arg_72_1.duration_ = 4.97

		local var_72_0 = {
			zh = 3.333,
			ja = 4.966
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
				arg_72_0:Play417041018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1034"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1034 == nil then
				arg_72_1.var_.actorSpriteComps1034 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps1034 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1034 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1034 = nil
			end

			local var_75_8 = arg_72_1.actors_["10128"]
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10128 == nil then
				arg_72_1.var_.actorSpriteComps10128 = var_75_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_10 = 0.2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 and not isNil(var_75_8) then
				local var_75_11 = (arg_72_1.time_ - var_75_9) / var_75_10

				if arg_72_1.var_.actorSpriteComps10128 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								local var_75_12 = Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, var_75_11)
								local var_75_13 = Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, var_75_11)
								local var_75_14 = Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, var_75_11)

								iter_75_5.color = Color.New(var_75_12, var_75_13, var_75_14)
							else
								local var_75_15 = Mathf.Lerp(iter_75_5.color.r, 0.5, var_75_11)

								iter_75_5.color = Color.New(var_75_15, var_75_15, var_75_15)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10128 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_75_7 then
						if arg_72_1.isInRecall_ then
							iter_75_7.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10128 = nil
			end

			local var_75_16 = arg_72_1.actors_["1034"].transform
			local var_75_17 = 0

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.var_.moveOldPos1034 = var_75_16.localPosition
				var_75_16.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1034", 2)

				local var_75_18 = var_75_16.childCount

				for iter_75_8 = 0, var_75_18 - 1 do
					local var_75_19 = var_75_16:GetChild(iter_75_8)

					if var_75_19.name == "split_4" or not string.find(var_75_19.name, "split") then
						var_75_19.gameObject:SetActive(true)
					else
						var_75_19.gameObject:SetActive(false)
					end
				end
			end

			local var_75_20 = 0.001

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_20 then
				local var_75_21 = (arg_72_1.time_ - var_75_17) / var_75_20
				local var_75_22 = Vector3.New(-390, -331.9, -324)

				var_75_16.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1034, var_75_22, var_75_21)
			end

			if arg_72_1.time_ >= var_75_17 + var_75_20 and arg_72_1.time_ < var_75_17 + var_75_20 + arg_75_0 then
				var_75_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_75_23 = 0
			local var_75_24 = 0.425

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_25 = arg_72_1:FormatText(StoryNameCfg[1109].name)

				arg_72_1.leftNameTxt_.text = var_75_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_26 = arg_72_1:GetWordFromCfg(417041017)
				local var_75_27 = arg_72_1:FormatText(var_75_26.content)

				arg_72_1.text_.text = var_75_27

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_28 = 16
				local var_75_29 = utf8.len(var_75_27)
				local var_75_30 = var_75_28 <= 0 and var_75_24 or var_75_24 * (var_75_29 / var_75_28)

				if var_75_30 > 0 and var_75_24 < var_75_30 then
					arg_72_1.talkMaxDuration = var_75_30

					if var_75_30 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_30 + var_75_23
					end
				end

				arg_72_1.text_.text = var_75_27
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041017", "story_v_out_417041.awb") ~= 0 then
					local var_75_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041017", "story_v_out_417041.awb") / 1000

					if var_75_31 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_23
					end

					if var_75_26.prefab_name ~= "" and arg_72_1.actors_[var_75_26.prefab_name] ~= nil then
						local var_75_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_26.prefab_name].transform, "story_v_out_417041", "417041017", "story_v_out_417041.awb")

						arg_72_1:RecordAudio("417041017", var_75_32)
						arg_72_1:RecordAudio("417041017", var_75_32)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417041", "417041017", "story_v_out_417041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417041", "417041017", "story_v_out_417041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_33 = math.max(var_75_24, arg_72_1.talkMaxDuration)

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_33 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_23) / var_75_33

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_23 + var_75_33 and arg_72_1.time_ < var_75_23 + var_75_33 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play417041018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417041018
		arg_76_1.duration_ = 8.5

		local var_76_0 = {
			zh = 8.5,
			ja = 8.1
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
				arg_76_0:Play417041019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10128"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10128 == nil then
				arg_76_1.var_.actorSpriteComps10128 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10128 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 1, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10128 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10128 = nil
			end

			local var_79_8 = arg_76_1.actors_["1034"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1034 == nil then
				arg_76_1.var_.actorSpriteComps1034 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps1034 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								local var_79_12 = Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, var_79_11)
								local var_79_13 = Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, var_79_11)
								local var_79_14 = Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, var_79_11)

								iter_79_5.color = Color.New(var_79_12, var_79_13, var_79_14)
							else
								local var_79_15 = Mathf.Lerp(iter_79_5.color.r, 0.5, var_79_11)

								iter_79_5.color = Color.New(var_79_15, var_79_15, var_79_15)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1034 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1034 = nil
			end

			local var_79_16 = arg_76_1.actors_["10128"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 4)

				local var_79_18 = var_79_16.childCount

				for iter_79_8 = 0, var_79_18 - 1 do
					local var_79_19 = var_79_16:GetChild(iter_79_8)

					if var_79_19.name == "split_2" or not string.find(var_79_19.name, "split") then
						var_79_19.gameObject:SetActive(true)
					else
						var_79_19.gameObject:SetActive(false)
					end
				end
			end

			local var_79_20 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_20 then
				local var_79_21 = (arg_76_1.time_ - var_79_17) / var_79_20
				local var_79_22 = Vector3.New(390, -347, -300)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, var_79_22, var_79_21)
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_79_23 = 0
			local var_79_24 = 1.025

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[595].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(417041018)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 41
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041018", "story_v_out_417041.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041018", "story_v_out_417041.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_out_417041", "417041018", "story_v_out_417041.awb")

						arg_76_1:RecordAudio("417041018", var_79_32)
						arg_76_1:RecordAudio("417041018", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417041", "417041018", "story_v_out_417041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417041", "417041018", "story_v_out_417041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play417041019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417041019
		arg_80_1.duration_ = 11.8

		local var_80_0 = {
			zh = 9.533,
			ja = 11.8
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
				arg_80_0:Play417041020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.275

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[595].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(417041019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041019", "story_v_out_417041.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041019", "story_v_out_417041.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_417041", "417041019", "story_v_out_417041.awb")

						arg_80_1:RecordAudio("417041019", var_83_9)
						arg_80_1:RecordAudio("417041019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417041", "417041019", "story_v_out_417041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417041", "417041019", "story_v_out_417041.awb")
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
	Play417041020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417041020
		arg_84_1.duration_ = 9.63

		local var_84_0 = {
			zh = 6.933,
			ja = 9.633
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
				arg_84_0:Play417041021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.925

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[595].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(417041020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 37
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041020", "story_v_out_417041.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041020", "story_v_out_417041.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_417041", "417041020", "story_v_out_417041.awb")

						arg_84_1:RecordAudio("417041020", var_87_9)
						arg_84_1:RecordAudio("417041020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417041", "417041020", "story_v_out_417041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417041", "417041020", "story_v_out_417041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417041021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417041021
		arg_88_1.duration_ = 10.37

		local var_88_0 = {
			zh = 7.3,
			ja = 10.366
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
				arg_88_0:Play417041022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10128"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos10128 = var_91_0.localPosition
				var_91_0.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10128", 4)

				local var_91_2 = var_91_0.childCount

				for iter_91_0 = 0, var_91_2 - 1 do
					local var_91_3 = var_91_0:GetChild(iter_91_0)

					if var_91_3.name == "" or not string.find(var_91_3.name, "split") then
						var_91_3.gameObject:SetActive(true)
					else
						var_91_3.gameObject:SetActive(false)
					end
				end
			end

			local var_91_4 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_4 then
				local var_91_5 = (arg_88_1.time_ - var_91_1) / var_91_4
				local var_91_6 = Vector3.New(390, -347, -300)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10128, var_91_6, var_91_5)
			end

			if arg_88_1.time_ >= var_91_1 + var_91_4 and arg_88_1.time_ < var_91_1 + var_91_4 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(390, -347, -300)
			end

			local var_91_7 = 0
			local var_91_8 = 0.85

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_9 = arg_88_1:FormatText(StoryNameCfg[595].name)

				arg_88_1.leftNameTxt_.text = var_91_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(417041021)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_12 = 34
				local var_91_13 = utf8.len(var_91_11)
				local var_91_14 = var_91_12 <= 0 and var_91_8 or var_91_8 * (var_91_13 / var_91_12)

				if var_91_14 > 0 and var_91_8 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14

					if var_91_14 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_7
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041021", "story_v_out_417041.awb") ~= 0 then
					local var_91_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041021", "story_v_out_417041.awb") / 1000

					if var_91_15 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_7
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_417041", "417041021", "story_v_out_417041.awb")

						arg_88_1:RecordAudio("417041021", var_91_16)
						arg_88_1:RecordAudio("417041021", var_91_16)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417041", "417041021", "story_v_out_417041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417041", "417041021", "story_v_out_417041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_17 = math.max(var_91_8, arg_88_1.talkMaxDuration)

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_17 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_7) / var_91_17

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_7 + var_91_17 and arg_88_1.time_ < var_91_7 + var_91_17 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play417041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417041022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play417041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10128"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10128 == nil then
				arg_92_1.var_.actorSpriteComps10128 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10128 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 0.5, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10128 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10128 = nil
			end

			local var_95_8 = arg_92_1.actors_["1034"].transform
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.var_.moveOldPos1034 = var_95_8.localPosition
				var_95_8.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1034", 7)

				local var_95_10 = var_95_8.childCount

				for iter_95_4 = 0, var_95_10 - 1 do
					local var_95_11 = var_95_8:GetChild(iter_95_4)

					if var_95_11.name == "" or not string.find(var_95_11.name, "split") then
						var_95_11.gameObject:SetActive(true)
					else
						var_95_11.gameObject:SetActive(false)
					end
				end
			end

			local var_95_12 = 0.001

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_9) / var_95_12
				local var_95_14 = Vector3.New(0, -2000, 0)

				var_95_8.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1034, var_95_14, var_95_13)
			end

			if arg_92_1.time_ >= var_95_9 + var_95_12 and arg_92_1.time_ < var_95_9 + var_95_12 + arg_95_0 then
				var_95_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_15 = arg_92_1.actors_["10128"].transform
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.var_.moveOldPos10128 = var_95_15.localPosition
				var_95_15.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10128", 7)

				local var_95_17 = var_95_15.childCount

				for iter_95_5 = 0, var_95_17 - 1 do
					local var_95_18 = var_95_15:GetChild(iter_95_5)

					if var_95_18.name == "" or not string.find(var_95_18.name, "split") then
						var_95_18.gameObject:SetActive(true)
					else
						var_95_18.gameObject:SetActive(false)
					end
				end
			end

			local var_95_19 = 0.001

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_16) / var_95_19
				local var_95_21 = Vector3.New(0, -2000, -300)

				var_95_15.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10128, var_95_21, var_95_20)
			end

			if arg_92_1.time_ >= var_95_16 + var_95_19 and arg_92_1.time_ < var_95_16 + var_95_19 + arg_95_0 then
				var_95_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_95_22 = 0.2
			local var_95_23 = 1

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				local var_95_24 = "play"
				local var_95_25 = "effect"

				arg_92_1:AudioAction(var_95_24, var_95_25, "se_story_side_1028", "se_story_side_1028_door", "")
			end

			local var_95_26 = 0
			local var_95_27 = 1.775

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_28 = arg_92_1:GetWordFromCfg(417041022)
				local var_95_29 = arg_92_1:FormatText(var_95_28.content)

				arg_92_1.text_.text = var_95_29

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_30 = 71
				local var_95_31 = utf8.len(var_95_29)
				local var_95_32 = var_95_30 <= 0 and var_95_27 or var_95_27 * (var_95_31 / var_95_30)

				if var_95_32 > 0 and var_95_27 < var_95_32 then
					arg_92_1.talkMaxDuration = var_95_32

					if var_95_32 + var_95_26 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_32 + var_95_26
					end
				end

				arg_92_1.text_.text = var_95_29
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_27, arg_92_1.talkMaxDuration)

			if var_95_26 <= arg_92_1.time_ and arg_92_1.time_ < var_95_26 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_26) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_26 + var_95_33 and arg_92_1.time_ < var_95_26 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play417041023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417041023
		arg_96_1.duration_ = 5.47

		local var_96_0 = {
			zh = 1.866,
			ja = 5.466
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
				arg_96_0:Play417041024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1034"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1034 == nil then
				arg_96_1.var_.actorSpriteComps1034 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps1034 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 1, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1034 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1034 = nil
			end

			local var_99_8 = arg_96_1.actors_["1034"].transform
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.var_.moveOldPos1034 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1034", 2)

				local var_99_10 = var_99_8.childCount

				for iter_99_4 = 0, var_99_10 - 1 do
					local var_99_11 = var_99_8:GetChild(iter_99_4)

					if var_99_11.name == "split_4" or not string.find(var_99_11.name, "split") then
						var_99_11.gameObject:SetActive(true)
					else
						var_99_11.gameObject:SetActive(false)
					end
				end
			end

			local var_99_12 = 0.001

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_9) / var_99_12
				local var_99_14 = Vector3.New(-390, -331.9, -324)

				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1034, var_99_14, var_99_13)
			end

			if arg_96_1.time_ >= var_99_9 + var_99_12 and arg_96_1.time_ < var_99_9 + var_99_12 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_99_15 = 0
			local var_99_16 = 0.25

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[1109].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(417041023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 10
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041023", "story_v_out_417041.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041023", "story_v_out_417041.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_417041", "417041023", "story_v_out_417041.awb")

						arg_96_1:RecordAudio("417041023", var_99_24)
						arg_96_1:RecordAudio("417041023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417041", "417041023", "story_v_out_417041.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417041", "417041023", "story_v_out_417041.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play417041024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417041024
		arg_100_1.duration_ = 11.67

		local var_100_0 = {
			zh = 4.566,
			ja = 11.666
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
				arg_100_0:Play417041025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1034"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 0.5, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_8 = arg_100_1.actors_["10128"].transform
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1.var_.moveOldPos10128 = var_103_8.localPosition
				var_103_8.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10128", 4)

				local var_103_10 = var_103_8.childCount

				for iter_103_4 = 0, var_103_10 - 1 do
					local var_103_11 = var_103_8:GetChild(iter_103_4)

					if var_103_11.name == "" or not string.find(var_103_11.name, "split") then
						var_103_11.gameObject:SetActive(true)
					else
						var_103_11.gameObject:SetActive(false)
					end
				end
			end

			local var_103_12 = 0.001

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_9) / var_103_12
				local var_103_14 = Vector3.New(390, -347, -300)

				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10128, var_103_14, var_103_13)
			end

			if arg_100_1.time_ >= var_103_9 + var_103_12 and arg_100_1.time_ < var_103_9 + var_103_12 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_103_15 = arg_100_1.actors_["10128"]
			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 and not isNil(var_103_15) and arg_100_1.var_.actorSpriteComps10128 == nil then
				arg_100_1.var_.actorSpriteComps10128 = var_103_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_17 = 0.2

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 and not isNil(var_103_15) then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17

				if arg_100_1.var_.actorSpriteComps10128 then
					for iter_103_5, iter_103_6 in pairs(arg_100_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_103_6 then
							if arg_100_1.isInRecall_ then
								local var_103_19 = Mathf.Lerp(iter_103_6.color.r, arg_100_1.hightColor1.r, var_103_18)
								local var_103_20 = Mathf.Lerp(iter_103_6.color.g, arg_100_1.hightColor1.g, var_103_18)
								local var_103_21 = Mathf.Lerp(iter_103_6.color.b, arg_100_1.hightColor1.b, var_103_18)

								iter_103_6.color = Color.New(var_103_19, var_103_20, var_103_21)
							else
								local var_103_22 = Mathf.Lerp(iter_103_6.color.r, 1, var_103_18)

								iter_103_6.color = Color.New(var_103_22, var_103_22, var_103_22)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 and not isNil(var_103_15) and arg_100_1.var_.actorSpriteComps10128 then
				for iter_103_7, iter_103_8 in pairs(arg_100_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_103_8 then
						if arg_100_1.isInRecall_ then
							iter_103_8.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10128 = nil
			end

			local var_103_23 = 0
			local var_103_24 = 0.475

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_25 = arg_100_1:FormatText(StoryNameCfg[595].name)

				arg_100_1.leftNameTxt_.text = var_103_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_26 = arg_100_1:GetWordFromCfg(417041024)
				local var_103_27 = arg_100_1:FormatText(var_103_26.content)

				arg_100_1.text_.text = var_103_27

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_28 = 19
				local var_103_29 = utf8.len(var_103_27)
				local var_103_30 = var_103_28 <= 0 and var_103_24 or var_103_24 * (var_103_29 / var_103_28)

				if var_103_30 > 0 and var_103_24 < var_103_30 then
					arg_100_1.talkMaxDuration = var_103_30

					if var_103_30 + var_103_23 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_30 + var_103_23
					end
				end

				arg_100_1.text_.text = var_103_27
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041024", "story_v_out_417041.awb") ~= 0 then
					local var_103_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041024", "story_v_out_417041.awb") / 1000

					if var_103_31 + var_103_23 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_31 + var_103_23
					end

					if var_103_26.prefab_name ~= "" and arg_100_1.actors_[var_103_26.prefab_name] ~= nil then
						local var_103_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_26.prefab_name].transform, "story_v_out_417041", "417041024", "story_v_out_417041.awb")

						arg_100_1:RecordAudio("417041024", var_103_32)
						arg_100_1:RecordAudio("417041024", var_103_32)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417041", "417041024", "story_v_out_417041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417041", "417041024", "story_v_out_417041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_33 = math.max(var_103_24, arg_100_1.talkMaxDuration)

			if var_103_23 <= arg_100_1.time_ and arg_100_1.time_ < var_103_23 + var_103_33 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_23) / var_103_33

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_23 + var_103_33 and arg_100_1.time_ < var_103_23 + var_103_33 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play417041025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417041025
		arg_104_1.duration_ = 6.73

		local var_104_0 = {
			zh = 6.733,
			ja = 4.933
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
				arg_104_0:Play417041026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1034"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1034 == nil then
				arg_104_1.var_.actorSpriteComps1034 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps1034 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1034 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1034 = nil
			end

			local var_107_8 = arg_104_1.actors_["10128"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10128 == nil then
				arg_104_1.var_.actorSpriteComps10128 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps10128 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 0.5, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10128 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10128 = nil
			end

			local var_107_16 = 0
			local var_107_17 = 0.725

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_18 = arg_104_1:FormatText(StoryNameCfg[1109].name)

				arg_104_1.leftNameTxt_.text = var_107_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_19 = arg_104_1:GetWordFromCfg(417041025)
				local var_107_20 = arg_104_1:FormatText(var_107_19.content)

				arg_104_1.text_.text = var_107_20

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_21 = 29
				local var_107_22 = utf8.len(var_107_20)
				local var_107_23 = var_107_21 <= 0 and var_107_17 or var_107_17 * (var_107_22 / var_107_21)

				if var_107_23 > 0 and var_107_17 < var_107_23 then
					arg_104_1.talkMaxDuration = var_107_23

					if var_107_23 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_16
					end
				end

				arg_104_1.text_.text = var_107_20
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041025", "story_v_out_417041.awb") ~= 0 then
					local var_107_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041025", "story_v_out_417041.awb") / 1000

					if var_107_24 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_24 + var_107_16
					end

					if var_107_19.prefab_name ~= "" and arg_104_1.actors_[var_107_19.prefab_name] ~= nil then
						local var_107_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_19.prefab_name].transform, "story_v_out_417041", "417041025", "story_v_out_417041.awb")

						arg_104_1:RecordAudio("417041025", var_107_25)
						arg_104_1:RecordAudio("417041025", var_107_25)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417041", "417041025", "story_v_out_417041.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417041", "417041025", "story_v_out_417041.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_26 = math.max(var_107_17, arg_104_1.talkMaxDuration)

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_26 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_16) / var_107_26

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_16 + var_107_26 and arg_104_1.time_ < var_107_16 + var_107_26 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417041026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417041026
		arg_108_1.duration_ = 5.87

		local var_108_0 = {
			zh = 2.9,
			ja = 5.866
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
				arg_108_0:Play417041027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10128"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10128 == nil then
				arg_108_1.var_.actorSpriteComps10128 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps10128 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10128 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10128 = nil
			end

			local var_111_8 = arg_108_1.actors_["1034"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.2

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 0.5, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 0.35

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[595].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(417041026)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 14
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041026", "story_v_out_417041.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041026", "story_v_out_417041.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_out_417041", "417041026", "story_v_out_417041.awb")

						arg_108_1:RecordAudio("417041026", var_111_25)
						arg_108_1:RecordAudio("417041026", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417041", "417041026", "story_v_out_417041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417041", "417041026", "story_v_out_417041.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_26 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_26 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_26

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_26 and arg_108_1.time_ < var_111_16 + var_111_26 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play417041027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417041027
		arg_112_1.duration_ = 10.17

		local var_112_0 = {
			zh = 5.766,
			ja = 10.166
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
				arg_112_0:Play417041028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10128"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10128 = var_115_0.localPosition
				var_115_0.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10128", 4)

				local var_115_2 = var_115_0.childCount

				for iter_115_0 = 0, var_115_2 - 1 do
					local var_115_3 = var_115_0:GetChild(iter_115_0)

					if var_115_3.name == "split_2" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_4 then
				local var_115_5 = (arg_112_1.time_ - var_115_1) / var_115_4
				local var_115_6 = Vector3.New(390, -347, -300)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10128, var_115_6, var_115_5)
			end

			if arg_112_1.time_ >= var_115_1 + var_115_4 and arg_112_1.time_ < var_115_1 + var_115_4 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(390, -347, -300)
			end

			local var_115_7 = 0
			local var_115_8 = 0.7

			if var_115_7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_9 = arg_112_1:FormatText(StoryNameCfg[595].name)

				arg_112_1.leftNameTxt_.text = var_115_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(417041027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 28
				local var_115_13 = utf8.len(var_115_11)
				local var_115_14 = var_115_12 <= 0 and var_115_8 or var_115_8 * (var_115_13 / var_115_12)

				if var_115_14 > 0 and var_115_8 < var_115_14 then
					arg_112_1.talkMaxDuration = var_115_14

					if var_115_14 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_7
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041027", "story_v_out_417041.awb") ~= 0 then
					local var_115_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041027", "story_v_out_417041.awb") / 1000

					if var_115_15 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_15 + var_115_7
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_417041", "417041027", "story_v_out_417041.awb")

						arg_112_1:RecordAudio("417041027", var_115_16)
						arg_112_1:RecordAudio("417041027", var_115_16)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417041", "417041027", "story_v_out_417041.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417041", "417041027", "story_v_out_417041.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_17 = math.max(var_115_8, arg_112_1.talkMaxDuration)

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_17 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_7) / var_115_17

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_7 + var_115_17 and arg_112_1.time_ < var_115_7 + var_115_17 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417041028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417041028
		arg_116_1.duration_ = 10.87

		local var_116_0 = {
			zh = 8.9,
			ja = 10.866
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
				arg_116_0:Play417041029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1034"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_8 = arg_116_1.actors_["10128"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10128 == nil then
				arg_116_1.var_.actorSpriteComps10128 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps10128 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10128 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10128 = nil
			end

			local var_119_16 = 0
			local var_119_17 = 1.075

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_18 = arg_116_1:FormatText(StoryNameCfg[1109].name)

				arg_116_1.leftNameTxt_.text = var_119_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_19 = arg_116_1:GetWordFromCfg(417041028)
				local var_119_20 = arg_116_1:FormatText(var_119_19.content)

				arg_116_1.text_.text = var_119_20

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_21 = 43
				local var_119_22 = utf8.len(var_119_20)
				local var_119_23 = var_119_21 <= 0 and var_119_17 or var_119_17 * (var_119_22 / var_119_21)

				if var_119_23 > 0 and var_119_17 < var_119_23 then
					arg_116_1.talkMaxDuration = var_119_23

					if var_119_23 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_16
					end
				end

				arg_116_1.text_.text = var_119_20
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041028", "story_v_out_417041.awb") ~= 0 then
					local var_119_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041028", "story_v_out_417041.awb") / 1000

					if var_119_24 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_16
					end

					if var_119_19.prefab_name ~= "" and arg_116_1.actors_[var_119_19.prefab_name] ~= nil then
						local var_119_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_19.prefab_name].transform, "story_v_out_417041", "417041028", "story_v_out_417041.awb")

						arg_116_1:RecordAudio("417041028", var_119_25)
						arg_116_1:RecordAudio("417041028", var_119_25)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417041", "417041028", "story_v_out_417041.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417041", "417041028", "story_v_out_417041.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_26 = math.max(var_119_17, arg_116_1.talkMaxDuration)

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_26 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_16) / var_119_26

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_16 + var_119_26 and arg_116_1.time_ < var_119_16 + var_119_26 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417041029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417041029
		arg_120_1.duration_ = 12.6

		local var_120_0 = {
			zh = 11,
			ja = 12.6
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
				arg_120_0:Play417041030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1034"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1034 = var_123_0.localPosition
				var_123_0.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1034", 2)

				local var_123_2 = var_123_0.childCount

				for iter_123_0 = 0, var_123_2 - 1 do
					local var_123_3 = var_123_0:GetChild(iter_123_0)

					if var_123_3.name == "split_6" or not string.find(var_123_3.name, "split") then
						var_123_3.gameObject:SetActive(true)
					else
						var_123_3.gameObject:SetActive(false)
					end
				end
			end

			local var_123_4 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_4 then
				local var_123_5 = (arg_120_1.time_ - var_123_1) / var_123_4
				local var_123_6 = Vector3.New(-390, -331.9, -324)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1034, var_123_6, var_123_5)
			end

			if arg_120_1.time_ >= var_123_1 + var_123_4 and arg_120_1.time_ < var_123_1 + var_123_4 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_123_7 = 0
			local var_123_8 = 1.175

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_9 = arg_120_1:FormatText(StoryNameCfg[1109].name)

				arg_120_1.leftNameTxt_.text = var_123_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(417041029)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_12 = 47
				local var_123_13 = utf8.len(var_123_11)
				local var_123_14 = var_123_12 <= 0 and var_123_8 or var_123_8 * (var_123_13 / var_123_12)

				if var_123_14 > 0 and var_123_8 < var_123_14 then
					arg_120_1.talkMaxDuration = var_123_14

					if var_123_14 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_7
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041029", "story_v_out_417041.awb") ~= 0 then
					local var_123_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041029", "story_v_out_417041.awb") / 1000

					if var_123_15 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_7
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_417041", "417041029", "story_v_out_417041.awb")

						arg_120_1:RecordAudio("417041029", var_123_16)
						arg_120_1:RecordAudio("417041029", var_123_16)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417041", "417041029", "story_v_out_417041.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417041", "417041029", "story_v_out_417041.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_17 = math.max(var_123_8, arg_120_1.talkMaxDuration)

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_17 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_7) / var_123_17

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_7 + var_123_17 and arg_120_1.time_ < var_123_7 + var_123_17 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play417041030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417041030
		arg_124_1.duration_ = 5.97

		local var_124_0 = {
			zh = 5.1,
			ja = 5.966
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417041031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10128"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 == nil then
				arg_124_1.var_.actorSpriteComps10128 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10128 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 1, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_8 = arg_124_1.actors_["1034"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 0.5, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_16 = arg_124_1.actors_["10128"].transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPos10128 = var_127_16.localPosition
				var_127_16.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10128", 4)

				local var_127_18 = var_127_16.childCount

				for iter_127_8 = 0, var_127_18 - 1 do
					local var_127_19 = var_127_16:GetChild(iter_127_8)

					if var_127_19.name == "" or not string.find(var_127_19.name, "split") then
						var_127_19.gameObject:SetActive(true)
					else
						var_127_19.gameObject:SetActive(false)
					end
				end
			end

			local var_127_20 = 0.001

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_17) / var_127_20
				local var_127_22 = Vector3.New(390, -347, -300)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10128, var_127_22, var_127_21)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_20 and arg_124_1.time_ < var_127_17 + var_127_20 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_127_23 = 0
			local var_127_24 = 0.65

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[595].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(417041030)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 26
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041030", "story_v_out_417041.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041030", "story_v_out_417041.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_out_417041", "417041030", "story_v_out_417041.awb")

						arg_124_1:RecordAudio("417041030", var_127_32)
						arg_124_1:RecordAudio("417041030", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417041", "417041030", "story_v_out_417041.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417041", "417041030", "story_v_out_417041.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417041031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417041031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417041032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10128"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 == nil then
				arg_128_1.var_.actorSpriteComps10128 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps10128 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 0.5, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_8 = arg_128_1.actors_["1034"].transform
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.var_.moveOldPos1034 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1034", 7)

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
				local var_131_14 = Vector3.New(0, -2000, 0)

				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1034, var_131_14, var_131_13)
			end

			if arg_128_1.time_ >= var_131_9 + var_131_12 and arg_128_1.time_ < var_131_9 + var_131_12 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_15 = arg_128_1.actors_["10128"].transform
			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.var_.moveOldPos10128 = var_131_15.localPosition
				var_131_15.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10128", 7)

				local var_131_17 = var_131_15.childCount

				for iter_131_5 = 0, var_131_17 - 1 do
					local var_131_18 = var_131_15:GetChild(iter_131_5)

					if var_131_18.name == "" or not string.find(var_131_18.name, "split") then
						var_131_18.gameObject:SetActive(true)
					else
						var_131_18.gameObject:SetActive(false)
					end
				end
			end

			local var_131_19 = 0.001

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_19 then
				local var_131_20 = (arg_128_1.time_ - var_131_16) / var_131_19
				local var_131_21 = Vector3.New(0, -2000, -300)

				var_131_15.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10128, var_131_21, var_131_20)
			end

			if arg_128_1.time_ >= var_131_16 + var_131_19 and arg_128_1.time_ < var_131_16 + var_131_19 + arg_131_0 then
				var_131_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_131_22 = 0.05
			local var_131_23 = 1

			if var_131_22 < arg_128_1.time_ and arg_128_1.time_ <= var_131_22 + arg_131_0 then
				local var_131_24 = "play"
				local var_131_25 = "effect"

				arg_128_1:AudioAction(var_131_24, var_131_25, "se_story_side_1199", "se_story_1199_shock", "")
			end

			local var_131_26 = 0
			local var_131_27 = 1.075

			if var_131_26 < arg_128_1.time_ and arg_128_1.time_ <= var_131_26 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_28 = arg_128_1:GetWordFromCfg(417041031)
				local var_131_29 = arg_128_1:FormatText(var_131_28.content)

				arg_128_1.text_.text = var_131_29

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_30 = 43
				local var_131_31 = utf8.len(var_131_29)
				local var_131_32 = var_131_30 <= 0 and var_131_27 or var_131_27 * (var_131_31 / var_131_30)

				if var_131_32 > 0 and var_131_27 < var_131_32 then
					arg_128_1.talkMaxDuration = var_131_32

					if var_131_32 + var_131_26 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_32 + var_131_26
					end
				end

				arg_128_1.text_.text = var_131_29
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_33 = math.max(var_131_27, arg_128_1.talkMaxDuration)

			if var_131_26 <= arg_128_1.time_ and arg_128_1.time_ < var_131_26 + var_131_33 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_26) / var_131_33

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_26 + var_131_33 and arg_128_1.time_ < var_131_26 + var_131_33 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play417041032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417041032
		arg_132_1.duration_ = 3.17

		local var_132_0 = {
			zh = 1.766,
			ja = 3.166
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
				arg_132_0:Play417041033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10128"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10128 == nil then
				arg_132_1.var_.actorSpriteComps10128 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10128 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_8 = arg_132_1.actors_["10128"].transform
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.var_.moveOldPos10128 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10128", 3)

				local var_135_10 = var_135_8.childCount

				for iter_135_4 = 0, var_135_10 - 1 do
					local var_135_11 = var_135_8:GetChild(iter_135_4)

					if var_135_11.name == "" or not string.find(var_135_11.name, "split") then
						var_135_11.gameObject:SetActive(true)
					else
						var_135_11.gameObject:SetActive(false)
					end
				end
			end

			local var_135_12 = 0.001

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_9) / var_135_12
				local var_135_14 = Vector3.New(0, -347, -300)

				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10128, var_135_14, var_135_13)
			end

			if arg_132_1.time_ >= var_135_9 + var_135_12 and arg_132_1.time_ < var_135_9 + var_135_12 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_135_15 = 0
			local var_135_16 = 0.2

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[595].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(417041032)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 8
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041032", "story_v_out_417041.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041032", "story_v_out_417041.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_417041", "417041032", "story_v_out_417041.awb")

						arg_132_1:RecordAudio("417041032", var_135_24)
						arg_132_1:RecordAudio("417041032", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417041", "417041032", "story_v_out_417041.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417041", "417041032", "story_v_out_417041.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play417041033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417041033
		arg_136_1.duration_ = 5.1

		local var_136_0 = {
			zh = 3.1,
			ja = 5.1
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
				arg_136_0:Play417041034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1034"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_8 = arg_136_1.actors_["10128"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10128 == nil then
				arg_136_1.var_.actorSpriteComps10128 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 0.2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps10128 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10128 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10128 = nil
			end

			local var_139_16 = arg_136_1.actors_["1034"].transform
			local var_139_17 = 0

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_16.localPosition
				var_139_16.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 3)

				local var_139_18 = var_139_16.childCount

				for iter_139_8 = 0, var_139_18 - 1 do
					local var_139_19 = var_139_16:GetChild(iter_139_8)

					if var_139_19.name == "" or not string.find(var_139_19.name, "split") then
						var_139_19.gameObject:SetActive(true)
					else
						var_139_19.gameObject:SetActive(false)
					end
				end
			end

			local var_139_20 = 0.001

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_20 then
				local var_139_21 = (arg_136_1.time_ - var_139_17) / var_139_20
				local var_139_22 = Vector3.New(0, -331.9, -324)

				var_139_16.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, var_139_22, var_139_21)
			end

			if arg_136_1.time_ >= var_139_17 + var_139_20 and arg_136_1.time_ < var_139_17 + var_139_20 + arg_139_0 then
				var_139_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_139_23 = arg_136_1.actors_["10128"].transform
			local var_139_24 = 0

			if var_139_24 < arg_136_1.time_ and arg_136_1.time_ <= var_139_24 + arg_139_0 then
				arg_136_1.var_.moveOldPos10128 = var_139_23.localPosition
				var_139_23.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("10128", 7)

				local var_139_25 = var_139_23.childCount

				for iter_139_9 = 0, var_139_25 - 1 do
					local var_139_26 = var_139_23:GetChild(iter_139_9)

					if var_139_26.name == "" or not string.find(var_139_26.name, "split") then
						var_139_26.gameObject:SetActive(true)
					else
						var_139_26.gameObject:SetActive(false)
					end
				end
			end

			local var_139_27 = 0.001

			if var_139_24 <= arg_136_1.time_ and arg_136_1.time_ < var_139_24 + var_139_27 then
				local var_139_28 = (arg_136_1.time_ - var_139_24) / var_139_27
				local var_139_29 = Vector3.New(0, -2000, -300)

				var_139_23.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10128, var_139_29, var_139_28)
			end

			if arg_136_1.time_ >= var_139_24 + var_139_27 and arg_136_1.time_ < var_139_24 + var_139_27 + arg_139_0 then
				var_139_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_139_30 = 0
			local var_139_31 = 0.4

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[1109].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(417041033)
				local var_139_34 = arg_136_1:FormatText(var_139_33.content)

				arg_136_1.text_.text = var_139_34

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 16
				local var_139_36 = utf8.len(var_139_34)
				local var_139_37 = var_139_35 <= 0 and var_139_31 or var_139_31 * (var_139_36 / var_139_35)

				if var_139_37 > 0 and var_139_31 < var_139_37 then
					arg_136_1.talkMaxDuration = var_139_37

					if var_139_37 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_34
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041033", "story_v_out_417041.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041033", "story_v_out_417041.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_417041", "417041033", "story_v_out_417041.awb")

						arg_136_1:RecordAudio("417041033", var_139_39)
						arg_136_1:RecordAudio("417041033", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417041", "417041033", "story_v_out_417041.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417041", "417041033", "story_v_out_417041.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_40 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_40 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_40

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_40 and arg_136_1.time_ < var_139_30 + var_139_40 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play417041034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417041034
		arg_140_1.duration_ = 12.13

		local var_140_0 = {
			zh = 10.3666666666667,
			ja = 12.1326666666667
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
				arg_140_0:Play417041035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = "I07"

			if arg_140_1.bgs_[var_143_0] == nil then
				local var_143_1 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_143_0)
				var_143_1.name = var_143_0
				var_143_1.transform.parent = arg_140_1.stage_.transform
				var_143_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_[var_143_0] = var_143_1
			end

			local var_143_2 = 2

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				local var_143_3 = manager.ui.mainCamera.transform.localPosition
				local var_143_4 = Vector3.New(0, 0, 10) + Vector3.New(var_143_3.x, var_143_3.y, 0)
				local var_143_5 = arg_140_1.bgs_.I07

				var_143_5.transform.localPosition = var_143_4
				var_143_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_6 = var_143_5:GetComponent("SpriteRenderer")

				if var_143_6 and var_143_6.sprite then
					local var_143_7 = (var_143_5.transform.localPosition - var_143_3).z
					local var_143_8 = manager.ui.mainCameraCom_
					local var_143_9 = 2 * var_143_7 * Mathf.Tan(var_143_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_143_10 = var_143_9 * var_143_8.aspect
					local var_143_11 = var_143_6.sprite.bounds.size.x
					local var_143_12 = var_143_6.sprite.bounds.size.y
					local var_143_13 = var_143_10 / var_143_11
					local var_143_14 = var_143_9 / var_143_12
					local var_143_15 = var_143_14 < var_143_13 and var_143_13 or var_143_14

					var_143_5.transform.localScale = Vector3.New(var_143_15, var_143_15, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "I07" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			local var_143_17 = 0.3

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_18 = 0

			if var_143_18 < arg_140_1.time_ and arg_140_1.time_ <= var_143_18 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_19 = 2

			if var_143_18 <= arg_140_1.time_ and arg_140_1.time_ < var_143_18 + var_143_19 then
				local var_143_20 = (arg_140_1.time_ - var_143_18) / var_143_19
				local var_143_21 = Color.New(0, 0, 0)

				var_143_21.a = Mathf.Lerp(0, 1, var_143_20)
				arg_140_1.mask_.color = var_143_21
			end

			if arg_140_1.time_ >= var_143_18 + var_143_19 and arg_140_1.time_ < var_143_18 + var_143_19 + arg_143_0 then
				local var_143_22 = Color.New(0, 0, 0)

				var_143_22.a = 1
				arg_140_1.mask_.color = var_143_22
			end

			local var_143_23 = 2

			if var_143_23 < arg_140_1.time_ and arg_140_1.time_ <= var_143_23 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_24 = 2

			if var_143_23 <= arg_140_1.time_ and arg_140_1.time_ < var_143_23 + var_143_24 then
				local var_143_25 = (arg_140_1.time_ - var_143_23) / var_143_24
				local var_143_26 = Color.New(0, 0, 0)

				var_143_26.a = Mathf.Lerp(1, 0, var_143_25)
				arg_140_1.mask_.color = var_143_26
			end

			if arg_140_1.time_ >= var_143_23 + var_143_24 and arg_140_1.time_ < var_143_23 + var_143_24 + arg_143_0 then
				local var_143_27 = Color.New(0, 0, 0)
				local var_143_28 = 0

				arg_140_1.mask_.enabled = false
				var_143_27.a = var_143_28
				arg_140_1.mask_.color = var_143_27
			end

			local var_143_29 = arg_140_1.actors_["1034"].transform
			local var_143_30 = 1.966

			if var_143_30 < arg_140_1.time_ and arg_140_1.time_ <= var_143_30 + arg_143_0 then
				arg_140_1.var_.moveOldPos1034 = var_143_29.localPosition
				var_143_29.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1034", 7)

				local var_143_31 = var_143_29.childCount

				for iter_143_2 = 0, var_143_31 - 1 do
					local var_143_32 = var_143_29:GetChild(iter_143_2)

					if var_143_32.name == "" or not string.find(var_143_32.name, "split") then
						var_143_32.gameObject:SetActive(true)
					else
						var_143_32.gameObject:SetActive(false)
					end
				end
			end

			local var_143_33 = 0.001

			if var_143_30 <= arg_140_1.time_ and arg_140_1.time_ < var_143_30 + var_143_33 then
				local var_143_34 = (arg_140_1.time_ - var_143_30) / var_143_33
				local var_143_35 = Vector3.New(0, -2000, 0)

				var_143_29.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1034, var_143_35, var_143_34)
			end

			if arg_140_1.time_ >= var_143_30 + var_143_33 and arg_140_1.time_ < var_143_30 + var_143_33 + arg_143_0 then
				var_143_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_36 = 3.86666666666667
			local var_143_37 = 0.875

			if var_143_36 < arg_140_1.time_ and arg_140_1.time_ <= var_143_36 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_38 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_38:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_39 = arg_140_1:FormatText(StoryNameCfg[1109].name)

				arg_140_1.leftNameTxt_.text = var_143_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_40 = arg_140_1:GetWordFromCfg(417041034)
				local var_143_41 = arg_140_1:FormatText(var_143_40.content)

				arg_140_1.text_.text = var_143_41

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_42 = 35
				local var_143_43 = utf8.len(var_143_41)
				local var_143_44 = var_143_42 <= 0 and var_143_37 or var_143_37 * (var_143_43 / var_143_42)

				if var_143_44 > 0 and var_143_37 < var_143_44 then
					arg_140_1.talkMaxDuration = var_143_44
					var_143_36 = var_143_36 + 0.3

					if var_143_44 + var_143_36 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_44 + var_143_36
					end
				end

				arg_140_1.text_.text = var_143_41
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041034", "story_v_out_417041.awb") ~= 0 then
					local var_143_45 = manager.audio:GetVoiceLength("story_v_out_417041", "417041034", "story_v_out_417041.awb") / 1000

					if var_143_45 + var_143_36 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_45 + var_143_36
					end

					if var_143_40.prefab_name ~= "" and arg_140_1.actors_[var_143_40.prefab_name] ~= nil then
						local var_143_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_40.prefab_name].transform, "story_v_out_417041", "417041034", "story_v_out_417041.awb")

						arg_140_1:RecordAudio("417041034", var_143_46)
						arg_140_1:RecordAudio("417041034", var_143_46)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417041", "417041034", "story_v_out_417041.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417041", "417041034", "story_v_out_417041.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_47 = var_143_36 + 0.3
			local var_143_48 = math.max(var_143_37, arg_140_1.talkMaxDuration)

			if var_143_47 <= arg_140_1.time_ and arg_140_1.time_ < var_143_47 + var_143_48 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_47) / var_143_48

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_47 + var_143_48 and arg_140_1.time_ < var_143_47 + var_143_48 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play417041035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417041035
		arg_146_1.duration_ = 3.67

		local var_146_0 = {
			zh = 2.3,
			ja = 3.666
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
				arg_146_0:Play417041036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.3

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[595].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(417041035)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 12
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041035", "story_v_out_417041.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041035", "story_v_out_417041.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_417041", "417041035", "story_v_out_417041.awb")

						arg_146_1:RecordAudio("417041035", var_149_9)
						arg_146_1:RecordAudio("417041035", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417041", "417041035", "story_v_out_417041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417041", "417041035", "story_v_out_417041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417041036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417041036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417041037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.85

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

				local var_153_2 = arg_150_1:GetWordFromCfg(417041036)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 34
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
	Play417041037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417041037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417041038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.01
			local var_157_1 = 1

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				local var_157_2 = "play"
				local var_157_3 = "effect"

				arg_154_1:AudioAction(var_157_2, var_157_3, "se_story_side_1066", "se_story_1066_Metal", "")
			end

			local var_157_4 = 0
			local var_157_5 = 1.225

			if var_157_4 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(417041037)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_8 = 50
				local var_157_9 = utf8.len(var_157_7)
				local var_157_10 = var_157_8 <= 0 and var_157_5 or var_157_5 * (var_157_9 / var_157_8)

				if var_157_10 > 0 and var_157_5 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_11 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_11 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_11

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_11 and arg_154_1.time_ < var_157_4 + var_157_11 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play417041038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417041038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417041039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 1.725

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(417041038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 69
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417041039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417041039
		arg_162_1.duration_ = 2.97

		local var_162_0 = {
			zh = 1.3,
			ja = 2.966
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
				arg_162_0:Play417041040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1034"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1034 == nil then
				arg_162_1.var_.actorSpriteComps1034 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps1034 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 1, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1034 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_165_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps1034 = nil
			end

			local var_165_8 = arg_162_1.actors_["1034"].transform
			local var_165_9 = 0

			if var_165_9 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.var_.moveOldPos1034 = var_165_8.localPosition
				var_165_8.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1034", 2)

				local var_165_10 = var_165_8.childCount

				for iter_165_4 = 0, var_165_10 - 1 do
					local var_165_11 = var_165_8:GetChild(iter_165_4)

					if var_165_11.name == "split_1" or not string.find(var_165_11.name, "split") then
						var_165_11.gameObject:SetActive(true)
					else
						var_165_11.gameObject:SetActive(false)
					end
				end
			end

			local var_165_12 = 0.001

			if var_165_9 <= arg_162_1.time_ and arg_162_1.time_ < var_165_9 + var_165_12 then
				local var_165_13 = (arg_162_1.time_ - var_165_9) / var_165_12
				local var_165_14 = Vector3.New(-390, -331.9, -324)

				var_165_8.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1034, var_165_14, var_165_13)
			end

			if arg_162_1.time_ >= var_165_9 + var_165_12 and arg_162_1.time_ < var_165_9 + var_165_12 + arg_165_0 then
				var_165_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_165_15 = 0
			local var_165_16 = 0.15

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[1109].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(417041039)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 6
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041039", "story_v_out_417041.awb") ~= 0 then
					local var_165_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041039", "story_v_out_417041.awb") / 1000

					if var_165_23 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_23 + var_165_15
					end

					if var_165_18.prefab_name ~= "" and arg_162_1.actors_[var_165_18.prefab_name] ~= nil then
						local var_165_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_18.prefab_name].transform, "story_v_out_417041", "417041039", "story_v_out_417041.awb")

						arg_162_1:RecordAudio("417041039", var_165_24)
						arg_162_1:RecordAudio("417041039", var_165_24)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417041", "417041039", "story_v_out_417041.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417041", "417041039", "story_v_out_417041.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_25 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_25 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_25

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_25 and arg_162_1.time_ < var_165_15 + var_165_25 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play417041040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417041040
		arg_166_1.duration_ = 5.67

		local var_166_0 = {
			zh = 4.033,
			ja = 5.666
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417041041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10128"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10128 == nil then
				arg_166_1.var_.actorSpriteComps10128 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10128 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 1, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10128 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10128 = nil
			end

			local var_169_8 = arg_166_1.actors_["1034"]
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1034 == nil then
				arg_166_1.var_.actorSpriteComps1034 = var_169_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_10 = 0.2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 and not isNil(var_169_8) then
				local var_169_11 = (arg_166_1.time_ - var_169_9) / var_169_10

				if arg_166_1.var_.actorSpriteComps1034 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								local var_169_12 = Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor2.r, var_169_11)
								local var_169_13 = Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor2.g, var_169_11)
								local var_169_14 = Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor2.b, var_169_11)

								iter_169_5.color = Color.New(var_169_12, var_169_13, var_169_14)
							else
								local var_169_15 = Mathf.Lerp(iter_169_5.color.r, 0.5, var_169_11)

								iter_169_5.color = Color.New(var_169_15, var_169_15, var_169_15)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps1034 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_169_7 then
						if arg_166_1.isInRecall_ then
							iter_169_7.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1034 = nil
			end

			local var_169_16 = arg_166_1.actors_["10128"].transform
			local var_169_17 = 0

			if var_169_17 < arg_166_1.time_ and arg_166_1.time_ <= var_169_17 + arg_169_0 then
				arg_166_1.var_.moveOldPos10128 = var_169_16.localPosition
				var_169_16.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10128", 4)

				local var_169_18 = var_169_16.childCount

				for iter_169_8 = 0, var_169_18 - 1 do
					local var_169_19 = var_169_16:GetChild(iter_169_8)

					if var_169_19.name == "" or not string.find(var_169_19.name, "split") then
						var_169_19.gameObject:SetActive(true)
					else
						var_169_19.gameObject:SetActive(false)
					end
				end
			end

			local var_169_20 = 0.001

			if var_169_17 <= arg_166_1.time_ and arg_166_1.time_ < var_169_17 + var_169_20 then
				local var_169_21 = (arg_166_1.time_ - var_169_17) / var_169_20
				local var_169_22 = Vector3.New(390, -347, -300)

				var_169_16.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10128, var_169_22, var_169_21)
			end

			if arg_166_1.time_ >= var_169_17 + var_169_20 and arg_166_1.time_ < var_169_17 + var_169_20 + arg_169_0 then
				var_169_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_169_23 = 0
			local var_169_24 = 0.525

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_25 = arg_166_1:FormatText(StoryNameCfg[595].name)

				arg_166_1.leftNameTxt_.text = var_169_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_26 = arg_166_1:GetWordFromCfg(417041040)
				local var_169_27 = arg_166_1:FormatText(var_169_26.content)

				arg_166_1.text_.text = var_169_27

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_28 = 21
				local var_169_29 = utf8.len(var_169_27)
				local var_169_30 = var_169_28 <= 0 and var_169_24 or var_169_24 * (var_169_29 / var_169_28)

				if var_169_30 > 0 and var_169_24 < var_169_30 then
					arg_166_1.talkMaxDuration = var_169_30

					if var_169_30 + var_169_23 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_30 + var_169_23
					end
				end

				arg_166_1.text_.text = var_169_27
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041040", "story_v_out_417041.awb") ~= 0 then
					local var_169_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041040", "story_v_out_417041.awb") / 1000

					if var_169_31 + var_169_23 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_31 + var_169_23
					end

					if var_169_26.prefab_name ~= "" and arg_166_1.actors_[var_169_26.prefab_name] ~= nil then
						local var_169_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_26.prefab_name].transform, "story_v_out_417041", "417041040", "story_v_out_417041.awb")

						arg_166_1:RecordAudio("417041040", var_169_32)
						arg_166_1:RecordAudio("417041040", var_169_32)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417041", "417041040", "story_v_out_417041.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417041", "417041040", "story_v_out_417041.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_33 = math.max(var_169_24, arg_166_1.talkMaxDuration)

			if var_169_23 <= arg_166_1.time_ and arg_166_1.time_ < var_169_23 + var_169_33 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_23) / var_169_33

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_23 + var_169_33 and arg_166_1.time_ < var_169_23 + var_169_33 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play417041041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417041041
		arg_170_1.duration_ = 14

		local var_170_0 = {
			zh = 11.7,
			ja = 14
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
				arg_170_0:Play417041042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.475

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[595].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(417041041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 59
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041041", "story_v_out_417041.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041041", "story_v_out_417041.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_417041", "417041041", "story_v_out_417041.awb")

						arg_170_1:RecordAudio("417041041", var_173_9)
						arg_170_1:RecordAudio("417041041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417041", "417041041", "story_v_out_417041.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417041", "417041041", "story_v_out_417041.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417041042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417041042
		arg_174_1.duration_ = 3.03

		local var_174_0 = {
			zh = 2.4,
			ja = 3.033
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417041043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1034"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1034 == nil then
				arg_174_1.var_.actorSpriteComps1034 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps1034 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 1, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1034 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1034 = nil
			end

			local var_177_8 = arg_174_1.actors_["10128"]
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10128 == nil then
				arg_174_1.var_.actorSpriteComps10128 = var_177_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_10 = 0.2

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_10 and not isNil(var_177_8) then
				local var_177_11 = (arg_174_1.time_ - var_177_9) / var_177_10

				if arg_174_1.var_.actorSpriteComps10128 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								local var_177_12 = Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, var_177_11)
								local var_177_13 = Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, var_177_11)
								local var_177_14 = Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, var_177_11)

								iter_177_5.color = Color.New(var_177_12, var_177_13, var_177_14)
							else
								local var_177_15 = Mathf.Lerp(iter_177_5.color.r, 0.5, var_177_11)

								iter_177_5.color = Color.New(var_177_15, var_177_15, var_177_15)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_9 + var_177_10 and arg_174_1.time_ < var_177_9 + var_177_10 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10128 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_177_7 then
						if arg_174_1.isInRecall_ then
							iter_177_7.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_16 = arg_174_1.actors_["1034"].transform
			local var_177_17 = 0

			if var_177_17 < arg_174_1.time_ and arg_174_1.time_ <= var_177_17 + arg_177_0 then
				arg_174_1.var_.moveOldPos1034 = var_177_16.localPosition
				var_177_16.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1034", 2)

				local var_177_18 = var_177_16.childCount

				for iter_177_8 = 0, var_177_18 - 1 do
					local var_177_19 = var_177_16:GetChild(iter_177_8)

					if var_177_19.name == "split_6" or not string.find(var_177_19.name, "split") then
						var_177_19.gameObject:SetActive(true)
					else
						var_177_19.gameObject:SetActive(false)
					end
				end
			end

			local var_177_20 = 0.001

			if var_177_17 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_20 then
				local var_177_21 = (arg_174_1.time_ - var_177_17) / var_177_20
				local var_177_22 = Vector3.New(-390, -331.9, -324)

				var_177_16.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1034, var_177_22, var_177_21)
			end

			if arg_174_1.time_ >= var_177_17 + var_177_20 and arg_174_1.time_ < var_177_17 + var_177_20 + arg_177_0 then
				var_177_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_177_23 = 0
			local var_177_24 = 0.225

			if var_177_23 < arg_174_1.time_ and arg_174_1.time_ <= var_177_23 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_25 = arg_174_1:FormatText(StoryNameCfg[1109].name)

				arg_174_1.leftNameTxt_.text = var_177_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_26 = arg_174_1:GetWordFromCfg(417041042)
				local var_177_27 = arg_174_1:FormatText(var_177_26.content)

				arg_174_1.text_.text = var_177_27

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_28 = 9
				local var_177_29 = utf8.len(var_177_27)
				local var_177_30 = var_177_28 <= 0 and var_177_24 or var_177_24 * (var_177_29 / var_177_28)

				if var_177_30 > 0 and var_177_24 < var_177_30 then
					arg_174_1.talkMaxDuration = var_177_30

					if var_177_30 + var_177_23 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_30 + var_177_23
					end
				end

				arg_174_1.text_.text = var_177_27
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041042", "story_v_out_417041.awb") ~= 0 then
					local var_177_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041042", "story_v_out_417041.awb") / 1000

					if var_177_31 + var_177_23 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_31 + var_177_23
					end

					if var_177_26.prefab_name ~= "" and arg_174_1.actors_[var_177_26.prefab_name] ~= nil then
						local var_177_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_26.prefab_name].transform, "story_v_out_417041", "417041042", "story_v_out_417041.awb")

						arg_174_1:RecordAudio("417041042", var_177_32)
						arg_174_1:RecordAudio("417041042", var_177_32)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417041", "417041042", "story_v_out_417041.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417041", "417041042", "story_v_out_417041.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_33 = math.max(var_177_24, arg_174_1.talkMaxDuration)

			if var_177_23 <= arg_174_1.time_ and arg_174_1.time_ < var_177_23 + var_177_33 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_23) / var_177_33

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_23 + var_177_33 and arg_174_1.time_ < var_177_23 + var_177_33 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play417041043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417041043
		arg_178_1.duration_ = 12.13

		local var_178_0 = {
			zh = 12.133,
			ja = 11.5
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
				arg_178_0:Play417041044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["10128"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10128 == nil then
				arg_178_1.var_.actorSpriteComps10128 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps10128 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps10128 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10128 = nil
			end

			local var_181_8 = arg_178_1.actors_["1034"]
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.actorSpriteComps1034 == nil then
				arg_178_1.var_.actorSpriteComps1034 = var_181_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_10 = 0.2

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_10 and not isNil(var_181_8) then
				local var_181_11 = (arg_178_1.time_ - var_181_9) / var_181_10

				if arg_178_1.var_.actorSpriteComps1034 then
					for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_181_5 then
							if arg_178_1.isInRecall_ then
								local var_181_12 = Mathf.Lerp(iter_181_5.color.r, arg_178_1.hightColor2.r, var_181_11)
								local var_181_13 = Mathf.Lerp(iter_181_5.color.g, arg_178_1.hightColor2.g, var_181_11)
								local var_181_14 = Mathf.Lerp(iter_181_5.color.b, arg_178_1.hightColor2.b, var_181_11)

								iter_181_5.color = Color.New(var_181_12, var_181_13, var_181_14)
							else
								local var_181_15 = Mathf.Lerp(iter_181_5.color.r, 0.5, var_181_11)

								iter_181_5.color = Color.New(var_181_15, var_181_15, var_181_15)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_9 + var_181_10 and arg_178_1.time_ < var_181_9 + var_181_10 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.actorSpriteComps1034 then
				for iter_181_6, iter_181_7 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_181_7 then
						if arg_178_1.isInRecall_ then
							iter_181_7.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps1034 = nil
			end

			local var_181_16 = 0
			local var_181_17 = 1.425

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_18 = arg_178_1:FormatText(StoryNameCfg[595].name)

				arg_178_1.leftNameTxt_.text = var_181_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_19 = arg_178_1:GetWordFromCfg(417041043)
				local var_181_20 = arg_178_1:FormatText(var_181_19.content)

				arg_178_1.text_.text = var_181_20

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_21 = 57
				local var_181_22 = utf8.len(var_181_20)
				local var_181_23 = var_181_21 <= 0 and var_181_17 or var_181_17 * (var_181_22 / var_181_21)

				if var_181_23 > 0 and var_181_17 < var_181_23 then
					arg_178_1.talkMaxDuration = var_181_23

					if var_181_23 + var_181_16 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_16
					end
				end

				arg_178_1.text_.text = var_181_20
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041043", "story_v_out_417041.awb") ~= 0 then
					local var_181_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041043", "story_v_out_417041.awb") / 1000

					if var_181_24 + var_181_16 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_24 + var_181_16
					end

					if var_181_19.prefab_name ~= "" and arg_178_1.actors_[var_181_19.prefab_name] ~= nil then
						local var_181_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_19.prefab_name].transform, "story_v_out_417041", "417041043", "story_v_out_417041.awb")

						arg_178_1:RecordAudio("417041043", var_181_25)
						arg_178_1:RecordAudio("417041043", var_181_25)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417041", "417041043", "story_v_out_417041.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417041", "417041043", "story_v_out_417041.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_26 = math.max(var_181_17, arg_178_1.talkMaxDuration)

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_26 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_16) / var_181_26

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_16 + var_181_26 and arg_178_1.time_ < var_181_16 + var_181_26 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play417041044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417041044
		arg_182_1.duration_ = 7.57

		local var_182_0 = {
			zh = 4.833,
			ja = 7.566
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
				arg_182_0:Play417041045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10128"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10128 = var_185_0.localPosition
				var_185_0.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10128", 4)

				local var_185_2 = var_185_0.childCount

				for iter_185_0 = 0, var_185_2 - 1 do
					local var_185_3 = var_185_0:GetChild(iter_185_0)

					if var_185_3.name == "split_2" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_4 then
				local var_185_5 = (arg_182_1.time_ - var_185_1) / var_185_4
				local var_185_6 = Vector3.New(390, -347, -300)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10128, var_185_6, var_185_5)
			end

			if arg_182_1.time_ >= var_185_1 + var_185_4 and arg_182_1.time_ < var_185_1 + var_185_4 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(390, -347, -300)
			end

			local var_185_7 = 0
			local var_185_8 = 0.575

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_9 = arg_182_1:FormatText(StoryNameCfg[595].name)

				arg_182_1.leftNameTxt_.text = var_185_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(417041044)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_12 = 23
				local var_185_13 = utf8.len(var_185_11)
				local var_185_14 = var_185_12 <= 0 and var_185_8 or var_185_8 * (var_185_13 / var_185_12)

				if var_185_14 > 0 and var_185_8 < var_185_14 then
					arg_182_1.talkMaxDuration = var_185_14

					if var_185_14 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_7
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041044", "story_v_out_417041.awb") ~= 0 then
					local var_185_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041044", "story_v_out_417041.awb") / 1000

					if var_185_15 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_15 + var_185_7
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_out_417041", "417041044", "story_v_out_417041.awb")

						arg_182_1:RecordAudio("417041044", var_185_16)
						arg_182_1:RecordAudio("417041044", var_185_16)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417041", "417041044", "story_v_out_417041.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417041", "417041044", "story_v_out_417041.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_17 = math.max(var_185_8, arg_182_1.talkMaxDuration)

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_17 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_7) / var_185_17

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_7 + var_185_17 and arg_182_1.time_ < var_185_7 + var_185_17 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play417041045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417041045
		arg_186_1.duration_ = 2.5

		local var_186_0 = {
			zh = 2.5,
			ja = 2.333
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
				arg_186_0:Play417041046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10128"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10128 == nil then
				arg_186_1.var_.actorSpriteComps10128 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10128 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 0.5, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10128 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10128 = nil
			end

			local var_189_8 = arg_186_1.actors_["1034"].transform
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.var_.moveOldPos1034 = var_189_8.localPosition
				var_189_8.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1034", 7)

				local var_189_10 = var_189_8.childCount

				for iter_189_4 = 0, var_189_10 - 1 do
					local var_189_11 = var_189_8:GetChild(iter_189_4)

					if var_189_11.name == "split_7" or not string.find(var_189_11.name, "split") then
						var_189_11.gameObject:SetActive(true)
					else
						var_189_11.gameObject:SetActive(false)
					end
				end
			end

			local var_189_12 = 0.001

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_12 then
				local var_189_13 = (arg_186_1.time_ - var_189_9) / var_189_12
				local var_189_14 = Vector3.New(0, -2000, 0)

				var_189_8.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1034, var_189_14, var_189_13)
			end

			if arg_186_1.time_ >= var_189_9 + var_189_12 and arg_186_1.time_ < var_189_9 + var_189_12 + arg_189_0 then
				var_189_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_189_15 = arg_186_1.actors_["10128"].transform
			local var_189_16 = 0

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.var_.moveOldPos10128 = var_189_15.localPosition
				var_189_15.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10128", 7)

				local var_189_17 = var_189_15.childCount

				for iter_189_5 = 0, var_189_17 - 1 do
					local var_189_18 = var_189_15:GetChild(iter_189_5)

					if var_189_18.name == "split_2" or not string.find(var_189_18.name, "split") then
						var_189_18.gameObject:SetActive(true)
					else
						var_189_18.gameObject:SetActive(false)
					end
				end
			end

			local var_189_19 = 0.001

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_19 then
				local var_189_20 = (arg_186_1.time_ - var_189_16) / var_189_19
				local var_189_21 = Vector3.New(0, -2000, -300)

				var_189_15.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10128, var_189_21, var_189_20)
			end

			if arg_186_1.time_ >= var_189_16 + var_189_19 and arg_186_1.time_ < var_189_16 + var_189_19 + arg_189_0 then
				var_189_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_189_22 = 0
			local var_189_23 = 0.25

			if var_189_22 < arg_186_1.time_ and arg_186_1.time_ <= var_189_22 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_24 = arg_186_1:FormatText(StoryNameCfg[1120].name)

				arg_186_1.leftNameTxt_.text = var_189_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_25 = arg_186_1:GetWordFromCfg(417041045)
				local var_189_26 = arg_186_1:FormatText(var_189_25.content)

				arg_186_1.text_.text = var_189_26

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_27 = 10
				local var_189_28 = utf8.len(var_189_26)
				local var_189_29 = var_189_27 <= 0 and var_189_23 or var_189_23 * (var_189_28 / var_189_27)

				if var_189_29 > 0 and var_189_23 < var_189_29 then
					arg_186_1.talkMaxDuration = var_189_29

					if var_189_29 + var_189_22 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_29 + var_189_22
					end
				end

				arg_186_1.text_.text = var_189_26
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041045", "story_v_out_417041.awb") ~= 0 then
					local var_189_30 = manager.audio:GetVoiceLength("story_v_out_417041", "417041045", "story_v_out_417041.awb") / 1000

					if var_189_30 + var_189_22 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_30 + var_189_22
					end

					if var_189_25.prefab_name ~= "" and arg_186_1.actors_[var_189_25.prefab_name] ~= nil then
						local var_189_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_25.prefab_name].transform, "story_v_out_417041", "417041045", "story_v_out_417041.awb")

						arg_186_1:RecordAudio("417041045", var_189_31)
						arg_186_1:RecordAudio("417041045", var_189_31)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417041", "417041045", "story_v_out_417041.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417041", "417041045", "story_v_out_417041.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_32 = math.max(var_189_23, arg_186_1.talkMaxDuration)

			if var_189_22 <= arg_186_1.time_ and arg_186_1.time_ < var_189_22 + var_189_32 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_22) / var_189_32

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_22 + var_189_32 and arg_186_1.time_ < var_189_22 + var_189_32 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play417041046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417041046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417041047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 1.45

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(417041046)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 58
				local var_193_5 = utf8.len(var_193_3)
				local var_193_6 = var_193_4 <= 0 and var_193_1 or var_193_1 * (var_193_5 / var_193_4)

				if var_193_6 > 0 and var_193_1 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_7 and arg_190_1.time_ < var_193_0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417041047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417041047
		arg_194_1.duration_ = 5.33

		local var_194_0 = {
			zh = 2.533,
			ja = 5.333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417041048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1034"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 == nil then
				arg_194_1.var_.actorSpriteComps1034 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps1034 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 1, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps1034 = nil
			end

			local var_197_8 = arg_194_1.actors_["1034"].transform
			local var_197_9 = 0

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034 = var_197_8.localPosition
				var_197_8.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1034", 2)

				local var_197_10 = var_197_8.childCount

				for iter_197_4 = 0, var_197_10 - 1 do
					local var_197_11 = var_197_8:GetChild(iter_197_4)

					if var_197_11.name == "split_7" or not string.find(var_197_11.name, "split") then
						var_197_11.gameObject:SetActive(true)
					else
						var_197_11.gameObject:SetActive(false)
					end
				end
			end

			local var_197_12 = 0.001

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_12 then
				local var_197_13 = (arg_194_1.time_ - var_197_9) / var_197_12
				local var_197_14 = Vector3.New(-390, -331.9, -324)

				var_197_8.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034, var_197_14, var_197_13)
			end

			if arg_194_1.time_ >= var_197_9 + var_197_12 and arg_194_1.time_ < var_197_9 + var_197_12 + arg_197_0 then
				var_197_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_197_15 = 0
			local var_197_16 = 0.35

			if var_197_15 < arg_194_1.time_ and arg_194_1.time_ <= var_197_15 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_17 = arg_194_1:FormatText(StoryNameCfg[1109].name)

				arg_194_1.leftNameTxt_.text = var_197_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_18 = arg_194_1:GetWordFromCfg(417041047)
				local var_197_19 = arg_194_1:FormatText(var_197_18.content)

				arg_194_1.text_.text = var_197_19

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_20 = 14
				local var_197_21 = utf8.len(var_197_19)
				local var_197_22 = var_197_20 <= 0 and var_197_16 or var_197_16 * (var_197_21 / var_197_20)

				if var_197_22 > 0 and var_197_16 < var_197_22 then
					arg_194_1.talkMaxDuration = var_197_22

					if var_197_22 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_22 + var_197_15
					end
				end

				arg_194_1.text_.text = var_197_19
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041047", "story_v_out_417041.awb") ~= 0 then
					local var_197_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041047", "story_v_out_417041.awb") / 1000

					if var_197_23 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_23 + var_197_15
					end

					if var_197_18.prefab_name ~= "" and arg_194_1.actors_[var_197_18.prefab_name] ~= nil then
						local var_197_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_18.prefab_name].transform, "story_v_out_417041", "417041047", "story_v_out_417041.awb")

						arg_194_1:RecordAudio("417041047", var_197_24)
						arg_194_1:RecordAudio("417041047", var_197_24)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417041", "417041047", "story_v_out_417041.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417041", "417041047", "story_v_out_417041.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_25 = math.max(var_197_16, arg_194_1.talkMaxDuration)

			if var_197_15 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_25 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_25

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_25 and arg_194_1.time_ < var_197_15 + var_197_25 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play417041048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417041048
		arg_198_1.duration_ = 9.83

		local var_198_0 = {
			zh = 8.3,
			ja = 9.833
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417041049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10128"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10128 == nil then
				arg_198_1.var_.actorSpriteComps10128 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps10128 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 1, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10128 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10128 = nil
			end

			local var_201_8 = arg_198_1.actors_["1034"]
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = var_201_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_10 = 0.2

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 and not isNil(var_201_8) then
				local var_201_11 = (arg_198_1.time_ - var_201_9) / var_201_10

				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								local var_201_12 = Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, var_201_11)
								local var_201_13 = Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, var_201_11)
								local var_201_14 = Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, var_201_11)

								iter_201_5.color = Color.New(var_201_12, var_201_13, var_201_14)
							else
								local var_201_15 = Mathf.Lerp(iter_201_5.color.r, 0.5, var_201_11)

								iter_201_5.color = Color.New(var_201_15, var_201_15, var_201_15)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_7 then
						if arg_198_1.isInRecall_ then
							iter_201_7.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_16 = arg_198_1.actors_["10128"].transform
			local var_201_17 = 0

			if var_201_17 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.var_.moveOldPos10128 = var_201_16.localPosition
				var_201_16.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10128", 4)

				local var_201_18 = var_201_16.childCount

				for iter_201_8 = 0, var_201_18 - 1 do
					local var_201_19 = var_201_16:GetChild(iter_201_8)

					if var_201_19.name == "split_2" or not string.find(var_201_19.name, "split") then
						var_201_19.gameObject:SetActive(true)
					else
						var_201_19.gameObject:SetActive(false)
					end
				end
			end

			local var_201_20 = 0.001

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_20 then
				local var_201_21 = (arg_198_1.time_ - var_201_17) / var_201_20
				local var_201_22 = Vector3.New(390, -347, -300)

				var_201_16.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10128, var_201_22, var_201_21)
			end

			if arg_198_1.time_ >= var_201_17 + var_201_20 and arg_198_1.time_ < var_201_17 + var_201_20 + arg_201_0 then
				var_201_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_201_23 = 0
			local var_201_24 = 0.975

			if var_201_23 < arg_198_1.time_ and arg_198_1.time_ <= var_201_23 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_25 = arg_198_1:FormatText(StoryNameCfg[595].name)

				arg_198_1.leftNameTxt_.text = var_201_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_26 = arg_198_1:GetWordFromCfg(417041048)
				local var_201_27 = arg_198_1:FormatText(var_201_26.content)

				arg_198_1.text_.text = var_201_27

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_28 = 39
				local var_201_29 = utf8.len(var_201_27)
				local var_201_30 = var_201_28 <= 0 and var_201_24 or var_201_24 * (var_201_29 / var_201_28)

				if var_201_30 > 0 and var_201_24 < var_201_30 then
					arg_198_1.talkMaxDuration = var_201_30

					if var_201_30 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_30 + var_201_23
					end
				end

				arg_198_1.text_.text = var_201_27
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041048", "story_v_out_417041.awb") ~= 0 then
					local var_201_31 = manager.audio:GetVoiceLength("story_v_out_417041", "417041048", "story_v_out_417041.awb") / 1000

					if var_201_31 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_31 + var_201_23
					end

					if var_201_26.prefab_name ~= "" and arg_198_1.actors_[var_201_26.prefab_name] ~= nil then
						local var_201_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_26.prefab_name].transform, "story_v_out_417041", "417041048", "story_v_out_417041.awb")

						arg_198_1:RecordAudio("417041048", var_201_32)
						arg_198_1:RecordAudio("417041048", var_201_32)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417041", "417041048", "story_v_out_417041.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417041", "417041048", "story_v_out_417041.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_33 = math.max(var_201_24, arg_198_1.talkMaxDuration)

			if var_201_23 <= arg_198_1.time_ and arg_198_1.time_ < var_201_23 + var_201_33 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_23) / var_201_33

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_23 + var_201_33 and arg_198_1.time_ < var_201_23 + var_201_33 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play417041049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417041049
		arg_202_1.duration_ = 3.5

		local var_202_0 = {
			zh = 3.266,
			ja = 3.5
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
				arg_202_0:Play417041050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10128"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10128 == nil then
				arg_202_1.var_.actorSpriteComps10128 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps10128 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor2.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor2.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor2.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 0.5, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10128 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10128 = nil
			end

			local var_205_8 = 0
			local var_205_9 = 0.35

			if var_205_8 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_10 = arg_202_1:FormatText(StoryNameCfg[1120].name)

				arg_202_1.leftNameTxt_.text = var_205_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_11 = arg_202_1:GetWordFromCfg(417041049)
				local var_205_12 = arg_202_1:FormatText(var_205_11.content)

				arg_202_1.text_.text = var_205_12

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 14
				local var_205_14 = utf8.len(var_205_12)
				local var_205_15 = var_205_13 <= 0 and var_205_9 or var_205_9 * (var_205_14 / var_205_13)

				if var_205_15 > 0 and var_205_9 < var_205_15 then
					arg_202_1.talkMaxDuration = var_205_15

					if var_205_15 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_15 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_12
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041049", "story_v_out_417041.awb") ~= 0 then
					local var_205_16 = manager.audio:GetVoiceLength("story_v_out_417041", "417041049", "story_v_out_417041.awb") / 1000

					if var_205_16 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_16 + var_205_8
					end

					if var_205_11.prefab_name ~= "" and arg_202_1.actors_[var_205_11.prefab_name] ~= nil then
						local var_205_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_11.prefab_name].transform, "story_v_out_417041", "417041049", "story_v_out_417041.awb")

						arg_202_1:RecordAudio("417041049", var_205_17)
						arg_202_1:RecordAudio("417041049", var_205_17)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417041", "417041049", "story_v_out_417041.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417041", "417041049", "story_v_out_417041.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_18 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_18 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_18

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_18 and arg_202_1.time_ < var_205_8 + var_205_18 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417041050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417041050
		arg_206_1.duration_ = 6.2

		local var_206_0 = {
			zh = 2.2,
			ja = 6.2
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
				arg_206_0:Play417041051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1034"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_8 = arg_206_1.actors_["1034"].transform
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 2)

				local var_209_10 = var_209_8.childCount

				for iter_209_4 = 0, var_209_10 - 1 do
					local var_209_11 = var_209_8:GetChild(iter_209_4)

					if var_209_11.name == "split_4" or not string.find(var_209_11.name, "split") then
						var_209_11.gameObject:SetActive(true)
					else
						var_209_11.gameObject:SetActive(false)
					end
				end
			end

			local var_209_12 = 0.001

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_12 then
				local var_209_13 = (arg_206_1.time_ - var_209_9) / var_209_12
				local var_209_14 = Vector3.New(-390, -331.9, -324)

				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, var_209_14, var_209_13)
			end

			if arg_206_1.time_ >= var_209_9 + var_209_12 and arg_206_1.time_ < var_209_9 + var_209_12 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_209_15 = 0
			local var_209_16 = 0.3

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1109].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(417041050)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 12
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041050", "story_v_out_417041.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041050", "story_v_out_417041.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_417041", "417041050", "story_v_out_417041.awb")

						arg_206_1:RecordAudio("417041050", var_209_24)
						arg_206_1:RecordAudio("417041050", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417041", "417041050", "story_v_out_417041.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417041", "417041050", "story_v_out_417041.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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
	Play417041051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417041051
		arg_210_1.duration_ = 5.4

		local var_210_0 = {
			zh = 5.4,
			ja = 4.7
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
				arg_210_0:Play417041052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10128"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10128 == nil then
				arg_210_1.var_.actorSpriteComps10128 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10128 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10128 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10128 = nil
			end

			local var_213_8 = arg_210_1.actors_["1034"]
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = var_213_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_10 = 0.2

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_10 and not isNil(var_213_8) then
				local var_213_11 = (arg_210_1.time_ - var_213_9) / var_213_10

				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_210_1.time_ >= var_213_9 + var_213_10 and arg_210_1.time_ < var_213_9 + var_213_10 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_7 then
						if arg_210_1.isInRecall_ then
							iter_213_7.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_16 = 0
			local var_213_17 = 0.625

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_18 = arg_210_1:FormatText(StoryNameCfg[595].name)

				arg_210_1.leftNameTxt_.text = var_213_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_19 = arg_210_1:GetWordFromCfg(417041051)
				local var_213_20 = arg_210_1:FormatText(var_213_19.content)

				arg_210_1.text_.text = var_213_20

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_21 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041051", "story_v_out_417041.awb") ~= 0 then
					local var_213_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041051", "story_v_out_417041.awb") / 1000

					if var_213_24 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_24 + var_213_16
					end

					if var_213_19.prefab_name ~= "" and arg_210_1.actors_[var_213_19.prefab_name] ~= nil then
						local var_213_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_19.prefab_name].transform, "story_v_out_417041", "417041051", "story_v_out_417041.awb")

						arg_210_1:RecordAudio("417041051", var_213_25)
						arg_210_1:RecordAudio("417041051", var_213_25)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417041", "417041051", "story_v_out_417041.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417041", "417041051", "story_v_out_417041.awb")
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
	Play417041052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417041052
		arg_214_1.duration_ = 10.33

		local var_214_0 = {
			zh = 6.533,
			ja = 10.333
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
				arg_214_0:Play417041053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.825

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[595].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(417041052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 33
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041052", "story_v_out_417041.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041052", "story_v_out_417041.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_417041", "417041052", "story_v_out_417041.awb")

						arg_214_1:RecordAudio("417041052", var_217_9)
						arg_214_1:RecordAudio("417041052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417041", "417041052", "story_v_out_417041.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417041", "417041052", "story_v_out_417041.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417041053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417041053
		arg_218_1.duration_ = 3.6

		local var_218_0 = {
			zh = 2.833,
			ja = 3.6
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
				arg_218_0:Play417041054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10128"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10128 == nil then
				arg_218_1.var_.actorSpriteComps10128 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps10128 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor2.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor2.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor2.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 0.5, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10128 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10128 = nil
			end

			local var_221_8 = 0.325
			local var_221_9 = 1

			if var_221_8 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				local var_221_10 = "play"
				local var_221_11 = "effect"

				arg_218_1:AudioAction(var_221_10, var_221_11, "se_story_1310", "se_story_1310_gun_load", "")
			end

			local var_221_12 = 0
			local var_221_13 = 0.325

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_14 = arg_218_1:FormatText(StoryNameCfg[1120].name)

				arg_218_1.leftNameTxt_.text = var_221_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_15 = arg_218_1:GetWordFromCfg(417041053)
				local var_221_16 = arg_218_1:FormatText(var_221_15.content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 13
				local var_221_18 = utf8.len(var_221_16)
				local var_221_19 = var_221_17 <= 0 and var_221_13 or var_221_13 * (var_221_18 / var_221_17)

				if var_221_19 > 0 and var_221_13 < var_221_19 then
					arg_218_1.talkMaxDuration = var_221_19

					if var_221_19 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_19 + var_221_12
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041053", "story_v_out_417041.awb") ~= 0 then
					local var_221_20 = manager.audio:GetVoiceLength("story_v_out_417041", "417041053", "story_v_out_417041.awb") / 1000

					if var_221_20 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_20 + var_221_12
					end

					if var_221_15.prefab_name ~= "" and arg_218_1.actors_[var_221_15.prefab_name] ~= nil then
						local var_221_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_15.prefab_name].transform, "story_v_out_417041", "417041053", "story_v_out_417041.awb")

						arg_218_1:RecordAudio("417041053", var_221_21)
						arg_218_1:RecordAudio("417041053", var_221_21)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417041", "417041053", "story_v_out_417041.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417041", "417041053", "story_v_out_417041.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_13, arg_218_1.talkMaxDuration)

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_12) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_12 + var_221_22 and arg_218_1.time_ < var_221_12 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417041054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417041054
		arg_222_1.duration_ = 5.5

		local var_222_0 = {
			zh = 2.333,
			ja = 5.5
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
				arg_222_0:Play417041055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1034"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1034 == nil then
				arg_222_1.var_.actorSpriteComps1034 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1034 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1034 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1034 = nil
			end

			local var_225_8 = arg_222_1.actors_["1034"].transform
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.var_.moveOldPos1034 = var_225_8.localPosition
				var_225_8.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1034", 2)

				local var_225_10 = var_225_8.childCount

				for iter_225_4 = 0, var_225_10 - 1 do
					local var_225_11 = var_225_8:GetChild(iter_225_4)

					if var_225_11.name == "split_6" or not string.find(var_225_11.name, "split") then
						var_225_11.gameObject:SetActive(true)
					else
						var_225_11.gameObject:SetActive(false)
					end
				end
			end

			local var_225_12 = 0.001

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_12 then
				local var_225_13 = (arg_222_1.time_ - var_225_9) / var_225_12
				local var_225_14 = Vector3.New(-390, -331.9, -324)

				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1034, var_225_14, var_225_13)
			end

			if arg_222_1.time_ >= var_225_9 + var_225_12 and arg_222_1.time_ < var_225_9 + var_225_12 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_225_15 = 0
			local var_225_16 = 0.325

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_17 = arg_222_1:FormatText(StoryNameCfg[1109].name)

				arg_222_1.leftNameTxt_.text = var_225_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(417041054)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_20 = 13
				local var_225_21 = utf8.len(var_225_19)
				local var_225_22 = var_225_20 <= 0 and var_225_16 or var_225_16 * (var_225_21 / var_225_20)

				if var_225_22 > 0 and var_225_16 < var_225_22 then
					arg_222_1.talkMaxDuration = var_225_22

					if var_225_22 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041054", "story_v_out_417041.awb") ~= 0 then
					local var_225_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041054", "story_v_out_417041.awb") / 1000

					if var_225_23 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_15
					end

					if var_225_18.prefab_name ~= "" and arg_222_1.actors_[var_225_18.prefab_name] ~= nil then
						local var_225_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_18.prefab_name].transform, "story_v_out_417041", "417041054", "story_v_out_417041.awb")

						arg_222_1:RecordAudio("417041054", var_225_24)
						arg_222_1:RecordAudio("417041054", var_225_24)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417041", "417041054", "story_v_out_417041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417041", "417041054", "story_v_out_417041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_25 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_25 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_25

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_25 and arg_222_1.time_ < var_225_15 + var_225_25 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play417041055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417041055
		arg_226_1.duration_ = 5.5

		local var_226_0 = {
			zh = 4.133,
			ja = 5.5
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
				arg_226_0:Play417041056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10128"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10128 == nil then
				arg_226_1.var_.actorSpriteComps10128 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps10128 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 1, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_8 = arg_226_1.actors_["1034"]
			local var_229_9 = 0

			if var_229_9 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps1034 == nil then
				arg_226_1.var_.actorSpriteComps1034 = var_229_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_10 = 0.2

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 and not isNil(var_229_8) then
				local var_229_11 = (arg_226_1.time_ - var_229_9) / var_229_10

				if arg_226_1.var_.actorSpriteComps1034 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								local var_229_12 = Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, var_229_11)
								local var_229_13 = Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, var_229_11)
								local var_229_14 = Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, var_229_11)

								iter_229_5.color = Color.New(var_229_12, var_229_13, var_229_14)
							else
								local var_229_15 = Mathf.Lerp(iter_229_5.color.r, 0.5, var_229_11)

								iter_229_5.color = Color.New(var_229_15, var_229_15, var_229_15)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps1034 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_229_7 then
						if arg_226_1.isInRecall_ then
							iter_229_7.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps1034 = nil
			end

			local var_229_16 = 0
			local var_229_17 = 0.5

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_18 = arg_226_1:FormatText(StoryNameCfg[595].name)

				arg_226_1.leftNameTxt_.text = var_229_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_19 = arg_226_1:GetWordFromCfg(417041055)
				local var_229_20 = arg_226_1:FormatText(var_229_19.content)

				arg_226_1.text_.text = var_229_20

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_21 = 20
				local var_229_22 = utf8.len(var_229_20)
				local var_229_23 = var_229_21 <= 0 and var_229_17 or var_229_17 * (var_229_22 / var_229_21)

				if var_229_23 > 0 and var_229_17 < var_229_23 then
					arg_226_1.talkMaxDuration = var_229_23

					if var_229_23 + var_229_16 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_16
					end
				end

				arg_226_1.text_.text = var_229_20
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041055", "story_v_out_417041.awb") ~= 0 then
					local var_229_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041055", "story_v_out_417041.awb") / 1000

					if var_229_24 + var_229_16 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_24 + var_229_16
					end

					if var_229_19.prefab_name ~= "" and arg_226_1.actors_[var_229_19.prefab_name] ~= nil then
						local var_229_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_19.prefab_name].transform, "story_v_out_417041", "417041055", "story_v_out_417041.awb")

						arg_226_1:RecordAudio("417041055", var_229_25)
						arg_226_1:RecordAudio("417041055", var_229_25)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417041", "417041055", "story_v_out_417041.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417041", "417041055", "story_v_out_417041.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_26 = math.max(var_229_17, arg_226_1.talkMaxDuration)

			if var_229_16 <= arg_226_1.time_ and arg_226_1.time_ < var_229_16 + var_229_26 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_16) / var_229_26

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_16 + var_229_26 and arg_226_1.time_ < var_229_16 + var_229_26 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417041056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417041056
		arg_230_1.duration_ = 5.77

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417041057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10128"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10128 == nil then
				arg_230_1.var_.actorSpriteComps10128 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps10128 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 0.5, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10128 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10128 = nil
			end

			local var_233_8 = arg_230_1.actors_["1034"].transform
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1.var_.moveOldPos1034 = var_233_8.localPosition
				var_233_8.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1034", 7)

				local var_233_10 = var_233_8.childCount

				for iter_233_4 = 0, var_233_10 - 1 do
					local var_233_11 = var_233_8:GetChild(iter_233_4)

					if var_233_11.name == "" or not string.find(var_233_11.name, "split") then
						var_233_11.gameObject:SetActive(true)
					else
						var_233_11.gameObject:SetActive(false)
					end
				end
			end

			local var_233_12 = 0.001

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_12 then
				local var_233_13 = (arg_230_1.time_ - var_233_9) / var_233_12
				local var_233_14 = Vector3.New(0, -2000, 0)

				var_233_8.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1034, var_233_14, var_233_13)
			end

			if arg_230_1.time_ >= var_233_9 + var_233_12 and arg_230_1.time_ < var_233_9 + var_233_12 + arg_233_0 then
				var_233_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_233_15 = arg_230_1.actors_["10128"].transform
			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.var_.moveOldPos10128 = var_233_15.localPosition
				var_233_15.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10128", 7)

				local var_233_17 = var_233_15.childCount

				for iter_233_5 = 0, var_233_17 - 1 do
					local var_233_18 = var_233_15:GetChild(iter_233_5)

					if var_233_18.name == "" or not string.find(var_233_18.name, "split") then
						var_233_18.gameObject:SetActive(true)
					else
						var_233_18.gameObject:SetActive(false)
					end
				end
			end

			local var_233_19 = 0.001

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_19 then
				local var_233_20 = (arg_230_1.time_ - var_233_16) / var_233_19
				local var_233_21 = Vector3.New(0, -2000, -300)

				var_233_15.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10128, var_233_21, var_233_20)
			end

			if arg_230_1.time_ >= var_233_16 + var_233_19 and arg_230_1.time_ < var_233_16 + var_233_19 + arg_233_0 then
				var_233_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_233_22 = manager.ui.mainCamera.transform
			local var_233_23 = 0

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				local var_233_24 = arg_230_1.var_.effect744
				local var_233_25
				local var_233_26 = var_233_22

				if not var_233_24 then
					var_233_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_233_26)
					var_233_24.name = "744"
					arg_230_1.var_.effect744 = var_233_24
				else
					var_233_24.transform:SetParent(var_233_26)
				end

				var_233_24.transform.localPosition = Vector3.New(0, -0.1, 0)
				var_233_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_233_27 = manager.ui.mainCameraCom_
				local var_233_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_233_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_233_29 = var_233_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_233_30 = 15
				local var_233_31 = 2 * var_233_30 * Mathf.Tan(var_233_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_233_27.aspect
				local var_233_32 = 1
				local var_233_33 = 1.7777777777777777

				if var_233_33 < var_233_27.aspect then
					var_233_32 = var_233_31 / (2 * var_233_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_233_33)
				end

				for iter_233_6, iter_233_7 in ipairs(var_233_29) do
					local var_233_34 = iter_233_7.transform.localScale

					iter_233_7.transform.localScale = Vector3.New(var_233_34.x / var_233_28 * var_233_32, var_233_34.y / var_233_28, var_233_34.z)
				end
			end

			local var_233_35 = manager.ui.mainCamera.transform
			local var_233_36 = 0.3

			if var_233_36 < arg_230_1.time_ and arg_230_1.time_ <= var_233_36 + arg_233_0 then
				local var_233_37 = arg_230_1.var_.effect744

				if var_233_37 then
					Object.Destroy(var_233_37)

					arg_230_1.var_.effect744 = nil
				end
			end

			local var_233_38 = manager.ui.mainCamera.transform
			local var_233_39 = 0.2

			if var_233_39 < arg_230_1.time_ and arg_230_1.time_ <= var_233_39 + arg_233_0 then
				local var_233_40 = arg_230_1.var_.effect498
				local var_233_41
				local var_233_42 = var_233_38

				if not var_233_40 then
					var_233_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_233_42)
					var_233_40.name = "498"
					arg_230_1.var_.effect498 = var_233_40
				else
					var_233_40.transform:SetParent(var_233_42)
				end

				var_233_40.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_233_40.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_233_43 = manager.ui.mainCameraCom_
				local var_233_44 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_233_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_233_45 = var_233_40.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_233_46 = 15
				local var_233_47 = 2 * var_233_46 * Mathf.Tan(var_233_43.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_233_43.aspect
				local var_233_48 = 1
				local var_233_49 = 1.7777777777777777

				if var_233_49 < var_233_43.aspect then
					var_233_48 = var_233_47 / (2 * var_233_46 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_233_49)
				end

				for iter_233_8, iter_233_9 in ipairs(var_233_45) do
					local var_233_50 = iter_233_9.transform.localScale

					iter_233_9.transform.localScale = Vector3.New(var_233_50.x / var_233_44 * var_233_48, var_233_50.y / var_233_44, var_233_50.z)
				end
			end

			local var_233_51 = 0.0333333333333333
			local var_233_52 = 1

			if var_233_51 < arg_230_1.time_ and arg_230_1.time_ <= var_233_51 + arg_233_0 then
				local var_233_53 = "play"
				local var_233_54 = "effect"

				arg_230_1:AudioAction(var_233_53, var_233_54, "se_story_1310", "se_story_1310_attact02", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_55 = 0.766666666666667
			local var_233_56 = 1.575

			if var_233_55 < arg_230_1.time_ and arg_230_1.time_ <= var_233_55 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_57 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_57:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_58 = arg_230_1:GetWordFromCfg(417041056)
				local var_233_59 = arg_230_1:FormatText(var_233_58.content)

				arg_230_1.text_.text = var_233_59

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_60 = 63
				local var_233_61 = utf8.len(var_233_59)
				local var_233_62 = var_233_60 <= 0 and var_233_56 or var_233_56 * (var_233_61 / var_233_60)

				if var_233_62 > 0 and var_233_56 < var_233_62 then
					arg_230_1.talkMaxDuration = var_233_62
					var_233_55 = var_233_55 + 0.3

					if var_233_62 + var_233_55 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_62 + var_233_55
					end
				end

				arg_230_1.text_.text = var_233_59
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_63 = var_233_55 + 0.3
			local var_233_64 = math.max(var_233_56, arg_230_1.talkMaxDuration)

			if var_233_63 <= arg_230_1.time_ and arg_230_1.time_ < var_233_63 + var_233_64 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_63) / var_233_64

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_63 + var_233_64 and arg_230_1.time_ < var_233_63 + var_233_64 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play417041057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417041057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417041058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = manager.ui.mainCamera.transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				local var_239_2 = arg_236_1.var_.effect498

				if var_239_2 then
					Object.Destroy(var_239_2)

					arg_236_1.var_.effect498 = nil
				end
			end

			local var_239_3 = 1.4
			local var_239_4 = 1

			if var_239_3 < arg_236_1.time_ and arg_236_1.time_ <= var_239_3 + arg_239_0 then
				local var_239_5 = "play"
				local var_239_6 = "effect"

				arg_236_1:AudioAction(var_239_5, var_239_6, "se_story_1310", "se_story_1310_hit02", "")
			end

			local var_239_7 = 0
			local var_239_8 = 1.675

			if var_239_7 < arg_236_1.time_ and arg_236_1.time_ <= var_239_7 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_9 = arg_236_1:GetWordFromCfg(417041057)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 67
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_8 or var_239_8 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_8 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_7 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_7
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_8, arg_236_1.talkMaxDuration)

			if var_239_7 <= arg_236_1.time_ and arg_236_1.time_ < var_239_7 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_7) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_7 + var_239_14 and arg_236_1.time_ < var_239_7 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417041058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417041058
		arg_240_1.duration_ = 5.68

		local var_240_0 = {
			zh = 4.75,
			ja = 5.683
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
				arg_240_0:Play417041059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = "D10"

			if arg_240_1.bgs_[var_243_0] == nil then
				local var_243_1 = Object.Instantiate(arg_240_1.paintGo_)

				var_243_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_243_0)
				var_243_1.name = var_243_0
				var_243_1.transform.parent = arg_240_1.stage_.transform
				var_243_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.bgs_[var_243_0] = var_243_1
			end

			local var_243_2 = 1.8

			if var_243_2 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				local var_243_3 = manager.ui.mainCamera.transform.localPosition
				local var_243_4 = Vector3.New(0, 0, 10) + Vector3.New(var_243_3.x, var_243_3.y, 0)
				local var_243_5 = arg_240_1.bgs_.D10

				var_243_5.transform.localPosition = var_243_4
				var_243_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_243_6 = var_243_5:GetComponent("SpriteRenderer")

				if var_243_6 and var_243_6.sprite then
					local var_243_7 = (var_243_5.transform.localPosition - var_243_3).z
					local var_243_8 = manager.ui.mainCameraCom_
					local var_243_9 = 2 * var_243_7 * Mathf.Tan(var_243_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_243_10 = var_243_9 * var_243_8.aspect
					local var_243_11 = var_243_6.sprite.bounds.size.x
					local var_243_12 = var_243_6.sprite.bounds.size.y
					local var_243_13 = var_243_10 / var_243_11
					local var_243_14 = var_243_9 / var_243_12
					local var_243_15 = var_243_14 < var_243_13 and var_243_13 or var_243_14

					var_243_5.transform.localScale = Vector3.New(var_243_15, var_243_15, 0)
				end

				for iter_243_0, iter_243_1 in pairs(arg_240_1.bgs_) do
					if iter_243_0 ~= "D10" then
						iter_243_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_243_16 = 0

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			local var_243_17 = 0.3

			if arg_240_1.time_ >= var_243_16 + var_243_17 and arg_240_1.time_ < var_243_16 + var_243_17 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			local var_243_18 = 0

			if var_243_18 < arg_240_1.time_ and arg_240_1.time_ <= var_243_18 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_19 = 1.8

			if var_243_18 <= arg_240_1.time_ and arg_240_1.time_ < var_243_18 + var_243_19 then
				local var_243_20 = (arg_240_1.time_ - var_243_18) / var_243_19
				local var_243_21 = Color.New(0, 0, 0)

				var_243_21.a = Mathf.Lerp(0, 1, var_243_20)
				arg_240_1.mask_.color = var_243_21
			end

			if arg_240_1.time_ >= var_243_18 + var_243_19 and arg_240_1.time_ < var_243_18 + var_243_19 + arg_243_0 then
				local var_243_22 = Color.New(0, 0, 0)

				var_243_22.a = 1
				arg_240_1.mask_.color = var_243_22
			end

			local var_243_23 = 1.8

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_24 = 1.8

			if var_243_23 <= arg_240_1.time_ and arg_240_1.time_ < var_243_23 + var_243_24 then
				local var_243_25 = (arg_240_1.time_ - var_243_23) / var_243_24
				local var_243_26 = Color.New(0, 0, 0)

				var_243_26.a = Mathf.Lerp(1, 0, var_243_25)
				arg_240_1.mask_.color = var_243_26
			end

			if arg_240_1.time_ >= var_243_23 + var_243_24 and arg_240_1.time_ < var_243_23 + var_243_24 + arg_243_0 then
				local var_243_27 = Color.New(0, 0, 0)
				local var_243_28 = 0

				arg_240_1.mask_.enabled = false
				var_243_27.a = var_243_28
				arg_240_1.mask_.color = var_243_27
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_29 = 3.45
			local var_243_30 = 0.15

			if var_243_29 < arg_240_1.time_ and arg_240_1.time_ <= var_243_29 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_31 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_31:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_32 = arg_240_1:FormatText(StoryNameCfg[1109].name)

				arg_240_1.leftNameTxt_.text = var_243_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_33 = arg_240_1:GetWordFromCfg(417041058)
				local var_243_34 = arg_240_1:FormatText(var_243_33.content)

				arg_240_1.text_.text = var_243_34

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_35 = 6
				local var_243_36 = utf8.len(var_243_34)
				local var_243_37 = var_243_35 <= 0 and var_243_30 or var_243_30 * (var_243_36 / var_243_35)

				if var_243_37 > 0 and var_243_30 < var_243_37 then
					arg_240_1.talkMaxDuration = var_243_37
					var_243_29 = var_243_29 + 0.3

					if var_243_37 + var_243_29 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_37 + var_243_29
					end
				end

				arg_240_1.text_.text = var_243_34
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041058", "story_v_out_417041.awb") ~= 0 then
					local var_243_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041058", "story_v_out_417041.awb") / 1000

					if var_243_38 + var_243_29 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_38 + var_243_29
					end

					if var_243_33.prefab_name ~= "" and arg_240_1.actors_[var_243_33.prefab_name] ~= nil then
						local var_243_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_33.prefab_name].transform, "story_v_out_417041", "417041058", "story_v_out_417041.awb")

						arg_240_1:RecordAudio("417041058", var_243_39)
						arg_240_1:RecordAudio("417041058", var_243_39)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417041", "417041058", "story_v_out_417041.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417041", "417041058", "story_v_out_417041.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_40 = var_243_29 + 0.3
			local var_243_41 = math.max(var_243_30, arg_240_1.talkMaxDuration)

			if var_243_40 <= arg_240_1.time_ and arg_240_1.time_ < var_243_40 + var_243_41 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_40) / var_243_41

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_40 + var_243_41 and arg_240_1.time_ < var_243_40 + var_243_41 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417041059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417041059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417041060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1034"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1034 == nil then
				arg_246_1.var_.actorSpriteComps1034 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps1034 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								local var_249_4 = Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, var_249_3)
								local var_249_5 = Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, var_249_3)
								local var_249_6 = Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, var_249_3)

								iter_249_1.color = Color.New(var_249_4, var_249_5, var_249_6)
							else
								local var_249_7 = Mathf.Lerp(iter_249_1.color.r, 0.5, var_249_3)

								iter_249_1.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1034 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps1034 = nil
			end

			local var_249_8 = 0
			local var_249_9 = 0.9

			if var_249_8 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(417041059)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_12 = 36
				local var_249_13 = utf8.len(var_249_11)
				local var_249_14 = var_249_12 <= 0 and var_249_9 or var_249_9 * (var_249_13 / var_249_12)

				if var_249_14 > 0 and var_249_9 < var_249_14 then
					arg_246_1.talkMaxDuration = var_249_14

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_15 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_15 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_15

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_15 and arg_246_1.time_ < var_249_8 + var_249_15 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417041060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417041060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417041061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 1.65

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(417041060)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 66
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play417041061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417041061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417041062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.233333333333333
			local var_257_1 = 1

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				local var_257_2 = "play"
				local var_257_3 = "effect"

				arg_254_1:AudioAction(var_257_2, var_257_3, "se_story_1310", "se_story_1310_machine01", "")
			end

			local var_257_4 = 0
			local var_257_5 = 1.4

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(417041061)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_8 = 56
				local var_257_9 = utf8.len(var_257_7)
				local var_257_10 = var_257_8 <= 0 and var_257_5 or var_257_5 * (var_257_9 / var_257_8)

				if var_257_10 > 0 and var_257_5 < var_257_10 then
					arg_254_1.talkMaxDuration = var_257_10

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_11 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_11 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_11

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_11 and arg_254_1.time_ < var_257_4 + var_257_11 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417041062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417041062
		arg_258_1.duration_ = 4

		local var_258_0 = {
			zh = 2.266,
			ja = 4
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417041063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.25

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[1109].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_5")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(417041062)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 10
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041062", "story_v_out_417041.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041062", "story_v_out_417041.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_417041", "417041062", "story_v_out_417041.awb")

						arg_258_1:RecordAudio("417041062", var_261_9)
						arg_258_1:RecordAudio("417041062", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417041", "417041062", "story_v_out_417041.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417041", "417041062", "story_v_out_417041.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play417041063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 417041063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play417041064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.525

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(417041063)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 61
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play417041064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 417041064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play417041065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.05
			local var_269_1 = 1

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				local var_269_2 = "play"
				local var_269_3 = "effect"

				arg_266_1:AudioAction(var_269_2, var_269_3, "se_story_1310", "se_story_1310_scan", "")
			end

			local var_269_4 = 0
			local var_269_5 = 1.175

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(417041064)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_8 = 47
				local var_269_9 = utf8.len(var_269_7)
				local var_269_10 = var_269_8 <= 0 and var_269_5 or var_269_5 * (var_269_9 / var_269_8)

				if var_269_10 > 0 and var_269_5 < var_269_10 then
					arg_266_1.talkMaxDuration = var_269_10

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_11 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_11 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_11

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_11 and arg_266_1.time_ < var_269_4 + var_269_11 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play417041065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417041065
		arg_270_1.duration_ = 5.53

		local var_270_0 = {
			zh = 5.1,
			ja = 5.533
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417041066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.55

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[1121].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(417041065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 22
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041065", "story_v_out_417041.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041065", "story_v_out_417041.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_417041", "417041065", "story_v_out_417041.awb")

						arg_270_1:RecordAudio("417041065", var_273_9)
						arg_270_1:RecordAudio("417041065", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417041", "417041065", "story_v_out_417041.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417041", "417041065", "story_v_out_417041.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play417041066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417041066
		arg_274_1.duration_ = 2

		local var_274_0 = {
			zh = 1.633,
			ja = 2
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417041067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.125

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[1109].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(417041066)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 5
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041066", "story_v_out_417041.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041066", "story_v_out_417041.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_417041", "417041066", "story_v_out_417041.awb")

						arg_274_1:RecordAudio("417041066", var_277_9)
						arg_274_1:RecordAudio("417041066", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_417041", "417041066", "story_v_out_417041.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_417041", "417041066", "story_v_out_417041.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417041067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417041067
		arg_278_1.duration_ = 5.8

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417041068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_1 = 0.266666666666667

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_1 then
				local var_281_2 = (arg_278_1.time_ - var_281_0) / var_281_1
				local var_281_3 = Color.New(1, 1, 1)

				var_281_3.a = Mathf.Lerp(1, 0, var_281_2)
				arg_278_1.mask_.color = var_281_3
			end

			if arg_278_1.time_ >= var_281_0 + var_281_1 and arg_278_1.time_ < var_281_0 + var_281_1 + arg_281_0 then
				local var_281_4 = Color.New(1, 1, 1)
				local var_281_5 = 0

				arg_278_1.mask_.enabled = false
				var_281_4.a = var_281_5
				arg_278_1.mask_.color = var_281_4
			end

			local var_281_6 = manager.ui.mainCamera.transform
			local var_281_7 = 0.166666666666667

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				local var_281_8 = arg_278_1.var_.effect321
				local var_281_9
				local var_281_10 = var_281_6

				if not var_281_8 then
					var_281_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_281_10)
					var_281_8.name = "321"
					arg_278_1.var_.effect321 = var_281_8
				else
					var_281_8.transform:SetParent(var_281_10)
				end

				var_281_8.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_281_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_281_11 = manager.ui.mainCameraCom_
				local var_281_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_281_11.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_281_13 = var_281_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_281_14 = 15
				local var_281_15 = 2 * var_281_14 * Mathf.Tan(var_281_11.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_281_11.aspect
				local var_281_16 = 1
				local var_281_17 = 1.7777777777777777

				if var_281_17 < var_281_11.aspect then
					var_281_16 = var_281_15 / (2 * var_281_14 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_281_17)
				end

				for iter_281_0, iter_281_1 in ipairs(var_281_13) do
					local var_281_18 = iter_281_1.transform.localScale

					iter_281_1.transform.localScale = Vector3.New(var_281_18.x / var_281_12 * var_281_16, var_281_18.y / var_281_12, var_281_18.z)
				end
			end

			local var_281_19 = 0
			local var_281_20 = 1

			if var_281_19 < arg_278_1.time_ and arg_278_1.time_ <= var_281_19 + arg_281_0 then
				local var_281_21 = "play"
				local var_281_22 = "effect"

				arg_278_1:AudioAction(var_281_21, var_281_22, "se_story_1310", "se_story_1310_machine02", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_23 = 0.8
			local var_281_24 = 1.4

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_25 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_25:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_26 = arg_278_1:GetWordFromCfg(417041067)
				local var_281_27 = arg_278_1:FormatText(var_281_26.content)

				arg_278_1.text_.text = var_281_27

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_28 = 56
				local var_281_29 = utf8.len(var_281_27)
				local var_281_30 = var_281_28 <= 0 and var_281_24 or var_281_24 * (var_281_29 / var_281_28)

				if var_281_30 > 0 and var_281_24 < var_281_30 then
					arg_278_1.talkMaxDuration = var_281_30
					var_281_23 = var_281_23 + 0.3

					if var_281_30 + var_281_23 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_30 + var_281_23
					end
				end

				arg_278_1.text_.text = var_281_27
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_31 = var_281_23 + 0.3
			local var_281_32 = math.max(var_281_24, arg_278_1.talkMaxDuration)

			if var_281_31 <= arg_278_1.time_ and arg_278_1.time_ < var_281_31 + var_281_32 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_31) / var_281_32

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_31 + var_281_32 and arg_278_1.time_ < var_281_31 + var_281_32 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play417041068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417041068
		arg_284_1.duration_ = 5.67

		local var_284_0 = {
			zh = 4.2,
			ja = 5.666
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play417041069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.275

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[1121].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(417041068)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 11
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041068", "story_v_out_417041.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041068", "story_v_out_417041.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_417041", "417041068", "story_v_out_417041.awb")

						arg_284_1:RecordAudio("417041068", var_287_9)
						arg_284_1:RecordAudio("417041068", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_417041", "417041068", "story_v_out_417041.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_417041", "417041068", "story_v_out_417041.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play417041069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417041069
		arg_288_1.duration_ = 2.97

		local var_288_0 = {
			zh = 2.9,
			ja = 2.966
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play417041070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1034"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1034 == nil then
				arg_288_1.var_.actorSpriteComps1034 = var_291_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_2 = 0.2

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.actorSpriteComps1034 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								local var_291_4 = Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor1.r, var_291_3)
								local var_291_5 = Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor1.g, var_291_3)
								local var_291_6 = Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor1.b, var_291_3)

								iter_291_1.color = Color.New(var_291_4, var_291_5, var_291_6)
							else
								local var_291_7 = Mathf.Lerp(iter_291_1.color.r, 1, var_291_3)

								iter_291_1.color = Color.New(var_291_7, var_291_7, var_291_7)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1034 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_291_3 then
						if arg_288_1.isInRecall_ then
							iter_291_3.color = arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_291_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps1034 = nil
			end

			local var_291_8 = 0
			local var_291_9 = 0.05

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_10 = arg_288_1:FormatText(StoryNameCfg[1109].name)

				arg_288_1.leftNameTxt_.text = var_291_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_11 = arg_288_1:GetWordFromCfg(417041069)
				local var_291_12 = arg_288_1:FormatText(var_291_11.content)

				arg_288_1.text_.text = var_291_12

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 2
				local var_291_14 = utf8.len(var_291_12)
				local var_291_15 = var_291_13 <= 0 and var_291_9 or var_291_9 * (var_291_14 / var_291_13)

				if var_291_15 > 0 and var_291_9 < var_291_15 then
					arg_288_1.talkMaxDuration = var_291_15

					if var_291_15 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_15 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_12
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041069", "story_v_out_417041.awb") ~= 0 then
					local var_291_16 = manager.audio:GetVoiceLength("story_v_out_417041", "417041069", "story_v_out_417041.awb") / 1000

					if var_291_16 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_16 + var_291_8
					end

					if var_291_11.prefab_name ~= "" and arg_288_1.actors_[var_291_11.prefab_name] ~= nil then
						local var_291_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_11.prefab_name].transform, "story_v_out_417041", "417041069", "story_v_out_417041.awb")

						arg_288_1:RecordAudio("417041069", var_291_17)
						arg_288_1:RecordAudio("417041069", var_291_17)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_417041", "417041069", "story_v_out_417041.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_417041", "417041069", "story_v_out_417041.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_18 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_18 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_18

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_18 and arg_288_1.time_ < var_291_8 + var_291_18 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417041070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417041070
		arg_292_1.duration_ = 5.63

		local var_292_0 = {
			zh = 5.26666666666667,
			ja = 5.63266666666667
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417041071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1034"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1034 == nil then
				arg_292_1.var_.actorSpriteComps1034 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps1034 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								local var_295_4 = Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor2.r, var_295_3)
								local var_295_5 = Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor2.g, var_295_3)
								local var_295_6 = Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor2.b, var_295_3)

								iter_295_1.color = Color.New(var_295_4, var_295_5, var_295_6)
							else
								local var_295_7 = Mathf.Lerp(iter_295_1.color.r, 0.5, var_295_3)

								iter_295_1.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1034 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_295_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps1034 = nil
			end

			local var_295_8 = manager.ui.mainCamera.transform
			local var_295_9 = 0

			if var_295_9 < arg_292_1.time_ and arg_292_1.time_ <= var_295_9 + arg_295_0 then
				local var_295_10 = arg_292_1.var_.effect777
				local var_295_11
				local var_295_12 = var_295_8

				if not var_295_10 then
					var_295_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_295_12)
					var_295_10.name = "777"
					arg_292_1.var_.effect777 = var_295_10
				else
					var_295_10.transform:SetParent(var_295_12)
				end

				var_295_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_295_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_295_13 = manager.ui.mainCameraCom_
				local var_295_14 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_295_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_295_15 = var_295_10.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_295_16 = 15
				local var_295_17 = 2 * var_295_16 * Mathf.Tan(var_295_13.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_295_13.aspect
				local var_295_18 = 1
				local var_295_19 = 1.7777777777777777

				if var_295_19 < var_295_13.aspect then
					var_295_18 = var_295_17 / (2 * var_295_16 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_295_19)
				end

				for iter_295_4, iter_295_5 in ipairs(var_295_15) do
					local var_295_20 = iter_295_5.transform.localScale

					iter_295_5.transform.localScale = Vector3.New(var_295_20.x / var_295_14 * var_295_18, var_295_20.y / var_295_14, var_295_20.z)
				end
			end

			local var_295_21 = manager.ui.mainCamera.transform
			local var_295_22 = 1.16666666666667

			if var_295_22 < arg_292_1.time_ and arg_292_1.time_ <= var_295_22 + arg_295_0 then
				local var_295_23 = arg_292_1.var_.effect777

				if var_295_23 then
					Object.Destroy(var_295_23)

					arg_292_1.var_.effect777 = nil
				end
			end

			local var_295_24 = 0.05
			local var_295_25 = 1

			if var_295_24 < arg_292_1.time_ and arg_292_1.time_ <= var_295_24 + arg_295_0 then
				local var_295_26 = "play"
				local var_295_27 = "effect"

				arg_292_1:AudioAction(var_295_26, var_295_27, "se_story_130", "se_story_130_noise", "")
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_28 = 0.466666666666667
			local var_295_29 = 0.3

			if var_295_28 < arg_292_1.time_ and arg_292_1.time_ <= var_295_28 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_30 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_30:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_31 = arg_292_1:FormatText(StoryNameCfg[1121].name)

				arg_292_1.leftNameTxt_.text = var_295_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_32 = arg_292_1:GetWordFromCfg(417041070)
				local var_295_33 = arg_292_1:FormatText(var_295_32.content)

				arg_292_1.text_.text = var_295_33

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_34 = 12
				local var_295_35 = utf8.len(var_295_33)
				local var_295_36 = var_295_34 <= 0 and var_295_29 or var_295_29 * (var_295_35 / var_295_34)

				if var_295_36 > 0 and var_295_29 < var_295_36 then
					arg_292_1.talkMaxDuration = var_295_36
					var_295_28 = var_295_28 + 0.3

					if var_295_36 + var_295_28 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_36 + var_295_28
					end
				end

				arg_292_1.text_.text = var_295_33
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041070", "story_v_out_417041.awb") ~= 0 then
					local var_295_37 = manager.audio:GetVoiceLength("story_v_out_417041", "417041070", "story_v_out_417041.awb") / 1000

					if var_295_37 + var_295_28 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_37 + var_295_28
					end

					if var_295_32.prefab_name ~= "" and arg_292_1.actors_[var_295_32.prefab_name] ~= nil then
						local var_295_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_32.prefab_name].transform, "story_v_out_417041", "417041070", "story_v_out_417041.awb")

						arg_292_1:RecordAudio("417041070", var_295_38)
						arg_292_1:RecordAudio("417041070", var_295_38)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_417041", "417041070", "story_v_out_417041.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_417041", "417041070", "story_v_out_417041.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_39 = var_295_28 + 0.3
			local var_295_40 = math.max(var_295_29, arg_292_1.talkMaxDuration)

			if var_295_39 <= arg_292_1.time_ and arg_292_1.time_ < var_295_39 + var_295_40 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_39) / var_295_40

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_39 + var_295_40 and arg_292_1.time_ < var_295_39 + var_295_40 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417041071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417041071
		arg_298_1.duration_ = 4.23

		local var_298_0 = {
			zh = 4.06633333333333,
			ja = 4.23333333333333
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417041072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_1 = 1.16666666666667

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_1 then
				local var_301_2 = (arg_298_1.time_ - var_301_0) / var_301_1
				local var_301_3 = Color.New(0, 0, 0)

				var_301_3.a = Mathf.Lerp(0, 1, var_301_2)
				arg_298_1.mask_.color = var_301_3
			end

			if arg_298_1.time_ >= var_301_0 + var_301_1 and arg_298_1.time_ < var_301_0 + var_301_1 + arg_301_0 then
				local var_301_4 = Color.New(0, 0, 0)

				var_301_4.a = 1
				arg_298_1.mask_.color = var_301_4
			end

			local var_301_5 = 1.16666666666667

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_6 = 1.46666666666667

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_6 then
				local var_301_7 = (arg_298_1.time_ - var_301_5) / var_301_6
				local var_301_8 = Color.New(0, 0, 0)

				var_301_8.a = Mathf.Lerp(1, 0, var_301_7)
				arg_298_1.mask_.color = var_301_8
			end

			if arg_298_1.time_ >= var_301_5 + var_301_6 and arg_298_1.time_ < var_301_5 + var_301_6 + arg_301_0 then
				local var_301_9 = Color.New(0, 0, 0)
				local var_301_10 = 0

				arg_298_1.mask_.enabled = false
				var_301_9.a = var_301_10
				arg_298_1.mask_.color = var_301_9
			end

			local var_301_11 = "STblack"

			if arg_298_1.bgs_[var_301_11] == nil then
				local var_301_12 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_301_11)
				var_301_12.name = var_301_11
				var_301_12.transform.parent = arg_298_1.stage_.transform
				var_301_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_[var_301_11] = var_301_12
			end

			local var_301_13 = 1.16666666666667

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				local var_301_14 = manager.ui.mainCamera.transform.localPosition
				local var_301_15 = Vector3.New(0, 0, 10) + Vector3.New(var_301_14.x, var_301_14.y, 0)
				local var_301_16 = arg_298_1.bgs_.STblack

				var_301_16.transform.localPosition = var_301_15
				var_301_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_17 = var_301_16:GetComponent("SpriteRenderer")

				if var_301_17 and var_301_17.sprite then
					local var_301_18 = (var_301_16.transform.localPosition - var_301_14).z
					local var_301_19 = manager.ui.mainCameraCom_
					local var_301_20 = 2 * var_301_18 * Mathf.Tan(var_301_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_301_21 = var_301_20 * var_301_19.aspect
					local var_301_22 = var_301_17.sprite.bounds.size.x
					local var_301_23 = var_301_17.sprite.bounds.size.y
					local var_301_24 = var_301_21 / var_301_22
					local var_301_25 = var_301_20 / var_301_23
					local var_301_26 = var_301_25 < var_301_24 and var_301_24 or var_301_25

					var_301_16.transform.localScale = Vector3.New(var_301_26, var_301_26, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "STblack" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_27 = 0.166666666666667
			local var_301_28 = 1

			if var_301_27 < arg_298_1.time_ and arg_298_1.time_ <= var_301_27 + arg_301_0 then
				local var_301_29 = "stop"
				local var_301_30 = "effect"

				arg_298_1:AudioAction(var_301_29, var_301_30, "se_story_1310", "se_story_1310_machine02", "")
			end

			local var_301_31 = 0
			local var_301_32 = 0.2

			if var_301_31 < arg_298_1.time_ and arg_298_1.time_ <= var_301_31 + arg_301_0 then
				local var_301_33 = "play"
				local var_301_34 = "music"

				arg_298_1:AudioAction(var_301_33, var_301_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_301_35 = ""
				local var_301_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_301_36 ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_36 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_36

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_36
						arg_298_1.bgmTxt2_.text = var_301_36
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_301_37 = 0.333333333333333
			local var_301_38 = 1

			if var_301_37 < arg_298_1.time_ and arg_298_1.time_ <= var_301_37 + arg_301_0 then
				local var_301_39 = "stop"
				local var_301_40 = "music"

				arg_298_1:AudioAction(var_301_39, var_301_40, "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_301_41 = ""
				local var_301_42 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if var_301_42 ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_42 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_42

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_42
						arg_298_1.bgmTxt2_.text = var_301_42
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_43 = 2.63333333333333
			local var_301_44 = 0.125

			if var_301_43 < arg_298_1.time_ and arg_298_1.time_ <= var_301_43 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_45 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_45:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_298_1.dialogCg_.alpha = arg_304_0
				end))
				var_301_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_46 = arg_298_1:FormatText(StoryNameCfg[1109].name)

				arg_298_1.leftNameTxt_.text = var_301_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_47 = arg_298_1:GetWordFromCfg(417041071)
				local var_301_48 = arg_298_1:FormatText(var_301_47.content)

				arg_298_1.text_.text = var_301_48

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_49 = 5
				local var_301_50 = utf8.len(var_301_48)
				local var_301_51 = var_301_49 <= 0 and var_301_44 or var_301_44 * (var_301_50 / var_301_49)

				if var_301_51 > 0 and var_301_44 < var_301_51 then
					arg_298_1.talkMaxDuration = var_301_51
					var_301_43 = var_301_43 + 0.3

					if var_301_51 + var_301_43 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_51 + var_301_43
					end
				end

				arg_298_1.text_.text = var_301_48
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041071", "story_v_out_417041.awb") ~= 0 then
					local var_301_52 = manager.audio:GetVoiceLength("story_v_out_417041", "417041071", "story_v_out_417041.awb") / 1000

					if var_301_52 + var_301_43 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_52 + var_301_43
					end

					if var_301_47.prefab_name ~= "" and arg_298_1.actors_[var_301_47.prefab_name] ~= nil then
						local var_301_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_47.prefab_name].transform, "story_v_out_417041", "417041071", "story_v_out_417041.awb")

						arg_298_1:RecordAudio("417041071", var_301_53)
						arg_298_1:RecordAudio("417041071", var_301_53)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417041", "417041071", "story_v_out_417041.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417041", "417041071", "story_v_out_417041.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_54 = var_301_43 + 0.3
			local var_301_55 = math.max(var_301_44, arg_298_1.talkMaxDuration)

			if var_301_54 <= arg_298_1.time_ and arg_298_1.time_ < var_301_54 + var_301_55 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_54) / var_301_55

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_54 + var_301_55 and arg_298_1.time_ < var_301_54 + var_301_55 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play417041072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417041072
		arg_306_1.duration_ = 2.5

		local var_306_0 = {
			zh = 2.2,
			ja = 2.5
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417041073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			local var_309_1 = 0.3

			if arg_306_1.time_ >= var_309_0 + var_309_1 and arg_306_1.time_ < var_309_0 + var_309_1 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			local var_309_2 = manager.ui.mainCamera.transform
			local var_309_3 = 0.034

			if var_309_3 < arg_306_1.time_ and arg_306_1.time_ <= var_309_3 + arg_309_0 then
				local var_309_4 = arg_306_1.var_.effect321

				if var_309_4 then
					Object.Destroy(var_309_4)

					arg_306_1.var_.effect321 = nil
				end
			end

			local var_309_5 = 0
			local var_309_6 = 0.2

			if var_309_5 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				local var_309_7 = "play"
				local var_309_8 = "music"

				arg_306_1:AudioAction(var_309_7, var_309_8, "ui_battle", "ui_battle_stopbgm", "")

				local var_309_9 = ""
				local var_309_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_309_10 ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_10 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_10

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_10
						arg_306_1.bgmTxt2_.text = var_309_10
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_11 = 0
			local var_309_12 = 0.225

			if var_309_11 < arg_306_1.time_ and arg_306_1.time_ <= var_309_11 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_13 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_13:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_306_1.dialogCg_.alpha = arg_311_0
				end))
				var_309_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_14 = arg_306_1:FormatText(StoryNameCfg[1109].name)

				arg_306_1.leftNameTxt_.text = var_309_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_15 = arg_306_1:GetWordFromCfg(417041072)
				local var_309_16 = arg_306_1:FormatText(var_309_15.content)

				arg_306_1.text_.text = var_309_16

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_17 = 9
				local var_309_18 = utf8.len(var_309_16)
				local var_309_19 = var_309_17 <= 0 and var_309_12 or var_309_12 * (var_309_18 / var_309_17)

				if var_309_19 > 0 and var_309_12 < var_309_19 then
					arg_306_1.talkMaxDuration = var_309_19
					var_309_11 = var_309_11 + 0.3

					if var_309_19 + var_309_11 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_19 + var_309_11
					end
				end

				arg_306_1.text_.text = var_309_16
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041072", "story_v_out_417041.awb") ~= 0 then
					local var_309_20 = manager.audio:GetVoiceLength("story_v_out_417041", "417041072", "story_v_out_417041.awb") / 1000

					if var_309_20 + var_309_11 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_20 + var_309_11
					end

					if var_309_15.prefab_name ~= "" and arg_306_1.actors_[var_309_15.prefab_name] ~= nil then
						local var_309_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_15.prefab_name].transform, "story_v_out_417041", "417041072", "story_v_out_417041.awb")

						arg_306_1:RecordAudio("417041072", var_309_21)
						arg_306_1:RecordAudio("417041072", var_309_21)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417041", "417041072", "story_v_out_417041.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417041", "417041072", "story_v_out_417041.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_22 = var_309_11 + 0.3
			local var_309_23 = math.max(var_309_12, arg_306_1.talkMaxDuration)

			if var_309_22 <= arg_306_1.time_ and arg_306_1.time_ < var_309_22 + var_309_23 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_22) / var_309_23

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_22 + var_309_23 and arg_306_1.time_ < var_309_22 + var_309_23 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play417041073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417041073
		arg_313_1.duration_ = 3.6

		local var_313_0 = {
			zh = 3.1,
			ja = 3.6
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
				arg_313_0:Play417041074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			local var_316_1 = 1

			if arg_313_1.time_ >= var_316_0 + var_316_1 and arg_313_1.time_ < var_316_0 + var_316_1 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_2 = 0.8
			local var_316_3 = 0.2

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_4 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_4:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_5 = arg_313_1:FormatText(StoryNameCfg[36].name)

				arg_313_1.leftNameTxt_.text = var_316_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(417041073)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 8
				local var_316_9 = utf8.len(var_316_7)
				local var_316_10 = var_316_8 <= 0 and var_316_3 or var_316_3 * (var_316_9 / var_316_8)

				if var_316_10 > 0 and var_316_3 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10
					var_316_2 = var_316_2 + 0.3

					if var_316_10 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041073", "story_v_out_417041.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041073", "story_v_out_417041.awb") / 1000

					if var_316_11 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_2
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_out_417041", "417041073", "story_v_out_417041.awb")

						arg_313_1:RecordAudio("417041073", var_316_12)
						arg_313_1:RecordAudio("417041073", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_417041", "417041073", "story_v_out_417041.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_417041", "417041073", "story_v_out_417041.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = var_316_2 + 0.3
			local var_316_14 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_13 <= arg_313_1.time_ and arg_313_1.time_ < var_316_13 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_13) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_13 + var_316_14 and arg_313_1.time_ < var_316_13 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play417041074 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 417041074
		arg_319_1.duration_ = 5.23

		local var_319_0 = {
			zh = 5.166,
			ja = 5.233
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
				arg_319_0:Play417041075(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			local var_322_1 = 1

			if arg_319_1.time_ >= var_322_0 + var_322_1 and arg_319_1.time_ < var_322_0 + var_322_1 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end

			local var_322_2 = manager.ui.mainCamera.transform
			local var_322_3 = 0

			if var_322_3 < arg_319_1.time_ and arg_319_1.time_ <= var_322_3 + arg_322_0 then
				local var_322_4 = arg_319_1.var_.effect798
				local var_322_5
				local var_322_6 = var_322_2

				if not var_322_4 then
					var_322_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng02_in_keep"), var_322_6)
					var_322_4.name = "798"
					arg_319_1.var_.effect798 = var_322_4
				else
					var_322_4.transform:SetParent(var_322_6)
				end

				var_322_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_322_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_322_7 = manager.ui.mainCameraCom_
				local var_322_8 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_322_7.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_322_9 = var_322_4.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_322_10 = 15
				local var_322_11 = 2 * var_322_10 * Mathf.Tan(var_322_7.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_322_7.aspect
				local var_322_12 = 1
				local var_322_13 = 1.7777777777777777

				if var_322_13 < var_322_7.aspect then
					var_322_12 = var_322_11 / (2 * var_322_10 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_322_13)
				end

				for iter_322_0, iter_322_1 in ipairs(var_322_9) do
					local var_322_14 = iter_322_1.transform.localScale

					iter_322_1.transform.localScale = Vector3.New(var_322_14.x / var_322_8 * var_322_12, var_322_14.y / var_322_8, var_322_14.z)
				end
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_15 = 1
			local var_322_16 = 0.45

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_17 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_17:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_18 = arg_319_1:FormatText(StoryNameCfg[36].name)

				arg_319_1.leftNameTxt_.text = var_322_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_19 = arg_319_1:GetWordFromCfg(417041074)
				local var_322_20 = arg_319_1:FormatText(var_322_19.content)

				arg_319_1.text_.text = var_322_20

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_21 = 18
				local var_322_22 = utf8.len(var_322_20)
				local var_322_23 = var_322_21 <= 0 and var_322_16 or var_322_16 * (var_322_22 / var_322_21)

				if var_322_23 > 0 and var_322_16 < var_322_23 then
					arg_319_1.talkMaxDuration = var_322_23
					var_322_15 = var_322_15 + 0.3

					if var_322_23 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_15
					end
				end

				arg_319_1.text_.text = var_322_20
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041074", "story_v_out_417041.awb") ~= 0 then
					local var_322_24 = manager.audio:GetVoiceLength("story_v_out_417041", "417041074", "story_v_out_417041.awb") / 1000

					if var_322_24 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_15
					end

					if var_322_19.prefab_name ~= "" and arg_319_1.actors_[var_322_19.prefab_name] ~= nil then
						local var_322_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_19.prefab_name].transform, "story_v_out_417041", "417041074", "story_v_out_417041.awb")

						arg_319_1:RecordAudio("417041074", var_322_25)
						arg_319_1:RecordAudio("417041074", var_322_25)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_417041", "417041074", "story_v_out_417041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_417041", "417041074", "story_v_out_417041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_26 = var_322_15 + 0.3
			local var_322_27 = math.max(var_322_16, arg_319_1.talkMaxDuration)

			if var_322_26 <= arg_319_1.time_ and arg_319_1.time_ < var_322_26 + var_322_27 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_26) / var_322_27

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_26 + var_322_27 and arg_319_1.time_ < var_322_26 + var_322_27 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play417041075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417041075
		arg_325_1.duration_ = 11.92

		local var_325_0 = {
			zh = 9.383,
			ja = 11.916
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
				arg_325_0:Play417041076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = "I07a"

			if arg_325_1.bgs_[var_328_0] == nil then
				local var_328_1 = Object.Instantiate(arg_325_1.paintGo_)

				var_328_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_328_0)
				var_328_1.name = var_328_0
				var_328_1.transform.parent = arg_325_1.stage_.transform
				var_328_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.bgs_[var_328_0] = var_328_1
			end

			local var_328_2 = 2.03333333333333

			if var_328_2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				local var_328_3 = manager.ui.mainCamera.transform.localPosition
				local var_328_4 = Vector3.New(0, 0, 10) + Vector3.New(var_328_3.x, var_328_3.y, 0)
				local var_328_5 = arg_325_1.bgs_.I07a

				var_328_5.transform.localPosition = var_328_4
				var_328_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_6 = var_328_5:GetComponent("SpriteRenderer")

				if var_328_6 and var_328_6.sprite then
					local var_328_7 = (var_328_5.transform.localPosition - var_328_3).z
					local var_328_8 = manager.ui.mainCameraCom_
					local var_328_9 = 2 * var_328_7 * Mathf.Tan(var_328_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_328_10 = var_328_9 * var_328_8.aspect
					local var_328_11 = var_328_6.sprite.bounds.size.x
					local var_328_12 = var_328_6.sprite.bounds.size.y
					local var_328_13 = var_328_10 / var_328_11
					local var_328_14 = var_328_9 / var_328_12
					local var_328_15 = var_328_14 < var_328_13 and var_328_13 or var_328_14

					var_328_5.transform.localScale = Vector3.New(var_328_15, var_328_15, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "I07a" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_16 = 7.45

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_17 = 0.3

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_18 = manager.ui.mainCamera.transform
			local var_328_19 = 2.03333333333333

			if var_328_19 < arg_325_1.time_ and arg_325_1.time_ <= var_328_19 + arg_328_0 then
				local var_328_20 = arg_325_1.var_.effect798

				if var_328_20 then
					Object.Destroy(var_328_20)

					arg_325_1.var_.effect798 = nil
				end
			end

			local var_328_21 = 0
			local var_328_22 = 0.2

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				local var_328_23 = "play"
				local var_328_24 = "music"

				arg_325_1:AudioAction(var_328_23, var_328_24, "ui_battle", "ui_battle_stopbgm", "")

				local var_328_25 = ""
				local var_328_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_328_26 ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_26 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_26

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_26
						arg_325_1.bgmTxt2_.text = var_328_26
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_27 = 1.63333333333333
			local var_328_28 = 1

			if var_328_27 < arg_325_1.time_ and arg_325_1.time_ <= var_328_27 + arg_328_0 then
				local var_328_29 = "play"
				local var_328_30 = "music"

				arg_325_1:AudioAction(var_328_29, var_328_30, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_328_31 = ""
				local var_328_32 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_328_32 ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_32 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_32

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_32
						arg_325_1.bgmTxt2_.text = var_328_32
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_33 = 2.05
			local var_328_34 = 3
			local var_328_35 = "I07a"

			if var_328_33 < arg_325_1.time_ and arg_325_1.time_ <= var_328_33 + arg_328_0 then
				arg_325_1.timestampController_:SetSelectedState("show")
				arg_325_1.timestampAni_:Play("in")

				arg_325_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_328_35)

				arg_325_1.timestampColorController_:SetSelectedState("cold")
				arg_325_1.timeColdImg_:SetAlpha(0.031)

				local var_328_36 = arg_325_1:GetWordFromCfg(501013)
				local var_328_37 = arg_325_1:FormatText(var_328_36.content)

				arg_325_1.text_timeText_.text = var_328_37

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_timeText_)

				local var_328_38 = arg_325_1:GetWordFromCfg(501014)
				local var_328_39 = arg_325_1:FormatText(var_328_38.content)

				arg_325_1.text_siteText_.text = var_328_39

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_siteText_)
			end

			if arg_325_1.time_ >= var_328_33 + var_328_34 and arg_325_1.time_ < var_328_33 + var_328_34 + arg_328_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_325_1.timestampAni_, "out", function()
					arg_325_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_328_40 = 5.04999999999999

			if var_328_40 < arg_325_1.time_ and arg_325_1.time_ <= var_328_40 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_41 = 1.2

			if var_328_40 <= arg_325_1.time_ and arg_325_1.time_ < var_328_40 + var_328_41 then
				local var_328_42 = (arg_325_1.time_ - var_328_40) / var_328_41
				local var_328_43 = Color.New(0, 0, 0)

				var_328_43.a = Mathf.Lerp(0, 1, var_328_42)
				arg_325_1.mask_.color = var_328_43
			end

			if arg_325_1.time_ >= var_328_40 + var_328_41 and arg_325_1.time_ < var_328_40 + var_328_41 + arg_328_0 then
				local var_328_44 = Color.New(0, 0, 0)

				var_328_44.a = 1
				arg_325_1.mask_.color = var_328_44
			end

			local var_328_45 = 6.25

			if var_328_45 < arg_325_1.time_ and arg_325_1.time_ <= var_328_45 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_46 = 1.2

			if var_328_45 <= arg_325_1.time_ and arg_325_1.time_ < var_328_45 + var_328_46 then
				local var_328_47 = (arg_325_1.time_ - var_328_45) / var_328_46
				local var_328_48 = Color.New(0, 0, 0)

				var_328_48.a = Mathf.Lerp(1, 0, var_328_47)
				arg_325_1.mask_.color = var_328_48
			end

			if arg_325_1.time_ >= var_328_45 + var_328_46 and arg_325_1.time_ < var_328_45 + var_328_46 + arg_328_0 then
				local var_328_49 = Color.New(0, 0, 0)
				local var_328_50 = 0

				arg_325_1.mask_.enabled = false
				var_328_49.a = var_328_50
				arg_325_1.mask_.color = var_328_49
			end

			local var_328_51 = 0

			if var_328_51 < arg_325_1.time_ and arg_325_1.time_ <= var_328_51 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_52 = 2.05

			if var_328_51 <= arg_325_1.time_ and arg_325_1.time_ < var_328_51 + var_328_52 then
				local var_328_53 = (arg_325_1.time_ - var_328_51) / var_328_52
				local var_328_54 = Color.New(0, 0, 0)

				var_328_54.a = Mathf.Lerp(0, 1, var_328_53)
				arg_325_1.mask_.color = var_328_54
			end

			if arg_325_1.time_ >= var_328_51 + var_328_52 and arg_325_1.time_ < var_328_51 + var_328_52 + arg_328_0 then
				local var_328_55 = Color.New(0, 0, 0)

				var_328_55.a = 1
				arg_325_1.mask_.color = var_328_55
			end

			local var_328_56 = 2.05

			if var_328_56 < arg_325_1.time_ and arg_325_1.time_ <= var_328_56 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = false

				arg_325_1:SetGaussion(false)
			end

			local var_328_57 = 1

			if var_328_56 <= arg_325_1.time_ and arg_325_1.time_ < var_328_56 + var_328_57 then
				local var_328_58 = (arg_325_1.time_ - var_328_56) / var_328_57
				local var_328_59 = Color.New(0, 0, 0)

				var_328_59.a = Mathf.Lerp(1, 0, var_328_58)
				arg_325_1.mask_.color = var_328_59
			end

			if arg_325_1.time_ >= var_328_56 + var_328_57 and arg_325_1.time_ < var_328_56 + var_328_57 + arg_328_0 then
				local var_328_60 = Color.New(0, 0, 0)
				local var_328_61 = 0

				arg_325_1.mask_.enabled = false
				var_328_60.a = var_328_61
				arg_325_1.mask_.color = var_328_60
			end

			local var_328_62 = 2.05

			arg_325_1.isInRecall_ = true

			if var_328_62 < arg_325_1.time_ and arg_325_1.time_ <= var_328_62 + arg_328_0 then
				arg_325_1.screenFilterGo_:SetActive(true)

				arg_325_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_325_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_325_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_328_2, iter_328_3 in pairs(arg_325_1.actors_) do
					local var_328_63 = iter_328_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_328_4, iter_328_5 in ipairs(var_328_63) do
						if iter_328_5.color.r > 0.51 then
							iter_328_5.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_328_5.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_328_64 = 0.0833333333333333

			if var_328_62 <= arg_325_1.time_ and arg_325_1.time_ < var_328_62 + var_328_64 then
				local var_328_65 = (arg_325_1.time_ - var_328_62) / var_328_64

				arg_325_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_328_65)
			end

			if arg_325_1.time_ >= var_328_62 + var_328_64 and arg_325_1.time_ < var_328_62 + var_328_64 + arg_328_0 then
				arg_325_1.screenFilterEffect_.weight = 1
			end

			local var_328_66 = 2.04999999999999

			if var_328_66 < arg_325_1.time_ and arg_325_1.time_ <= var_328_66 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_67 = 3

			if arg_325_1.time_ >= var_328_66 + var_328_67 and arg_325_1.time_ < var_328_66 + var_328_67 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_68 = 7.45
			local var_328_69 = 0.175

			if var_328_68 < arg_325_1.time_ and arg_325_1.time_ <= var_328_68 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_70 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_70:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_325_1.dialogCg_.alpha = arg_332_0
				end))
				var_328_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_71 = arg_325_1:FormatText(StoryNameCfg[1109].name)

				arg_325_1.leftNameTxt_.text = var_328_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_72 = arg_325_1:GetWordFromCfg(417041075)
				local var_328_73 = arg_325_1:FormatText(var_328_72.content)

				arg_325_1.text_.text = var_328_73

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_74 = 7
				local var_328_75 = utf8.len(var_328_73)
				local var_328_76 = var_328_74 <= 0 and var_328_69 or var_328_69 * (var_328_75 / var_328_74)

				if var_328_76 > 0 and var_328_69 < var_328_76 then
					arg_325_1.talkMaxDuration = var_328_76
					var_328_68 = var_328_68 + 0.3

					if var_328_76 + var_328_68 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_76 + var_328_68
					end
				end

				arg_325_1.text_.text = var_328_73
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041075", "story_v_out_417041.awb") ~= 0 then
					local var_328_77 = manager.audio:GetVoiceLength("story_v_out_417041", "417041075", "story_v_out_417041.awb") / 1000

					if var_328_77 + var_328_68 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_77 + var_328_68
					end

					if var_328_72.prefab_name ~= "" and arg_325_1.actors_[var_328_72.prefab_name] ~= nil then
						local var_328_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_72.prefab_name].transform, "story_v_out_417041", "417041075", "story_v_out_417041.awb")

						arg_325_1:RecordAudio("417041075", var_328_78)
						arg_325_1:RecordAudio("417041075", var_328_78)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_417041", "417041075", "story_v_out_417041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_417041", "417041075", "story_v_out_417041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_79 = var_328_68 + 0.3
			local var_328_80 = math.max(var_328_69, arg_325_1.talkMaxDuration)

			if var_328_79 <= arg_325_1.time_ and arg_325_1.time_ < var_328_79 + var_328_80 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_79) / var_328_80

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_79 + var_328_80 and arg_325_1.time_ < var_328_79 + var_328_80 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417041076 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417041076
		arg_334_1.duration_ = 8.57

		local var_334_0 = {
			zh = 6.266,
			ja = 8.566
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417041077(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.0666666666666667
			local var_337_1 = 1

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				local var_337_2 = "play"
				local var_337_3 = "effect"

				arg_334_1:AudioAction(var_337_2, var_337_3, "se_story_1310", "se_story_1310_handcuffs", "")
			end

			local var_337_4 = 0
			local var_337_5 = 0.675

			if var_337_4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_6 = arg_334_1:FormatText(StoryNameCfg[1122].name)

				arg_334_1.leftNameTxt_.text = var_337_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_7 = arg_334_1:GetWordFromCfg(417041076)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_9 = 27
				local var_337_10 = utf8.len(var_337_8)
				local var_337_11 = var_337_9 <= 0 and var_337_5 or var_337_5 * (var_337_10 / var_337_9)

				if var_337_11 > 0 and var_337_5 < var_337_11 then
					arg_334_1.talkMaxDuration = var_337_11

					if var_337_11 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_4
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041076", "story_v_out_417041.awb") ~= 0 then
					local var_337_12 = manager.audio:GetVoiceLength("story_v_out_417041", "417041076", "story_v_out_417041.awb") / 1000

					if var_337_12 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_4
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_out_417041", "417041076", "story_v_out_417041.awb")

						arg_334_1:RecordAudio("417041076", var_337_13)
						arg_334_1:RecordAudio("417041076", var_337_13)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417041", "417041076", "story_v_out_417041.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417041", "417041076", "story_v_out_417041.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_14 = math.max(var_337_5, arg_334_1.talkMaxDuration)

			if var_337_4 <= arg_334_1.time_ and arg_334_1.time_ < var_337_4 + var_337_14 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_4) / var_337_14

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_4 + var_337_14 and arg_334_1.time_ < var_337_4 + var_337_14 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417041077 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417041077
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417041078(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 1.1

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:GetWordFromCfg(417041077)
				local var_341_3 = arg_338_1:FormatText(var_341_2.content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 44
				local var_341_5 = utf8.len(var_341_3)
				local var_341_6 = var_341_4 <= 0 and var_341_1 or var_341_1 * (var_341_5 / var_341_4)

				if var_341_6 > 0 and var_341_1 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_7 and arg_338_1.time_ < var_341_0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417041078 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417041078
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417041079(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.15

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(417041078)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 46
				local var_345_5 = utf8.len(var_345_3)
				local var_345_6 = var_345_4 <= 0 and var_345_1 or var_345_1 * (var_345_5 / var_345_4)

				if var_345_6 > 0 and var_345_1 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_7 and arg_342_1.time_ < var_345_0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417041079 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417041079
		arg_346_1.duration_ = 6.87

		local var_346_0 = {
			zh = 6.866,
			ja = 6.633
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
				arg_346_0:Play417041080(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.825

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[1122].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(417041079)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 33
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041079", "story_v_out_417041.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041079", "story_v_out_417041.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_417041", "417041079", "story_v_out_417041.awb")

						arg_346_1:RecordAudio("417041079", var_349_9)
						arg_346_1:RecordAudio("417041079", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417041", "417041079", "story_v_out_417041.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417041", "417041079", "story_v_out_417041.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play417041080 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417041080
		arg_350_1.duration_ = 7.93

		local var_350_0 = {
			zh = 5.4,
			ja = 7.933
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417041081(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.675

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[1122].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(417041080)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 27
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041080", "story_v_out_417041.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041080", "story_v_out_417041.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_out_417041", "417041080", "story_v_out_417041.awb")

						arg_350_1:RecordAudio("417041080", var_353_9)
						arg_350_1:RecordAudio("417041080", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417041", "417041080", "story_v_out_417041.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417041", "417041080", "story_v_out_417041.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_10 and arg_350_1.time_ < var_353_0 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417041081 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417041081
		arg_354_1.duration_ = 2.33

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417041082(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1034"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps1034 == nil then
				arg_354_1.var_.actorSpriteComps1034 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps1034 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 1, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps1034 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_357_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps1034 = nil
			end

			local var_357_8 = arg_354_1.actors_["1034"].transform
			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.var_.moveOldPos1034 = var_357_8.localPosition
				var_357_8.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1034", 3)

				local var_357_10 = var_357_8.childCount

				for iter_357_4 = 0, var_357_10 - 1 do
					local var_357_11 = var_357_8:GetChild(iter_357_4)

					if var_357_11.name == "split_6" or not string.find(var_357_11.name, "split") then
						var_357_11.gameObject:SetActive(true)
					else
						var_357_11.gameObject:SetActive(false)
					end
				end
			end

			local var_357_12 = 0.001

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_12 then
				local var_357_13 = (arg_354_1.time_ - var_357_9) / var_357_12
				local var_357_14 = Vector3.New(0, -331.9, -324)

				var_357_8.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1034, var_357_14, var_357_13)
			end

			if arg_354_1.time_ >= var_357_9 + var_357_12 and arg_354_1.time_ < var_357_9 + var_357_12 + arg_357_0 then
				var_357_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_357_15 = 0
			local var_357_16 = 0.175

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[1109].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(417041081)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 7
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041081", "story_v_out_417041.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041081", "story_v_out_417041.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_out_417041", "417041081", "story_v_out_417041.awb")

						arg_354_1:RecordAudio("417041081", var_357_24)
						arg_354_1:RecordAudio("417041081", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417041", "417041081", "story_v_out_417041.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417041", "417041081", "story_v_out_417041.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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

		arg_354_1:InitPlayNodeList()
	end,
	Play417041082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417041082
		arg_358_1.duration_ = 5.37

		local var_358_0 = {
			zh = 4.066,
			ja = 5.366
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
				arg_358_0:Play417041083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1034"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1034 == nil then
				arg_358_1.var_.actorSpriteComps1034 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps1034 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor2.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor2.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor2.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 0.5, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1034 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_361_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1034 = nil
			end

			local var_361_8 = 0
			local var_361_9 = 0.425

			if var_361_8 < arg_358_1.time_ and arg_358_1.time_ <= var_361_8 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_10 = arg_358_1:FormatText(StoryNameCfg[1122].name)

				arg_358_1.leftNameTxt_.text = var_361_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_11 = arg_358_1:GetWordFromCfg(417041082)
				local var_361_12 = arg_358_1:FormatText(var_361_11.content)

				arg_358_1.text_.text = var_361_12

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_13 = 17
				local var_361_14 = utf8.len(var_361_12)
				local var_361_15 = var_361_13 <= 0 and var_361_9 or var_361_9 * (var_361_14 / var_361_13)

				if var_361_15 > 0 and var_361_9 < var_361_15 then
					arg_358_1.talkMaxDuration = var_361_15

					if var_361_15 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_15 + var_361_8
					end
				end

				arg_358_1.text_.text = var_361_12
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041082", "story_v_out_417041.awb") ~= 0 then
					local var_361_16 = manager.audio:GetVoiceLength("story_v_out_417041", "417041082", "story_v_out_417041.awb") / 1000

					if var_361_16 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_16 + var_361_8
					end

					if var_361_11.prefab_name ~= "" and arg_358_1.actors_[var_361_11.prefab_name] ~= nil then
						local var_361_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_11.prefab_name].transform, "story_v_out_417041", "417041082", "story_v_out_417041.awb")

						arg_358_1:RecordAudio("417041082", var_361_17)
						arg_358_1:RecordAudio("417041082", var_361_17)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417041", "417041082", "story_v_out_417041.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417041", "417041082", "story_v_out_417041.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_18 = math.max(var_361_9, arg_358_1.talkMaxDuration)

			if var_361_8 <= arg_358_1.time_ and arg_358_1.time_ < var_361_8 + var_361_18 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_8) / var_361_18

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_8 + var_361_18 and arg_358_1.time_ < var_361_8 + var_361_18 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417041083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417041083
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417041084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1034"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos1034 = var_365_0.localPosition
				var_365_0.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1034", 7)

				local var_365_2 = var_365_0.childCount

				for iter_365_0 = 0, var_365_2 - 1 do
					local var_365_3 = var_365_0:GetChild(iter_365_0)

					if var_365_3.name == "" or not string.find(var_365_3.name, "split") then
						var_365_3.gameObject:SetActive(true)
					else
						var_365_3.gameObject:SetActive(false)
					end
				end
			end

			local var_365_4 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_4 then
				local var_365_5 = (arg_362_1.time_ - var_365_1) / var_365_4
				local var_365_6 = Vector3.New(0, -2000, 0)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1034, var_365_6, var_365_5)
			end

			if arg_362_1.time_ >= var_365_1 + var_365_4 and arg_362_1.time_ < var_365_1 + var_365_4 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_365_7 = 0
			local var_365_8 = 0.95

			if var_365_7 < arg_362_1.time_ and arg_362_1.time_ <= var_365_7 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_9 = arg_362_1:GetWordFromCfg(417041083)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 38
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_8 or var_365_8 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_8 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_7 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_7
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_14 = math.max(var_365_8, arg_362_1.talkMaxDuration)

			if var_365_7 <= arg_362_1.time_ and arg_362_1.time_ < var_365_7 + var_365_14 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_7) / var_365_14

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_7 + var_365_14 and arg_362_1.time_ < var_365_7 + var_365_14 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play417041084 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417041084
		arg_366_1.duration_ = 2.4

		local var_366_0 = {
			zh = 2.1,
			ja = 2.4
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
				arg_366_0:Play417041085(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = "10113"

			if arg_366_1.actors_[var_369_0] == nil then
				local var_369_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_369_1) then
					local var_369_2 = Object.Instantiate(var_369_1, arg_366_1.canvasGo_.transform)

					var_369_2.transform:SetSiblingIndex(1)

					var_369_2.name = var_369_0
					var_369_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_366_1.actors_[var_369_0] = var_369_2

					local var_369_3 = var_369_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_366_1.isInRecall_ then
						for iter_369_0, iter_369_1 in ipairs(var_369_3) do
							iter_369_1.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_369_4 = arg_366_1.actors_["10113"]
			local var_369_5 = 0

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.actorSpriteComps10113 == nil then
				arg_366_1.var_.actorSpriteComps10113 = var_369_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_6 = 0.2

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_6 and not isNil(var_369_4) then
				local var_369_7 = (arg_366_1.time_ - var_369_5) / var_369_6

				if arg_366_1.var_.actorSpriteComps10113 then
					for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_369_3 then
							if arg_366_1.isInRecall_ then
								local var_369_8 = Mathf.Lerp(iter_369_3.color.r, arg_366_1.hightColor1.r, var_369_7)
								local var_369_9 = Mathf.Lerp(iter_369_3.color.g, arg_366_1.hightColor1.g, var_369_7)
								local var_369_10 = Mathf.Lerp(iter_369_3.color.b, arg_366_1.hightColor1.b, var_369_7)

								iter_369_3.color = Color.New(var_369_8, var_369_9, var_369_10)
							else
								local var_369_11 = Mathf.Lerp(iter_369_3.color.r, 1, var_369_7)

								iter_369_3.color = Color.New(var_369_11, var_369_11, var_369_11)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_5 + var_369_6 and arg_366_1.time_ < var_369_5 + var_369_6 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.actorSpriteComps10113 then
				for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_369_5 then
						if arg_366_1.isInRecall_ then
							iter_369_5.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_369_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps10113 = nil
			end

			local var_369_12 = arg_366_1.actors_["10113"].transform
			local var_369_13 = 0

			if var_369_13 < arg_366_1.time_ and arg_366_1.time_ <= var_369_13 + arg_369_0 then
				arg_366_1.var_.moveOldPos10113 = var_369_12.localPosition
				var_369_12.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10113", 3)

				local var_369_14 = var_369_12.childCount

				for iter_369_6 = 0, var_369_14 - 1 do
					local var_369_15 = var_369_12:GetChild(iter_369_6)

					if var_369_15.name == "" or not string.find(var_369_15.name, "split") then
						var_369_15.gameObject:SetActive(true)
					else
						var_369_15.gameObject:SetActive(false)
					end
				end
			end

			local var_369_16 = 0.001

			if var_369_13 <= arg_366_1.time_ and arg_366_1.time_ < var_369_13 + var_369_16 then
				local var_369_17 = (arg_366_1.time_ - var_369_13) / var_369_16
				local var_369_18 = Vector3.New(-30.38, -328.4, -517.4)

				var_369_12.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10113, var_369_18, var_369_17)
			end

			if arg_366_1.time_ >= var_369_13 + var_369_16 and arg_366_1.time_ < var_369_13 + var_369_16 + arg_369_0 then
				var_369_12.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_369_19 = 0
			local var_369_20 = 0.25

			if var_369_19 < arg_366_1.time_ and arg_366_1.time_ <= var_369_19 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_21 = arg_366_1:FormatText(StoryNameCfg[1117].name)

				arg_366_1.leftNameTxt_.text = var_369_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_22 = arg_366_1:GetWordFromCfg(417041084)
				local var_369_23 = arg_366_1:FormatText(var_369_22.content)

				arg_366_1.text_.text = var_369_23

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_24 = 10
				local var_369_25 = utf8.len(var_369_23)
				local var_369_26 = var_369_24 <= 0 and var_369_20 or var_369_20 * (var_369_25 / var_369_24)

				if var_369_26 > 0 and var_369_20 < var_369_26 then
					arg_366_1.talkMaxDuration = var_369_26

					if var_369_26 + var_369_19 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_26 + var_369_19
					end
				end

				arg_366_1.text_.text = var_369_23
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041084", "story_v_out_417041.awb") ~= 0 then
					local var_369_27 = manager.audio:GetVoiceLength("story_v_out_417041", "417041084", "story_v_out_417041.awb") / 1000

					if var_369_27 + var_369_19 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_27 + var_369_19
					end

					if var_369_22.prefab_name ~= "" and arg_366_1.actors_[var_369_22.prefab_name] ~= nil then
						local var_369_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_22.prefab_name].transform, "story_v_out_417041", "417041084", "story_v_out_417041.awb")

						arg_366_1:RecordAudio("417041084", var_369_28)
						arg_366_1:RecordAudio("417041084", var_369_28)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417041", "417041084", "story_v_out_417041.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417041", "417041084", "story_v_out_417041.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_29 = math.max(var_369_20, arg_366_1.talkMaxDuration)

			if var_369_19 <= arg_366_1.time_ and arg_366_1.time_ < var_369_19 + var_369_29 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_19) / var_369_29

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_19 + var_369_29 and arg_366_1.time_ < var_369_19 + var_369_29 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
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

		arg_366_1:InitPlayNodeList()
	end,
	Play417041085 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417041085
		arg_370_1.duration_ = 2.07

		local var_370_0 = {
			zh = 1.666,
			ja = 2.066
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
				arg_370_0:Play417041086(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1034"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1034 == nil then
				arg_370_1.var_.actorSpriteComps1034 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps1034 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps1034 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1034 = nil
			end

			local var_373_8 = arg_370_1.actors_["10113"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10113 == nil then
				arg_370_1.var_.actorSpriteComps10113 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps10113 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10113 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10113 = nil
			end

			local var_373_16 = arg_370_1.actors_["1034"].transform
			local var_373_17 = 0

			if var_373_17 < arg_370_1.time_ and arg_370_1.time_ <= var_373_17 + arg_373_0 then
				arg_370_1.var_.moveOldPos1034 = var_373_16.localPosition
				var_373_16.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1034", 3)

				local var_373_18 = var_373_16.childCount

				for iter_373_8 = 0, var_373_18 - 1 do
					local var_373_19 = var_373_16:GetChild(iter_373_8)

					if var_373_19.name == "split_6" or not string.find(var_373_19.name, "split") then
						var_373_19.gameObject:SetActive(true)
					else
						var_373_19.gameObject:SetActive(false)
					end
				end
			end

			local var_373_20 = 0.001

			if var_373_17 <= arg_370_1.time_ and arg_370_1.time_ < var_373_17 + var_373_20 then
				local var_373_21 = (arg_370_1.time_ - var_373_17) / var_373_20
				local var_373_22 = Vector3.New(0, -331.9, -324)

				var_373_16.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1034, var_373_22, var_373_21)
			end

			if arg_370_1.time_ >= var_373_17 + var_373_20 and arg_370_1.time_ < var_373_17 + var_373_20 + arg_373_0 then
				var_373_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_373_23 = arg_370_1.actors_["10113"].transform
			local var_373_24 = 0

			if var_373_24 < arg_370_1.time_ and arg_370_1.time_ <= var_373_24 + arg_373_0 then
				arg_370_1.var_.moveOldPos10113 = var_373_23.localPosition
				var_373_23.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10113", 7)

				local var_373_25 = var_373_23.childCount

				for iter_373_9 = 0, var_373_25 - 1 do
					local var_373_26 = var_373_23:GetChild(iter_373_9)

					if var_373_26.name == "" or not string.find(var_373_26.name, "split") then
						var_373_26.gameObject:SetActive(true)
					else
						var_373_26.gameObject:SetActive(false)
					end
				end
			end

			local var_373_27 = 0.001

			if var_373_24 <= arg_370_1.time_ and arg_370_1.time_ < var_373_24 + var_373_27 then
				local var_373_28 = (arg_370_1.time_ - var_373_24) / var_373_27
				local var_373_29 = Vector3.New(0, -2000, 0)

				var_373_23.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10113, var_373_29, var_373_28)
			end

			if arg_370_1.time_ >= var_373_24 + var_373_27 and arg_370_1.time_ < var_373_24 + var_373_27 + arg_373_0 then
				var_373_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_373_30 = 0
			local var_373_31 = 0.175

			if var_373_30 < arg_370_1.time_ and arg_370_1.time_ <= var_373_30 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_32 = arg_370_1:FormatText(StoryNameCfg[1109].name)

				arg_370_1.leftNameTxt_.text = var_373_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_33 = arg_370_1:GetWordFromCfg(417041085)
				local var_373_34 = arg_370_1:FormatText(var_373_33.content)

				arg_370_1.text_.text = var_373_34

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_35 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041085", "story_v_out_417041.awb") ~= 0 then
					local var_373_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041085", "story_v_out_417041.awb") / 1000

					if var_373_38 + var_373_30 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_38 + var_373_30
					end

					if var_373_33.prefab_name ~= "" and arg_370_1.actors_[var_373_33.prefab_name] ~= nil then
						local var_373_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_33.prefab_name].transform, "story_v_out_417041", "417041085", "story_v_out_417041.awb")

						arg_370_1:RecordAudio("417041085", var_373_39)
						arg_370_1:RecordAudio("417041085", var_373_39)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417041", "417041085", "story_v_out_417041.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417041", "417041085", "story_v_out_417041.awb")
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
				actorName = "10113",
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
	Play417041086 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417041086
		arg_374_1.duration_ = 7.57

		local var_374_0 = {
			zh = 5.5,
			ja = 7.566
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
				arg_374_0:Play417041087(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["10113"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10113 == nil then
				arg_374_1.var_.actorSpriteComps10113 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps10113 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10113 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_377_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps10113 = nil
			end

			local var_377_8 = arg_374_1.actors_["1034"]
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1034 == nil then
				arg_374_1.var_.actorSpriteComps1034 = var_377_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_10 = 0.2

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 and not isNil(var_377_8) then
				local var_377_11 = (arg_374_1.time_ - var_377_9) / var_377_10

				if arg_374_1.var_.actorSpriteComps1034 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 and not isNil(var_377_8) and arg_374_1.var_.actorSpriteComps1034 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_377_7 then
						if arg_374_1.isInRecall_ then
							iter_377_7.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps1034 = nil
			end

			local var_377_16 = arg_374_1.actors_["10113"].transform
			local var_377_17 = 0

			if var_377_17 < arg_374_1.time_ and arg_374_1.time_ <= var_377_17 + arg_377_0 then
				arg_374_1.var_.moveOldPos10113 = var_377_16.localPosition
				var_377_16.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10113", 3)

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
				local var_377_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_377_16.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10113, var_377_22, var_377_21)
			end

			if arg_374_1.time_ >= var_377_17 + var_377_20 and arg_374_1.time_ < var_377_17 + var_377_20 + arg_377_0 then
				var_377_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_377_23 = arg_374_1.actors_["1034"].transform
			local var_377_24 = 0

			if var_377_24 < arg_374_1.time_ and arg_374_1.time_ <= var_377_24 + arg_377_0 then
				arg_374_1.var_.moveOldPos1034 = var_377_23.localPosition
				var_377_23.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1034", 7)

				local var_377_25 = var_377_23.childCount

				for iter_377_9 = 0, var_377_25 - 1 do
					local var_377_26 = var_377_23:GetChild(iter_377_9)

					if var_377_26.name == "" or not string.find(var_377_26.name, "split") then
						var_377_26.gameObject:SetActive(true)
					else
						var_377_26.gameObject:SetActive(false)
					end
				end
			end

			local var_377_27 = 0.001

			if var_377_24 <= arg_374_1.time_ and arg_374_1.time_ < var_377_24 + var_377_27 then
				local var_377_28 = (arg_374_1.time_ - var_377_24) / var_377_27
				local var_377_29 = Vector3.New(0, -2000, 0)

				var_377_23.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1034, var_377_29, var_377_28)
			end

			if arg_374_1.time_ >= var_377_24 + var_377_27 and arg_374_1.time_ < var_377_24 + var_377_27 + arg_377_0 then
				var_377_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_30 = 0
			local var_377_31 = 0.625

			if var_377_30 < arg_374_1.time_ and arg_374_1.time_ <= var_377_30 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_32 = arg_374_1:FormatText(StoryNameCfg[1117].name)

				arg_374_1.leftNameTxt_.text = var_377_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_33 = arg_374_1:GetWordFromCfg(417041086)
				local var_377_34 = arg_374_1:FormatText(var_377_33.content)

				arg_374_1.text_.text = var_377_34

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_35 = 25
				local var_377_36 = utf8.len(var_377_34)
				local var_377_37 = var_377_35 <= 0 and var_377_31 or var_377_31 * (var_377_36 / var_377_35)

				if var_377_37 > 0 and var_377_31 < var_377_37 then
					arg_374_1.talkMaxDuration = var_377_37

					if var_377_37 + var_377_30 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_37 + var_377_30
					end
				end

				arg_374_1.text_.text = var_377_34
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041086", "story_v_out_417041.awb") ~= 0 then
					local var_377_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041086", "story_v_out_417041.awb") / 1000

					if var_377_38 + var_377_30 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_38 + var_377_30
					end

					if var_377_33.prefab_name ~= "" and arg_374_1.actors_[var_377_33.prefab_name] ~= nil then
						local var_377_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_33.prefab_name].transform, "story_v_out_417041", "417041086", "story_v_out_417041.awb")

						arg_374_1:RecordAudio("417041086", var_377_39)
						arg_374_1:RecordAudio("417041086", var_377_39)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417041", "417041086", "story_v_out_417041.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417041", "417041086", "story_v_out_417041.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_40 = math.max(var_377_31, arg_374_1.talkMaxDuration)

			if var_377_30 <= arg_374_1.time_ and arg_374_1.time_ < var_377_30 + var_377_40 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_30) / var_377_40

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_30 + var_377_40 and arg_374_1.time_ < var_377_30 + var_377_40 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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
	Play417041087 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417041087
		arg_378_1.duration_ = 3.5

		local var_378_0 = {
			zh = 1.466,
			ja = 3.5
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play417041088(arg_378_1)
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
								local var_381_4 = Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor1.r, var_381_3)
								local var_381_5 = Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor1.g, var_381_3)
								local var_381_6 = Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor1.b, var_381_3)

								iter_381_1.color = Color.New(var_381_4, var_381_5, var_381_6)
							else
								local var_381_7 = Mathf.Lerp(iter_381_1.color.r, 1, var_381_3)

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
							iter_381_3.color = arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_381_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps1034 = nil
			end

			local var_381_8 = arg_378_1.actors_["10113"]
			local var_381_9 = 0

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 and not isNil(var_381_8) and arg_378_1.var_.actorSpriteComps10113 == nil then
				arg_378_1.var_.actorSpriteComps10113 = var_381_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_10 = 0.2

			if var_381_9 <= arg_378_1.time_ and arg_378_1.time_ < var_381_9 + var_381_10 and not isNil(var_381_8) then
				local var_381_11 = (arg_378_1.time_ - var_381_9) / var_381_10

				if arg_378_1.var_.actorSpriteComps10113 then
					for iter_381_4, iter_381_5 in pairs(arg_378_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_381_5 then
							if arg_378_1.isInRecall_ then
								local var_381_12 = Mathf.Lerp(iter_381_5.color.r, arg_378_1.hightColor2.r, var_381_11)
								local var_381_13 = Mathf.Lerp(iter_381_5.color.g, arg_378_1.hightColor2.g, var_381_11)
								local var_381_14 = Mathf.Lerp(iter_381_5.color.b, arg_378_1.hightColor2.b, var_381_11)

								iter_381_5.color = Color.New(var_381_12, var_381_13, var_381_14)
							else
								local var_381_15 = Mathf.Lerp(iter_381_5.color.r, 0.5, var_381_11)

								iter_381_5.color = Color.New(var_381_15, var_381_15, var_381_15)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_9 + var_381_10 and arg_378_1.time_ < var_381_9 + var_381_10 + arg_381_0 and not isNil(var_381_8) and arg_378_1.var_.actorSpriteComps10113 then
				for iter_381_6, iter_381_7 in pairs(arg_378_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_381_7 then
						if arg_378_1.isInRecall_ then
							iter_381_7.color = arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_381_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps10113 = nil
			end

			local var_381_16 = arg_378_1.actors_["1034"].transform
			local var_381_17 = 0

			if var_381_17 < arg_378_1.time_ and arg_378_1.time_ <= var_381_17 + arg_381_0 then
				arg_378_1.var_.moveOldPos1034 = var_381_16.localPosition
				var_381_16.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1034", 3)

				local var_381_18 = var_381_16.childCount

				for iter_381_8 = 0, var_381_18 - 1 do
					local var_381_19 = var_381_16:GetChild(iter_381_8)

					if var_381_19.name == "split_6" or not string.find(var_381_19.name, "split") then
						var_381_19.gameObject:SetActive(true)
					else
						var_381_19.gameObject:SetActive(false)
					end
				end
			end

			local var_381_20 = 0.001

			if var_381_17 <= arg_378_1.time_ and arg_378_1.time_ < var_381_17 + var_381_20 then
				local var_381_21 = (arg_378_1.time_ - var_381_17) / var_381_20
				local var_381_22 = Vector3.New(0, -331.9, -324)

				var_381_16.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1034, var_381_22, var_381_21)
			end

			if arg_378_1.time_ >= var_381_17 + var_381_20 and arg_378_1.time_ < var_381_17 + var_381_20 + arg_381_0 then
				var_381_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_381_23 = arg_378_1.actors_["10113"].transform
			local var_381_24 = 0

			if var_381_24 < arg_378_1.time_ and arg_378_1.time_ <= var_381_24 + arg_381_0 then
				arg_378_1.var_.moveOldPos10113 = var_381_23.localPosition
				var_381_23.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10113", 7)

				local var_381_25 = var_381_23.childCount

				for iter_381_9 = 0, var_381_25 - 1 do
					local var_381_26 = var_381_23:GetChild(iter_381_9)

					if var_381_26.name == "" or not string.find(var_381_26.name, "split") then
						var_381_26.gameObject:SetActive(true)
					else
						var_381_26.gameObject:SetActive(false)
					end
				end
			end

			local var_381_27 = 0.001

			if var_381_24 <= arg_378_1.time_ and arg_378_1.time_ < var_381_24 + var_381_27 then
				local var_381_28 = (arg_378_1.time_ - var_381_24) / var_381_27
				local var_381_29 = Vector3.New(0, -2000, 0)

				var_381_23.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10113, var_381_29, var_381_28)
			end

			if arg_378_1.time_ >= var_381_24 + var_381_27 and arg_378_1.time_ < var_381_24 + var_381_27 + arg_381_0 then
				var_381_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_381_30 = 0
			local var_381_31 = 0.175

			if var_381_30 < arg_378_1.time_ and arg_378_1.time_ <= var_381_30 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_32 = arg_378_1:FormatText(StoryNameCfg[1109].name)

				arg_378_1.leftNameTxt_.text = var_381_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_33 = arg_378_1:GetWordFromCfg(417041087)
				local var_381_34 = arg_378_1:FormatText(var_381_33.content)

				arg_378_1.text_.text = var_381_34

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_35 = 7
				local var_381_36 = utf8.len(var_381_34)
				local var_381_37 = var_381_35 <= 0 and var_381_31 or var_381_31 * (var_381_36 / var_381_35)

				if var_381_37 > 0 and var_381_31 < var_381_37 then
					arg_378_1.talkMaxDuration = var_381_37

					if var_381_37 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_37 + var_381_30
					end
				end

				arg_378_1.text_.text = var_381_34
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041087", "story_v_out_417041.awb") ~= 0 then
					local var_381_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041087", "story_v_out_417041.awb") / 1000

					if var_381_38 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_38 + var_381_30
					end

					if var_381_33.prefab_name ~= "" and arg_378_1.actors_[var_381_33.prefab_name] ~= nil then
						local var_381_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_33.prefab_name].transform, "story_v_out_417041", "417041087", "story_v_out_417041.awb")

						arg_378_1:RecordAudio("417041087", var_381_39)
						arg_378_1:RecordAudio("417041087", var_381_39)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_417041", "417041087", "story_v_out_417041.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_417041", "417041087", "story_v_out_417041.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_40 = math.max(var_381_31, arg_378_1.talkMaxDuration)

			if var_381_30 <= arg_378_1.time_ and arg_378_1.time_ < var_381_30 + var_381_40 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_30) / var_381_40

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_30 + var_381_40 and arg_378_1.time_ < var_381_30 + var_381_40 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
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
				actorName = "10113",
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
	Play417041088 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417041088
		arg_382_1.duration_ = 4.07

		local var_382_0 = {
			zh = 3,
			ja = 4.066
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
				arg_382_0:Play417041089(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10113"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10113 == nil then
				arg_382_1.var_.actorSpriteComps10113 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps10113 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10113 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps10113 = nil
			end

			local var_385_8 = arg_382_1.actors_["1034"]
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps1034 == nil then
				arg_382_1.var_.actorSpriteComps1034 = var_385_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_10 = 0.2

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_10 and not isNil(var_385_8) then
				local var_385_11 = (arg_382_1.time_ - var_385_9) / var_385_10

				if arg_382_1.var_.actorSpriteComps1034 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								local var_385_12 = Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, var_385_11)
								local var_385_13 = Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, var_385_11)
								local var_385_14 = Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, var_385_11)

								iter_385_5.color = Color.New(var_385_12, var_385_13, var_385_14)
							else
								local var_385_15 = Mathf.Lerp(iter_385_5.color.r, 0.5, var_385_11)

								iter_385_5.color = Color.New(var_385_15, var_385_15, var_385_15)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_9 + var_385_10 and arg_382_1.time_ < var_385_9 + var_385_10 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps1034 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_385_7 then
						if arg_382_1.isInRecall_ then
							iter_385_7.color = arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_385_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps1034 = nil
			end

			local var_385_16 = arg_382_1.actors_["10113"].transform
			local var_385_17 = 0

			if var_385_17 < arg_382_1.time_ and arg_382_1.time_ <= var_385_17 + arg_385_0 then
				arg_382_1.var_.moveOldPos10113 = var_385_16.localPosition
				var_385_16.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("10113", 3)

				local var_385_18 = var_385_16.childCount

				for iter_385_8 = 0, var_385_18 - 1 do
					local var_385_19 = var_385_16:GetChild(iter_385_8)

					if var_385_19.name == "split_6" or not string.find(var_385_19.name, "split") then
						var_385_19.gameObject:SetActive(true)
					else
						var_385_19.gameObject:SetActive(false)
					end
				end
			end

			local var_385_20 = 0.001

			if var_385_17 <= arg_382_1.time_ and arg_382_1.time_ < var_385_17 + var_385_20 then
				local var_385_21 = (arg_382_1.time_ - var_385_17) / var_385_20
				local var_385_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_385_16.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos10113, var_385_22, var_385_21)
			end

			if arg_382_1.time_ >= var_385_17 + var_385_20 and arg_382_1.time_ < var_385_17 + var_385_20 + arg_385_0 then
				var_385_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_385_23 = arg_382_1.actors_["1034"].transform
			local var_385_24 = 0

			if var_385_24 < arg_382_1.time_ and arg_382_1.time_ <= var_385_24 + arg_385_0 then
				arg_382_1.var_.moveOldPos1034 = var_385_23.localPosition
				var_385_23.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1034", 7)

				local var_385_25 = var_385_23.childCount

				for iter_385_9 = 0, var_385_25 - 1 do
					local var_385_26 = var_385_23:GetChild(iter_385_9)

					if var_385_26.name == "" or not string.find(var_385_26.name, "split") then
						var_385_26.gameObject:SetActive(true)
					else
						var_385_26.gameObject:SetActive(false)
					end
				end
			end

			local var_385_27 = 0.001

			if var_385_24 <= arg_382_1.time_ and arg_382_1.time_ < var_385_24 + var_385_27 then
				local var_385_28 = (arg_382_1.time_ - var_385_24) / var_385_27
				local var_385_29 = Vector3.New(0, -2000, 0)

				var_385_23.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1034, var_385_29, var_385_28)
			end

			if arg_382_1.time_ >= var_385_24 + var_385_27 and arg_382_1.time_ < var_385_24 + var_385_27 + arg_385_0 then
				var_385_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_385_30 = 0
			local var_385_31 = 0.325

			if var_385_30 < arg_382_1.time_ and arg_382_1.time_ <= var_385_30 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_32 = arg_382_1:FormatText(StoryNameCfg[1117].name)

				arg_382_1.leftNameTxt_.text = var_385_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_33 = arg_382_1:GetWordFromCfg(417041088)
				local var_385_34 = arg_382_1:FormatText(var_385_33.content)

				arg_382_1.text_.text = var_385_34

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_35 = 13
				local var_385_36 = utf8.len(var_385_34)
				local var_385_37 = var_385_35 <= 0 and var_385_31 or var_385_31 * (var_385_36 / var_385_35)

				if var_385_37 > 0 and var_385_31 < var_385_37 then
					arg_382_1.talkMaxDuration = var_385_37

					if var_385_37 + var_385_30 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_37 + var_385_30
					end
				end

				arg_382_1.text_.text = var_385_34
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041088", "story_v_out_417041.awb") ~= 0 then
					local var_385_38 = manager.audio:GetVoiceLength("story_v_out_417041", "417041088", "story_v_out_417041.awb") / 1000

					if var_385_38 + var_385_30 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_38 + var_385_30
					end

					if var_385_33.prefab_name ~= "" and arg_382_1.actors_[var_385_33.prefab_name] ~= nil then
						local var_385_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_33.prefab_name].transform, "story_v_out_417041", "417041088", "story_v_out_417041.awb")

						arg_382_1:RecordAudio("417041088", var_385_39)
						arg_382_1:RecordAudio("417041088", var_385_39)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_417041", "417041088", "story_v_out_417041.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_417041", "417041088", "story_v_out_417041.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_40 = math.max(var_385_31, arg_382_1.talkMaxDuration)

			if var_385_30 <= arg_382_1.time_ and arg_382_1.time_ < var_385_30 + var_385_40 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_30) / var_385_40

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_30 + var_385_40 and arg_382_1.time_ < var_385_30 + var_385_40 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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
	Play417041089 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 417041089
		arg_386_1.duration_ = 8.83

		local var_386_0 = {
			zh = 8.833,
			ja = 8.7
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
				arg_386_0:Play417041090(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 1.125

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[1117].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:GetWordFromCfg(417041089)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041089", "story_v_out_417041.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041089", "story_v_out_417041.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_out_417041", "417041089", "story_v_out_417041.awb")

						arg_386_1:RecordAudio("417041089", var_389_9)
						arg_386_1:RecordAudio("417041089", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_417041", "417041089", "story_v_out_417041.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_417041", "417041089", "story_v_out_417041.awb")
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
	Play417041090 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417041090
		arg_390_1.duration_ = 9.47

		local var_390_0 = {
			zh = 4.9,
			ja = 9.466
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
			arg_390_1.auto_ = false
		end

		function arg_390_1.playNext_(arg_392_0)
			arg_390_1.onStoryFinished_()
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.475

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[1117].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(417041090)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041090", "story_v_out_417041.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041090", "story_v_out_417041.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_417041", "417041090", "story_v_out_417041.awb")

						arg_390_1:RecordAudio("417041090", var_393_9)
						arg_390_1:RecordAudio("417041090", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_417041", "417041090", "story_v_out_417041.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_417041", "417041090", "story_v_out_417041.awb")
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
	assets = {
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a"
	},
	voices = {
		"story_v_out_417041.awb"
	}
}
