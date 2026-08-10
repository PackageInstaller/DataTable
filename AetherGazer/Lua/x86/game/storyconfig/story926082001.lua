return {
	Play926082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926082001
		arg_1_1.duration_ = 5.37

		local var_1_0 = {
			zh = 5.19933333333333,
			ja = 5.36633333333333
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
				arg_1_0:Play926082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I20f"

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
				local var_4_5 = arg_1_1.bgs_.I20f

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
					if iter_4_0 ~= "I20f" then
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

			local var_4_19 = 1.43333333333333

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

			local var_4_24 = "128404"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_["128404"]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_36 = 0.1
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_143", "se_story_143_amb_drone_dark", "")
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

			local var_4_46 = 0.500666666666667
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel")

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

			local var_4_52 = 1.43333333333333
			local var_4_53 = 0.4

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_56 = arg_1_1:GetWordFromCfg(926082001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082001", "story_v_out_926082.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_926082", "926082001", "story_v_out_926082.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_926082", "926082001", "story_v_out_926082.awb")

						arg_1_1:RecordAudio("926082001", var_4_62)
						arg_1_1:RecordAudio("926082001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926082", "926082001", "story_v_out_926082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926082", "926082001", "story_v_out_926082.awb")
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
	Play926082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["128404"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps128404 == nil then
				arg_9_1.var_.actorSpriteComps128404 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps128404 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps128404 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps128404 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.75

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(926082002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 30
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_9 or var_12_9 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_9 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_15 and arg_9_1.time_ < var_12_8 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play926082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926082003
		arg_13_1.duration_ = 7.67

		local var_13_0 = {
			zh = 6.3,
			ja = 7.666
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play926082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.725

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(926082003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082003", "story_v_out_926082.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082003", "story_v_out_926082.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_926082", "926082003", "story_v_out_926082.awb")

						arg_13_1:RecordAudio("926082003", var_16_9)
						arg_13_1:RecordAudio("926082003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926082", "926082003", "story_v_out_926082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926082", "926082003", "story_v_out_926082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926082004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				local var_18_0 = iter_18_0 <= 1

				SetActive(iter_18_1.go, var_18_0)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1331].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926082005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(926082004, 1331)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["128404"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926082005
		arg_21_1.duration_ = 10.3

		local var_21_0 = {
			zh = 7.666,
			ja = 10.3
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
				arg_21_0:Play926082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["128404"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps128404 == nil then
				arg_21_1.var_.actorSpriteComps128404 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps128404 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps128404 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_8 = arg_21_1.actors_["128404"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 3)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "split_6" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(-16.1, -362, -375)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_24_15 = 0
			local var_24_16 = 0.875

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(926082005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 35
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082005", "story_v_out_926082.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082005", "story_v_out_926082.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_926082", "926082005", "story_v_out_926082.awb")

						arg_21_1:RecordAudio("926082005", var_24_24)
						arg_21_1:RecordAudio("926082005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926082", "926082005", "story_v_out_926082.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926082", "926082005", "story_v_out_926082.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play926082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926082006
		arg_25_1.duration_ = 7.7

		local var_25_0 = {
			zh = 6.2,
			ja = 7.7
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
				arg_25_0:Play926082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.85

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(926082006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082006", "story_v_out_926082.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082006", "story_v_out_926082.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_926082", "926082006", "story_v_out_926082.awb")

						arg_25_1:RecordAudio("926082006", var_28_9)
						arg_25_1:RecordAudio("926082006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926082", "926082006", "story_v_out_926082.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926082", "926082006", "story_v_out_926082.awb")
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
	Play926082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926082007
		arg_29_1.duration_ = 8.03

		local var_29_0 = {
			zh = 6.5,
			ja = 8.033
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
				arg_29_0:Play926082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.775

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(926082007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082007", "story_v_out_926082.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082007", "story_v_out_926082.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_926082", "926082007", "story_v_out_926082.awb")

						arg_29_1:RecordAudio("926082007", var_32_9)
						arg_29_1:RecordAudio("926082007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926082", "926082007", "story_v_out_926082.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926082", "926082007", "story_v_out_926082.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play926082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926082008
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"

			SetActive(arg_33_1.choicesGo_, true)

			for iter_34_0, iter_34_1 in ipairs(arg_33_1.choices_) do
				local var_34_0 = iter_34_0 <= 2

				SetActive(iter_34_1.go, var_34_0)
			end

			arg_33_1.choices_[1].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1332].name)
			arg_33_1.choices_[2].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1333].name)
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926082009(arg_33_1)
			end

			if arg_35_0 == 2 then
				arg_33_0:Play926082009(arg_33_1)
			end

			arg_33_1:RecordChoiceLog(926082008, 1332, 1333)
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["128404"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926082009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			zh = 3.033,
			ja = 3.533
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
				arg_37_0:Play926082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["128404"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps128404 == nil then
				arg_37_1.var_.actorSpriteComps128404 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps128404 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 1, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps128404 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps128404 = nil
			end

			local var_40_8 = arg_37_1.actors_["128404"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos128404 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("128404", 3)

				local var_40_10 = var_40_8.childCount

				for iter_40_4 = 0, var_40_10 - 1 do
					local var_40_11 = var_40_8:GetChild(iter_40_4)

					if var_40_11.name == "" or not string.find(var_40_11.name, "split") then
						var_40_11.gameObject:SetActive(true)
					else
						var_40_11.gameObject:SetActive(false)
					end
				end
			end

			local var_40_12 = 0.001

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_9) / var_40_12
				local var_40_14 = Vector3.New(-16.1, -362, -375)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos128404, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_40_15 = 0
			local var_40_16 = 0.375

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(926082009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 15
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082009", "story_v_out_926082.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082009", "story_v_out_926082.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_926082", "926082009", "story_v_out_926082.awb")

						arg_37_1:RecordAudio("926082009", var_40_24)
						arg_37_1:RecordAudio("926082009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926082", "926082009", "story_v_out_926082.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926082", "926082009", "story_v_out_926082.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play926082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926082010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play926082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["128404"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps128404 == nil then
				arg_41_1.var_.actorSpriteComps128404 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps128404 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps128404 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps128404 = nil
			end

			local var_44_8 = arg_41_1.actors_["128404"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos128404 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("128404", 7)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(0, -2000, 0)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos128404, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_15 = 0
			local var_44_16 = 0.375

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(926082010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 15
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_16 or var_44_16 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_16 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_22 and arg_41_1.time_ < var_44_15 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play926082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926082011
		arg_45_1.duration_ = 8.17

		local var_45_0 = {
			zh = 6.766,
			ja = 8.166
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
				arg_45_0:Play926082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["128404"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end

			local var_48_8 = arg_45_1.actors_["128404"].transform
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.var_.moveOldPos128404 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("128404", 3)

				local var_48_10 = var_48_8.childCount

				for iter_48_4 = 0, var_48_10 - 1 do
					local var_48_11 = var_48_8:GetChild(iter_48_4)

					if var_48_11.name == "split_4" or not string.find(var_48_11.name, "split") then
						var_48_11.gameObject:SetActive(true)
					else
						var_48_11.gameObject:SetActive(false)
					end
				end
			end

			local var_48_12 = 0.001

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_9) / var_48_12
				local var_48_14 = Vector3.New(-16.1, -362, -375)

				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos128404, var_48_14, var_48_13)
			end

			if arg_45_1.time_ >= var_48_9 + var_48_12 and arg_45_1.time_ < var_48_9 + var_48_12 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_48_15 = 0
			local var_48_16 = 0.625

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(926082011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 25
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082011", "story_v_out_926082.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082011", "story_v_out_926082.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_926082", "926082011", "story_v_out_926082.awb")

						arg_45_1:RecordAudio("926082011", var_48_24)
						arg_45_1:RecordAudio("926082011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926082", "926082011", "story_v_out_926082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926082", "926082011", "story_v_out_926082.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play926082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926082012
		arg_49_1.duration_ = 6.37

		local var_49_0 = {
			zh = 3.866,
			ja = 6.366
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
				arg_49_0:Play926082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.475

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(926082012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 19
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082012", "story_v_out_926082.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082012", "story_v_out_926082.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_926082", "926082012", "story_v_out_926082.awb")

						arg_49_1:RecordAudio("926082012", var_52_9)
						arg_49_1:RecordAudio("926082012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926082", "926082012", "story_v_out_926082.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926082", "926082012", "story_v_out_926082.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play926082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926082013
		arg_53_1.duration_ = 3.13

		local var_53_0 = {
			zh = 2.333,
			ja = 3.133
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
				arg_53_0:Play926082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["128404"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos128404 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("128404", 3)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(-16.1, -362, -375)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos128404, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_56_7 = 0
			local var_56_8 = 0.3

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_9 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(926082013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 12
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_8 or var_56_8 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_8 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082013", "story_v_out_926082.awb") ~= 0 then
					local var_56_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082013", "story_v_out_926082.awb") / 1000

					if var_56_15 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_7
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_926082", "926082013", "story_v_out_926082.awb")

						arg_53_1:RecordAudio("926082013", var_56_16)
						arg_53_1:RecordAudio("926082013", var_56_16)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926082", "926082013", "story_v_out_926082.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926082", "926082013", "story_v_out_926082.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_17 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_17 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_7) / var_56_17

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_7 + var_56_17 and arg_53_1.time_ < var_56_7 + var_56_17 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play926082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926082014
		arg_57_1.duration_ = 8.1

		local var_57_0 = {
			zh = 7.43333333333333,
			ja = 8.09933333333333
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
				arg_57_0:Play926082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "10144"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(var_60_1, arg_57_1.canvasGo_.transform)

					var_60_2.transform:SetSiblingIndex(1)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs(var_60_3) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_4 = arg_57_1.actors_["10144"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.actorSpriteComps10144 == nil then
				arg_57_1.var_.actorSpriteComps10144 = var_60_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 0.2

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.actorSpriteComps10144 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								local var_60_8 = Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, var_60_7)
								local var_60_9 = Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, var_60_7)
								local var_60_10 = Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, var_60_7)

								iter_60_3.color = Color.New(var_60_8, var_60_9, var_60_10)
							else
								local var_60_11 = Mathf.Lerp(iter_60_3.color.r, 1, var_60_7)

								iter_60_3.color = Color.New(var_60_11, var_60_11, var_60_11)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.actorSpriteComps10144 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_60_5 then
						if arg_57_1.isInRecall_ then
							iter_60_5.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10144 = nil
			end

			local var_60_12 = arg_57_1.actors_["128404"]
			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 and not isNil(var_60_12) and arg_57_1.var_.actorSpriteComps128404 == nil then
				arg_57_1.var_.actorSpriteComps128404 = var_60_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_14 = 0.2

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_14 and not isNil(var_60_12) then
				local var_60_15 = (arg_57_1.time_ - var_60_13) / var_60_14

				if arg_57_1.var_.actorSpriteComps128404 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								local var_60_16 = Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, var_60_15)
								local var_60_17 = Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, var_60_15)
								local var_60_18 = Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, var_60_15)

								iter_60_7.color = Color.New(var_60_16, var_60_17, var_60_18)
							else
								local var_60_19 = Mathf.Lerp(iter_60_7.color.r, 0.5, var_60_15)

								iter_60_7.color = Color.New(var_60_19, var_60_19, var_60_19)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_13 + var_60_14 and arg_57_1.time_ < var_60_13 + var_60_14 + arg_60_0 and not isNil(var_60_12) and arg_57_1.var_.actorSpriteComps128404 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps128404 = nil
			end

			local var_60_20 = arg_57_1.actors_["128404"].transform
			local var_60_21 = 0

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.var_.moveOldPos128404 = var_60_20.localPosition
				var_60_20.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("128404", 7)

				local var_60_22 = var_60_20.childCount

				for iter_60_10 = 0, var_60_22 - 1 do
					local var_60_23 = var_60_20:GetChild(iter_60_10)

					if var_60_23.name == "" or not string.find(var_60_23.name, "split") then
						var_60_23.gameObject:SetActive(true)
					else
						var_60_23.gameObject:SetActive(false)
					end
				end
			end

			local var_60_24 = 0.001

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_24 then
				local var_60_25 = (arg_57_1.time_ - var_60_21) / var_60_24
				local var_60_26 = Vector3.New(0, -2000, 0)

				var_60_20.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos128404, var_60_26, var_60_25)
			end

			if arg_57_1.time_ >= var_60_21 + var_60_24 and arg_57_1.time_ < var_60_21 + var_60_24 + arg_60_0 then
				var_60_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_27 = "story_item_22201"

			if arg_57_1.actors_[var_60_27] == nil then
				local var_60_28 = Object.Instantiate(arg_57_1.imageGo_, arg_57_1.canvasGo_.transform)

				var_60_28.transform:SetSiblingIndex(1)

				var_60_28.name = var_60_27

				local var_60_29 = var_60_28:GetComponent(typeof(Image))

				var_60_29.sprite = getSpriteWithoutAtlas("TextureConfig/UIStoryImages/story_item_22201")

				var_60_29:SetNativeSize()

				var_60_28.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_57_1.actors_[var_60_27] = var_60_28
			end

			local var_60_30 = arg_57_1.actors_.story_item_22201.transform
			local var_60_31 = 0

			if var_60_31 < arg_57_1.time_ and arg_57_1.time_ <= var_60_31 + arg_60_0 then
				arg_57_1.var_.moveOldPosstory_item_22201 = var_60_30.localPosition
				var_60_30.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("story_item_22201", 3)
			end

			local var_60_32 = 0.8

			if var_60_31 <= arg_57_1.time_ and arg_57_1.time_ < var_60_31 + var_60_32 then
				local var_60_33 = (arg_57_1.time_ - var_60_31) / var_60_32
				local var_60_34 = Vector3.New(0, 0, 0)

				var_60_30.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosstory_item_22201, var_60_34, var_60_33)
			end

			if arg_57_1.time_ >= var_60_31 + var_60_32 and arg_57_1.time_ < var_60_31 + var_60_32 + arg_60_0 then
				var_60_30.localPosition = Vector3.New(0, 0, 0)
			end

			local var_60_35 = 0
			local var_60_36 = 1

			if var_60_35 < arg_57_1.time_ and arg_57_1.time_ <= var_60_35 + arg_60_0 then
				local var_60_37 = "play"
				local var_60_38 = "effect"

				arg_57_1:AudioAction(var_60_37, var_60_38, "se_story_143", "se_story_143_bell", "")
			end

			local var_60_39 = 0

			if var_60_39 < arg_57_1.time_ and arg_57_1.time_ <= var_60_39 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_40 = 1.38333333333333

			if arg_57_1.time_ >= var_60_39 + var_60_40 and arg_57_1.time_ < var_60_39 + var_60_40 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_41 = 1.23333333333333
			local var_60_42 = 0.55

			if var_60_41 < arg_57_1.time_ and arg_57_1.time_ <= var_60_41 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_43 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_43:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_44 = arg_57_1:FormatText(StoryNameCfg[1297].name)

				arg_57_1.leftNameTxt_.text = var_60_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_45 = arg_57_1:GetWordFromCfg(926082014)
				local var_60_46 = arg_57_1:FormatText(var_60_45.content)

				arg_57_1.text_.text = var_60_46

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_47 = 22
				local var_60_48 = utf8.len(var_60_46)
				local var_60_49 = var_60_47 <= 0 and var_60_42 or var_60_42 * (var_60_48 / var_60_47)

				if var_60_49 > 0 and var_60_42 < var_60_49 then
					arg_57_1.talkMaxDuration = var_60_49
					var_60_41 = var_60_41 + 0.3

					if var_60_49 + var_60_41 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_49 + var_60_41
					end
				end

				arg_57_1.text_.text = var_60_46
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082014", "story_v_out_926082.awb") ~= 0 then
					local var_60_50 = manager.audio:GetVoiceLength("story_v_out_926082", "926082014", "story_v_out_926082.awb") / 1000

					if var_60_50 + var_60_41 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_50 + var_60_41
					end

					if var_60_45.prefab_name ~= "" and arg_57_1.actors_[var_60_45.prefab_name] ~= nil then
						local var_60_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_45.prefab_name].transform, "story_v_out_926082", "926082014", "story_v_out_926082.awb")

						arg_57_1:RecordAudio("926082014", var_60_51)
						arg_57_1:RecordAudio("926082014", var_60_51)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_926082", "926082014", "story_v_out_926082.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_926082", "926082014", "story_v_out_926082.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_52 = var_60_41 + 0.3
			local var_60_53 = math.max(var_60_42, arg_57_1.talkMaxDuration)

			if var_60_52 <= arg_57_1.time_ and arg_57_1.time_ < var_60_52 + var_60_53 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_52) / var_60_53

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_52 + var_60_53 and arg_57_1.time_ < var_60_52 + var_60_53 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				needEase = true,
				actorName = "story_item_22201",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 0),
					endPos = Vector3.New(0, 0, 0),
					easeType = LeanTweenType.easeInQuint
				}
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play926082015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 926082015
		arg_63_1.duration_ = 5.9

		local var_63_0 = {
			zh = 5.833,
			ja = 5.9
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
				arg_63_0:Play926082016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["128404"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps128404 == nil then
				arg_63_1.var_.actorSpriteComps128404 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps128404 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps128404 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps128404 = nil
			end

			local var_66_8 = arg_63_1.actors_["10144"]
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10144 == nil then
				arg_63_1.var_.actorSpriteComps10144 = var_66_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_10 = 0.2

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 and not isNil(var_66_8) then
				local var_66_11 = (arg_63_1.time_ - var_66_9) / var_66_10

				if arg_63_1.var_.actorSpriteComps10144 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								local var_66_12 = Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, var_66_11)
								local var_66_13 = Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, var_66_11)
								local var_66_14 = Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, var_66_11)

								iter_66_5.color = Color.New(var_66_12, var_66_13, var_66_14)
							else
								local var_66_15 = Mathf.Lerp(iter_66_5.color.r, 0.5, var_66_11)

								iter_66_5.color = Color.New(var_66_15, var_66_15, var_66_15)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10144 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_66_7 then
						if arg_63_1.isInRecall_ then
							iter_66_7.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10144 = nil
			end

			local var_66_16 = 0
			local var_66_17 = 0.575

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_18 = arg_63_1:FormatText(StoryNameCfg[6].name)

				arg_63_1.leftNameTxt_.text = var_66_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_19 = arg_63_1:GetWordFromCfg(926082015)
				local var_66_20 = arg_63_1:FormatText(var_66_19.content)

				arg_63_1.text_.text = var_66_20

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 23
				local var_66_22 = utf8.len(var_66_20)
				local var_66_23 = var_66_21 <= 0 and var_66_17 or var_66_17 * (var_66_22 / var_66_21)

				if var_66_23 > 0 and var_66_17 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23

					if var_66_23 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_20
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082015", "story_v_out_926082.awb") ~= 0 then
					local var_66_24 = manager.audio:GetVoiceLength("story_v_out_926082", "926082015", "story_v_out_926082.awb") / 1000

					if var_66_24 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_24 + var_66_16
					end

					if var_66_19.prefab_name ~= "" and arg_63_1.actors_[var_66_19.prefab_name] ~= nil then
						local var_66_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_19.prefab_name].transform, "story_v_out_926082", "926082015", "story_v_out_926082.awb")

						arg_63_1:RecordAudio("926082015", var_66_25)
						arg_63_1:RecordAudio("926082015", var_66_25)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_926082", "926082015", "story_v_out_926082.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_926082", "926082015", "story_v_out_926082.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_26 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_26

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_26 and arg_63_1.time_ < var_66_16 + var_66_26 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play926082016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 926082016
		arg_67_1.duration_ = 6.77

		local var_67_0 = {
			zh = 6.666,
			ja = 6.766
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
				arg_67_0:Play926082017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.8

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[6].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(926082016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082016", "story_v_out_926082.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082016", "story_v_out_926082.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_926082", "926082016", "story_v_out_926082.awb")

						arg_67_1:RecordAudio("926082016", var_70_9)
						arg_67_1:RecordAudio("926082016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_926082", "926082016", "story_v_out_926082.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_926082", "926082016", "story_v_out_926082.awb")
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
	Play926082017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 926082017
		arg_71_1.duration_ = 11.77

		local var_71_0 = {
			zh = 8.933,
			ja = 11.766
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
				arg_71_0:Play926082018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.05

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(926082017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082017", "story_v_out_926082.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082017", "story_v_out_926082.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_926082", "926082017", "story_v_out_926082.awb")

						arg_71_1:RecordAudio("926082017", var_74_9)
						arg_71_1:RecordAudio("926082017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_926082", "926082017", "story_v_out_926082.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_926082", "926082017", "story_v_out_926082.awb")
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
	Play926082018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 926082018
		arg_75_1.duration_ = 5.9

		local var_75_0 = {
			zh = 5.3,
			ja = 5.9
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
				arg_75_0:Play926082019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["128404"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos128404 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("128404", 7)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "split_6" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(0, -2000, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos128404, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_7 = 0
			local var_78_8 = 0.675

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_9 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_10 = arg_75_1:GetWordFromCfg(926082018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 27
				local var_78_13 = utf8.len(var_78_11)
				local var_78_14 = var_78_12 <= 0 and var_78_8 or var_78_8 * (var_78_13 / var_78_12)

				if var_78_14 > 0 and var_78_8 < var_78_14 then
					arg_75_1.talkMaxDuration = var_78_14

					if var_78_14 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_7
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082018", "story_v_out_926082.awb") ~= 0 then
					local var_78_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082018", "story_v_out_926082.awb") / 1000

					if var_78_15 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_15 + var_78_7
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_926082", "926082018", "story_v_out_926082.awb")

						arg_75_1:RecordAudio("926082018", var_78_16)
						arg_75_1:RecordAudio("926082018", var_78_16)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_926082", "926082018", "story_v_out_926082.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_926082", "926082018", "story_v_out_926082.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_17 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_17 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_7) / var_78_17

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_7 + var_78_17 and arg_75_1.time_ < var_78_7 + var_78_17 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play926082019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 926082019
		arg_79_1.duration_ = 6.13

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play926082020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["128404"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps128404 == nil then
				arg_79_1.var_.actorSpriteComps128404 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps128404 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps128404 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps128404 = nil
			end

			local var_82_8 = arg_79_1.actors_.story_item_22201.transform
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.var_.moveOldPosstory_item_22201 = var_82_8.localPosition
				var_82_8.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("story_item_22201", 7)
			end

			local var_82_10 = 0.766666666666667

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = (arg_79_1.time_ - var_82_9) / var_82_10
				local var_82_12 = Vector3.New(0, 0, 0)

				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPosstory_item_22201, var_82_12, var_82_11)
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, 0, 0)
			end

			local var_82_13 = arg_79_1.actors_.story_item_22201.transform
			local var_82_14 = 0.766666666666667

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.var_.moveOldPosstory_item_22201 = var_82_13.localPosition
				var_82_13.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("story_item_22201", 7)
			end

			local var_82_15 = 0.1

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_15 then
				local var_82_16 = (arg_79_1.time_ - var_82_14) / var_82_15
				local var_82_17 = Vector3.New(0, -2000, 0)

				var_82_13.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPosstory_item_22201, var_82_17, var_82_16)
			end

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 then
				var_82_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_18 = 0

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_19 = 1.93333333333333

			if arg_79_1.time_ >= var_82_18 + var_82_19 and arg_79_1.time_ < var_82_18 + var_82_19 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_20 = 1.13333333333333
			local var_82_21 = 0.525

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_22 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_22:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_23 = arg_79_1:GetWordFromCfg(926082019)
				local var_82_24 = arg_79_1:FormatText(var_82_23.content)

				arg_79_1.text_.text = var_82_24

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 21
				local var_82_26 = utf8.len(var_82_24)
				local var_82_27 = var_82_25 <= 0 and var_82_21 or var_82_21 * (var_82_26 / var_82_25)

				if var_82_27 > 0 and var_82_21 < var_82_27 then
					arg_79_1.talkMaxDuration = var_82_27
					var_82_20 = var_82_20 + 0.3

					if var_82_27 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_27 + var_82_20
					end
				end

				arg_79_1.text_.text = var_82_24
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_28 = var_82_20 + 0.3
			local var_82_29 = math.max(var_82_21, arg_79_1.talkMaxDuration)

			if var_82_28 <= arg_79_1.time_ and arg_79_1.time_ < var_82_28 + var_82_29 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_28) / var_82_29

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_28 + var_82_29 and arg_79_1.time_ < var_82_28 + var_82_29 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				needEase = true,
				actorName = "story_item_22201",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.766666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(0, 0, 0),
					endPos = Vector3.New(0, 0, 0),
					easeType = LeanTweenType.easeInQuint
				}
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				actorName = "story_item_22201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play926082020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926082020
		arg_85_1.duration_ = 2.53

		local var_85_0 = {
			zh = 1.66633333333333,
			ja = 2.53333333333333
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
				arg_85_0:Play926082021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["128404"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps128404 == nil then
				arg_85_1.var_.actorSpriteComps128404 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps128404 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps128404 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps128404 = nil
			end

			local var_88_8 = manager.ui.mainCamera.transform
			local var_88_9 = 0.0666666666666667

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				local var_88_10 = arg_85_1.var_.effect9009
				local var_88_11
				local var_88_12 = var_88_8

				if not var_88_10 then
					var_88_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_lightmoment"), var_88_12)
					var_88_10.name = "9009"
					arg_85_1.var_.effect9009 = var_88_10
				else
					var_88_10.transform:SetParent(var_88_12)
				end

				var_88_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_14 = 1.26666666666667

			if arg_85_1.time_ >= var_88_13 + var_88_14 and arg_85_1.time_ < var_88_13 + var_88_14 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_15 = 0.0666666666666667
			local var_88_16 = 1

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				local var_88_17 = "play"
				local var_88_18 = "effect"

				arg_85_1:AudioAction(var_88_17, var_88_18, "se_story_143", "se_story_143_bell02", "")
			end

			local var_88_19 = arg_85_1.actors_["128404"].transform
			local var_88_20 = 0

			if var_88_20 < arg_85_1.time_ and arg_85_1.time_ <= var_88_20 + arg_88_0 then
				arg_85_1.var_.moveOldPos128404 = var_88_19.localPosition
				var_88_19.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("128404", 3)

				local var_88_21 = var_88_19.childCount

				for iter_88_4 = 0, var_88_21 - 1 do
					local var_88_22 = var_88_19:GetChild(iter_88_4)

					if var_88_22.name == "split_5" or not string.find(var_88_22.name, "split") then
						var_88_22.gameObject:SetActive(true)
					else
						var_88_22.gameObject:SetActive(false)
					end
				end
			end

			local var_88_23 = 0.1

			if var_88_20 <= arg_85_1.time_ and arg_85_1.time_ < var_88_20 + var_88_23 then
				local var_88_24 = (arg_85_1.time_ - var_88_20) / var_88_23
				local var_88_25 = Vector3.New(-16.1, -362, -375)

				var_88_19.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos128404, var_88_25, var_88_24)
			end

			if arg_85_1.time_ >= var_88_20 + var_88_23 and arg_85_1.time_ < var_88_20 + var_88_23 + arg_88_0 then
				var_88_19.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_26 = 0.533333333333333
			local var_88_27 = 0.1

			if var_88_26 < arg_85_1.time_ and arg_85_1.time_ <= var_88_26 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_28 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_28:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_29 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_30 = arg_85_1:GetWordFromCfg(926082020)
				local var_88_31 = arg_85_1:FormatText(var_88_30.content)

				arg_85_1.text_.text = var_88_31

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_32 = 3
				local var_88_33 = utf8.len(var_88_31)
				local var_88_34 = var_88_32 <= 0 and var_88_27 or var_88_27 * (var_88_33 / var_88_32)

				if var_88_34 > 0 and var_88_27 < var_88_34 then
					arg_85_1.talkMaxDuration = var_88_34
					var_88_26 = var_88_26 + 0.3

					if var_88_34 + var_88_26 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_34 + var_88_26
					end
				end

				arg_85_1.text_.text = var_88_31
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082020", "story_v_out_926082.awb") ~= 0 then
					local var_88_35 = manager.audio:GetVoiceLength("story_v_out_926082", "926082020", "story_v_out_926082.awb") / 1000

					if var_88_35 + var_88_26 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_35 + var_88_26
					end

					if var_88_30.prefab_name ~= "" and arg_85_1.actors_[var_88_30.prefab_name] ~= nil then
						local var_88_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_30.prefab_name].transform, "story_v_out_926082", "926082020", "story_v_out_926082.awb")

						arg_85_1:RecordAudio("926082020", var_88_36)
						arg_85_1:RecordAudio("926082020", var_88_36)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926082", "926082020", "story_v_out_926082.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926082", "926082020", "story_v_out_926082.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_37 = var_88_26 + 0.3
			local var_88_38 = math.max(var_88_27, arg_85_1.talkMaxDuration)

			if var_88_37 <= arg_85_1.time_ and arg_85_1.time_ < var_88_37 + var_88_38 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_37) / var_88_38

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_37 + var_88_38 and arg_85_1.time_ < var_88_37 + var_88_38 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play926082021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 926082021
		arg_91_1.duration_ = 8.07

		local var_91_0 = {
			zh = 8.066,
			ja = 7.166
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
				arg_91_0:Play926082022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.775

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[6].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(926082021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082021", "story_v_out_926082.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082021", "story_v_out_926082.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_926082", "926082021", "story_v_out_926082.awb")

						arg_91_1:RecordAudio("926082021", var_94_9)
						arg_91_1:RecordAudio("926082021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_926082", "926082021", "story_v_out_926082.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_926082", "926082021", "story_v_out_926082.awb")
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
	Play926082022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 926082022
		arg_95_1.duration_ = 11.67

		local var_95_0 = {
			zh = 8.333,
			ja = 11.666
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play926082023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.925

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[6].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(926082022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 37
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082022", "story_v_out_926082.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082022", "story_v_out_926082.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_926082", "926082022", "story_v_out_926082.awb")

						arg_95_1:RecordAudio("926082022", var_98_9)
						arg_95_1:RecordAudio("926082022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_926082", "926082022", "story_v_out_926082.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_926082", "926082022", "story_v_out_926082.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play926082023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 926082023
		arg_99_1.duration_ = 10.2

		local var_99_0 = {
			zh = 7.6,
			ja = 10.2
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
				arg_99_0:Play926082024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.95

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[6].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(926082023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082023", "story_v_out_926082.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082023", "story_v_out_926082.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_926082", "926082023", "story_v_out_926082.awb")

						arg_99_1:RecordAudio("926082023", var_102_9)
						arg_99_1:RecordAudio("926082023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_926082", "926082023", "story_v_out_926082.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_926082", "926082023", "story_v_out_926082.awb")
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
	Play926082024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 926082024
		arg_103_1.duration_ = 9.63

		local var_103_0 = {
			zh = 9.633,
			ja = 7.2
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play926082025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.125

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[6].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(926082024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 45
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082024", "story_v_out_926082.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082024", "story_v_out_926082.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_926082", "926082024", "story_v_out_926082.awb")

						arg_103_1:RecordAudio("926082024", var_106_9)
						arg_103_1:RecordAudio("926082024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_926082", "926082024", "story_v_out_926082.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_926082", "926082024", "story_v_out_926082.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play926082025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 926082025
		arg_107_1.duration_ = 11.3

		local var_107_0 = {
			zh = 8.5,
			ja = 11.3
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play926082026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.95

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(926082025)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 38
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082025", "story_v_out_926082.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082025", "story_v_out_926082.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_926082", "926082025", "story_v_out_926082.awb")

						arg_107_1:RecordAudio("926082025", var_110_9)
						arg_107_1:RecordAudio("926082025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_926082", "926082025", "story_v_out_926082.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_926082", "926082025", "story_v_out_926082.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play926082026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 926082026
		arg_111_1.duration_ = 4.5

		local var_111_0 = {
			zh = 3.9,
			ja = 4.5
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
				arg_111_0:Play926082027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["128404"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "split_2" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.533333333333333

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(-289.9, -356, -623.82)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-289.9, -356, -623.82)
			end

			local var_114_7 = arg_111_1.actors_["128404"].transform
			local var_114_8 = 0.533333333333333

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = var_114_7.localPosition
				var_114_7.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				local var_114_9 = var_114_7.childCount

				for iter_114_1 = 0, var_114_9 - 1 do
					local var_114_10 = var_114_7:GetChild(iter_114_1)

					if var_114_10.name == "split_2" or not string.find(var_114_10.name, "split") then
						var_114_10.gameObject:SetActive(true)
					else
						var_114_10.gameObject:SetActive(false)
					end
				end
			end

			local var_114_11 = 0.833333333333333

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_11 then
				local var_114_12 = (arg_111_1.time_ - var_114_8) / var_114_11
				local var_114_13 = Vector3.New(289.4, -356, -623.82)

				var_114_7.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, var_114_13, var_114_12)
			end

			if arg_111_1.time_ >= var_114_8 + var_114_11 and arg_111_1.time_ < var_114_8 + var_114_11 + arg_114_0 then
				var_114_7.localPosition = Vector3.New(289.4, -356, -623.82)
			end

			local var_114_14 = arg_111_1.actors_["128404"].transform
			local var_114_15 = 1.36666666666667

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = var_114_14.localPosition
				var_114_14.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				local var_114_16 = var_114_14.childCount

				for iter_114_2 = 0, var_114_16 - 1 do
					local var_114_17 = var_114_14:GetChild(iter_114_2)

					if var_114_17.name == "split_2" or not string.find(var_114_17.name, "split") then
						var_114_17.gameObject:SetActive(true)
					else
						var_114_17.gameObject:SetActive(false)
					end
				end
			end

			local var_114_18 = 0.666666666665333

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_18 then
				local var_114_19 = (arg_111_1.time_ - var_114_15) / var_114_18
				local var_114_20 = Vector3.New(-29.4, -356, -623.82)

				var_114_14.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, var_114_20, var_114_19)
			end

			if arg_111_1.time_ >= var_114_15 + var_114_18 and arg_111_1.time_ < var_114_15 + var_114_18 + arg_114_0 then
				var_114_14.localPosition = Vector3.New(-29.4, -356, -623.82)
			end

			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_22 = 2.16666666666667

			if arg_111_1.time_ >= var_114_21 + var_114_22 and arg_111_1.time_ < var_114_21 + var_114_22 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_23 = 0
			local var_114_24 = 0.275

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_25 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_26 = arg_111_1:GetWordFromCfg(926082026)
				local var_114_27 = arg_111_1:FormatText(var_114_26.content)

				arg_111_1.text_.text = var_114_27

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_28 = 11
				local var_114_29 = utf8.len(var_114_27)
				local var_114_30 = var_114_28 <= 0 and var_114_24 or var_114_24 * (var_114_29 / var_114_28)

				if var_114_30 > 0 and var_114_24 < var_114_30 then
					arg_111_1.talkMaxDuration = var_114_30

					if var_114_30 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_23
					end
				end

				arg_111_1.text_.text = var_114_27
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082026", "story_v_out_926082.awb") ~= 0 then
					local var_114_31 = manager.audio:GetVoiceLength("story_v_out_926082", "926082026", "story_v_out_926082.awb") / 1000

					if var_114_31 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_31 + var_114_23
					end

					if var_114_26.prefab_name ~= "" and arg_111_1.actors_[var_114_26.prefab_name] ~= nil then
						local var_114_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_26.prefab_name].transform, "story_v_out_926082", "926082026", "story_v_out_926082.awb")

						arg_111_1:RecordAudio("926082026", var_114_32)
						arg_111_1:RecordAudio("926082026", var_114_32)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_926082", "926082026", "story_v_out_926082.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_926082", "926082026", "story_v_out_926082.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_33 = math.max(var_114_24, arg_111_1.talkMaxDuration)

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_33 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_23) / var_114_33

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_23 + var_114_33 and arg_111_1.time_ < var_114_23 + var_114_33 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-29.4, -356, -623.82),
					endPos = Vector3.New(-289.9, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.833333333333333,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-289.9, -356, -623.82),
					endPos = Vector3.New(289.4, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.666666666665333,
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(289.4, -356, -623.82),
					endPos = Vector3.New(-29.4, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play926082027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 926082027
		arg_115_1.duration_ = 9.83

		local var_115_0 = {
			zh = 9.266,
			ja = 9.833
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
				arg_115_0:Play926082028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.125

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[6].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(926082027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 45
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082027", "story_v_out_926082.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082027", "story_v_out_926082.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_926082", "926082027", "story_v_out_926082.awb")

						arg_115_1:RecordAudio("926082027", var_118_9)
						arg_115_1:RecordAudio("926082027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_926082", "926082027", "story_v_out_926082.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_926082", "926082027", "story_v_out_926082.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play926082028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 926082028
		arg_119_1.duration_ = 6.47

		local var_119_0 = {
			zh = 6.466,
			ja = 5.566
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
				arg_119_0:Play926082029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["128404"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos128404 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("128404", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_5" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(-29.4, -356, -632.82)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos128404, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-29.4, -356, -632.82)
			end

			local var_122_7 = 0
			local var_122_8 = 0.5

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_9 = arg_119_1:FormatText(StoryNameCfg[6].name)

				arg_119_1.leftNameTxt_.text = var_122_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(926082028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_12 = 20
				local var_122_13 = utf8.len(var_122_11)
				local var_122_14 = var_122_12 <= 0 and var_122_8 or var_122_8 * (var_122_13 / var_122_12)

				if var_122_14 > 0 and var_122_8 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14

					if var_122_14 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082028", "story_v_out_926082.awb") ~= 0 then
					local var_122_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082028", "story_v_out_926082.awb") / 1000

					if var_122_15 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_7
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_926082", "926082028", "story_v_out_926082.awb")

						arg_119_1:RecordAudio("926082028", var_122_16)
						arg_119_1:RecordAudio("926082028", var_122_16)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_926082", "926082028", "story_v_out_926082.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_926082", "926082028", "story_v_out_926082.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_17 and arg_119_1.time_ < var_122_7 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play926082029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 926082029
		arg_123_1.duration_ = 8.07

		local var_123_0 = {
			zh = 5.5,
			ja = 8.066
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
				arg_123_0:Play926082030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["128404"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos128404 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("128404", 3)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "split_4" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(-29.4, -356, -632.82)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos128404, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-29.4, -356, -632.82)
			end

			local var_126_7 = 0
			local var_126_8 = 0.625

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_9 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(926082029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 25
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_8 or var_126_8 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_8 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082029", "story_v_out_926082.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082029", "story_v_out_926082.awb") / 1000

					if var_126_15 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_7
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_926082", "926082029", "story_v_out_926082.awb")

						arg_123_1:RecordAudio("926082029", var_126_16)
						arg_123_1:RecordAudio("926082029", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_926082", "926082029", "story_v_out_926082.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_926082", "926082029", "story_v_out_926082.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_17 and arg_123_1.time_ < var_126_7 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play926082030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 926082030
		arg_127_1.duration_ = 8.07

		local var_127_0 = {
			zh = 7.366,
			ja = 8.066
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
				arg_127_0:Play926082031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10144"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10144 == nil then
				arg_127_1.var_.actorSpriteComps10144 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10144 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10144 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10144 = nil
			end

			local var_130_8 = arg_127_1.actors_["128404"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps128404 == nil then
				arg_127_1.var_.actorSpriteComps128404 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 0.2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps128404 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								local var_130_12 = Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, var_130_11)
								local var_130_13 = Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, var_130_11)
								local var_130_14 = Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, var_130_11)

								iter_130_5.color = Color.New(var_130_12, var_130_13, var_130_14)
							else
								local var_130_15 = Mathf.Lerp(iter_130_5.color.r, 0.5, var_130_11)

								iter_130_5.color = Color.New(var_130_15, var_130_15, var_130_15)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps128404 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps128404 = nil
			end

			local var_130_16 = arg_127_1.actors_["128404"].transform
			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1.var_.moveOldPos128404 = var_130_16.localPosition
				var_130_16.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("128404", 7)

				local var_130_18 = var_130_16.childCount

				for iter_130_8 = 0, var_130_18 - 1 do
					local var_130_19 = var_130_16:GetChild(iter_130_8)

					if var_130_19.name == "" or not string.find(var_130_19.name, "split") then
						var_130_19.gameObject:SetActive(true)
					else
						var_130_19.gameObject:SetActive(false)
					end
				end
			end

			local var_130_20 = 0.001

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_20 then
				local var_130_21 = (arg_127_1.time_ - var_130_17) / var_130_20
				local var_130_22 = Vector3.New(0, -2000, 0)

				var_130_16.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos128404, var_130_22, var_130_21)
			end

			if arg_127_1.time_ >= var_130_17 + var_130_20 and arg_127_1.time_ < var_130_17 + var_130_20 + arg_130_0 then
				var_130_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_23 = arg_127_1.actors_["10144"].transform
			local var_130_24 = 0

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.var_.moveOldPos10144 = var_130_23.localPosition
				var_130_23.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10144", 3)

				local var_130_25 = var_130_23.childCount

				for iter_130_9 = 0, var_130_25 - 1 do
					local var_130_26 = var_130_23:GetChild(iter_130_9)

					if var_130_26.name == "" or not string.find(var_130_26.name, "split") then
						var_130_26.gameObject:SetActive(true)
					else
						var_130_26.gameObject:SetActive(false)
					end
				end
			end

			local var_130_27 = 0.001

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_27 then
				local var_130_28 = (arg_127_1.time_ - var_130_24) / var_130_27
				local var_130_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_130_23.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10144, var_130_29, var_130_28)
			end

			if arg_127_1.time_ >= var_130_24 + var_130_27 and arg_127_1.time_ < var_130_24 + var_130_27 + arg_130_0 then
				var_130_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_130_30 = 0
			local var_130_31 = 0.775

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_32 = arg_127_1:FormatText(StoryNameCfg[1297].name)

				arg_127_1.leftNameTxt_.text = var_130_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_33 = arg_127_1:GetWordFromCfg(926082030)
				local var_130_34 = arg_127_1:FormatText(var_130_33.content)

				arg_127_1.text_.text = var_130_34

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_35 = 31
				local var_130_36 = utf8.len(var_130_34)
				local var_130_37 = var_130_35 <= 0 and var_130_31 or var_130_31 * (var_130_36 / var_130_35)

				if var_130_37 > 0 and var_130_31 < var_130_37 then
					arg_127_1.talkMaxDuration = var_130_37

					if var_130_37 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_37 + var_130_30
					end
				end

				arg_127_1.text_.text = var_130_34
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082030", "story_v_out_926082.awb") ~= 0 then
					local var_130_38 = manager.audio:GetVoiceLength("story_v_out_926082", "926082030", "story_v_out_926082.awb") / 1000

					if var_130_38 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_38 + var_130_30
					end

					if var_130_33.prefab_name ~= "" and arg_127_1.actors_[var_130_33.prefab_name] ~= nil then
						local var_130_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_33.prefab_name].transform, "story_v_out_926082", "926082030", "story_v_out_926082.awb")

						arg_127_1:RecordAudio("926082030", var_130_39)
						arg_127_1:RecordAudio("926082030", var_130_39)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_926082", "926082030", "story_v_out_926082.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_926082", "926082030", "story_v_out_926082.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_40 = math.max(var_130_31, arg_127_1.talkMaxDuration)

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_40 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_30) / var_130_40

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_30 + var_130_40 and arg_127_1.time_ < var_130_30 + var_130_40 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play926082031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 926082031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play926082032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10144"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10144 == nil then
				arg_131_1.var_.actorSpriteComps10144 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10144 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 0.5, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10144 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10144 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.225

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_10 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_11 = arg_131_1:GetWordFromCfg(926082031)
				local var_134_12 = arg_131_1:FormatText(var_134_11.content)

				arg_131_1.text_.text = var_134_12

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 9
				local var_134_14 = utf8.len(var_134_12)
				local var_134_15 = var_134_13 <= 0 and var_134_9 or var_134_9 * (var_134_14 / var_134_13)

				if var_134_15 > 0 and var_134_9 < var_134_15 then
					arg_131_1.talkMaxDuration = var_134_15

					if var_134_15 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_12
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play926082032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 926082032
		arg_135_1.duration_ = 5.93

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play926082033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10144"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10144 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10144", 7)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(0, -2000, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10144, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_138_7 = 0.266666666666667
			local var_138_8 = 1

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				local var_138_9 = "play"
				local var_138_10 = "effect"

				arg_135_1:AudioAction(var_138_9, var_138_10, "se_story_143", "se_story_143_cover", "")
			end

			local var_138_11 = "story_item_22202"

			if arg_135_1.actors_[var_138_11] == nil then
				local var_138_12 = Object.Instantiate(arg_135_1.imageGo_, arg_135_1.canvasGo_.transform)

				var_138_12.transform:SetSiblingIndex(1)

				var_138_12.name = var_138_11

				local var_138_13 = var_138_12:GetComponent(typeof(Image))

				var_138_13.sprite = getSpriteWithoutAtlas("TextureConfig/UIStoryImages/story_item_22202")

				var_138_13:SetNativeSize()

				var_138_12.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_135_1.actors_[var_138_11] = var_138_12
			end

			local var_138_14 = arg_135_1.actors_.story_item_22202.transform
			local var_138_15 = 0

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.var_.moveOldPosstory_item_22202 = var_138_14.localPosition
				var_138_14.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("story_item_22202", 3)
			end

			local var_138_16 = 0.6

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_16 then
				local var_138_17 = (arg_135_1.time_ - var_138_15) / var_138_16
				local var_138_18 = Vector3.New(8.07, 12.38, 0)

				var_138_14.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosstory_item_22202, var_138_18, var_138_17)
			end

			if arg_135_1.time_ >= var_138_15 + var_138_16 and arg_135_1.time_ < var_138_15 + var_138_16 + arg_138_0 then
				var_138_14.localPosition = Vector3.New(8.07, 12.38, 0)
			end

			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_20 = 1.26666666666667

			if arg_135_1.time_ >= var_138_19 + var_138_20 and arg_135_1.time_ < var_138_19 + var_138_20 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_21 = 0.933333333333333
			local var_138_22 = 0.8

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_23 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_23:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_24 = arg_135_1:GetWordFromCfg(926082032)
				local var_138_25 = arg_135_1:FormatText(var_138_24.content)

				arg_135_1.text_.text = var_138_25

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_26 = 32
				local var_138_27 = utf8.len(var_138_25)
				local var_138_28 = var_138_26 <= 0 and var_138_22 or var_138_22 * (var_138_27 / var_138_26)

				if var_138_28 > 0 and var_138_22 < var_138_28 then
					arg_135_1.talkMaxDuration = var_138_28
					var_138_21 = var_138_21 + 0.3

					if var_138_28 + var_138_21 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_28 + var_138_21
					end
				end

				arg_135_1.text_.text = var_138_25
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_29 = var_138_21 + 0.3
			local var_138_30 = math.max(var_138_22, arg_135_1.talkMaxDuration)

			if var_138_29 <= arg_135_1.time_ and arg_135_1.time_ < var_138_29 + var_138_30 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_29) / var_138_30

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_29 + var_138_30 and arg_135_1.time_ < var_138_29 + var_138_30 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				needEase = true,
				actorName = "story_item_22202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(8.07, 14, 0),
					endPos = Vector3.New(8.07, 12.38, 0),
					easeType = LeanTweenType.easeInCirc
				}
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play926082033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926082033
		arg_141_1.duration_ = 3.3

		local var_141_0 = {
			zh = 3.3,
			ja = 3.266
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
				arg_141_0:Play926082034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["128404"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps128404 == nil then
				arg_141_1.var_.actorSpriteComps128404 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps128404 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 1, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps128404 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps128404 = nil
			end

			local var_144_8 = arg_141_1.actors_["128404"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos128404 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("128404", 7)

				local var_144_10 = var_144_8.childCount

				for iter_144_4 = 0, var_144_10 - 1 do
					local var_144_11 = var_144_8:GetChild(iter_144_4)

					if var_144_11.name == "" or not string.find(var_144_11.name, "split") then
						var_144_11.gameObject:SetActive(true)
					else
						var_144_11.gameObject:SetActive(false)
					end
				end
			end

			local var_144_12 = 0.001

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_9) / var_144_12
				local var_144_14 = Vector3.New(0, -2000, 0)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos128404, var_144_14, var_144_13)
			end

			if arg_141_1.time_ >= var_144_9 + var_144_12 and arg_141_1.time_ < var_144_9 + var_144_12 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_15 = 0
			local var_144_16 = 0.225

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_18 = arg_141_1:GetWordFromCfg(926082033)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 9
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082033", "story_v_out_926082.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082033", "story_v_out_926082.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_926082", "926082033", "story_v_out_926082.awb")

						arg_141_1:RecordAudio("926082033", var_144_24)
						arg_141_1:RecordAudio("926082033", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926082", "926082033", "story_v_out_926082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926082", "926082033", "story_v_out_926082.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play926082034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926082034
		arg_145_1.duration_ = 9.67

		local var_145_0 = {
			zh = 9.5,
			ja = 9.666
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
				arg_145_0:Play926082035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.975

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(926082034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082034", "story_v_out_926082.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082034", "story_v_out_926082.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_926082", "926082034", "story_v_out_926082.awb")

						arg_145_1:RecordAudio("926082034", var_148_9)
						arg_145_1:RecordAudio("926082034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926082", "926082034", "story_v_out_926082.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926082", "926082034", "story_v_out_926082.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play926082035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926082035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926082036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["128404"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.275

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_10

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

				local var_152_11 = arg_149_1:GetWordFromCfg(926082035)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 11
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926082036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926082036
		arg_153_1.duration_ = 1.8

		local var_153_0 = {
			zh = 1.166,
			ja = 1.8
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play926082037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["128404"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.05

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[6].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_11 = arg_153_1:GetWordFromCfg(926082036)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 2
				local var_156_14 = utf8.len(var_156_12)
				local var_156_15 = var_156_13 <= 0 and var_156_9 or var_156_9 * (var_156_14 / var_156_13)

				if var_156_15 > 0 and var_156_9 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082036", "story_v_out_926082.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082036", "story_v_out_926082.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_926082", "926082036", "story_v_out_926082.awb")

						arg_153_1:RecordAudio("926082036", var_156_17)
						arg_153_1:RecordAudio("926082036", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926082", "926082036", "story_v_out_926082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926082", "926082036", "story_v_out_926082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_18 and arg_153_1.time_ < var_156_8 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play926082037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926082037
		arg_157_1.duration_ = 5.57

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926082038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["128404"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps128404 == nil then
				arg_157_1.var_.actorSpriteComps128404 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps128404 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 0.5, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps128404 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps128404 = nil
			end

			local var_160_8 = arg_157_1.actors_["128404"].transform
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.var_.moveOldPos128404 = var_160_8.localPosition
				var_160_8.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("128404", 7)

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
				local var_160_14 = Vector3.New(0, -2000, 0)

				var_160_8.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos128404, var_160_14, var_160_13)
			end

			if arg_157_1.time_ >= var_160_9 + var_160_12 and arg_157_1.time_ < var_160_9 + var_160_12 + arg_160_0 then
				var_160_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_15 = arg_157_1.actors_.story_item_22202.transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPosstory_item_22202 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("story_item_22202", 3)
			end

			local var_160_17 = 0.625

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17
				local var_160_19 = Vector3.New(8.07, 12.38, 0)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosstory_item_22202, var_160_19, var_160_18)
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(8.07, 12.38, 0)
			end

			local var_160_20 = arg_157_1.actors_.story_item_22202.transform
			local var_160_21 = 0.766666666666667

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.var_.moveOldPosstory_item_22202 = var_160_20.localPosition
				var_160_20.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("story_item_22202", 7)
			end

			local var_160_22 = 0.001

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_22 then
				local var_160_23 = (arg_157_1.time_ - var_160_21) / var_160_22
				local var_160_24 = Vector3.New(0, -2000, 0)

				var_160_20.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosstory_item_22202, var_160_24, var_160_23)
			end

			if arg_157_1.time_ >= var_160_21 + var_160_22 and arg_157_1.time_ < var_160_21 + var_160_22 + arg_160_0 then
				var_160_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_25 = 0

			if var_160_25 < arg_157_1.time_ and arg_157_1.time_ <= var_160_25 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_26 = 0.625

			if arg_157_1.time_ >= var_160_25 + var_160_26 and arg_157_1.time_ < var_160_25 + var_160_26 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_27 = 0.566666666666667
			local var_160_28 = 0.625

			if var_160_27 < arg_157_1.time_ and arg_157_1.time_ <= var_160_27 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_29 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_29:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_30 = arg_157_1:GetWordFromCfg(926082037)
				local var_160_31 = arg_157_1:FormatText(var_160_30.content)

				arg_157_1.text_.text = var_160_31

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_32 = 25
				local var_160_33 = utf8.len(var_160_31)
				local var_160_34 = var_160_32 <= 0 and var_160_28 or var_160_28 * (var_160_33 / var_160_32)

				if var_160_34 > 0 and var_160_28 < var_160_34 then
					arg_157_1.talkMaxDuration = var_160_34
					var_160_27 = var_160_27 + 0.3

					if var_160_34 + var_160_27 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_34 + var_160_27
					end
				end

				arg_157_1.text_.text = var_160_31
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_35 = var_160_27 + 0.3
			local var_160_36 = math.max(var_160_28, arg_157_1.talkMaxDuration)

			if var_160_35 <= arg_157_1.time_ and arg_157_1.time_ < var_160_35 + var_160_36 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_35) / var_160_36

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_35 + var_160_36 and arg_157_1.time_ < var_160_35 + var_160_36 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				needEase = true,
				actorName = "story_item_22202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.625,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(8.07, 14, 0),
					endPos = Vector3.New(8.07, 12.38, 0),
					easeType = LeanTweenType.easeInCirc
				}
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				actorName = "story_item_22202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play926082038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926082038
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 4.5,
			ja = 3.866
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
				arg_163_0:Play926082039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["128404"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps128404 == nil then
				arg_163_1.var_.actorSpriteComps128404 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps128404 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 1, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps128404 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps128404 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.2

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_10 = arg_163_1:FormatText(StoryNameCfg[6].name)

				arg_163_1.leftNameTxt_.text = var_166_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_11 = arg_163_1:GetWordFromCfg(926082038)
				local var_166_12 = arg_163_1:FormatText(var_166_11.content)

				arg_163_1.text_.text = var_166_12

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 8
				local var_166_14 = utf8.len(var_166_12)
				local var_166_15 = var_166_13 <= 0 and var_166_9 or var_166_9 * (var_166_14 / var_166_13)

				if var_166_15 > 0 and var_166_9 < var_166_15 then
					arg_163_1.talkMaxDuration = var_166_15

					if var_166_15 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_15 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_12
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082038", "story_v_out_926082.awb") ~= 0 then
					local var_166_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082038", "story_v_out_926082.awb") / 1000

					if var_166_16 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_8
					end

					if var_166_11.prefab_name ~= "" and arg_163_1.actors_[var_166_11.prefab_name] ~= nil then
						local var_166_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_11.prefab_name].transform, "story_v_out_926082", "926082038", "story_v_out_926082.awb")

						arg_163_1:RecordAudio("926082038", var_166_17)
						arg_163_1:RecordAudio("926082038", var_166_17)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_926082", "926082038", "story_v_out_926082.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_926082", "926082038", "story_v_out_926082.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_18 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_18 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_18

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_18 and arg_163_1.time_ < var_166_8 + var_166_18 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play926082039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926082039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play926082040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["128404"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps128404 == nil then
				arg_167_1.var_.actorSpriteComps128404 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps128404 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 0.5, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps128404 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps128404 = nil
			end

			local var_170_8 = arg_167_1.actors_["128404"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos128404 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("128404", 7)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "" or not string.find(var_170_11.name, "split") then
						var_170_11.gameObject:SetActive(true)
					else
						var_170_11.gameObject:SetActive(false)
					end
				end
			end

			local var_170_12 = 0.001

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(0, -2000, 0)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos128404, var_170_14, var_170_13)
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_15 = 0
			local var_170_16 = 0.75

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_17 = arg_167_1:GetWordFromCfg(926082039)
				local var_170_18 = arg_167_1:FormatText(var_170_17.content)

				arg_167_1.text_.text = var_170_18

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_19 = 30
				local var_170_20 = utf8.len(var_170_18)
				local var_170_21 = var_170_19 <= 0 and var_170_16 or var_170_16 * (var_170_20 / var_170_19)

				if var_170_21 > 0 and var_170_16 < var_170_21 then
					arg_167_1.talkMaxDuration = var_170_21

					if var_170_21 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_21 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_18
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_22 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_22 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_22

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_22 and arg_167_1.time_ < var_170_15 + var_170_22 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play926082040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 926082040
		arg_171_1.duration_ = 4.4

		local var_171_0 = {
			zh = 3.4,
			ja = 4.4
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
				arg_171_0:Play926082041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["128404"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps128404 == nil then
				arg_171_1.var_.actorSpriteComps128404 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps128404 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 1, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps128404 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps128404 = nil
			end

			local var_174_8 = arg_171_1.actors_["128404"].transform
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.var_.moveOldPos128404 = var_174_8.localPosition
				var_174_8.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("128404", 3)

				local var_174_10 = var_174_8.childCount

				for iter_174_4 = 0, var_174_10 - 1 do
					local var_174_11 = var_174_8:GetChild(iter_174_4)

					if var_174_11.name == "split_5" or not string.find(var_174_11.name, "split") then
						var_174_11.gameObject:SetActive(true)
					else
						var_174_11.gameObject:SetActive(false)
					end
				end
			end

			local var_174_12 = 0.001

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_12 then
				local var_174_13 = (arg_171_1.time_ - var_174_9) / var_174_12
				local var_174_14 = Vector3.New(-16.1, -362, -375)

				var_174_8.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos128404, var_174_14, var_174_13)
			end

			if arg_171_1.time_ >= var_174_9 + var_174_12 and arg_171_1.time_ < var_174_9 + var_174_12 + arg_174_0 then
				var_174_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_174_15 = 0
			local var_174_16 = 0.3

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[6].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(926082040)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 12
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082040", "story_v_out_926082.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082040", "story_v_out_926082.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_926082", "926082040", "story_v_out_926082.awb")

						arg_171_1:RecordAudio("926082040", var_174_24)
						arg_171_1:RecordAudio("926082040", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_926082", "926082040", "story_v_out_926082.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_926082", "926082040", "story_v_out_926082.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play926082041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 926082041
		arg_175_1.duration_ = 7.27

		local var_175_0 = {
			zh = 4.3,
			ja = 7.266
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
				arg_175_0:Play926082042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.475

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[6].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(926082041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 19
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082041", "story_v_out_926082.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082041", "story_v_out_926082.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_926082", "926082041", "story_v_out_926082.awb")

						arg_175_1:RecordAudio("926082041", var_178_9)
						arg_175_1:RecordAudio("926082041", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_926082", "926082041", "story_v_out_926082.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_926082", "926082041", "story_v_out_926082.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play926082042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 926082042
		arg_179_1.duration_ = 8.1

		local var_179_0 = {
			zh = 7.6,
			ja = 8.1
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
				arg_179_0:Play926082043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["128404"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos128404 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("128404", 3)

				local var_182_2 = var_182_0.childCount

				for iter_182_0 = 0, var_182_2 - 1 do
					local var_182_3 = var_182_0:GetChild(iter_182_0)

					if var_182_3.name == "split_5" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_4 then
				local var_182_5 = (arg_179_1.time_ - var_182_1) / var_182_4
				local var_182_6 = Vector3.New(-16.1, -362, -375)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos128404, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_182_7 = 0
			local var_182_8 = 0.625

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_9 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(926082042)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_12 = 25
				local var_182_13 = utf8.len(var_182_11)
				local var_182_14 = var_182_12 <= 0 and var_182_8 or var_182_8 * (var_182_13 / var_182_12)

				if var_182_14 > 0 and var_182_8 < var_182_14 then
					arg_179_1.talkMaxDuration = var_182_14

					if var_182_14 + var_182_7 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_7
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082042", "story_v_out_926082.awb") ~= 0 then
					local var_182_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082042", "story_v_out_926082.awb") / 1000

					if var_182_15 + var_182_7 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_15 + var_182_7
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_926082", "926082042", "story_v_out_926082.awb")

						arg_179_1:RecordAudio("926082042", var_182_16)
						arg_179_1:RecordAudio("926082042", var_182_16)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_926082", "926082042", "story_v_out_926082.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_926082", "926082042", "story_v_out_926082.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_17 = math.max(var_182_8, arg_179_1.talkMaxDuration)

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_17 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_7) / var_182_17

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_7 + var_182_17 and arg_179_1.time_ < var_182_7 + var_182_17 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play926082043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926082043
		arg_183_1.duration_ = 7.87

		local var_183_0 = {
			zh = 5.966,
			ja = 7.866
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
				arg_183_0:Play926082044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.65

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[6].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(926082043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082043", "story_v_out_926082.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082043", "story_v_out_926082.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_926082", "926082043", "story_v_out_926082.awb")

						arg_183_1:RecordAudio("926082043", var_186_9)
						arg_183_1:RecordAudio("926082043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926082", "926082043", "story_v_out_926082.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926082", "926082043", "story_v_out_926082.awb")
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
	Play926082044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 926082044
		arg_187_1.duration_ = 6.3

		local var_187_0 = {
			zh = 6.266,
			ja = 6.3
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
				arg_187_0:Play926082045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.675

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[6].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(926082044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 27
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082044", "story_v_out_926082.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082044", "story_v_out_926082.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_926082", "926082044", "story_v_out_926082.awb")

						arg_187_1:RecordAudio("926082044", var_190_9)
						arg_187_1:RecordAudio("926082044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_926082", "926082044", "story_v_out_926082.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_926082", "926082044", "story_v_out_926082.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play926082045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 926082045
		arg_191_1.duration_ = 7.73

		local var_191_0 = {
			zh = 5.6,
			ja = 7.733
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
				arg_191_0:Play926082046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["128404"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos128404 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("128404", 3)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "split_4" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(-16.1, -362, -375)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos128404, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_194_7 = 0
			local var_194_8 = 0.475

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_9 = arg_191_1:FormatText(StoryNameCfg[6].name)

				arg_191_1.leftNameTxt_.text = var_194_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(926082045)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_12 = 19
				local var_194_13 = utf8.len(var_194_11)
				local var_194_14 = var_194_12 <= 0 and var_194_8 or var_194_8 * (var_194_13 / var_194_12)

				if var_194_14 > 0 and var_194_8 < var_194_14 then
					arg_191_1.talkMaxDuration = var_194_14

					if var_194_14 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082045", "story_v_out_926082.awb") ~= 0 then
					local var_194_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082045", "story_v_out_926082.awb") / 1000

					if var_194_15 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_15 + var_194_7
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_926082", "926082045", "story_v_out_926082.awb")

						arg_191_1:RecordAudio("926082045", var_194_16)
						arg_191_1:RecordAudio("926082045", var_194_16)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_926082", "926082045", "story_v_out_926082.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_926082", "926082045", "story_v_out_926082.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_17 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_17 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_17

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_17 and arg_191_1.time_ < var_194_7 + var_194_17 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 926082046
		arg_195_1.duration_ = 1.97

		local var_195_0 = {
			zh = 1.966,
			ja = 1.666
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
				arg_195_0:Play926082047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10144"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10144 == nil then
				arg_195_1.var_.actorSpriteComps10144 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10144 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10144 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10144 = nil
			end

			local var_198_8 = arg_195_1.actors_["128404"]
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps128404 == nil then
				arg_195_1.var_.actorSpriteComps128404 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_10 = 0.2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 and not isNil(var_198_8) then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10

				if arg_195_1.var_.actorSpriteComps128404 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								local var_198_12 = Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, var_198_11)
								local var_198_13 = Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, var_198_11)
								local var_198_14 = Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, var_198_11)

								iter_198_5.color = Color.New(var_198_12, var_198_13, var_198_14)
							else
								local var_198_15 = Mathf.Lerp(iter_198_5.color.r, 0.5, var_198_11)

								iter_198_5.color = Color.New(var_198_15, var_198_15, var_198_15)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps128404 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_198_7 then
						if arg_195_1.isInRecall_ then
							iter_198_7.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps128404 = nil
			end

			local var_198_16 = arg_195_1.actors_["128404"].transform
			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.var_.moveOldPos128404 = var_198_16.localPosition
				var_198_16.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("128404", 7)

				local var_198_18 = var_198_16.childCount

				for iter_198_8 = 0, var_198_18 - 1 do
					local var_198_19 = var_198_16:GetChild(iter_198_8)

					if var_198_19.name == "" or not string.find(var_198_19.name, "split") then
						var_198_19.gameObject:SetActive(true)
					else
						var_198_19.gameObject:SetActive(false)
					end
				end
			end

			local var_198_20 = 0.001

			if var_198_17 <= arg_195_1.time_ and arg_195_1.time_ < var_198_17 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_17) / var_198_20
				local var_198_22 = Vector3.New(0, -2000, 0)

				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos128404, var_198_22, var_198_21)
			end

			if arg_195_1.time_ >= var_198_17 + var_198_20 and arg_195_1.time_ < var_198_17 + var_198_20 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_23 = arg_195_1.actors_["10144"].transform
			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1.var_.moveOldPos10144 = var_198_23.localPosition
				var_198_23.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10144", 3)

				local var_198_25 = var_198_23.childCount

				for iter_198_9 = 0, var_198_25 - 1 do
					local var_198_26 = var_198_23:GetChild(iter_198_9)

					if var_198_26.name == "split_5" or not string.find(var_198_26.name, "split") then
						var_198_26.gameObject:SetActive(true)
					else
						var_198_26.gameObject:SetActive(false)
					end
				end
			end

			local var_198_27 = 0.001

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_27 then
				local var_198_28 = (arg_195_1.time_ - var_198_24) / var_198_27
				local var_198_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_198_23.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10144, var_198_29, var_198_28)
			end

			if arg_195_1.time_ >= var_198_24 + var_198_27 and arg_195_1.time_ < var_198_24 + var_198_27 + arg_198_0 then
				var_198_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_198_30 = 0
			local var_198_31 = 0.15

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_32 = arg_195_1:FormatText(StoryNameCfg[1297].name)

				arg_195_1.leftNameTxt_.text = var_198_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_33 = arg_195_1:GetWordFromCfg(926082046)
				local var_198_34 = arg_195_1:FormatText(var_198_33.content)

				arg_195_1.text_.text = var_198_34

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_35 = 6
				local var_198_36 = utf8.len(var_198_34)
				local var_198_37 = var_198_35 <= 0 and var_198_31 or var_198_31 * (var_198_36 / var_198_35)

				if var_198_37 > 0 and var_198_31 < var_198_37 then
					arg_195_1.talkMaxDuration = var_198_37

					if var_198_37 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_37 + var_198_30
					end
				end

				arg_195_1.text_.text = var_198_34
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082046", "story_v_out_926082.awb") ~= 0 then
					local var_198_38 = manager.audio:GetVoiceLength("story_v_out_926082", "926082046", "story_v_out_926082.awb") / 1000

					if var_198_38 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_38 + var_198_30
					end

					if var_198_33.prefab_name ~= "" and arg_195_1.actors_[var_198_33.prefab_name] ~= nil then
						local var_198_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_33.prefab_name].transform, "story_v_out_926082", "926082046", "story_v_out_926082.awb")

						arg_195_1:RecordAudio("926082046", var_198_39)
						arg_195_1:RecordAudio("926082046", var_198_39)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_926082", "926082046", "story_v_out_926082.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_926082", "926082046", "story_v_out_926082.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_40 = math.max(var_198_31, arg_195_1.talkMaxDuration)

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_40 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_40

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_40 and arg_195_1.time_ < var_198_30 + var_198_40 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926082047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 926082047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play926082048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10144"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10144 == nil then
				arg_199_1.var_.actorSpriteComps10144 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10144 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10144 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10144 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.3

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(926082047)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 12
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
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play926082048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 926082048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play926082049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10144"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10144 = var_206_0.localPosition
				var_206_0.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10144", 7)

				local var_206_2 = var_206_0.childCount

				for iter_206_0 = 0, var_206_2 - 1 do
					local var_206_3 = var_206_0:GetChild(iter_206_0)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_4 then
				local var_206_5 = (arg_203_1.time_ - var_206_1) / var_206_4
				local var_206_6 = Vector3.New(0, -2000, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10144, var_206_6, var_206_5)
			end

			if arg_203_1.time_ >= var_206_1 + var_206_4 and arg_203_1.time_ < var_206_1 + var_206_4 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_7 = 0
			local var_206_8 = 0.725

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(926082048)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 29
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_8 or var_206_8 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_8 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_7 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_7
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_8, arg_203_1.talkMaxDuration)

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_7) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_7 + var_206_14 and arg_203_1.time_ < var_206_7 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926082049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 926082049
		arg_207_1.duration_ = 30.15

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play926082050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = "STwhite"

			if arg_207_1.bgs_[var_210_0] == nil then
				local var_210_1 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_210_0)
				var_210_1.name = var_210_0
				var_210_1.transform.parent = arg_207_1.stage_.transform
				var_210_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_[var_210_0] = var_210_1
			end

			local var_210_2 = 2.23333333333333

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				local var_210_3 = manager.ui.mainCamera.transform.localPosition
				local var_210_4 = Vector3.New(0, 0, 10) + Vector3.New(var_210_3.x, var_210_3.y, 0)
				local var_210_5 = arg_207_1.bgs_.STwhite

				var_210_5.transform.localPosition = var_210_4
				var_210_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_6 = var_210_5:GetComponent("SpriteRenderer")

				if var_210_6 and var_210_6.sprite then
					local var_210_7 = (var_210_5.transform.localPosition - var_210_3).z
					local var_210_8 = manager.ui.mainCameraCom_
					local var_210_9 = 2 * var_210_7 * Mathf.Tan(var_210_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_10 = var_210_9 * var_210_8.aspect
					local var_210_11 = var_210_6.sprite.bounds.size.x
					local var_210_12 = var_210_6.sprite.bounds.size.y
					local var_210_13 = var_210_10 / var_210_11
					local var_210_14 = var_210_9 / var_210_12
					local var_210_15 = var_210_14 < var_210_13 and var_210_13 or var_210_14

					var_210_5.transform.localScale = Vector3.New(var_210_15, var_210_15, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "STwhite" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_16 = 18.1666666666667

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				local var_210_17 = manager.ui.mainCamera.transform.localPosition
				local var_210_18 = Vector3.New(0, 0, 10) + Vector3.New(var_210_17.x, var_210_17.y, 0)
				local var_210_19 = arg_207_1.bgs_.STwhite

				var_210_19.transform.localPosition = var_210_18
				var_210_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_20 = var_210_19:GetComponent("SpriteRenderer")

				if var_210_20 and var_210_20.sprite then
					local var_210_21 = (var_210_19.transform.localPosition - var_210_17).z
					local var_210_22 = manager.ui.mainCameraCom_
					local var_210_23 = 2 * var_210_21 * Mathf.Tan(var_210_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_24 = var_210_23 * var_210_22.aspect
					local var_210_25 = var_210_20.sprite.bounds.size.x
					local var_210_26 = var_210_20.sprite.bounds.size.y
					local var_210_27 = var_210_24 / var_210_25
					local var_210_28 = var_210_23 / var_210_26
					local var_210_29 = var_210_28 < var_210_27 and var_210_27 or var_210_28

					var_210_19.transform.localScale = Vector3.New(var_210_29, var_210_29, 0)
				end

				for iter_210_2, iter_210_3 in pairs(arg_207_1.bgs_) do
					if iter_210_2 ~= "STwhite" then
						iter_210_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_30 = 16.1666666666667

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			local var_210_31 = 0.3

			if arg_207_1.time_ >= var_210_30 + var_210_31 and arg_207_1.time_ < var_210_30 + var_210_31 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_32 = 0

			if var_210_32 < arg_207_1.time_ and arg_207_1.time_ <= var_210_32 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_33 = 2.23333333333333

			if var_210_32 <= arg_207_1.time_ and arg_207_1.time_ < var_210_32 + var_210_33 then
				local var_210_34 = (arg_207_1.time_ - var_210_32) / var_210_33
				local var_210_35 = Color.New(0, 0, 0)

				var_210_35.a = Mathf.Lerp(0, 1, var_210_34)
				arg_207_1.mask_.color = var_210_35
			end

			if arg_207_1.time_ >= var_210_32 + var_210_33 and arg_207_1.time_ < var_210_32 + var_210_33 + arg_210_0 then
				local var_210_36 = Color.New(0, 0, 0)

				var_210_36.a = 1
				arg_207_1.mask_.color = var_210_36
			end

			local var_210_37 = 2.23333333333333

			if var_210_37 < arg_207_1.time_ and arg_207_1.time_ <= var_210_37 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_38 = 1.33333333333333

			if var_210_37 <= arg_207_1.time_ and arg_207_1.time_ < var_210_37 + var_210_38 then
				local var_210_39 = (arg_207_1.time_ - var_210_37) / var_210_38
				local var_210_40 = Color.New(0, 0, 0)

				var_210_40.a = Mathf.Lerp(1, 0, var_210_39)
				arg_207_1.mask_.color = var_210_40
			end

			if arg_207_1.time_ >= var_210_37 + var_210_38 and arg_207_1.time_ < var_210_37 + var_210_38 + arg_210_0 then
				local var_210_41 = Color.New(0, 0, 0)
				local var_210_42 = 0

				arg_207_1.mask_.enabled = false
				var_210_41.a = var_210_42
				arg_207_1.mask_.color = var_210_41
			end

			local var_210_43 = 17.4

			if var_210_43 < arg_207_1.time_ and arg_207_1.time_ <= var_210_43 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_44 = 1.03333333333333

			if var_210_43 <= arg_207_1.time_ and arg_207_1.time_ < var_210_43 + var_210_44 then
				local var_210_45 = (arg_207_1.time_ - var_210_43) / var_210_44
				local var_210_46 = Color.New(0, 0, 0)

				var_210_46.a = Mathf.Lerp(0, 1, var_210_45)
				arg_207_1.mask_.color = var_210_46
			end

			if arg_207_1.time_ >= var_210_43 + var_210_44 and arg_207_1.time_ < var_210_43 + var_210_44 + arg_210_0 then
				local var_210_47 = Color.New(0, 0, 0)

				var_210_47.a = 1
				arg_207_1.mask_.color = var_210_47
			end

			local var_210_48 = 18.4333333333333

			if var_210_48 < arg_207_1.time_ and arg_207_1.time_ <= var_210_48 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_49 = 1.4

			if var_210_48 <= arg_207_1.time_ and arg_207_1.time_ < var_210_48 + var_210_49 then
				local var_210_50 = (arg_207_1.time_ - var_210_48) / var_210_49
				local var_210_51 = Color.New(0, 0, 0)

				var_210_51.a = Mathf.Lerp(1, 0, var_210_50)
				arg_207_1.mask_.color = var_210_51
			end

			if arg_207_1.time_ >= var_210_48 + var_210_49 and arg_207_1.time_ < var_210_48 + var_210_49 + arg_210_0 then
				local var_210_52 = Color.New(0, 0, 0)
				local var_210_53 = 0

				arg_207_1.mask_.enabled = false
				var_210_52.a = var_210_53
				arg_207_1.mask_.color = var_210_52
			end

			local var_210_54 = 18.1666666666667

			if var_210_54 < arg_207_1.time_ and arg_207_1.time_ <= var_210_54 + arg_210_0 then
				local var_210_55 = arg_207_1.fswbg_.transform:Find("textbox/adapt/content") or arg_207_1.fswbg_.transform:Find("textbox/content")
				local var_210_56 = arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_210_57 = var_210_55:GetComponent("Text")
				local var_210_58 = var_210_55:GetComponent("RectTransform")

				var_210_57.alignment = UnityEngine.TextAnchor.LowerCenter
				var_210_58.offsetMin = Vector2.New(0, 0)
				var_210_58.offsetMax = Vector2.New(0, 0)
			end

			local var_210_59 = 18.4

			if var_210_59 < arg_207_1.time_ and arg_207_1.time_ <= var_210_59 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(true)
				arg_207_1.dialog_:SetActive(false)

				arg_207_1.fswtw_.percent = 0

				local var_210_60 = arg_207_1:GetWordFromCfg(926082049)
				local var_210_61 = arg_207_1:FormatText(var_210_60.content)

				arg_207_1.fswt_.text = var_210_61

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.fswt_)

				arg_207_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_207_1.fswtw_:SetDirty()

				arg_207_1.typewritterCharCountI18N = 0

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_62 = 20.8166666666667

			if var_210_62 < arg_207_1.time_ and arg_207_1.time_ <= var_210_62 + arg_210_0 then
				arg_207_1.var_.oldValueTypewriter = arg_207_1.fswtw_.percent
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_63 = 42
			local var_210_64 = 2.8
			local var_210_65 = arg_207_1:GetWordFromCfg(926082049)
			local var_210_66 = arg_207_1:FormatText(var_210_65.content)
			local var_210_67, var_210_68 = arg_207_1:GetPercentByPara(var_210_66, 1)

			if var_210_62 < arg_207_1.time_ and arg_207_1.time_ <= var_210_62 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				local var_210_69 = var_210_63 <= 0 and var_210_64 or var_210_64 * ((var_210_68 - arg_207_1.typewritterCharCountI18N) / var_210_63)

				if var_210_69 > 0 and var_210_64 < var_210_69 then
					arg_207_1.talkMaxDuration = var_210_69

					if var_210_69 + var_210_62 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_69 + var_210_62
					end
				end
			end

			local var_210_70 = 2.8
			local var_210_71 = math.max(var_210_70, arg_207_1.talkMaxDuration)

			if var_210_62 <= arg_207_1.time_ and arg_207_1.time_ < var_210_62 + var_210_71 then
				local var_210_72 = (arg_207_1.time_ - var_210_62) / var_210_71

				arg_207_1.fswtw_.percent = Mathf.Lerp(arg_207_1.var_.oldValueTypewriter, var_210_67, var_210_72)
				arg_207_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_207_1.fswtw_:SetDirty()
			end

			if arg_207_1.time_ >= var_210_62 + var_210_71 and arg_207_1.time_ < var_210_62 + var_210_71 + arg_210_0 then
				arg_207_1.fswtw_.percent = var_210_67

				arg_207_1.fswtw_:SetDirty()
				arg_207_1:ShowNextGo(true)

				arg_207_1.typewritterCharCountI18N = var_210_68
			end

			local var_210_73 = 18.45
			local var_210_74 = 0.3

			if var_210_73 < arg_207_1.time_ and arg_207_1.time_ <= var_210_73 + arg_210_0 then
				local var_210_75 = "play"
				local var_210_76 = "music"

				arg_207_1:AudioAction(var_210_75, var_210_76, "ui_battle", "ui_battle_stopbgm", "")

				local var_210_77 = ""
				local var_210_78 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_210_78 ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_78 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_78

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_78
						arg_207_1.bgmTxt2_.text = var_210_78
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_210_79 = 19.8166666666667
			local var_210_80 = 1

			if var_210_79 < arg_207_1.time_ and arg_207_1.time_ <= var_210_79 + arg_210_0 then
				local var_210_81 = "play"
				local var_210_82 = "music"

				arg_207_1:AudioAction(var_210_81, var_210_82, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_210_83 = ""
				local var_210_84 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_210_84 ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_84 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_84

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_84
						arg_207_1.bgmTxt2_.text = var_210_84
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_210_85 = 18.9166666666667
			local var_210_86 = 1

			if var_210_85 < arg_207_1.time_ and arg_207_1.time_ <= var_210_85 + arg_210_0 then
				local var_210_87 = "stop"
				local var_210_88 = "effect"

				arg_207_1:AudioAction(var_210_87, var_210_88, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_210_89 = 20.8166666666667
			local var_210_90 = 9.333
			local var_210_91 = manager.audio:GetVoiceLength("story_v_out_926082", "926082049", "0") / 1000

			if var_210_91 > 0 and var_210_90 < var_210_91 and var_210_91 + var_210_89 > arg_207_1.duration_ then
				local var_210_92 = var_210_91

				arg_207_1.duration_ = var_210_91 + var_210_89
			end

			if var_210_89 < arg_207_1.time_ and arg_207_1.time_ <= var_210_89 + arg_210_0 then
				local var_210_93 = "play"
				local var_210_94 = "voice"

				arg_207_1:AudioAction(var_210_93, var_210_94, "story_v_out_926082", "926082049", "0")
			end

			local var_210_95 = 2.23333333333333

			if var_210_95 < arg_207_1.time_ and arg_207_1.time_ <= var_210_95 + arg_210_0 then
				SetActive(arg_207_1.dialog_, false)
				SetActive(arg_207_1.allBtn_.gameObject, false)
				arg_207_1.hideBtnsController_:SetSelectedIndex(1)
				arg_207_1:StopAllVoice()

				arg_207_1.marker = "12334"

				manager.video:Play("SofdecAsset/activity/activity_4_3_08_402501_start.usm", function(arg_213_0)
					arg_207_1.time_ = var_210_95 + 16.1566666668902

					if arg_207_1.state_ == "pause" then
						arg_207_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_214_0)
					if arg_214_0 then
						arg_207_1.state_ = "pause"
					else
						arg_207_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_210_96 = 16.1666666666667

			if var_210_95 <= arg_207_1.time_ and arg_207_1.time_ < var_210_95 + var_210_96 then
				-- block empty
			end

			if arg_207_1.time_ >= var_210_95 + var_210_96 and arg_207_1.time_ < var_210_95 + var_210_96 + arg_210_0 then
				arg_207_1.marker = ""
			end

			local var_210_97 = 18.4

			if var_210_97 < arg_207_1.time_ and arg_207_1.time_ <= var_210_97 + arg_210_0 then
				SetActive(arg_207_1.dialog_, false)
				SetActive(arg_207_1.allBtn_.gameObject, true)
				arg_207_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_207_1.isInLoopVideo = false
			end

			local var_210_98 = 0.0333333333333314

			if var_210_97 <= arg_207_1.time_ and arg_207_1.time_ < var_210_97 + var_210_98 then
				-- block empty
			end

			if arg_207_1.time_ >= var_210_97 + var_210_98 and arg_207_1.time_ < var_210_97 + var_210_98 + arg_210_0 then
				arg_207_1.marker = ""
			end

			local var_210_99 = 2.23333333333333

			if var_210_99 < arg_207_1.time_ and arg_207_1.time_ <= var_210_99 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(true)
				arg_207_1.dialog_:SetActive(false)

				arg_207_1.fswtw_.percent = 0

				local var_210_100 = arg_207_1:GetWordFromCfg(102)
				local var_210_101 = arg_207_1:FormatText(var_210_100.content)

				arg_207_1.fswt_.text = var_210_101

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.fswt_)

				arg_207_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_207_1.fswtw_:SetDirty()

				arg_207_1.typewritterCharCountI18N = 0

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_102 = 18.4

			if var_210_102 < arg_207_1.time_ and arg_207_1.time_ <= var_210_102 + arg_210_0 then
				local var_210_103 = arg_207_1.fswbg_.transform:Find("textbox/adapt/content") or arg_207_1.fswbg_.transform:Find("textbox/content")
				local var_210_104 = arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_210_105 = var_210_103:GetComponent("Text")
				local var_210_106 = var_210_103:GetComponent("RectTransform")

				var_210_105.alignment = UnityEngine.TextAnchor.LowerCenter
				var_210_106.offsetMin = Vector2.New(0, 0)
				var_210_106.offsetMax = Vector2.New(0, 0)
			end

			local var_210_107 = 2.23333333333333

			if var_210_107 < arg_207_1.time_ and arg_207_1.time_ <= var_210_107 + arg_210_0 then
				local var_210_108 = manager.ui.mainCamera.transform.localPosition
				local var_210_109 = Vector3.New(0, 0, 10) + Vector3.New(var_210_108.x, var_210_108.y, 0)
				local var_210_110 = arg_207_1.bgs_.STwhite

				var_210_110.transform.localPosition = var_210_109
				var_210_110.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_111 = var_210_110:GetComponent("SpriteRenderer")

				if var_210_111 and var_210_111.sprite then
					local var_210_112 = (var_210_110.transform.localPosition - var_210_108).z
					local var_210_113 = manager.ui.mainCameraCom_
					local var_210_114 = 2 * var_210_112 * Mathf.Tan(var_210_113.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_115 = var_210_114 * var_210_113.aspect
					local var_210_116 = var_210_111.sprite.bounds.size.x
					local var_210_117 = var_210_111.sprite.bounds.size.y
					local var_210_118 = var_210_115 / var_210_116
					local var_210_119 = var_210_114 / var_210_117
					local var_210_120 = var_210_119 < var_210_118 and var_210_118 or var_210_119

					var_210_110.transform.localScale = Vector3.New(var_210_120, var_210_120, 0)
				end

				for iter_210_4, iter_210_5 in pairs(arg_207_1.bgs_) do
					if iter_210_4 ~= "STwhite" then
						iter_210_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_121 = 18.5

			if var_210_121 < arg_207_1.time_ and arg_207_1.time_ <= var_210_121 + arg_210_0 then
				local var_210_122 = manager.ui.mainCamera.transform.localPosition
				local var_210_123 = Vector3.New(0, 0, 10) + Vector3.New(var_210_122.x, var_210_122.y, 0)
				local var_210_124 = arg_207_1.bgs_.STwhite

				var_210_124.transform.localPosition = var_210_123
				var_210_124.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_125 = var_210_124:GetComponent("SpriteRenderer")

				if var_210_125 and var_210_125.sprite then
					local var_210_126 = (var_210_124.transform.localPosition - var_210_122).z
					local var_210_127 = manager.ui.mainCameraCom_
					local var_210_128 = 2 * var_210_126 * Mathf.Tan(var_210_127.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_129 = var_210_128 * var_210_127.aspect
					local var_210_130 = var_210_125.sprite.bounds.size.x
					local var_210_131 = var_210_125.sprite.bounds.size.y
					local var_210_132 = var_210_129 / var_210_130
					local var_210_133 = var_210_128 / var_210_131
					local var_210_134 = var_210_133 < var_210_132 and var_210_132 or var_210_133

					var_210_124.transform.localScale = Vector3.New(var_210_134, var_210_134, 0)
				end

				for iter_210_6, iter_210_7 in pairs(arg_207_1.bgs_) do
					if iter_210_6 ~= "STwhite" then
						iter_210_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play926082050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 926082050
		arg_215_1.duration_ = 8.6

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play926082051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.0166666666666667

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				local var_218_1 = manager.ui.mainCamera.transform.localPosition
				local var_218_2 = Vector3.New(0, 0, 10) + Vector3.New(var_218_1.x, var_218_1.y, 0)
				local var_218_3 = arg_215_1.bgs_.STwhite

				var_218_3.transform.localPosition = var_218_2
				var_218_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_4 = var_218_3:GetComponent("SpriteRenderer")

				if var_218_4 and var_218_4.sprite then
					local var_218_5 = (var_218_3.transform.localPosition - var_218_1).z
					local var_218_6 = manager.ui.mainCameraCom_
					local var_218_7 = 2 * var_218_5 * Mathf.Tan(var_218_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_8 = var_218_7 * var_218_6.aspect
					local var_218_9 = var_218_4.sprite.bounds.size.x
					local var_218_10 = var_218_4.sprite.bounds.size.y
					local var_218_11 = var_218_8 / var_218_9
					local var_218_12 = var_218_7 / var_218_10
					local var_218_13 = var_218_12 < var_218_11 and var_218_11 or var_218_12

					var_218_3.transform.localScale = Vector3.New(var_218_13, var_218_13, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "STwhite" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0

				local var_218_15 = arg_215_1:GetWordFromCfg(926082050)
				local var_218_16 = arg_215_1:FormatText(var_218_15.content)

				arg_215_1.fswt_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_17 = 0.633333333333336

			if var_218_17 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_18 = 38
			local var_218_19 = 2.53333333333333
			local var_218_20 = arg_215_1:GetWordFromCfg(926082050)
			local var_218_21 = arg_215_1:FormatText(var_218_20.content)
			local var_218_22, var_218_23 = arg_215_1:GetPercentByPara(var_218_21, 1)

			if var_218_17 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_24 = var_218_18 <= 0 and var_218_19 or var_218_19 * ((var_218_23 - arg_215_1.typewritterCharCountI18N) / var_218_18)

				if var_218_24 > 0 and var_218_19 < var_218_24 then
					arg_215_1.talkMaxDuration = var_218_24

					if var_218_24 + var_218_17 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_24 + var_218_17
					end
				end
			end

			local var_218_25 = 2.53333333333333
			local var_218_26 = math.max(var_218_25, arg_215_1.talkMaxDuration)

			if var_218_17 <= arg_215_1.time_ and arg_215_1.time_ < var_218_17 + var_218_26 then
				local var_218_27 = (arg_215_1.time_ - var_218_17) / var_218_26

				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_22, var_218_27)
				arg_215_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_17 + var_218_26 and arg_215_1.time_ < var_218_17 + var_218_26 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_22

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_23
			end

			local var_218_28 = 0.5
			local var_218_29 = 8.1
			local var_218_30 = manager.audio:GetVoiceLength("story_v_out_926082", "926082050", "0") / 1000

			if var_218_30 > 0 and var_218_29 < var_218_30 and var_218_30 + var_218_28 > arg_215_1.duration_ then
				local var_218_31 = var_218_30

				arg_215_1.duration_ = var_218_30 + var_218_28
			end

			if var_218_28 < arg_215_1.time_ and arg_215_1.time_ <= var_218_28 + arg_218_0 then
				local var_218_32 = "play"
				local var_218_33 = "voice"

				arg_215_1:AudioAction(var_218_32, var_218_33, "story_v_out_926082", "926082050", "0")
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play926082051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 926082051
		arg_219_1.duration_ = 8.63

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play926082052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0

				local var_222_1 = arg_219_1:GetWordFromCfg(926082051)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.fswt_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_3 = 0.194687306880951

			if var_222_3 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_4 = 42
			local var_222_5 = 2.8
			local var_222_6 = arg_219_1:GetWordFromCfg(926082051)
			local var_222_7 = arg_219_1:FormatText(var_222_6.content)
			local var_222_8, var_222_9 = arg_219_1:GetPercentByPara(var_222_7, 1)

			if var_222_3 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_10 = var_222_4 <= 0 and var_222_5 or var_222_5 * ((var_222_9 - arg_219_1.typewritterCharCountI18N) / var_222_4)

				if var_222_10 > 0 and var_222_5 < var_222_10 then
					arg_219_1.talkMaxDuration = var_222_10

					if var_222_10 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_3
					end
				end
			end

			local var_222_11 = 2.8
			local var_222_12 = math.max(var_222_11, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_12 then
				local var_222_13 = (arg_219_1.time_ - var_222_3) / var_222_12

				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_8, var_222_13)
				arg_219_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_12 and arg_219_1.time_ < var_222_3 + var_222_12 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_8

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_9
			end

			local var_222_14 = 0.194687306880951
			local var_222_15 = 8.433
			local var_222_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082051", "0") / 1000

			if var_222_16 > 0 and var_222_15 < var_222_16 and var_222_16 + var_222_14 > arg_219_1.duration_ then
				local var_222_17 = var_222_16

				arg_219_1.duration_ = var_222_16 + var_222_14
			end

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				local var_222_18 = "play"
				local var_222_19 = "voice"

				arg_219_1:AudioAction(var_222_18, var_222_19, "story_v_out_926082", "926082051", "0")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play926082052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 926082052
		arg_223_1.duration_ = 2.63

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play926082053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_1 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_226_1.offsetMin = Vector2.New(400, 154.9)
				var_226_1.offsetMax = Vector2.New(-335.4, -171.3)

				local var_226_2 = arg_223_1:GetWordFromCfg(419160)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.cswt_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 220
				arg_223_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_4 = 0

			if var_226_4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0

				local var_226_5 = arg_223_1:GetWordFromCfg(926082052)
				local var_226_6 = arg_223_1:FormatText(var_226_5.content)

				arg_223_1.fswt_.text = var_226_6

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_7 = 0.633333333333334

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_8 = 8
			local var_226_9 = 0.533333333333333
			local var_226_10 = arg_223_1:GetWordFromCfg(926082052)
			local var_226_11 = arg_223_1:FormatText(var_226_10.content)
			local var_226_12, var_226_13 = arg_223_1:GetPercentByPara(var_226_11, 1)

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_14 = var_226_8 <= 0 and var_226_9 or var_226_9 * ((var_226_13 - arg_223_1.typewritterCharCountI18N) / var_226_8)

				if var_226_14 > 0 and var_226_9 < var_226_14 then
					arg_223_1.talkMaxDuration = var_226_14

					if var_226_14 + var_226_7 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_7
					end
				end
			end

			local var_226_15 = 0.533333333333333
			local var_226_16 = math.max(var_226_15, arg_223_1.talkMaxDuration)

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_16 then
				local var_226_17 = (arg_223_1.time_ - var_226_7) / var_226_16

				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_12, var_226_17)
				arg_223_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_7 + var_226_16 and arg_223_1.time_ < var_226_7 + var_226_16 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_12

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_13
			end

			local var_226_18 = 0.633333333333334
			local var_226_19 = 2
			local var_226_20 = manager.audio:GetVoiceLength("story_v_out_926082", "926082052", "0") / 1000

			if var_226_20 > 0 and var_226_19 < var_226_20 and var_226_20 + var_226_18 > arg_223_1.duration_ then
				local var_226_21 = var_226_20

				arg_223_1.duration_ = var_226_20 + var_226_18
			end

			if var_226_18 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				local var_226_22 = "play"
				local var_226_23 = "voice"

				arg_223_1:AudioAction(var_226_22, var_226_23, "story_v_out_926082", "926082052", "0")
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play926082053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 926082053
		arg_227_1.duration_ = 11.43

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play926082054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.fswbg_:SetActive(true)
				arg_227_1.dialog_:SetActive(false)

				arg_227_1.fswtw_.percent = 0

				local var_230_1 = arg_227_1:GetWordFromCfg(926082053)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.fswt_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.fswt_)

				arg_227_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_227_1.fswtw_:SetDirty()

				arg_227_1.typewritterCharCountI18N = 0

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_3 = 0.633333333333334

			if var_230_3 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.var_.oldValueTypewriter = arg_227_1.fswtw_.percent
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_4 = 46
			local var_230_5 = 3.06666666666667
			local var_230_6 = arg_227_1:GetWordFromCfg(926082053)
			local var_230_7 = arg_227_1:FormatText(var_230_6.content)
			local var_230_8, var_230_9 = arg_227_1:GetPercentByPara(var_230_7, 1)

			if var_230_3 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				local var_230_10 = var_230_4 <= 0 and var_230_5 or var_230_5 * ((var_230_9 - arg_227_1.typewritterCharCountI18N) / var_230_4)

				if var_230_10 > 0 and var_230_5 < var_230_10 then
					arg_227_1.talkMaxDuration = var_230_10

					if var_230_10 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_3
					end
				end
			end

			local var_230_11 = 3.06666666666667
			local var_230_12 = math.max(var_230_11, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_12 then
				local var_230_13 = (arg_227_1.time_ - var_230_3) / var_230_12

				arg_227_1.fswtw_.percent = Mathf.Lerp(arg_227_1.var_.oldValueTypewriter, var_230_8, var_230_13)
				arg_227_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_227_1.fswtw_:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_12 and arg_227_1.time_ < var_230_3 + var_230_12 + arg_230_0 then
				arg_227_1.fswtw_.percent = var_230_8

				arg_227_1.fswtw_:SetDirty()
				arg_227_1:ShowNextGo(true)

				arg_227_1.typewritterCharCountI18N = var_230_9
			end

			local var_230_14 = 0.533333333333333
			local var_230_15 = 10.9
			local var_230_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082053", "0") / 1000

			if var_230_16 > 0 and var_230_15 < var_230_16 and var_230_16 + var_230_14 > arg_227_1.duration_ then
				local var_230_17 = var_230_16

				arg_227_1.duration_ = var_230_16 + var_230_14
			end

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				local var_230_18 = "play"
				local var_230_19 = "voice"

				arg_227_1:AudioAction(var_230_18, var_230_19, "story_v_out_926082", "926082053", "0")
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play926082054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 926082054
		arg_231_1.duration_ = 5.18

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play926082055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(false)
				arg_231_1.dialog_:SetActive(false)
				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_1 = 0.0166666666666667

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(false)
				arg_231_1.dialog_:SetActive(false)
				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_2 = 0
			local var_234_3 = 0.3

			if var_234_2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				local var_234_4 = "play"
				local var_234_5 = "music"

				arg_231_1:AudioAction(var_234_4, var_234_5, "ui_battle", "ui_battle_stopbgm", "")

				local var_234_6 = ""
				local var_234_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_234_7 ~= "" then
					if arg_231_1.bgmTxt_.text ~= var_234_7 and arg_231_1.bgmTxt_.text ~= "" then
						if arg_231_1.bgmTxt2_.text ~= "" then
							arg_231_1.bgmTxt_.text = arg_231_1.bgmTxt2_.text
						end

						arg_231_1.bgmTxt2_.text = var_234_7

						arg_231_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_231_1.bgmTxt_.text = var_234_7
						arg_231_1.bgmTxt2_.text = var_234_7
					end

					if arg_231_1.bgmTimer then
						arg_231_1.bgmTimer:Stop()

						arg_231_1.bgmTimer = nil
					end

					if arg_231_1.settingData.show_music_name == 1 then
						arg_231_1.musicController:SetSelectedState("show")
						arg_231_1.musicAnimator_:Play("open", 0, 0)

						if arg_231_1.settingData.music_time ~= 0 then
							arg_231_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_231_1.settingData.music_time), function()
								if arg_231_1 == nil or isNil(arg_231_1.bgmTxt_) then
									return
								end

								arg_231_1.musicController:SetSelectedState("hide")
								arg_231_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_234_8 = 0
			local var_234_9 = 1

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				local var_234_10 = "play"
				local var_234_11 = "effect"

				arg_231_1:AudioAction(var_234_10, var_234_11, "se_story_143", "se_story_143_bell03", "")
			end

			local var_234_12 = "104701"

			if arg_231_1.actors_[var_234_12] == nil then
				local var_234_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_234_13) then
					local var_234_14 = Object.Instantiate(var_234_13, arg_231_1.canvasGo_.transform)

					var_234_14.transform:SetSiblingIndex(1)

					var_234_14.name = var_234_12
					var_234_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_231_1.actors_[var_234_12] = var_234_14

					local var_234_15 = var_234_14:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_231_1.isInRecall_ then
						for iter_234_0, iter_234_1 in ipairs(var_234_15) do
							iter_234_1.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_234_16 = arg_231_1.actors_["104701"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				local var_234_18 = var_234_16.childCount

				for iter_234_2 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_2)

					if var_234_19.name == "split_4" or not string.find(var_234_19.name, "split") then
						var_234_19.gameObject:SetActive(true)
					else
						var_234_19.gameObject:SetActive(false)
					end
				end
			end

			local var_234_20 = 0.1

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-41, -375, -352.4)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, var_234_22, var_234_21)
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-41, -375, -352.4)
			end

			local var_234_23 = arg_231_1.actors_["104701"].transform
			local var_234_24 = 0.1

			if var_234_24 < arg_231_1.time_ and arg_231_1.time_ <= var_234_24 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_23.localPosition
				var_234_23.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				local var_234_25 = var_234_23.childCount

				for iter_234_3 = 0, var_234_25 - 1 do
					local var_234_26 = var_234_23:GetChild(iter_234_3)

					if var_234_26.name == "split_4" or not string.find(var_234_26.name, "split") then
						var_234_26.gameObject:SetActive(true)
					else
						var_234_26.gameObject:SetActive(false)
					end
				end
			end

			local var_234_27 = 0.0666666666666667

			if var_234_24 <= arg_231_1.time_ and arg_231_1.time_ < var_234_24 + var_234_27 then
				local var_234_28 = (arg_231_1.time_ - var_234_24) / var_234_27
				local var_234_29 = Vector3.New(-41, -388.2, -352.4)

				var_234_23.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, var_234_29, var_234_28)
			end

			if arg_231_1.time_ >= var_234_24 + var_234_27 and arg_231_1.time_ < var_234_24 + var_234_27 + arg_234_0 then
				var_234_23.localPosition = Vector3.New(-41, -388.2, -352.4)
			end

			local var_234_30 = arg_231_1.actors_["104701"].transform
			local var_234_31 = 0.166666666666667

			if var_234_31 < arg_231_1.time_ and arg_231_1.time_ <= var_234_31 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_30.localPosition
				var_234_30.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				local var_234_32 = var_234_30.childCount

				for iter_234_4 = 0, var_234_32 - 1 do
					local var_234_33 = var_234_30:GetChild(iter_234_4)

					if var_234_33.name == "split_4" or not string.find(var_234_33.name, "split") then
						var_234_33.gameObject:SetActive(true)
					else
						var_234_33.gameObject:SetActive(false)
					end
				end
			end

			local var_234_34 = 0.001

			if var_234_31 <= arg_231_1.time_ and arg_231_1.time_ < var_234_31 + var_234_34 then
				local var_234_35 = (arg_231_1.time_ - var_234_31) / var_234_34
				local var_234_36 = Vector3.New(-41, -375, -352.4)

				var_234_30.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, var_234_36, var_234_35)
			end

			if arg_231_1.time_ >= var_234_31 + var_234_34 and arg_231_1.time_ < var_234_31 + var_234_34 + arg_234_0 then
				var_234_30.localPosition = Vector3.New(-41, -375, -352.4)
			end

			local var_234_37 = 0

			if var_234_37 < arg_231_1.time_ and arg_231_1.time_ <= var_234_37 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			local var_234_38 = 0.8

			if arg_231_1.time_ >= var_234_37 + var_234_38 and arg_231_1.time_ < var_234_37 + var_234_38 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_39 = 0.183333333333333
			local var_234_40 = 0.25

			if var_234_39 < arg_231_1.time_ and arg_231_1.time_ <= var_234_39 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_41 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_41:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_231_1.dialogCg_.alpha = arg_236_0
				end))
				var_234_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_42 = arg_231_1:FormatText(StoryNameCfg[7].name)

				arg_231_1.leftNameTxt_.text = var_234_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_43 = arg_231_1:GetWordFromCfg(926082054)
				local var_234_44 = arg_231_1:FormatText(var_234_43.content)

				arg_231_1.text_.text = var_234_44

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_45 = 10
				local var_234_46 = utf8.len(var_234_44)
				local var_234_47 = var_234_45 <= 0 and var_234_40 or var_234_40 * (var_234_46 / var_234_45)

				if var_234_47 > 0 and var_234_40 < var_234_47 then
					arg_231_1.talkMaxDuration = var_234_47
					var_234_39 = var_234_39 + 0.3

					if var_234_47 + var_234_39 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_47 + var_234_39
					end
				end

				arg_231_1.text_.text = var_234_44
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_48 = var_234_39 + 0.3
			local var_234_49 = math.max(var_234_40, arg_231_1.talkMaxDuration)

			if var_234_48 <= arg_231_1.time_ and arg_231_1.time_ < var_234_48 + var_234_49 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_48) / var_234_49

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_48 + var_234_49 and arg_231_1.time_ < var_234_48 + var_234_49 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.245,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-28.04, -1700.12, -265.92),
					endPos = Vector3.New(-41, -375, -352.4),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0666666666666667,
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-41, -375, -352.4),
					endPos = Vector3.New(-41, -388.2, -352.4),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0166666666666667,
				startTime = 0.166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-41, -388.2, -352.4),
					endPos = Vector3.New(-41, -375, -352.4),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play926082055 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 926082055
		arg_238_1.duration_ = 10.2

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play926082056(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10144"]
			local var_241_1 = 0.766666666666667

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10144 == nil then
				arg_238_1.var_.actorSpriteComps10144 = var_241_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.actorSpriteComps10144 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								local var_241_4 = Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, var_241_3)
								local var_241_5 = Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, var_241_3)
								local var_241_6 = Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, var_241_3)

								iter_241_1.color = Color.New(var_241_4, var_241_5, var_241_6)
							else
								local var_241_7 = Mathf.Lerp(iter_241_1.color.r, 1, var_241_3)

								iter_241_1.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10144 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_241_3 then
						if arg_238_1.isInRecall_ then
							iter_241_3.color = arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_241_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps10144 = nil
			end

			local var_241_8 = 1.23333333333333

			if var_241_8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.cswbg_:SetActive(false)
			end

			local var_241_9 = 1.23333333333333

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				local var_241_10 = manager.ui.mainCamera.transform.localPosition
				local var_241_11 = Vector3.New(0, 0, 10) + Vector3.New(var_241_10.x, var_241_10.y, 0)
				local var_241_12 = arg_238_1.bgs_.I20f

				var_241_12.transform.localPosition = var_241_11
				var_241_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_13 = var_241_12:GetComponent("SpriteRenderer")

				if var_241_13 and var_241_13.sprite then
					local var_241_14 = (var_241_12.transform.localPosition - var_241_10).z
					local var_241_15 = manager.ui.mainCameraCom_
					local var_241_16 = 2 * var_241_14 * Mathf.Tan(var_241_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_241_17 = var_241_16 * var_241_15.aspect
					local var_241_18 = var_241_13.sprite.bounds.size.x
					local var_241_19 = var_241_13.sprite.bounds.size.y
					local var_241_20 = var_241_17 / var_241_18
					local var_241_21 = var_241_16 / var_241_19
					local var_241_22 = var_241_21 < var_241_20 and var_241_20 or var_241_21

					var_241_12.transform.localScale = Vector3.New(var_241_22, var_241_22, 0)
				end

				for iter_241_4, iter_241_5 in pairs(arg_238_1.bgs_) do
					if iter_241_4 ~= "I20f" then
						iter_241_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_23 = 0

			if var_241_23 < arg_238_1.time_ and arg_238_1.time_ <= var_241_23 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_24 = 1.23333333333333

			if var_241_23 <= arg_238_1.time_ and arg_238_1.time_ < var_241_23 + var_241_24 then
				local var_241_25 = (arg_238_1.time_ - var_241_23) / var_241_24
				local var_241_26 = Color.New(0, 0, 0)

				var_241_26.a = Mathf.Lerp(0, 1, var_241_25)
				arg_238_1.mask_.color = var_241_26
			end

			if arg_238_1.time_ >= var_241_23 + var_241_24 and arg_238_1.time_ < var_241_23 + var_241_24 + arg_241_0 then
				local var_241_27 = Color.New(0, 0, 0)

				var_241_27.a = 1
				arg_238_1.mask_.color = var_241_27
			end

			local var_241_28 = 1.23333333333333

			if var_241_28 < arg_238_1.time_ and arg_238_1.time_ <= var_241_28 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_29 = 2

			if var_241_28 <= arg_238_1.time_ and arg_238_1.time_ < var_241_28 + var_241_29 then
				local var_241_30 = (arg_238_1.time_ - var_241_28) / var_241_29
				local var_241_31 = Color.New(0, 0, 0)

				var_241_31.a = Mathf.Lerp(1, 0, var_241_30)
				arg_238_1.mask_.color = var_241_31
			end

			if arg_238_1.time_ >= var_241_28 + var_241_29 and arg_238_1.time_ < var_241_28 + var_241_29 + arg_241_0 then
				local var_241_32 = Color.New(0, 0, 0)
				local var_241_33 = 0

				arg_238_1.mask_.enabled = false
				var_241_32.a = var_241_33
				arg_238_1.mask_.color = var_241_32
			end

			local var_241_34 = 0.766666666666667
			local var_241_35 = 0.3

			if var_241_34 < arg_238_1.time_ and arg_238_1.time_ <= var_241_34 + arg_241_0 then
				local var_241_36 = "play"
				local var_241_37 = "music"

				arg_238_1:AudioAction(var_241_36, var_241_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_241_38 = ""
				local var_241_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_241_39 ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_39 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_39

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_39
						arg_238_1.bgmTxt2_.text = var_241_39
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_40 = 1.23333333333333
			local var_241_41 = 1

			if var_241_40 < arg_238_1.time_ and arg_238_1.time_ <= var_241_40 + arg_241_0 then
				local var_241_42 = "play"
				local var_241_43 = "music"

				arg_238_1:AudioAction(var_241_42, var_241_43, "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_241_44 = ""
				local var_241_45 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if var_241_45 ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_45 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_45

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_45
						arg_238_1.bgmTxt2_.text = var_241_45
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_46 = arg_238_1.actors_["104701"].transform
			local var_241_47 = 1.23333333333333

			if var_241_47 < arg_238_1.time_ and arg_238_1.time_ <= var_241_47 + arg_241_0 then
				arg_238_1.var_.moveOldPos104701 = var_241_46.localPosition
				var_241_46.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("104701", 7)

				local var_241_48 = var_241_46.childCount

				for iter_241_6 = 0, var_241_48 - 1 do
					local var_241_49 = var_241_46:GetChild(iter_241_6)

					if var_241_49.name == "split_4" or not string.find(var_241_49.name, "split") then
						var_241_49.gameObject:SetActive(true)
					else
						var_241_49.gameObject:SetActive(false)
					end
				end
			end

			local var_241_50 = 0.001

			if var_241_47 <= arg_238_1.time_ and arg_238_1.time_ < var_241_47 + var_241_50 then
				local var_241_51 = (arg_238_1.time_ - var_241_47) / var_241_50
				local var_241_52 = Vector3.New(0, -2000, 0)

				var_241_46.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos104701, var_241_52, var_241_51)
			end

			if arg_238_1.time_ >= var_241_47 + var_241_50 and arg_238_1.time_ < var_241_47 + var_241_50 + arg_241_0 then
				var_241_46.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_53 = 3.03333333333333
			local var_241_54 = 0.575

			if var_241_53 < arg_238_1.time_ and arg_238_1.time_ <= var_241_53 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_55 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_55:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_238_1.dialogCg_.alpha = arg_244_0
				end))
				var_241_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_56 = arg_238_1:FormatText(StoryNameCfg[1297].name)

				arg_238_1.leftNameTxt_.text = var_241_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_4")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_57 = arg_238_1:GetWordFromCfg(926082055)
				local var_241_58 = arg_238_1:FormatText(var_241_57.content)

				arg_238_1.text_.text = var_241_58

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_59 = 23
				local var_241_60 = utf8.len(var_241_58)
				local var_241_61 = var_241_59 <= 0 and var_241_54 or var_241_54 * (var_241_60 / var_241_59)

				if var_241_61 > 0 and var_241_54 < var_241_61 then
					arg_238_1.talkMaxDuration = var_241_61
					var_241_53 = var_241_53 + 0.3

					if var_241_61 + var_241_53 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_61 + var_241_53
					end
				end

				arg_238_1.text_.text = var_241_58
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082055", "story_v_out_926082.awb") ~= 0 then
					local var_241_62 = manager.audio:GetVoiceLength("story_v_out_926082", "926082055", "story_v_out_926082.awb") / 1000

					if var_241_62 + var_241_53 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_62 + var_241_53
					end

					if var_241_57.prefab_name ~= "" and arg_238_1.actors_[var_241_57.prefab_name] ~= nil then
						local var_241_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_57.prefab_name].transform, "story_v_out_926082", "926082055", "story_v_out_926082.awb")

						arg_238_1:RecordAudio("926082055", var_241_63)
						arg_238_1:RecordAudio("926082055", var_241_63)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_926082", "926082055", "story_v_out_926082.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_926082", "926082055", "story_v_out_926082.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_64 = var_241_53 + 0.3
			local var_241_65 = math.max(var_241_54, arg_238_1.talkMaxDuration)

			if var_241_64 <= arg_238_1.time_ and arg_238_1.time_ < var_241_64 + var_241_65 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_64) / var_241_65

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_64 + var_241_65 and arg_238_1.time_ < var_241_64 + var_241_65 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = false,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0166666666666667,
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play926082056 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 926082056
		arg_246_1.duration_ = 3.03

		local var_246_0 = {
			zh = 2.533,
			ja = 3.033
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play926082057(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["128404"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps128404 == nil then
				arg_246_1.var_.actorSpriteComps128404 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps128404 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								local var_249_4 = Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor1.r, var_249_3)
								local var_249_5 = Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor1.g, var_249_3)
								local var_249_6 = Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor1.b, var_249_3)

								iter_249_1.color = Color.New(var_249_4, var_249_5, var_249_6)
							else
								local var_249_7 = Mathf.Lerp(iter_249_1.color.r, 1, var_249_3)

								iter_249_1.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps128404 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_249_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps128404 = nil
			end

			local var_249_8 = arg_246_1.actors_["10144"]
			local var_249_9 = 0

			if var_249_9 < arg_246_1.time_ and arg_246_1.time_ <= var_249_9 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.actorSpriteComps10144 == nil then
				arg_246_1.var_.actorSpriteComps10144 = var_249_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_10 = 0.2

			if var_249_9 <= arg_246_1.time_ and arg_246_1.time_ < var_249_9 + var_249_10 and not isNil(var_249_8) then
				local var_249_11 = (arg_246_1.time_ - var_249_9) / var_249_10

				if arg_246_1.var_.actorSpriteComps10144 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								local var_249_12 = Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, var_249_11)
								local var_249_13 = Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, var_249_11)
								local var_249_14 = Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, var_249_11)

								iter_249_5.color = Color.New(var_249_12, var_249_13, var_249_14)
							else
								local var_249_15 = Mathf.Lerp(iter_249_5.color.r, 0.5, var_249_11)

								iter_249_5.color = Color.New(var_249_15, var_249_15, var_249_15)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_9 + var_249_10 and arg_246_1.time_ < var_249_9 + var_249_10 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.actorSpriteComps10144 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_249_7 then
						if arg_246_1.isInRecall_ then
							iter_249_7.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps10144 = nil
			end

			local var_249_16 = arg_246_1.actors_["128404"].transform
			local var_249_17 = 0

			if var_249_17 < arg_246_1.time_ and arg_246_1.time_ <= var_249_17 + arg_249_0 then
				arg_246_1.var_.moveOldPos128404 = var_249_16.localPosition
				var_249_16.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("128404", 3)

				local var_249_18 = var_249_16.childCount

				for iter_249_8 = 0, var_249_18 - 1 do
					local var_249_19 = var_249_16:GetChild(iter_249_8)

					if var_249_19.name == "split_4" or not string.find(var_249_19.name, "split") then
						var_249_19.gameObject:SetActive(true)
					else
						var_249_19.gameObject:SetActive(false)
					end
				end
			end

			local var_249_20 = 0.001

			if var_249_17 <= arg_246_1.time_ and arg_246_1.time_ < var_249_17 + var_249_20 then
				local var_249_21 = (arg_246_1.time_ - var_249_17) / var_249_20
				local var_249_22 = Vector3.New(-16.1, -362, -375)

				var_249_16.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos128404, var_249_22, var_249_21)
			end

			if arg_246_1.time_ >= var_249_17 + var_249_20 and arg_246_1.time_ < var_249_17 + var_249_20 + arg_249_0 then
				var_249_16.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_249_23 = arg_246_1.actors_["128404"]
			local var_249_24 = 0

			if var_249_24 < arg_246_1.time_ and arg_246_1.time_ <= var_249_24 + arg_249_0 then
				local var_249_25 = var_249_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_249_25 then
					arg_246_1.var_.alphaOldValue128404 = var_249_25.alpha
					arg_246_1.var_.characterEffect128404 = var_249_25
				end

				arg_246_1.var_.alphaOldValue128404 = 0
			end

			local var_249_26 = 0.2

			if var_249_24 <= arg_246_1.time_ and arg_246_1.time_ < var_249_24 + var_249_26 then
				local var_249_27 = (arg_246_1.time_ - var_249_24) / var_249_26
				local var_249_28 = Mathf.Lerp(arg_246_1.var_.alphaOldValue128404, 1, var_249_27)

				if arg_246_1.var_.characterEffect128404 then
					arg_246_1.var_.characterEffect128404.alpha = var_249_28
				end
			end

			if arg_246_1.time_ >= var_249_24 + var_249_26 and arg_246_1.time_ < var_249_24 + var_249_26 + arg_249_0 and arg_246_1.var_.characterEffect128404 then
				arg_246_1.var_.characterEffect128404.alpha = 1
			end

			local var_249_29 = 0
			local var_249_30 = 0.125

			if var_249_29 < arg_246_1.time_ and arg_246_1.time_ <= var_249_29 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_31 = arg_246_1:FormatText(StoryNameCfg[6].name)

				arg_246_1.leftNameTxt_.text = var_249_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_32 = arg_246_1:GetWordFromCfg(926082056)
				local var_249_33 = arg_246_1:FormatText(var_249_32.content)

				arg_246_1.text_.text = var_249_33

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_34 = 5
				local var_249_35 = utf8.len(var_249_33)
				local var_249_36 = var_249_34 <= 0 and var_249_30 or var_249_30 * (var_249_35 / var_249_34)

				if var_249_36 > 0 and var_249_30 < var_249_36 then
					arg_246_1.talkMaxDuration = var_249_36

					if var_249_36 + var_249_29 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_36 + var_249_29
					end
				end

				arg_246_1.text_.text = var_249_33
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082056", "story_v_out_926082.awb") ~= 0 then
					local var_249_37 = manager.audio:GetVoiceLength("story_v_out_926082", "926082056", "story_v_out_926082.awb") / 1000

					if var_249_37 + var_249_29 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_37 + var_249_29
					end

					if var_249_32.prefab_name ~= "" and arg_246_1.actors_[var_249_32.prefab_name] ~= nil then
						local var_249_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_32.prefab_name].transform, "story_v_out_926082", "926082056", "story_v_out_926082.awb")

						arg_246_1:RecordAudio("926082056", var_249_38)
						arg_246_1:RecordAudio("926082056", var_249_38)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_926082", "926082056", "story_v_out_926082.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_926082", "926082056", "story_v_out_926082.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_39 = math.max(var_249_30, arg_246_1.talkMaxDuration)

			if var_249_29 <= arg_246_1.time_ and arg_246_1.time_ < var_249_29 + var_249_39 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_29) / var_249_39

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_29 + var_249_39 and arg_246_1.time_ < var_249_29 + var_249_39 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play926082057 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 926082057
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play926082058(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["128404"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps128404 == nil then
				arg_250_1.var_.actorSpriteComps128404 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps128404 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 0.5, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps128404 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_253_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps128404 = nil
			end

			local var_253_8 = 0
			local var_253_9 = 0.15

			if var_253_8 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_10 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_11 = arg_250_1:GetWordFromCfg(926082057)
				local var_253_12 = arg_250_1:FormatText(var_253_11.content)

				arg_250_1.text_.text = var_253_12

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 6
				local var_253_14 = utf8.len(var_253_12)
				local var_253_15 = var_253_13 <= 0 and var_253_9 or var_253_9 * (var_253_14 / var_253_13)

				if var_253_15 > 0 and var_253_9 < var_253_15 then
					arg_250_1.talkMaxDuration = var_253_15

					if var_253_15 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_15 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_12
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_16 and arg_250_1.time_ < var_253_8 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play926082058 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 926082058
		arg_254_1.duration_ = 8.5

		local var_254_0 = {
			zh = 8.5,
			ja = 7.433
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play926082059(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["128404"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps128404 == nil then
				arg_254_1.var_.actorSpriteComps128404 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps128404 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 1, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps128404 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps128404 = nil
			end

			local var_257_8 = arg_254_1.actors_["128404"].transform
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.var_.moveOldPos128404 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("128404", 3)

				local var_257_10 = var_257_8.childCount

				for iter_257_4 = 0, var_257_10 - 1 do
					local var_257_11 = var_257_8:GetChild(iter_257_4)

					if var_257_11.name == "split_4" or not string.find(var_257_11.name, "split") then
						var_257_11.gameObject:SetActive(true)
					else
						var_257_11.gameObject:SetActive(false)
					end
				end
			end

			local var_257_12 = 0.001

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_12 then
				local var_257_13 = (arg_254_1.time_ - var_257_9) / var_257_12
				local var_257_14 = Vector3.New(-16.1, -362, -375)

				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos128404, var_257_14, var_257_13)
			end

			if arg_254_1.time_ >= var_257_9 + var_257_12 and arg_254_1.time_ < var_257_9 + var_257_12 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_257_15 = 0
			local var_257_16 = 0.675

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[6].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(926082058)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 27
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082058", "story_v_out_926082.awb") ~= 0 then
					local var_257_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082058", "story_v_out_926082.awb") / 1000

					if var_257_23 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_23 + var_257_15
					end

					if var_257_18.prefab_name ~= "" and arg_254_1.actors_[var_257_18.prefab_name] ~= nil then
						local var_257_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_18.prefab_name].transform, "story_v_out_926082", "926082058", "story_v_out_926082.awb")

						arg_254_1:RecordAudio("926082058", var_257_24)
						arg_254_1:RecordAudio("926082058", var_257_24)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_926082", "926082058", "story_v_out_926082.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_926082", "926082058", "story_v_out_926082.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_25 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_25 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_25

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_25 and arg_254_1.time_ < var_257_15 + var_257_25 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play926082059 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 926082059
		arg_258_1.duration_ = 1

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"

			SetActive(arg_258_1.choicesGo_, true)

			for iter_259_0, iter_259_1 in ipairs(arg_258_1.choices_) do
				local var_259_0 = iter_259_0 <= 1

				SetActive(iter_259_1.go, var_259_0)
			end

			arg_258_1.choices_[1].txt.text = arg_258_1:FormatText(StoryChoiceCfg[1334].name)
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play926082060(arg_258_1)
			end

			arg_258_1:RecordChoiceLog(926082059, 1334)
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["128404"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps128404 == nil then
				arg_258_1.var_.actorSpriteComps128404 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps128404 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								local var_261_4 = Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor2.r, var_261_3)
								local var_261_5 = Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor2.g, var_261_3)
								local var_261_6 = Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor2.b, var_261_3)

								iter_261_1.color = Color.New(var_261_4, var_261_5, var_261_6)
							else
								local var_261_7 = Mathf.Lerp(iter_261_1.color.r, 0.5, var_261_3)

								iter_261_1.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps128404 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play926082060 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 926082060
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play926082061(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["128404"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = var_265_0.localPosition
				var_265_0.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 7)

				local var_265_2 = var_265_0.childCount

				for iter_265_0 = 0, var_265_2 - 1 do
					local var_265_3 = var_265_0:GetChild(iter_265_0)

					if var_265_3.name == "" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_4 then
				local var_265_5 = (arg_262_1.time_ - var_265_1) / var_265_4
				local var_265_6 = Vector3.New(0, -2000, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, var_265_6, var_265_5)
			end

			if arg_262_1.time_ >= var_265_1 + var_265_4 and arg_262_1.time_ < var_265_1 + var_265_4 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_7 = 0
			local var_265_8 = 0.9

			if var_265_7 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_9 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_10 = arg_262_1:GetWordFromCfg(926082060)
				local var_265_11 = arg_262_1:FormatText(var_265_10.content)

				arg_262_1.text_.text = var_265_11

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_12 = 36
				local var_265_13 = utf8.len(var_265_11)
				local var_265_14 = var_265_12 <= 0 and var_265_8 or var_265_8 * (var_265_13 / var_265_12)

				if var_265_14 > 0 and var_265_8 < var_265_14 then
					arg_262_1.talkMaxDuration = var_265_14

					if var_265_14 + var_265_7 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_7
					end
				end

				arg_262_1.text_.text = var_265_11
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_15 = math.max(var_265_8, arg_262_1.talkMaxDuration)

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_15 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_7) / var_265_15

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_7 + var_265_15 and arg_262_1.time_ < var_265_7 + var_265_15 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play926082061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 926082061
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play926082062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.65

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(926082061)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 26
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play926082062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 926082062
		arg_270_1.duration_ = 6.73

		local var_270_0 = {
			zh = 4.033,
			ja = 6.733
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
			arg_270_1.auto_ = false
		end

		function arg_270_1.playNext_(arg_272_0)
			arg_270_1.onStoryFinished_()
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10144"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps10144 == nil then
				arg_270_1.var_.actorSpriteComps10144 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps10144 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 1, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps10144 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps10144 = nil
			end

			local var_273_8 = arg_270_1.actors_["10144"].transform
			local var_273_9 = 0

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.var_.moveOldPos10144 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10144", 3)

				local var_273_10 = var_273_8.childCount

				for iter_273_4 = 0, var_273_10 - 1 do
					local var_273_11 = var_273_8:GetChild(iter_273_4)

					if var_273_11.name == "split_4" or not string.find(var_273_11.name, "split") then
						var_273_11.gameObject:SetActive(true)
					else
						var_273_11.gameObject:SetActive(false)
					end
				end
			end

			local var_273_12 = 0.001

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_12 then
				local var_273_13 = (arg_270_1.time_ - var_273_9) / var_273_12
				local var_273_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10144, var_273_14, var_273_13)
			end

			if arg_270_1.time_ >= var_273_9 + var_273_12 and arg_270_1.time_ < var_273_9 + var_273_12 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_273_15 = 0
			local var_273_16 = 0.4

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[1297].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(926082062)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 16
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082062", "story_v_out_926082.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_926082", "926082062", "story_v_out_926082.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_926082", "926082062", "story_v_out_926082.awb")

						arg_270_1:RecordAudio("926082062", var_273_24)
						arg_270_1:RecordAudio("926082062", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_926082", "926082062", "story_v_out_926082.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_926082", "926082062", "story_v_out_926082.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I20f",
		"TextureConfig/Background/STwhite",
		"SofdecAsset/activity/activity_4_3_08_402501_start.usm"
	},
	voices = {
		"story_v_out_926082.awb"
	},
	skipMarkers = {
		926082049
	}
}
