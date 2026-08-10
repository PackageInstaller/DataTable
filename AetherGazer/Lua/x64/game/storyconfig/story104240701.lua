return {
	Play424071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424071001
		arg_1_1.duration_ = 8.6

		local var_1_0 = {
			zh = 6.433,
			ja = 8.6
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
				arg_1_0:Play424071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0115a"

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
				local var_4_5 = arg_1_1.bgs_.ST0115a

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
					if iter_4_0 ~= "ST0115a" then
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

			local var_4_24 = "1047"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

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

			local var_4_28 = arg_1_1.actors_["1047"].transform
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos1047 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1047", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(-38.9, -360, -319.3)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1047, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_4_35 = arg_1_1.actors_["1047"]
			local var_4_36 = 1.8

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1:SetSpriteNiuquEffect("1047", true)
			end

			local var_4_37 = arg_1_1.actors_["1047"]
			local var_4_38 = 1.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = var_4_37:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_39 then
					arg_1_1.var_.alphaOldValue1047 = var_4_39.alpha
					arg_1_1.var_.characterEffect1047 = var_4_39
				end
			end

			local var_4_40 = 0.034

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_38) / var_4_40
				local var_4_42 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1047, 0.6, var_4_41)

				if arg_1_1.var_.characterEffect1047 then
					arg_1_1.var_.characterEffect1047.alpha = var_4_42
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_40 and arg_1_1.time_ < var_4_38 + var_4_40 + arg_4_0 and arg_1_1.var_.characterEffect1047 then
				arg_1_1.var_.characterEffect1047.alpha = 0.6
			end

			local var_4_43 = 0
			local var_4_44 = 0.3

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 0.433333333333333
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 0.1
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "effect"

				arg_1_1:AudioAction(var_4_57, var_4_58, "se_story_146", "se_story_146_wind02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.45

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1296].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(424071001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 18
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071001", "story_v_out_424071.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_424071", "424071001", "story_v_out_424071.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_424071", "424071001", "story_v_out_424071.awb")

						arg_1_1:RecordAudio("424071001", var_4_69)
						arg_1_1:RecordAudio("424071001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424071", "424071001", "story_v_out_424071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424071", "424071001", "story_v_out_424071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play424071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.55

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(424071002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 22
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play424071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424071003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 1.8,
			ja = 3.433
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
				arg_13_0:Play424071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1047"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1047 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1047", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_2" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(-38.9, -360, -319.3)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1047, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_16_7 = 0
			local var_16_8 = 0.225

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_9 = arg_13_1:FormatText(StoryNameCfg[1296].name)

				arg_13_1.leftNameTxt_.text = var_16_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(424071003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 9
				local var_16_13 = utf8.len(var_16_11)
				local var_16_14 = var_16_12 <= 0 and var_16_8 or var_16_8 * (var_16_13 / var_16_12)

				if var_16_14 > 0 and var_16_8 < var_16_14 then
					arg_13_1.talkMaxDuration = var_16_14

					if var_16_14 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071003", "story_v_out_424071.awb") ~= 0 then
					local var_16_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071003", "story_v_out_424071.awb") / 1000

					if var_16_15 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_7
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_424071", "424071003", "story_v_out_424071.awb")

						arg_13_1:RecordAudio("424071003", var_16_16)
						arg_13_1:RecordAudio("424071003", var_16_16)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_424071", "424071003", "story_v_out_424071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_424071", "424071003", "story_v_out_424071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_7) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_7 + var_16_17 and arg_13_1.time_ < var_16_7 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play424071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424071004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.825

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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(424071004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 33
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
	Play424071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424071005
		arg_21_1.duration_ = 6.47

		local var_21_0 = {
			zh = 3.3,
			ja = 6.466
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
				arg_21_0:Play424071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.325

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1296].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(424071005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071005", "story_v_out_424071.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071005", "story_v_out_424071.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_424071", "424071005", "story_v_out_424071.awb")

						arg_21_1:RecordAudio("424071005", var_24_9)
						arg_21_1:RecordAudio("424071005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424071", "424071005", "story_v_out_424071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424071", "424071005", "story_v_out_424071.awb")
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
	Play424071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424071006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play424071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.425

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(424071006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 17
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424071007
		arg_29_1.duration_ = 10.67

		local var_29_0 = {
			zh = 5.533,
			ja = 10.666
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
				arg_29_0:Play424071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1047"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1047", 3)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_4" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(-38.9, -360, -319.3)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_32_7 = 0
			local var_32_8 = 0.675

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_9 = arg_29_1:FormatText(StoryNameCfg[1296].name)

				arg_29_1.leftNameTxt_.text = var_32_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(424071007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 27
				local var_32_13 = utf8.len(var_32_11)
				local var_32_14 = var_32_12 <= 0 and var_32_8 or var_32_8 * (var_32_13 / var_32_12)

				if var_32_14 > 0 and var_32_8 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14

					if var_32_14 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071007", "story_v_out_424071.awb") ~= 0 then
					local var_32_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071007", "story_v_out_424071.awb") / 1000

					if var_32_15 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_7
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_424071", "424071007", "story_v_out_424071.awb")

						arg_29_1:RecordAudio("424071007", var_32_16)
						arg_29_1:RecordAudio("424071007", var_32_16)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424071", "424071007", "story_v_out_424071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424071", "424071007", "story_v_out_424071.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_17 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_17 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_17

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_17 and arg_29_1.time_ < var_32_7 + var_32_17 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play424071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424071008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play424071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.275

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(424071008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 11
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play424071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424071009
		arg_37_1.duration_ = 4.63

		local var_37_0 = {
			zh = 4.5,
			ja = 4.633
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
				arg_37_0:Play424071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1047"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1047", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_1" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-38.9, -360, -319.3)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_40_7 = 0
			local var_40_8 = 0.4

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_9 = arg_37_1:FormatText(StoryNameCfg[1296].name)

				arg_37_1.leftNameTxt_.text = var_40_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(424071009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 16
				local var_40_13 = utf8.len(var_40_11)
				local var_40_14 = var_40_12 <= 0 and var_40_8 or var_40_8 * (var_40_13 / var_40_12)

				if var_40_14 > 0 and var_40_8 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071009", "story_v_out_424071.awb") ~= 0 then
					local var_40_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071009", "story_v_out_424071.awb") / 1000

					if var_40_15 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_7
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_424071", "424071009", "story_v_out_424071.awb")

						arg_37_1:RecordAudio("424071009", var_40_16)
						arg_37_1:RecordAudio("424071009", var_40_16)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_424071", "424071009", "story_v_out_424071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_424071", "424071009", "story_v_out_424071.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_17 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_17 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_17

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_17 and arg_37_1.time_ < var_40_7 + var_40_17 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424071010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play424071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.55

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(424071010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 62
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play424071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424071011
		arg_45_1.duration_ = 4.93

		local var_45_0 = {
			zh = 3.866,
			ja = 4.933
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
				arg_45_0:Play424071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1047"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1047", 3)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_7" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-38.9, -360, -319.3)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_48_7 = 0
			local var_48_8 = 0.35

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[1296].name)

				arg_45_1.leftNameTxt_.text = var_48_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(424071011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 14
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_8 or var_48_8 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_8 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_7
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071011", "story_v_out_424071.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071011", "story_v_out_424071.awb") / 1000

					if var_48_15 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_7
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_424071", "424071011", "story_v_out_424071.awb")

						arg_45_1:RecordAudio("424071011", var_48_16)
						arg_45_1:RecordAudio("424071011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424071", "424071011", "story_v_out_424071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424071", "424071011", "story_v_out_424071.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_17 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_17 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_7) / var_48_17

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_7 + var_48_17 and arg_45_1.time_ < var_48_7 + var_48_17 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424071012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play424071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.25

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(424071012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10
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
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play424071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424071013
		arg_53_1.duration_ = 4.6

		local var_53_0 = {
			zh = 2.933,
			ja = 4.6
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
				arg_53_0:Play424071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1047"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1047 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1047", 3)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(-38.9, -360, -319.3)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1047, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_56_7 = 0
			local var_56_8 = 0.375

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_9 = arg_53_1:FormatText(StoryNameCfg[1296].name)

				arg_53_1.leftNameTxt_.text = var_56_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(424071013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071013", "story_v_out_424071.awb") ~= 0 then
					local var_56_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071013", "story_v_out_424071.awb") / 1000

					if var_56_15 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_7
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_424071", "424071013", "story_v_out_424071.awb")

						arg_53_1:RecordAudio("424071013", var_56_16)
						arg_53_1:RecordAudio("424071013", var_56_16)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_424071", "424071013", "story_v_out_424071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_424071", "424071013", "story_v_out_424071.awb")
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
				actorName = "1047",
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
	Play424071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play424071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1047"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1047", 7)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(0, -2000, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_7 = "1034"

			if arg_57_1.actors_[var_60_7] == nil then
				local var_60_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_60_8) then
					local var_60_9 = Object.Instantiate(var_60_8, arg_57_1.canvasGo_.transform)

					var_60_9.transform:SetSiblingIndex(1)

					var_60_9.name = var_60_7
					var_60_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_7] = var_60_9

					local var_60_10 = var_60_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_57_1.isInRecall_ then
						for iter_60_1, iter_60_2 in ipairs(var_60_10) do
							iter_60_2.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_11 = arg_57_1.actors_["1034"]
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1:SetSpriteNiuquEffect("1034", false)
			end

			local var_60_13 = arg_57_1.actors_["1034"]
			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				local var_60_15 = var_60_13:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_15 then
					arg_57_1.var_.alphaOldValue1034 = var_60_15.alpha
					arg_57_1.var_.characterEffect1034 = var_60_15
				end

				arg_57_1.var_.alphaOldValue1034 = 0
			end

			local var_60_16 = 0.2

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_16 then
				local var_60_17 = (arg_57_1.time_ - var_60_14) / var_60_16
				local var_60_18 = Mathf.Lerp(arg_57_1.var_.alphaOldValue1034, 1, var_60_17)

				if arg_57_1.var_.characterEffect1034 then
					arg_57_1.var_.characterEffect1034.alpha = var_60_18
				end
			end

			if arg_57_1.time_ >= var_60_14 + var_60_16 and arg_57_1.time_ < var_60_14 + var_60_16 + arg_60_0 and arg_57_1.var_.characterEffect1034 then
				arg_57_1.var_.characterEffect1034.alpha = 1
			end

			local var_60_19 = 0
			local var_60_20 = 0.575

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_21 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_22 = arg_57_1:GetWordFromCfg(424071014)
				local var_60_23 = arg_57_1:FormatText(var_60_22.content)

				arg_57_1.text_.text = var_60_23

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_24 = 23
				local var_60_25 = utf8.len(var_60_23)
				local var_60_26 = var_60_24 <= 0 and var_60_20 or var_60_20 * (var_60_25 / var_60_24)

				if var_60_26 > 0 and var_60_20 < var_60_26 then
					arg_57_1.talkMaxDuration = var_60_26

					if var_60_26 + var_60_19 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_26 + var_60_19
					end
				end

				arg_57_1.text_.text = var_60_23
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = math.max(var_60_20, arg_57_1.talkMaxDuration)

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_27 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_19) / var_60_27

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_19 + var_60_27 and arg_57_1.time_ < var_60_19 + var_60_27 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play424071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424071015
		arg_61_1.duration_ = 1.4

		local var_61_0 = {
			zh = 1.266,
			ja = 1.4
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
				arg_61_0:Play424071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "1094"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(var_64_1, arg_61_1.canvasGo_.transform)

					var_64_2.transform:SetSiblingIndex(1)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_61_1.isInRecall_ then
						for iter_64_0, iter_64_1 in ipairs(var_64_3) do
							iter_64_1.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_4 = arg_61_1.actors_["1094"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.actorSpriteComps1094 == nil then
				arg_61_1.var_.actorSpriteComps1094 = var_64_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.2

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.actorSpriteComps1094 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								local var_64_8 = Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, var_64_7)
								local var_64_9 = Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, var_64_7)
								local var_64_10 = Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, var_64_7)

								iter_64_3.color = Color.New(var_64_8, var_64_9, var_64_10)
							else
								local var_64_11 = Mathf.Lerp(iter_64_3.color.r, 1, var_64_7)

								iter_64_3.color = Color.New(var_64_11, var_64_11, var_64_11)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.actorSpriteComps1094 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_64_5 then
						if arg_61_1.isInRecall_ then
							iter_64_5.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1094 = nil
			end

			local var_64_12 = arg_61_1.actors_["1094"].transform
			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.var_.moveOldPos1094 = var_64_12.localPosition
				var_64_12.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1094", 3)

				local var_64_14 = var_64_12.childCount

				for iter_64_6 = 0, var_64_14 - 1 do
					local var_64_15 = var_64_12:GetChild(iter_64_6)

					if var_64_15.name == "" or not string.find(var_64_15.name, "split") then
						var_64_15.gameObject:SetActive(true)
					else
						var_64_15.gameObject:SetActive(false)
					end
				end
			end

			local var_64_16 = 0.001

			if var_64_13 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_16 then
				local var_64_17 = (arg_61_1.time_ - var_64_13) / var_64_16
				local var_64_18 = Vector3.New(0, -335, -230)

				var_64_12.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1094, var_64_18, var_64_17)
			end

			if arg_61_1.time_ >= var_64_13 + var_64_16 and arg_61_1.time_ < var_64_13 + var_64_16 + arg_64_0 then
				var_64_12.localPosition = Vector3.New(0, -335, -230)
			end

			local var_64_19 = arg_61_1.actors_["1094"]
			local var_64_20 = 0

			if var_64_20 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				local var_64_21 = var_64_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_21 then
					arg_61_1.var_.alphaOldValue1094 = var_64_21.alpha
					arg_61_1.var_.characterEffect1094 = var_64_21
				end

				arg_61_1.var_.alphaOldValue1094 = 0
			end

			local var_64_22 = 0.6

			if var_64_20 <= arg_61_1.time_ and arg_61_1.time_ < var_64_20 + var_64_22 then
				local var_64_23 = (arg_61_1.time_ - var_64_20) / var_64_22
				local var_64_24 = Mathf.Lerp(arg_61_1.var_.alphaOldValue1094, 1, var_64_23)

				if arg_61_1.var_.characterEffect1094 then
					arg_61_1.var_.characterEffect1094.alpha = var_64_24
				end
			end

			if arg_61_1.time_ >= var_64_20 + var_64_22 and arg_61_1.time_ < var_64_20 + var_64_22 + arg_64_0 and arg_61_1.var_.characterEffect1094 then
				arg_61_1.var_.characterEffect1094.alpha = 1
			end

			local var_64_25 = 0
			local var_64_26 = 0.1

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_27 = arg_61_1:FormatText(StoryNameCfg[181].name)

				arg_61_1.leftNameTxt_.text = var_64_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_28 = arg_61_1:GetWordFromCfg(424071015)
				local var_64_29 = arg_61_1:FormatText(var_64_28.content)

				arg_61_1.text_.text = var_64_29

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_30 = 4
				local var_64_31 = utf8.len(var_64_29)
				local var_64_32 = var_64_30 <= 0 and var_64_26 or var_64_26 * (var_64_31 / var_64_30)

				if var_64_32 > 0 and var_64_26 < var_64_32 then
					arg_61_1.talkMaxDuration = var_64_32

					if var_64_32 + var_64_25 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_32 + var_64_25
					end
				end

				arg_61_1.text_.text = var_64_29
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071015", "story_v_out_424071.awb") ~= 0 then
					local var_64_33 = manager.audio:GetVoiceLength("story_v_out_424071", "424071015", "story_v_out_424071.awb") / 1000

					if var_64_33 + var_64_25 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_33 + var_64_25
					end

					if var_64_28.prefab_name ~= "" and arg_61_1.actors_[var_64_28.prefab_name] ~= nil then
						local var_64_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_28.prefab_name].transform, "story_v_out_424071", "424071015", "story_v_out_424071.awb")

						arg_61_1:RecordAudio("424071015", var_64_34)
						arg_61_1:RecordAudio("424071015", var_64_34)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424071", "424071015", "story_v_out_424071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424071", "424071015", "story_v_out_424071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_35 = math.max(var_64_26, arg_61_1.talkMaxDuration)

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_35 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_25) / var_64_35

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_25 + var_64_35 and arg_61_1.time_ < var_64_25 + var_64_35 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play424071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424071016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play424071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1094"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1094 == nil then
				arg_65_1.var_.actorSpriteComps1094 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1094 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1094 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1094 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 1.65

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_11 = arg_65_1:GetWordFromCfg(424071016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 66
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_9 or var_68_9 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_9 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play424071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424071017
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			zh = 4.066,
			ja = 4.6
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play424071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1094"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1094 == nil then
				arg_69_1.var_.actorSpriteComps1094 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1094 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1094 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1094 = nil
			end

			local var_72_8 = arg_69_1.actors_["1094"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos1094 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1094", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(0, -335, -230)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1094, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_72_15 = 0
			local var_72_16 = 0.325

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[181].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(424071017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 13
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071017", "story_v_out_424071.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071017", "story_v_out_424071.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_424071", "424071017", "story_v_out_424071.awb")

						arg_69_1:RecordAudio("424071017", var_72_24)
						arg_69_1:RecordAudio("424071017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_424071", "424071017", "story_v_out_424071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_424071", "424071017", "story_v_out_424071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play424071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424071018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play424071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1094"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1094 == nil then
				arg_73_1.var_.actorSpriteComps1094 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1094 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1094 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1094 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.475

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_11 = arg_73_1:GetWordFromCfg(424071018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 19
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_9 or var_76_9 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_9 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play424071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424071019
		arg_77_1.duration_ = 1.37

		local var_77_0 = {
			zh = 0.999999999999,
			ja = 1.366
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play424071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1094"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1094 == nil then
				arg_77_1.var_.actorSpriteComps1094 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1094 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1094 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1094 = nil
			end

			local var_80_8 = arg_77_1.actors_["1094"].transform
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.var_.moveOldPos1094 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1094", 3)

				local var_80_10 = var_80_8.childCount

				for iter_80_4 = 0, var_80_10 - 1 do
					local var_80_11 = var_80_8:GetChild(iter_80_4)

					if var_80_11.name == "split_2" then
						var_80_11:SetAsLastSibling()
						var_80_11.gameObject:SetActive(true)

						arg_77_1.var_.actorSpriteSplit1094 = var_80_11.gameObject:GetComponent(typeof(Image))

						arg_77_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_80_12 = 0.5

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_12 then
				local var_80_13 = (arg_77_1.time_ - var_80_9) / var_80_12
				local var_80_14 = Vector3.New(0, -335, -230)

				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1094, var_80_14, var_80_13)

				if arg_77_1.var_.actorSpriteSplit1094 ~= nil then
					arg_77_1.var_.actorSpriteSplit1094:SetAlpha(var_80_13)
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_12 and arg_77_1.time_ < var_80_9 + var_80_12 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0, -335, -230)

				if arg_77_1.var_.actorSpriteSplit1094 ~= nil then
					arg_77_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_80_15 = 0
			local var_80_16 = 0.05

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[181].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(424071019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 2
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071019", "story_v_out_424071.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071019", "story_v_out_424071.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_424071", "424071019", "story_v_out_424071.awb")

						arg_77_1:RecordAudio("424071019", var_80_24)
						arg_77_1:RecordAudio("424071019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424071", "424071019", "story_v_out_424071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424071", "424071019", "story_v_out_424071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play424071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424071020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play424071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1094"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1094 == nil then
				arg_81_1.var_.actorSpriteComps1094 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1094 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 0.5, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1094 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1094 = nil
			end

			local var_84_8 = arg_81_1.actors_["1094"].transform
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.var_.moveOldPos1094 = var_84_8.localPosition
				var_84_8.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1094", 7)

				local var_84_10 = var_84_8.childCount

				for iter_84_4 = 0, var_84_10 - 1 do
					local var_84_11 = var_84_8:GetChild(iter_84_4)

					if var_84_11.name == "" or not string.find(var_84_11.name, "split") then
						var_84_11.gameObject:SetActive(true)
					else
						var_84_11.gameObject:SetActive(false)
					end
				end
			end

			local var_84_12 = 0.001

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_9) / var_84_12
				local var_84_14 = Vector3.New(0, -2000, 0)

				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1094, var_84_14, var_84_13)
			end

			if arg_81_1.time_ >= var_84_9 + var_84_12 and arg_81_1.time_ < var_84_9 + var_84_12 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_15 = 0
			local var_84_16 = 1.1

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(424071020)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 44
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_16 or var_84_16 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_16 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_22 and arg_81_1.time_ < var_84_15 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play424071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424071021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play424071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.35

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(424071021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 14
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play424071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424071022
		arg_89_1.duration_ = 1.33

		local var_89_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_89_0:Play424071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1094"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1094 == nil then
				arg_89_1.var_.actorSpriteComps1094 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps1094 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1094 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1094 = nil
			end

			local var_92_8 = arg_89_1.actors_["1094"].transform
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.var_.moveOldPos1094 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1094", 3)

				local var_92_10 = var_92_8.childCount

				for iter_92_4 = 0, var_92_10 - 1 do
					local var_92_11 = var_92_8:GetChild(iter_92_4)

					if var_92_11.name == "" or not string.find(var_92_11.name, "split") then
						var_92_11.gameObject:SetActive(true)
					else
						var_92_11.gameObject:SetActive(false)
					end
				end
			end

			local var_92_12 = 0.001

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_12 then
				local var_92_13 = (arg_89_1.time_ - var_92_9) / var_92_12
				local var_92_14 = Vector3.New(0, -335, -230)

				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1094, var_92_14, var_92_13)
			end

			if arg_89_1.time_ >= var_92_9 + var_92_12 and arg_89_1.time_ < var_92_9 + var_92_12 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_92_15 = 0
			local var_92_16 = 0.15

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[181].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(424071022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 6
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071022", "story_v_out_424071.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071022", "story_v_out_424071.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_424071", "424071022", "story_v_out_424071.awb")

						arg_89_1:RecordAudio("424071022", var_92_24)
						arg_89_1:RecordAudio("424071022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424071", "424071022", "story_v_out_424071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424071", "424071022", "story_v_out_424071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play424071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424071023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play424071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1094"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1094 == nil then
				arg_93_1.var_.actorSpriteComps1094 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1094 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.4

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_10 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_11 = arg_93_1:GetWordFromCfg(424071023)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 16
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_9 or var_96_9 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_9 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play424071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424071024
		arg_97_1.duration_ = 8.8

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play424071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1094"].transform
			local var_100_1 = 1.966

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 7)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -2000, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_8 = 2

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_8 then
				local var_100_9 = (arg_97_1.time_ - var_100_7) / var_100_8
				local var_100_10 = Color.New(0, 0, 0)

				var_100_10.a = Mathf.Lerp(0, 1, var_100_9)
				arg_97_1.mask_.color = var_100_10
			end

			if arg_97_1.time_ >= var_100_7 + var_100_8 and arg_97_1.time_ < var_100_7 + var_100_8 + arg_100_0 then
				local var_100_11 = Color.New(0, 0, 0)

				var_100_11.a = 1
				arg_97_1.mask_.color = var_100_11
			end

			local var_100_12 = 2

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_13 = 2

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_13 then
				local var_100_14 = (arg_97_1.time_ - var_100_12) / var_100_13
				local var_100_15 = Color.New(0, 0, 0)

				var_100_15.a = Mathf.Lerp(1, 0, var_100_14)
				arg_97_1.mask_.color = var_100_15
			end

			if arg_97_1.time_ >= var_100_12 + var_100_13 and arg_97_1.time_ < var_100_12 + var_100_13 + arg_100_0 then
				local var_100_16 = Color.New(0, 0, 0)
				local var_100_17 = 0

				arg_97_1.mask_.enabled = false
				var_100_16.a = var_100_17
				arg_97_1.mask_.color = var_100_16
			end

			local var_100_18 = manager.ui.mainCamera.transform
			local var_100_19 = 2

			if var_100_19 < arg_97_1.time_ and arg_97_1.time_ <= var_100_19 + arg_100_0 then
				local var_100_20 = arg_97_1.var_.effectshanshangxiaowusleep1
				local var_100_21
				local var_100_22 = var_100_18

				if not var_100_20 then
					var_100_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_100_22)
					var_100_20.name = "shanshangxiaowusleep1"
					arg_97_1.var_.effectshanshangxiaowusleep1 = var_100_20
				else
					var_100_20.transform:SetParent(var_100_22)
				end

				var_100_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_100_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_100_23 = 1.7777777777777777
				local var_100_24 = Screen.width / Screen.height
				local var_100_25 = var_100_24 / var_100_23
				local var_100_26 = Mathf.Max(var_100_23 / var_100_24, 1)

				var_100_20.transform.localScale = Vector3.New(var_100_20.transform.localScale.x * var_100_25, var_100_20.transform.localScale.y * var_100_26, var_100_20.transform.localScale.z)
			end

			local var_100_27 = manager.ui.mainCamera.transform
			local var_100_28 = 2

			if var_100_28 < arg_97_1.time_ and arg_97_1.time_ <= var_100_28 + arg_100_0 then
				local var_100_29 = arg_97_1.var_.effectshanshangxiaowusleep2
				local var_100_30
				local var_100_31 = var_100_27

				if not var_100_29 then
					var_100_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_100_31)
					var_100_29.name = "shanshangxiaowusleep2"
					arg_97_1.var_.effectshanshangxiaowusleep2 = var_100_29
				else
					var_100_29.transform:SetParent(var_100_31)
				end

				var_100_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_100_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_100_32 = 1.7777777777777777
				local var_100_33 = Screen.width / Screen.height
				local var_100_34 = var_100_33 / var_100_32
				local var_100_35 = Mathf.Max(var_100_32 / var_100_33, 1)

				var_100_29.transform.localScale = Vector3.New(var_100_29.transform.localScale.x * var_100_34, var_100_29.transform.localScale.y * var_100_35, var_100_29.transform.localScale.z)
			end

			local var_100_36 = 3.9
			local var_100_37 = 1

			if var_100_36 < arg_97_1.time_ and arg_97_1.time_ <= var_100_36 + arg_100_0 then
				local var_100_38 = "play"
				local var_100_39 = "effect"

				arg_97_1:AudioAction(var_100_38, var_100_39, "se_story_side_1095", "se_story_side_1095_foley_cloth", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_40 = 3.8
			local var_100_41 = 1.575

			if var_100_40 < arg_97_1.time_ and arg_97_1.time_ <= var_100_40 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_42 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_42:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_43 = arg_97_1:GetWordFromCfg(424071024)
				local var_100_44 = arg_97_1:FormatText(var_100_43.content)

				arg_97_1.text_.text = var_100_44

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_45 = 63
				local var_100_46 = utf8.len(var_100_44)
				local var_100_47 = var_100_45 <= 0 and var_100_41 or var_100_41 * (var_100_46 / var_100_45)

				if var_100_47 > 0 and var_100_41 < var_100_47 then
					arg_97_1.talkMaxDuration = var_100_47
					var_100_40 = var_100_40 + 0.3

					if var_100_47 + var_100_40 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_47 + var_100_40
					end
				end

				arg_97_1.text_.text = var_100_44
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_48 = var_100_40 + 0.3
			local var_100_49 = math.max(var_100_41, arg_97_1.talkMaxDuration)

			if var_100_48 <= arg_97_1.time_ and arg_97_1.time_ < var_100_48 + var_100_49 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_48) / var_100_49

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_48 + var_100_49 and arg_97_1.time_ < var_100_48 + var_100_49 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play424071025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424071025
		arg_103_1.duration_ = 4.33

		local var_103_0 = {
			zh = 2.633,
			ja = 4.333
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
				arg_103_0:Play424071026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.175

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[181].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(424071025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071025", "story_v_out_424071.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071025", "story_v_out_424071.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_424071", "424071025", "story_v_out_424071.awb")

						arg_103_1:RecordAudio("424071025", var_106_9)
						arg_103_1:RecordAudio("424071025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_424071", "424071025", "story_v_out_424071.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_424071", "424071025", "story_v_out_424071.awb")
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
	Play424071026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424071026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play424071027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.425

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

				local var_110_2 = arg_107_1:GetWordFromCfg(424071026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 57
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
	Play424071027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424071027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play424071028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.2

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(424071027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 8
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424071028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424071028
		arg_115_1.duration_ = 4.57

		local var_115_0 = {
			zh = 3.1,
			ja = 4.566
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
				arg_115_0:Play424071029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.275

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[181].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(424071028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071028", "story_v_out_424071.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071028", "story_v_out_424071.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_424071", "424071028", "story_v_out_424071.awb")

						arg_115_1:RecordAudio("424071028", var_118_9)
						arg_115_1:RecordAudio("424071028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424071", "424071028", "story_v_out_424071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424071", "424071028", "story_v_out_424071.awb")
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
	Play424071029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424071029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424071030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.125

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(424071029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 5
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
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play424071030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424071030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424071031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.65

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(424071030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 26
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424071031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424071031
		arg_127_1.duration_ = 3.5

		local var_127_0 = {
			zh = 3.033,
			ja = 3.5
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
				arg_127_0:Play424071032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.2

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[181].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(424071031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 8
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071031", "story_v_out_424071.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071031", "story_v_out_424071.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_424071", "424071031", "story_v_out_424071.awb")

						arg_127_1:RecordAudio("424071031", var_130_9)
						arg_127_1:RecordAudio("424071031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424071", "424071031", "story_v_out_424071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424071", "424071031", "story_v_out_424071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424071032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424071032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play424071033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.325

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(424071032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 13
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
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play424071033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424071033
		arg_135_1.duration_ = 1.63

		local var_135_0 = {
			zh = 1.466,
			ja = 1.633
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
				arg_135_0:Play424071034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.1

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[181].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(424071033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 4
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071033", "story_v_out_424071.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071033", "story_v_out_424071.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_424071", "424071033", "story_v_out_424071.awb")

						arg_135_1:RecordAudio("424071033", var_138_9)
						arg_135_1:RecordAudio("424071033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424071", "424071033", "story_v_out_424071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424071", "424071033", "story_v_out_424071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424071034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424071034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play424071035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.125

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(424071034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 5
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play424071035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424071035
		arg_143_1.duration_ = 9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play424071036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "STblack"

			if arg_143_1.bgs_[var_146_0] == nil then
				local var_146_1 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_146_0)
				var_146_1.name = var_146_0
				var_146_1.transform.parent = arg_143_1.stage_.transform
				var_146_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_[var_146_0] = var_146_1
			end

			local var_146_2 = 2

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				local var_146_3 = manager.ui.mainCamera.transform.localPosition
				local var_146_4 = Vector3.New(0, 0, 10) + Vector3.New(var_146_3.x, var_146_3.y, 0)
				local var_146_5 = arg_143_1.bgs_.STblack

				var_146_5.transform.localPosition = var_146_4
				var_146_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_6 = var_146_5:GetComponent("SpriteRenderer")

				if var_146_6 and var_146_6.sprite then
					local var_146_7 = (var_146_5.transform.localPosition - var_146_3).z
					local var_146_8 = manager.ui.mainCameraCom_
					local var_146_9 = 2 * var_146_7 * Mathf.Tan(var_146_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_146_10 = var_146_9 * var_146_8.aspect
					local var_146_11 = var_146_6.sprite.bounds.size.x
					local var_146_12 = var_146_6.sprite.bounds.size.y
					local var_146_13 = var_146_10 / var_146_11
					local var_146_14 = var_146_9 / var_146_12
					local var_146_15 = var_146_14 < var_146_13 and var_146_13 or var_146_14

					var_146_5.transform.localScale = Vector3.New(var_146_15, var_146_15, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "STblack" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_16 = 4

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_17 = 0.3

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_18 = 0

			if var_146_18 < arg_143_1.time_ and arg_143_1.time_ <= var_146_18 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_19 = 2

			if var_146_18 <= arg_143_1.time_ and arg_143_1.time_ < var_146_18 + var_146_19 then
				local var_146_20 = (arg_143_1.time_ - var_146_18) / var_146_19
				local var_146_21 = Color.New(0, 0, 0)

				var_146_21.a = Mathf.Lerp(0, 1, var_146_20)
				arg_143_1.mask_.color = var_146_21
			end

			if arg_143_1.time_ >= var_146_18 + var_146_19 and arg_143_1.time_ < var_146_18 + var_146_19 + arg_146_0 then
				local var_146_22 = Color.New(0, 0, 0)

				var_146_22.a = 1
				arg_143_1.mask_.color = var_146_22
			end

			local var_146_23 = 2

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_24 = 2

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24
				local var_146_26 = Color.New(0, 0, 0)

				var_146_26.a = Mathf.Lerp(1, 0, var_146_25)
				arg_143_1.mask_.color = var_146_26
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 then
				local var_146_27 = Color.New(0, 0, 0)
				local var_146_28 = 0

				arg_143_1.mask_.enabled = false
				var_146_27.a = var_146_28
				arg_143_1.mask_.color = var_146_27
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_29 = 4
			local var_146_30 = 0.675

			if var_146_29 < arg_143_1.time_ and arg_143_1.time_ <= var_146_29 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_31 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_31:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_32 = arg_143_1:GetWordFromCfg(424071035)
				local var_146_33 = arg_143_1:FormatText(var_146_32.content)

				arg_143_1.text_.text = var_146_33

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_34 = 27
				local var_146_35 = utf8.len(var_146_33)
				local var_146_36 = var_146_34 <= 0 and var_146_30 or var_146_30 * (var_146_35 / var_146_34)

				if var_146_36 > 0 and var_146_30 < var_146_36 then
					arg_143_1.talkMaxDuration = var_146_36
					var_146_29 = var_146_29 + 0.3

					if var_146_36 + var_146_29 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_36 + var_146_29
					end
				end

				arg_143_1.text_.text = var_146_33
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_37 = var_146_29 + 0.3
			local var_146_38 = math.max(var_146_30, arg_143_1.talkMaxDuration)

			if var_146_37 <= arg_143_1.time_ and arg_143_1.time_ < var_146_37 + var_146_38 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_37) / var_146_38

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_37 + var_146_38 and arg_143_1.time_ < var_146_37 + var_146_38 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424071036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 424071036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play424071037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.275

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(424071036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 51
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play424071037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 424071037
		arg_153_1.duration_ = 5.37

		local var_153_0 = {
			zh = 1.6,
			ja = 5.366
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
				arg_153_0:Play424071038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.125

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[181].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(424071037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 5
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071037", "story_v_out_424071.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071037", "story_v_out_424071.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_424071", "424071037", "story_v_out_424071.awb")

						arg_153_1:RecordAudio("424071037", var_156_9)
						arg_153_1:RecordAudio("424071037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_424071", "424071037", "story_v_out_424071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_424071", "424071037", "story_v_out_424071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play424071038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 424071038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play424071039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.85

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(424071038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 34
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play424071039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 424071039
		arg_161_1.duration_ = 7

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play424071040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				local var_164_1 = manager.ui.mainCamera.transform.localPosition
				local var_164_2 = Vector3.New(0, 0, 10) + Vector3.New(var_164_1.x, var_164_1.y, 0)
				local var_164_3 = arg_161_1.bgs_.ST0115a

				var_164_3.transform.localPosition = var_164_2
				var_164_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_4 = var_164_3:GetComponent("SpriteRenderer")

				if var_164_4 and var_164_4.sprite then
					local var_164_5 = (var_164_3.transform.localPosition - var_164_1).z
					local var_164_6 = manager.ui.mainCameraCom_
					local var_164_7 = 2 * var_164_5 * Mathf.Tan(var_164_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_164_8 = var_164_7 * var_164_6.aspect
					local var_164_9 = var_164_4.sprite.bounds.size.x
					local var_164_10 = var_164_4.sprite.bounds.size.y
					local var_164_11 = var_164_8 / var_164_9
					local var_164_12 = var_164_7 / var_164_10
					local var_164_13 = var_164_12 < var_164_11 and var_164_11 or var_164_12

					var_164_3.transform.localScale = Vector3.New(var_164_13, var_164_13, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST0115a" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_14 = 2

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_15 = 0.3

			if arg_161_1.time_ >= var_164_14 + var_164_15 and arg_161_1.time_ < var_164_14 + var_164_15 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_17 = 2

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_17 then
				local var_164_18 = (arg_161_1.time_ - var_164_16) / var_164_17
				local var_164_19 = Color.New(0, 0, 0)

				var_164_19.a = Mathf.Lerp(1, 0, var_164_18)
				arg_161_1.mask_.color = var_164_19
			end

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 then
				local var_164_20 = Color.New(0, 0, 0)
				local var_164_21 = 0

				arg_161_1.mask_.enabled = false
				var_164_20.a = var_164_21
				arg_161_1.mask_.color = var_164_20
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_22 = 2
			local var_164_23 = 0.225

			if var_164_22 < arg_161_1.time_ and arg_161_1.time_ <= var_164_22 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_24 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_24:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_25 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_26 = arg_161_1:GetWordFromCfg(424071039)
				local var_164_27 = arg_161_1:FormatText(var_164_26.content)

				arg_161_1.text_.text = var_164_27

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_28 = 9
				local var_164_29 = utf8.len(var_164_27)
				local var_164_30 = var_164_28 <= 0 and var_164_23 or var_164_23 * (var_164_29 / var_164_28)

				if var_164_30 > 0 and var_164_23 < var_164_30 then
					arg_161_1.talkMaxDuration = var_164_30
					var_164_22 = var_164_22 + 0.3

					if var_164_30 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_30 + var_164_22
					end
				end

				arg_161_1.text_.text = var_164_27
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_31 = var_164_22 + 0.3
			local var_164_32 = math.max(var_164_23, arg_161_1.talkMaxDuration)

			if var_164_31 <= arg_161_1.time_ and arg_161_1.time_ < var_164_31 + var_164_32 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_31) / var_164_32

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_31 + var_164_32 and arg_161_1.time_ < var_164_31 + var_164_32 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play424071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424071040
		arg_167_1.duration_ = 1.47

		local var_167_0 = {
			zh = 1.366,
			ja = 1.466
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
				arg_167_0:Play424071041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.075

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[181].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(424071040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 3
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071040", "story_v_out_424071.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071040", "story_v_out_424071.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_424071", "424071040", "story_v_out_424071.awb")

						arg_167_1:RecordAudio("424071040", var_170_9)
						arg_167_1:RecordAudio("424071040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424071", "424071040", "story_v_out_424071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424071", "424071040", "story_v_out_424071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play424071041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424071041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424071042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.275

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(424071041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 11
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424071042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424071042
		arg_175_1.duration_ = 8.7

		local var_175_0 = {
			zh = 5.333,
			ja = 8.7
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
				arg_175_0:Play424071043(arg_175_1)
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

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[181].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(424071042)
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071042", "story_v_out_424071.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071042", "story_v_out_424071.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_424071", "424071042", "story_v_out_424071.awb")

						arg_175_1:RecordAudio("424071042", var_178_9)
						arg_175_1:RecordAudio("424071042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_424071", "424071042", "story_v_out_424071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_424071", "424071042", "story_v_out_424071.awb")
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
	Play424071043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424071043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424071044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.7

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

				local var_182_2 = arg_179_1:GetWordFromCfg(424071043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 28
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
	Play424071044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424071044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play424071045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.075

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(424071044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 43
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
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play424071045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424071045
		arg_187_1.duration_ = 1.4

		local var_187_0 = {
			zh = 1.366,
			ja = 1.4
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
				arg_187_0:Play424071046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.125

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[181].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(424071045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071045", "story_v_out_424071.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071045", "story_v_out_424071.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_424071", "424071045", "story_v_out_424071.awb")

						arg_187_1:RecordAudio("424071045", var_190_9)
						arg_187_1:RecordAudio("424071045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_424071", "424071045", "story_v_out_424071.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_424071", "424071045", "story_v_out_424071.awb")
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
	Play424071046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424071046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play424071047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.05

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(424071046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 2
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
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play424071047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424071047
		arg_195_1.duration_ = 2.4

		local var_195_0 = {
			zh = 2.4,
			ja = 1.3
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
				arg_195_0:Play424071048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.175

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[181].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(424071047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 7
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071047", "story_v_out_424071.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071047", "story_v_out_424071.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_424071", "424071047", "story_v_out_424071.awb")

						arg_195_1:RecordAudio("424071047", var_198_9)
						arg_195_1:RecordAudio("424071047", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424071", "424071047", "story_v_out_424071.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424071", "424071047", "story_v_out_424071.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play424071048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424071048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play424071049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.3

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				local var_202_2 = "play"
				local var_202_3 = "music"

				arg_199_1:AudioAction(var_202_2, var_202_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_202_4 = ""
				local var_202_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_202_5 ~= "" then
					if arg_199_1.bgmTxt_.text ~= var_202_5 and arg_199_1.bgmTxt_.text ~= "" then
						if arg_199_1.bgmTxt2_.text ~= "" then
							arg_199_1.bgmTxt_.text = arg_199_1.bgmTxt2_.text
						end

						arg_199_1.bgmTxt2_.text = var_202_5

						arg_199_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_199_1.bgmTxt_.text = var_202_5
						arg_199_1.bgmTxt2_.text = var_202_5
					end

					if arg_199_1.bgmTimer then
						arg_199_1.bgmTimer:Stop()

						arg_199_1.bgmTimer = nil
					end

					if arg_199_1.settingData.show_music_name == 1 then
						arg_199_1.musicController:SetSelectedState("show")
						arg_199_1.musicAnimator_:Play("open", 0, 0)

						if arg_199_1.settingData.music_time ~= 0 then
							arg_199_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_199_1.settingData.music_time), function()
								if arg_199_1 == nil or isNil(arg_199_1.bgmTxt_) then
									return
								end

								arg_199_1.musicController:SetSelectedState("hide")
								arg_199_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_202_6 = 0
			local var_202_7 = 0.6

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(424071048)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 24
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_7 or var_202_7 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_7 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_13 and arg_199_1.time_ < var_202_6 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play424071049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 424071049
		arg_204_1.duration_ = 9

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play424071050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = "I11r"

			if arg_204_1.bgs_[var_207_0] == nil then
				local var_207_1 = Object.Instantiate(arg_204_1.paintGo_)

				var_207_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_207_0)
				var_207_1.name = var_207_0
				var_207_1.transform.parent = arg_204_1.stage_.transform
				var_207_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.bgs_[var_207_0] = var_207_1
			end

			local var_207_2 = 2

			if var_207_2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				local var_207_3 = manager.ui.mainCamera.transform.localPosition
				local var_207_4 = Vector3.New(0, 0, 10) + Vector3.New(var_207_3.x, var_207_3.y, 0)
				local var_207_5 = arg_204_1.bgs_.I11r

				var_207_5.transform.localPosition = var_207_4
				var_207_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_6 = var_207_5:GetComponent("SpriteRenderer")

				if var_207_6 and var_207_6.sprite then
					local var_207_7 = (var_207_5.transform.localPosition - var_207_3).z
					local var_207_8 = manager.ui.mainCameraCom_
					local var_207_9 = 2 * var_207_7 * Mathf.Tan(var_207_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_207_10 = var_207_9 * var_207_8.aspect
					local var_207_11 = var_207_6.sprite.bounds.size.x
					local var_207_12 = var_207_6.sprite.bounds.size.y
					local var_207_13 = var_207_10 / var_207_11
					local var_207_14 = var_207_9 / var_207_12
					local var_207_15 = var_207_14 < var_207_13 and var_207_13 or var_207_14

					var_207_5.transform.localScale = Vector3.New(var_207_15, var_207_15, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "I11r" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_16 = 4

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.allBtn_.enabled = false
			end

			local var_207_17 = 0.3

			if arg_204_1.time_ >= var_207_16 + var_207_17 and arg_204_1.time_ < var_207_16 + var_207_17 + arg_207_0 then
				arg_204_1.allBtn_.enabled = true
			end

			local var_207_18 = 0

			if var_207_18 < arg_204_1.time_ and arg_204_1.time_ <= var_207_18 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_19 = 2

			if var_207_18 <= arg_204_1.time_ and arg_204_1.time_ < var_207_18 + var_207_19 then
				local var_207_20 = (arg_204_1.time_ - var_207_18) / var_207_19
				local var_207_21 = Color.New(0, 0, 0)

				var_207_21.a = Mathf.Lerp(0, 1, var_207_20)
				arg_204_1.mask_.color = var_207_21
			end

			if arg_204_1.time_ >= var_207_18 + var_207_19 and arg_204_1.time_ < var_207_18 + var_207_19 + arg_207_0 then
				local var_207_22 = Color.New(0, 0, 0)

				var_207_22.a = 1
				arg_204_1.mask_.color = var_207_22
			end

			local var_207_23 = 2

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_24 = 2

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_24 then
				local var_207_25 = (arg_204_1.time_ - var_207_23) / var_207_24
				local var_207_26 = Color.New(0, 0, 0)

				var_207_26.a = Mathf.Lerp(1, 0, var_207_25)
				arg_204_1.mask_.color = var_207_26
			end

			if arg_204_1.time_ >= var_207_23 + var_207_24 and arg_204_1.time_ < var_207_23 + var_207_24 + arg_207_0 then
				local var_207_27 = Color.New(0, 0, 0)
				local var_207_28 = 0

				arg_204_1.mask_.enabled = false
				var_207_27.a = var_207_28
				arg_204_1.mask_.color = var_207_27
			end

			local var_207_29 = 0.166666666666667
			local var_207_30 = 0.3

			if var_207_29 < arg_204_1.time_ and arg_204_1.time_ <= var_207_29 + arg_207_0 then
				local var_207_31 = "play"
				local var_207_32 = "music"

				arg_204_1:AudioAction(var_207_31, var_207_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_207_33 = ""
				local var_207_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_207_34 ~= "" then
					if arg_204_1.bgmTxt_.text ~= var_207_34 and arg_204_1.bgmTxt_.text ~= "" then
						if arg_204_1.bgmTxt2_.text ~= "" then
							arg_204_1.bgmTxt_.text = arg_204_1.bgmTxt2_.text
						end

						arg_204_1.bgmTxt2_.text = var_207_34

						arg_204_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_204_1.bgmTxt_.text = var_207_34
						arg_204_1.bgmTxt2_.text = var_207_34
					end

					if arg_204_1.bgmTimer then
						arg_204_1.bgmTimer:Stop()

						arg_204_1.bgmTimer = nil
					end

					if arg_204_1.settingData.show_music_name == 1 then
						arg_204_1.musicController:SetSelectedState("show")
						arg_204_1.musicAnimator_:Play("open", 0, 0)

						if arg_204_1.settingData.music_time ~= 0 then
							arg_204_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_204_1.settingData.music_time), function()
								if arg_204_1 == nil or isNil(arg_204_1.bgmTxt_) then
									return
								end

								arg_204_1.musicController:SetSelectedState("hide")
								arg_204_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_207_35 = 1.7
			local var_207_36 = 1

			if var_207_35 < arg_204_1.time_ and arg_204_1.time_ <= var_207_35 + arg_207_0 then
				local var_207_37 = "play"
				local var_207_38 = "music"

				arg_204_1:AudioAction(var_207_37, var_207_38, "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_207_39 = ""
				local var_207_40 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if var_207_40 ~= "" then
					if arg_204_1.bgmTxt_.text ~= var_207_40 and arg_204_1.bgmTxt_.text ~= "" then
						if arg_204_1.bgmTxt2_.text ~= "" then
							arg_204_1.bgmTxt_.text = arg_204_1.bgmTxt2_.text
						end

						arg_204_1.bgmTxt2_.text = var_207_40

						arg_204_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_204_1.bgmTxt_.text = var_207_40
						arg_204_1.bgmTxt2_.text = var_207_40
					end

					if arg_204_1.bgmTimer then
						arg_204_1.bgmTimer:Stop()

						arg_204_1.bgmTimer = nil
					end

					if arg_204_1.settingData.show_music_name == 1 then
						arg_204_1.musicController:SetSelectedState("show")
						arg_204_1.musicAnimator_:Play("open", 0, 0)

						if arg_204_1.settingData.music_time ~= 0 then
							arg_204_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_204_1.settingData.music_time), function()
								if arg_204_1 == nil or isNil(arg_204_1.bgmTxt_) then
									return
								end

								arg_204_1.musicController:SetSelectedState("hide")
								arg_204_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_207_41 = 1.7
			local var_207_42 = 1

			if var_207_41 < arg_204_1.time_ and arg_204_1.time_ <= var_207_41 + arg_207_0 then
				local var_207_43 = "play"
				local var_207_44 = "effect"

				arg_204_1:AudioAction(var_207_43, var_207_44, "se_story_133", "se_story_133_sea", "")
			end

			local var_207_45 = 0.166666666666667
			local var_207_46 = 1

			if var_207_45 < arg_204_1.time_ and arg_204_1.time_ <= var_207_45 + arg_207_0 then
				local var_207_47 = "stop"
				local var_207_48 = "effect"

				arg_204_1:AudioAction(var_207_47, var_207_48, "se_story_146", "se_story_146_wind02", "")
			end

			local var_207_49 = manager.ui.mainCamera.transform
			local var_207_50 = 2

			if var_207_50 < arg_204_1.time_ and arg_204_1.time_ <= var_207_50 + arg_207_0 then
				local var_207_51 = arg_204_1.var_.effectshanshangxiaowusleep2

				if var_207_51 then
					Object.Destroy(var_207_51)

					arg_204_1.var_.effectshanshangxiaowusleep2 = nil
				end
			end

			local var_207_52 = manager.ui.mainCamera.transform
			local var_207_53 = 2

			if var_207_53 < arg_204_1.time_ and arg_204_1.time_ <= var_207_53 + arg_207_0 then
				local var_207_54 = arg_204_1.var_.effectshanshangxiaowusleep1

				if var_207_54 then
					Object.Destroy(var_207_54)

					arg_204_1.var_.effectshanshangxiaowusleep1 = nil
				end
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_55 = 4
			local var_207_56 = 1.35

			if var_207_55 < arg_204_1.time_ and arg_204_1.time_ <= var_207_55 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_57 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_57:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_204_1.dialogCg_.alpha = arg_210_0
				end))
				var_207_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_58 = arg_204_1:GetWordFromCfg(424071049)
				local var_207_59 = arg_204_1:FormatText(var_207_58.content)

				arg_204_1.text_.text = var_207_59

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_60 = 54
				local var_207_61 = utf8.len(var_207_59)
				local var_207_62 = var_207_60 <= 0 and var_207_56 or var_207_56 * (var_207_61 / var_207_60)

				if var_207_62 > 0 and var_207_56 < var_207_62 then
					arg_204_1.talkMaxDuration = var_207_62
					var_207_55 = var_207_55 + 0.3

					if var_207_62 + var_207_55 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_62 + var_207_55
					end
				end

				arg_204_1.text_.text = var_207_59
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_63 = var_207_55 + 0.3
			local var_207_64 = math.max(var_207_56, arg_204_1.talkMaxDuration)

			if var_207_63 <= arg_204_1.time_ and arg_204_1.time_ < var_207_63 + var_207_64 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_63) / var_207_64

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_63 + var_207_64 and arg_204_1.time_ < var_207_63 + var_207_64 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play424071050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 424071050
		arg_212_1.duration_ = 2.37

		local var_212_0 = {
			zh = 1.533,
			ja = 2.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play424071051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1094"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1094 == nil then
				arg_212_1.var_.actorSpriteComps1094 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps1094 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								local var_215_4 = Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, var_215_3)
								local var_215_5 = Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, var_215_3)
								local var_215_6 = Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, var_215_3)

								iter_215_1.color = Color.New(var_215_4, var_215_5, var_215_6)
							else
								local var_215_7 = Mathf.Lerp(iter_215_1.color.r, 1, var_215_3)

								iter_215_1.color = Color.New(var_215_7, var_215_7, var_215_7)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1094 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps1094 = nil
			end

			local var_215_8 = arg_212_1.actors_["1094"].transform
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.var_.moveOldPos1094 = var_215_8.localPosition
				var_215_8.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1094", 3)

				local var_215_10 = var_215_8.childCount

				for iter_215_4 = 0, var_215_10 - 1 do
					local var_215_11 = var_215_8:GetChild(iter_215_4)

					if var_215_11.name == "split_4" or not string.find(var_215_11.name, "split") then
						var_215_11.gameObject:SetActive(true)
					else
						var_215_11.gameObject:SetActive(false)
					end
				end
			end

			local var_215_12 = 0.001

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_12 then
				local var_215_13 = (arg_212_1.time_ - var_215_9) / var_215_12
				local var_215_14 = Vector3.New(0, -335, -230)

				var_215_8.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1094, var_215_14, var_215_13)
			end

			if arg_212_1.time_ >= var_215_9 + var_215_12 and arg_212_1.time_ < var_215_9 + var_215_12 + arg_215_0 then
				var_215_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_215_15 = 0
			local var_215_16 = 0.2

			if var_215_15 < arg_212_1.time_ and arg_212_1.time_ <= var_215_15 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_17 = arg_212_1:FormatText(StoryNameCfg[181].name)

				arg_212_1.leftNameTxt_.text = var_215_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_18 = arg_212_1:GetWordFromCfg(424071050)
				local var_215_19 = arg_212_1:FormatText(var_215_18.content)

				arg_212_1.text_.text = var_215_19

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_20 = 8
				local var_215_21 = utf8.len(var_215_19)
				local var_215_22 = var_215_20 <= 0 and var_215_16 or var_215_16 * (var_215_21 / var_215_20)

				if var_215_22 > 0 and var_215_16 < var_215_22 then
					arg_212_1.talkMaxDuration = var_215_22

					if var_215_22 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_22 + var_215_15
					end
				end

				arg_212_1.text_.text = var_215_19
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071050", "story_v_out_424071.awb") ~= 0 then
					local var_215_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071050", "story_v_out_424071.awb") / 1000

					if var_215_23 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_15
					end

					if var_215_18.prefab_name ~= "" and arg_212_1.actors_[var_215_18.prefab_name] ~= nil then
						local var_215_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_18.prefab_name].transform, "story_v_out_424071", "424071050", "story_v_out_424071.awb")

						arg_212_1:RecordAudio("424071050", var_215_24)
						arg_212_1:RecordAudio("424071050", var_215_24)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_424071", "424071050", "story_v_out_424071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_424071", "424071050", "story_v_out_424071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_16, arg_212_1.talkMaxDuration)

			if var_215_15 <= arg_212_1.time_ and arg_212_1.time_ < var_215_15 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_15) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_15 + var_215_25 and arg_212_1.time_ < var_215_15 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play424071051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 424071051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play424071052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1094"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1094 == nil then
				arg_216_1.var_.actorSpriteComps1094 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps1094 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 0.5, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1094 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1094 = nil
			end

			local var_219_8 = 0
			local var_219_9 = 1.25

			if var_219_8 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_10 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_11 = arg_216_1:GetWordFromCfg(424071051)
				local var_219_12 = arg_216_1:FormatText(var_219_11.content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 50
				local var_219_14 = utf8.len(var_219_12)
				local var_219_15 = var_219_13 <= 0 and var_219_9 or var_219_9 * (var_219_14 / var_219_13)

				if var_219_15 > 0 and var_219_9 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play424071052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 424071052
		arg_220_1.duration_ = 3.53

		local var_220_0 = {
			zh = 2.7,
			ja = 3.533
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play424071053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.375

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[177].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:GetWordFromCfg(424071052)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 15
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071052", "story_v_out_424071.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071052", "story_v_out_424071.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_424071", "424071052", "story_v_out_424071.awb")

						arg_220_1:RecordAudio("424071052", var_223_9)
						arg_220_1:RecordAudio("424071052", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_424071", "424071052", "story_v_out_424071.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_424071", "424071052", "story_v_out_424071.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play424071053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 424071053
		arg_224_1.duration_ = 2.47

		local var_224_0 = {
			zh = 2.466,
			ja = 2.433
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play424071054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1094"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1094 == nil then
				arg_224_1.var_.actorSpriteComps1094 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps1094 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_4 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, var_227_3)
								local var_227_5 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, var_227_3)
								local var_227_6 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, var_227_3)

								iter_227_1.color = Color.New(var_227_4, var_227_5, var_227_6)
							else
								local var_227_7 = Mathf.Lerp(iter_227_1.color.r, 1, var_227_3)

								iter_227_1.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1094 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1094 = nil
			end

			local var_227_8 = arg_224_1.actors_["1094"].transform
			local var_227_9 = 0

			if var_227_9 < arg_224_1.time_ and arg_224_1.time_ <= var_227_9 + arg_227_0 then
				arg_224_1.var_.moveOldPos1094 = var_227_8.localPosition
				var_227_8.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("1094", 3)

				local var_227_10 = var_227_8.childCount

				for iter_227_4 = 0, var_227_10 - 1 do
					local var_227_11 = var_227_8:GetChild(iter_227_4)

					if var_227_11.name == "" then
						var_227_11:SetAsLastSibling()
						var_227_11.gameObject:SetActive(true)

						arg_224_1.var_.actorSpriteSplit1094 = var_227_11.gameObject:GetComponent(typeof(Image))

						arg_224_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_227_12 = 0.5

			if var_227_9 <= arg_224_1.time_ and arg_224_1.time_ < var_227_9 + var_227_12 then
				local var_227_13 = (arg_224_1.time_ - var_227_9) / var_227_12
				local var_227_14 = Vector3.New(0, -335, -230)

				var_227_8.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1094, var_227_14, var_227_13)

				if arg_224_1.var_.actorSpriteSplit1094 ~= nil then
					arg_224_1.var_.actorSpriteSplit1094:SetAlpha(var_227_13)
				end
			end

			if arg_224_1.time_ >= var_227_9 + var_227_12 and arg_224_1.time_ < var_227_9 + var_227_12 + arg_227_0 then
				var_227_8.localPosition = Vector3.New(0, -335, -230)

				if arg_224_1.var_.actorSpriteSplit1094 ~= nil then
					arg_224_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_227_15 = 0
			local var_227_16 = 0.2

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_17 = arg_224_1:FormatText(StoryNameCfg[181].name)

				arg_224_1.leftNameTxt_.text = var_227_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_18 = arg_224_1:GetWordFromCfg(424071053)
				local var_227_19 = arg_224_1:FormatText(var_227_18.content)

				arg_224_1.text_.text = var_227_19

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_20 = 8
				local var_227_21 = utf8.len(var_227_19)
				local var_227_22 = var_227_20 <= 0 and var_227_16 or var_227_16 * (var_227_21 / var_227_20)

				if var_227_22 > 0 and var_227_16 < var_227_22 then
					arg_224_1.talkMaxDuration = var_227_22

					if var_227_22 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_22 + var_227_15
					end
				end

				arg_224_1.text_.text = var_227_19
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071053", "story_v_out_424071.awb") ~= 0 then
					local var_227_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071053", "story_v_out_424071.awb") / 1000

					if var_227_23 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_15
					end

					if var_227_18.prefab_name ~= "" and arg_224_1.actors_[var_227_18.prefab_name] ~= nil then
						local var_227_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_18.prefab_name].transform, "story_v_out_424071", "424071053", "story_v_out_424071.awb")

						arg_224_1:RecordAudio("424071053", var_227_24)
						arg_224_1:RecordAudio("424071053", var_227_24)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_424071", "424071053", "story_v_out_424071.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_424071", "424071053", "story_v_out_424071.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_25 = math.max(var_227_16, arg_224_1.talkMaxDuration)

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_25 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_15) / var_227_25

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_15 + var_227_25 and arg_224_1.time_ < var_227_15 + var_227_25 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play424071054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 424071054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play424071055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1094"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps1094 == nil then
				arg_228_1.var_.actorSpriteComps1094 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps1094 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 0.5, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps1094 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps1094 = nil
			end

			local var_231_8 = 0
			local var_231_9 = 0.725

			if var_231_8 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_10 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_11 = arg_228_1:GetWordFromCfg(424071054)
				local var_231_12 = arg_228_1:FormatText(var_231_11.content)

				arg_228_1.text_.text = var_231_12

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 29
				local var_231_14 = utf8.len(var_231_12)
				local var_231_15 = var_231_13 <= 0 and var_231_9 or var_231_9 * (var_231_14 / var_231_13)

				if var_231_15 > 0 and var_231_9 < var_231_15 then
					arg_228_1.talkMaxDuration = var_231_15

					if var_231_15 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_8
					end
				end

				arg_228_1.text_.text = var_231_12
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_9, arg_228_1.talkMaxDuration)

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_8) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_8 + var_231_16 and arg_228_1.time_ < var_231_8 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play424071055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 424071055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play424071056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1094"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1094 = var_235_0.localPosition
				var_235_0.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1094", 7)

				local var_235_2 = var_235_0.childCount

				for iter_235_0 = 0, var_235_2 - 1 do
					local var_235_3 = var_235_0:GetChild(iter_235_0)

					if var_235_3.name == "" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_4 then
				local var_235_5 = (arg_232_1.time_ - var_235_1) / var_235_4
				local var_235_6 = Vector3.New(0, -2000, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1094, var_235_6, var_235_5)
			end

			if arg_232_1.time_ >= var_235_1 + var_235_4 and arg_232_1.time_ < var_235_1 + var_235_4 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_235_7 = 0
			local var_235_8 = 1.3

			if var_235_7 < arg_232_1.time_ and arg_232_1.time_ <= var_235_7 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_9 = arg_232_1:GetWordFromCfg(424071055)
				local var_235_10 = arg_232_1:FormatText(var_235_9.content)

				arg_232_1.text_.text = var_235_10

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 52
				local var_235_12 = utf8.len(var_235_10)
				local var_235_13 = var_235_11 <= 0 and var_235_8 or var_235_8 * (var_235_12 / var_235_11)

				if var_235_13 > 0 and var_235_8 < var_235_13 then
					arg_232_1.talkMaxDuration = var_235_13

					if var_235_13 + var_235_7 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_7
					end
				end

				arg_232_1.text_.text = var_235_10
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_14 = math.max(var_235_8, arg_232_1.talkMaxDuration)

			if var_235_7 <= arg_232_1.time_ and arg_232_1.time_ < var_235_7 + var_235_14 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_7) / var_235_14

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_7 + var_235_14 and arg_232_1.time_ < var_235_7 + var_235_14 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play424071056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 424071056
		arg_236_1.duration_ = 9

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play424071057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = "ST0115"

			if arg_236_1.bgs_[var_239_0] == nil then
				local var_239_1 = Object.Instantiate(arg_236_1.paintGo_)

				var_239_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_239_0)
				var_239_1.name = var_239_0
				var_239_1.transform.parent = arg_236_1.stage_.transform
				var_239_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.bgs_[var_239_0] = var_239_1
			end

			local var_239_2 = 2

			if var_239_2 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				local var_239_3 = manager.ui.mainCamera.transform.localPosition
				local var_239_4 = Vector3.New(0, 0, 10) + Vector3.New(var_239_3.x, var_239_3.y, 0)
				local var_239_5 = arg_236_1.bgs_.ST0115

				var_239_5.transform.localPosition = var_239_4
				var_239_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_239_6 = var_239_5:GetComponent("SpriteRenderer")

				if var_239_6 and var_239_6.sprite then
					local var_239_7 = (var_239_5.transform.localPosition - var_239_3).z
					local var_239_8 = manager.ui.mainCameraCom_
					local var_239_9 = 2 * var_239_7 * Mathf.Tan(var_239_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_239_10 = var_239_9 * var_239_8.aspect
					local var_239_11 = var_239_6.sprite.bounds.size.x
					local var_239_12 = var_239_6.sprite.bounds.size.y
					local var_239_13 = var_239_10 / var_239_11
					local var_239_14 = var_239_9 / var_239_12
					local var_239_15 = var_239_14 < var_239_13 and var_239_13 or var_239_14

					var_239_5.transform.localScale = Vector3.New(var_239_15, var_239_15, 0)
				end

				for iter_239_0, iter_239_1 in pairs(arg_236_1.bgs_) do
					if iter_239_0 ~= "ST0115" then
						iter_239_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_239_16 = 4

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 then
				arg_236_1.allBtn_.enabled = false
			end

			local var_239_17 = 0.3

			if arg_236_1.time_ >= var_239_16 + var_239_17 and arg_236_1.time_ < var_239_16 + var_239_17 + arg_239_0 then
				arg_236_1.allBtn_.enabled = true
			end

			local var_239_18 = 0

			if var_239_18 < arg_236_1.time_ and arg_236_1.time_ <= var_239_18 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_19 = 2

			if var_239_18 <= arg_236_1.time_ and arg_236_1.time_ < var_239_18 + var_239_19 then
				local var_239_20 = (arg_236_1.time_ - var_239_18) / var_239_19
				local var_239_21 = Color.New(0, 0, 0)

				var_239_21.a = Mathf.Lerp(0, 1, var_239_20)
				arg_236_1.mask_.color = var_239_21
			end

			if arg_236_1.time_ >= var_239_18 + var_239_19 and arg_236_1.time_ < var_239_18 + var_239_19 + arg_239_0 then
				local var_239_22 = Color.New(0, 0, 0)

				var_239_22.a = 1
				arg_236_1.mask_.color = var_239_22
			end

			local var_239_23 = 2

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_24 = 2

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_24 then
				local var_239_25 = (arg_236_1.time_ - var_239_23) / var_239_24
				local var_239_26 = Color.New(0, 0, 0)

				var_239_26.a = Mathf.Lerp(1, 0, var_239_25)
				arg_236_1.mask_.color = var_239_26
			end

			if arg_236_1.time_ >= var_239_23 + var_239_24 and arg_236_1.time_ < var_239_23 + var_239_24 + arg_239_0 then
				local var_239_27 = Color.New(0, 0, 0)
				local var_239_28 = 0

				arg_236_1.mask_.enabled = false
				var_239_27.a = var_239_28
				arg_236_1.mask_.color = var_239_27
			end

			local var_239_29 = 0.233333333333333
			local var_239_30 = 1

			if var_239_29 < arg_236_1.time_ and arg_236_1.time_ <= var_239_29 + arg_239_0 then
				local var_239_31 = "stop"
				local var_239_32 = "effect"

				arg_236_1:AudioAction(var_239_31, var_239_32, "se_story_133", "se_story_133_sea", "")
			end

			local var_239_33 = 1.7
			local var_239_34 = 1

			if var_239_33 < arg_236_1.time_ and arg_236_1.time_ <= var_239_33 + arg_239_0 then
				local var_239_35 = "play"
				local var_239_36 = "effect"

				arg_236_1:AudioAction(var_239_35, var_239_36, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_236_1.frameCnt_ <= 1 then
				arg_236_1.dialog_:SetActive(false)
			end

			local var_239_37 = 4
			local var_239_38 = 0.375

			if var_239_37 < arg_236_1.time_ and arg_236_1.time_ <= var_239_37 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0

				arg_236_1.dialog_:SetActive(true)

				arg_236_1.dialogCg_.alpha = 0

				local var_239_39 = LeanTween.value(arg_236_1.dialog_, 0, 1, 0.3)

				var_239_39:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_236_1.dialogCg_.alpha = arg_240_0
				end))
				var_239_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_236_1.dialog_)
					var_239_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_236_1.duration_ = arg_236_1.duration_ + 0.3

				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_40 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_41 = arg_236_1:GetWordFromCfg(424071056)
				local var_239_42 = arg_236_1:FormatText(var_239_41.content)

				arg_236_1.text_.text = var_239_42

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_43 = 15
				local var_239_44 = utf8.len(var_239_42)
				local var_239_45 = var_239_43 <= 0 and var_239_38 or var_239_38 * (var_239_44 / var_239_43)

				if var_239_45 > 0 and var_239_38 < var_239_45 then
					arg_236_1.talkMaxDuration = var_239_45
					var_239_37 = var_239_37 + 0.3

					if var_239_45 + var_239_37 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_45 + var_239_37
					end
				end

				arg_236_1.text_.text = var_239_42
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_46 = var_239_37 + 0.3
			local var_239_47 = math.max(var_239_38, arg_236_1.talkMaxDuration)

			if var_239_46 <= arg_236_1.time_ and arg_236_1.time_ < var_239_46 + var_239_47 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_46) / var_239_47

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_46 + var_239_47 and arg_236_1.time_ < var_239_46 + var_239_47 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play424071057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 424071057
		arg_242_1.duration_ = 12

		local var_242_0 = {
			zh = 8.133,
			ja = 12
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play424071058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = "10155"

			if arg_242_1.actors_[var_245_0] == nil then
				local var_245_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_245_1) then
					local var_245_2 = Object.Instantiate(var_245_1, arg_242_1.canvasGo_.transform)

					var_245_2.transform:SetSiblingIndex(1)

					var_245_2.name = var_245_0
					var_245_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_242_1.actors_[var_245_0] = var_245_2

					local var_245_3 = var_245_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_242_1.isInRecall_ then
						for iter_245_0, iter_245_1 in ipairs(var_245_3) do
							iter_245_1.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_245_4 = arg_242_1.actors_["10155"]
			local var_245_5 = 0

			if var_245_5 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 and not isNil(var_245_4) and arg_242_1.var_.actorSpriteComps10155 == nil then
				arg_242_1.var_.actorSpriteComps10155 = var_245_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_6 = 0.2

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 and not isNil(var_245_4) then
				local var_245_7 = (arg_242_1.time_ - var_245_5) / var_245_6

				if arg_242_1.var_.actorSpriteComps10155 then
					for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_245_3 then
							if arg_242_1.isInRecall_ then
								local var_245_8 = Mathf.Lerp(iter_245_3.color.r, arg_242_1.hightColor1.r, var_245_7)
								local var_245_9 = Mathf.Lerp(iter_245_3.color.g, arg_242_1.hightColor1.g, var_245_7)
								local var_245_10 = Mathf.Lerp(iter_245_3.color.b, arg_242_1.hightColor1.b, var_245_7)

								iter_245_3.color = Color.New(var_245_8, var_245_9, var_245_10)
							else
								local var_245_11 = Mathf.Lerp(iter_245_3.color.r, 1, var_245_7)

								iter_245_3.color = Color.New(var_245_11, var_245_11, var_245_11)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 and not isNil(var_245_4) and arg_242_1.var_.actorSpriteComps10155 then
				for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_245_5 then
						if arg_242_1.isInRecall_ then
							iter_245_5.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps10155 = nil
			end

			local var_245_12 = arg_242_1.actors_["10155"].transform
			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1.var_.moveOldPos10155 = var_245_12.localPosition
				var_245_12.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10155", 3)

				local var_245_14 = var_245_12.childCount

				for iter_245_6 = 0, var_245_14 - 1 do
					local var_245_15 = var_245_12:GetChild(iter_245_6)

					if var_245_15.name == "split_5" or not string.find(var_245_15.name, "split") then
						var_245_15.gameObject:SetActive(true)
					else
						var_245_15.gameObject:SetActive(false)
					end
				end
			end

			local var_245_16 = 0.001

			if var_245_13 <= arg_242_1.time_ and arg_242_1.time_ < var_245_13 + var_245_16 then
				local var_245_17 = (arg_242_1.time_ - var_245_13) / var_245_16
				local var_245_18 = Vector3.New(-40, -390, -250)

				var_245_12.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10155, var_245_18, var_245_17)
			end

			if arg_242_1.time_ >= var_245_13 + var_245_16 and arg_242_1.time_ < var_245_13 + var_245_16 + arg_245_0 then
				var_245_12.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_245_19 = 0
			local var_245_20 = 0.75

			if var_245_19 < arg_242_1.time_ and arg_242_1.time_ <= var_245_19 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_21 = arg_242_1:FormatText(StoryNameCfg[1391].name)

				arg_242_1.leftNameTxt_.text = var_245_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_22 = arg_242_1:GetWordFromCfg(424071057)
				local var_245_23 = arg_242_1:FormatText(var_245_22.content)

				arg_242_1.text_.text = var_245_23

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_24 = 30
				local var_245_25 = utf8.len(var_245_23)
				local var_245_26 = var_245_24 <= 0 and var_245_20 or var_245_20 * (var_245_25 / var_245_24)

				if var_245_26 > 0 and var_245_20 < var_245_26 then
					arg_242_1.talkMaxDuration = var_245_26

					if var_245_26 + var_245_19 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_26 + var_245_19
					end
				end

				arg_242_1.text_.text = var_245_23
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071057", "story_v_out_424071.awb") ~= 0 then
					local var_245_27 = manager.audio:GetVoiceLength("story_v_out_424071", "424071057", "story_v_out_424071.awb") / 1000

					if var_245_27 + var_245_19 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_27 + var_245_19
					end

					if var_245_22.prefab_name ~= "" and arg_242_1.actors_[var_245_22.prefab_name] ~= nil then
						local var_245_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_22.prefab_name].transform, "story_v_out_424071", "424071057", "story_v_out_424071.awb")

						arg_242_1:RecordAudio("424071057", var_245_28)
						arg_242_1:RecordAudio("424071057", var_245_28)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_424071", "424071057", "story_v_out_424071.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_424071", "424071057", "story_v_out_424071.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_29 = math.max(var_245_20, arg_242_1.talkMaxDuration)

			if var_245_19 <= arg_242_1.time_ and arg_242_1.time_ < var_245_19 + var_245_29 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_19) / var_245_29

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_19 + var_245_29 and arg_242_1.time_ < var_245_19 + var_245_29 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play424071058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 424071058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play424071059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10155"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps10155 == nil then
				arg_246_1.var_.actorSpriteComps10155 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps10155 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps10155 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps10155 = nil
			end

			local var_249_8 = 0
			local var_249_9 = 0.85

			if var_249_8 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_10 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_11 = arg_246_1:GetWordFromCfg(424071058)
				local var_249_12 = arg_246_1:FormatText(var_249_11.content)

				arg_246_1.text_.text = var_249_12

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 34
				local var_249_14 = utf8.len(var_249_12)
				local var_249_15 = var_249_13 <= 0 and var_249_9 or var_249_9 * (var_249_14 / var_249_13)

				if var_249_15 > 0 and var_249_9 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_12
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play424071059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 424071059
		arg_250_1.duration_ = 14.97

		local var_250_0 = {
			zh = 7.233,
			ja = 14.966
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play424071060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10155"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10155 == nil then
				arg_250_1.var_.actorSpriteComps10155 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps10155 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 1, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10155 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_253_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps10155 = nil
			end

			local var_253_8 = arg_250_1.actors_["10155"].transform
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.var_.moveOldPos10155 = var_253_8.localPosition
				var_253_8.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10155", 3)

				local var_253_10 = var_253_8.childCount

				for iter_253_4 = 0, var_253_10 - 1 do
					local var_253_11 = var_253_8:GetChild(iter_253_4)

					if var_253_11.name == "split_1" then
						var_253_11:SetAsLastSibling()
						var_253_11.gameObject:SetActive(true)

						arg_250_1.var_.actorSpriteSplit10155 = var_253_11.gameObject:GetComponent(typeof(Image))

						arg_250_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_253_12 = 0.5

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_9) / var_253_12
				local var_253_14 = Vector3.New(-40, -390, -250)

				var_253_8.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10155, var_253_14, var_253_13)

				if arg_250_1.var_.actorSpriteSplit10155 ~= nil then
					arg_250_1.var_.actorSpriteSplit10155:SetAlpha(var_253_13)
				end
			end

			if arg_250_1.time_ >= var_253_9 + var_253_12 and arg_250_1.time_ < var_253_9 + var_253_12 + arg_253_0 then
				var_253_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_250_1.var_.actorSpriteSplit10155 ~= nil then
					arg_250_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_253_15 = 0
			local var_253_16 = 0.9

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[1391].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(424071059)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 36
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071059", "story_v_out_424071.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071059", "story_v_out_424071.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_out_424071", "424071059", "story_v_out_424071.awb")

						arg_250_1:RecordAudio("424071059", var_253_24)
						arg_250_1:RecordAudio("424071059", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_424071", "424071059", "story_v_out_424071.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_424071", "424071059", "story_v_out_424071.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play424071060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 424071060
		arg_254_1.duration_ = 3.27

		local var_254_0 = {
			zh = 2.333,
			ja = 3.266
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
				arg_254_0:Play424071061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1094"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1094 == nil then
				arg_254_1.var_.actorSpriteComps1094 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps1094 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1094 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1094 = nil
			end

			local var_257_8 = arg_254_1.actors_["10155"]
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps10155 == nil then
				arg_254_1.var_.actorSpriteComps10155 = var_257_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_10 = 0.2

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_10 and not isNil(var_257_8) then
				local var_257_11 = (arg_254_1.time_ - var_257_9) / var_257_10

				if arg_254_1.var_.actorSpriteComps10155 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								local var_257_12 = Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, var_257_11)
								local var_257_13 = Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, var_257_11)
								local var_257_14 = Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, var_257_11)

								iter_257_5.color = Color.New(var_257_12, var_257_13, var_257_14)
							else
								local var_257_15 = Mathf.Lerp(iter_257_5.color.r, 0.5, var_257_11)

								iter_257_5.color = Color.New(var_257_15, var_257_15, var_257_15)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_9 + var_257_10 and arg_254_1.time_ < var_257_9 + var_257_10 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps10155 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_257_7 then
						if arg_254_1.isInRecall_ then
							iter_257_7.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps10155 = nil
			end

			local var_257_16 = arg_254_1.actors_["1094"].transform
			local var_257_17 = 0

			if var_257_17 < arg_254_1.time_ and arg_254_1.time_ <= var_257_17 + arg_257_0 then
				arg_254_1.var_.moveOldPos1094 = var_257_16.localPosition
				var_257_16.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1094", 4)

				local var_257_18 = var_257_16.childCount

				for iter_257_8 = 0, var_257_18 - 1 do
					local var_257_19 = var_257_16:GetChild(iter_257_8)

					if var_257_19.name == "split_1" or not string.find(var_257_19.name, "split") then
						var_257_19.gameObject:SetActive(true)
					else
						var_257_19.gameObject:SetActive(false)
					end
				end
			end

			local var_257_20 = 0.001

			if var_257_17 <= arg_254_1.time_ and arg_254_1.time_ < var_257_17 + var_257_20 then
				local var_257_21 = (arg_254_1.time_ - var_257_17) / var_257_20
				local var_257_22 = Vector3.New(470, -335, -230)

				var_257_16.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1094, var_257_22, var_257_21)
			end

			if arg_254_1.time_ >= var_257_17 + var_257_20 and arg_254_1.time_ < var_257_17 + var_257_20 + arg_257_0 then
				var_257_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_257_23 = arg_254_1.actors_["10155"].transform
			local var_257_24 = 0

			if var_257_24 < arg_254_1.time_ and arg_254_1.time_ <= var_257_24 + arg_257_0 then
				arg_254_1.var_.moveOldPos10155 = var_257_23.localPosition
				var_257_23.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10155", 2)

				local var_257_25 = var_257_23.childCount

				for iter_257_9 = 0, var_257_25 - 1 do
					local var_257_26 = var_257_23:GetChild(iter_257_9)

					if var_257_26.name == "split_1" or not string.find(var_257_26.name, "split") then
						var_257_26.gameObject:SetActive(true)
					else
						var_257_26.gameObject:SetActive(false)
					end
				end
			end

			local var_257_27 = 0.001

			if var_257_24 <= arg_254_1.time_ and arg_254_1.time_ < var_257_24 + var_257_27 then
				local var_257_28 = (arg_254_1.time_ - var_257_24) / var_257_27
				local var_257_29 = Vector3.New(-410, -390, -250)

				var_257_23.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10155, var_257_29, var_257_28)
			end

			if arg_254_1.time_ >= var_257_24 + var_257_27 and arg_254_1.time_ < var_257_24 + var_257_27 + arg_257_0 then
				var_257_23.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_257_30 = 0
			local var_257_31 = 0.275

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_32 = arg_254_1:FormatText(StoryNameCfg[181].name)

				arg_254_1.leftNameTxt_.text = var_257_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_33 = arg_254_1:GetWordFromCfg(424071060)
				local var_257_34 = arg_254_1:FormatText(var_257_33.content)

				arg_254_1.text_.text = var_257_34

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_35 = 11
				local var_257_36 = utf8.len(var_257_34)
				local var_257_37 = var_257_35 <= 0 and var_257_31 or var_257_31 * (var_257_36 / var_257_35)

				if var_257_37 > 0 and var_257_31 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end

				arg_254_1.text_.text = var_257_34
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071060", "story_v_out_424071.awb") ~= 0 then
					local var_257_38 = manager.audio:GetVoiceLength("story_v_out_424071", "424071060", "story_v_out_424071.awb") / 1000

					if var_257_38 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_38 + var_257_30
					end

					if var_257_33.prefab_name ~= "" and arg_254_1.actors_[var_257_33.prefab_name] ~= nil then
						local var_257_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_33.prefab_name].transform, "story_v_out_424071", "424071060", "story_v_out_424071.awb")

						arg_254_1:RecordAudio("424071060", var_257_39)
						arg_254_1:RecordAudio("424071060", var_257_39)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_424071", "424071060", "story_v_out_424071.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_424071", "424071060", "story_v_out_424071.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_40 = math.max(var_257_31, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_40 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_30) / var_257_40

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_40 and arg_254_1.time_ < var_257_30 + var_257_40 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
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
	Play424071061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 424071061
		arg_258_1.duration_ = 4.47

		local var_258_0 = {
			zh = 3.133,
			ja = 4.466
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
				arg_258_0:Play424071062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1094"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps1094 == nil then
				arg_258_1.var_.actorSpriteComps1094 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps1094 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps1094 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps1094 = nil
			end

			local var_261_8 = 0
			local var_261_9 = 0.425

			if var_261_8 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_10 = arg_258_1:FormatText(StoryNameCfg[177].name)

				arg_258_1.leftNameTxt_.text = var_261_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_11 = arg_258_1:GetWordFromCfg(424071061)
				local var_261_12 = arg_258_1:FormatText(var_261_11.content)

				arg_258_1.text_.text = var_261_12

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 17
				local var_261_14 = utf8.len(var_261_12)
				local var_261_15 = var_261_13 <= 0 and var_261_9 or var_261_9 * (var_261_14 / var_261_13)

				if var_261_15 > 0 and var_261_9 < var_261_15 then
					arg_258_1.talkMaxDuration = var_261_15

					if var_261_15 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_15 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_12
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071061", "story_v_out_424071.awb") ~= 0 then
					local var_261_16 = manager.audio:GetVoiceLength("story_v_out_424071", "424071061", "story_v_out_424071.awb") / 1000

					if var_261_16 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_16 + var_261_8
					end

					if var_261_11.prefab_name ~= "" and arg_258_1.actors_[var_261_11.prefab_name] ~= nil then
						local var_261_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_11.prefab_name].transform, "story_v_out_424071", "424071061", "story_v_out_424071.awb")

						arg_258_1:RecordAudio("424071061", var_261_17)
						arg_258_1:RecordAudio("424071061", var_261_17)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_424071", "424071061", "story_v_out_424071.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_424071", "424071061", "story_v_out_424071.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_18 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_18 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_18

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_18 and arg_258_1.time_ < var_261_8 + var_261_18 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play424071062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 424071062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play424071063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.15

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(424071062)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 46
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play424071063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 424071063
		arg_266_1.duration_ = 5.3

		local var_266_0 = {
			zh = 4.1,
			ja = 5.3
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play424071064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10155"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps10155 == nil then
				arg_266_1.var_.actorSpriteComps10155 = var_269_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.actorSpriteComps10155 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								local var_269_4 = Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, var_269_3)
								local var_269_5 = Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, var_269_3)
								local var_269_6 = Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, var_269_3)

								iter_269_1.color = Color.New(var_269_4, var_269_5, var_269_6)
							else
								local var_269_7 = Mathf.Lerp(iter_269_1.color.r, 1, var_269_3)

								iter_269_1.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps10155 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_269_3 then
						if arg_266_1.isInRecall_ then
							iter_269_3.color = arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_269_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps10155 = nil
			end

			local var_269_8 = arg_266_1.actors_["10155"].transform
			local var_269_9 = 0

			if var_269_9 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 then
				arg_266_1.var_.moveOldPos10155 = var_269_8.localPosition
				var_269_8.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10155", 2)

				local var_269_10 = var_269_8.childCount

				for iter_269_4 = 0, var_269_10 - 1 do
					local var_269_11 = var_269_8:GetChild(iter_269_4)

					if var_269_11.name == "" or not string.find(var_269_11.name, "split") then
						var_269_11.gameObject:SetActive(true)
					else
						var_269_11.gameObject:SetActive(false)
					end
				end
			end

			local var_269_12 = 0.001

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_12 then
				local var_269_13 = (arg_266_1.time_ - var_269_9) / var_269_12
				local var_269_14 = Vector3.New(-410, -390, -250)

				var_269_8.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10155, var_269_14, var_269_13)
			end

			if arg_266_1.time_ >= var_269_9 + var_269_12 and arg_266_1.time_ < var_269_9 + var_269_12 + arg_269_0 then
				var_269_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_269_15 = 0
			local var_269_16 = 0.525

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[1391].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(424071063)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 21
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071063", "story_v_out_424071.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071063", "story_v_out_424071.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_out_424071", "424071063", "story_v_out_424071.awb")

						arg_266_1:RecordAudio("424071063", var_269_24)
						arg_266_1:RecordAudio("424071063", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_424071", "424071063", "story_v_out_424071.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_424071", "424071063", "story_v_out_424071.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play424071064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 424071064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play424071065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10155"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps10155 == nil then
				arg_270_1.var_.actorSpriteComps10155 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps10155 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor2.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor2.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor2.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 0.5, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps10155 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_273_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps10155 = nil
			end

			local var_273_8 = 0
			local var_273_9 = 0.525

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_10 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_11 = arg_270_1:GetWordFromCfg(424071064)
				local var_273_12 = arg_270_1:FormatText(var_273_11.content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 21
				local var_273_14 = utf8.len(var_273_12)
				local var_273_15 = var_273_13 <= 0 and var_273_9 or var_273_9 * (var_273_14 / var_273_13)

				if var_273_15 > 0 and var_273_9 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_8) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_16 and arg_270_1.time_ < var_273_8 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play424071065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 424071065
		arg_274_1.duration_ = 4.57

		local var_274_0 = {
			zh = 2.7,
			ja = 4.566
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
				arg_274_0:Play424071066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10155"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps10155 == nil then
				arg_274_1.var_.actorSpriteComps10155 = var_277_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.actorSpriteComps10155 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								local var_277_4 = Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor1.r, var_277_3)
								local var_277_5 = Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor1.g, var_277_3)
								local var_277_6 = Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor1.b, var_277_3)

								iter_277_1.color = Color.New(var_277_4, var_277_5, var_277_6)
							else
								local var_277_7 = Mathf.Lerp(iter_277_1.color.r, 1, var_277_3)

								iter_277_1.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps10155 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_277_3 then
						if arg_274_1.isInRecall_ then
							iter_277_3.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_277_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps10155 = nil
			end

			local var_277_8 = arg_274_1.actors_["10155"].transform
			local var_277_9 = 0

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1.var_.moveOldPos10155 = var_277_8.localPosition
				var_277_8.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10155", 2)

				local var_277_10 = var_277_8.childCount

				for iter_277_4 = 0, var_277_10 - 1 do
					local var_277_11 = var_277_8:GetChild(iter_277_4)

					if var_277_11.name == "split_4" then
						var_277_11:SetAsLastSibling()
						var_277_11.gameObject:SetActive(true)

						arg_274_1.var_.actorSpriteSplit10155 = var_277_11.gameObject:GetComponent(typeof(Image))

						arg_274_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_277_12 = 0.5

			if var_277_9 <= arg_274_1.time_ and arg_274_1.time_ < var_277_9 + var_277_12 then
				local var_277_13 = (arg_274_1.time_ - var_277_9) / var_277_12
				local var_277_14 = Vector3.New(-410, -390, -250)

				var_277_8.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10155, var_277_14, var_277_13)

				if arg_274_1.var_.actorSpriteSplit10155 ~= nil then
					arg_274_1.var_.actorSpriteSplit10155:SetAlpha(var_277_13)
				end
			end

			if arg_274_1.time_ >= var_277_9 + var_277_12 and arg_274_1.time_ < var_277_9 + var_277_12 + arg_277_0 then
				var_277_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_274_1.var_.actorSpriteSplit10155 ~= nil then
					arg_274_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_277_15 = 0
			local var_277_16 = 0.325

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[1391].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(424071065)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 13
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071065", "story_v_out_424071.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071065", "story_v_out_424071.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_out_424071", "424071065", "story_v_out_424071.awb")

						arg_274_1:RecordAudio("424071065", var_277_24)
						arg_274_1:RecordAudio("424071065", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_424071", "424071065", "story_v_out_424071.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_424071", "424071065", "story_v_out_424071.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play424071066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 424071066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play424071067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10155"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10155 == nil then
				arg_278_1.var_.actorSpriteComps10155 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps10155 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor2.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor2.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor2.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 0.5, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10155 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps10155 = nil
			end

			local var_281_8 = 0
			local var_281_9 = 0.65

			if var_281_8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_10 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_11 = arg_278_1:GetWordFromCfg(424071066)
				local var_281_12 = arg_278_1:FormatText(var_281_11.content)

				arg_278_1.text_.text = var_281_12

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 26
				local var_281_14 = utf8.len(var_281_12)
				local var_281_15 = var_281_13 <= 0 and var_281_9 or var_281_9 * (var_281_14 / var_281_13)

				if var_281_15 > 0 and var_281_9 < var_281_15 then
					arg_278_1.talkMaxDuration = var_281_15

					if var_281_15 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_15 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_12
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_16 and arg_278_1.time_ < var_281_8 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play424071067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 424071067
		arg_282_1.duration_ = 6.3

		local var_282_0 = {
			zh = 6.3,
			ja = 5.4
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play424071068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10155"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10155 == nil then
				arg_282_1.var_.actorSpriteComps10155 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps10155 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 1, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10155 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10155 = nil
			end

			local var_285_8 = arg_282_1.actors_["10155"].transform
			local var_285_9 = 0

			if var_285_9 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 then
				arg_282_1.var_.moveOldPos10155 = var_285_8.localPosition
				var_285_8.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10155", 2)

				local var_285_10 = var_285_8.childCount

				for iter_285_4 = 0, var_285_10 - 1 do
					local var_285_11 = var_285_8:GetChild(iter_285_4)

					if var_285_11.name == "split_1" then
						var_285_11:SetAsLastSibling()
						var_285_11.gameObject:SetActive(true)

						arg_282_1.var_.actorSpriteSplit10155 = var_285_11.gameObject:GetComponent(typeof(Image))

						arg_282_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_285_12 = 0.5

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_12 then
				local var_285_13 = (arg_282_1.time_ - var_285_9) / var_285_12
				local var_285_14 = Vector3.New(-410, -390, -250)

				var_285_8.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10155, var_285_14, var_285_13)

				if arg_282_1.var_.actorSpriteSplit10155 ~= nil then
					arg_282_1.var_.actorSpriteSplit10155:SetAlpha(var_285_13)
				end
			end

			if arg_282_1.time_ >= var_285_9 + var_285_12 and arg_282_1.time_ < var_285_9 + var_285_12 + arg_285_0 then
				var_285_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_282_1.var_.actorSpriteSplit10155 ~= nil then
					arg_282_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_285_15 = 0
			local var_285_16 = 0.55

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_17 = arg_282_1:FormatText(StoryNameCfg[1391].name)

				arg_282_1.leftNameTxt_.text = var_285_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_18 = arg_282_1:GetWordFromCfg(424071067)
				local var_285_19 = arg_282_1:FormatText(var_285_18.content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_20 = 22
				local var_285_21 = utf8.len(var_285_19)
				local var_285_22 = var_285_20 <= 0 and var_285_16 or var_285_16 * (var_285_21 / var_285_20)

				if var_285_22 > 0 and var_285_16 < var_285_22 then
					arg_282_1.talkMaxDuration = var_285_22

					if var_285_22 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_22 + var_285_15
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071067", "story_v_out_424071.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071067", "story_v_out_424071.awb") / 1000

					if var_285_23 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_15
					end

					if var_285_18.prefab_name ~= "" and arg_282_1.actors_[var_285_18.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_18.prefab_name].transform, "story_v_out_424071", "424071067", "story_v_out_424071.awb")

						arg_282_1:RecordAudio("424071067", var_285_24)
						arg_282_1:RecordAudio("424071067", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_424071", "424071067", "story_v_out_424071.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_424071", "424071067", "story_v_out_424071.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_25 = math.max(var_285_16, arg_282_1.talkMaxDuration)

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_25 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_15) / var_285_25

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_15 + var_285_25 and arg_282_1.time_ < var_285_15 + var_285_25 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play424071068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 424071068
		arg_286_1.duration_ = 2.2

		local var_286_0 = {
			zh = 1.5,
			ja = 2.2
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
				arg_286_0:Play424071069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1094"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1094 == nil then
				arg_286_1.var_.actorSpriteComps1094 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps1094 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 1, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1094 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps1094 = nil
			end

			local var_289_8 = arg_286_1.actors_["10155"]
			local var_289_9 = 0

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10155 == nil then
				arg_286_1.var_.actorSpriteComps10155 = var_289_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_10 = 0.2

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_10 and not isNil(var_289_8) then
				local var_289_11 = (arg_286_1.time_ - var_289_9) / var_289_10

				if arg_286_1.var_.actorSpriteComps10155 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								local var_289_12 = Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, var_289_11)
								local var_289_13 = Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, var_289_11)
								local var_289_14 = Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, var_289_11)

								iter_289_5.color = Color.New(var_289_12, var_289_13, var_289_14)
							else
								local var_289_15 = Mathf.Lerp(iter_289_5.color.r, 0.5, var_289_11)

								iter_289_5.color = Color.New(var_289_15, var_289_15, var_289_15)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_9 + var_289_10 and arg_286_1.time_ < var_289_9 + var_289_10 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10155 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_289_7 then
						if arg_286_1.isInRecall_ then
							iter_289_7.color = arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_289_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps10155 = nil
			end

			local var_289_16 = arg_286_1.actors_["1094"].transform
			local var_289_17 = 0

			if var_289_17 < arg_286_1.time_ and arg_286_1.time_ <= var_289_17 + arg_289_0 then
				arg_286_1.var_.moveOldPos1094 = var_289_16.localPosition
				var_289_16.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("1094", 4)

				local var_289_18 = var_289_16.childCount

				for iter_289_8 = 0, var_289_18 - 1 do
					local var_289_19 = var_289_16:GetChild(iter_289_8)

					if var_289_19.name == "" or not string.find(var_289_19.name, "split") then
						var_289_19.gameObject:SetActive(true)
					else
						var_289_19.gameObject:SetActive(false)
					end
				end
			end

			local var_289_20 = 0.001

			if var_289_17 <= arg_286_1.time_ and arg_286_1.time_ < var_289_17 + var_289_20 then
				local var_289_21 = (arg_286_1.time_ - var_289_17) / var_289_20
				local var_289_22 = Vector3.New(470, -335, -230)

				var_289_16.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1094, var_289_22, var_289_21)
			end

			if arg_286_1.time_ >= var_289_17 + var_289_20 and arg_286_1.time_ < var_289_17 + var_289_20 + arg_289_0 then
				var_289_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_289_23 = 0
			local var_289_24 = 0.125

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_25 = arg_286_1:FormatText(StoryNameCfg[181].name)

				arg_286_1.leftNameTxt_.text = var_289_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_26 = arg_286_1:GetWordFromCfg(424071068)
				local var_289_27 = arg_286_1:FormatText(var_289_26.content)

				arg_286_1.text_.text = var_289_27

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_28 = 5
				local var_289_29 = utf8.len(var_289_27)
				local var_289_30 = var_289_28 <= 0 and var_289_24 or var_289_24 * (var_289_29 / var_289_28)

				if var_289_30 > 0 and var_289_24 < var_289_30 then
					arg_286_1.talkMaxDuration = var_289_30

					if var_289_30 + var_289_23 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_30 + var_289_23
					end
				end

				arg_286_1.text_.text = var_289_27
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071068", "story_v_out_424071.awb") ~= 0 then
					local var_289_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071068", "story_v_out_424071.awb") / 1000

					if var_289_31 + var_289_23 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_31 + var_289_23
					end

					if var_289_26.prefab_name ~= "" and arg_286_1.actors_[var_289_26.prefab_name] ~= nil then
						local var_289_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_26.prefab_name].transform, "story_v_out_424071", "424071068", "story_v_out_424071.awb")

						arg_286_1:RecordAudio("424071068", var_289_32)
						arg_286_1:RecordAudio("424071068", var_289_32)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_424071", "424071068", "story_v_out_424071.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_424071", "424071068", "story_v_out_424071.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_33 = math.max(var_289_24, arg_286_1.talkMaxDuration)

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_33 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_23) / var_289_33

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_23 + var_289_33 and arg_286_1.time_ < var_289_23 + var_289_33 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play424071069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 424071069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play424071070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1094"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1094 == nil then
				arg_290_1.var_.actorSpriteComps1094 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps1094 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 0.5, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1094 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps1094 = nil
			end

			local var_293_8 = 0
			local var_293_9 = 1.3

			if var_293_8 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_10 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_11 = arg_290_1:GetWordFromCfg(424071069)
				local var_293_12 = arg_290_1:FormatText(var_293_11.content)

				arg_290_1.text_.text = var_293_12

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_13 = 52
				local var_293_14 = utf8.len(var_293_12)
				local var_293_15 = var_293_13 <= 0 and var_293_9 or var_293_9 * (var_293_14 / var_293_13)

				if var_293_15 > 0 and var_293_9 < var_293_15 then
					arg_290_1.talkMaxDuration = var_293_15

					if var_293_15 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_15 + var_293_8
					end
				end

				arg_290_1.text_.text = var_293_12
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_9, arg_290_1.talkMaxDuration)

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_16 and arg_290_1.time_ < var_293_8 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play424071070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 424071070
		arg_294_1.duration_ = 4.73

		local var_294_0 = {
			zh = 3.066,
			ja = 4.733
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play424071071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.325

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[177].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(424071070)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 13
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071070", "story_v_out_424071.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071070", "story_v_out_424071.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_424071", "424071070", "story_v_out_424071.awb")

						arg_294_1:RecordAudio("424071070", var_297_9)
						arg_294_1:RecordAudio("424071070", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_424071", "424071070", "story_v_out_424071.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_424071", "424071070", "story_v_out_424071.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play424071071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 424071071
		arg_298_1.duration_ = 6.63

		local var_298_0 = {
			zh = 2.033,
			ja = 6.633
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
				arg_298_0:Play424071072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10155"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10155 == nil then
				arg_298_1.var_.actorSpriteComps10155 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps10155 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 1, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10155 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10155 = nil
			end

			local var_301_8 = arg_298_1.actors_["10155"].transform
			local var_301_9 = 0

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 then
				arg_298_1.var_.moveOldPos10155 = var_301_8.localPosition
				var_301_8.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("10155", 2)

				local var_301_10 = var_301_8.childCount

				for iter_301_4 = 0, var_301_10 - 1 do
					local var_301_11 = var_301_8:GetChild(iter_301_4)

					if var_301_11.name == "split_4" then
						var_301_11:SetAsLastSibling()
						var_301_11.gameObject:SetActive(true)

						arg_298_1.var_.actorSpriteSplit10155 = var_301_11.gameObject:GetComponent(typeof(Image))

						arg_298_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_301_12 = 0.5

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_12 then
				local var_301_13 = (arg_298_1.time_ - var_301_9) / var_301_12
				local var_301_14 = Vector3.New(-410, -390, -250)

				var_301_8.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10155, var_301_14, var_301_13)

				if arg_298_1.var_.actorSpriteSplit10155 ~= nil then
					arg_298_1.var_.actorSpriteSplit10155:SetAlpha(var_301_13)
				end
			end

			if arg_298_1.time_ >= var_301_9 + var_301_12 and arg_298_1.time_ < var_301_9 + var_301_12 + arg_301_0 then
				var_301_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_298_1.var_.actorSpriteSplit10155 ~= nil then
					arg_298_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_301_15 = 0
			local var_301_16 = 0.325

			if var_301_15 < arg_298_1.time_ and arg_298_1.time_ <= var_301_15 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_17 = arg_298_1:FormatText(StoryNameCfg[1391].name)

				arg_298_1.leftNameTxt_.text = var_301_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_18 = arg_298_1:GetWordFromCfg(424071071)
				local var_301_19 = arg_298_1:FormatText(var_301_18.content)

				arg_298_1.text_.text = var_301_19

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_20 = 13
				local var_301_21 = utf8.len(var_301_19)
				local var_301_22 = var_301_20 <= 0 and var_301_16 or var_301_16 * (var_301_21 / var_301_20)

				if var_301_22 > 0 and var_301_16 < var_301_22 then
					arg_298_1.talkMaxDuration = var_301_22

					if var_301_22 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_22 + var_301_15
					end
				end

				arg_298_1.text_.text = var_301_19
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071071", "story_v_out_424071.awb") ~= 0 then
					local var_301_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071071", "story_v_out_424071.awb") / 1000

					if var_301_23 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_15
					end

					if var_301_18.prefab_name ~= "" and arg_298_1.actors_[var_301_18.prefab_name] ~= nil then
						local var_301_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_18.prefab_name].transform, "story_v_out_424071", "424071071", "story_v_out_424071.awb")

						arg_298_1:RecordAudio("424071071", var_301_24)
						arg_298_1:RecordAudio("424071071", var_301_24)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_424071", "424071071", "story_v_out_424071.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_424071", "424071071", "story_v_out_424071.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_25 = math.max(var_301_16, arg_298_1.talkMaxDuration)

			if var_301_15 <= arg_298_1.time_ and arg_298_1.time_ < var_301_15 + var_301_25 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_15) / var_301_25

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_15 + var_301_25 and arg_298_1.time_ < var_301_15 + var_301_25 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play424071072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 424071072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play424071073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10155"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10155 == nil then
				arg_302_1.var_.actorSpriteComps10155 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps10155 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 0.5, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10155 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_305_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps10155 = nil
			end

			local var_305_8 = 0
			local var_305_9 = 0.95

			if var_305_8 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(424071072)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_12 = 38
				local var_305_13 = utf8.len(var_305_11)
				local var_305_14 = var_305_12 <= 0 and var_305_9 or var_305_9 * (var_305_13 / var_305_12)

				if var_305_14 > 0 and var_305_9 < var_305_14 then
					arg_302_1.talkMaxDuration = var_305_14

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_15 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_15 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_15

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_15 and arg_302_1.time_ < var_305_8 + var_305_15 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play424071073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 424071073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play424071074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.225

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:GetWordFromCfg(424071073)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 49
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_8 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_8 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_8

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_8 and arg_306_1.time_ < var_309_0 + var_309_8 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play424071074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 424071074
		arg_310_1.duration_ = 10.2

		local var_310_0 = {
			zh = 5.966,
			ja = 10.2
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play424071075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10155"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10155 == nil then
				arg_310_1.var_.actorSpriteComps10155 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps10155 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 1, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10155 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10155 = nil
			end

			local var_313_8 = arg_310_1.actors_["10155"].transform
			local var_313_9 = 0

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 then
				arg_310_1.var_.moveOldPos10155 = var_313_8.localPosition
				var_313_8.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10155", 2)

				local var_313_10 = var_313_8.childCount

				for iter_313_4 = 0, var_313_10 - 1 do
					local var_313_11 = var_313_8:GetChild(iter_313_4)

					if var_313_11.name == "split_3" then
						var_313_11:SetAsLastSibling()
						var_313_11.gameObject:SetActive(true)

						arg_310_1.var_.actorSpriteSplit10155 = var_313_11.gameObject:GetComponent(typeof(Image))

						arg_310_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_313_12 = 0.5

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_12 then
				local var_313_13 = (arg_310_1.time_ - var_313_9) / var_313_12
				local var_313_14 = Vector3.New(-410, -390, -250)

				var_313_8.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10155, var_313_14, var_313_13)

				if arg_310_1.var_.actorSpriteSplit10155 ~= nil then
					arg_310_1.var_.actorSpriteSplit10155:SetAlpha(var_313_13)
				end
			end

			if arg_310_1.time_ >= var_313_9 + var_313_12 and arg_310_1.time_ < var_313_9 + var_313_12 + arg_313_0 then
				var_313_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_310_1.var_.actorSpriteSplit10155 ~= nil then
					arg_310_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_313_15 = 0
			local var_313_16 = 0.725

			if var_313_15 < arg_310_1.time_ and arg_310_1.time_ <= var_313_15 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_17 = arg_310_1:FormatText(StoryNameCfg[1391].name)

				arg_310_1.leftNameTxt_.text = var_313_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_18 = arg_310_1:GetWordFromCfg(424071074)
				local var_313_19 = arg_310_1:FormatText(var_313_18.content)

				arg_310_1.text_.text = var_313_19

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_20 = 29
				local var_313_21 = utf8.len(var_313_19)
				local var_313_22 = var_313_20 <= 0 and var_313_16 or var_313_16 * (var_313_21 / var_313_20)

				if var_313_22 > 0 and var_313_16 < var_313_22 then
					arg_310_1.talkMaxDuration = var_313_22

					if var_313_22 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_22 + var_313_15
					end
				end

				arg_310_1.text_.text = var_313_19
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071074", "story_v_out_424071.awb") ~= 0 then
					local var_313_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071074", "story_v_out_424071.awb") / 1000

					if var_313_23 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_15
					end

					if var_313_18.prefab_name ~= "" and arg_310_1.actors_[var_313_18.prefab_name] ~= nil then
						local var_313_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_18.prefab_name].transform, "story_v_out_424071", "424071074", "story_v_out_424071.awb")

						arg_310_1:RecordAudio("424071074", var_313_24)
						arg_310_1:RecordAudio("424071074", var_313_24)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_424071", "424071074", "story_v_out_424071.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_424071", "424071074", "story_v_out_424071.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_25 = math.max(var_313_16, arg_310_1.talkMaxDuration)

			if var_313_15 <= arg_310_1.time_ and arg_310_1.time_ < var_313_15 + var_313_25 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_15) / var_313_25

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_15 + var_313_25 and arg_310_1.time_ < var_313_15 + var_313_25 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play424071075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 424071075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play424071076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10155"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10155 == nil then
				arg_314_1.var_.actorSpriteComps10155 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps10155 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 0.5, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10155 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10155 = nil
			end

			local var_317_8 = 0
			local var_317_9 = 1.425

			if var_317_8 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_10 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_11 = arg_314_1:GetWordFromCfg(424071075)
				local var_317_12 = arg_314_1:FormatText(var_317_11.content)

				arg_314_1.text_.text = var_317_12

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 57
				local var_317_14 = utf8.len(var_317_12)
				local var_317_15 = var_317_13 <= 0 and var_317_9 or var_317_9 * (var_317_14 / var_317_13)

				if var_317_15 > 0 and var_317_9 < var_317_15 then
					arg_314_1.talkMaxDuration = var_317_15

					if var_317_15 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_15 + var_317_8
					end
				end

				arg_314_1.text_.text = var_317_12
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_9, arg_314_1.talkMaxDuration)

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_8) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_8 + var_317_16 and arg_314_1.time_ < var_317_8 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play424071076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 424071076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play424071077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.5

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(424071076)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 60
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play424071077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 424071077
		arg_322_1.duration_ = 12.77

		local var_322_0 = {
			zh = 6.033,
			ja = 12.766
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play424071078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10155"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10155 == nil then
				arg_322_1.var_.actorSpriteComps10155 = var_325_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.actorSpriteComps10155 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								local var_325_4 = Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, var_325_3)
								local var_325_5 = Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, var_325_3)
								local var_325_6 = Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, var_325_3)

								iter_325_1.color = Color.New(var_325_4, var_325_5, var_325_6)
							else
								local var_325_7 = Mathf.Lerp(iter_325_1.color.r, 1, var_325_3)

								iter_325_1.color = Color.New(var_325_7, var_325_7, var_325_7)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10155 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_325_3 then
						if arg_322_1.isInRecall_ then
							iter_325_3.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_325_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps10155 = nil
			end

			local var_325_8 = arg_322_1.actors_["10155"].transform
			local var_325_9 = 0

			if var_325_9 < arg_322_1.time_ and arg_322_1.time_ <= var_325_9 + arg_325_0 then
				arg_322_1.var_.moveOldPos10155 = var_325_8.localPosition
				var_325_8.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10155", 2)

				local var_325_10 = var_325_8.childCount

				for iter_325_4 = 0, var_325_10 - 1 do
					local var_325_11 = var_325_8:GetChild(iter_325_4)

					if var_325_11.name == "split_4" then
						var_325_11:SetAsLastSibling()
						var_325_11.gameObject:SetActive(true)

						arg_322_1.var_.actorSpriteSplit10155 = var_325_11.gameObject:GetComponent(typeof(Image))

						arg_322_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_325_12 = 0.5

			if var_325_9 <= arg_322_1.time_ and arg_322_1.time_ < var_325_9 + var_325_12 then
				local var_325_13 = (arg_322_1.time_ - var_325_9) / var_325_12
				local var_325_14 = Vector3.New(-410, -390, -250)

				var_325_8.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10155, var_325_14, var_325_13)

				if arg_322_1.var_.actorSpriteSplit10155 ~= nil then
					arg_322_1.var_.actorSpriteSplit10155:SetAlpha(var_325_13)
				end
			end

			if arg_322_1.time_ >= var_325_9 + var_325_12 and arg_322_1.time_ < var_325_9 + var_325_12 + arg_325_0 then
				var_325_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_322_1.var_.actorSpriteSplit10155 ~= nil then
					arg_322_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_325_15 = 0
			local var_325_16 = 0.65

			if var_325_15 < arg_322_1.time_ and arg_322_1.time_ <= var_325_15 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_17 = arg_322_1:FormatText(StoryNameCfg[1391].name)

				arg_322_1.leftNameTxt_.text = var_325_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_18 = arg_322_1:GetWordFromCfg(424071077)
				local var_325_19 = arg_322_1:FormatText(var_325_18.content)

				arg_322_1.text_.text = var_325_19

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_20 = 26
				local var_325_21 = utf8.len(var_325_19)
				local var_325_22 = var_325_20 <= 0 and var_325_16 or var_325_16 * (var_325_21 / var_325_20)

				if var_325_22 > 0 and var_325_16 < var_325_22 then
					arg_322_1.talkMaxDuration = var_325_22

					if var_325_22 + var_325_15 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_22 + var_325_15
					end
				end

				arg_322_1.text_.text = var_325_19
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071077", "story_v_out_424071.awb") ~= 0 then
					local var_325_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071077", "story_v_out_424071.awb") / 1000

					if var_325_23 + var_325_15 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_23 + var_325_15
					end

					if var_325_18.prefab_name ~= "" and arg_322_1.actors_[var_325_18.prefab_name] ~= nil then
						local var_325_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_18.prefab_name].transform, "story_v_out_424071", "424071077", "story_v_out_424071.awb")

						arg_322_1:RecordAudio("424071077", var_325_24)
						arg_322_1:RecordAudio("424071077", var_325_24)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_424071", "424071077", "story_v_out_424071.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_424071", "424071077", "story_v_out_424071.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_25 = math.max(var_325_16, arg_322_1.talkMaxDuration)

			if var_325_15 <= arg_322_1.time_ and arg_322_1.time_ < var_325_15 + var_325_25 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_15) / var_325_25

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_15 + var_325_25 and arg_322_1.time_ < var_325_15 + var_325_25 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play424071078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 424071078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play424071079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10155"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10155 == nil then
				arg_326_1.var_.actorSpriteComps10155 = var_329_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.actorSpriteComps10155 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								local var_329_4 = Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, var_329_3)
								local var_329_5 = Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, var_329_3)
								local var_329_6 = Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, var_329_3)

								iter_329_1.color = Color.New(var_329_4, var_329_5, var_329_6)
							else
								local var_329_7 = Mathf.Lerp(iter_329_1.color.r, 0.5, var_329_3)

								iter_329_1.color = Color.New(var_329_7, var_329_7, var_329_7)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10155 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_329_3 then
						if arg_326_1.isInRecall_ then
							iter_329_3.color = arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_329_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps10155 = nil
			end

			local var_329_8 = 0
			local var_329_9 = 1.275

			if var_329_8 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_10 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_11 = arg_326_1:GetWordFromCfg(424071078)
				local var_329_12 = arg_326_1:FormatText(var_329_11.content)

				arg_326_1.text_.text = var_329_12

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 51
				local var_329_14 = utf8.len(var_329_12)
				local var_329_15 = var_329_13 <= 0 and var_329_9 or var_329_9 * (var_329_14 / var_329_13)

				if var_329_15 > 0 and var_329_9 < var_329_15 then
					arg_326_1.talkMaxDuration = var_329_15

					if var_329_15 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_15 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_12
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play424071079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 424071079
		arg_330_1.duration_ = 10.6

		local var_330_0 = {
			zh = 9,
			ja = 10.6
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play424071080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10155"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10155 == nil then
				arg_330_1.var_.actorSpriteComps10155 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps10155 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 1, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10155 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps10155 = nil
			end

			local var_333_8 = arg_330_1.actors_["10155"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos10155 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10155", 2)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "split_1" then
						var_333_11:SetAsLastSibling()
						var_333_11.gameObject:SetActive(true)

						arg_330_1.var_.actorSpriteSplit10155 = var_333_11.gameObject:GetComponent(typeof(Image))

						arg_330_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_333_12 = 0.5

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(-410, -390, -250)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10155, var_333_14, var_333_13)

				if arg_330_1.var_.actorSpriteSplit10155 ~= nil then
					arg_330_1.var_.actorSpriteSplit10155:SetAlpha(var_333_13)
				end
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_330_1.var_.actorSpriteSplit10155 ~= nil then
					arg_330_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_333_15 = 0
			local var_333_16 = 0.775

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[1391].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(424071079)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 31
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071079", "story_v_out_424071.awb") ~= 0 then
					local var_333_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071079", "story_v_out_424071.awb") / 1000

					if var_333_23 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_15
					end

					if var_333_18.prefab_name ~= "" and arg_330_1.actors_[var_333_18.prefab_name] ~= nil then
						local var_333_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_18.prefab_name].transform, "story_v_out_424071", "424071079", "story_v_out_424071.awb")

						arg_330_1:RecordAudio("424071079", var_333_24)
						arg_330_1:RecordAudio("424071079", var_333_24)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_424071", "424071079", "story_v_out_424071.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_424071", "424071079", "story_v_out_424071.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_25 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_25 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_25

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_25 and arg_330_1.time_ < var_333_15 + var_333_25 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play424071080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 424071080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play424071081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10155"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10155 == nil then
				arg_334_1.var_.actorSpriteComps10155 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps10155 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 0.5, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10155 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps10155 = nil
			end

			local var_337_8 = 0
			local var_337_9 = 0.825

			if var_337_8 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_10 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_11 = arg_334_1:GetWordFromCfg(424071080)
				local var_337_12 = arg_334_1:FormatText(var_337_11.content)

				arg_334_1.text_.text = var_337_12

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_13 = 33
				local var_337_14 = utf8.len(var_337_12)
				local var_337_15 = var_337_13 <= 0 and var_337_9 or var_337_9 * (var_337_14 / var_337_13)

				if var_337_15 > 0 and var_337_9 < var_337_15 then
					arg_334_1.talkMaxDuration = var_337_15

					if var_337_15 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_15 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_12
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_16 and arg_334_1.time_ < var_337_8 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play424071081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 424071081
		arg_338_1.duration_ = 4.6

		local var_338_0 = {
			zh = 3.3,
			ja = 4.6
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play424071082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1094"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1094 == nil then
				arg_338_1.var_.actorSpriteComps1094 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps1094 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1094 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps1094 = nil
			end

			local var_341_8 = arg_338_1.actors_["1094"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos1094 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1094", 4)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "" or not string.find(var_341_11.name, "split") then
						var_341_11.gameObject:SetActive(true)
					else
						var_341_11.gameObject:SetActive(false)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(470, -335, -230)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1094, var_341_14, var_341_13)
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_341_15 = 0
			local var_341_16 = 0.4

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[181].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_18 = arg_338_1:GetWordFromCfg(424071081)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 16
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071081", "story_v_out_424071.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071081", "story_v_out_424071.awb") / 1000

					if var_341_23 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_15
					end

					if var_341_18.prefab_name ~= "" and arg_338_1.actors_[var_341_18.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_18.prefab_name].transform, "story_v_out_424071", "424071081", "story_v_out_424071.awb")

						arg_338_1:RecordAudio("424071081", var_341_24)
						arg_338_1:RecordAudio("424071081", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_424071", "424071081", "story_v_out_424071.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_424071", "424071081", "story_v_out_424071.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_25 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_25

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_25 and arg_338_1.time_ < var_341_15 + var_341_25 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play424071082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 424071082
		arg_342_1.duration_ = 6.93

		local var_342_0 = {
			zh = 3.633,
			ja = 6.933
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play424071083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10155"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10155 == nil then
				arg_342_1.var_.actorSpriteComps10155 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps10155 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 1, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10155 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_345_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10155 = nil
			end

			local var_345_8 = arg_342_1.actors_["1094"]
			local var_345_9 = 0

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps1094 == nil then
				arg_342_1.var_.actorSpriteComps1094 = var_345_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_10 = 0.2

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_10 and not isNil(var_345_8) then
				local var_345_11 = (arg_342_1.time_ - var_345_9) / var_345_10

				if arg_342_1.var_.actorSpriteComps1094 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								local var_345_12 = Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, var_345_11)
								local var_345_13 = Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, var_345_11)
								local var_345_14 = Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, var_345_11)

								iter_345_5.color = Color.New(var_345_12, var_345_13, var_345_14)
							else
								local var_345_15 = Mathf.Lerp(iter_345_5.color.r, 0.5, var_345_11)

								iter_345_5.color = Color.New(var_345_15, var_345_15, var_345_15)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_9 + var_345_10 and arg_342_1.time_ < var_345_9 + var_345_10 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps1094 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_345_7 then
						if arg_342_1.isInRecall_ then
							iter_345_7.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps1094 = nil
			end

			local var_345_16 = arg_342_1.actors_["10155"].transform
			local var_345_17 = 0

			if var_345_17 < arg_342_1.time_ and arg_342_1.time_ <= var_345_17 + arg_345_0 then
				arg_342_1.var_.moveOldPos10155 = var_345_16.localPosition
				var_345_16.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10155", 2)

				local var_345_18 = var_345_16.childCount

				for iter_345_8 = 0, var_345_18 - 1 do
					local var_345_19 = var_345_16:GetChild(iter_345_8)

					if var_345_19.name == "split_2" then
						var_345_19:SetAsLastSibling()
						var_345_19.gameObject:SetActive(true)

						arg_342_1.var_.actorSpriteSplit10155 = var_345_19.gameObject:GetComponent(typeof(Image))

						arg_342_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_345_20 = 0.5

			if var_345_17 <= arg_342_1.time_ and arg_342_1.time_ < var_345_17 + var_345_20 then
				local var_345_21 = (arg_342_1.time_ - var_345_17) / var_345_20
				local var_345_22 = Vector3.New(-410, -390, -250)

				var_345_16.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10155, var_345_22, var_345_21)

				if arg_342_1.var_.actorSpriteSplit10155 ~= nil then
					arg_342_1.var_.actorSpriteSplit10155:SetAlpha(var_345_21)
				end
			end

			if arg_342_1.time_ >= var_345_17 + var_345_20 and arg_342_1.time_ < var_345_17 + var_345_20 + arg_345_0 then
				var_345_16.localPosition = Vector3.New(-410, -390, -250)

				if arg_342_1.var_.actorSpriteSplit10155 ~= nil then
					arg_342_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_345_23 = 0
			local var_345_24 = 0.425

			if var_345_23 < arg_342_1.time_ and arg_342_1.time_ <= var_345_23 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_25 = arg_342_1:FormatText(StoryNameCfg[1391].name)

				arg_342_1.leftNameTxt_.text = var_345_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_26 = arg_342_1:GetWordFromCfg(424071082)
				local var_345_27 = arg_342_1:FormatText(var_345_26.content)

				arg_342_1.text_.text = var_345_27

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_28 = 17
				local var_345_29 = utf8.len(var_345_27)
				local var_345_30 = var_345_28 <= 0 and var_345_24 or var_345_24 * (var_345_29 / var_345_28)

				if var_345_30 > 0 and var_345_24 < var_345_30 then
					arg_342_1.talkMaxDuration = var_345_30

					if var_345_30 + var_345_23 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_30 + var_345_23
					end
				end

				arg_342_1.text_.text = var_345_27
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071082", "story_v_out_424071.awb") ~= 0 then
					local var_345_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071082", "story_v_out_424071.awb") / 1000

					if var_345_31 + var_345_23 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_31 + var_345_23
					end

					if var_345_26.prefab_name ~= "" and arg_342_1.actors_[var_345_26.prefab_name] ~= nil then
						local var_345_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_26.prefab_name].transform, "story_v_out_424071", "424071082", "story_v_out_424071.awb")

						arg_342_1:RecordAudio("424071082", var_345_32)
						arg_342_1:RecordAudio("424071082", var_345_32)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_424071", "424071082", "story_v_out_424071.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_424071", "424071082", "story_v_out_424071.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_33 = math.max(var_345_24, arg_342_1.talkMaxDuration)

			if var_345_23 <= arg_342_1.time_ and arg_342_1.time_ < var_345_23 + var_345_33 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_23) / var_345_33

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_23 + var_345_33 and arg_342_1.time_ < var_345_23 + var_345_33 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play424071083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 424071083
		arg_346_1.duration_ = 6.67

		local var_346_0 = {
			zh = 5.4,
			ja = 6.666
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
				arg_346_0:Play424071084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10155"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10155 == nil then
				arg_346_1.var_.actorSpriteComps10155 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.2

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps10155 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor2.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor2.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor2.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 0.5, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10155 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_349_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps10155 = nil
			end

			local var_349_8 = 0
			local var_349_9 = 0.725

			if var_349_8 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_10 = arg_346_1:FormatText(StoryNameCfg[177].name)

				arg_346_1.leftNameTxt_.text = var_349_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_11 = arg_346_1:GetWordFromCfg(424071083)
				local var_349_12 = arg_346_1:FormatText(var_349_11.content)

				arg_346_1.text_.text = var_349_12

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_13 = 29
				local var_349_14 = utf8.len(var_349_12)
				local var_349_15 = var_349_13 <= 0 and var_349_9 or var_349_9 * (var_349_14 / var_349_13)

				if var_349_15 > 0 and var_349_9 < var_349_15 then
					arg_346_1.talkMaxDuration = var_349_15

					if var_349_15 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_15 + var_349_8
					end
				end

				arg_346_1.text_.text = var_349_12
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071083", "story_v_out_424071.awb") ~= 0 then
					local var_349_16 = manager.audio:GetVoiceLength("story_v_out_424071", "424071083", "story_v_out_424071.awb") / 1000

					if var_349_16 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_16 + var_349_8
					end

					if var_349_11.prefab_name ~= "" and arg_346_1.actors_[var_349_11.prefab_name] ~= nil then
						local var_349_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_11.prefab_name].transform, "story_v_out_424071", "424071083", "story_v_out_424071.awb")

						arg_346_1:RecordAudio("424071083", var_349_17)
						arg_346_1:RecordAudio("424071083", var_349_17)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_424071", "424071083", "story_v_out_424071.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_424071", "424071083", "story_v_out_424071.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_18 = math.max(var_349_9, arg_346_1.talkMaxDuration)

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_18 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_8) / var_349_18

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_8 + var_349_18 and arg_346_1.time_ < var_349_8 + var_349_18 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play424071084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 424071084
		arg_350_1.duration_ = 12.03

		local var_350_0 = {
			zh = 6.133,
			ja = 12.033
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
				arg_350_0:Play424071085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10155"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10155 == nil then
				arg_350_1.var_.actorSpriteComps10155 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps10155 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 1, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10155 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10155 = nil
			end

			local var_353_8 = arg_350_1.actors_["10155"].transform
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.var_.moveOldPos10155 = var_353_8.localPosition
				var_353_8.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10155", 2)

				local var_353_10 = var_353_8.childCount

				for iter_353_4 = 0, var_353_10 - 1 do
					local var_353_11 = var_353_8:GetChild(iter_353_4)

					if var_353_11.name == "split_1" then
						var_353_11:SetAsLastSibling()
						var_353_11.gameObject:SetActive(true)

						arg_350_1.var_.actorSpriteSplit10155 = var_353_11.gameObject:GetComponent(typeof(Image))

						arg_350_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_353_12 = 0.5

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_12 then
				local var_353_13 = (arg_350_1.time_ - var_353_9) / var_353_12
				local var_353_14 = Vector3.New(-410, -390, -250)

				var_353_8.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10155, var_353_14, var_353_13)

				if arg_350_1.var_.actorSpriteSplit10155 ~= nil then
					arg_350_1.var_.actorSpriteSplit10155:SetAlpha(var_353_13)
				end
			end

			if arg_350_1.time_ >= var_353_9 + var_353_12 and arg_350_1.time_ < var_353_9 + var_353_12 + arg_353_0 then
				var_353_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_350_1.var_.actorSpriteSplit10155 ~= nil then
					arg_350_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_353_15 = 0
			local var_353_16 = 0.675

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[1391].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(424071084)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 27
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071084", "story_v_out_424071.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071084", "story_v_out_424071.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_out_424071", "424071084", "story_v_out_424071.awb")

						arg_350_1:RecordAudio("424071084", var_353_24)
						arg_350_1:RecordAudio("424071084", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_424071", "424071084", "story_v_out_424071.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_424071", "424071084", "story_v_out_424071.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_25 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_25 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_25

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_25 and arg_350_1.time_ < var_353_15 + var_353_25 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play424071085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 424071085
		arg_354_1.duration_ = 6.73

		local var_354_0 = {
			zh = 2.966,
			ja = 6.733
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play424071086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10155"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos10155 = var_357_0.localPosition
				var_357_0.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10155", 2)

				local var_357_2 = var_357_0.childCount

				for iter_357_0 = 0, var_357_2 - 1 do
					local var_357_3 = var_357_0:GetChild(iter_357_0)

					if var_357_3.name == "" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_4 then
				local var_357_5 = (arg_354_1.time_ - var_357_1) / var_357_4
				local var_357_6 = Vector3.New(-410, -390, -250)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10155, var_357_6, var_357_5)
			end

			if arg_354_1.time_ >= var_357_1 + var_357_4 and arg_354_1.time_ < var_357_1 + var_357_4 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_357_7 = 0
			local var_357_8 = 0.475

			if var_357_7 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_9 = arg_354_1:FormatText(StoryNameCfg[1391].name)

				arg_354_1.leftNameTxt_.text = var_357_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:GetWordFromCfg(424071085)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_12 = 19
				local var_357_13 = utf8.len(var_357_11)
				local var_357_14 = var_357_12 <= 0 and var_357_8 or var_357_8 * (var_357_13 / var_357_12)

				if var_357_14 > 0 and var_357_8 < var_357_14 then
					arg_354_1.talkMaxDuration = var_357_14

					if var_357_14 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_7
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071085", "story_v_out_424071.awb") ~= 0 then
					local var_357_15 = manager.audio:GetVoiceLength("story_v_out_424071", "424071085", "story_v_out_424071.awb") / 1000

					if var_357_15 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_15 + var_357_7
					end

					if var_357_10.prefab_name ~= "" and arg_354_1.actors_[var_357_10.prefab_name] ~= nil then
						local var_357_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_10.prefab_name].transform, "story_v_out_424071", "424071085", "story_v_out_424071.awb")

						arg_354_1:RecordAudio("424071085", var_357_16)
						arg_354_1:RecordAudio("424071085", var_357_16)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_424071", "424071085", "story_v_out_424071.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_424071", "424071085", "story_v_out_424071.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_17 = math.max(var_357_8, arg_354_1.talkMaxDuration)

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_17 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_7) / var_357_17

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_7 + var_357_17 and arg_354_1.time_ < var_357_7 + var_357_17 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424071086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 424071086
		arg_358_1.duration_ = 1

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play424071087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1094"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1094 == nil then
				arg_358_1.var_.actorSpriteComps1094 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps1094 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 1, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps1094 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps1094 = nil
			end

			local var_361_8 = arg_358_1.actors_["10155"]
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps10155 == nil then
				arg_358_1.var_.actorSpriteComps10155 = var_361_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_10 = 0.2

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_10 and not isNil(var_361_8) then
				local var_361_11 = (arg_358_1.time_ - var_361_9) / var_361_10

				if arg_358_1.var_.actorSpriteComps10155 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								local var_361_12 = Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, var_361_11)
								local var_361_13 = Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, var_361_11)
								local var_361_14 = Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, var_361_11)

								iter_361_5.color = Color.New(var_361_12, var_361_13, var_361_14)
							else
								local var_361_15 = Mathf.Lerp(iter_361_5.color.r, 0.5, var_361_11)

								iter_361_5.color = Color.New(var_361_15, var_361_15, var_361_15)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_9 + var_361_10 and arg_358_1.time_ < var_361_9 + var_361_10 + arg_361_0 and not isNil(var_361_8) and arg_358_1.var_.actorSpriteComps10155 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_361_7 then
						if arg_358_1.isInRecall_ then
							iter_361_7.color = arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_361_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps10155 = nil
			end

			local var_361_16 = arg_358_1.actors_["1094"].transform
			local var_361_17 = 0

			if var_361_17 < arg_358_1.time_ and arg_358_1.time_ <= var_361_17 + arg_361_0 then
				arg_358_1.var_.moveOldPos1094 = var_361_16.localPosition
				var_361_16.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1094", 4)

				local var_361_18 = var_361_16.childCount

				for iter_361_8 = 0, var_361_18 - 1 do
					local var_361_19 = var_361_16:GetChild(iter_361_8)

					if var_361_19.name == "" or not string.find(var_361_19.name, "split") then
						var_361_19.gameObject:SetActive(true)
					else
						var_361_19.gameObject:SetActive(false)
					end
				end
			end

			local var_361_20 = 0.001

			if var_361_17 <= arg_358_1.time_ and arg_358_1.time_ < var_361_17 + var_361_20 then
				local var_361_21 = (arg_358_1.time_ - var_361_17) / var_361_20
				local var_361_22 = Vector3.New(470, -335, -230)

				var_361_16.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1094, var_361_22, var_361_21)
			end

			if arg_358_1.time_ >= var_361_17 + var_361_20 and arg_358_1.time_ < var_361_17 + var_361_20 + arg_361_0 then
				var_361_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_361_23 = 0
			local var_361_24 = 0.05

			if var_361_23 < arg_358_1.time_ and arg_358_1.time_ <= var_361_23 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_25 = arg_358_1:FormatText(StoryNameCfg[181].name)

				arg_358_1.leftNameTxt_.text = var_361_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_26 = arg_358_1:GetWordFromCfg(424071086)
				local var_361_27 = arg_358_1:FormatText(var_361_26.content)

				arg_358_1.text_.text = var_361_27

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_28 = 2
				local var_361_29 = utf8.len(var_361_27)
				local var_361_30 = var_361_28 <= 0 and var_361_24 or var_361_24 * (var_361_29 / var_361_28)

				if var_361_30 > 0 and var_361_24 < var_361_30 then
					arg_358_1.talkMaxDuration = var_361_30

					if var_361_30 + var_361_23 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_30 + var_361_23
					end
				end

				arg_358_1.text_.text = var_361_27
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071086", "story_v_out_424071.awb") ~= 0 then
					local var_361_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071086", "story_v_out_424071.awb") / 1000

					if var_361_31 + var_361_23 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_31 + var_361_23
					end

					if var_361_26.prefab_name ~= "" and arg_358_1.actors_[var_361_26.prefab_name] ~= nil then
						local var_361_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_26.prefab_name].transform, "story_v_out_424071", "424071086", "story_v_out_424071.awb")

						arg_358_1:RecordAudio("424071086", var_361_32)
						arg_358_1:RecordAudio("424071086", var_361_32)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_424071", "424071086", "story_v_out_424071.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_424071", "424071086", "story_v_out_424071.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_33 = math.max(var_361_24, arg_358_1.talkMaxDuration)

			if var_361_23 <= arg_358_1.time_ and arg_358_1.time_ < var_361_23 + var_361_33 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_23) / var_361_33

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_23 + var_361_33 and arg_358_1.time_ < var_361_23 + var_361_33 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play424071087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 424071087
		arg_362_1.duration_ = 24.77

		local var_362_0 = {
			zh = 11.133,
			ja = 24.766
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play424071088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10155"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10155 == nil then
				arg_362_1.var_.actorSpriteComps10155 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.2

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps10155 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								local var_365_4 = Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, var_365_3)
								local var_365_5 = Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, var_365_3)
								local var_365_6 = Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, var_365_3)

								iter_365_1.color = Color.New(var_365_4, var_365_5, var_365_6)
							else
								local var_365_7 = Mathf.Lerp(iter_365_1.color.r, 1, var_365_3)

								iter_365_1.color = Color.New(var_365_7, var_365_7, var_365_7)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10155 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps10155 = nil
			end

			local var_365_8 = arg_362_1.actors_["1094"]
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1094 == nil then
				arg_362_1.var_.actorSpriteComps1094 = var_365_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_10 = 0.2

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_10 and not isNil(var_365_8) then
				local var_365_11 = (arg_362_1.time_ - var_365_9) / var_365_10

				if arg_362_1.var_.actorSpriteComps1094 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								local var_365_12 = Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, var_365_11)
								local var_365_13 = Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, var_365_11)
								local var_365_14 = Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, var_365_11)

								iter_365_5.color = Color.New(var_365_12, var_365_13, var_365_14)
							else
								local var_365_15 = Mathf.Lerp(iter_365_5.color.r, 0.5, var_365_11)

								iter_365_5.color = Color.New(var_365_15, var_365_15, var_365_15)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_9 + var_365_10 and arg_362_1.time_ < var_365_9 + var_365_10 + arg_365_0 and not isNil(var_365_8) and arg_362_1.var_.actorSpriteComps1094 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_365_7 then
						if arg_362_1.isInRecall_ then
							iter_365_7.color = arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_365_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1094 = nil
			end

			local var_365_16 = arg_362_1.actors_["10155"].transform
			local var_365_17 = 0

			if var_365_17 < arg_362_1.time_ and arg_362_1.time_ <= var_365_17 + arg_365_0 then
				arg_362_1.var_.moveOldPos10155 = var_365_16.localPosition
				var_365_16.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10155", 2)

				local var_365_18 = var_365_16.childCount

				for iter_365_8 = 0, var_365_18 - 1 do
					local var_365_19 = var_365_16:GetChild(iter_365_8)

					if var_365_19.name == "" or not string.find(var_365_19.name, "split") then
						var_365_19.gameObject:SetActive(true)
					else
						var_365_19.gameObject:SetActive(false)
					end
				end
			end

			local var_365_20 = 0.001

			if var_365_17 <= arg_362_1.time_ and arg_362_1.time_ < var_365_17 + var_365_20 then
				local var_365_21 = (arg_362_1.time_ - var_365_17) / var_365_20
				local var_365_22 = Vector3.New(-410, -390, -250)

				var_365_16.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10155, var_365_22, var_365_21)
			end

			if arg_362_1.time_ >= var_365_17 + var_365_20 and arg_362_1.time_ < var_365_17 + var_365_20 + arg_365_0 then
				var_365_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_365_23 = 0
			local var_365_24 = 1.275

			if var_365_23 < arg_362_1.time_ and arg_362_1.time_ <= var_365_23 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_25 = arg_362_1:FormatText(StoryNameCfg[1391].name)

				arg_362_1.leftNameTxt_.text = var_365_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_26 = arg_362_1:GetWordFromCfg(424071087)
				local var_365_27 = arg_362_1:FormatText(var_365_26.content)

				arg_362_1.text_.text = var_365_27

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_28 = 51
				local var_365_29 = utf8.len(var_365_27)
				local var_365_30 = var_365_28 <= 0 and var_365_24 or var_365_24 * (var_365_29 / var_365_28)

				if var_365_30 > 0 and var_365_24 < var_365_30 then
					arg_362_1.talkMaxDuration = var_365_30

					if var_365_30 + var_365_23 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_30 + var_365_23
					end
				end

				arg_362_1.text_.text = var_365_27
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071087", "story_v_out_424071.awb") ~= 0 then
					local var_365_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071087", "story_v_out_424071.awb") / 1000

					if var_365_31 + var_365_23 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_31 + var_365_23
					end

					if var_365_26.prefab_name ~= "" and arg_362_1.actors_[var_365_26.prefab_name] ~= nil then
						local var_365_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_26.prefab_name].transform, "story_v_out_424071", "424071087", "story_v_out_424071.awb")

						arg_362_1:RecordAudio("424071087", var_365_32)
						arg_362_1:RecordAudio("424071087", var_365_32)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_424071", "424071087", "story_v_out_424071.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_424071", "424071087", "story_v_out_424071.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_33 = math.max(var_365_24, arg_362_1.talkMaxDuration)

			if var_365_23 <= arg_362_1.time_ and arg_362_1.time_ < var_365_23 + var_365_33 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_23) / var_365_33

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_23 + var_365_33 and arg_362_1.time_ < var_365_23 + var_365_33 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424071088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 424071088
		arg_366_1.duration_ = 1.17

		local var_366_0 = {
			zh = 1.166,
			ja = 0.999999999999
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
				arg_366_0:Play424071089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1094"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1094 == nil then
				arg_366_1.var_.actorSpriteComps1094 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.2

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps1094 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps1094 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_369_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps1094 = nil
			end

			local var_369_8 = arg_366_1.actors_["10155"]
			local var_369_9 = 0

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps10155 == nil then
				arg_366_1.var_.actorSpriteComps10155 = var_369_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_10 = 0.2

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_10 and not isNil(var_369_8) then
				local var_369_11 = (arg_366_1.time_ - var_369_9) / var_369_10

				if arg_366_1.var_.actorSpriteComps10155 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_366_1.time_ >= var_369_9 + var_369_10 and arg_366_1.time_ < var_369_9 + var_369_10 + arg_369_0 and not isNil(var_369_8) and arg_366_1.var_.actorSpriteComps10155 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_369_7 then
						if arg_366_1.isInRecall_ then
							iter_369_7.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps10155 = nil
			end

			local var_369_16 = arg_366_1.actors_["1094"].transform
			local var_369_17 = 0

			if var_369_17 < arg_366_1.time_ and arg_366_1.time_ <= var_369_17 + arg_369_0 then
				arg_366_1.var_.moveOldPos1094 = var_369_16.localPosition
				var_369_16.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1094", 4)

				local var_369_18 = var_369_16.childCount

				for iter_369_8 = 0, var_369_18 - 1 do
					local var_369_19 = var_369_16:GetChild(iter_369_8)

					if var_369_19.name == "split_2" or not string.find(var_369_19.name, "split") then
						var_369_19.gameObject:SetActive(true)
					else
						var_369_19.gameObject:SetActive(false)
					end
				end
			end

			local var_369_20 = 0.001

			if var_369_17 <= arg_366_1.time_ and arg_366_1.time_ < var_369_17 + var_369_20 then
				local var_369_21 = (arg_366_1.time_ - var_369_17) / var_369_20
				local var_369_22 = Vector3.New(470, -335, -230)

				var_369_16.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1094, var_369_22, var_369_21)
			end

			if arg_366_1.time_ >= var_369_17 + var_369_20 and arg_366_1.time_ < var_369_17 + var_369_20 + arg_369_0 then
				var_369_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_369_23 = 0
			local var_369_24 = 0.1

			if var_369_23 < arg_366_1.time_ and arg_366_1.time_ <= var_369_23 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_25 = arg_366_1:FormatText(StoryNameCfg[181].name)

				arg_366_1.leftNameTxt_.text = var_369_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_26 = arg_366_1:GetWordFromCfg(424071088)
				local var_369_27 = arg_366_1:FormatText(var_369_26.content)

				arg_366_1.text_.text = var_369_27

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_28 = 4
				local var_369_29 = utf8.len(var_369_27)
				local var_369_30 = var_369_28 <= 0 and var_369_24 or var_369_24 * (var_369_29 / var_369_28)

				if var_369_30 > 0 and var_369_24 < var_369_30 then
					arg_366_1.talkMaxDuration = var_369_30

					if var_369_30 + var_369_23 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_30 + var_369_23
					end
				end

				arg_366_1.text_.text = var_369_27
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071088", "story_v_out_424071.awb") ~= 0 then
					local var_369_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071088", "story_v_out_424071.awb") / 1000

					if var_369_31 + var_369_23 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_31 + var_369_23
					end

					if var_369_26.prefab_name ~= "" and arg_366_1.actors_[var_369_26.prefab_name] ~= nil then
						local var_369_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_26.prefab_name].transform, "story_v_out_424071", "424071088", "story_v_out_424071.awb")

						arg_366_1:RecordAudio("424071088", var_369_32)
						arg_366_1:RecordAudio("424071088", var_369_32)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_424071", "424071088", "story_v_out_424071.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_424071", "424071088", "story_v_out_424071.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_33 = math.max(var_369_24, arg_366_1.talkMaxDuration)

			if var_369_23 <= arg_366_1.time_ and arg_366_1.time_ < var_369_23 + var_369_33 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_23) / var_369_33

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_23 + var_369_33 and arg_366_1.time_ < var_369_23 + var_369_33 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
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

		arg_366_1:InitPlayNodeList()
	end,
	Play424071089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 424071089
		arg_370_1.duration_ = 4.27

		local var_370_0 = {
			zh = 1.5,
			ja = 4.266
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
				arg_370_0:Play424071090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10155"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10155 == nil then
				arg_370_1.var_.actorSpriteComps10155 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps10155 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10155 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10155 = nil
			end

			local var_373_8 = arg_370_1.actors_["1094"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1094 == nil then
				arg_370_1.var_.actorSpriteComps1094 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps1094 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps1094 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps1094 = nil
			end

			local var_373_16 = arg_370_1.actors_["10155"].transform
			local var_373_17 = 0

			if var_373_17 < arg_370_1.time_ and arg_370_1.time_ <= var_373_17 + arg_373_0 then
				arg_370_1.var_.moveOldPos10155 = var_373_16.localPosition
				var_373_16.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10155", 2)

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
				local var_373_22 = Vector3.New(-410, -390, -250)

				var_373_16.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10155, var_373_22, var_373_21)
			end

			if arg_370_1.time_ >= var_373_17 + var_373_20 and arg_370_1.time_ < var_373_17 + var_373_20 + arg_373_0 then
				var_373_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_373_23 = 0
			local var_373_24 = 0.2

			if var_373_23 < arg_370_1.time_ and arg_370_1.time_ <= var_373_23 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_25 = arg_370_1:FormatText(StoryNameCfg[1391].name)

				arg_370_1.leftNameTxt_.text = var_373_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_26 = arg_370_1:GetWordFromCfg(424071089)
				local var_373_27 = arg_370_1:FormatText(var_373_26.content)

				arg_370_1.text_.text = var_373_27

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_28 = 8
				local var_373_29 = utf8.len(var_373_27)
				local var_373_30 = var_373_28 <= 0 and var_373_24 or var_373_24 * (var_373_29 / var_373_28)

				if var_373_30 > 0 and var_373_24 < var_373_30 then
					arg_370_1.talkMaxDuration = var_373_30

					if var_373_30 + var_373_23 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_30 + var_373_23
					end
				end

				arg_370_1.text_.text = var_373_27
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071089", "story_v_out_424071.awb") ~= 0 then
					local var_373_31 = manager.audio:GetVoiceLength("story_v_out_424071", "424071089", "story_v_out_424071.awb") / 1000

					if var_373_31 + var_373_23 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_31 + var_373_23
					end

					if var_373_26.prefab_name ~= "" and arg_370_1.actors_[var_373_26.prefab_name] ~= nil then
						local var_373_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_26.prefab_name].transform, "story_v_out_424071", "424071089", "story_v_out_424071.awb")

						arg_370_1:RecordAudio("424071089", var_373_32)
						arg_370_1:RecordAudio("424071089", var_373_32)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_424071", "424071089", "story_v_out_424071.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_424071", "424071089", "story_v_out_424071.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_33 = math.max(var_373_24, arg_370_1.talkMaxDuration)

			if var_373_23 <= arg_370_1.time_ and arg_370_1.time_ < var_373_23 + var_373_33 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_23) / var_373_33

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_23 + var_373_33 and arg_370_1.time_ < var_373_23 + var_373_33 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424071090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 424071090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play424071091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["10155"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10155 == nil then
				arg_374_1.var_.actorSpriteComps10155 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps10155 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								local var_377_4 = Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, var_377_3)
								local var_377_5 = Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, var_377_3)
								local var_377_6 = Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, var_377_3)

								iter_377_1.color = Color.New(var_377_4, var_377_5, var_377_6)
							else
								local var_377_7 = Mathf.Lerp(iter_377_1.color.r, 0.5, var_377_3)

								iter_377_1.color = Color.New(var_377_7, var_377_7, var_377_7)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10155 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps10155 = nil
			end

			local var_377_8 = arg_374_1.actors_["10155"].transform
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.var_.moveOldPos10155 = var_377_8.localPosition
				var_377_8.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10155", 7)

				local var_377_10 = var_377_8.childCount

				for iter_377_4 = 0, var_377_10 - 1 do
					local var_377_11 = var_377_8:GetChild(iter_377_4)

					if var_377_11.name == "" or not string.find(var_377_11.name, "split") then
						var_377_11.gameObject:SetActive(true)
					else
						var_377_11.gameObject:SetActive(false)
					end
				end
			end

			local var_377_12 = 0.001

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_12 then
				local var_377_13 = (arg_374_1.time_ - var_377_9) / var_377_12
				local var_377_14 = Vector3.New(0, -2000, 0)

				var_377_8.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10155, var_377_14, var_377_13)
			end

			if arg_374_1.time_ >= var_377_9 + var_377_12 and arg_374_1.time_ < var_377_9 + var_377_12 + arg_377_0 then
				var_377_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_15 = arg_374_1.actors_["1094"].transform
			local var_377_16 = 0

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.var_.moveOldPos1094 = var_377_15.localPosition
				var_377_15.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1094", 7)

				local var_377_17 = var_377_15.childCount

				for iter_377_5 = 0, var_377_17 - 1 do
					local var_377_18 = var_377_15:GetChild(iter_377_5)

					if var_377_18.name == "" or not string.find(var_377_18.name, "split") then
						var_377_18.gameObject:SetActive(true)
					else
						var_377_18.gameObject:SetActive(false)
					end
				end
			end

			local var_377_19 = 0.001

			if var_377_16 <= arg_374_1.time_ and arg_374_1.time_ < var_377_16 + var_377_19 then
				local var_377_20 = (arg_374_1.time_ - var_377_16) / var_377_19
				local var_377_21 = Vector3.New(0, -2000, 0)

				var_377_15.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1094, var_377_21, var_377_20)
			end

			if arg_374_1.time_ >= var_377_16 + var_377_19 and arg_374_1.time_ < var_377_16 + var_377_19 + arg_377_0 then
				var_377_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_22 = 0.034
			local var_377_23 = 1

			if var_377_22 < arg_374_1.time_ and arg_374_1.time_ <= var_377_22 + arg_377_0 then
				local var_377_24 = "play"
				local var_377_25 = "effect"

				arg_374_1:AudioAction(var_377_24, var_377_25, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_377_26 = 0
			local var_377_27 = 0.825

			if var_377_26 < arg_374_1.time_ and arg_374_1.time_ <= var_377_26 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_28 = arg_374_1:GetWordFromCfg(424071090)
				local var_377_29 = arg_374_1:FormatText(var_377_28.content)

				arg_374_1.text_.text = var_377_29

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_30 = 33
				local var_377_31 = utf8.len(var_377_29)
				local var_377_32 = var_377_30 <= 0 and var_377_27 or var_377_27 * (var_377_31 / var_377_30)

				if var_377_32 > 0 and var_377_27 < var_377_32 then
					arg_374_1.talkMaxDuration = var_377_32

					if var_377_32 + var_377_26 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_32 + var_377_26
					end
				end

				arg_374_1.text_.text = var_377_29
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_33 = math.max(var_377_27, arg_374_1.talkMaxDuration)

			if var_377_26 <= arg_374_1.time_ and arg_374_1.time_ < var_377_26 + var_377_33 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_26) / var_377_33

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_26 + var_377_33 and arg_374_1.time_ < var_377_26 + var_377_33 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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

		arg_374_1:InitPlayNodeList()
	end,
	Play424071091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 424071091
		arg_378_1.duration_ = 10.3

		local var_378_0 = {
			zh = 7.766,
			ja = 10.3
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
				arg_378_0:Play424071092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 2

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				local var_381_1 = manager.ui.mainCamera.transform.localPosition
				local var_381_2 = Vector3.New(0, 0, 10) + Vector3.New(var_381_1.x, var_381_1.y, 0)
				local var_381_3 = arg_378_1.bgs_.I11r

				var_381_3.transform.localPosition = var_381_2
				var_381_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_381_4 = var_381_3:GetComponent("SpriteRenderer")

				if var_381_4 and var_381_4.sprite then
					local var_381_5 = (var_381_3.transform.localPosition - var_381_1).z
					local var_381_6 = manager.ui.mainCameraCom_
					local var_381_7 = 2 * var_381_5 * Mathf.Tan(var_381_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_381_8 = var_381_7 * var_381_6.aspect
					local var_381_9 = var_381_4.sprite.bounds.size.x
					local var_381_10 = var_381_4.sprite.bounds.size.y
					local var_381_11 = var_381_8 / var_381_9
					local var_381_12 = var_381_7 / var_381_10
					local var_381_13 = var_381_12 < var_381_11 and var_381_11 or var_381_12

					var_381_3.transform.localScale = Vector3.New(var_381_13, var_381_13, 0)
				end

				for iter_381_0, iter_381_1 in pairs(arg_378_1.bgs_) do
					if iter_381_0 ~= "I11r" then
						iter_381_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_381_14 = 4

			if var_381_14 < arg_378_1.time_ and arg_378_1.time_ <= var_381_14 + arg_381_0 then
				arg_378_1.allBtn_.enabled = false
			end

			local var_381_15 = 0.3

			if arg_378_1.time_ >= var_381_14 + var_381_15 and arg_378_1.time_ < var_381_14 + var_381_15 + arg_381_0 then
				arg_378_1.allBtn_.enabled = true
			end

			local var_381_16 = 0

			if var_381_16 < arg_378_1.time_ and arg_378_1.time_ <= var_381_16 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_17 = 2

			if var_381_16 <= arg_378_1.time_ and arg_378_1.time_ < var_381_16 + var_381_17 then
				local var_381_18 = (arg_378_1.time_ - var_381_16) / var_381_17
				local var_381_19 = Color.New(0, 0, 0)

				var_381_19.a = Mathf.Lerp(0, 1, var_381_18)
				arg_378_1.mask_.color = var_381_19
			end

			if arg_378_1.time_ >= var_381_16 + var_381_17 and arg_378_1.time_ < var_381_16 + var_381_17 + arg_381_0 then
				local var_381_20 = Color.New(0, 0, 0)

				var_381_20.a = 1
				arg_378_1.mask_.color = var_381_20
			end

			local var_381_21 = 2

			if var_381_21 < arg_378_1.time_ and arg_378_1.time_ <= var_381_21 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_22 = 2

			if var_381_21 <= arg_378_1.time_ and arg_378_1.time_ < var_381_21 + var_381_22 then
				local var_381_23 = (arg_378_1.time_ - var_381_21) / var_381_22
				local var_381_24 = Color.New(0, 0, 0)

				var_381_24.a = Mathf.Lerp(1, 0, var_381_23)
				arg_378_1.mask_.color = var_381_24
			end

			if arg_378_1.time_ >= var_381_21 + var_381_22 and arg_378_1.time_ < var_381_21 + var_381_22 + arg_381_0 then
				local var_381_25 = Color.New(0, 0, 0)
				local var_381_26 = 0

				arg_378_1.mask_.enabled = false
				var_381_25.a = var_381_26
				arg_378_1.mask_.color = var_381_25
			end

			local var_381_27 = 0.133333333333333
			local var_381_28 = 1

			if var_381_27 < arg_378_1.time_ and arg_378_1.time_ <= var_381_27 + arg_381_0 then
				local var_381_29 = "stop"
				local var_381_30 = "effect"

				arg_378_1:AudioAction(var_381_29, var_381_30, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_381_31 = 1.76666666666667
			local var_381_32 = 1

			if var_381_31 < arg_378_1.time_ and arg_378_1.time_ <= var_381_31 + arg_381_0 then
				local var_381_33 = "play"
				local var_381_34 = "effect"

				arg_378_1:AudioAction(var_381_33, var_381_34, "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_378_1.frameCnt_ <= 1 then
				arg_378_1.dialog_:SetActive(false)
			end

			local var_381_35 = 4
			local var_381_36 = 0.45

			if var_381_35 < arg_378_1.time_ and arg_378_1.time_ <= var_381_35 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0

				arg_378_1.dialog_:SetActive(true)

				arg_378_1.dialogCg_.alpha = 0

				local var_381_37 = LeanTween.value(arg_378_1.dialog_, 0, 1, 0.3)

				var_381_37:setOnUpdate(LuaHelper.FloatAction(function(arg_382_0)
					arg_378_1.dialogCg_.alpha = arg_382_0
				end))
				var_381_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_378_1.dialog_)
					var_381_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_378_1.duration_ = arg_378_1.duration_ + 0.3

				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_38 = arg_378_1:FormatText(StoryNameCfg[177].name)

				arg_378_1.leftNameTxt_.text = var_381_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_39 = arg_378_1:GetWordFromCfg(424071091)
				local var_381_40 = arg_378_1:FormatText(var_381_39.content)

				arg_378_1.text_.text = var_381_40

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_41 = 18
				local var_381_42 = utf8.len(var_381_40)
				local var_381_43 = var_381_41 <= 0 and var_381_36 or var_381_36 * (var_381_42 / var_381_41)

				if var_381_43 > 0 and var_381_36 < var_381_43 then
					arg_378_1.talkMaxDuration = var_381_43
					var_381_35 = var_381_35 + 0.3

					if var_381_43 + var_381_35 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_43 + var_381_35
					end
				end

				arg_378_1.text_.text = var_381_40
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071091", "story_v_out_424071.awb") ~= 0 then
					local var_381_44 = manager.audio:GetVoiceLength("story_v_out_424071", "424071091", "story_v_out_424071.awb") / 1000

					if var_381_44 + var_381_35 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_44 + var_381_35
					end

					if var_381_39.prefab_name ~= "" and arg_378_1.actors_[var_381_39.prefab_name] ~= nil then
						local var_381_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_39.prefab_name].transform, "story_v_out_424071", "424071091", "story_v_out_424071.awb")

						arg_378_1:RecordAudio("424071091", var_381_45)
						arg_378_1:RecordAudio("424071091", var_381_45)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_424071", "424071091", "story_v_out_424071.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_424071", "424071091", "story_v_out_424071.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_46 = var_381_35 + 0.3
			local var_381_47 = math.max(var_381_36, arg_378_1.talkMaxDuration)

			if var_381_46 <= arg_378_1.time_ and arg_378_1.time_ < var_381_46 + var_381_47 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_46) / var_381_47

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_46 + var_381_47 and arg_378_1.time_ < var_381_46 + var_381_47 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play424071092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 424071092
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play424071093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.875

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

				local var_387_3 = arg_384_1:GetWordFromCfg(424071092)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 35
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
	Play424071093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 424071093
		arg_388_1.duration_ = 3.5

		local var_388_0 = {
			zh = 2.1,
			ja = 3.5
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play424071094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1094"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1094 == nil then
				arg_388_1.var_.actorSpriteComps1094 = var_391_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.actorSpriteComps1094 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								local var_391_4 = Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor1.r, var_391_3)
								local var_391_5 = Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor1.g, var_391_3)
								local var_391_6 = Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor1.b, var_391_3)

								iter_391_1.color = Color.New(var_391_4, var_391_5, var_391_6)
							else
								local var_391_7 = Mathf.Lerp(iter_391_1.color.r, 1, var_391_3)

								iter_391_1.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1094 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_391_3 then
						if arg_388_1.isInRecall_ then
							iter_391_3.color = arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_391_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps1094 = nil
			end

			local var_391_8 = arg_388_1.actors_["1094"].transform
			local var_391_9 = 0

			if var_391_9 < arg_388_1.time_ and arg_388_1.time_ <= var_391_9 + arg_391_0 then
				arg_388_1.var_.moveOldPos1094 = var_391_8.localPosition
				var_391_8.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1094", 3)

				local var_391_10 = var_391_8.childCount

				for iter_391_4 = 0, var_391_10 - 1 do
					local var_391_11 = var_391_8:GetChild(iter_391_4)

					if var_391_11.name == "split_4" then
						var_391_11:SetAsLastSibling()
						var_391_11.gameObject:SetActive(true)

						arg_388_1.var_.actorSpriteSplit1094 = var_391_11.gameObject:GetComponent(typeof(Image))

						arg_388_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_391_12 = 0.001

			if var_391_9 <= arg_388_1.time_ and arg_388_1.time_ < var_391_9 + var_391_12 then
				local var_391_13 = (arg_388_1.time_ - var_391_9) / var_391_12
				local var_391_14 = Vector3.New(0, -335, -230)

				var_391_8.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1094, var_391_14, var_391_13)

				if arg_388_1.var_.actorSpriteSplit1094 ~= nil then
					arg_388_1.var_.actorSpriteSplit1094:SetAlpha(var_391_13)
				end
			end

			if arg_388_1.time_ >= var_391_9 + var_391_12 and arg_388_1.time_ < var_391_9 + var_391_12 + arg_391_0 then
				var_391_8.localPosition = Vector3.New(0, -335, -230)

				if arg_388_1.var_.actorSpriteSplit1094 ~= nil then
					arg_388_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_391_15 = 0
			local var_391_16 = 0.25

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_17 = arg_388_1:FormatText(StoryNameCfg[181].name)

				arg_388_1.leftNameTxt_.text = var_391_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(424071093)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_20 = 10
				local var_391_21 = utf8.len(var_391_19)
				local var_391_22 = var_391_20 <= 0 and var_391_16 or var_391_16 * (var_391_21 / var_391_20)

				if var_391_22 > 0 and var_391_16 < var_391_22 then
					arg_388_1.talkMaxDuration = var_391_22

					if var_391_22 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_15
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071093", "story_v_out_424071.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071093", "story_v_out_424071.awb") / 1000

					if var_391_23 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_15
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_out_424071", "424071093", "story_v_out_424071.awb")

						arg_388_1:RecordAudio("424071093", var_391_24)
						arg_388_1:RecordAudio("424071093", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_424071", "424071093", "story_v_out_424071.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_424071", "424071093", "story_v_out_424071.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_25 = math.max(var_391_16, arg_388_1.talkMaxDuration)

			if var_391_15 <= arg_388_1.time_ and arg_388_1.time_ < var_391_15 + var_391_25 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_15) / var_391_25

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_15 + var_391_25 and arg_388_1.time_ < var_391_15 + var_391_25 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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

		arg_388_1:InitPlayNodeList()
	end,
	Play424071094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 424071094
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play424071095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1094"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps1094 == nil then
				arg_392_1.var_.actorSpriteComps1094 = var_395_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_2 = 0.2

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.actorSpriteComps1094 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								local var_395_4 = Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor2.r, var_395_3)
								local var_395_5 = Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor2.g, var_395_3)
								local var_395_6 = Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor2.b, var_395_3)

								iter_395_1.color = Color.New(var_395_4, var_395_5, var_395_6)
							else
								local var_395_7 = Mathf.Lerp(iter_395_1.color.r, 0.5, var_395_3)

								iter_395_1.color = Color.New(var_395_7, var_395_7, var_395_7)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps1094 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_395_3 then
						if arg_392_1.isInRecall_ then
							iter_395_3.color = arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_395_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps1094 = nil
			end

			local var_395_8 = 0
			local var_395_9 = 0.475

			if var_395_8 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_10 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_10

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

				local var_395_11 = arg_392_1:GetWordFromCfg(424071094)
				local var_395_12 = arg_392_1:FormatText(var_395_11.content)

				arg_392_1.text_.text = var_395_12

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_13 = 19
				local var_395_14 = utf8.len(var_395_12)
				local var_395_15 = var_395_13 <= 0 and var_395_9 or var_395_9 * (var_395_14 / var_395_13)

				if var_395_15 > 0 and var_395_9 < var_395_15 then
					arg_392_1.talkMaxDuration = var_395_15

					if var_395_15 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_15 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_12
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_16 and arg_392_1.time_ < var_395_8 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play424071095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 424071095
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play424071096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1094"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1094 = var_399_0.localPosition
				var_399_0.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("1094", 7)

				local var_399_2 = var_399_0.childCount

				for iter_399_0 = 0, var_399_2 - 1 do
					local var_399_3 = var_399_0:GetChild(iter_399_0)

					if var_399_3.name == "" or not string.find(var_399_3.name, "split") then
						var_399_3.gameObject:SetActive(true)
					else
						var_399_3.gameObject:SetActive(false)
					end
				end
			end

			local var_399_4 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_4 then
				local var_399_5 = (arg_396_1.time_ - var_399_1) / var_399_4
				local var_399_6 = Vector3.New(0, -2000, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1094, var_399_6, var_399_5)
			end

			if arg_396_1.time_ >= var_399_1 + var_399_4 and arg_396_1.time_ < var_399_1 + var_399_4 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_399_7 = 0.034
			local var_399_8 = 1

			if var_399_7 < arg_396_1.time_ and arg_396_1.time_ <= var_399_7 + arg_399_0 then
				local var_399_9 = "play"
				local var_399_10 = "effect"

				arg_396_1:AudioAction(var_399_9, var_399_10, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_399_11 = 0
			local var_399_12 = 1.1

			if var_399_11 < arg_396_1.time_ and arg_396_1.time_ <= var_399_11 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_13 = arg_396_1:GetWordFromCfg(424071095)
				local var_399_14 = arg_396_1:FormatText(var_399_13.content)

				arg_396_1.text_.text = var_399_14

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_15 = 44
				local var_399_16 = utf8.len(var_399_14)
				local var_399_17 = var_399_15 <= 0 and var_399_12 or var_399_12 * (var_399_16 / var_399_15)

				if var_399_17 > 0 and var_399_12 < var_399_17 then
					arg_396_1.talkMaxDuration = var_399_17

					if var_399_17 + var_399_11 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_17 + var_399_11
					end
				end

				arg_396_1.text_.text = var_399_14
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_18 = math.max(var_399_12, arg_396_1.talkMaxDuration)

			if var_399_11 <= arg_396_1.time_ and arg_396_1.time_ < var_399_11 + var_399_18 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_11) / var_399_18

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_11 + var_399_18 and arg_396_1.time_ < var_399_11 + var_399_18 + arg_399_0 then
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
	Play424071096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 424071096
		arg_400_1.duration_ = 5.7

		local var_400_0 = {
			zh = 3.733,
			ja = 5.7
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play424071097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = "1037"

			if arg_400_1.actors_[var_403_0] == nil then
				local var_403_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_403_1) then
					local var_403_2 = Object.Instantiate(var_403_1, arg_400_1.canvasGo_.transform)

					var_403_2.transform:SetSiblingIndex(1)

					var_403_2.name = var_403_0
					var_403_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_400_1.actors_[var_403_0] = var_403_2

					local var_403_3 = var_403_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_400_1.isInRecall_ then
						for iter_403_0, iter_403_1 in ipairs(var_403_3) do
							iter_403_1.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_403_4 = arg_400_1.actors_["1037"]
			local var_403_5 = 0

			if var_403_5 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 and not isNil(var_403_4) and arg_400_1.var_.actorSpriteComps1037 == nil then
				arg_400_1.var_.actorSpriteComps1037 = var_403_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_6 = 0.2

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 and not isNil(var_403_4) then
				local var_403_7 = (arg_400_1.time_ - var_403_5) / var_403_6

				if arg_400_1.var_.actorSpriteComps1037 then
					for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_403_3 then
							if arg_400_1.isInRecall_ then
								local var_403_8 = Mathf.Lerp(iter_403_3.color.r, arg_400_1.hightColor1.r, var_403_7)
								local var_403_9 = Mathf.Lerp(iter_403_3.color.g, arg_400_1.hightColor1.g, var_403_7)
								local var_403_10 = Mathf.Lerp(iter_403_3.color.b, arg_400_1.hightColor1.b, var_403_7)

								iter_403_3.color = Color.New(var_403_8, var_403_9, var_403_10)
							else
								local var_403_11 = Mathf.Lerp(iter_403_3.color.r, 1, var_403_7)

								iter_403_3.color = Color.New(var_403_11, var_403_11, var_403_11)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 and not isNil(var_403_4) and arg_400_1.var_.actorSpriteComps1037 then
				for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_403_5 then
						if arg_400_1.isInRecall_ then
							iter_403_5.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_403_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps1037 = nil
			end

			local var_403_12 = 0
			local var_403_13 = 0.5

			if var_403_12 < arg_400_1.time_ and arg_400_1.time_ <= var_403_12 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_14 = arg_400_1:FormatText(StoryNameCfg[15].name)

				arg_400_1.leftNameTxt_.text = var_403_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_400_1.callingController_:SetSelectedState("calling")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_15 = arg_400_1:GetWordFromCfg(424071096)
				local var_403_16 = arg_400_1:FormatText(var_403_15.content)

				arg_400_1.text_.text = var_403_16

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_17 = 20
				local var_403_18 = utf8.len(var_403_16)
				local var_403_19 = var_403_17 <= 0 and var_403_13 or var_403_13 * (var_403_18 / var_403_17)

				if var_403_19 > 0 and var_403_13 < var_403_19 then
					arg_400_1.talkMaxDuration = var_403_19

					if var_403_19 + var_403_12 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_19 + var_403_12
					end
				end

				arg_400_1.text_.text = var_403_16
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071096", "story_v_out_424071.awb") ~= 0 then
					local var_403_20 = manager.audio:GetVoiceLength("story_v_out_424071", "424071096", "story_v_out_424071.awb") / 1000

					if var_403_20 + var_403_12 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_20 + var_403_12
					end

					if var_403_15.prefab_name ~= "" and arg_400_1.actors_[var_403_15.prefab_name] ~= nil then
						local var_403_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_15.prefab_name].transform, "story_v_out_424071", "424071096", "story_v_out_424071.awb")

						arg_400_1:RecordAudio("424071096", var_403_21)
						arg_400_1:RecordAudio("424071096", var_403_21)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_424071", "424071096", "story_v_out_424071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_424071", "424071096", "story_v_out_424071.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_22 = math.max(var_403_13, arg_400_1.talkMaxDuration)

			if var_403_12 <= arg_400_1.time_ and arg_400_1.time_ < var_403_12 + var_403_22 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_12) / var_403_22

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_12 + var_403_22 and arg_400_1.time_ < var_403_12 + var_403_22 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play424071097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 424071097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play424071098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1037"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1037 == nil then
				arg_404_1.var_.actorSpriteComps1037 = var_407_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_2 = 0.2

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.actorSpriteComps1037 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_407_1 then
							if arg_404_1.isInRecall_ then
								local var_407_4 = Mathf.Lerp(iter_407_1.color.r, arg_404_1.hightColor2.r, var_407_3)
								local var_407_5 = Mathf.Lerp(iter_407_1.color.g, arg_404_1.hightColor2.g, var_407_3)
								local var_407_6 = Mathf.Lerp(iter_407_1.color.b, arg_404_1.hightColor2.b, var_407_3)

								iter_407_1.color = Color.New(var_407_4, var_407_5, var_407_6)
							else
								local var_407_7 = Mathf.Lerp(iter_407_1.color.r, 0.5, var_407_3)

								iter_407_1.color = Color.New(var_407_7, var_407_7, var_407_7)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1037 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_407_3 then
						if arg_404_1.isInRecall_ then
							iter_407_3.color = arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_407_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps1037 = nil
			end

			local var_407_8 = 0
			local var_407_9 = 0.275

			if var_407_8 < arg_404_1.time_ and arg_404_1.time_ <= var_407_8 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_10 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_11 = arg_404_1:GetWordFromCfg(424071097)
				local var_407_12 = arg_404_1:FormatText(var_407_11.content)

				arg_404_1.text_.text = var_407_12

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_13 = 11
				local var_407_14 = utf8.len(var_407_12)
				local var_407_15 = var_407_13 <= 0 and var_407_9 or var_407_9 * (var_407_14 / var_407_13)

				if var_407_15 > 0 and var_407_9 < var_407_15 then
					arg_404_1.talkMaxDuration = var_407_15

					if var_407_15 + var_407_8 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_15 + var_407_8
					end
				end

				arg_404_1.text_.text = var_407_12
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_9, arg_404_1.talkMaxDuration)

			if var_407_8 <= arg_404_1.time_ and arg_404_1.time_ < var_407_8 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_8) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_8 + var_407_16 and arg_404_1.time_ < var_407_8 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play424071098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 424071098
		arg_408_1.duration_ = 7.53

		local var_408_0 = {
			zh = 5.8,
			ja = 7.533
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
				arg_408_0:Play424071099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.7

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[15].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_408_1.callingController_:SetSelectedState("calling")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(424071098)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 28
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071098", "story_v_out_424071.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071098", "story_v_out_424071.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_424071", "424071098", "story_v_out_424071.awb")

						arg_408_1:RecordAudio("424071098", var_411_9)
						arg_408_1:RecordAudio("424071098", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_424071", "424071098", "story_v_out_424071.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_424071", "424071098", "story_v_out_424071.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play424071099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 424071099
		arg_412_1.duration_ = 11.3

		local var_412_0 = {
			zh = 8.833,
			ja = 11.3
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
				arg_412_0:Play424071100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 1.05

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[15].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_412_1.callingController_:SetSelectedState("calling")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(424071099)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 42
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071099", "story_v_out_424071.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071099", "story_v_out_424071.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_424071", "424071099", "story_v_out_424071.awb")

						arg_412_1:RecordAudio("424071099", var_415_9)
						arg_412_1:RecordAudio("424071099", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_424071", "424071099", "story_v_out_424071.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_424071", "424071099", "story_v_out_424071.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play424071100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 424071100
		arg_416_1.duration_ = 12.8

		local var_416_0 = {
			zh = 11.033,
			ja = 12.8
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play424071101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 1.35

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[15].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_416_1.callingController_:SetSelectedState("calling")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(424071100)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 54
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071100", "story_v_out_424071.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071100", "story_v_out_424071.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_424071", "424071100", "story_v_out_424071.awb")

						arg_416_1:RecordAudio("424071100", var_419_9)
						arg_416_1:RecordAudio("424071100", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_424071", "424071100", "story_v_out_424071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_424071", "424071100", "story_v_out_424071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play424071101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 424071101
		arg_420_1.duration_ = 8.5

		local var_420_0 = {
			zh = 8.5,
			ja = 8.033
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
				arg_420_0:Play424071102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.95

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_2 = arg_420_1:FormatText(StoryNameCfg[15].name)

				arg_420_1.leftNameTxt_.text = var_423_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_420_1.callingController_:SetSelectedState("calling")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_3 = arg_420_1:GetWordFromCfg(424071101)
				local var_423_4 = arg_420_1:FormatText(var_423_3.content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071101", "story_v_out_424071.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071101", "story_v_out_424071.awb") / 1000

					if var_423_8 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_0
					end

					if var_423_3.prefab_name ~= "" and arg_420_1.actors_[var_423_3.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_3.prefab_name].transform, "story_v_out_424071", "424071101", "story_v_out_424071.awb")

						arg_420_1:RecordAudio("424071101", var_423_9)
						arg_420_1:RecordAudio("424071101", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_424071", "424071101", "story_v_out_424071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_424071", "424071101", "story_v_out_424071.awb")
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
	Play424071102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 424071102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play424071103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.55

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

				local var_427_3 = arg_424_1:GetWordFromCfg(424071102)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 22
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
	Play424071103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 424071103
		arg_428_1.duration_ = 5.83

		local var_428_0 = {
			zh = 4.6,
			ja = 5.833
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
				arg_428_0:Play424071104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.575

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[15].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_428_1.callingController_:SetSelectedState("calling")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(424071103)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 23
				local var_431_6 = utf8.len(var_431_4)
				local var_431_7 = var_431_5 <= 0 and var_431_1 or var_431_1 * (var_431_6 / var_431_5)

				if var_431_7 > 0 and var_431_1 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071103", "story_v_out_424071.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071103", "story_v_out_424071.awb") / 1000

					if var_431_8 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_0
					end

					if var_431_3.prefab_name ~= "" and arg_428_1.actors_[var_431_3.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_3.prefab_name].transform, "story_v_out_424071", "424071103", "story_v_out_424071.awb")

						arg_428_1:RecordAudio("424071103", var_431_9)
						arg_428_1:RecordAudio("424071103", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_424071", "424071103", "story_v_out_424071.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_424071", "424071103", "story_v_out_424071.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_10 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_10 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_10

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_10 and arg_428_1.time_ < var_431_0 + var_431_10 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play424071104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 424071104
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play424071105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.175

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(424071104)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 7
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_8 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_8 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_8

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_8 and arg_432_1.time_ < var_435_0 + var_435_8 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play424071105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 424071105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play424071106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = "1111"

			if arg_436_1.actors_[var_439_0] == nil then
				local var_439_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1111")

				if not isNil(var_439_1) then
					local var_439_2 = Object.Instantiate(var_439_1, arg_436_1.canvasGo_.transform)

					var_439_2.transform:SetSiblingIndex(1)

					var_439_2.name = var_439_0
					var_439_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_436_1.actors_[var_439_0] = var_439_2

					local var_439_3 = var_439_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_436_1.isInRecall_ then
						for iter_439_0, iter_439_1 in ipairs(var_439_3) do
							iter_439_1.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_439_4 = arg_436_1.actors_["1111"].transform
			local var_439_5 = 0

			if var_439_5 < arg_436_1.time_ and arg_436_1.time_ <= var_439_5 + arg_439_0 then
				arg_436_1.var_.moveOldPos1111 = var_439_4.localPosition
				var_439_4.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("1111", 7)

				local var_439_6 = var_439_4.childCount

				for iter_439_2 = 0, var_439_6 - 1 do
					local var_439_7 = var_439_4:GetChild(iter_439_2)

					if var_439_7.name == "" or not string.find(var_439_7.name, "split") then
						var_439_7.gameObject:SetActive(true)
					else
						var_439_7.gameObject:SetActive(false)
					end
				end
			end

			local var_439_8 = 0.001

			if var_439_5 <= arg_436_1.time_ and arg_436_1.time_ < var_439_5 + var_439_8 then
				local var_439_9 = (arg_436_1.time_ - var_439_5) / var_439_8
				local var_439_10 = Vector3.New(0, -2000, -350)

				var_439_4.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1111, var_439_10, var_439_9)
			end

			if arg_436_1.time_ >= var_439_5 + var_439_8 and arg_436_1.time_ < var_439_5 + var_439_8 + arg_439_0 then
				var_439_4.localPosition = Vector3.New(0, -2000, -350)
			end

			local var_439_11 = 0
			local var_439_12 = 0.575

			if var_439_11 < arg_436_1.time_ and arg_436_1.time_ <= var_439_11 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_13 = arg_436_1:FormatText(StoryNameCfg[7].name)

				arg_436_1.leftNameTxt_.text = var_439_13

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

				local var_439_14 = arg_436_1:GetWordFromCfg(424071105)
				local var_439_15 = arg_436_1:FormatText(var_439_14.content)

				arg_436_1.text_.text = var_439_15

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_16 = 23
				local var_439_17 = utf8.len(var_439_15)
				local var_439_18 = var_439_16 <= 0 and var_439_12 or var_439_12 * (var_439_17 / var_439_16)

				if var_439_18 > 0 and var_439_12 < var_439_18 then
					arg_436_1.talkMaxDuration = var_439_18

					if var_439_18 + var_439_11 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_18 + var_439_11
					end
				end

				arg_436_1.text_.text = var_439_15
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_19 = math.max(var_439_12, arg_436_1.talkMaxDuration)

			if var_439_11 <= arg_436_1.time_ and arg_436_1.time_ < var_439_11 + var_439_19 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_11) / var_439_19

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_11 + var_439_19 and arg_436_1.time_ < var_439_11 + var_439_19 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111",
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
	Play424071106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 424071106
		arg_440_1.duration_ = 5.4

		local var_440_0 = {
			zh = 3.1,
			ja = 5.4
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
				arg_440_0:Play424071107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.4

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[177].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:GetWordFromCfg(424071106)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 16
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071106", "story_v_out_424071.awb") ~= 0 then
					local var_443_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071106", "story_v_out_424071.awb") / 1000

					if var_443_8 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_8 + var_443_0
					end

					if var_443_3.prefab_name ~= "" and arg_440_1.actors_[var_443_3.prefab_name] ~= nil then
						local var_443_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_3.prefab_name].transform, "story_v_out_424071", "424071106", "story_v_out_424071.awb")

						arg_440_1:RecordAudio("424071106", var_443_9)
						arg_440_1:RecordAudio("424071106", var_443_9)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_424071", "424071106", "story_v_out_424071.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_424071", "424071106", "story_v_out_424071.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_10 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_10 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_10

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_10 and arg_440_1.time_ < var_443_0 + var_443_10 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play424071107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 424071107
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play424071108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 1.4

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:GetWordFromCfg(424071107)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 56
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_8 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_8 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_8

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_8 and arg_444_1.time_ < var_447_0 + var_447_8 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play424071108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 424071108
		arg_448_1.duration_ = 2.77

		local var_448_0 = {
			zh = 2.066,
			ja = 2.766
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
				arg_448_0:Play424071109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.3

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[177].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:GetWordFromCfg(424071108)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 12
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071108", "story_v_out_424071.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071108", "story_v_out_424071.awb") / 1000

					if var_451_8 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_0
					end

					if var_451_3.prefab_name ~= "" and arg_448_1.actors_[var_451_3.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_3.prefab_name].transform, "story_v_out_424071", "424071108", "story_v_out_424071.awb")

						arg_448_1:RecordAudio("424071108", var_451_9)
						arg_448_1:RecordAudio("424071108", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_424071", "424071108", "story_v_out_424071.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_424071", "424071108", "story_v_out_424071.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_10 and arg_448_1.time_ < var_451_0 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play424071109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 424071109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play424071110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 1.2

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(424071109)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 48
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_8 and arg_452_1.time_ < var_455_0 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play424071110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 424071110
		arg_456_1.duration_ = 4.13

		local var_456_0 = {
			zh = 3.533,
			ja = 4.133
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
				arg_456_0:Play424071111(arg_456_1)
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
								local var_459_4 = Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, var_459_3)
								local var_459_5 = Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, var_459_3)
								local var_459_6 = Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, var_459_3)

								iter_459_1.color = Color.New(var_459_4, var_459_5, var_459_6)
							else
								local var_459_7 = Mathf.Lerp(iter_459_1.color.r, 1, var_459_3)

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
							iter_459_3.color = arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_459_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps1094 = nil
			end

			local var_459_8 = arg_456_1.actors_["1094"].transform
			local var_459_9 = 0

			if var_459_9 < arg_456_1.time_ and arg_456_1.time_ <= var_459_9 + arg_459_0 then
				arg_456_1.var_.moveOldPos1094 = var_459_8.localPosition
				var_459_8.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("1094", 3)

				local var_459_10 = var_459_8.childCount

				for iter_459_4 = 0, var_459_10 - 1 do
					local var_459_11 = var_459_8:GetChild(iter_459_4)

					if var_459_11.name == "" or not string.find(var_459_11.name, "split") then
						var_459_11.gameObject:SetActive(true)
					else
						var_459_11.gameObject:SetActive(false)
					end
				end
			end

			local var_459_12 = 0.001

			if var_459_9 <= arg_456_1.time_ and arg_456_1.time_ < var_459_9 + var_459_12 then
				local var_459_13 = (arg_456_1.time_ - var_459_9) / var_459_12
				local var_459_14 = Vector3.New(0, -335, -230)

				var_459_8.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1094, var_459_14, var_459_13)
			end

			if arg_456_1.time_ >= var_459_9 + var_459_12 and arg_456_1.time_ < var_459_9 + var_459_12 + arg_459_0 then
				var_459_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_459_15 = 0
			local var_459_16 = 0.3

			if var_459_15 < arg_456_1.time_ and arg_456_1.time_ <= var_459_15 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_17 = arg_456_1:FormatText(StoryNameCfg[181].name)

				arg_456_1.leftNameTxt_.text = var_459_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_18 = arg_456_1:GetWordFromCfg(424071110)
				local var_459_19 = arg_456_1:FormatText(var_459_18.content)

				arg_456_1.text_.text = var_459_19

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_20 = 12
				local var_459_21 = utf8.len(var_459_19)
				local var_459_22 = var_459_20 <= 0 and var_459_16 or var_459_16 * (var_459_21 / var_459_20)

				if var_459_22 > 0 and var_459_16 < var_459_22 then
					arg_456_1.talkMaxDuration = var_459_22

					if var_459_22 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_22 + var_459_15
					end
				end

				arg_456_1.text_.text = var_459_19
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071110", "story_v_out_424071.awb") ~= 0 then
					local var_459_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071110", "story_v_out_424071.awb") / 1000

					if var_459_23 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_23 + var_459_15
					end

					if var_459_18.prefab_name ~= "" and arg_456_1.actors_[var_459_18.prefab_name] ~= nil then
						local var_459_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_18.prefab_name].transform, "story_v_out_424071", "424071110", "story_v_out_424071.awb")

						arg_456_1:RecordAudio("424071110", var_459_24)
						arg_456_1:RecordAudio("424071110", var_459_24)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_424071", "424071110", "story_v_out_424071.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_424071", "424071110", "story_v_out_424071.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_25 = math.max(var_459_16, arg_456_1.talkMaxDuration)

			if var_459_15 <= arg_456_1.time_ and arg_456_1.time_ < var_459_15 + var_459_25 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_15) / var_459_25

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_15 + var_459_25 and arg_456_1.time_ < var_459_15 + var_459_25 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
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

		arg_456_1:InitPlayNodeList()
	end,
	Play424071111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 424071111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play424071112(arg_460_1)
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
								local var_463_4 = Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor2.r, var_463_3)
								local var_463_5 = Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor2.g, var_463_3)
								local var_463_6 = Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor2.b, var_463_3)

								iter_463_1.color = Color.New(var_463_4, var_463_5, var_463_6)
							else
								local var_463_7 = Mathf.Lerp(iter_463_1.color.r, 0.5, var_463_3)

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
							iter_463_3.color = arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_463_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps1094 = nil
			end

			local var_463_8 = 0
			local var_463_9 = 0.55

			if var_463_8 < arg_460_1.time_ and arg_460_1.time_ <= var_463_8 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_10 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_11 = arg_460_1:GetWordFromCfg(424071111)
				local var_463_12 = arg_460_1:FormatText(var_463_11.content)

				arg_460_1.text_.text = var_463_12

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_13 = 22
				local var_463_14 = utf8.len(var_463_12)
				local var_463_15 = var_463_13 <= 0 and var_463_9 or var_463_9 * (var_463_14 / var_463_13)

				if var_463_15 > 0 and var_463_9 < var_463_15 then
					arg_460_1.talkMaxDuration = var_463_15

					if var_463_15 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_15 + var_463_8
					end
				end

				arg_460_1.text_.text = var_463_12
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_16 = math.max(var_463_9, arg_460_1.talkMaxDuration)

			if var_463_8 <= arg_460_1.time_ and arg_460_1.time_ < var_463_8 + var_463_16 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_8) / var_463_16

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_8 + var_463_16 and arg_460_1.time_ < var_463_8 + var_463_16 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play424071112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 424071112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play424071113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.85

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:GetWordFromCfg(424071112)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 34
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_8 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_8 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_8

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_8 and arg_464_1.time_ < var_467_0 + var_467_8 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play424071113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 424071113
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play424071114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.7

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

				local var_471_2 = arg_468_1:GetWordFromCfg(424071113)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 28
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
	Play424071114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 424071114
		arg_472_1.duration_ = 5.1

		local var_472_0 = {
			zh = 3.766,
			ja = 5.1
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
				arg_472_0:Play424071115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.475

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[177].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_3 = arg_472_1:GetWordFromCfg(424071114)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071114", "story_v_out_424071.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071114", "story_v_out_424071.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_424071", "424071114", "story_v_out_424071.awb")

						arg_472_1:RecordAudio("424071114", var_475_9)
						arg_472_1:RecordAudio("424071114", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_424071", "424071114", "story_v_out_424071.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_424071", "424071114", "story_v_out_424071.awb")
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
	Play424071115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 424071115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play424071116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.7

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

				local var_479_3 = arg_476_1:GetWordFromCfg(424071115)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 28
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
	Play424071116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 424071116
		arg_480_1.duration_ = 1.4

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play424071117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1094"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos1094 = var_483_0.localPosition
				var_483_0.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("1094", 3)

				local var_483_2 = var_483_0.childCount

				for iter_483_0 = 0, var_483_2 - 1 do
					local var_483_3 = var_483_0:GetChild(iter_483_0)

					if var_483_3.name == "split_4" then
						var_483_3:SetAsLastSibling()
						var_483_3.gameObject:SetActive(true)

						arg_480_1.var_.actorSpriteSplit1094 = var_483_3.gameObject:GetComponent(typeof(Image))

						arg_480_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_483_4 = 0.5

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_4 then
				local var_483_5 = (arg_480_1.time_ - var_483_1) / var_483_4
				local var_483_6 = Vector3.New(0, -335, -230)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1094, var_483_6, var_483_5)

				if arg_480_1.var_.actorSpriteSplit1094 ~= nil then
					arg_480_1.var_.actorSpriteSplit1094:SetAlpha(var_483_5)
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_4 and arg_480_1.time_ < var_483_1 + var_483_4 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, -335, -230)

				if arg_480_1.var_.actorSpriteSplit1094 ~= nil then
					arg_480_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_483_7 = arg_480_1.actors_["1094"]
			local var_483_8 = 0

			if var_483_8 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 and not isNil(var_483_7) and arg_480_1.var_.actorSpriteComps1094 == nil then
				arg_480_1.var_.actorSpriteComps1094 = var_483_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_9 = 0.2

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_9 and not isNil(var_483_7) then
				local var_483_10 = (arg_480_1.time_ - var_483_8) / var_483_9

				if arg_480_1.var_.actorSpriteComps1094 then
					for iter_483_1, iter_483_2 in pairs(arg_480_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_483_2 then
							if arg_480_1.isInRecall_ then
								local var_483_11 = Mathf.Lerp(iter_483_2.color.r, arg_480_1.hightColor1.r, var_483_10)
								local var_483_12 = Mathf.Lerp(iter_483_2.color.g, arg_480_1.hightColor1.g, var_483_10)
								local var_483_13 = Mathf.Lerp(iter_483_2.color.b, arg_480_1.hightColor1.b, var_483_10)

								iter_483_2.color = Color.New(var_483_11, var_483_12, var_483_13)
							else
								local var_483_14 = Mathf.Lerp(iter_483_2.color.r, 1, var_483_10)

								iter_483_2.color = Color.New(var_483_14, var_483_14, var_483_14)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_8 + var_483_9 and arg_480_1.time_ < var_483_8 + var_483_9 + arg_483_0 and not isNil(var_483_7) and arg_480_1.var_.actorSpriteComps1094 then
				for iter_483_3, iter_483_4 in pairs(arg_480_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_483_4 then
						if arg_480_1.isInRecall_ then
							iter_483_4.color = arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_483_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps1094 = nil
			end

			local var_483_15 = 0
			local var_483_16 = 0.075

			if var_483_15 < arg_480_1.time_ and arg_480_1.time_ <= var_483_15 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_17 = arg_480_1:FormatText(StoryNameCfg[1403].name)

				arg_480_1.leftNameTxt_.text = var_483_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_18 = arg_480_1:GetWordFromCfg(424071116)
				local var_483_19 = arg_480_1:FormatText(var_483_18.content)

				arg_480_1.text_.text = var_483_19

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_20 = 3
				local var_483_21 = utf8.len(var_483_19)
				local var_483_22 = var_483_20 <= 0 and var_483_16 or var_483_16 * (var_483_21 / var_483_20)

				if var_483_22 > 0 and var_483_16 < var_483_22 then
					arg_480_1.talkMaxDuration = var_483_22

					if var_483_22 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_22 + var_483_15
					end
				end

				arg_480_1.text_.text = var_483_19
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071116", "story_v_out_424071.awb") ~= 0 then
					local var_483_23 = manager.audio:GetVoiceLength("story_v_out_424071", "424071116", "story_v_out_424071.awb") / 1000

					if var_483_23 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_23 + var_483_15
					end

					if var_483_18.prefab_name ~= "" and arg_480_1.actors_[var_483_18.prefab_name] ~= nil then
						local var_483_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_18.prefab_name].transform, "story_v_out_424071", "424071116", "story_v_out_424071.awb")

						arg_480_1:RecordAudio("424071116", var_483_24)
						arg_480_1:RecordAudio("424071116", var_483_24)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_424071", "424071116", "story_v_out_424071.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_424071", "424071116", "story_v_out_424071.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_25 = math.max(var_483_16, arg_480_1.talkMaxDuration)

			if var_483_15 <= arg_480_1.time_ and arg_480_1.time_ < var_483_15 + var_483_25 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_15) / var_483_25

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_15 + var_483_25 and arg_480_1.time_ < var_483_15 + var_483_25 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
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

		arg_480_1:InitPlayNodeList()
	end,
	Play424071117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 424071117
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
			arg_484_1.auto_ = false
		end

		function arg_484_1.playNext_(arg_486_0)
			arg_484_1.onStoryFinished_()
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1094"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.actorSpriteComps1094 == nil then
				arg_484_1.var_.actorSpriteComps1094 = var_487_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_2 = 0.2

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.actorSpriteComps1094 then
					for iter_487_0, iter_487_1 in pairs(arg_484_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_487_1 then
							if arg_484_1.isInRecall_ then
								local var_487_4 = Mathf.Lerp(iter_487_1.color.r, arg_484_1.hightColor2.r, var_487_3)
								local var_487_5 = Mathf.Lerp(iter_487_1.color.g, arg_484_1.hightColor2.g, var_487_3)
								local var_487_6 = Mathf.Lerp(iter_487_1.color.b, arg_484_1.hightColor2.b, var_487_3)

								iter_487_1.color = Color.New(var_487_4, var_487_5, var_487_6)
							else
								local var_487_7 = Mathf.Lerp(iter_487_1.color.r, 0.5, var_487_3)

								iter_487_1.color = Color.New(var_487_7, var_487_7, var_487_7)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.actorSpriteComps1094 then
				for iter_487_2, iter_487_3 in pairs(arg_484_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_487_3 then
						if arg_484_1.isInRecall_ then
							iter_487_3.color = arg_484_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_487_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_484_1.var_.actorSpriteComps1094 = nil
			end

			local var_487_8 = 0
			local var_487_9 = 0.425

			if var_487_8 < arg_484_1.time_ and arg_484_1.time_ <= var_487_8 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_10 = arg_484_1:FormatText(StoryNameCfg[7].name)

				arg_484_1.leftNameTxt_.text = var_487_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_11 = arg_484_1:GetWordFromCfg(424071117)
				local var_487_12 = arg_484_1:FormatText(var_487_11.content)

				arg_484_1.text_.text = var_487_12

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_13 = 17
				local var_487_14 = utf8.len(var_487_12)
				local var_487_15 = var_487_13 <= 0 and var_487_9 or var_487_9 * (var_487_14 / var_487_13)

				if var_487_15 > 0 and var_487_9 < var_487_15 then
					arg_484_1.talkMaxDuration = var_487_15

					if var_487_15 + var_487_8 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_15 + var_487_8
					end
				end

				arg_484_1.text_.text = var_487_12
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_16 = math.max(var_487_9, arg_484_1.talkMaxDuration)

			if var_487_8 <= arg_484_1.time_ and arg_484_1.time_ < var_487_8 + var_487_16 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_8) / var_487_16

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_8 + var_487_16 and arg_484_1.time_ < var_487_8 + var_487_16 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ST0115"
	},
	voices = {
		"story_v_out_424071.awb"
	}
}
