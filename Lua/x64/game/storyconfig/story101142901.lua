return {
	Play114291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114291001
		arg_1_1.duration_ = 9.7

		local var_1_0 = {
			ja = 9.7,
			ko = 5.5,
			zh = 6.9,
			en = 6.133
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
				arg_1_0:Play114291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST26"

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
				local var_4_5 = arg_1_1.bgs_.ST26

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
					if iter_4_0 ~= "ST26" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = "10016"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_23.transform:SetSiblingIndex(1)

				var_4_23.name = var_4_22

				local var_4_24 = var_4_23:GetComponent(typeof(Image))

				var_4_24.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10016")

				var_4_24:SetNativeSize()

				var_4_23.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_22] = var_4_23
			end

			local var_4_25 = arg_1_1.actors_["10016"].transform
			local var_4_26 = 1.8

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.moveOldPos10016 = var_4_25.localPosition
				var_4_25.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_4_27 = 0.001

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Vector3.New(-390, -350, -180)

				var_4_25.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10016, var_4_29, var_4_28)
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_30 = arg_1_1.actors_["10016"]
			local var_4_31 = 1.8

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 and not isNil(var_4_30) then
				local var_4_32 = var_4_30:GetComponent("Image")

				if var_4_32 then
					arg_1_1.var_.highlightMatValue10016 = var_4_32
				end
			end

			local var_4_33 = 0.034

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_33 and not isNil(var_4_30) then
				local var_4_34 = (arg_1_1.time_ - var_4_31) / var_4_33

				if arg_1_1.var_.highlightMatValue10016 then
					local var_4_35 = Mathf.Lerp(0.5, 1, var_4_34)
					local var_4_36 = arg_1_1.var_.highlightMatValue10016
					local var_4_37 = var_4_36.color

					var_4_37.r = var_4_35
					var_4_37.g = var_4_35
					var_4_37.b = var_4_35
					var_4_36.color = var_4_37
				end
			end

			if arg_1_1.time_ >= var_4_31 + var_4_33 and arg_1_1.time_ < var_4_31 + var_4_33 + arg_4_0 and not isNil(var_4_30) and arg_1_1.var_.highlightMatValue10016 then
				local var_4_38 = 1

				var_4_30.transform:SetSiblingIndex(1)

				local var_4_39 = arg_1_1.var_.highlightMatValue10016
				local var_4_40 = var_4_39.color

				var_4_40.r = var_4_38
				var_4_40.g = var_4_38
				var_4_40.b = var_4_38
				var_4_39.color = var_4_40
			end

			local var_4_41 = arg_1_1.actors_["10016"]
			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponent("Image")

				if var_4_43 then
					arg_1_1.var_.alphaMatValue10016 = var_4_43
					arg_1_1.var_.alphaOldValue10016 = var_4_43.color.a
				end

				arg_1_1.var_.alphaOldValue10016 = 0
			end

			local var_4_44 = 0.5

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10016, 1, var_4_45)

				if arg_1_1.var_.alphaMatValue10016 then
					local var_4_47 = arg_1_1.var_.alphaMatValue10016.color

					var_4_47.a = var_4_46
					arg_1_1.var_.alphaMatValue10016.color = var_4_47
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.alphaMatValue10016 then
				local var_4_48 = arg_1_1.var_.alphaMatValue10016
				local var_4_49 = var_4_48.color

				var_4_49.a = 1
				var_4_48.color = var_4_49
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 2
			local var_4_57 = 0.733333333333333

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "music"

				arg_1_1:AudioAction(var_4_58, var_4_59, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_4_60 = ""
				local var_4_61 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_4_61 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_61 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_61

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_61
						arg_1_1.bgmTxt2_.text = var_4_61
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

			local var_4_62 = 2
			local var_4_63 = 0.475

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_64 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_64:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_65 = arg_1_1:FormatText(StoryNameCfg[226].name)

				arg_1_1.leftNameTxt_.text = var_4_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_66 = arg_1_1:GetWordFromCfg(114291001)
				local var_4_67 = arg_1_1:FormatText(var_4_66.content)

				arg_1_1.text_.text = var_4_67

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_68 = 19
				local var_4_69 = utf8.len(var_4_67)
				local var_4_70 = var_4_68 <= 0 and var_4_63 or var_4_63 * (var_4_69 / var_4_68)

				if var_4_70 > 0 and var_4_63 < var_4_70 then
					arg_1_1.talkMaxDuration = var_4_70
					var_4_62 = var_4_62 + 0.3

					if var_4_70 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_62
					end
				end

				arg_1_1.text_.text = var_4_67
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291001", "story_v_out_114291.awb") ~= 0 then
					local var_4_71 = manager.audio:GetVoiceLength("story_v_out_114291", "114291001", "story_v_out_114291.awb") / 1000

					if var_4_71 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_71 + var_4_62
					end

					if var_4_66.prefab_name ~= "" and arg_1_1.actors_[var_4_66.prefab_name] ~= nil then
						local var_4_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_66.prefab_name].transform, "story_v_out_114291", "114291001", "story_v_out_114291.awb")

						arg_1_1:RecordAudio("114291001", var_4_72)
						arg_1_1:RecordAudio("114291001", var_4_72)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114291", "114291001", "story_v_out_114291.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114291", "114291001", "story_v_out_114291.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_73 = var_4_62 + 0.3
			local var_4_74 = math.max(var_4_63, arg_1_1.talkMaxDuration)

			if var_4_73 <= arg_1_1.time_ and arg_1_1.time_ < var_4_73 + var_4_74 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_73) / var_4_74

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_73 + var_4_74 and arg_1_1.time_ < var_4_73 + var_4_74 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play114291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114291002
		arg_9_1.duration_ = 9.13

		local var_9_0 = {
			ja = 9.133,
			ko = 8.8,
			zh = 6.166,
			en = 5.233
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10020"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.imageGo_, arg_9_1.canvasGo_.transform)

				var_12_1.transform:SetSiblingIndex(1)

				var_12_1.name = var_12_0

				local var_12_2 = var_12_1:GetComponent(typeof(Image))

				var_12_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10020")

				var_12_2:SetNativeSize()

				var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_9_1.actors_[var_12_0] = var_12_1
			end

			local var_12_3 = arg_9_1.actors_["10020"].transform
			local var_12_4 = 0

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.var_.moveOldPos10020 = var_12_3.localPosition
				var_12_3.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10020", 4)
			end

			local var_12_5 = 0.001

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_5 then
				local var_12_6 = (arg_9_1.time_ - var_12_4) / var_12_5
				local var_12_7 = Vector3.New(390, -350, -180)

				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10020, var_12_7, var_12_6)
			end

			if arg_9_1.time_ >= var_12_4 + var_12_5 and arg_9_1.time_ < var_12_4 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(390, -350, -180)
			end

			local var_12_8 = arg_9_1.actors_["10016"]
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 and not isNil(var_12_8) then
				local var_12_10 = var_12_8:GetComponent("Image")

				if var_12_10 then
					arg_9_1.var_.highlightMatValue10016 = var_12_10
				end
			end

			local var_12_11 = 0.034

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_11 and not isNil(var_12_8) then
				local var_12_12 = (arg_9_1.time_ - var_12_9) / var_12_11

				if arg_9_1.var_.highlightMatValue10016 then
					local var_12_13 = Mathf.Lerp(1, 0.5, var_12_12)
					local var_12_14 = arg_9_1.var_.highlightMatValue10016
					local var_12_15 = var_12_14.color

					var_12_15.r = var_12_13
					var_12_15.g = var_12_13
					var_12_15.b = var_12_13
					var_12_14.color = var_12_15
				end
			end

			if arg_9_1.time_ >= var_12_9 + var_12_11 and arg_9_1.time_ < var_12_9 + var_12_11 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.highlightMatValue10016 then
				local var_12_16 = 0.5
				local var_12_17 = arg_9_1.var_.highlightMatValue10016
				local var_12_18 = var_12_17.color

				var_12_18.r = var_12_16
				var_12_18.g = var_12_16
				var_12_18.b = var_12_16
				var_12_17.color = var_12_18
			end

			local var_12_19 = arg_9_1.actors_["10020"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) then
				local var_12_21 = var_12_19:GetComponent("Image")

				if var_12_21 then
					arg_9_1.var_.highlightMatValue10020 = var_12_21
				end
			end

			local var_12_22 = 0.034

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_22 and not isNil(var_12_19) then
				local var_12_23 = (arg_9_1.time_ - var_12_20) / var_12_22

				if arg_9_1.var_.highlightMatValue10020 then
					local var_12_24 = Mathf.Lerp(0.5, 1, var_12_23)
					local var_12_25 = arg_9_1.var_.highlightMatValue10020
					local var_12_26 = var_12_25.color

					var_12_26.r = var_12_24
					var_12_26.g = var_12_24
					var_12_26.b = var_12_24
					var_12_25.color = var_12_26
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_22 and arg_9_1.time_ < var_12_20 + var_12_22 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.highlightMatValue10020 then
				local var_12_27 = 1

				var_12_19.transform:SetSiblingIndex(1)

				local var_12_28 = arg_9_1.var_.highlightMatValue10020
				local var_12_29 = var_12_28.color

				var_12_29.r = var_12_27
				var_12_29.g = var_12_27
				var_12_29.b = var_12_27
				var_12_28.color = var_12_29
			end

			local var_12_30 = arg_9_1.actors_["10020"]
			local var_12_31 = 0

			if var_12_31 < arg_9_1.time_ and arg_9_1.time_ <= var_12_31 + arg_12_0 then
				local var_12_32 = var_12_30:GetComponent("Image")

				if var_12_32 then
					arg_9_1.var_.alphaMatValue10020 = var_12_32
					arg_9_1.var_.alphaOldValue10020 = var_12_32.color.a
				end

				arg_9_1.var_.alphaOldValue10020 = 0
			end

			local var_12_33 = 0.5

			if var_12_31 <= arg_9_1.time_ and arg_9_1.time_ < var_12_31 + var_12_33 then
				local var_12_34 = (arg_9_1.time_ - var_12_31) / var_12_33
				local var_12_35 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10020, 1, var_12_34)

				if arg_9_1.var_.alphaMatValue10020 then
					local var_12_36 = arg_9_1.var_.alphaMatValue10020.color

					var_12_36.a = var_12_35
					arg_9_1.var_.alphaMatValue10020.color = var_12_36
				end
			end

			if arg_9_1.time_ >= var_12_31 + var_12_33 and arg_9_1.time_ < var_12_31 + var_12_33 + arg_12_0 and arg_9_1.var_.alphaMatValue10020 then
				local var_12_37 = arg_9_1.var_.alphaMatValue10020
				local var_12_38 = var_12_37.color

				var_12_38.a = 1
				var_12_37.color = var_12_38
			end

			local var_12_39 = 0
			local var_12_40 = 0.675

			if var_12_39 < arg_9_1.time_ and arg_9_1.time_ <= var_12_39 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_41 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_42 = arg_9_1:GetWordFromCfg(114291002)
				local var_12_43 = arg_9_1:FormatText(var_12_42.content)

				arg_9_1.text_.text = var_12_43

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_44 = 27
				local var_12_45 = utf8.len(var_12_43)
				local var_12_46 = var_12_44 <= 0 and var_12_40 or var_12_40 * (var_12_45 / var_12_44)

				if var_12_46 > 0 and var_12_40 < var_12_46 then
					arg_9_1.talkMaxDuration = var_12_46

					if var_12_46 + var_12_39 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_46 + var_12_39
					end
				end

				arg_9_1.text_.text = var_12_43
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291002", "story_v_out_114291.awb") ~= 0 then
					local var_12_47 = manager.audio:GetVoiceLength("story_v_out_114291", "114291002", "story_v_out_114291.awb") / 1000

					if var_12_47 + var_12_39 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_47 + var_12_39
					end

					if var_12_42.prefab_name ~= "" and arg_9_1.actors_[var_12_42.prefab_name] ~= nil then
						local var_12_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_42.prefab_name].transform, "story_v_out_114291", "114291002", "story_v_out_114291.awb")

						arg_9_1:RecordAudio("114291002", var_12_48)
						arg_9_1:RecordAudio("114291002", var_12_48)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114291", "114291002", "story_v_out_114291.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114291", "114291002", "story_v_out_114291.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_49 = math.max(var_12_40, arg_9_1.talkMaxDuration)

			if var_12_39 <= arg_9_1.time_ and arg_9_1.time_ < var_12_39 + var_12_49 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_39) / var_12_49

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_39 + var_12_49 and arg_9_1.time_ < var_12_39 + var_12_49 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10020",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114291003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10020"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) then
				local var_16_2 = var_16_0:GetComponent("Image")

				if var_16_2 then
					arg_13_1.var_.highlightMatValue10020 = var_16_2
				end
			end

			local var_16_3 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 and not isNil(var_16_0) then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3

				if arg_13_1.var_.highlightMatValue10020 then
					local var_16_5 = Mathf.Lerp(1, 0.5, var_16_4)
					local var_16_6 = arg_13_1.var_.highlightMatValue10020
					local var_16_7 = var_16_6.color

					var_16_7.r = var_16_5
					var_16_7.g = var_16_5
					var_16_7.b = var_16_5
					var_16_6.color = var_16_7
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.highlightMatValue10020 then
				local var_16_8 = 0.5
				local var_16_9 = arg_13_1.var_.highlightMatValue10020
				local var_16_10 = var_16_9.color

				var_16_10.r = var_16_8
				var_16_10.g = var_16_8
				var_16_10.b = var_16_8
				var_16_9.color = var_16_10
			end

			local var_16_11 = 0
			local var_16_12 = 1.2

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(114291003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 48
				local var_16_16 = utf8.len(var_16_14)
				local var_16_17 = var_16_15 <= 0 and var_16_12 or var_16_12 * (var_16_16 / var_16_15)

				if var_16_17 > 0 and var_16_12 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_18 and arg_13_1.time_ < var_16_11 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114291004
		arg_17_1.duration_ = 16.27

		local var_17_0 = {
			ja = 16.266,
			ko = 10.7,
			zh = 13.933,
			en = 13.666
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
				arg_17_0:Play114291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10016"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) then
				local var_20_2 = var_20_0:GetComponent("Image")

				if var_20_2 then
					arg_17_1.var_.highlightMatValue10016 = var_20_2
				end
			end

			local var_20_3 = 0.034

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 and not isNil(var_20_0) then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3

				if arg_17_1.var_.highlightMatValue10016 then
					local var_20_5 = Mathf.Lerp(0.5, 1, var_20_4)
					local var_20_6 = arg_17_1.var_.highlightMatValue10016
					local var_20_7 = var_20_6.color

					var_20_7.r = var_20_5
					var_20_7.g = var_20_5
					var_20_7.b = var_20_5
					var_20_6.color = var_20_7
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.highlightMatValue10016 then
				local var_20_8 = 1

				var_20_0.transform:SetSiblingIndex(1)

				local var_20_9 = arg_17_1.var_.highlightMatValue10016
				local var_20_10 = var_20_9.color

				var_20_10.r = var_20_8
				var_20_10.g = var_20_8
				var_20_10.b = var_20_8
				var_20_9.color = var_20_10
			end

			local var_20_11 = 0
			local var_20_12 = 1.275

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_13 = arg_17_1:FormatText(StoryNameCfg[226].name)

				arg_17_1.leftNameTxt_.text = var_20_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(114291004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 51
				local var_20_17 = utf8.len(var_20_15)
				local var_20_18 = var_20_16 <= 0 and var_20_12 or var_20_12 * (var_20_17 / var_20_16)

				if var_20_18 > 0 and var_20_12 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18

					if var_20_18 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291004", "story_v_out_114291.awb") ~= 0 then
					local var_20_19 = manager.audio:GetVoiceLength("story_v_out_114291", "114291004", "story_v_out_114291.awb") / 1000

					if var_20_19 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_11
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_114291", "114291004", "story_v_out_114291.awb")

						arg_17_1:RecordAudio("114291004", var_20_20)
						arg_17_1:RecordAudio("114291004", var_20_20)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114291", "114291004", "story_v_out_114291.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114291", "114291004", "story_v_out_114291.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_21 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_21 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_21

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_21 and arg_17_1.time_ < var_20_11 + var_20_21 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114291005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114291005
		arg_21_1.duration_ = 10.93

		local var_21_0 = {
			ja = 10.933,
			ko = 10.266,
			zh = 8.833,
			en = 10.9
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
				arg_21_0:Play114291006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10016"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) then
				local var_24_2 = var_24_0:GetComponent("Image")

				if var_24_2 then
					arg_21_1.var_.highlightMatValue10016 = var_24_2
				end
			end

			local var_24_3 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_3 and not isNil(var_24_0) then
				local var_24_4 = (arg_21_1.time_ - var_24_1) / var_24_3

				if arg_21_1.var_.highlightMatValue10016 then
					local var_24_5 = Mathf.Lerp(1, 0.5, var_24_4)
					local var_24_6 = arg_21_1.var_.highlightMatValue10016
					local var_24_7 = var_24_6.color

					var_24_7.r = var_24_5
					var_24_7.g = var_24_5
					var_24_7.b = var_24_5
					var_24_6.color = var_24_7
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_3 and arg_21_1.time_ < var_24_1 + var_24_3 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.highlightMatValue10016 then
				local var_24_8 = 0.5
				local var_24_9 = arg_21_1.var_.highlightMatValue10016
				local var_24_10 = var_24_9.color

				var_24_10.r = var_24_8
				var_24_10.g = var_24_8
				var_24_10.b = var_24_8
				var_24_9.color = var_24_10
			end

			local var_24_11 = arg_21_1.actors_["10020"]
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 and not isNil(var_24_11) then
				local var_24_13 = var_24_11:GetComponent("Image")

				if var_24_13 then
					arg_21_1.var_.highlightMatValue10020 = var_24_13
				end
			end

			local var_24_14 = 0.034

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_14 and not isNil(var_24_11) then
				local var_24_15 = (arg_21_1.time_ - var_24_12) / var_24_14

				if arg_21_1.var_.highlightMatValue10020 then
					local var_24_16 = Mathf.Lerp(0.5, 1, var_24_15)
					local var_24_17 = arg_21_1.var_.highlightMatValue10020
					local var_24_18 = var_24_17.color

					var_24_18.r = var_24_16
					var_24_18.g = var_24_16
					var_24_18.b = var_24_16
					var_24_17.color = var_24_18
				end
			end

			if arg_21_1.time_ >= var_24_12 + var_24_14 and arg_21_1.time_ < var_24_12 + var_24_14 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.highlightMatValue10020 then
				local var_24_19 = 1

				var_24_11.transform:SetSiblingIndex(1)

				local var_24_20 = arg_21_1.var_.highlightMatValue10020
				local var_24_21 = var_24_20.color

				var_24_21.r = var_24_19
				var_24_21.g = var_24_19
				var_24_21.b = var_24_19
				var_24_20.color = var_24_21
			end

			local var_24_22 = 0
			local var_24_23 = 0.7

			if var_24_22 < arg_21_1.time_ and arg_21_1.time_ <= var_24_22 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_24 = arg_21_1:FormatText(StoryNameCfg[36].name)

				arg_21_1.leftNameTxt_.text = var_24_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_25 = arg_21_1:GetWordFromCfg(114291005)
				local var_24_26 = arg_21_1:FormatText(var_24_25.content)

				arg_21_1.text_.text = var_24_26

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_27 = 28
				local var_24_28 = utf8.len(var_24_26)
				local var_24_29 = var_24_27 <= 0 and var_24_23 or var_24_23 * (var_24_28 / var_24_27)

				if var_24_29 > 0 and var_24_23 < var_24_29 then
					arg_21_1.talkMaxDuration = var_24_29

					if var_24_29 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_22
					end
				end

				arg_21_1.text_.text = var_24_26
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291005", "story_v_out_114291.awb") ~= 0 then
					local var_24_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291005", "story_v_out_114291.awb") / 1000

					if var_24_30 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_22
					end

					if var_24_25.prefab_name ~= "" and arg_21_1.actors_[var_24_25.prefab_name] ~= nil then
						local var_24_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_25.prefab_name].transform, "story_v_out_114291", "114291005", "story_v_out_114291.awb")

						arg_21_1:RecordAudio("114291005", var_24_31)
						arg_21_1:RecordAudio("114291005", var_24_31)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114291", "114291005", "story_v_out_114291.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114291", "114291005", "story_v_out_114291.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_32 = math.max(var_24_23, arg_21_1.talkMaxDuration)

			if var_24_22 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_32 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_32

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_32 and arg_21_1.time_ < var_24_22 + var_24_32 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114291006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114291006
		arg_25_1.duration_ = 12.7

		local var_25_0 = {
			ja = 12.7,
			ko = 9.433,
			zh = 10.766,
			en = 8.166
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
				arg_25_0:Play114291007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10016"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) then
				local var_28_2 = var_28_0:GetComponent("Image")

				if var_28_2 then
					arg_25_1.var_.highlightMatValue10016 = var_28_2
				end
			end

			local var_28_3 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 and not isNil(var_28_0) then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3

				if arg_25_1.var_.highlightMatValue10016 then
					local var_28_5 = Mathf.Lerp(0.5, 1, var_28_4)
					local var_28_6 = arg_25_1.var_.highlightMatValue10016
					local var_28_7 = var_28_6.color

					var_28_7.r = var_28_5
					var_28_7.g = var_28_5
					var_28_7.b = var_28_5
					var_28_6.color = var_28_7
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.highlightMatValue10016 then
				local var_28_8 = 1

				var_28_0.transform:SetSiblingIndex(1)

				local var_28_9 = arg_25_1.var_.highlightMatValue10016
				local var_28_10 = var_28_9.color

				var_28_10.r = var_28_8
				var_28_10.g = var_28_8
				var_28_10.b = var_28_8
				var_28_9.color = var_28_10
			end

			local var_28_11 = arg_25_1.actors_["10020"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) then
				local var_28_13 = var_28_11:GetComponent("Image")

				if var_28_13 then
					arg_25_1.var_.highlightMatValue10020 = var_28_13
				end
			end

			local var_28_14 = 0.034

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_14 and not isNil(var_28_11) then
				local var_28_15 = (arg_25_1.time_ - var_28_12) / var_28_14

				if arg_25_1.var_.highlightMatValue10020 then
					local var_28_16 = Mathf.Lerp(1, 0.5, var_28_15)
					local var_28_17 = arg_25_1.var_.highlightMatValue10020
					local var_28_18 = var_28_17.color

					var_28_18.r = var_28_16
					var_28_18.g = var_28_16
					var_28_18.b = var_28_16
					var_28_17.color = var_28_18
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_14 and arg_25_1.time_ < var_28_12 + var_28_14 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.highlightMatValue10020 then
				local var_28_19 = 0.5
				local var_28_20 = arg_25_1.var_.highlightMatValue10020
				local var_28_21 = var_28_20.color

				var_28_21.r = var_28_19
				var_28_21.g = var_28_19
				var_28_21.b = var_28_19
				var_28_20.color = var_28_21
			end

			local var_28_22 = 0
			local var_28_23 = 0.95

			if var_28_22 < arg_25_1.time_ and arg_25_1.time_ <= var_28_22 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_24 = arg_25_1:FormatText(StoryNameCfg[226].name)

				arg_25_1.leftNameTxt_.text = var_28_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_25 = arg_25_1:GetWordFromCfg(114291006)
				local var_28_26 = arg_25_1:FormatText(var_28_25.content)

				arg_25_1.text_.text = var_28_26

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_27 = 38
				local var_28_28 = utf8.len(var_28_26)
				local var_28_29 = var_28_27 <= 0 and var_28_23 or var_28_23 * (var_28_28 / var_28_27)

				if var_28_29 > 0 and var_28_23 < var_28_29 then
					arg_25_1.talkMaxDuration = var_28_29

					if var_28_29 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_22
					end
				end

				arg_25_1.text_.text = var_28_26
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291006", "story_v_out_114291.awb") ~= 0 then
					local var_28_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291006", "story_v_out_114291.awb") / 1000

					if var_28_30 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_22
					end

					if var_28_25.prefab_name ~= "" and arg_25_1.actors_[var_28_25.prefab_name] ~= nil then
						local var_28_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_25.prefab_name].transform, "story_v_out_114291", "114291006", "story_v_out_114291.awb")

						arg_25_1:RecordAudio("114291006", var_28_31)
						arg_25_1:RecordAudio("114291006", var_28_31)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114291", "114291006", "story_v_out_114291.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114291", "114291006", "story_v_out_114291.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_32 = math.max(var_28_23, arg_25_1.talkMaxDuration)

			if var_28_22 <= arg_25_1.time_ and arg_25_1.time_ < var_28_22 + var_28_32 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_22) / var_28_32

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_22 + var_28_32 and arg_25_1.time_ < var_28_22 + var_28_32 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114291007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114291007
		arg_29_1.duration_ = 5.9

		local var_29_0 = {
			ja = 5.9,
			ko = 4.333,
			zh = 3.366,
			en = 2.9
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
				arg_29_0:Play114291008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10016"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) then
				local var_32_2 = var_32_0:GetComponent("Image")

				if var_32_2 then
					arg_29_1.var_.highlightMatValue10016 = var_32_2
				end
			end

			local var_32_3 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_3 and not isNil(var_32_0) then
				local var_32_4 = (arg_29_1.time_ - var_32_1) / var_32_3

				if arg_29_1.var_.highlightMatValue10016 then
					local var_32_5 = Mathf.Lerp(1, 0.5, var_32_4)
					local var_32_6 = arg_29_1.var_.highlightMatValue10016
					local var_32_7 = var_32_6.color

					var_32_7.r = var_32_5
					var_32_7.g = var_32_5
					var_32_7.b = var_32_5
					var_32_6.color = var_32_7
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_3 and arg_29_1.time_ < var_32_1 + var_32_3 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.highlightMatValue10016 then
				local var_32_8 = 0.5
				local var_32_9 = arg_29_1.var_.highlightMatValue10016
				local var_32_10 = var_32_9.color

				var_32_10.r = var_32_8
				var_32_10.g = var_32_8
				var_32_10.b = var_32_8
				var_32_9.color = var_32_10
			end

			local var_32_11 = arg_29_1.actors_["10020"]
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 and not isNil(var_32_11) then
				local var_32_13 = var_32_11:GetComponent("Image")

				if var_32_13 then
					arg_29_1.var_.highlightMatValue10020 = var_32_13
				end
			end

			local var_32_14 = 0.034

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_14 and not isNil(var_32_11) then
				local var_32_15 = (arg_29_1.time_ - var_32_12) / var_32_14

				if arg_29_1.var_.highlightMatValue10020 then
					local var_32_16 = Mathf.Lerp(0.5, 1, var_32_15)
					local var_32_17 = arg_29_1.var_.highlightMatValue10020
					local var_32_18 = var_32_17.color

					var_32_18.r = var_32_16
					var_32_18.g = var_32_16
					var_32_18.b = var_32_16
					var_32_17.color = var_32_18
				end
			end

			if arg_29_1.time_ >= var_32_12 + var_32_14 and arg_29_1.time_ < var_32_12 + var_32_14 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.highlightMatValue10020 then
				local var_32_19 = 1

				var_32_11.transform:SetSiblingIndex(1)

				local var_32_20 = arg_29_1.var_.highlightMatValue10020
				local var_32_21 = var_32_20.color

				var_32_21.r = var_32_19
				var_32_21.g = var_32_19
				var_32_21.b = var_32_19
				var_32_20.color = var_32_21
			end

			local var_32_22 = 0
			local var_32_23 = 0.35

			if var_32_22 < arg_29_1.time_ and arg_29_1.time_ <= var_32_22 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_24 = arg_29_1:FormatText(StoryNameCfg[36].name)

				arg_29_1.leftNameTxt_.text = var_32_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_25 = arg_29_1:GetWordFromCfg(114291007)
				local var_32_26 = arg_29_1:FormatText(var_32_25.content)

				arg_29_1.text_.text = var_32_26

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_27 = 14
				local var_32_28 = utf8.len(var_32_26)
				local var_32_29 = var_32_27 <= 0 and var_32_23 or var_32_23 * (var_32_28 / var_32_27)

				if var_32_29 > 0 and var_32_23 < var_32_29 then
					arg_29_1.talkMaxDuration = var_32_29

					if var_32_29 + var_32_22 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_29 + var_32_22
					end
				end

				arg_29_1.text_.text = var_32_26
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291007", "story_v_out_114291.awb") ~= 0 then
					local var_32_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291007", "story_v_out_114291.awb") / 1000

					if var_32_30 + var_32_22 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_22
					end

					if var_32_25.prefab_name ~= "" and arg_29_1.actors_[var_32_25.prefab_name] ~= nil then
						local var_32_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_25.prefab_name].transform, "story_v_out_114291", "114291007", "story_v_out_114291.awb")

						arg_29_1:RecordAudio("114291007", var_32_31)
						arg_29_1:RecordAudio("114291007", var_32_31)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114291", "114291007", "story_v_out_114291.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114291", "114291007", "story_v_out_114291.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_32 = math.max(var_32_23, arg_29_1.talkMaxDuration)

			if var_32_22 <= arg_29_1.time_ and arg_29_1.time_ < var_32_22 + var_32_32 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_22) / var_32_32

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_22 + var_32_32 and arg_29_1.time_ < var_32_22 + var_32_32 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114291008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114291008
		arg_33_1.duration_ = 17.6

		local var_33_0 = {
			ja = 13.233,
			ko = 15.9,
			zh = 16.033,
			en = 17.6
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
				arg_33_0:Play114291009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10016"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) then
				local var_36_2 = var_36_0:GetComponent("Image")

				if var_36_2 then
					arg_33_1.var_.highlightMatValue10016 = var_36_2
				end
			end

			local var_36_3 = 0.034

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 and not isNil(var_36_0) then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3

				if arg_33_1.var_.highlightMatValue10016 then
					local var_36_5 = Mathf.Lerp(0.5, 1, var_36_4)
					local var_36_6 = arg_33_1.var_.highlightMatValue10016
					local var_36_7 = var_36_6.color

					var_36_7.r = var_36_5
					var_36_7.g = var_36_5
					var_36_7.b = var_36_5
					var_36_6.color = var_36_7
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.highlightMatValue10016 then
				local var_36_8 = 1

				var_36_0.transform:SetSiblingIndex(1)

				local var_36_9 = arg_33_1.var_.highlightMatValue10016
				local var_36_10 = var_36_9.color

				var_36_10.r = var_36_8
				var_36_10.g = var_36_8
				var_36_10.b = var_36_8
				var_36_9.color = var_36_10
			end

			local var_36_11 = arg_33_1.actors_["10020"]
			local var_36_12 = 0

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 and not isNil(var_36_11) then
				local var_36_13 = var_36_11:GetComponent("Image")

				if var_36_13 then
					arg_33_1.var_.highlightMatValue10020 = var_36_13
				end
			end

			local var_36_14 = 0.034

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_14 and not isNil(var_36_11) then
				local var_36_15 = (arg_33_1.time_ - var_36_12) / var_36_14

				if arg_33_1.var_.highlightMatValue10020 then
					local var_36_16 = Mathf.Lerp(1, 0.5, var_36_15)
					local var_36_17 = arg_33_1.var_.highlightMatValue10020
					local var_36_18 = var_36_17.color

					var_36_18.r = var_36_16
					var_36_18.g = var_36_16
					var_36_18.b = var_36_16
					var_36_17.color = var_36_18
				end
			end

			if arg_33_1.time_ >= var_36_12 + var_36_14 and arg_33_1.time_ < var_36_12 + var_36_14 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.highlightMatValue10020 then
				local var_36_19 = 0.5
				local var_36_20 = arg_33_1.var_.highlightMatValue10020
				local var_36_21 = var_36_20.color

				var_36_21.r = var_36_19
				var_36_21.g = var_36_19
				var_36_21.b = var_36_19
				var_36_20.color = var_36_21
			end

			local var_36_22 = 0
			local var_36_23 = 1.325

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_24 = arg_33_1:FormatText(StoryNameCfg[226].name)

				arg_33_1.leftNameTxt_.text = var_36_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_25 = arg_33_1:GetWordFromCfg(114291008)
				local var_36_26 = arg_33_1:FormatText(var_36_25.content)

				arg_33_1.text_.text = var_36_26

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_27 = 53
				local var_36_28 = utf8.len(var_36_26)
				local var_36_29 = var_36_27 <= 0 and var_36_23 or var_36_23 * (var_36_28 / var_36_27)

				if var_36_29 > 0 and var_36_23 < var_36_29 then
					arg_33_1.talkMaxDuration = var_36_29

					if var_36_29 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_22
					end
				end

				arg_33_1.text_.text = var_36_26
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291008", "story_v_out_114291.awb") ~= 0 then
					local var_36_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291008", "story_v_out_114291.awb") / 1000

					if var_36_30 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_22
					end

					if var_36_25.prefab_name ~= "" and arg_33_1.actors_[var_36_25.prefab_name] ~= nil then
						local var_36_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_25.prefab_name].transform, "story_v_out_114291", "114291008", "story_v_out_114291.awb")

						arg_33_1:RecordAudio("114291008", var_36_31)
						arg_33_1:RecordAudio("114291008", var_36_31)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114291", "114291008", "story_v_out_114291.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114291", "114291008", "story_v_out_114291.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_32 = math.max(var_36_23, arg_33_1.talkMaxDuration)

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_22) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_22 + var_36_32 and arg_33_1.time_ < var_36_22 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114291009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114291009
		arg_37_1.duration_ = 12.33

		local var_37_0 = {
			ja = 6.666,
			ko = 12.3,
			zh = 12.333,
			en = 9.866
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
				arg_37_0:Play114291010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10016"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) then
				local var_40_2 = var_40_0:GetComponent("Image")

				if var_40_2 then
					arg_37_1.var_.highlightMatValue10016 = var_40_2
				end
			end

			local var_40_3 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_3 and not isNil(var_40_0) then
				local var_40_4 = (arg_37_1.time_ - var_40_1) / var_40_3

				if arg_37_1.var_.highlightMatValue10016 then
					local var_40_5 = Mathf.Lerp(1, 0.5, var_40_4)
					local var_40_6 = arg_37_1.var_.highlightMatValue10016
					local var_40_7 = var_40_6.color

					var_40_7.r = var_40_5
					var_40_7.g = var_40_5
					var_40_7.b = var_40_5
					var_40_6.color = var_40_7
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_3 and arg_37_1.time_ < var_40_1 + var_40_3 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.highlightMatValue10016 then
				local var_40_8 = 0.5
				local var_40_9 = arg_37_1.var_.highlightMatValue10016
				local var_40_10 = var_40_9.color

				var_40_10.r = var_40_8
				var_40_10.g = var_40_8
				var_40_10.b = var_40_8
				var_40_9.color = var_40_10
			end

			local var_40_11 = arg_37_1.actors_["10020"]
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 and not isNil(var_40_11) then
				local var_40_13 = var_40_11:GetComponent("Image")

				if var_40_13 then
					arg_37_1.var_.highlightMatValue10020 = var_40_13
				end
			end

			local var_40_14 = 0.034

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_14 and not isNil(var_40_11) then
				local var_40_15 = (arg_37_1.time_ - var_40_12) / var_40_14

				if arg_37_1.var_.highlightMatValue10020 then
					local var_40_16 = Mathf.Lerp(0.5, 1, var_40_15)
					local var_40_17 = arg_37_1.var_.highlightMatValue10020
					local var_40_18 = var_40_17.color

					var_40_18.r = var_40_16
					var_40_18.g = var_40_16
					var_40_18.b = var_40_16
					var_40_17.color = var_40_18
				end
			end

			if arg_37_1.time_ >= var_40_12 + var_40_14 and arg_37_1.time_ < var_40_12 + var_40_14 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.highlightMatValue10020 then
				local var_40_19 = 1

				var_40_11.transform:SetSiblingIndex(1)

				local var_40_20 = arg_37_1.var_.highlightMatValue10020
				local var_40_21 = var_40_20.color

				var_40_21.r = var_40_19
				var_40_21.g = var_40_19
				var_40_21.b = var_40_19
				var_40_20.color = var_40_21
			end

			local var_40_22 = 0
			local var_40_23 = 1.15

			if var_40_22 < arg_37_1.time_ and arg_37_1.time_ <= var_40_22 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_24 = arg_37_1:FormatText(StoryNameCfg[36].name)

				arg_37_1.leftNameTxt_.text = var_40_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_25 = arg_37_1:GetWordFromCfg(114291009)
				local var_40_26 = arg_37_1:FormatText(var_40_25.content)

				arg_37_1.text_.text = var_40_26

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_27 = 46
				local var_40_28 = utf8.len(var_40_26)
				local var_40_29 = var_40_27 <= 0 and var_40_23 or var_40_23 * (var_40_28 / var_40_27)

				if var_40_29 > 0 and var_40_23 < var_40_29 then
					arg_37_1.talkMaxDuration = var_40_29

					if var_40_29 + var_40_22 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_22
					end
				end

				arg_37_1.text_.text = var_40_26
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291009", "story_v_out_114291.awb") ~= 0 then
					local var_40_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291009", "story_v_out_114291.awb") / 1000

					if var_40_30 + var_40_22 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_30 + var_40_22
					end

					if var_40_25.prefab_name ~= "" and arg_37_1.actors_[var_40_25.prefab_name] ~= nil then
						local var_40_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_25.prefab_name].transform, "story_v_out_114291", "114291009", "story_v_out_114291.awb")

						arg_37_1:RecordAudio("114291009", var_40_31)
						arg_37_1:RecordAudio("114291009", var_40_31)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114291", "114291009", "story_v_out_114291.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114291", "114291009", "story_v_out_114291.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_32 = math.max(var_40_23, arg_37_1.talkMaxDuration)

			if var_40_22 <= arg_37_1.time_ and arg_37_1.time_ < var_40_22 + var_40_32 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_22) / var_40_32

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_22 + var_40_32 and arg_37_1.time_ < var_40_22 + var_40_32 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114291010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114291010
		arg_41_1.duration_ = 6.33

		local var_41_0 = {
			ja = 6.333,
			ko = 5.2,
			zh = 3.866,
			en = 3.466
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114291011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.425

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[36].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(114291010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291010", "story_v_out_114291.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291010", "story_v_out_114291.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_114291", "114291010", "story_v_out_114291.awb")

						arg_41_1:RecordAudio("114291010", var_44_9)
						arg_41_1:RecordAudio("114291010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114291", "114291010", "story_v_out_114291.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114291", "114291010", "story_v_out_114291.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114291011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114291011
		arg_45_1.duration_ = 3.37

		local var_45_0 = {
			ja = 3.366,
			ko = 2.5,
			zh = 3,
			en = 2.666
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
				arg_45_0:Play114291012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10016"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) then
				local var_48_2 = var_48_0:GetComponent("Image")

				if var_48_2 then
					arg_45_1.var_.highlightMatValue10016 = var_48_2
				end
			end

			local var_48_3 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_3 and not isNil(var_48_0) then
				local var_48_4 = (arg_45_1.time_ - var_48_1) / var_48_3

				if arg_45_1.var_.highlightMatValue10016 then
					local var_48_5 = Mathf.Lerp(0.5, 1, var_48_4)
					local var_48_6 = arg_45_1.var_.highlightMatValue10016
					local var_48_7 = var_48_6.color

					var_48_7.r = var_48_5
					var_48_7.g = var_48_5
					var_48_7.b = var_48_5
					var_48_6.color = var_48_7
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_3 and arg_45_1.time_ < var_48_1 + var_48_3 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.highlightMatValue10016 then
				local var_48_8 = 1

				var_48_0.transform:SetSiblingIndex(1)

				local var_48_9 = arg_45_1.var_.highlightMatValue10016
				local var_48_10 = var_48_9.color

				var_48_10.r = var_48_8
				var_48_10.g = var_48_8
				var_48_10.b = var_48_8
				var_48_9.color = var_48_10
			end

			local var_48_11 = arg_45_1.actors_["10020"]
			local var_48_12 = 0

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 and not isNil(var_48_11) then
				local var_48_13 = var_48_11:GetComponent("Image")

				if var_48_13 then
					arg_45_1.var_.highlightMatValue10020 = var_48_13
				end
			end

			local var_48_14 = 0.034

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_14 and not isNil(var_48_11) then
				local var_48_15 = (arg_45_1.time_ - var_48_12) / var_48_14

				if arg_45_1.var_.highlightMatValue10020 then
					local var_48_16 = Mathf.Lerp(1, 0.5, var_48_15)
					local var_48_17 = arg_45_1.var_.highlightMatValue10020
					local var_48_18 = var_48_17.color

					var_48_18.r = var_48_16
					var_48_18.g = var_48_16
					var_48_18.b = var_48_16
					var_48_17.color = var_48_18
				end
			end

			if arg_45_1.time_ >= var_48_12 + var_48_14 and arg_45_1.time_ < var_48_12 + var_48_14 + arg_48_0 and not isNil(var_48_11) and arg_45_1.var_.highlightMatValue10020 then
				local var_48_19 = 0.5
				local var_48_20 = arg_45_1.var_.highlightMatValue10020
				local var_48_21 = var_48_20.color

				var_48_21.r = var_48_19
				var_48_21.g = var_48_19
				var_48_21.b = var_48_19
				var_48_20.color = var_48_21
			end

			local var_48_22 = 0
			local var_48_23 = 0.175

			if var_48_22 < arg_45_1.time_ and arg_45_1.time_ <= var_48_22 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_24 = arg_45_1:FormatText(StoryNameCfg[226].name)

				arg_45_1.leftNameTxt_.text = var_48_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_25 = arg_45_1:GetWordFromCfg(114291011)
				local var_48_26 = arg_45_1:FormatText(var_48_25.content)

				arg_45_1.text_.text = var_48_26

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_27 = 7
				local var_48_28 = utf8.len(var_48_26)
				local var_48_29 = var_48_27 <= 0 and var_48_23 or var_48_23 * (var_48_28 / var_48_27)

				if var_48_29 > 0 and var_48_23 < var_48_29 then
					arg_45_1.talkMaxDuration = var_48_29

					if var_48_29 + var_48_22 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_29 + var_48_22
					end
				end

				arg_45_1.text_.text = var_48_26
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291011", "story_v_out_114291.awb") ~= 0 then
					local var_48_30 = manager.audio:GetVoiceLength("story_v_out_114291", "114291011", "story_v_out_114291.awb") / 1000

					if var_48_30 + var_48_22 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_22
					end

					if var_48_25.prefab_name ~= "" and arg_45_1.actors_[var_48_25.prefab_name] ~= nil then
						local var_48_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_25.prefab_name].transform, "story_v_out_114291", "114291011", "story_v_out_114291.awb")

						arg_45_1:RecordAudio("114291011", var_48_31)
						arg_45_1:RecordAudio("114291011", var_48_31)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114291", "114291011", "story_v_out_114291.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114291", "114291011", "story_v_out_114291.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_32 = math.max(var_48_23, arg_45_1.talkMaxDuration)

			if var_48_22 <= arg_45_1.time_ and arg_45_1.time_ < var_48_22 + var_48_32 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_22) / var_48_32

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_22 + var_48_32 and arg_45_1.time_ < var_48_22 + var_48_32 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114291012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114291012
		arg_49_1.duration_ = 17.43

		local var_49_0 = {
			ja = 17.433,
			ko = 16,
			zh = 15.533,
			en = 15.833
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
				arg_49_0:Play114291013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "OM0503"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 2

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.OM0503

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "OM0503" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Color.New(0, 0, 0)

				var_52_19.a = Mathf.Lerp(0, 1, var_52_18)
				arg_49_1.mask_.color = var_52_19
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				local var_52_20 = Color.New(0, 0, 0)

				var_52_20.a = 1
				arg_49_1.mask_.color = var_52_20
			end

			local var_52_21 = 2

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_22 = 2

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_22 then
				local var_52_23 = (arg_49_1.time_ - var_52_21) / var_52_22
				local var_52_24 = Color.New(0, 0, 0)

				var_52_24.a = Mathf.Lerp(1, 0, var_52_23)
				arg_49_1.mask_.color = var_52_24
			end

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				local var_52_25 = Color.New(0, 0, 0)
				local var_52_26 = 0

				arg_49_1.mask_.enabled = false
				var_52_25.a = var_52_26
				arg_49_1.mask_.color = var_52_25
			end

			local var_52_27 = arg_49_1.actors_["10020"]
			local var_52_28 = 1.5

			if var_52_28 < arg_49_1.time_ and arg_49_1.time_ <= var_52_28 + arg_52_0 then
				local var_52_29 = var_52_27:GetComponent("Image")

				if var_52_29 then
					arg_49_1.var_.alphaMatValue10020 = var_52_29
					arg_49_1.var_.alphaOldValue10020 = var_52_29.color.a
				end

				arg_49_1.var_.alphaOldValue10020 = 1
			end

			local var_52_30 = 0.5

			if var_52_28 <= arg_49_1.time_ and arg_49_1.time_ < var_52_28 + var_52_30 then
				local var_52_31 = (arg_49_1.time_ - var_52_28) / var_52_30
				local var_52_32 = Mathf.Lerp(arg_49_1.var_.alphaOldValue10020, 0, var_52_31)

				if arg_49_1.var_.alphaMatValue10020 then
					local var_52_33 = arg_49_1.var_.alphaMatValue10020.color

					var_52_33.a = var_52_32
					arg_49_1.var_.alphaMatValue10020.color = var_52_33
				end
			end

			if arg_49_1.time_ >= var_52_28 + var_52_30 and arg_49_1.time_ < var_52_28 + var_52_30 + arg_52_0 and arg_49_1.var_.alphaMatValue10020 then
				local var_52_34 = arg_49_1.var_.alphaMatValue10020
				local var_52_35 = var_52_34.color

				var_52_35.a = 0
				var_52_34.color = var_52_35
			end

			local var_52_36 = arg_49_1.actors_["10016"]
			local var_52_37 = 1.5

			if var_52_37 < arg_49_1.time_ and arg_49_1.time_ <= var_52_37 + arg_52_0 then
				local var_52_38 = var_52_36:GetComponent("Image")

				if var_52_38 then
					arg_49_1.var_.alphaMatValue10016 = var_52_38
					arg_49_1.var_.alphaOldValue10016 = var_52_38.color.a
				end

				arg_49_1.var_.alphaOldValue10016 = 1
			end

			local var_52_39 = 0.5

			if var_52_37 <= arg_49_1.time_ and arg_49_1.time_ < var_52_37 + var_52_39 then
				local var_52_40 = (arg_49_1.time_ - var_52_37) / var_52_39
				local var_52_41 = Mathf.Lerp(arg_49_1.var_.alphaOldValue10016, 0, var_52_40)

				if arg_49_1.var_.alphaMatValue10016 then
					local var_52_42 = arg_49_1.var_.alphaMatValue10016.color

					var_52_42.a = var_52_41
					arg_49_1.var_.alphaMatValue10016.color = var_52_42
				end
			end

			if arg_49_1.time_ >= var_52_37 + var_52_39 and arg_49_1.time_ < var_52_37 + var_52_39 + arg_52_0 and arg_49_1.var_.alphaMatValue10016 then
				local var_52_43 = arg_49_1.var_.alphaMatValue10016
				local var_52_44 = var_52_43.color

				var_52_44.a = 0
				var_52_43.color = var_52_44
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_45 = 4
			local var_52_46 = 1.075

			if var_52_45 < arg_49_1.time_ and arg_49_1.time_ <= var_52_45 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_47 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_47:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_48 = arg_49_1:FormatText(StoryNameCfg[226].name)

				arg_49_1.leftNameTxt_.text = var_52_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_49 = arg_49_1:GetWordFromCfg(114291012)
				local var_52_50 = arg_49_1:FormatText(var_52_49.content)

				arg_49_1.text_.text = var_52_50

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_51 = 43
				local var_52_52 = utf8.len(var_52_50)
				local var_52_53 = var_52_51 <= 0 and var_52_46 or var_52_46 * (var_52_52 / var_52_51)

				if var_52_53 > 0 and var_52_46 < var_52_53 then
					arg_49_1.talkMaxDuration = var_52_53
					var_52_45 = var_52_45 + 0.3

					if var_52_53 + var_52_45 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_53 + var_52_45
					end
				end

				arg_49_1.text_.text = var_52_50
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291012", "story_v_out_114291.awb") ~= 0 then
					local var_52_54 = manager.audio:GetVoiceLength("story_v_out_114291", "114291012", "story_v_out_114291.awb") / 1000

					if var_52_54 + var_52_45 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_54 + var_52_45
					end

					if var_52_49.prefab_name ~= "" and arg_49_1.actors_[var_52_49.prefab_name] ~= nil then
						local var_52_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_49.prefab_name].transform, "story_v_out_114291", "114291012", "story_v_out_114291.awb")

						arg_49_1:RecordAudio("114291012", var_52_55)
						arg_49_1:RecordAudio("114291012", var_52_55)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114291", "114291012", "story_v_out_114291.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114291", "114291012", "story_v_out_114291.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_56 = var_52_45 + 0.3
			local var_52_57 = math.max(var_52_46, arg_49_1.talkMaxDuration)

			if var_52_56 <= arg_49_1.time_ and arg_49_1.time_ < var_52_56 + var_52_57 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_56) / var_52_57

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_56 + var_52_57 and arg_49_1.time_ < var_52_56 + var_52_57 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114291013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 114291013
		arg_55_1.duration_ = 19.7

		local var_55_0 = {
			ja = 16.1,
			ko = 18.333,
			zh = 19.7,
			en = 18.433
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
				arg_55_0:Play114291014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.575

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[226].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(114291013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 63
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291013", "story_v_out_114291.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291013", "story_v_out_114291.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_114291", "114291013", "story_v_out_114291.awb")

						arg_55_1:RecordAudio("114291013", var_58_9)
						arg_55_1:RecordAudio("114291013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_114291", "114291013", "story_v_out_114291.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_114291", "114291013", "story_v_out_114291.awb")
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
	Play114291014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 114291014
		arg_59_1.duration_ = 22.9

		local var_59_0 = {
			ja = 22.9,
			ko = 16.6,
			zh = 18.733,
			en = 19.966
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
				arg_59_0:Play114291015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.825

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[226].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(114291014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 74
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291014", "story_v_out_114291.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291014", "story_v_out_114291.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_114291", "114291014", "story_v_out_114291.awb")

						arg_59_1:RecordAudio("114291014", var_62_9)
						arg_59_1:RecordAudio("114291014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_114291", "114291014", "story_v_out_114291.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_114291", "114291014", "story_v_out_114291.awb")
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
	Play114291015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 114291015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play114291016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.475

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(114291015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 59
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play114291016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 114291016
		arg_67_1.duration_ = 26.2

		local var_67_0 = {
			ja = 26.2,
			ko = 21.9,
			zh = 18.7,
			en = 22.933
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
				arg_67_0:Play114291017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 1.8

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[226].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(114291016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 72
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291016", "story_v_out_114291.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291016", "story_v_out_114291.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_114291", "114291016", "story_v_out_114291.awb")

						arg_67_1:RecordAudio("114291016", var_70_9)
						arg_67_1:RecordAudio("114291016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_114291", "114291016", "story_v_out_114291.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_114291", "114291016", "story_v_out_114291.awb")
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
	Play114291017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 114291017
		arg_71_1.duration_ = 22.27

		local var_71_0 = {
			ja = 22.266,
			ko = 17.7,
			zh = 14.966,
			en = 15.766
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
				arg_71_0:Play114291018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.45

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[226].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(114291017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291017", "story_v_out_114291.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291017", "story_v_out_114291.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_114291", "114291017", "story_v_out_114291.awb")

						arg_71_1:RecordAudio("114291017", var_74_9)
						arg_71_1:RecordAudio("114291017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_114291", "114291017", "story_v_out_114291.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_114291", "114291017", "story_v_out_114291.awb")
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
	Play114291018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114291018
		arg_75_1.duration_ = 16.63

		local var_75_0 = {
			ja = 13.366,
			ko = 14.466,
			zh = 16.466,
			en = 16.633
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
				arg_75_0:Play114291019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.475

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[226].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(114291018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 59
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291018", "story_v_out_114291.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291018", "story_v_out_114291.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_114291", "114291018", "story_v_out_114291.awb")

						arg_75_1:RecordAudio("114291018", var_78_9)
						arg_75_1:RecordAudio("114291018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_114291", "114291018", "story_v_out_114291.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_114291", "114291018", "story_v_out_114291.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play114291019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114291019
		arg_79_1.duration_ = 8.1

		local var_79_0 = {
			ja = 8.1,
			ko = 7.733,
			zh = 6.5,
			en = 7.566
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
				arg_79_0:Play114291020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.675

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[36].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(114291019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291019", "story_v_out_114291.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291019", "story_v_out_114291.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_114291", "114291019", "story_v_out_114291.awb")

						arg_79_1:RecordAudio("114291019", var_82_9)
						arg_79_1:RecordAudio("114291019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114291", "114291019", "story_v_out_114291.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114291", "114291019", "story_v_out_114291.awb")
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
	Play114291020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114291020
		arg_83_1.duration_ = 8.27

		local var_83_0 = {
			ja = 8.266,
			ko = 6.933,
			zh = 7.1,
			en = 7.133
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
				arg_83_0:Play114291021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.525

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[226].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(114291020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291020", "story_v_out_114291.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291020", "story_v_out_114291.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_114291", "114291020", "story_v_out_114291.awb")

						arg_83_1:RecordAudio("114291020", var_86_9)
						arg_83_1:RecordAudio("114291020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_114291", "114291020", "story_v_out_114291.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_114291", "114291020", "story_v_out_114291.awb")
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
	Play114291021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114291021
		arg_87_1.duration_ = 24

		local var_87_0 = {
			ja = 24,
			ko = 11.6,
			zh = 16.4,
			en = 17.833
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
				arg_87_0:Play114291022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.325

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[226].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(114291021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291021", "story_v_out_114291.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291021", "story_v_out_114291.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_114291", "114291021", "story_v_out_114291.awb")

						arg_87_1:RecordAudio("114291021", var_90_9)
						arg_87_1:RecordAudio("114291021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114291", "114291021", "story_v_out_114291.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114291", "114291021", "story_v_out_114291.awb")
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
	Play114291022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114291022
		arg_91_1.duration_ = 19.17

		local var_91_0 = {
			ja = 19.166,
			ko = 14.7,
			zh = 19.1,
			en = 14.766
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
				arg_91_0:Play114291023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.125

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[226].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(114291022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291022", "story_v_out_114291.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291022", "story_v_out_114291.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_114291", "114291022", "story_v_out_114291.awb")

						arg_91_1:RecordAudio("114291022", var_94_9)
						arg_91_1:RecordAudio("114291022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114291", "114291022", "story_v_out_114291.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114291", "114291022", "story_v_out_114291.awb")
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
	Play114291023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114291023
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114291024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 2

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				local var_98_1 = manager.ui.mainCamera.transform.localPosition
				local var_98_2 = Vector3.New(0, 0, 10) + Vector3.New(var_98_1.x, var_98_1.y, 0)
				local var_98_3 = arg_95_1.bgs_.ST26

				var_98_3.transform.localPosition = var_98_2
				var_98_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_4 = var_98_3:GetComponent("SpriteRenderer")

				if var_98_4 and var_98_4.sprite then
					local var_98_5 = (var_98_3.transform.localPosition - var_98_1).z
					local var_98_6 = manager.ui.mainCameraCom_
					local var_98_7 = 2 * var_98_5 * Mathf.Tan(var_98_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_8 = var_98_7 * var_98_6.aspect
					local var_98_9 = var_98_4.sprite.bounds.size.x
					local var_98_10 = var_98_4.sprite.bounds.size.y
					local var_98_11 = var_98_8 / var_98_9
					local var_98_12 = var_98_7 / var_98_10
					local var_98_13 = var_98_12 < var_98_11 and var_98_11 or var_98_12

					var_98_3.transform.localScale = Vector3.New(var_98_13, var_98_13, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST26" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_15 = 2

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_15 then
				local var_98_16 = (arg_95_1.time_ - var_98_14) / var_98_15
				local var_98_17 = Color.New(0, 0, 0)

				var_98_17.a = Mathf.Lerp(0, 1, var_98_16)
				arg_95_1.mask_.color = var_98_17
			end

			if arg_95_1.time_ >= var_98_14 + var_98_15 and arg_95_1.time_ < var_98_14 + var_98_15 + arg_98_0 then
				local var_98_18 = Color.New(0, 0, 0)

				var_98_18.a = 1
				arg_95_1.mask_.color = var_98_18
			end

			local var_98_19 = 2

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_20 = 2

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_20 then
				local var_98_21 = (arg_95_1.time_ - var_98_19) / var_98_20
				local var_98_22 = Color.New(0, 0, 0)

				var_98_22.a = Mathf.Lerp(1, 0, var_98_21)
				arg_95_1.mask_.color = var_98_22
			end

			if arg_95_1.time_ >= var_98_19 + var_98_20 and arg_95_1.time_ < var_98_19 + var_98_20 + arg_98_0 then
				local var_98_23 = Color.New(0, 0, 0)
				local var_98_24 = 0

				arg_95_1.mask_.enabled = false
				var_98_23.a = var_98_24
				arg_95_1.mask_.color = var_98_23
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_25 = 4
			local var_98_26 = 0.05

			if var_98_25 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_27 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_27:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_28 = arg_95_1:GetWordFromCfg(114291023)
				local var_98_29 = arg_95_1:FormatText(var_98_28.content)

				arg_95_1.text_.text = var_98_29

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_30 = 2
				local var_98_31 = utf8.len(var_98_29)
				local var_98_32 = var_98_30 <= 0 and var_98_26 or var_98_26 * (var_98_31 / var_98_30)

				if var_98_32 > 0 and var_98_26 < var_98_32 then
					arg_95_1.talkMaxDuration = var_98_32
					var_98_25 = var_98_25 + 0.3

					if var_98_32 + var_98_25 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_32 + var_98_25
					end
				end

				arg_95_1.text_.text = var_98_29
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_33 = var_98_25 + 0.3
			local var_98_34 = math.max(var_98_26, arg_95_1.talkMaxDuration)

			if var_98_33 <= arg_95_1.time_ and arg_95_1.time_ < var_98_33 + var_98_34 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_33) / var_98_34

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_33 + var_98_34 and arg_95_1.time_ < var_98_33 + var_98_34 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114291024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114291024
		arg_101_1.duration_ = 1.63

		local var_101_0 = {
			ja = 1.633,
			ko = 1.566,
			zh = 1.066,
			en = 1.333
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114291025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "10015"

			if arg_101_1.actors_[var_104_0] == nil then
				local var_104_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_104_1) then
					local var_104_2 = Object.Instantiate(var_104_1, arg_101_1.canvasGo_.transform)

					var_104_2.transform:SetSiblingIndex(1)

					var_104_2.name = var_104_0
					var_104_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_[var_104_0] = var_104_2

					local var_104_3 = var_104_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs(var_104_3) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_4 = arg_101_1.actors_["10015"].transform
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.var_.moveOldPos10015 = var_104_4.localPosition
				var_104_4.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10015", 4)

				local var_104_6 = var_104_4.childCount

				for iter_104_2 = 0, var_104_6 - 1 do
					local var_104_7 = var_104_4:GetChild(iter_104_2)

					if var_104_7.name == "split_1" or not string.find(var_104_7.name, "split") then
						var_104_7.gameObject:SetActive(true)
					else
						var_104_7.gameObject:SetActive(false)
					end
				end
			end

			local var_104_8 = 0.001

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_8 then
				local var_104_9 = (arg_101_1.time_ - var_104_5) / var_104_8
				local var_104_10 = Vector3.New(390, -350, -180)

				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10015, var_104_10, var_104_9)
			end

			if arg_101_1.time_ >= var_104_5 + var_104_8 and arg_101_1.time_ < var_104_5 + var_104_8 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_11 = arg_101_1.actors_["10015"]
			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.actorSpriteComps10015 == nil then
				arg_101_1.var_.actorSpriteComps10015 = var_104_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_13 = 0.034

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_13 and not isNil(var_104_11) then
				local var_104_14 = (arg_101_1.time_ - var_104_12) / var_104_13

				if arg_101_1.var_.actorSpriteComps10015 then
					for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_104_4 then
							if arg_101_1.isInRecall_ then
								local var_104_15 = Mathf.Lerp(iter_104_4.color.r, arg_101_1.hightColor1.r, var_104_14)
								local var_104_16 = Mathf.Lerp(iter_104_4.color.g, arg_101_1.hightColor1.g, var_104_14)
								local var_104_17 = Mathf.Lerp(iter_104_4.color.b, arg_101_1.hightColor1.b, var_104_14)

								iter_104_4.color = Color.New(var_104_15, var_104_16, var_104_17)
							else
								local var_104_18 = Mathf.Lerp(iter_104_4.color.r, 1, var_104_14)

								iter_104_4.color = Color.New(var_104_18, var_104_18, var_104_18)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_12 + var_104_13 and arg_101_1.time_ < var_104_12 + var_104_13 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.actorSpriteComps10015 then
				for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_104_6 then
						if arg_101_1.isInRecall_ then
							iter_104_6.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10015 = nil
			end

			local var_104_19 = arg_101_1.actors_["10015"]
			local var_104_20 = 0

			if var_104_20 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 then
				local var_104_21 = var_104_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_104_21 then
					arg_101_1.var_.alphaOldValue10015 = var_104_21.alpha
					arg_101_1.var_.characterEffect10015 = var_104_21
				end

				arg_101_1.var_.alphaOldValue10015 = 0
			end

			local var_104_22 = 0.5

			if var_104_20 <= arg_101_1.time_ and arg_101_1.time_ < var_104_20 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_20) / var_104_22
				local var_104_24 = Mathf.Lerp(arg_101_1.var_.alphaOldValue10015, 1, var_104_23)

				if arg_101_1.var_.characterEffect10015 then
					arg_101_1.var_.characterEffect10015.alpha = var_104_24
				end
			end

			if arg_101_1.time_ >= var_104_20 + var_104_22 and arg_101_1.time_ < var_104_20 + var_104_22 + arg_104_0 and arg_101_1.var_.characterEffect10015 then
				arg_101_1.var_.characterEffect10015.alpha = 1
			end

			local var_104_25 = 0
			local var_104_26 = 0.1

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_27 = arg_101_1:FormatText(StoryNameCfg[208].name)

				arg_101_1.leftNameTxt_.text = var_104_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_28 = arg_101_1:GetWordFromCfg(114291024)
				local var_104_29 = arg_101_1:FormatText(var_104_28.content)

				arg_101_1.text_.text = var_104_29

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_30 = 4
				local var_104_31 = utf8.len(var_104_29)
				local var_104_32 = var_104_30 <= 0 and var_104_26 or var_104_26 * (var_104_31 / var_104_30)

				if var_104_32 > 0 and var_104_26 < var_104_32 then
					arg_101_1.talkMaxDuration = var_104_32

					if var_104_32 + var_104_25 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_32 + var_104_25
					end
				end

				arg_101_1.text_.text = var_104_29
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291024", "story_v_out_114291.awb") ~= 0 then
					local var_104_33 = manager.audio:GetVoiceLength("story_v_out_114291", "114291024", "story_v_out_114291.awb") / 1000

					if var_104_33 + var_104_25 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_33 + var_104_25
					end

					if var_104_28.prefab_name ~= "" and arg_101_1.actors_[var_104_28.prefab_name] ~= nil then
						local var_104_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_28.prefab_name].transform, "story_v_out_114291", "114291024", "story_v_out_114291.awb")

						arg_101_1:RecordAudio("114291024", var_104_34)
						arg_101_1:RecordAudio("114291024", var_104_34)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114291", "114291024", "story_v_out_114291.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114291", "114291024", "story_v_out_114291.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_35 = math.max(var_104_26, arg_101_1.talkMaxDuration)

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_35 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_25) / var_104_35

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_25 + var_104_35 and arg_101_1.time_ < var_104_25 + var_104_35 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114291025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114291025
		arg_105_1.duration_ = 7.73

		local var_105_0 = {
			ja = 7.5,
			ko = 7.1,
			zh = 7.733,
			en = 6.8
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play114291026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10016"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10016 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(-390, -350, -180)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10016, var_108_4, var_108_3)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_108_5 = arg_105_1.actors_["10015"]
			local var_108_6 = 0

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10015 == nil then
				arg_105_1.var_.actorSpriteComps10015 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_7 = 0.034

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_7 and not isNil(var_108_5) then
				local var_108_8 = (arg_105_1.time_ - var_108_6) / var_108_7

				if arg_105_1.var_.actorSpriteComps10015 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_9 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, var_108_8)
								local var_108_10 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, var_108_8)
								local var_108_11 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, var_108_8)

								iter_108_1.color = Color.New(var_108_9, var_108_10, var_108_11)
							else
								local var_108_12 = Mathf.Lerp(iter_108_1.color.r, 0.5, var_108_8)

								iter_108_1.color = Color.New(var_108_12, var_108_12, var_108_12)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_6 + var_108_7 and arg_105_1.time_ < var_108_6 + var_108_7 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10015 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10015 = nil
			end

			local var_108_13 = arg_105_1.actors_["10016"]
			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 and not isNil(var_108_13) then
				local var_108_15 = var_108_13:GetComponent("Image")

				if var_108_15 then
					arg_105_1.var_.highlightMatValue10016 = var_108_15
				end
			end

			local var_108_16 = 0.034

			if var_108_14 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_16 and not isNil(var_108_13) then
				local var_108_17 = (arg_105_1.time_ - var_108_14) / var_108_16

				if arg_105_1.var_.highlightMatValue10016 then
					local var_108_18 = Mathf.Lerp(0.5, 1, var_108_17)
					local var_108_19 = arg_105_1.var_.highlightMatValue10016
					local var_108_20 = var_108_19.color

					var_108_20.r = var_108_18
					var_108_20.g = var_108_18
					var_108_20.b = var_108_18
					var_108_19.color = var_108_20
				end
			end

			if arg_105_1.time_ >= var_108_14 + var_108_16 and arg_105_1.time_ < var_108_14 + var_108_16 + arg_108_0 and not isNil(var_108_13) and arg_105_1.var_.highlightMatValue10016 then
				local var_108_21 = 1

				var_108_13.transform:SetSiblingIndex(1)

				local var_108_22 = arg_105_1.var_.highlightMatValue10016
				local var_108_23 = var_108_22.color

				var_108_23.r = var_108_21
				var_108_23.g = var_108_21
				var_108_23.b = var_108_21
				var_108_22.color = var_108_23
			end

			local var_108_24 = arg_105_1.actors_["10016"]
			local var_108_25 = 0

			if var_108_25 < arg_105_1.time_ and arg_105_1.time_ <= var_108_25 + arg_108_0 then
				local var_108_26 = var_108_24:GetComponent("Image")

				if var_108_26 then
					arg_105_1.var_.alphaMatValue10016 = var_108_26
					arg_105_1.var_.alphaOldValue10016 = var_108_26.color.a
				end

				arg_105_1.var_.alphaOldValue10016 = 0
			end

			local var_108_27 = 0.5

			if var_108_25 <= arg_105_1.time_ and arg_105_1.time_ < var_108_25 + var_108_27 then
				local var_108_28 = (arg_105_1.time_ - var_108_25) / var_108_27
				local var_108_29 = Mathf.Lerp(arg_105_1.var_.alphaOldValue10016, 1, var_108_28)

				if arg_105_1.var_.alphaMatValue10016 then
					local var_108_30 = arg_105_1.var_.alphaMatValue10016.color

					var_108_30.a = var_108_29
					arg_105_1.var_.alphaMatValue10016.color = var_108_30
				end
			end

			if arg_105_1.time_ >= var_108_25 + var_108_27 and arg_105_1.time_ < var_108_25 + var_108_27 + arg_108_0 and arg_105_1.var_.alphaMatValue10016 then
				local var_108_31 = arg_105_1.var_.alphaMatValue10016
				local var_108_32 = var_108_31.color

				var_108_32.a = 1
				var_108_31.color = var_108_32
			end

			local var_108_33 = 0
			local var_108_34 = 0.625

			if var_108_33 < arg_105_1.time_ and arg_105_1.time_ <= var_108_33 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_35 = arg_105_1:FormatText(StoryNameCfg[226].name)

				arg_105_1.leftNameTxt_.text = var_108_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_36 = arg_105_1:GetWordFromCfg(114291025)
				local var_108_37 = arg_105_1:FormatText(var_108_36.content)

				arg_105_1.text_.text = var_108_37

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_38 = 25
				local var_108_39 = utf8.len(var_108_37)
				local var_108_40 = var_108_38 <= 0 and var_108_34 or var_108_34 * (var_108_39 / var_108_38)

				if var_108_40 > 0 and var_108_34 < var_108_40 then
					arg_105_1.talkMaxDuration = var_108_40

					if var_108_40 + var_108_33 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_40 + var_108_33
					end
				end

				arg_105_1.text_.text = var_108_37
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291025", "story_v_out_114291.awb") ~= 0 then
					local var_108_41 = manager.audio:GetVoiceLength("story_v_out_114291", "114291025", "story_v_out_114291.awb") / 1000

					if var_108_41 + var_108_33 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_41 + var_108_33
					end

					if var_108_36.prefab_name ~= "" and arg_105_1.actors_[var_108_36.prefab_name] ~= nil then
						local var_108_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_36.prefab_name].transform, "story_v_out_114291", "114291025", "story_v_out_114291.awb")

						arg_105_1:RecordAudio("114291025", var_108_42)
						arg_105_1:RecordAudio("114291025", var_108_42)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114291", "114291025", "story_v_out_114291.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114291", "114291025", "story_v_out_114291.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_43 = math.max(var_108_34, arg_105_1.talkMaxDuration)

			if var_108_33 <= arg_105_1.time_ and arg_105_1.time_ < var_108_33 + var_108_43 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_33) / var_108_43

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_33 + var_108_43 and arg_105_1.time_ < var_108_33 + var_108_43 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play114291026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114291026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114291027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10016"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) then
				local var_112_2 = var_112_0:GetComponent("Image")

				if var_112_2 then
					arg_109_1.var_.highlightMatValue10016 = var_112_2
				end
			end

			local var_112_3 = 0.034

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_3 and not isNil(var_112_0) then
				local var_112_4 = (arg_109_1.time_ - var_112_1) / var_112_3

				if arg_109_1.var_.highlightMatValue10016 then
					local var_112_5 = Mathf.Lerp(1, 0.5, var_112_4)
					local var_112_6 = arg_109_1.var_.highlightMatValue10016
					local var_112_7 = var_112_6.color

					var_112_7.r = var_112_5
					var_112_7.g = var_112_5
					var_112_7.b = var_112_5
					var_112_6.color = var_112_7
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_3 and arg_109_1.time_ < var_112_1 + var_112_3 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.highlightMatValue10016 then
				local var_112_8 = 0.5
				local var_112_9 = arg_109_1.var_.highlightMatValue10016
				local var_112_10 = var_112_9.color

				var_112_10.r = var_112_8
				var_112_10.g = var_112_8
				var_112_10.b = var_112_8
				var_112_9.color = var_112_10
			end

			local var_112_11 = 0
			local var_112_12 = 1.2

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(114291026)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 48
				local var_112_16 = utf8.len(var_112_14)
				local var_112_17 = var_112_15 <= 0 and var_112_12 or var_112_12 * (var_112_16 / var_112_15)

				if var_112_17 > 0 and var_112_12 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17

					if var_112_17 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_18 and arg_109_1.time_ < var_112_11 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114291027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114291027
		arg_113_1.duration_ = 9.93

		local var_113_0 = {
			ja = 5.966,
			ko = 9.933,
			zh = 7.7,
			en = 7.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114291028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10015"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10015 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10015", 4)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_2" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(390, -350, -180)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10015, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_116_7 = arg_113_1.actors_["10015"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10015 == nil then
				arg_113_1.var_.actorSpriteComps10015 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps10015 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10015 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10015 = nil
			end

			local var_116_15 = 0
			local var_116_16 = 0.7

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[208].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(114291027)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 28
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291027", "story_v_out_114291.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_out_114291", "114291027", "story_v_out_114291.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_114291", "114291027", "story_v_out_114291.awb")

						arg_113_1:RecordAudio("114291027", var_116_24)
						arg_113_1:RecordAudio("114291027", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114291", "114291027", "story_v_out_114291.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114291", "114291027", "story_v_out_114291.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_25 and arg_113_1.time_ < var_116_15 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play114291028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114291028
		arg_117_1.duration_ = 14.63

		local var_117_0 = {
			ja = 14.633,
			ko = 9.733,
			zh = 9.9,
			en = 9.4
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114291029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10015"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10015 == nil then
				arg_117_1.var_.actorSpriteComps10015 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.034

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10015 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10015 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10015 = nil
			end

			local var_120_8 = arg_117_1.actors_["10016"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) then
				local var_120_10 = var_120_8:GetComponent("Image")

				if var_120_10 then
					arg_117_1.var_.highlightMatValue10016 = var_120_10
				end
			end

			local var_120_11 = 0.034

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_11 and not isNil(var_120_8) then
				local var_120_12 = (arg_117_1.time_ - var_120_9) / var_120_11

				if arg_117_1.var_.highlightMatValue10016 then
					local var_120_13 = Mathf.Lerp(0.5, 1, var_120_12)
					local var_120_14 = arg_117_1.var_.highlightMatValue10016
					local var_120_15 = var_120_14.color

					var_120_15.r = var_120_13
					var_120_15.g = var_120_13
					var_120_15.b = var_120_13
					var_120_14.color = var_120_15
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_11 and arg_117_1.time_ < var_120_9 + var_120_11 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.highlightMatValue10016 then
				local var_120_16 = 1

				var_120_8.transform:SetSiblingIndex(1)

				local var_120_17 = arg_117_1.var_.highlightMatValue10016
				local var_120_18 = var_120_17.color

				var_120_18.r = var_120_16
				var_120_18.g = var_120_16
				var_120_18.b = var_120_16
				var_120_17.color = var_120_18
			end

			local var_120_19 = 0
			local var_120_20 = 0.875

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_21 = arg_117_1:FormatText(StoryNameCfg[226].name)

				arg_117_1.leftNameTxt_.text = var_120_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_22 = arg_117_1:GetWordFromCfg(114291028)
				local var_120_23 = arg_117_1:FormatText(var_120_22.content)

				arg_117_1.text_.text = var_120_23

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_24 = 35
				local var_120_25 = utf8.len(var_120_23)
				local var_120_26 = var_120_24 <= 0 and var_120_20 or var_120_20 * (var_120_25 / var_120_24)

				if var_120_26 > 0 and var_120_20 < var_120_26 then
					arg_117_1.talkMaxDuration = var_120_26

					if var_120_26 + var_120_19 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_26 + var_120_19
					end
				end

				arg_117_1.text_.text = var_120_23
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291028", "story_v_out_114291.awb") ~= 0 then
					local var_120_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291028", "story_v_out_114291.awb") / 1000

					if var_120_27 + var_120_19 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_19
					end

					if var_120_22.prefab_name ~= "" and arg_117_1.actors_[var_120_22.prefab_name] ~= nil then
						local var_120_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_22.prefab_name].transform, "story_v_out_114291", "114291028", "story_v_out_114291.awb")

						arg_117_1:RecordAudio("114291028", var_120_28)
						arg_117_1:RecordAudio("114291028", var_120_28)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114291", "114291028", "story_v_out_114291.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114291", "114291028", "story_v_out_114291.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_29 = math.max(var_120_20, arg_117_1.talkMaxDuration)

			if var_120_19 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_29 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_19) / var_120_29

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_19 + var_120_29 and arg_117_1.time_ < var_120_19 + var_120_29 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114291029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114291029
		arg_121_1.duration_ = 10.1

		local var_121_0 = {
			ja = 6.8,
			ko = 8.566,
			zh = 10.1,
			en = 7.233
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play114291030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10015"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10015 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10015", 4)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "split_1" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(390, -350, -180)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10015, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_124_7 = arg_121_1.actors_["10015"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10015 == nil then
				arg_121_1.var_.actorSpriteComps10015 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps10015 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								local var_124_11 = Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, var_124_10)
								local var_124_12 = Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, var_124_10)
								local var_124_13 = Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, var_124_10)

								iter_124_2.color = Color.New(var_124_11, var_124_12, var_124_13)
							else
								local var_124_14 = Mathf.Lerp(iter_124_2.color.r, 1, var_124_10)

								iter_124_2.color = Color.New(var_124_14, var_124_14, var_124_14)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10015 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10015 = nil
			end

			local var_124_15 = arg_121_1.actors_["10016"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) then
				local var_124_17 = var_124_15:GetComponent("Image")

				if var_124_17 then
					arg_121_1.var_.highlightMatValue10016 = var_124_17
				end
			end

			local var_124_18 = 0.034

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_18 and not isNil(var_124_15) then
				local var_124_19 = (arg_121_1.time_ - var_124_16) / var_124_18

				if arg_121_1.var_.highlightMatValue10016 then
					local var_124_20 = Mathf.Lerp(1, 0.5, var_124_19)
					local var_124_21 = arg_121_1.var_.highlightMatValue10016
					local var_124_22 = var_124_21.color

					var_124_22.r = var_124_20
					var_124_22.g = var_124_20
					var_124_22.b = var_124_20
					var_124_21.color = var_124_22
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_18 and arg_121_1.time_ < var_124_16 + var_124_18 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.highlightMatValue10016 then
				local var_124_23 = 0.5
				local var_124_24 = arg_121_1.var_.highlightMatValue10016
				local var_124_25 = var_124_24.color

				var_124_25.r = var_124_23
				var_124_25.g = var_124_23
				var_124_25.b = var_124_23
				var_124_24.color = var_124_25
			end

			local var_124_26 = 0
			local var_124_27 = 0.925

			if var_124_26 < arg_121_1.time_ and arg_121_1.time_ <= var_124_26 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_28 = arg_121_1:FormatText(StoryNameCfg[208].name)

				arg_121_1.leftNameTxt_.text = var_124_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_29 = arg_121_1:GetWordFromCfg(114291029)
				local var_124_30 = arg_121_1:FormatText(var_124_29.content)

				arg_121_1.text_.text = var_124_30

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_31 = 37
				local var_124_32 = utf8.len(var_124_30)
				local var_124_33 = var_124_31 <= 0 and var_124_27 or var_124_27 * (var_124_32 / var_124_31)

				if var_124_33 > 0 and var_124_27 < var_124_33 then
					arg_121_1.talkMaxDuration = var_124_33

					if var_124_33 + var_124_26 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_33 + var_124_26
					end
				end

				arg_121_1.text_.text = var_124_30
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291029", "story_v_out_114291.awb") ~= 0 then
					local var_124_34 = manager.audio:GetVoiceLength("story_v_out_114291", "114291029", "story_v_out_114291.awb") / 1000

					if var_124_34 + var_124_26 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_34 + var_124_26
					end

					if var_124_29.prefab_name ~= "" and arg_121_1.actors_[var_124_29.prefab_name] ~= nil then
						local var_124_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_29.prefab_name].transform, "story_v_out_114291", "114291029", "story_v_out_114291.awb")

						arg_121_1:RecordAudio("114291029", var_124_35)
						arg_121_1:RecordAudio("114291029", var_124_35)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114291", "114291029", "story_v_out_114291.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114291", "114291029", "story_v_out_114291.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_36 = math.max(var_124_27, arg_121_1.talkMaxDuration)

			if var_124_26 <= arg_121_1.time_ and arg_121_1.time_ < var_124_26 + var_124_36 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_26) / var_124_36

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_26 + var_124_36 and arg_121_1.time_ < var_124_26 + var_124_36 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play114291030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114291030
		arg_125_1.duration_ = 2.1

		local var_125_0 = {
			ja = 1.633,
			ko = 2.1,
			zh = 1.233,
			en = 1
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114291031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10015"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10015 == nil then
				arg_125_1.var_.actorSpriteComps10015 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.034

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10015 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 0.5, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10015 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10015 = nil
			end

			local var_128_8 = arg_125_1.actors_["10016"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) then
				local var_128_10 = var_128_8:GetComponent("Image")

				if var_128_10 then
					arg_125_1.var_.highlightMatValue10016 = var_128_10
				end
			end

			local var_128_11 = 0.034

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_11 and not isNil(var_128_8) then
				local var_128_12 = (arg_125_1.time_ - var_128_9) / var_128_11

				if arg_125_1.var_.highlightMatValue10016 then
					local var_128_13 = Mathf.Lerp(0.5, 1, var_128_12)
					local var_128_14 = arg_125_1.var_.highlightMatValue10016
					local var_128_15 = var_128_14.color

					var_128_15.r = var_128_13
					var_128_15.g = var_128_13
					var_128_15.b = var_128_13
					var_128_14.color = var_128_15
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_11 and arg_125_1.time_ < var_128_9 + var_128_11 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.highlightMatValue10016 then
				local var_128_16 = 1

				var_128_8.transform:SetSiblingIndex(1)

				local var_128_17 = arg_125_1.var_.highlightMatValue10016
				local var_128_18 = var_128_17.color

				var_128_18.r = var_128_16
				var_128_18.g = var_128_16
				var_128_18.b = var_128_16
				var_128_17.color = var_128_18
			end

			local var_128_19 = 0
			local var_128_20 = 0.075

			if var_128_19 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_21 = arg_125_1:FormatText(StoryNameCfg[226].name)

				arg_125_1.leftNameTxt_.text = var_128_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_22 = arg_125_1:GetWordFromCfg(114291030)
				local var_128_23 = arg_125_1:FormatText(var_128_22.content)

				arg_125_1.text_.text = var_128_23

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_24 = 3
				local var_128_25 = utf8.len(var_128_23)
				local var_128_26 = var_128_24 <= 0 and var_128_20 or var_128_20 * (var_128_25 / var_128_24)

				if var_128_26 > 0 and var_128_20 < var_128_26 then
					arg_125_1.talkMaxDuration = var_128_26

					if var_128_26 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_26 + var_128_19
					end
				end

				arg_125_1.text_.text = var_128_23
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291030", "story_v_out_114291.awb") ~= 0 then
					local var_128_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291030", "story_v_out_114291.awb") / 1000

					if var_128_27 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_27 + var_128_19
					end

					if var_128_22.prefab_name ~= "" and arg_125_1.actors_[var_128_22.prefab_name] ~= nil then
						local var_128_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_22.prefab_name].transform, "story_v_out_114291", "114291030", "story_v_out_114291.awb")

						arg_125_1:RecordAudio("114291030", var_128_28)
						arg_125_1:RecordAudio("114291030", var_128_28)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114291", "114291030", "story_v_out_114291.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114291", "114291030", "story_v_out_114291.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_29 = math.max(var_128_20, arg_125_1.talkMaxDuration)

			if var_128_19 <= arg_125_1.time_ and arg_125_1.time_ < var_128_19 + var_128_29 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_19) / var_128_29

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_19 + var_128_29 and arg_125_1.time_ < var_128_19 + var_128_29 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114291031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114291031
		arg_129_1.duration_ = 3.73

		local var_129_0 = {
			ja = 3.733,
			ko = 3.2,
			zh = 3.333,
			en = 1.866
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
				arg_129_0:Play114291032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10015"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10015 == nil then
				arg_129_1.var_.actorSpriteComps10015 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.034

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10015 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10015 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10015 = nil
			end

			local var_132_8 = arg_129_1.actors_["10016"]
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 and not isNil(var_132_8) then
				local var_132_10 = var_132_8:GetComponent("Image")

				if var_132_10 then
					arg_129_1.var_.highlightMatValue10016 = var_132_10
				end
			end

			local var_132_11 = 0.034

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_11 and not isNil(var_132_8) then
				local var_132_12 = (arg_129_1.time_ - var_132_9) / var_132_11

				if arg_129_1.var_.highlightMatValue10016 then
					local var_132_13 = Mathf.Lerp(1, 0.5, var_132_12)
					local var_132_14 = arg_129_1.var_.highlightMatValue10016
					local var_132_15 = var_132_14.color

					var_132_15.r = var_132_13
					var_132_15.g = var_132_13
					var_132_15.b = var_132_13
					var_132_14.color = var_132_15
				end
			end

			if arg_129_1.time_ >= var_132_9 + var_132_11 and arg_129_1.time_ < var_132_9 + var_132_11 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.highlightMatValue10016 then
				local var_132_16 = 0.5
				local var_132_17 = arg_129_1.var_.highlightMatValue10016
				local var_132_18 = var_132_17.color

				var_132_18.r = var_132_16
				var_132_18.g = var_132_16
				var_132_18.b = var_132_16
				var_132_17.color = var_132_18
			end

			local var_132_19 = 0
			local var_132_20 = 0.25

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_21 = arg_129_1:FormatText(StoryNameCfg[208].name)

				arg_129_1.leftNameTxt_.text = var_132_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_22 = arg_129_1:GetWordFromCfg(114291031)
				local var_132_23 = arg_129_1:FormatText(var_132_22.content)

				arg_129_1.text_.text = var_132_23

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_24 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291031", "story_v_out_114291.awb") ~= 0 then
					local var_132_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291031", "story_v_out_114291.awb") / 1000

					if var_132_27 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_27 + var_132_19
					end

					if var_132_22.prefab_name ~= "" and arg_129_1.actors_[var_132_22.prefab_name] ~= nil then
						local var_132_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_22.prefab_name].transform, "story_v_out_114291", "114291031", "story_v_out_114291.awb")

						arg_129_1:RecordAudio("114291031", var_132_28)
						arg_129_1:RecordAudio("114291031", var_132_28)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114291", "114291031", "story_v_out_114291.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114291", "114291031", "story_v_out_114291.awb")
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

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114291032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114291032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114291033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10015"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10015 == nil then
				arg_133_1.var_.actorSpriteComps10015 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.034

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10015 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10015 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10015 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.8

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(114291032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_12 = 32
				local var_136_13 = utf8.len(var_136_11)
				local var_136_14 = var_136_12 <= 0 and var_136_9 or var_136_9 * (var_136_13 / var_136_12)

				if var_136_14 > 0 and var_136_9 < var_136_14 then
					arg_133_1.talkMaxDuration = var_136_14

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_15 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_15 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_15

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_15 and arg_133_1.time_ < var_136_8 + var_136_15 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114291033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114291033
		arg_137_1.duration_ = 4.1

		local var_137_0 = {
			ja = 4.1,
			ko = 3,
			zh = 2.133,
			en = 2.933
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
				arg_137_0:Play114291034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10015"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10015 == nil then
				arg_137_1.var_.actorSpriteComps10015 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.034

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10015 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10015 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10015 = nil
			end

			local var_140_8 = arg_137_1.actors_["10015"].transform
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.var_.moveOldPos10015 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10015", 4)

				local var_140_10 = var_140_8.childCount

				for iter_140_4 = 0, var_140_10 - 1 do
					local var_140_11 = var_140_8:GetChild(iter_140_4)

					if var_140_11.name == "split_5" or not string.find(var_140_11.name, "split") then
						var_140_11.gameObject:SetActive(true)
					else
						var_140_11.gameObject:SetActive(false)
					end
				end
			end

			local var_140_12 = 0.001

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_9) / var_140_12
				local var_140_14 = Vector3.New(390, -350, -180)

				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10015, var_140_14, var_140_13)
			end

			if arg_137_1.time_ >= var_140_9 + var_140_12 and arg_137_1.time_ < var_140_9 + var_140_12 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_140_15 = 0
			local var_140_16 = 0.2

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[208].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(114291033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 8
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291033", "story_v_out_114291.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_114291", "114291033", "story_v_out_114291.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_114291", "114291033", "story_v_out_114291.awb")

						arg_137_1:RecordAudio("114291033", var_140_24)
						arg_137_1:RecordAudio("114291033", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114291", "114291033", "story_v_out_114291.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114291", "114291033", "story_v_out_114291.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play114291034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114291034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114291035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10015"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10015 == nil then
				arg_141_1.var_.actorSpriteComps10015 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.034

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10015 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10015 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10015 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 1.85

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(114291034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 74
				local var_144_13 = utf8.len(var_144_11)
				local var_144_14 = var_144_12 <= 0 and var_144_9 or var_144_9 * (var_144_13 / var_144_12)

				if var_144_14 > 0 and var_144_9 < var_144_14 then
					arg_141_1.talkMaxDuration = var_144_14

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_15 and arg_141_1.time_ < var_144_8 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114291035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114291035
		arg_145_1.duration_ = 14.33

		local var_145_0 = {
			ja = 14.333,
			ko = 11.033,
			zh = 10.033,
			en = 9.9
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
				arg_145_0:Play114291036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10015"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10015 == nil then
				arg_145_1.var_.actorSpriteComps10015 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.034

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10015 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10015 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10015 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 1.15

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_10 = arg_145_1:FormatText(StoryNameCfg[208].name)

				arg_145_1.leftNameTxt_.text = var_148_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(114291035)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291035", "story_v_out_114291.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_114291", "114291035", "story_v_out_114291.awb") / 1000

					if var_148_16 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_8
					end

					if var_148_11.prefab_name ~= "" and arg_145_1.actors_[var_148_11.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_11.prefab_name].transform, "story_v_out_114291", "114291035", "story_v_out_114291.awb")

						arg_145_1:RecordAudio("114291035", var_148_17)
						arg_145_1:RecordAudio("114291035", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_114291", "114291035", "story_v_out_114291.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_114291", "114291035", "story_v_out_114291.awb")
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
	Play114291036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114291036
		arg_149_1.duration_ = 9.97

		local var_149_0 = {
			ja = 8.133,
			ko = 5.333,
			zh = 9.966,
			en = 7.333
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
				arg_149_0:Play114291037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10015"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10015 == nil then
				arg_149_1.var_.actorSpriteComps10015 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.034

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10015 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10015 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10015 = nil
			end

			local var_152_8 = arg_149_1.actors_["10016"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) then
				local var_152_10 = var_152_8:GetComponent("Image")

				if var_152_10 then
					arg_149_1.var_.highlightMatValue10016 = var_152_10
				end
			end

			local var_152_11 = 0.034

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_11 and not isNil(var_152_8) then
				local var_152_12 = (arg_149_1.time_ - var_152_9) / var_152_11

				if arg_149_1.var_.highlightMatValue10016 then
					local var_152_13 = Mathf.Lerp(0.5, 1, var_152_12)
					local var_152_14 = arg_149_1.var_.highlightMatValue10016
					local var_152_15 = var_152_14.color

					var_152_15.r = var_152_13
					var_152_15.g = var_152_13
					var_152_15.b = var_152_13
					var_152_14.color = var_152_15
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_11 and arg_149_1.time_ < var_152_9 + var_152_11 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.highlightMatValue10016 then
				local var_152_16 = 1

				var_152_8.transform:SetSiblingIndex(1)

				local var_152_17 = arg_149_1.var_.highlightMatValue10016
				local var_152_18 = var_152_17.color

				var_152_18.r = var_152_16
				var_152_18.g = var_152_16
				var_152_18.b = var_152_16
				var_152_17.color = var_152_18
			end

			local var_152_19 = 0
			local var_152_20 = 0.625

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_21 = arg_149_1:FormatText(StoryNameCfg[226].name)

				arg_149_1.leftNameTxt_.text = var_152_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_22 = arg_149_1:GetWordFromCfg(114291036)
				local var_152_23 = arg_149_1:FormatText(var_152_22.content)

				arg_149_1.text_.text = var_152_23

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_24 = 25
				local var_152_25 = utf8.len(var_152_23)
				local var_152_26 = var_152_24 <= 0 and var_152_20 or var_152_20 * (var_152_25 / var_152_24)

				if var_152_26 > 0 and var_152_20 < var_152_26 then
					arg_149_1.talkMaxDuration = var_152_26

					if var_152_26 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_26 + var_152_19
					end
				end

				arg_149_1.text_.text = var_152_23
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291036", "story_v_out_114291.awb") ~= 0 then
					local var_152_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291036", "story_v_out_114291.awb") / 1000

					if var_152_27 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_27 + var_152_19
					end

					if var_152_22.prefab_name ~= "" and arg_149_1.actors_[var_152_22.prefab_name] ~= nil then
						local var_152_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_22.prefab_name].transform, "story_v_out_114291", "114291036", "story_v_out_114291.awb")

						arg_149_1:RecordAudio("114291036", var_152_28)
						arg_149_1:RecordAudio("114291036", var_152_28)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114291", "114291036", "story_v_out_114291.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114291", "114291036", "story_v_out_114291.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_20, arg_149_1.talkMaxDuration)

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_19) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_19 + var_152_29 and arg_149_1.time_ < var_152_19 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114291037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114291037
		arg_153_1.duration_ = 11.07

		local var_153_0 = {
			ja = 11.066,
			ko = 10.6,
			zh = 10.4,
			en = 10.9
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
				arg_153_0:Play114291038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10015"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10015 == nil then
				arg_153_1.var_.actorSpriteComps10015 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.034

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10015 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10015 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10015 = nil
			end

			local var_156_8 = arg_153_1.actors_["10016"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) then
				local var_156_10 = var_156_8:GetComponent("Image")

				if var_156_10 then
					arg_153_1.var_.highlightMatValue10016 = var_156_10
				end
			end

			local var_156_11 = 0.034

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_11 and not isNil(var_156_8) then
				local var_156_12 = (arg_153_1.time_ - var_156_9) / var_156_11

				if arg_153_1.var_.highlightMatValue10016 then
					local var_156_13 = Mathf.Lerp(1, 0.5, var_156_12)
					local var_156_14 = arg_153_1.var_.highlightMatValue10016
					local var_156_15 = var_156_14.color

					var_156_15.r = var_156_13
					var_156_15.g = var_156_13
					var_156_15.b = var_156_13
					var_156_14.color = var_156_15
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_11 and arg_153_1.time_ < var_156_9 + var_156_11 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.highlightMatValue10016 then
				local var_156_16 = 0.5
				local var_156_17 = arg_153_1.var_.highlightMatValue10016
				local var_156_18 = var_156_17.color

				var_156_18.r = var_156_16
				var_156_18.g = var_156_16
				var_156_18.b = var_156_16
				var_156_17.color = var_156_18
			end

			local var_156_19 = arg_153_1.actors_["10015"].transform
			local var_156_20 = 0

			if var_156_20 < arg_153_1.time_ and arg_153_1.time_ <= var_156_20 + arg_156_0 then
				arg_153_1.var_.moveOldPos10015 = var_156_19.localPosition
				var_156_19.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10015", 4)

				local var_156_21 = var_156_19.childCount

				for iter_156_4 = 0, var_156_21 - 1 do
					local var_156_22 = var_156_19:GetChild(iter_156_4)

					if var_156_22.name == "split_1" or not string.find(var_156_22.name, "split") then
						var_156_22.gameObject:SetActive(true)
					else
						var_156_22.gameObject:SetActive(false)
					end
				end
			end

			local var_156_23 = 0.001

			if var_156_20 <= arg_153_1.time_ and arg_153_1.time_ < var_156_20 + var_156_23 then
				local var_156_24 = (arg_153_1.time_ - var_156_20) / var_156_23
				local var_156_25 = Vector3.New(390, -350, -180)

				var_156_19.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10015, var_156_25, var_156_24)
			end

			if arg_153_1.time_ >= var_156_20 + var_156_23 and arg_153_1.time_ < var_156_20 + var_156_23 + arg_156_0 then
				var_156_19.localPosition = Vector3.New(390, -350, -180)
			end

			local var_156_26 = 0
			local var_156_27 = 1.175

			if var_156_26 < arg_153_1.time_ and arg_153_1.time_ <= var_156_26 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_28 = arg_153_1:FormatText(StoryNameCfg[208].name)

				arg_153_1.leftNameTxt_.text = var_156_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_29 = arg_153_1:GetWordFromCfg(114291037)
				local var_156_30 = arg_153_1:FormatText(var_156_29.content)

				arg_153_1.text_.text = var_156_30

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_31 = 47
				local var_156_32 = utf8.len(var_156_30)
				local var_156_33 = var_156_31 <= 0 and var_156_27 or var_156_27 * (var_156_32 / var_156_31)

				if var_156_33 > 0 and var_156_27 < var_156_33 then
					arg_153_1.talkMaxDuration = var_156_33

					if var_156_33 + var_156_26 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_33 + var_156_26
					end
				end

				arg_153_1.text_.text = var_156_30
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291037", "story_v_out_114291.awb") ~= 0 then
					local var_156_34 = manager.audio:GetVoiceLength("story_v_out_114291", "114291037", "story_v_out_114291.awb") / 1000

					if var_156_34 + var_156_26 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_34 + var_156_26
					end

					if var_156_29.prefab_name ~= "" and arg_153_1.actors_[var_156_29.prefab_name] ~= nil then
						local var_156_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_29.prefab_name].transform, "story_v_out_114291", "114291037", "story_v_out_114291.awb")

						arg_153_1:RecordAudio("114291037", var_156_35)
						arg_153_1:RecordAudio("114291037", var_156_35)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114291", "114291037", "story_v_out_114291.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114291", "114291037", "story_v_out_114291.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_36 = math.max(var_156_27, arg_153_1.talkMaxDuration)

			if var_156_26 <= arg_153_1.time_ and arg_153_1.time_ < var_156_26 + var_156_36 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_26) / var_156_36

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_26 + var_156_36 and arg_153_1.time_ < var_156_26 + var_156_36 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114291038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114291038
		arg_157_1.duration_ = 16.73

		local var_157_0 = {
			ja = 6.566,
			ko = 16.733,
			zh = 12.8,
			en = 11.133
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
				arg_157_0:Play114291039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.425

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[208].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(114291038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 57
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291038", "story_v_out_114291.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291038", "story_v_out_114291.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_114291", "114291038", "story_v_out_114291.awb")

						arg_157_1:RecordAudio("114291038", var_160_9)
						arg_157_1:RecordAudio("114291038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114291", "114291038", "story_v_out_114291.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114291", "114291038", "story_v_out_114291.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play114291039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114291039
		arg_161_1.duration_ = 18.1

		local var_161_0 = {
			ja = 5.3,
			ko = 14.866,
			zh = 18.1,
			en = 13.2
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
				arg_161_0:Play114291040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.9

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[208].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(114291039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 76
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291039", "story_v_out_114291.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291039", "story_v_out_114291.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_114291", "114291039", "story_v_out_114291.awb")

						arg_161_1:RecordAudio("114291039", var_164_9)
						arg_161_1:RecordAudio("114291039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114291", "114291039", "story_v_out_114291.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114291", "114291039", "story_v_out_114291.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114291040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114291040
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			ja = 3.7,
			ko = 3.966,
			zh = 4.3,
			en = 4.2
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
				arg_165_0:Play114291041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10015"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.034

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 0.5, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_8 = arg_165_1.actors_["10016"]
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 and not isNil(var_168_8) then
				local var_168_10 = var_168_8:GetComponent("Image")

				if var_168_10 then
					arg_165_1.var_.highlightMatValue10016 = var_168_10
				end
			end

			local var_168_11 = 0.034

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_11 and not isNil(var_168_8) then
				local var_168_12 = (arg_165_1.time_ - var_168_9) / var_168_11

				if arg_165_1.var_.highlightMatValue10016 then
					local var_168_13 = Mathf.Lerp(0.5, 1, var_168_12)
					local var_168_14 = arg_165_1.var_.highlightMatValue10016
					local var_168_15 = var_168_14.color

					var_168_15.r = var_168_13
					var_168_15.g = var_168_13
					var_168_15.b = var_168_13
					var_168_14.color = var_168_15
				end
			end

			if arg_165_1.time_ >= var_168_9 + var_168_11 and arg_165_1.time_ < var_168_9 + var_168_11 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.highlightMatValue10016 then
				local var_168_16 = 1

				var_168_8.transform:SetSiblingIndex(1)

				local var_168_17 = arg_165_1.var_.highlightMatValue10016
				local var_168_18 = var_168_17.color

				var_168_18.r = var_168_16
				var_168_18.g = var_168_16
				var_168_18.b = var_168_16
				var_168_17.color = var_168_18
			end

			local var_168_19 = 0
			local var_168_20 = 0.3

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_21 = arg_165_1:FormatText(StoryNameCfg[226].name)

				arg_165_1.leftNameTxt_.text = var_168_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_22 = arg_165_1:GetWordFromCfg(114291040)
				local var_168_23 = arg_165_1:FormatText(var_168_22.content)

				arg_165_1.text_.text = var_168_23

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_24 = 12
				local var_168_25 = utf8.len(var_168_23)
				local var_168_26 = var_168_24 <= 0 and var_168_20 or var_168_20 * (var_168_25 / var_168_24)

				if var_168_26 > 0 and var_168_20 < var_168_26 then
					arg_165_1.talkMaxDuration = var_168_26

					if var_168_26 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_26 + var_168_19
					end
				end

				arg_165_1.text_.text = var_168_23
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291040", "story_v_out_114291.awb") ~= 0 then
					local var_168_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291040", "story_v_out_114291.awb") / 1000

					if var_168_27 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_27 + var_168_19
					end

					if var_168_22.prefab_name ~= "" and arg_165_1.actors_[var_168_22.prefab_name] ~= nil then
						local var_168_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_22.prefab_name].transform, "story_v_out_114291", "114291040", "story_v_out_114291.awb")

						arg_165_1:RecordAudio("114291040", var_168_28)
						arg_165_1:RecordAudio("114291040", var_168_28)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114291", "114291040", "story_v_out_114291.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114291", "114291040", "story_v_out_114291.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_29 = math.max(var_168_20, arg_165_1.talkMaxDuration)

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_29 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_19) / var_168_29

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_19 + var_168_29 and arg_165_1.time_ < var_168_19 + var_168_29 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114291041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114291041
		arg_169_1.duration_ = 3.87

		local var_169_0 = {
			ja = 3.7,
			ko = 3.1,
			zh = 3.233,
			en = 3.866
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
				arg_169_0:Play114291042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10015"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10015 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10015", 4)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "split_4" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(390, -350, -180)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10015, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_172_7 = arg_169_1.actors_["10015"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10015 == nil then
				arg_169_1.var_.actorSpriteComps10015 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps10015 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								local var_172_11 = Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, var_172_10)
								local var_172_12 = Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, var_172_10)
								local var_172_13 = Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, var_172_10)

								iter_172_2.color = Color.New(var_172_11, var_172_12, var_172_13)
							else
								local var_172_14 = Mathf.Lerp(iter_172_2.color.r, 1, var_172_10)

								iter_172_2.color = Color.New(var_172_14, var_172_14, var_172_14)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10015 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10015 = nil
			end

			local var_172_15 = arg_169_1.actors_["10016"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) then
				local var_172_17 = var_172_15:GetComponent("Image")

				if var_172_17 then
					arg_169_1.var_.highlightMatValue10016 = var_172_17
				end
			end

			local var_172_18 = 0.034

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_18 and not isNil(var_172_15) then
				local var_172_19 = (arg_169_1.time_ - var_172_16) / var_172_18

				if arg_169_1.var_.highlightMatValue10016 then
					local var_172_20 = Mathf.Lerp(1, 0.5, var_172_19)
					local var_172_21 = arg_169_1.var_.highlightMatValue10016
					local var_172_22 = var_172_21.color

					var_172_22.r = var_172_20
					var_172_22.g = var_172_20
					var_172_22.b = var_172_20
					var_172_21.color = var_172_22
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_18 and arg_169_1.time_ < var_172_16 + var_172_18 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.highlightMatValue10016 then
				local var_172_23 = 0.5
				local var_172_24 = arg_169_1.var_.highlightMatValue10016
				local var_172_25 = var_172_24.color

				var_172_25.r = var_172_23
				var_172_25.g = var_172_23
				var_172_25.b = var_172_23
				var_172_24.color = var_172_25
			end

			local var_172_26 = 0
			local var_172_27 = 0.35

			if var_172_26 < arg_169_1.time_ and arg_169_1.time_ <= var_172_26 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_28 = arg_169_1:FormatText(StoryNameCfg[208].name)

				arg_169_1.leftNameTxt_.text = var_172_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_29 = arg_169_1:GetWordFromCfg(114291041)
				local var_172_30 = arg_169_1:FormatText(var_172_29.content)

				arg_169_1.text_.text = var_172_30

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_31 = 14
				local var_172_32 = utf8.len(var_172_30)
				local var_172_33 = var_172_31 <= 0 and var_172_27 or var_172_27 * (var_172_32 / var_172_31)

				if var_172_33 > 0 and var_172_27 < var_172_33 then
					arg_169_1.talkMaxDuration = var_172_33

					if var_172_33 + var_172_26 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_33 + var_172_26
					end
				end

				arg_169_1.text_.text = var_172_30
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291041", "story_v_out_114291.awb") ~= 0 then
					local var_172_34 = manager.audio:GetVoiceLength("story_v_out_114291", "114291041", "story_v_out_114291.awb") / 1000

					if var_172_34 + var_172_26 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_34 + var_172_26
					end

					if var_172_29.prefab_name ~= "" and arg_169_1.actors_[var_172_29.prefab_name] ~= nil then
						local var_172_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_29.prefab_name].transform, "story_v_out_114291", "114291041", "story_v_out_114291.awb")

						arg_169_1:RecordAudio("114291041", var_172_35)
						arg_169_1:RecordAudio("114291041", var_172_35)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114291", "114291041", "story_v_out_114291.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114291", "114291041", "story_v_out_114291.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_36 = math.max(var_172_27, arg_169_1.talkMaxDuration)

			if var_172_26 <= arg_169_1.time_ and arg_169_1.time_ < var_172_26 + var_172_36 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_26) / var_172_36

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_26 + var_172_36 and arg_169_1.time_ < var_172_26 + var_172_36 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play114291042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114291042
		arg_173_1.duration_ = 3.23

		local var_173_0 = {
			ja = 3.233,
			ko = 1.5,
			zh = 1.433,
			en = 2.533
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114291043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10015"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10015 == nil then
				arg_173_1.var_.actorSpriteComps10015 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.034

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10015 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 0.5, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10015 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10015 = nil
			end

			local var_176_8 = arg_173_1.actors_["10016"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) then
				local var_176_10 = var_176_8:GetComponent("Image")

				if var_176_10 then
					arg_173_1.var_.highlightMatValue10016 = var_176_10
				end
			end

			local var_176_11 = 0.034

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_11 and not isNil(var_176_8) then
				local var_176_12 = (arg_173_1.time_ - var_176_9) / var_176_11

				if arg_173_1.var_.highlightMatValue10016 then
					local var_176_13 = Mathf.Lerp(0.5, 1, var_176_12)
					local var_176_14 = arg_173_1.var_.highlightMatValue10016
					local var_176_15 = var_176_14.color

					var_176_15.r = var_176_13
					var_176_15.g = var_176_13
					var_176_15.b = var_176_13
					var_176_14.color = var_176_15
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_11 and arg_173_1.time_ < var_176_9 + var_176_11 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.highlightMatValue10016 then
				local var_176_16 = 1

				var_176_8.transform:SetSiblingIndex(1)

				local var_176_17 = arg_173_1.var_.highlightMatValue10016
				local var_176_18 = var_176_17.color

				var_176_18.r = var_176_16
				var_176_18.g = var_176_16
				var_176_18.b = var_176_16
				var_176_17.color = var_176_18
			end

			local var_176_19 = 0
			local var_176_20 = 0.15

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_21 = arg_173_1:FormatText(StoryNameCfg[226].name)

				arg_173_1.leftNameTxt_.text = var_176_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_22 = arg_173_1:GetWordFromCfg(114291042)
				local var_176_23 = arg_173_1:FormatText(var_176_22.content)

				arg_173_1.text_.text = var_176_23

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_24 = 6
				local var_176_25 = utf8.len(var_176_23)
				local var_176_26 = var_176_24 <= 0 and var_176_20 or var_176_20 * (var_176_25 / var_176_24)

				if var_176_26 > 0 and var_176_20 < var_176_26 then
					arg_173_1.talkMaxDuration = var_176_26

					if var_176_26 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_26 + var_176_19
					end
				end

				arg_173_1.text_.text = var_176_23
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291042", "story_v_out_114291.awb") ~= 0 then
					local var_176_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291042", "story_v_out_114291.awb") / 1000

					if var_176_27 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_27 + var_176_19
					end

					if var_176_22.prefab_name ~= "" and arg_173_1.actors_[var_176_22.prefab_name] ~= nil then
						local var_176_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_22.prefab_name].transform, "story_v_out_114291", "114291042", "story_v_out_114291.awb")

						arg_173_1:RecordAudio("114291042", var_176_28)
						arg_173_1:RecordAudio("114291042", var_176_28)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114291", "114291042", "story_v_out_114291.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114291", "114291042", "story_v_out_114291.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_29 = math.max(var_176_20, arg_173_1.talkMaxDuration)

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_29 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_19) / var_176_29

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_19 + var_176_29 and arg_173_1.time_ < var_176_19 + var_176_29 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114291043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114291043
		arg_177_1.duration_ = 10.13

		local var_177_0 = {
			ja = 7.233,
			ko = 9.066,
			zh = 9.066,
			en = 10.133
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114291044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10015"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10015 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10015", 4)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_1" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(390, -350, -180)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10015, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_180_7 = arg_177_1.actors_["10015"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 0.034

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 and not isNil(var_180_7) then
				local var_180_10 = (arg_177_1.time_ - var_180_8) / var_180_9

				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								local var_180_11 = Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, var_180_10)
								local var_180_12 = Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, var_180_10)
								local var_180_13 = Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, var_180_10)

								iter_180_2.color = Color.New(var_180_11, var_180_12, var_180_13)
							else
								local var_180_14 = Mathf.Lerp(iter_180_2.color.r, 1, var_180_10)

								iter_180_2.color = Color.New(var_180_14, var_180_14, var_180_14)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_4 then
						if arg_177_1.isInRecall_ then
							iter_180_4.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_15 = arg_177_1.actors_["10016"]
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 and not isNil(var_180_15) then
				local var_180_17 = var_180_15:GetComponent("Image")

				if var_180_17 then
					arg_177_1.var_.highlightMatValue10016 = var_180_17
				end
			end

			local var_180_18 = 0.034

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_18 and not isNil(var_180_15) then
				local var_180_19 = (arg_177_1.time_ - var_180_16) / var_180_18

				if arg_177_1.var_.highlightMatValue10016 then
					local var_180_20 = Mathf.Lerp(1, 0.5, var_180_19)
					local var_180_21 = arg_177_1.var_.highlightMatValue10016
					local var_180_22 = var_180_21.color

					var_180_22.r = var_180_20
					var_180_22.g = var_180_20
					var_180_22.b = var_180_20
					var_180_21.color = var_180_22
				end
			end

			if arg_177_1.time_ >= var_180_16 + var_180_18 and arg_177_1.time_ < var_180_16 + var_180_18 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.highlightMatValue10016 then
				local var_180_23 = 0.5
				local var_180_24 = arg_177_1.var_.highlightMatValue10016
				local var_180_25 = var_180_24.color

				var_180_25.r = var_180_23
				var_180_25.g = var_180_23
				var_180_25.b = var_180_23
				var_180_24.color = var_180_25
			end

			local var_180_26 = 0
			local var_180_27 = 0.8

			if var_180_26 < arg_177_1.time_ and arg_177_1.time_ <= var_180_26 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_28 = arg_177_1:FormatText(StoryNameCfg[208].name)

				arg_177_1.leftNameTxt_.text = var_180_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_29 = arg_177_1:GetWordFromCfg(114291043)
				local var_180_30 = arg_177_1:FormatText(var_180_29.content)

				arg_177_1.text_.text = var_180_30

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_31 = 32
				local var_180_32 = utf8.len(var_180_30)
				local var_180_33 = var_180_31 <= 0 and var_180_27 or var_180_27 * (var_180_32 / var_180_31)

				if var_180_33 > 0 and var_180_27 < var_180_33 then
					arg_177_1.talkMaxDuration = var_180_33

					if var_180_33 + var_180_26 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_33 + var_180_26
					end
				end

				arg_177_1.text_.text = var_180_30
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291043", "story_v_out_114291.awb") ~= 0 then
					local var_180_34 = manager.audio:GetVoiceLength("story_v_out_114291", "114291043", "story_v_out_114291.awb") / 1000

					if var_180_34 + var_180_26 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_34 + var_180_26
					end

					if var_180_29.prefab_name ~= "" and arg_177_1.actors_[var_180_29.prefab_name] ~= nil then
						local var_180_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_29.prefab_name].transform, "story_v_out_114291", "114291043", "story_v_out_114291.awb")

						arg_177_1:RecordAudio("114291043", var_180_35)
						arg_177_1:RecordAudio("114291043", var_180_35)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114291", "114291043", "story_v_out_114291.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114291", "114291043", "story_v_out_114291.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_36 = math.max(var_180_27, arg_177_1.talkMaxDuration)

			if var_180_26 <= arg_177_1.time_ and arg_177_1.time_ < var_180_26 + var_180_36 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_26) / var_180_36

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_26 + var_180_36 and arg_177_1.time_ < var_180_26 + var_180_36 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114291044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114291044
		arg_181_1.duration_ = 9.73

		local var_181_0 = {
			ja = 9.2,
			ko = 6.1,
			zh = 6.933,
			en = 9.733
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114291045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10015"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10015 == nil then
				arg_181_1.var_.actorSpriteComps10015 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.034

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10015 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10015 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10015 = nil
			end

			local var_184_8 = arg_181_1.actors_["10016"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) then
				local var_184_10 = var_184_8:GetComponent("Image")

				if var_184_10 then
					arg_181_1.var_.highlightMatValue10016 = var_184_10
				end
			end

			local var_184_11 = 0.034

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_11 and not isNil(var_184_8) then
				local var_184_12 = (arg_181_1.time_ - var_184_9) / var_184_11

				if arg_181_1.var_.highlightMatValue10016 then
					local var_184_13 = Mathf.Lerp(0.5, 1, var_184_12)
					local var_184_14 = arg_181_1.var_.highlightMatValue10016
					local var_184_15 = var_184_14.color

					var_184_15.r = var_184_13
					var_184_15.g = var_184_13
					var_184_15.b = var_184_13
					var_184_14.color = var_184_15
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_11 and arg_181_1.time_ < var_184_9 + var_184_11 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.highlightMatValue10016 then
				local var_184_16 = 1

				var_184_8.transform:SetSiblingIndex(1)

				local var_184_17 = arg_181_1.var_.highlightMatValue10016
				local var_184_18 = var_184_17.color

				var_184_18.r = var_184_16
				var_184_18.g = var_184_16
				var_184_18.b = var_184_16
				var_184_17.color = var_184_18
			end

			local var_184_19 = 0
			local var_184_20 = 0.45

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_21 = arg_181_1:FormatText(StoryNameCfg[226].name)

				arg_181_1.leftNameTxt_.text = var_184_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_22 = arg_181_1:GetWordFromCfg(114291044)
				local var_184_23 = arg_181_1:FormatText(var_184_22.content)

				arg_181_1.text_.text = var_184_23

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_24 = 18
				local var_184_25 = utf8.len(var_184_23)
				local var_184_26 = var_184_24 <= 0 and var_184_20 or var_184_20 * (var_184_25 / var_184_24)

				if var_184_26 > 0 and var_184_20 < var_184_26 then
					arg_181_1.talkMaxDuration = var_184_26

					if var_184_26 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_26 + var_184_19
					end
				end

				arg_181_1.text_.text = var_184_23
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291044", "story_v_out_114291.awb") ~= 0 then
					local var_184_27 = manager.audio:GetVoiceLength("story_v_out_114291", "114291044", "story_v_out_114291.awb") / 1000

					if var_184_27 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_27 + var_184_19
					end

					if var_184_22.prefab_name ~= "" and arg_181_1.actors_[var_184_22.prefab_name] ~= nil then
						local var_184_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_22.prefab_name].transform, "story_v_out_114291", "114291044", "story_v_out_114291.awb")

						arg_181_1:RecordAudio("114291044", var_184_28)
						arg_181_1:RecordAudio("114291044", var_184_28)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114291", "114291044", "story_v_out_114291.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114291", "114291044", "story_v_out_114291.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_29 = math.max(var_184_20, arg_181_1.talkMaxDuration)

			if var_184_19 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_29 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_19) / var_184_29

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_19 + var_184_29 and arg_181_1.time_ < var_184_19 + var_184_29 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114291045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114291045
		arg_185_1.duration_ = 3.27

		local var_185_0 = {
			ja = 3.266,
			ko = 1.8,
			zh = 2.133,
			en = 1.866
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114291046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10015"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10015 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10015", 4)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_2" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(390, -350, -180)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10015, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_188_7 = arg_185_1.actors_["10015"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 1, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_15 = arg_185_1.actors_["10016"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) then
				local var_188_17 = var_188_15:GetComponent("Image")

				if var_188_17 then
					arg_185_1.var_.highlightMatValue10016 = var_188_17
				end
			end

			local var_188_18 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_18 and not isNil(var_188_15) then
				local var_188_19 = (arg_185_1.time_ - var_188_16) / var_188_18

				if arg_185_1.var_.highlightMatValue10016 then
					local var_188_20 = Mathf.Lerp(1, 0.5, var_188_19)
					local var_188_21 = arg_185_1.var_.highlightMatValue10016
					local var_188_22 = var_188_21.color

					var_188_22.r = var_188_20
					var_188_22.g = var_188_20
					var_188_22.b = var_188_20
					var_188_21.color = var_188_22
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_18 and arg_185_1.time_ < var_188_16 + var_188_18 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.highlightMatValue10016 then
				local var_188_23 = 0.5
				local var_188_24 = arg_185_1.var_.highlightMatValue10016
				local var_188_25 = var_188_24.color

				var_188_25.r = var_188_23
				var_188_25.g = var_188_23
				var_188_25.b = var_188_23
				var_188_24.color = var_188_25
			end

			local var_188_26 = 0
			local var_188_27 = 0.225

			if var_188_26 < arg_185_1.time_ and arg_185_1.time_ <= var_188_26 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_28 = arg_185_1:FormatText(StoryNameCfg[208].name)

				arg_185_1.leftNameTxt_.text = var_188_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_29 = arg_185_1:GetWordFromCfg(114291045)
				local var_188_30 = arg_185_1:FormatText(var_188_29.content)

				arg_185_1.text_.text = var_188_30

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_31 = 9
				local var_188_32 = utf8.len(var_188_30)
				local var_188_33 = var_188_31 <= 0 and var_188_27 or var_188_27 * (var_188_32 / var_188_31)

				if var_188_33 > 0 and var_188_27 < var_188_33 then
					arg_185_1.talkMaxDuration = var_188_33

					if var_188_33 + var_188_26 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_33 + var_188_26
					end
				end

				arg_185_1.text_.text = var_188_30
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291045", "story_v_out_114291.awb") ~= 0 then
					local var_188_34 = manager.audio:GetVoiceLength("story_v_out_114291", "114291045", "story_v_out_114291.awb") / 1000

					if var_188_34 + var_188_26 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_34 + var_188_26
					end

					if var_188_29.prefab_name ~= "" and arg_185_1.actors_[var_188_29.prefab_name] ~= nil then
						local var_188_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_29.prefab_name].transform, "story_v_out_114291", "114291045", "story_v_out_114291.awb")

						arg_185_1:RecordAudio("114291045", var_188_35)
						arg_185_1:RecordAudio("114291045", var_188_35)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114291", "114291045", "story_v_out_114291.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114291", "114291045", "story_v_out_114291.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_36 = math.max(var_188_27, arg_185_1.talkMaxDuration)

			if var_188_26 <= arg_185_1.time_ and arg_185_1.time_ < var_188_26 + var_188_36 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_26) / var_188_36

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_26 + var_188_36 and arg_185_1.time_ < var_188_26 + var_188_36 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114291046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114291046
		arg_189_1.duration_ = 4.13

		local var_189_0 = {
			ja = 3.266,
			ko = 1.2,
			zh = 1.433,
			en = 4.133
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114291047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10016"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10016 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10016", 3)
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10016, var_192_4, var_192_3)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_192_5 = arg_189_1.actors_["10016"]
			local var_192_6 = 0

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 and not isNil(var_192_5) then
				local var_192_7 = var_192_5:GetComponent("Image")

				if var_192_7 then
					arg_189_1.var_.highlightMatValue10016 = var_192_7
				end
			end

			local var_192_8 = 0.034

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_8 and not isNil(var_192_5) then
				local var_192_9 = (arg_189_1.time_ - var_192_6) / var_192_8

				if arg_189_1.var_.highlightMatValue10016 then
					local var_192_10 = Mathf.Lerp(0.5, 1, var_192_9)
					local var_192_11 = arg_189_1.var_.highlightMatValue10016
					local var_192_12 = var_192_11.color

					var_192_12.r = var_192_10
					var_192_12.g = var_192_10
					var_192_12.b = var_192_10
					var_192_11.color = var_192_12
				end
			end

			if arg_189_1.time_ >= var_192_6 + var_192_8 and arg_189_1.time_ < var_192_6 + var_192_8 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.highlightMatValue10016 then
				local var_192_13 = 1

				var_192_5.transform:SetSiblingIndex(1)

				local var_192_14 = arg_189_1.var_.highlightMatValue10016
				local var_192_15 = var_192_14.color

				var_192_15.r = var_192_13
				var_192_15.g = var_192_13
				var_192_15.b = var_192_13
				var_192_14.color = var_192_15
			end

			local var_192_16 = arg_189_1.actors_["10015"]
			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 then
				local var_192_18 = var_192_16:GetComponentInChildren(typeof(CanvasGroup))

				if var_192_18 then
					arg_189_1.var_.alphaOldValue10015 = var_192_18.alpha
					arg_189_1.var_.characterEffect10015 = var_192_18
				end

				arg_189_1.var_.alphaOldValue10015 = 1
			end

			local var_192_19 = 0.5

			if var_192_17 <= arg_189_1.time_ and arg_189_1.time_ < var_192_17 + var_192_19 then
				local var_192_20 = (arg_189_1.time_ - var_192_17) / var_192_19
				local var_192_21 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10015, 0, var_192_20)

				if arg_189_1.var_.characterEffect10015 then
					arg_189_1.var_.characterEffect10015.alpha = var_192_21
				end
			end

			if arg_189_1.time_ >= var_192_17 + var_192_19 and arg_189_1.time_ < var_192_17 + var_192_19 + arg_192_0 and arg_189_1.var_.characterEffect10015 then
				arg_189_1.var_.characterEffect10015.alpha = 0
			end

			local var_192_22 = arg_189_1.actors_["10016"]
			local var_192_23 = 0

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				local var_192_24 = var_192_22:GetComponent("Image")

				if var_192_24 then
					arg_189_1.var_.alphaMatValue10016 = var_192_24
					arg_189_1.var_.alphaOldValue10016 = var_192_24.color.a
				end

				arg_189_1.var_.alphaOldValue10016 = 0
			end

			local var_192_25 = 0.5

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_25 then
				local var_192_26 = (arg_189_1.time_ - var_192_23) / var_192_25
				local var_192_27 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10016, 1, var_192_26)

				if arg_189_1.var_.alphaMatValue10016 then
					local var_192_28 = arg_189_1.var_.alphaMatValue10016.color

					var_192_28.a = var_192_27
					arg_189_1.var_.alphaMatValue10016.color = var_192_28
				end
			end

			if arg_189_1.time_ >= var_192_23 + var_192_25 and arg_189_1.time_ < var_192_23 + var_192_25 + arg_192_0 and arg_189_1.var_.alphaMatValue10016 then
				local var_192_29 = arg_189_1.var_.alphaMatValue10016
				local var_192_30 = var_192_29.color

				var_192_30.a = 1
				var_192_29.color = var_192_30
			end

			local var_192_31 = 0
			local var_192_32 = 0.05

			if var_192_31 < arg_189_1.time_ and arg_189_1.time_ <= var_192_31 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_33 = arg_189_1:FormatText(StoryNameCfg[226].name)

				arg_189_1.leftNameTxt_.text = var_192_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_34 = arg_189_1:GetWordFromCfg(114291046)
				local var_192_35 = arg_189_1:FormatText(var_192_34.content)

				arg_189_1.text_.text = var_192_35

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_36 = 2
				local var_192_37 = utf8.len(var_192_35)
				local var_192_38 = var_192_36 <= 0 and var_192_32 or var_192_32 * (var_192_37 / var_192_36)

				if var_192_38 > 0 and var_192_32 < var_192_38 then
					arg_189_1.talkMaxDuration = var_192_38

					if var_192_38 + var_192_31 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_38 + var_192_31
					end
				end

				arg_189_1.text_.text = var_192_35
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291046", "story_v_out_114291.awb") ~= 0 then
					local var_192_39 = manager.audio:GetVoiceLength("story_v_out_114291", "114291046", "story_v_out_114291.awb") / 1000

					if var_192_39 + var_192_31 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_39 + var_192_31
					end

					if var_192_34.prefab_name ~= "" and arg_189_1.actors_[var_192_34.prefab_name] ~= nil then
						local var_192_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_34.prefab_name].transform, "story_v_out_114291", "114291046", "story_v_out_114291.awb")

						arg_189_1:RecordAudio("114291046", var_192_40)
						arg_189_1:RecordAudio("114291046", var_192_40)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114291", "114291046", "story_v_out_114291.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114291", "114291046", "story_v_out_114291.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_41 = math.max(var_192_32, arg_189_1.talkMaxDuration)

			if var_192_31 <= arg_189_1.time_ and arg_189_1.time_ < var_192_31 + var_192_41 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_31) / var_192_41

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_31 + var_192_41 and arg_189_1.time_ < var_192_31 + var_192_41 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114291047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114291047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114291048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10016"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				local var_196_2 = var_196_0:GetComponent("Image")

				if var_196_2 then
					arg_193_1.var_.alphaMatValue10016 = var_196_2
					arg_193_1.var_.alphaOldValue10016 = var_196_2.color.a
				end

				arg_193_1.var_.alphaOldValue10016 = 1
			end

			local var_196_3 = 0.5

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_3 then
				local var_196_4 = (arg_193_1.time_ - var_196_1) / var_196_3
				local var_196_5 = Mathf.Lerp(arg_193_1.var_.alphaOldValue10016, 0, var_196_4)

				if arg_193_1.var_.alphaMatValue10016 then
					local var_196_6 = arg_193_1.var_.alphaMatValue10016.color

					var_196_6.a = var_196_5
					arg_193_1.var_.alphaMatValue10016.color = var_196_6
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_3 and arg_193_1.time_ < var_196_1 + var_196_3 + arg_196_0 and arg_193_1.var_.alphaMatValue10016 then
				local var_196_7 = arg_193_1.var_.alphaMatValue10016
				local var_196_8 = var_196_7.color

				var_196_8.a = 0
				var_196_7.color = var_196_8
			end

			local var_196_9 = 0
			local var_196_10 = 1.125

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_11 = arg_193_1:GetWordFromCfg(114291047)
				local var_196_12 = arg_193_1:FormatText(var_196_11.content)

				arg_193_1.text_.text = var_196_12

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 45
				local var_196_14 = utf8.len(var_196_12)
				local var_196_15 = var_196_13 <= 0 and var_196_10 or var_196_10 * (var_196_14 / var_196_13)

				if var_196_15 > 0 and var_196_10 < var_196_15 then
					arg_193_1.talkMaxDuration = var_196_15

					if var_196_15 + var_196_9 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_15 + var_196_9
					end
				end

				arg_193_1.text_.text = var_196_12
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_10, arg_193_1.talkMaxDuration)

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_9) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_9 + var_196_16 and arg_193_1.time_ < var_196_9 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114291048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114291048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play114291049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.55

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(114291048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 22
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114291049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114291049
		arg_201_1.duration_ = 12.7

		local var_201_0 = {
			ja = 12.7,
			ko = 8.733,
			zh = 6.5,
			en = 6.566
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play114291050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10015"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 4)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_1" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(390, -350, -180)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_7 = arg_201_1.actors_["10016"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos10016 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_204_9 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9
				local var_204_11 = Vector3.New(-390, -350, -180)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10016, var_204_11, var_204_10)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_204_12 = arg_201_1.actors_["10015"]
			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 and not isNil(var_204_12) and arg_201_1.var_.actorSpriteComps10015 == nil then
				arg_201_1.var_.actorSpriteComps10015 = var_204_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_14 = 0.034

			if var_204_13 <= arg_201_1.time_ and arg_201_1.time_ < var_204_13 + var_204_14 and not isNil(var_204_12) then
				local var_204_15 = (arg_201_1.time_ - var_204_13) / var_204_14

				if arg_201_1.var_.actorSpriteComps10015 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								local var_204_16 = Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, var_204_15)
								local var_204_17 = Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, var_204_15)
								local var_204_18 = Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, var_204_15)

								iter_204_2.color = Color.New(var_204_16, var_204_17, var_204_18)
							else
								local var_204_19 = Mathf.Lerp(iter_204_2.color.r, 1, var_204_15)

								iter_204_2.color = Color.New(var_204_19, var_204_19, var_204_19)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_13 + var_204_14 and arg_201_1.time_ < var_204_13 + var_204_14 + arg_204_0 and not isNil(var_204_12) and arg_201_1.var_.actorSpriteComps10015 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10015 = nil
			end

			local var_204_20 = arg_201_1.actors_["10016"]
			local var_204_21 = 0

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 and not isNil(var_204_20) then
				local var_204_22 = var_204_20:GetComponent("Image")

				if var_204_22 then
					arg_201_1.var_.highlightMatValue10016 = var_204_22
				end
			end

			local var_204_23 = 0.034

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_23 and not isNil(var_204_20) then
				local var_204_24 = (arg_201_1.time_ - var_204_21) / var_204_23

				if arg_201_1.var_.highlightMatValue10016 then
					local var_204_25 = Mathf.Lerp(1, 0.5, var_204_24)
					local var_204_26 = arg_201_1.var_.highlightMatValue10016
					local var_204_27 = var_204_26.color

					var_204_27.r = var_204_25
					var_204_27.g = var_204_25
					var_204_27.b = var_204_25
					var_204_26.color = var_204_27
				end
			end

			if arg_201_1.time_ >= var_204_21 + var_204_23 and arg_201_1.time_ < var_204_21 + var_204_23 + arg_204_0 and not isNil(var_204_20) and arg_201_1.var_.highlightMatValue10016 then
				local var_204_28 = 0.5
				local var_204_29 = arg_201_1.var_.highlightMatValue10016
				local var_204_30 = var_204_29.color

				var_204_30.r = var_204_28
				var_204_30.g = var_204_28
				var_204_30.b = var_204_28
				var_204_29.color = var_204_30
			end

			local var_204_31 = arg_201_1.actors_["10015"]
			local var_204_32 = 0

			if var_204_32 < arg_201_1.time_ and arg_201_1.time_ <= var_204_32 + arg_204_0 then
				local var_204_33 = var_204_31:GetComponentInChildren(typeof(CanvasGroup))

				if var_204_33 then
					arg_201_1.var_.alphaOldValue10015 = var_204_33.alpha
					arg_201_1.var_.characterEffect10015 = var_204_33
				end

				arg_201_1.var_.alphaOldValue10015 = 0
			end

			local var_204_34 = 0.5

			if var_204_32 <= arg_201_1.time_ and arg_201_1.time_ < var_204_32 + var_204_34 then
				local var_204_35 = (arg_201_1.time_ - var_204_32) / var_204_34
				local var_204_36 = Mathf.Lerp(arg_201_1.var_.alphaOldValue10015, 1, var_204_35)

				if arg_201_1.var_.characterEffect10015 then
					arg_201_1.var_.characterEffect10015.alpha = var_204_36
				end
			end

			if arg_201_1.time_ >= var_204_32 + var_204_34 and arg_201_1.time_ < var_204_32 + var_204_34 + arg_204_0 and arg_201_1.var_.characterEffect10015 then
				arg_201_1.var_.characterEffect10015.alpha = 1
			end

			local var_204_37 = arg_201_1.actors_["10016"]
			local var_204_38 = 0

			if var_204_38 < arg_201_1.time_ and arg_201_1.time_ <= var_204_38 + arg_204_0 then
				local var_204_39 = var_204_37:GetComponent("Image")

				if var_204_39 then
					arg_201_1.var_.alphaMatValue10016 = var_204_39
					arg_201_1.var_.alphaOldValue10016 = var_204_39.color.a
				end

				arg_201_1.var_.alphaOldValue10016 = 0
			end

			local var_204_40 = 0.5

			if var_204_38 <= arg_201_1.time_ and arg_201_1.time_ < var_204_38 + var_204_40 then
				local var_204_41 = (arg_201_1.time_ - var_204_38) / var_204_40
				local var_204_42 = Mathf.Lerp(arg_201_1.var_.alphaOldValue10016, 1, var_204_41)

				if arg_201_1.var_.alphaMatValue10016 then
					local var_204_43 = arg_201_1.var_.alphaMatValue10016.color

					var_204_43.a = var_204_42
					arg_201_1.var_.alphaMatValue10016.color = var_204_43
				end
			end

			if arg_201_1.time_ >= var_204_38 + var_204_40 and arg_201_1.time_ < var_204_38 + var_204_40 + arg_204_0 and arg_201_1.var_.alphaMatValue10016 then
				local var_204_44 = arg_201_1.var_.alphaMatValue10016
				local var_204_45 = var_204_44.color

				var_204_45.a = 1
				var_204_44.color = var_204_45
			end

			local var_204_46 = 0
			local var_204_47 = 0.7

			if var_204_46 < arg_201_1.time_ and arg_201_1.time_ <= var_204_46 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_48 = arg_201_1:FormatText(StoryNameCfg[208].name)

				arg_201_1.leftNameTxt_.text = var_204_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_49 = arg_201_1:GetWordFromCfg(114291049)
				local var_204_50 = arg_201_1:FormatText(var_204_49.content)

				arg_201_1.text_.text = var_204_50

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_51 = 28
				local var_204_52 = utf8.len(var_204_50)
				local var_204_53 = var_204_51 <= 0 and var_204_47 or var_204_47 * (var_204_52 / var_204_51)

				if var_204_53 > 0 and var_204_47 < var_204_53 then
					arg_201_1.talkMaxDuration = var_204_53

					if var_204_53 + var_204_46 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_53 + var_204_46
					end
				end

				arg_201_1.text_.text = var_204_50
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291049", "story_v_out_114291.awb") ~= 0 then
					local var_204_54 = manager.audio:GetVoiceLength("story_v_out_114291", "114291049", "story_v_out_114291.awb") / 1000

					if var_204_54 + var_204_46 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_54 + var_204_46
					end

					if var_204_49.prefab_name ~= "" and arg_201_1.actors_[var_204_49.prefab_name] ~= nil then
						local var_204_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_49.prefab_name].transform, "story_v_out_114291", "114291049", "story_v_out_114291.awb")

						arg_201_1:RecordAudio("114291049", var_204_55)
						arg_201_1:RecordAudio("114291049", var_204_55)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114291", "114291049", "story_v_out_114291.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114291", "114291049", "story_v_out_114291.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_56 = math.max(var_204_47, arg_201_1.talkMaxDuration)

			if var_204_46 <= arg_201_1.time_ and arg_201_1.time_ < var_204_46 + var_204_56 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_46) / var_204_56

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_46 + var_204_56 and arg_201_1.time_ < var_204_46 + var_204_56 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play114291050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114291050
		arg_205_1.duration_ = 21.43

		local var_205_0 = {
			ja = 17.6,
			ko = 19.266,
			zh = 16.6,
			en = 21.433
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10015"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 4)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_2" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(390, -350, -180)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_208_7 = arg_205_1.actors_["10015"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10015 == nil then
				arg_205_1.var_.actorSpriteComps10015 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps10015 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10015 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10015 = nil
			end

			local var_208_15 = arg_205_1.actors_["10015"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				local var_208_17 = var_208_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_208_17 then
					arg_205_1.var_.alphaOldValue10015 = var_208_17.alpha
					arg_205_1.var_.characterEffect10015 = var_208_17
				end

				arg_205_1.var_.alphaOldValue10015 = 0
			end

			local var_208_18 = 0.0166666666666667

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_18 then
				local var_208_19 = (arg_205_1.time_ - var_208_16) / var_208_18
				local var_208_20 = Mathf.Lerp(arg_205_1.var_.alphaOldValue10015, 1, var_208_19)

				if arg_205_1.var_.characterEffect10015 then
					arg_205_1.var_.characterEffect10015.alpha = var_208_20
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_18 and arg_205_1.time_ < var_208_16 + var_208_18 + arg_208_0 and arg_205_1.var_.characterEffect10015 then
				arg_205_1.var_.characterEffect10015.alpha = 1
			end

			local var_208_21 = 0
			local var_208_22 = 1.575

			if var_208_21 < arg_205_1.time_ and arg_205_1.time_ <= var_208_21 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_23 = arg_205_1:FormatText(StoryNameCfg[208].name)

				arg_205_1.leftNameTxt_.text = var_208_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_24 = arg_205_1:GetWordFromCfg(114291050)
				local var_208_25 = arg_205_1:FormatText(var_208_24.content)

				arg_205_1.text_.text = var_208_25

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_26 = 63
				local var_208_27 = utf8.len(var_208_25)
				local var_208_28 = var_208_26 <= 0 and var_208_22 or var_208_22 * (var_208_27 / var_208_26)

				if var_208_28 > 0 and var_208_22 < var_208_28 then
					arg_205_1.talkMaxDuration = var_208_28

					if var_208_28 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_28 + var_208_21
					end
				end

				arg_205_1.text_.text = var_208_25
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291050", "story_v_out_114291.awb") ~= 0 then
					local var_208_29 = manager.audio:GetVoiceLength("story_v_out_114291", "114291050", "story_v_out_114291.awb") / 1000

					if var_208_29 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_29 + var_208_21
					end

					if var_208_24.prefab_name ~= "" and arg_205_1.actors_[var_208_24.prefab_name] ~= nil then
						local var_208_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_24.prefab_name].transform, "story_v_out_114291", "114291050", "story_v_out_114291.awb")

						arg_205_1:RecordAudio("114291050", var_208_30)
						arg_205_1:RecordAudio("114291050", var_208_30)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_114291", "114291050", "story_v_out_114291.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_114291", "114291050", "story_v_out_114291.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_31 = math.max(var_208_22, arg_205_1.talkMaxDuration)

			if var_208_21 <= arg_205_1.time_ and arg_205_1.time_ < var_208_21 + var_208_31 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_21) / var_208_31

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_21 + var_208_31 and arg_205_1.time_ < var_208_21 + var_208_31 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST26",
		"TextureConfig/Background/OM0503"
	},
	voices = {
		"story_v_out_114291.awb"
	}
}
