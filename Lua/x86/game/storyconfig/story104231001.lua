return {
	Play423101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423101001
		arg_1_1.duration_ = 10.73

		local var_1_0 = {
			zh = 6.3,
			ja = 10.733
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
				arg_1_0:Play423101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25h"

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
				local var_4_5 = arg_1_1.bgs_.I25h

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
					if iter_4_0 ~= "I25h" then
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

			local var_4_24 = "10148"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

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

			local var_4_28 = arg_1_1.actors_["10148"]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 == nil then
				arg_1_1.var_.actorSpriteComps10148 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10148 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10148 = nil
			end

			local var_4_36 = arg_1_1.actors_["10148"].transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10148 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10148", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_1" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -350, -270)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10148, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -350, -270)
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

			local var_4_49 = 0.500666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			local var_4_55 = 0.166666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "effect"

				arg_1_1:AudioAction(var_4_57, var_4_58, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.7

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1331].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(423101001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101001", "story_v_out_423101.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_423101", "423101001", "story_v_out_423101.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_423101", "423101001", "story_v_out_423101.awb")

						arg_1_1:RecordAudio("423101001", var_4_69)
						arg_1_1:RecordAudio("423101001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423101", "423101001", "story_v_out_423101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423101", "423101001", "story_v_out_423101.awb")
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
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423101002
		arg_9_1.duration_ = 13.2

		local var_9_0 = {
			zh = 9.1,
			ja = 13.2
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
				arg_9_0:Play423101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10148"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10148 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10148", 3)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "split_3" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.1

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -350, -270)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10148, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_12_7 = 0
			local var_12_8 = 1.225

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_9 = arg_9_1:FormatText(StoryNameCfg[1331].name)

				arg_9_1.leftNameTxt_.text = var_12_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(423101002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 49
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_8 or var_12_8 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_8 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_7
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101002", "story_v_out_423101.awb") ~= 0 then
					local var_12_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101002", "story_v_out_423101.awb") / 1000

					if var_12_15 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_7
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_423101", "423101002", "story_v_out_423101.awb")

						arg_9_1:RecordAudio("423101002", var_12_16)
						arg_9_1:RecordAudio("423101002", var_12_16)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423101", "423101002", "story_v_out_423101.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423101", "423101002", "story_v_out_423101.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_17 = math.max(var_12_8, arg_9_1.talkMaxDuration)

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_17 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_7) / var_12_17

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_7 + var_12_17 and arg_9_1.time_ < var_12_7 + var_12_17 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play423101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423101003
		arg_13_1.duration_ = 8

		local var_13_0 = {
			zh = 6,
			ja = 8
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
				arg_13_0:Play423101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10148"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10148 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10148", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_1" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -350, -270)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10148, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_16_7 = 0
			local var_16_8 = 0.675

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_9 = arg_13_1:FormatText(StoryNameCfg[1331].name)

				arg_13_1.leftNameTxt_.text = var_16_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(423101003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101003", "story_v_out_423101.awb") ~= 0 then
					local var_16_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101003", "story_v_out_423101.awb") / 1000

					if var_16_15 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_7
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_423101", "423101003", "story_v_out_423101.awb")

						arg_13_1:RecordAudio("423101003", var_16_16)
						arg_13_1:RecordAudio("423101003", var_16_16)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423101", "423101003", "story_v_out_423101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423101", "423101003", "story_v_out_423101.awb")
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
				actorName = "10148",
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
	Play423101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10148"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10148 == nil then
				arg_17_1.var_.actorSpriteComps10148 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10148 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10148 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10148 = nil
			end

			local var_20_8 = arg_17_1.actors_["10148"].transform
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.var_.moveOldPos10148 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10148", 7)

				local var_20_10 = var_20_8.childCount

				for iter_20_4 = 0, var_20_10 - 1 do
					local var_20_11 = var_20_8:GetChild(iter_20_4)

					if var_20_11.name == "" or not string.find(var_20_11.name, "split") then
						var_20_11.gameObject:SetActive(true)
					else
						var_20_11.gameObject:SetActive(false)
					end
				end
			end

			local var_20_12 = 0.001

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_12 then
				local var_20_13 = (arg_17_1.time_ - var_20_9) / var_20_12
				local var_20_14 = Vector3.New(0, -2000, 0)

				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10148, var_20_14, var_20_13)
			end

			if arg_17_1.time_ >= var_20_9 + var_20_12 and arg_17_1.time_ < var_20_9 + var_20_12 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_15 = 0
			local var_20_16 = 1.775

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(423101004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 71
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_16 or var_20_16 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_16 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_22 and arg_17_1.time_ < var_20_15 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play423101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423101005
		arg_21_1.duration_ = 7.87

		local var_21_0 = {
			zh = 7.866,
			ja = 6.8
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
				arg_21_0:Play423101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10148"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10148 == nil then
				arg_21_1.var_.actorSpriteComps10148 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10148 = nil
			end

			local var_24_8 = arg_21_1.actors_["10148"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos10148 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10148", 3)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "split_4" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -350, -270)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10148, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_24_15 = 0
			local var_24_16 = 0.8

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[1331].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(423101005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101005", "story_v_out_423101.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101005", "story_v_out_423101.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_423101", "423101005", "story_v_out_423101.awb")

						arg_21_1:RecordAudio("423101005", var_24_24)
						arg_21_1:RecordAudio("423101005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423101", "423101005", "story_v_out_423101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423101", "423101005", "story_v_out_423101.awb")
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
				actorName = "10148",
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
	Play423101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10148"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10148 == nil then
				arg_25_1.var_.actorSpriteComps10148 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10148 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10148 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10148 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.675

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(423101006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 27
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play423101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.85

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(423101007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 34
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play423101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423101008
		arg_33_1.duration_ = 12.1

		local var_33_0 = {
			zh = 8.066,
			ja = 12.1
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
				arg_33_0:Play423101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10148"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10148 == nil then
				arg_33_1.var_.actorSpriteComps10148 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10148 = nil
			end

			local var_36_8 = arg_33_1.actors_["10148"].transform
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.var_.moveOldPos10148 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10148", 3)

				local var_36_10 = var_36_8.childCount

				for iter_36_4 = 0, var_36_10 - 1 do
					local var_36_11 = var_36_8:GetChild(iter_36_4)

					if var_36_11.name == "" or not string.find(var_36_11.name, "split") then
						var_36_11.gameObject:SetActive(true)
					else
						var_36_11.gameObject:SetActive(false)
					end
				end
			end

			local var_36_12 = 0.001

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_12 then
				local var_36_13 = (arg_33_1.time_ - var_36_9) / var_36_12
				local var_36_14 = Vector3.New(0, -350, -270)

				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10148, var_36_14, var_36_13)
			end

			if arg_33_1.time_ >= var_36_9 + var_36_12 and arg_33_1.time_ < var_36_9 + var_36_12 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_36_15 = 0
			local var_36_16 = 1.05

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[1331].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(423101008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 42
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101008", "story_v_out_423101.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101008", "story_v_out_423101.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_423101", "423101008", "story_v_out_423101.awb")

						arg_33_1:RecordAudio("423101008", var_36_24)
						arg_33_1:RecordAudio("423101008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423101", "423101008", "story_v_out_423101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423101", "423101008", "story_v_out_423101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play423101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423101009
		arg_37_1.duration_ = 6.6

		local var_37_0 = {
			zh = 5.466,
			ja = 6.6
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
				arg_37_0:Play423101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.825

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1331].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(423101009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101009", "story_v_out_423101.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101009", "story_v_out_423101.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_423101", "423101009", "story_v_out_423101.awb")

						arg_37_1:RecordAudio("423101009", var_40_9)
						arg_37_1:RecordAudio("423101009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423101", "423101009", "story_v_out_423101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423101", "423101009", "story_v_out_423101.awb")
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
	Play423101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423101010
		arg_41_1.duration_ = 9.7

		local var_41_0 = {
			zh = 5.4,
			ja = 9.7
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
				arg_41_0:Play423101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10148"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 3)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_2" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(0, -350, -270)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_44_7 = 0
			local var_44_8 = 0.65

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_9 = arg_41_1:FormatText(StoryNameCfg[1331].name)

				arg_41_1.leftNameTxt_.text = var_44_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(423101010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 26
				local var_44_13 = utf8.len(var_44_11)
				local var_44_14 = var_44_12 <= 0 and var_44_8 or var_44_8 * (var_44_13 / var_44_12)

				if var_44_14 > 0 and var_44_8 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101010", "story_v_out_423101.awb") ~= 0 then
					local var_44_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101010", "story_v_out_423101.awb") / 1000

					if var_44_15 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_7
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_423101", "423101010", "story_v_out_423101.awb")

						arg_41_1:RecordAudio("423101010", var_44_16)
						arg_41_1:RecordAudio("423101010", var_44_16)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423101", "423101010", "story_v_out_423101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423101", "423101010", "story_v_out_423101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_17 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_17 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_17

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_17 and arg_41_1.time_ < var_44_7 + var_44_17 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423101011
		arg_45_1.duration_ = 7.53

		local var_45_0 = {
			zh = 5.966,
			ja = 7.533
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
				arg_45_0:Play423101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 2

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_1 = manager.ui.mainCamera.transform.localPosition
				local var_48_2 = Vector3.New(0, 0, 10) + Vector3.New(var_48_1.x, var_48_1.y, 0)
				local var_48_3 = arg_45_1.bgs_.I25h

				var_48_3.transform.localPosition = var_48_2
				var_48_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_4 = var_48_3:GetComponent("SpriteRenderer")

				if var_48_4 and var_48_4.sprite then
					local var_48_5 = (var_48_3.transform.localPosition - var_48_1).z
					local var_48_6 = manager.ui.mainCameraCom_
					local var_48_7 = 2 * var_48_5 * Mathf.Tan(var_48_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_8 = var_48_7 * var_48_6.aspect
					local var_48_9 = var_48_4.sprite.bounds.size.x
					local var_48_10 = var_48_4.sprite.bounds.size.y
					local var_48_11 = var_48_8 / var_48_9
					local var_48_12 = var_48_7 / var_48_10
					local var_48_13 = var_48_12 < var_48_11 and var_48_11 or var_48_12

					var_48_3.transform.localScale = Vector3.New(var_48_13, var_48_13, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I25h" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_14 = 4

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_15 = 0.3

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_17 = 2

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17
				local var_48_19 = Color.New(0, 0, 0)

				var_48_19.a = Mathf.Lerp(0, 1, var_48_18)
				arg_45_1.mask_.color = var_48_19
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				local var_48_20 = Color.New(0, 0, 0)

				var_48_20.a = 1
				arg_45_1.mask_.color = var_48_20
			end

			local var_48_21 = 2

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_22 = 2

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				local var_48_23 = (arg_45_1.time_ - var_48_21) / var_48_22
				local var_48_24 = Color.New(0, 0, 0)

				var_48_24.a = Mathf.Lerp(1, 0, var_48_23)
				arg_45_1.mask_.color = var_48_24
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				local var_48_25 = Color.New(0, 0, 0)
				local var_48_26 = 0

				arg_45_1.mask_.enabled = false
				var_48_25.a = var_48_26
				arg_45_1.mask_.color = var_48_25
			end

			local var_48_27 = arg_45_1.actors_["10148"].transform
			local var_48_28 = 4

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1.var_.moveOldPos10148 = var_48_27.localPosition
				var_48_27.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10148", 3)

				local var_48_29 = var_48_27.childCount

				for iter_48_2 = 0, var_48_29 - 1 do
					local var_48_30 = var_48_27:GetChild(iter_48_2)

					if var_48_30.name == "" or not string.find(var_48_30.name, "split") then
						var_48_30.gameObject:SetActive(true)
					else
						var_48_30.gameObject:SetActive(false)
					end
				end
			end

			local var_48_31 = 0.001

			if var_48_28 <= arg_45_1.time_ and arg_45_1.time_ < var_48_28 + var_48_31 then
				local var_48_32 = (arg_45_1.time_ - var_48_28) / var_48_31
				local var_48_33 = Vector3.New(0, -350, -270)

				var_48_27.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10148, var_48_33, var_48_32)
			end

			if arg_45_1.time_ >= var_48_28 + var_48_31 and arg_45_1.time_ < var_48_28 + var_48_31 + arg_48_0 then
				var_48_27.localPosition = Vector3.New(0, -350, -270)
			end

			local var_48_34 = arg_45_1.actors_["10148"].transform
			local var_48_35 = 1.966

			if var_48_35 < arg_45_1.time_ and arg_45_1.time_ <= var_48_35 + arg_48_0 then
				arg_45_1.var_.moveOldPos10148 = var_48_34.localPosition
				var_48_34.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10148", 7)

				local var_48_36 = var_48_34.childCount

				for iter_48_3 = 0, var_48_36 - 1 do
					local var_48_37 = var_48_34:GetChild(iter_48_3)

					if var_48_37.name == "" or not string.find(var_48_37.name, "split") then
						var_48_37.gameObject:SetActive(true)
					else
						var_48_37.gameObject:SetActive(false)
					end
				end
			end

			local var_48_38 = 0.001

			if var_48_35 <= arg_45_1.time_ and arg_45_1.time_ < var_48_35 + var_48_38 then
				local var_48_39 = (arg_45_1.time_ - var_48_35) / var_48_38
				local var_48_40 = Vector3.New(0, -2000, 0)

				var_48_34.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10148, var_48_40, var_48_39)
			end

			if arg_45_1.time_ >= var_48_35 + var_48_38 and arg_45_1.time_ < var_48_35 + var_48_38 + arg_48_0 then
				var_48_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_41 = 4
			local var_48_42 = 0.175

			if var_48_41 < arg_45_1.time_ and arg_45_1.time_ <= var_48_41 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_43 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_43:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_44 = arg_45_1:FormatText(StoryNameCfg[1331].name)

				arg_45_1.leftNameTxt_.text = var_48_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_45 = arg_45_1:GetWordFromCfg(423101011)
				local var_48_46 = arg_45_1:FormatText(var_48_45.content)

				arg_45_1.text_.text = var_48_46

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_47 = 7
				local var_48_48 = utf8.len(var_48_46)
				local var_48_49 = var_48_47 <= 0 and var_48_42 or var_48_42 * (var_48_48 / var_48_47)

				if var_48_49 > 0 and var_48_42 < var_48_49 then
					arg_45_1.talkMaxDuration = var_48_49
					var_48_41 = var_48_41 + 0.3

					if var_48_49 + var_48_41 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_49 + var_48_41
					end
				end

				arg_45_1.text_.text = var_48_46
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101011", "story_v_out_423101.awb") ~= 0 then
					local var_48_50 = manager.audio:GetVoiceLength("story_v_out_423101", "423101011", "story_v_out_423101.awb") / 1000

					if var_48_50 + var_48_41 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_50 + var_48_41
					end

					if var_48_45.prefab_name ~= "" and arg_45_1.actors_[var_48_45.prefab_name] ~= nil then
						local var_48_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_45.prefab_name].transform, "story_v_out_423101", "423101011", "story_v_out_423101.awb")

						arg_45_1:RecordAudio("423101011", var_48_51)
						arg_45_1:RecordAudio("423101011", var_48_51)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423101", "423101011", "story_v_out_423101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423101", "423101011", "story_v_out_423101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_52 = var_48_41 + 0.3
			local var_48_53 = math.max(var_48_42, arg_45_1.talkMaxDuration)

			if var_48_52 <= arg_45_1.time_ and arg_45_1.time_ < var_48_52 + var_48_53 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_52) / var_48_53

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_52 + var_48_53 and arg_45_1.time_ < var_48_52 + var_48_53 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play423101012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423101012
		arg_51_1.duration_ = 7.6

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play423101013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10148"].transform
			local var_54_1 = 0.466

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos10148 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10148", 7)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(0, -2000, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10148, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_8 = 0.5

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8
				local var_54_10 = Color.New(1, 1, 1)

				var_54_10.a = Mathf.Lerp(0, 1, var_54_9)
				arg_51_1.mask_.color = var_54_10
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 then
				local var_54_11 = Color.New(1, 1, 1)

				var_54_11.a = 1
				arg_51_1.mask_.color = var_54_11
			end

			local var_54_12 = 0.5

			if var_54_12 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_13 = 0.5

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_13 then
				local var_54_14 = (arg_51_1.time_ - var_54_12) / var_54_13
				local var_54_15 = Color.New(1, 1, 1)

				var_54_15.a = Mathf.Lerp(1, 0, var_54_14)
				arg_51_1.mask_.color = var_54_15
			end

			if arg_51_1.time_ >= var_54_12 + var_54_13 and arg_51_1.time_ < var_54_12 + var_54_13 + arg_54_0 then
				local var_54_16 = Color.New(1, 1, 1)
				local var_54_17 = 0

				arg_51_1.mask_.enabled = false
				var_54_16.a = var_54_17
				arg_51_1.mask_.color = var_54_16
			end

			local var_54_18 = manager.ui.mainCamera.transform
			local var_54_19 = 1

			if var_54_19 < arg_51_1.time_ and arg_51_1.time_ <= var_54_19 + arg_54_0 then
				local var_54_20 = arg_51_1.var_.effectdianyingkaipai1
				local var_54_21
				local var_54_22 = var_54_18

				if not var_54_20 then
					var_54_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), var_54_22)
					var_54_20.name = "dianyingkaipai1"
					arg_51_1.var_.effectdianyingkaipai1 = var_54_20
				else
					var_54_20.transform:SetParent(var_54_22)
				end

				var_54_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_54_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_54_23 = manager.ui.mainCameraCom_
				local var_54_24 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_54_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_54_25 = var_54_20.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_54_26 = 15
				local var_54_27 = 2 * var_54_26 * Mathf.Tan(var_54_23.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_54_23.aspect
				local var_54_28 = 1
				local var_54_29 = 1.7777777777777777

				if var_54_29 < var_54_23.aspect then
					var_54_28 = var_54_27 / (2 * var_54_26 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_54_29)
				end

				for iter_54_1, iter_54_2 in ipairs(var_54_25) do
					local var_54_30 = iter_54_2.transform.localScale

					iter_54_2.transform.localScale = Vector3.New(var_54_30.x / var_54_24 * var_54_28, var_54_30.y / var_54_24, var_54_30.z)
				end
			end

			local var_54_31 = 0
			local var_54_32 = 0.3

			if var_54_31 < arg_51_1.time_ and arg_51_1.time_ <= var_54_31 + arg_54_0 then
				local var_54_33 = "play"
				local var_54_34 = "music"

				arg_51_1:AudioAction(var_54_33, var_54_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_54_35 = ""
				local var_54_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_54_36 ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_36 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_36

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_36
						arg_51_1.bgmTxt2_.text = var_54_36
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_54_37 = 0.500666666666667
			local var_54_38 = 1

			if var_54_37 < arg_51_1.time_ and arg_51_1.time_ <= var_54_37 + arg_54_0 then
				local var_54_39 = "play"
				local var_54_40 = "music"

				arg_51_1:AudioAction(var_54_39, var_54_40, "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_54_41 = ""
				local var_54_42 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if var_54_42 ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_42 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_42

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_42
						arg_51_1.bgmTxt2_.text = var_54_42
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_54_43 = 0.133333333333333
			local var_54_44 = 1

			if var_54_43 < arg_51_1.time_ and arg_51_1.time_ <= var_54_43 + arg_54_0 then
				local var_54_45 = "play"
				local var_54_46 = "effect"

				arg_51_1:AudioAction(var_54_45, var_54_46, "se_story_144", "se_story_144_clap04", "")
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_47 = 2.6
			local var_54_48 = 1.875

			if var_54_47 < arg_51_1.time_ and arg_51_1.time_ <= var_54_47 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_49 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_49:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_51_1.dialogCg_.alpha = arg_57_0
				end))
				var_54_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_50 = arg_51_1:GetWordFromCfg(423101012)
				local var_54_51 = arg_51_1:FormatText(var_54_50.content)

				arg_51_1.text_.text = var_54_51

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_52 = 75
				local var_54_53 = utf8.len(var_54_51)
				local var_54_54 = var_54_52 <= 0 and var_54_48 or var_54_48 * (var_54_53 / var_54_52)

				if var_54_54 > 0 and var_54_48 < var_54_54 then
					arg_51_1.talkMaxDuration = var_54_54
					var_54_47 = var_54_47 + 0.3

					if var_54_54 + var_54_47 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_54 + var_54_47
					end
				end

				arg_51_1.text_.text = var_54_51
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_55 = var_54_47 + 0.3
			local var_54_56 = math.max(var_54_48, arg_51_1.talkMaxDuration)

			if var_54_55 <= arg_51_1.time_ and arg_51_1.time_ < var_54_55 + var_54_56 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_55) / var_54_56

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_55 + var_54_56 and arg_51_1.time_ < var_54_55 + var_54_56 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play423101013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423101013
		arg_59_1.duration_ = 8.63

		local var_59_0 = {
			zh = 6.2,
			ja = 8.633
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
				arg_59_0:Play423101014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.166666666666667
			local var_62_1 = 1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "effect"

				arg_59_1:AudioAction(var_62_2, var_62_3, "se_story_side_1067", "se_story_1067_horse01", "")
			end

			local var_62_4 = 0
			local var_62_5 = 0.6

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_6 = arg_59_1:FormatText(StoryNameCfg[1343].name)

				arg_59_1.leftNameTxt_.text = var_62_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_7 = arg_59_1:GetWordFromCfg(423101013)
				local var_62_8 = arg_59_1:FormatText(var_62_7.content)

				arg_59_1.text_.text = var_62_8

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 24
				local var_62_10 = utf8.len(var_62_8)
				local var_62_11 = var_62_9 <= 0 and var_62_5 or var_62_5 * (var_62_10 / var_62_9)

				if var_62_11 > 0 and var_62_5 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_8
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101013", "story_v_out_423101.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_423101", "423101013", "story_v_out_423101.awb") / 1000

					if var_62_12 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_4
					end

					if var_62_7.prefab_name ~= "" and arg_59_1.actors_[var_62_7.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_7.prefab_name].transform, "story_v_out_423101", "423101013", "story_v_out_423101.awb")

						arg_59_1:RecordAudio("423101013", var_62_13)
						arg_59_1:RecordAudio("423101013", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423101", "423101013", "story_v_out_423101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423101", "423101013", "story_v_out_423101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_14 and arg_59_1.time_ < var_62_4 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play423101014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423101014
		arg_63_1.duration_ = 5.43

		local var_63_0 = {
			zh = 4.433,
			ja = 5.433
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
				arg_63_0:Play423101015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.525

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[1343].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(423101014)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101014", "story_v_out_423101.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101014", "story_v_out_423101.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_423101", "423101014", "story_v_out_423101.awb")

						arg_63_1:RecordAudio("423101014", var_66_9)
						arg_63_1:RecordAudio("423101014", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_423101", "423101014", "story_v_out_423101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_423101", "423101014", "story_v_out_423101.awb")
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
	Play423101015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 423101015
		arg_67_1.duration_ = 7.9

		local var_67_0 = {
			zh = 7.133,
			ja = 7.9
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
				arg_67_0:Play423101016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.6

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[1344].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(423101015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101015", "story_v_out_423101.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101015", "story_v_out_423101.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_423101", "423101015", "story_v_out_423101.awb")

						arg_67_1:RecordAudio("423101015", var_70_9)
						arg_67_1:RecordAudio("423101015", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_423101", "423101015", "story_v_out_423101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_423101", "423101015", "story_v_out_423101.awb")
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
	Play423101016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 423101016
		arg_71_1.duration_ = 5.73

		local var_71_0 = {
			zh = 4.2,
			ja = 5.733
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
				arg_71_0:Play423101017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.4

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[1343].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(423101016)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101016", "story_v_out_423101.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101016", "story_v_out_423101.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_423101", "423101016", "story_v_out_423101.awb")

						arg_71_1:RecordAudio("423101016", var_74_9)
						arg_71_1:RecordAudio("423101016", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_423101", "423101016", "story_v_out_423101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_423101", "423101016", "story_v_out_423101.awb")
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
	Play423101017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423101017
		arg_75_1.duration_ = 8.23

		local var_75_0 = {
			zh = 5.333,
			ja = 8.233
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
				arg_75_0:Play423101018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.475

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[1344].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(423101017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101017", "story_v_out_423101.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101017", "story_v_out_423101.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_423101", "423101017", "story_v_out_423101.awb")

						arg_75_1:RecordAudio("423101017", var_78_9)
						arg_75_1:RecordAudio("423101017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_423101", "423101017", "story_v_out_423101.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_423101", "423101017", "story_v_out_423101.awb")
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
	Play423101018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423101018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play423101019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.4

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(423101018)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 56
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play423101019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423101019
		arg_83_1.duration_ = 13.6

		local var_83_0 = {
			zh = 8.566,
			ja = 13.6
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
				arg_83_0:Play423101020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.8

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[1344].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(423101019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101019", "story_v_out_423101.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101019", "story_v_out_423101.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_423101", "423101019", "story_v_out_423101.awb")

						arg_83_1:RecordAudio("423101019", var_86_9)
						arg_83_1:RecordAudio("423101019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423101", "423101019", "story_v_out_423101.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423101", "423101019", "story_v_out_423101.awb")
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
	Play423101020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423101020
		arg_87_1.duration_ = 11.03

		local var_87_0 = {
			zh = 7.9,
			ja = 11.033
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
				arg_87_0:Play423101021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "1083"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(var_90_1, arg_87_1.canvasGo_.transform)

					var_90_2.transform:SetSiblingIndex(1)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_87_1.isInRecall_ then
						for iter_90_0, iter_90_1 in ipairs(var_90_3) do
							iter_90_1.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_4 = arg_87_1.actors_["1083"]
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.actorSpriteComps1083 == nil then
				arg_87_1.var_.actorSpriteComps1083 = var_90_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.2

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 and not isNil(var_90_4) then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6

				if arg_87_1.var_.actorSpriteComps1083 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								local var_90_8 = Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor1.r, var_90_7)
								local var_90_9 = Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor1.g, var_90_7)
								local var_90_10 = Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor1.b, var_90_7)

								iter_90_3.color = Color.New(var_90_8, var_90_9, var_90_10)
							else
								local var_90_11 = Mathf.Lerp(iter_90_3.color.r, 1, var_90_7)

								iter_90_3.color = Color.New(var_90_11, var_90_11, var_90_11)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.actorSpriteComps1083 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_90_5 then
						if arg_87_1.isInRecall_ then
							iter_90_5.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1083 = nil
			end

			local var_90_12 = arg_87_1.actors_["1083"].transform
			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.var_.moveOldPos1083 = var_90_12.localPosition
				var_90_12.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1083", 3)

				local var_90_14 = var_90_12.childCount

				for iter_90_6 = 0, var_90_14 - 1 do
					local var_90_15 = var_90_12:GetChild(iter_90_6)

					if var_90_15.name == "split_7" or not string.find(var_90_15.name, "split") then
						var_90_15.gameObject:SetActive(true)
					else
						var_90_15.gameObject:SetActive(false)
					end
				end
			end

			local var_90_16 = 0.001

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_16 then
				local var_90_17 = (arg_87_1.time_ - var_90_13) / var_90_16
				local var_90_18 = Vector3.New(-50, -345, -345)

				var_90_12.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1083, var_90_18, var_90_17)
			end

			if arg_87_1.time_ >= var_90_13 + var_90_16 and arg_87_1.time_ < var_90_13 + var_90_16 + arg_90_0 then
				var_90_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_90_19 = arg_87_1.actors_["1083"]
			local var_90_20 = 0

			if var_90_20 < arg_87_1.time_ and arg_87_1.time_ <= var_90_20 + arg_90_0 then
				local var_90_21 = var_90_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_21 then
					arg_87_1.var_.alphaOldValue1083 = var_90_21.alpha
					arg_87_1.var_.characterEffect1083 = var_90_21
				end

				arg_87_1.var_.alphaOldValue1083 = 0
			end

			local var_90_22 = 0.5

			if var_90_20 <= arg_87_1.time_ and arg_87_1.time_ < var_90_20 + var_90_22 then
				local var_90_23 = (arg_87_1.time_ - var_90_20) / var_90_22
				local var_90_24 = Mathf.Lerp(arg_87_1.var_.alphaOldValue1083, 1, var_90_23)

				if arg_87_1.var_.characterEffect1083 then
					arg_87_1.var_.characterEffect1083.alpha = var_90_24
				end
			end

			if arg_87_1.time_ >= var_90_20 + var_90_22 and arg_87_1.time_ < var_90_20 + var_90_22 + arg_90_0 and arg_87_1.var_.characterEffect1083 then
				arg_87_1.var_.characterEffect1083.alpha = 1
			end

			local var_90_25 = 0
			local var_90_26 = 0.85

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_27 = arg_87_1:FormatText(StoryNameCfg[1345].name)

				arg_87_1.leftNameTxt_.text = var_90_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_28 = arg_87_1:GetWordFromCfg(423101020)
				local var_90_29 = arg_87_1:FormatText(var_90_28.content)

				arg_87_1.text_.text = var_90_29

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_30 = 34
				local var_90_31 = utf8.len(var_90_29)
				local var_90_32 = var_90_30 <= 0 and var_90_26 or var_90_26 * (var_90_31 / var_90_30)

				if var_90_32 > 0 and var_90_26 < var_90_32 then
					arg_87_1.talkMaxDuration = var_90_32

					if var_90_32 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_32 + var_90_25
					end
				end

				arg_87_1.text_.text = var_90_29
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101020", "story_v_out_423101.awb") ~= 0 then
					local var_90_33 = manager.audio:GetVoiceLength("story_v_out_423101", "423101020", "story_v_out_423101.awb") / 1000

					if var_90_33 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_33 + var_90_25
					end

					if var_90_28.prefab_name ~= "" and arg_87_1.actors_[var_90_28.prefab_name] ~= nil then
						local var_90_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_28.prefab_name].transform, "story_v_out_423101", "423101020", "story_v_out_423101.awb")

						arg_87_1:RecordAudio("423101020", var_90_34)
						arg_87_1:RecordAudio("423101020", var_90_34)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_423101", "423101020", "story_v_out_423101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_423101", "423101020", "story_v_out_423101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_35 = math.max(var_90_26, arg_87_1.talkMaxDuration)

			if var_90_25 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_35 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_25) / var_90_35

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_25 + var_90_35 and arg_87_1.time_ < var_90_25 + var_90_35 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play423101021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423101021
		arg_91_1.duration_ = 5.63

		local var_91_0 = {
			zh = 4.266,
			ja = 5.633
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
				arg_91_0:Play423101022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1083"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1083 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1083", 3)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_8" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(-50, -345, -345)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1083, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_94_7 = 0
			local var_94_8 = 0.525

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_9 = arg_91_1:FormatText(StoryNameCfg[1345].name)

				arg_91_1.leftNameTxt_.text = var_94_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(423101021)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 21
				local var_94_13 = utf8.len(var_94_11)
				local var_94_14 = var_94_12 <= 0 and var_94_8 or var_94_8 * (var_94_13 / var_94_12)

				if var_94_14 > 0 and var_94_8 < var_94_14 then
					arg_91_1.talkMaxDuration = var_94_14

					if var_94_14 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101021", "story_v_out_423101.awb") ~= 0 then
					local var_94_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101021", "story_v_out_423101.awb") / 1000

					if var_94_15 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_7
					end

					if var_94_10.prefab_name ~= "" and arg_91_1.actors_[var_94_10.prefab_name] ~= nil then
						local var_94_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_10.prefab_name].transform, "story_v_out_423101", "423101021", "story_v_out_423101.awb")

						arg_91_1:RecordAudio("423101021", var_94_16)
						arg_91_1:RecordAudio("423101021", var_94_16)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423101", "423101021", "story_v_out_423101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423101", "423101021", "story_v_out_423101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_17 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_17 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_7) / var_94_17

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_17 and arg_91_1.time_ < var_94_7 + var_94_17 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play423101022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423101022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play423101023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1083"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps1083 == nil then
				arg_95_1.var_.actorSpriteComps1083 = var_98_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.actorSpriteComps1083 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								local var_98_4 = Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor2.r, var_98_3)
								local var_98_5 = Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor2.g, var_98_3)
								local var_98_6 = Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor2.b, var_98_3)

								iter_98_1.color = Color.New(var_98_4, var_98_5, var_98_6)
							else
								local var_98_7 = Mathf.Lerp(iter_98_1.color.r, 0.5, var_98_3)

								iter_98_1.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps1083 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_98_3 then
						if arg_95_1.isInRecall_ then
							iter_98_3.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps1083 = nil
			end

			local var_98_8 = arg_95_1.actors_["1083"].transform
			local var_98_9 = 0

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.var_.moveOldPos1083 = var_98_8.localPosition
				var_98_8.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1083", 7)

				local var_98_10 = var_98_8.childCount

				for iter_98_4 = 0, var_98_10 - 1 do
					local var_98_11 = var_98_8:GetChild(iter_98_4)

					if var_98_11.name == "" or not string.find(var_98_11.name, "split") then
						var_98_11.gameObject:SetActive(true)
					else
						var_98_11.gameObject:SetActive(false)
					end
				end
			end

			local var_98_12 = 0.001

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_12 then
				local var_98_13 = (arg_95_1.time_ - var_98_9) / var_98_12
				local var_98_14 = Vector3.New(0, -2000, 0)

				var_98_8.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1083, var_98_14, var_98_13)
			end

			if arg_95_1.time_ >= var_98_9 + var_98_12 and arg_95_1.time_ < var_98_9 + var_98_12 + arg_98_0 then
				var_98_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_15 = 0.166666666666667
			local var_98_16 = 1

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				local var_98_17 = "play"
				local var_98_18 = "effect"

				arg_95_1:AudioAction(var_98_17, var_98_18, "se_story_side_1067", "se_story_1067_horse02", "")
			end

			local var_98_19 = 0
			local var_98_20 = 1.825

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_21 = arg_95_1:GetWordFromCfg(423101022)
				local var_98_22 = arg_95_1:FormatText(var_98_21.content)

				arg_95_1.text_.text = var_98_22

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_23 = 73
				local var_98_24 = utf8.len(var_98_22)
				local var_98_25 = var_98_23 <= 0 and var_98_20 or var_98_20 * (var_98_24 / var_98_23)

				if var_98_25 > 0 and var_98_20 < var_98_25 then
					arg_95_1.talkMaxDuration = var_98_25

					if var_98_25 + var_98_19 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_25 + var_98_19
					end
				end

				arg_95_1.text_.text = var_98_22
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_26 = math.max(var_98_20, arg_95_1.talkMaxDuration)

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_26 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_19) / var_98_26

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_19 + var_98_26 and arg_95_1.time_ < var_98_19 + var_98_26 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play423101023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423101023
		arg_99_1.duration_ = 14.27

		local var_99_0 = {
			zh = 11.333,
			ja = 14.266
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
				arg_99_0:Play423101024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.15

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1343].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(423101023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101023", "story_v_out_423101.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101023", "story_v_out_423101.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_423101", "423101023", "story_v_out_423101.awb")

						arg_99_1:RecordAudio("423101023", var_102_9)
						arg_99_1:RecordAudio("423101023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_423101", "423101023", "story_v_out_423101.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_423101", "423101023", "story_v_out_423101.awb")
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
	Play423101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423101024
		arg_103_1.duration_ = 11.13

		local var_103_0 = {
			zh = 10.2,
			ja = 11.133
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
				arg_103_0:Play423101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1083"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1083 == nil then
				arg_103_1.var_.actorSpriteComps1083 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps1083 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 1, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1083 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1083 = nil
			end

			local var_106_8 = arg_103_1.actors_["1083"].transform
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.var_.moveOldPos1083 = var_106_8.localPosition
				var_106_8.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1083", 3)

				local var_106_10 = var_106_8.childCount

				for iter_106_4 = 0, var_106_10 - 1 do
					local var_106_11 = var_106_8:GetChild(iter_106_4)

					if var_106_11.name == "" or not string.find(var_106_11.name, "split") then
						var_106_11.gameObject:SetActive(true)
					else
						var_106_11.gameObject:SetActive(false)
					end
				end
			end

			local var_106_12 = 0.001

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_9) / var_106_12
				local var_106_14 = Vector3.New(-50, -345, -345)

				var_106_8.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1083, var_106_14, var_106_13)
			end

			if arg_103_1.time_ >= var_106_9 + var_106_12 and arg_103_1.time_ < var_106_9 + var_106_12 + arg_106_0 then
				var_106_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_106_15 = 0
			local var_106_16 = 1.1

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[1345].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(423101024)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 44
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101024", "story_v_out_423101.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101024", "story_v_out_423101.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_423101", "423101024", "story_v_out_423101.awb")

						arg_103_1:RecordAudio("423101024", var_106_24)
						arg_103_1:RecordAudio("423101024", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_423101", "423101024", "story_v_out_423101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_423101", "423101024", "story_v_out_423101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play423101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423101025
		arg_107_1.duration_ = 10.53

		local var_107_0 = {
			zh = 9.433,
			ja = 10.533
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
				arg_107_0:Play423101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1083"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1083 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1083", 3)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_7" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(-50, -345, -345)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1083, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_110_7 = 0
			local var_110_8 = 1.05

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_9 = arg_107_1:FormatText(StoryNameCfg[1345].name)

				arg_107_1.leftNameTxt_.text = var_110_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(423101025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 42
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_8 or var_110_8 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_8 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101025", "story_v_out_423101.awb") ~= 0 then
					local var_110_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101025", "story_v_out_423101.awb") / 1000

					if var_110_15 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_15 + var_110_7
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_423101", "423101025", "story_v_out_423101.awb")

						arg_107_1:RecordAudio("423101025", var_110_16)
						arg_107_1:RecordAudio("423101025", var_110_16)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_423101", "423101025", "story_v_out_423101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_423101", "423101025", "story_v_out_423101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_17 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_17 and arg_107_1.time_ < var_110_7 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play423101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423101026
		arg_111_1.duration_ = 13.73

		local var_111_0 = {
			zh = 8.5,
			ja = 13.733
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
				arg_111_0:Play423101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1083"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1083 == nil then
				arg_111_1.var_.actorSpriteComps1083 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps1083 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 0.5, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1083 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1083 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.925

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_10 = arg_111_1:FormatText(StoryNameCfg[1343].name)

				arg_111_1.leftNameTxt_.text = var_114_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_11 = arg_111_1:GetWordFromCfg(423101026)
				local var_114_12 = arg_111_1:FormatText(var_114_11.content)

				arg_111_1.text_.text = var_114_12

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 37
				local var_114_14 = utf8.len(var_114_12)
				local var_114_15 = var_114_13 <= 0 and var_114_9 or var_114_9 * (var_114_14 / var_114_13)

				if var_114_15 > 0 and var_114_9 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_12
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101026", "story_v_out_423101.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101026", "story_v_out_423101.awb") / 1000

					if var_114_16 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_8
					end

					if var_114_11.prefab_name ~= "" and arg_111_1.actors_[var_114_11.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_11.prefab_name].transform, "story_v_out_423101", "423101026", "story_v_out_423101.awb")

						arg_111_1:RecordAudio("423101026", var_114_17)
						arg_111_1:RecordAudio("423101026", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423101", "423101026", "story_v_out_423101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423101", "423101026", "story_v_out_423101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_18 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_18

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_18 and arg_111_1.time_ < var_114_8 + var_114_18 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play423101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423101027
		arg_115_1.duration_ = 5.13

		local var_115_0 = {
			zh = 5.133,
			ja = 4.833
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
				arg_115_0:Play423101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.4

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[1343].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(423101027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101027", "story_v_out_423101.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101027", "story_v_out_423101.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_423101", "423101027", "story_v_out_423101.awb")

						arg_115_1:RecordAudio("423101027", var_118_9)
						arg_115_1:RecordAudio("423101027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_423101", "423101027", "story_v_out_423101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_423101", "423101027", "story_v_out_423101.awb")
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
	Play423101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423101028
		arg_119_1.duration_ = 9

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play423101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "SS2303"

			if arg_119_1.bgs_[var_122_0] == nil then
				local var_122_1 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_0)
				var_122_1.name = var_122_0
				var_122_1.transform.parent = arg_119_1.stage_.transform
				var_122_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_0] = var_122_1
			end

			local var_122_2 = 2

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				local var_122_3 = manager.ui.mainCamera.transform.localPosition
				local var_122_4 = Vector3.New(0, 0, 10) + Vector3.New(var_122_3.x, var_122_3.y, 0)
				local var_122_5 = arg_119_1.bgs_.SS2303

				var_122_5.transform.localPosition = var_122_4
				var_122_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_6 = var_122_5:GetComponent("SpriteRenderer")

				if var_122_6 and var_122_6.sprite then
					local var_122_7 = (var_122_5.transform.localPosition - var_122_3).z
					local var_122_8 = manager.ui.mainCameraCom_
					local var_122_9 = 2 * var_122_7 * Mathf.Tan(var_122_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_10 = var_122_9 * var_122_8.aspect
					local var_122_11 = var_122_6.sprite.bounds.size.x
					local var_122_12 = var_122_6.sprite.bounds.size.y
					local var_122_13 = var_122_10 / var_122_11
					local var_122_14 = var_122_9 / var_122_12
					local var_122_15 = var_122_14 < var_122_13 and var_122_13 or var_122_14

					var_122_5.transform.localScale = Vector3.New(var_122_15, var_122_15, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "SS2303" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_16 = 4

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_17 = 0.3

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_18 = 0

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_19 = 2

			if var_122_18 <= arg_119_1.time_ and arg_119_1.time_ < var_122_18 + var_122_19 then
				local var_122_20 = (arg_119_1.time_ - var_122_18) / var_122_19
				local var_122_21 = Color.New(0, 0, 0)

				var_122_21.a = Mathf.Lerp(0, 1, var_122_20)
				arg_119_1.mask_.color = var_122_21
			end

			if arg_119_1.time_ >= var_122_18 + var_122_19 and arg_119_1.time_ < var_122_18 + var_122_19 + arg_122_0 then
				local var_122_22 = Color.New(0, 0, 0)

				var_122_22.a = 1
				arg_119_1.mask_.color = var_122_22
			end

			local var_122_23 = 2

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_24 = 2

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 then
				local var_122_25 = (arg_119_1.time_ - var_122_23) / var_122_24
				local var_122_26 = Color.New(0, 0, 0)

				var_122_26.a = Mathf.Lerp(1, 0, var_122_25)
				arg_119_1.mask_.color = var_122_26
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 then
				local var_122_27 = Color.New(0, 0, 0)
				local var_122_28 = 0

				arg_119_1.mask_.enabled = false
				var_122_27.a = var_122_28
				arg_119_1.mask_.color = var_122_27
			end

			local var_122_29 = arg_119_1.actors_["1083"].transform
			local var_122_30 = 1.966

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.var_.moveOldPos1083 = var_122_29.localPosition
				var_122_29.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1083", 7)

				local var_122_31 = var_122_29.childCount

				for iter_122_2 = 0, var_122_31 - 1 do
					local var_122_32 = var_122_29:GetChild(iter_122_2)

					if var_122_32.name == "" or not string.find(var_122_32.name, "split") then
						var_122_32.gameObject:SetActive(true)
					else
						var_122_32.gameObject:SetActive(false)
					end
				end
			end

			local var_122_33 = 0.001

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_33 then
				local var_122_34 = (arg_119_1.time_ - var_122_30) / var_122_33
				local var_122_35 = Vector3.New(0, -2000, 0)

				var_122_29.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1083, var_122_35, var_122_34)
			end

			if arg_119_1.time_ >= var_122_30 + var_122_33 and arg_119_1.time_ < var_122_30 + var_122_33 + arg_122_0 then
				var_122_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_36 = arg_119_1.bgs_.SS2303.transform
			local var_122_37 = 1.9

			if var_122_37 < arg_119_1.time_ and arg_119_1.time_ <= var_122_37 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS2303 = var_122_36.localPosition
			end

			local var_122_38 = 0.1

			if var_122_37 <= arg_119_1.time_ and arg_119_1.time_ < var_122_37 + var_122_38 then
				local var_122_39 = (arg_119_1.time_ - var_122_37) / var_122_38
				local var_122_40 = Vector3.New(0, 0, 5)

				var_122_36.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS2303, var_122_40, var_122_39)
			end

			if arg_119_1.time_ >= var_122_37 + var_122_38 and arg_119_1.time_ < var_122_37 + var_122_38 + arg_122_0 then
				var_122_36.localPosition = Vector3.New(0, 0, 5)
			end

			local var_122_41 = arg_119_1.bgs_.SS2303.transform
			local var_122_42 = 2

			if var_122_42 < arg_119_1.time_ and arg_119_1.time_ <= var_122_42 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS2303 = var_122_41.localPosition
			end

			local var_122_43 = 3.2

			if var_122_42 <= arg_119_1.time_ and arg_119_1.time_ < var_122_42 + var_122_43 then
				local var_122_44 = (arg_119_1.time_ - var_122_42) / var_122_43
				local var_122_45 = Vector3.New(0, 0, 5.5)

				var_122_41.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS2303, var_122_45, var_122_44)
			end

			if arg_119_1.time_ >= var_122_42 + var_122_43 and arg_119_1.time_ < var_122_42 + var_122_43 + arg_122_0 then
				var_122_41.localPosition = Vector3.New(0, 0, 5.5)
			end

			local var_122_46 = manager.ui.mainCamera.transform
			local var_122_47 = 1.9

			if var_122_47 < arg_119_1.time_ and arg_119_1.time_ <= var_122_47 + arg_122_0 then
				local var_122_48 = arg_119_1.var_.effectdianyingkaipai1

				if var_122_48 then
					Object.Destroy(var_122_48)

					arg_119_1.var_.effectdianyingkaipai1 = nil
				end
			end

			local var_122_49 = 1.46666666666667
			local var_122_50 = 1

			if var_122_49 < arg_119_1.time_ and arg_119_1.time_ <= var_122_49 + arg_122_0 then
				local var_122_51 = "play"
				local var_122_52 = "effect"

				arg_119_1:AudioAction(var_122_51, var_122_52, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_122_53 = 2.83546070172451
			local var_122_54 = 1

			if var_122_53 < arg_119_1.time_ and arg_119_1.time_ <= var_122_53 + arg_122_0 then
				local var_122_55 = "play"
				local var_122_56 = "effect"

				arg_119_1:AudioAction(var_122_55, var_122_56, "se_story_144", "se_story_144_bell02", "")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_57 = 4
			local var_122_58 = 1.825

			if var_122_57 < arg_119_1.time_ and arg_119_1.time_ <= var_122_57 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_59 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_59:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_60 = arg_119_1:GetWordFromCfg(423101028)
				local var_122_61 = arg_119_1:FormatText(var_122_60.content)

				arg_119_1.text_.text = var_122_61

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_62 = 73
				local var_122_63 = utf8.len(var_122_61)
				local var_122_64 = var_122_62 <= 0 and var_122_58 or var_122_58 * (var_122_63 / var_122_62)

				if var_122_64 > 0 and var_122_58 < var_122_64 then
					arg_119_1.talkMaxDuration = var_122_64
					var_122_57 = var_122_57 + 0.3

					if var_122_64 + var_122_57 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_64 + var_122_57
					end
				end

				arg_119_1.text_.text = var_122_61
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_65 = var_122_57 + 0.3
			local var_122_66 = math.max(var_122_58, arg_119_1.talkMaxDuration)

			if var_122_65 <= arg_119_1.time_ and arg_119_1.time_ < var_122_65 + var_122_66 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_65) / var_122_66

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_65 + var_122_66 and arg_119_1.time_ < var_122_65 + var_122_66 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS2303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.2,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play423101029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423101029
		arg_125_1.duration_ = 18.17

		local var_125_0 = {
			zh = 13.366,
			ja = 18.166
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
				arg_125_0:Play423101030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.225

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[1343].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(423101029)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 49
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101029", "story_v_out_423101.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101029", "story_v_out_423101.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_423101", "423101029", "story_v_out_423101.awb")

						arg_125_1:RecordAudio("423101029", var_128_9)
						arg_125_1:RecordAudio("423101029", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423101", "423101029", "story_v_out_423101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423101", "423101029", "story_v_out_423101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play423101030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423101030
		arg_129_1.duration_ = 12.8

		local var_129_0 = {
			zh = 9,
			ja = 12.8
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
				arg_129_0:Play423101031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[1343].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(423101030)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 40
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101030", "story_v_out_423101.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101030", "story_v_out_423101.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_423101", "423101030", "story_v_out_423101.awb")

						arg_129_1:RecordAudio("423101030", var_132_9)
						arg_129_1:RecordAudio("423101030", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_423101", "423101030", "story_v_out_423101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_423101", "423101030", "story_v_out_423101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play423101031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423101031
		arg_133_1.duration_ = 5.63

		local var_133_0 = {
			zh = 5.633,
			ja = 4.533
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
				arg_133_0:Play423101032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.525

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1345].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_3")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(423101031)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 21
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101031", "story_v_out_423101.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101031", "story_v_out_423101.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_423101", "423101031", "story_v_out_423101.awb")

						arg_133_1:RecordAudio("423101031", var_136_9)
						arg_133_1:RecordAudio("423101031", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_423101", "423101031", "story_v_out_423101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_423101", "423101031", "story_v_out_423101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423101032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423101032
		arg_137_1.duration_ = 16.6

		local var_137_0 = {
			zh = 11.333,
			ja = 16.6
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
				arg_137_0:Play423101033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 1.3

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1343].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(423101032)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 52
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101032", "story_v_out_423101.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101032", "story_v_out_423101.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_423101", "423101032", "story_v_out_423101.awb")

						arg_137_1:RecordAudio("423101032", var_140_9)
						arg_137_1:RecordAudio("423101032", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_423101", "423101032", "story_v_out_423101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_423101", "423101032", "story_v_out_423101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play423101033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423101033
		arg_141_1.duration_ = 12.57

		local var_141_0 = {
			zh = 9.7,
			ja = 12.566
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
				arg_141_0:Play423101034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.05

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[1343].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(423101033)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101033", "story_v_out_423101.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101033", "story_v_out_423101.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_423101", "423101033", "story_v_out_423101.awb")

						arg_141_1:RecordAudio("423101033", var_144_9)
						arg_141_1:RecordAudio("423101033", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_423101", "423101033", "story_v_out_423101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_423101", "423101033", "story_v_out_423101.awb")
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
	Play423101034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423101034
		arg_145_1.duration_ = 3.73

		local var_145_0 = {
			zh = 3.7,
			ja = 3.733
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
				arg_145_0:Play423101035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.275

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1346].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(423101034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101034", "story_v_out_423101.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101034", "story_v_out_423101.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_423101", "423101034", "story_v_out_423101.awb")

						arg_145_1:RecordAudio("423101034", var_148_9)
						arg_145_1:RecordAudio("423101034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423101", "423101034", "story_v_out_423101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423101", "423101034", "story_v_out_423101.awb")
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
	Play423101035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423101035
		arg_149_1.duration_ = 6.3

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423101036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.266666666666667

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_1 = 1.033333

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_1 then
				local var_152_2 = (arg_149_1.time_ - var_152_0) / var_152_1
				local var_152_3 = Color.New(1, 1, 1)

				var_152_3.a = Mathf.Lerp(1, 0, var_152_2)
				arg_149_1.mask_.color = var_152_3
			end

			if arg_149_1.time_ >= var_152_0 + var_152_1 and arg_149_1.time_ < var_152_0 + var_152_1 + arg_152_0 then
				local var_152_4 = Color.New(1, 1, 1)
				local var_152_5 = 0

				arg_149_1.mask_.enabled = false
				var_152_4.a = var_152_5
				arg_149_1.mask_.color = var_152_4
			end

			local var_152_6 = manager.ui.mainCamera.transform
			local var_152_7 = 0.266666666666667

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				arg_149_1.var_.shakeOldPos = var_152_6.localPosition
			end

			local var_152_8 = 0.6

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / 0.066
				local var_152_10, var_152_11 = math.modf(var_152_9)

				var_152_6.localPosition = Vector3.New(var_152_11 * 0.13, var_152_11 * 0.13, var_152_11 * 0.13) + arg_149_1.var_.shakeOldPos
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 then
				var_152_6.localPosition = arg_149_1.var_.shakeOldPos
			end

			local var_152_12 = 0.266666666666667

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				local var_152_13 = manager.ui.mainCamera.transform.localPosition
				local var_152_14 = Vector3.New(0, 0, 10) + Vector3.New(var_152_13.x, var_152_13.y, 0)
				local var_152_15 = arg_149_1.bgs_.SS2303

				var_152_15.transform.localPosition = var_152_14
				var_152_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_16 = var_152_15:GetComponent("SpriteRenderer")

				if var_152_16 and var_152_16.sprite then
					local var_152_17 = (var_152_15.transform.localPosition - var_152_13).z
					local var_152_18 = manager.ui.mainCameraCom_
					local var_152_19 = 2 * var_152_17 * Mathf.Tan(var_152_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_20 = var_152_19 * var_152_18.aspect
					local var_152_21 = var_152_16.sprite.bounds.size.x
					local var_152_22 = var_152_16.sprite.bounds.size.y
					local var_152_23 = var_152_20 / var_152_21
					local var_152_24 = var_152_19 / var_152_22
					local var_152_25 = var_152_24 < var_152_23 and var_152_23 or var_152_24

					var_152_15.transform.localScale = Vector3.New(var_152_25, var_152_25, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "SS2303" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_26 = 0

			if var_152_26 < arg_149_1.time_ and arg_149_1.time_ <= var_152_26 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			local var_152_27 = 0.266666666666667

			if arg_149_1.time_ >= var_152_26 + var_152_27 and arg_149_1.time_ < var_152_26 + var_152_27 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_28 = 0.266666666666667
			local var_152_29 = 1

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				local var_152_30 = "play"
				local var_152_31 = "effect"

				arg_149_1:AudioAction(var_152_30, var_152_31, "se_story_144", "se_story_144_gun", "")
			end

			local var_152_32 = 1.29999966666667
			local var_152_33 = 1.625

			if var_152_32 < arg_149_1.time_ and arg_149_1.time_ <= var_152_32 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_34 = arg_149_1:GetWordFromCfg(423101035)
				local var_152_35 = arg_149_1:FormatText(var_152_34.content)

				arg_149_1.text_.text = var_152_35

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_36 = 65
				local var_152_37 = utf8.len(var_152_35)
				local var_152_38 = var_152_36 <= 0 and var_152_33 or var_152_33 * (var_152_37 / var_152_36)

				if var_152_38 > 0 and var_152_33 < var_152_38 then
					arg_149_1.talkMaxDuration = var_152_38

					if var_152_38 + var_152_32 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_32
					end
				end

				arg_149_1.text_.text = var_152_35
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_39 = math.max(var_152_33, arg_149_1.talkMaxDuration)

			if var_152_32 <= arg_149_1.time_ and arg_149_1.time_ < var_152_32 + var_152_39 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_32) / var_152_39

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_32 + var_152_39 and arg_149_1.time_ < var_152_32 + var_152_39 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play423101036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423101036
		arg_153_1.duration_ = 5.1

		local var_153_0 = {
			zh = 3.366,
			ja = 5.1
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
				arg_153_0:Play423101037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.133333333333333
			local var_156_1 = 1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				local var_156_2 = "play"
				local var_156_3 = "effect"

				arg_153_1:AudioAction(var_156_2, var_156_3, "se_story_144", "se_story_144_bell03", "")
			end

			local var_156_4 = 0
			local var_156_5 = 0.4

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_6 = arg_153_1:FormatText(StoryNameCfg[1344].name)

				arg_153_1.leftNameTxt_.text = var_156_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_7 = arg_153_1:GetWordFromCfg(423101036)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 16
				local var_156_10 = utf8.len(var_156_8)
				local var_156_11 = var_156_9 <= 0 and var_156_5 or var_156_5 * (var_156_10 / var_156_9)

				if var_156_11 > 0 and var_156_5 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101036", "story_v_out_423101.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_423101", "423101036", "story_v_out_423101.awb") / 1000

					if var_156_12 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_4
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_423101", "423101036", "story_v_out_423101.awb")

						arg_153_1:RecordAudio("423101036", var_156_13)
						arg_153_1:RecordAudio("423101036", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423101", "423101036", "story_v_out_423101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423101", "423101036", "story_v_out_423101.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_14 and arg_153_1.time_ < var_156_4 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play423101037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423101037
		arg_157_1.duration_ = 17

		local var_157_0 = {
			zh = 8.866,
			ja = 17
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
				arg_157_0:Play423101038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = "L08g"

			if arg_157_1.bgs_[var_160_0] == nil then
				local var_160_1 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_160_0)
				var_160_1.name = var_160_0
				var_160_1.transform.parent = arg_157_1.stage_.transform
				var_160_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_[var_160_0] = var_160_1
			end

			local var_160_2 = 2

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				local var_160_3 = manager.ui.mainCamera.transform.localPosition
				local var_160_4 = Vector3.New(0, 0, 10) + Vector3.New(var_160_3.x, var_160_3.y, 0)
				local var_160_5 = arg_157_1.bgs_.L08g

				var_160_5.transform.localPosition = var_160_4
				var_160_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_6 = var_160_5:GetComponent("SpriteRenderer")

				if var_160_6 and var_160_6.sprite then
					local var_160_7 = (var_160_5.transform.localPosition - var_160_3).z
					local var_160_8 = manager.ui.mainCameraCom_
					local var_160_9 = 2 * var_160_7 * Mathf.Tan(var_160_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_160_10 = var_160_9 * var_160_8.aspect
					local var_160_11 = var_160_6.sprite.bounds.size.x
					local var_160_12 = var_160_6.sprite.bounds.size.y
					local var_160_13 = var_160_10 / var_160_11
					local var_160_14 = var_160_9 / var_160_12
					local var_160_15 = var_160_14 < var_160_13 and var_160_13 or var_160_14

					var_160_5.transform.localScale = Vector3.New(var_160_15, var_160_15, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "L08g" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_16 = 3.999999999999

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_17 = 0.3

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_18 = 0

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_19 = 2

			if var_160_18 <= arg_157_1.time_ and arg_157_1.time_ < var_160_18 + var_160_19 then
				local var_160_20 = (arg_157_1.time_ - var_160_18) / var_160_19
				local var_160_21 = Color.New(0, 0, 0)

				var_160_21.a = Mathf.Lerp(0, 1, var_160_20)
				arg_157_1.mask_.color = var_160_21
			end

			if arg_157_1.time_ >= var_160_18 + var_160_19 and arg_157_1.time_ < var_160_18 + var_160_19 + arg_160_0 then
				local var_160_22 = Color.New(0, 0, 0)

				var_160_22.a = 1
				arg_157_1.mask_.color = var_160_22
			end

			local var_160_23 = 2

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_24 = 2

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24
				local var_160_26 = Color.New(0, 0, 0)

				var_160_26.a = Mathf.Lerp(1, 0, var_160_25)
				arg_157_1.mask_.color = var_160_26
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 then
				local var_160_27 = Color.New(0, 0, 0)
				local var_160_28 = 0

				arg_157_1.mask_.enabled = false
				var_160_27.a = var_160_28
				arg_157_1.mask_.color = var_160_27
			end

			local var_160_29 = 0.1
			local var_160_30 = 1

			if var_160_29 < arg_157_1.time_ and arg_157_1.time_ <= var_160_29 + arg_160_0 then
				local var_160_31 = "stop"
				local var_160_32 = "effect"

				arg_157_1:AudioAction(var_160_31, var_160_32, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_160_33 = 1.6
			local var_160_34 = 1

			if var_160_33 < arg_157_1.time_ and arg_157_1.time_ <= var_160_33 + arg_160_0 then
				local var_160_35 = "play"
				local var_160_36 = "effect"

				arg_157_1:AudioAction(var_160_35, var_160_36, "se_story_140", "se_story_140_amb_drain", "")
			end

			local var_160_37 = 0.1
			local var_160_38 = 1

			if var_160_37 < arg_157_1.time_ and arg_157_1.time_ <= var_160_37 + arg_160_0 then
				local var_160_39 = "stop"
				local var_160_40 = "effect"

				arg_157_1:AudioAction(var_160_39, var_160_40, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_41 = 4
			local var_160_42 = 0.575

			if var_160_41 < arg_157_1.time_ and arg_157_1.time_ <= var_160_41 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_43 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_43:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_44 = arg_157_1:FormatText(StoryNameCfg[1346].name)

				arg_157_1.leftNameTxt_.text = var_160_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_45 = arg_157_1:GetWordFromCfg(423101037)
				local var_160_46 = arg_157_1:FormatText(var_160_45.content)

				arg_157_1.text_.text = var_160_46

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_47 = 23
				local var_160_48 = utf8.len(var_160_46)
				local var_160_49 = var_160_47 <= 0 and var_160_42 or var_160_42 * (var_160_48 / var_160_47)

				if var_160_49 > 0 and var_160_42 < var_160_49 then
					arg_157_1.talkMaxDuration = var_160_49
					var_160_41 = var_160_41 + 0.3

					if var_160_49 + var_160_41 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_49 + var_160_41
					end
				end

				arg_157_1.text_.text = var_160_46
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101037", "story_v_out_423101.awb") ~= 0 then
					local var_160_50 = manager.audio:GetVoiceLength("story_v_out_423101", "423101037", "story_v_out_423101.awb") / 1000

					if var_160_50 + var_160_41 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_50 + var_160_41
					end

					if var_160_45.prefab_name ~= "" and arg_157_1.actors_[var_160_45.prefab_name] ~= nil then
						local var_160_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_45.prefab_name].transform, "story_v_out_423101", "423101037", "story_v_out_423101.awb")

						arg_157_1:RecordAudio("423101037", var_160_51)
						arg_157_1:RecordAudio("423101037", var_160_51)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_423101", "423101037", "story_v_out_423101.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_423101", "423101037", "story_v_out_423101.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_52 = var_160_41 + 0.3
			local var_160_53 = math.max(var_160_42, arg_157_1.talkMaxDuration)

			if var_160_52 <= arg_157_1.time_ and arg_157_1.time_ < var_160_52 + var_160_53 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_52) / var_160_53

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_52 + var_160_53 and arg_157_1.time_ < var_160_52 + var_160_53 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423101038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423101038
		arg_163_1.duration_ = 4.6

		local var_163_0 = {
			zh = 1.866,
			ja = 4.6
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
				arg_163_0:Play423101039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.225

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[1345].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_7")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(423101038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 9
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101038", "story_v_out_423101.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101038", "story_v_out_423101.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_423101", "423101038", "story_v_out_423101.awb")

						arg_163_1:RecordAudio("423101038", var_166_9)
						arg_163_1:RecordAudio("423101038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_423101", "423101038", "story_v_out_423101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_423101", "423101038", "story_v_out_423101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play423101039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423101039
		arg_167_1.duration_ = 8.6

		local var_167_0 = {
			zh = 8.533,
			ja = 8.6
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
				arg_167_0:Play423101040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1083"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1083 == nil then
				arg_167_1.var_.actorSpriteComps1083 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps1083 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1083 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1083 = nil
			end

			local var_170_8 = 0
			local var_170_9 = 0.725

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_10 = arg_167_1:FormatText(StoryNameCfg[1343].name)

				arg_167_1.leftNameTxt_.text = var_170_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_11 = arg_167_1:GetWordFromCfg(423101039)
				local var_170_12 = arg_167_1:FormatText(var_170_11.content)

				arg_167_1.text_.text = var_170_12

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 29
				local var_170_14 = utf8.len(var_170_12)
				local var_170_15 = var_170_13 <= 0 and var_170_9 or var_170_9 * (var_170_14 / var_170_13)

				if var_170_15 > 0 and var_170_9 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_12
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101039", "story_v_out_423101.awb") ~= 0 then
					local var_170_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101039", "story_v_out_423101.awb") / 1000

					if var_170_16 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_8
					end

					if var_170_11.prefab_name ~= "" and arg_167_1.actors_[var_170_11.prefab_name] ~= nil then
						local var_170_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_11.prefab_name].transform, "story_v_out_423101", "423101039", "story_v_out_423101.awb")

						arg_167_1:RecordAudio("423101039", var_170_17)
						arg_167_1:RecordAudio("423101039", var_170_17)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_423101", "423101039", "story_v_out_423101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_423101", "423101039", "story_v_out_423101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_18 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_18

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_18 and arg_167_1.time_ < var_170_8 + var_170_18 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423101040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423101040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play423101041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1083"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1083 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1083", 7)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(0, -2000, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1083, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_174_7 = 0.034
			local var_174_8 = 1

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				local var_174_9 = "play"
				local var_174_10 = "effect"

				arg_171_1:AudioAction(var_174_9, var_174_10, "se_story_144", "se_story_144_horse", "")
			end

			local var_174_11 = 0
			local var_174_12 = 1.6

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(423101040)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 64
				local var_174_16 = utf8.len(var_174_14)
				local var_174_17 = var_174_15 <= 0 and var_174_12 or var_174_12 * (var_174_16 / var_174_15)

				if var_174_17 > 0 and var_174_12 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17

					if var_174_17 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_11
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_18 = math.max(var_174_12, arg_171_1.talkMaxDuration)

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_18 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_11) / var_174_18

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_11 + var_174_18 and arg_171_1.time_ < var_174_11 + var_174_18 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423101041
		arg_175_1.duration_ = 10.47

		local var_175_0 = {
			zh = 6,
			ja = 10.466
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
				arg_175_0:Play423101042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "10146"

			if arg_175_1.actors_[var_178_0] == nil then
				local var_178_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

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

			local var_178_4 = arg_175_1.actors_["10146"]
			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps10146 == nil then
				arg_175_1.var_.actorSpriteComps10146 = var_178_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 0.2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 and not isNil(var_178_4) then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6

				if arg_175_1.var_.actorSpriteComps10146 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10146:ToTable()) do
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

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps10146 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_178_5 then
						if arg_175_1.isInRecall_ then
							iter_178_5.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10146 = nil
			end

			local var_178_12 = arg_175_1.actors_["10146"].transform
			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1.var_.moveOldPos10146 = var_178_12.localPosition
				var_178_12.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10146", 3)

				local var_178_14 = var_178_12.childCount

				for iter_178_6 = 0, var_178_14 - 1 do
					local var_178_15 = var_178_12:GetChild(iter_178_6)

					if var_178_15.name == "split_6" or not string.find(var_178_15.name, "split") then
						var_178_15.gameObject:SetActive(true)
					else
						var_178_15.gameObject:SetActive(false)
					end
				end
			end

			local var_178_16 = 0.001

			if var_178_13 <= arg_175_1.time_ and arg_175_1.time_ < var_178_13 + var_178_16 then
				local var_178_17 = (arg_175_1.time_ - var_178_13) / var_178_16
				local var_178_18 = Vector3.New(0, -350, -320)

				var_178_12.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10146, var_178_18, var_178_17)
			end

			if arg_175_1.time_ >= var_178_13 + var_178_16 and arg_175_1.time_ < var_178_13 + var_178_16 + arg_178_0 then
				var_178_12.localPosition = Vector3.New(0, -350, -320)
			end

			local var_178_19 = arg_175_1.actors_["10146"]
			local var_178_20 = 0

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				local var_178_21 = var_178_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_178_21 then
					arg_175_1.var_.alphaOldValue10146 = var_178_21.alpha
					arg_175_1.var_.characterEffect10146 = var_178_21
				end

				arg_175_1.var_.alphaOldValue10146 = 0
			end

			local var_178_22 = 0.5

			if var_178_20 <= arg_175_1.time_ and arg_175_1.time_ < var_178_20 + var_178_22 then
				local var_178_23 = (arg_175_1.time_ - var_178_20) / var_178_22
				local var_178_24 = Mathf.Lerp(arg_175_1.var_.alphaOldValue10146, 1, var_178_23)

				if arg_175_1.var_.characterEffect10146 then
					arg_175_1.var_.characterEffect10146.alpha = var_178_24
				end
			end

			if arg_175_1.time_ >= var_178_20 + var_178_22 and arg_175_1.time_ < var_178_20 + var_178_22 + arg_178_0 and arg_175_1.var_.characterEffect10146 then
				arg_175_1.var_.characterEffect10146.alpha = 1
			end

			local var_178_25 = 0
			local var_178_26 = 0.725

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_27 = arg_175_1:FormatText(StoryNameCfg[1338].name)

				arg_175_1.leftNameTxt_.text = var_178_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_28 = arg_175_1:GetWordFromCfg(423101041)
				local var_178_29 = arg_175_1:FormatText(var_178_28.content)

				arg_175_1.text_.text = var_178_29

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_30 = 29
				local var_178_31 = utf8.len(var_178_29)
				local var_178_32 = var_178_30 <= 0 and var_178_26 or var_178_26 * (var_178_31 / var_178_30)

				if var_178_32 > 0 and var_178_26 < var_178_32 then
					arg_175_1.talkMaxDuration = var_178_32

					if var_178_32 + var_178_25 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_32 + var_178_25
					end
				end

				arg_175_1.text_.text = var_178_29
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101041", "story_v_out_423101.awb") ~= 0 then
					local var_178_33 = manager.audio:GetVoiceLength("story_v_out_423101", "423101041", "story_v_out_423101.awb") / 1000

					if var_178_33 + var_178_25 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_33 + var_178_25
					end

					if var_178_28.prefab_name ~= "" and arg_175_1.actors_[var_178_28.prefab_name] ~= nil then
						local var_178_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_28.prefab_name].transform, "story_v_out_423101", "423101041", "story_v_out_423101.awb")

						arg_175_1:RecordAudio("423101041", var_178_34)
						arg_175_1:RecordAudio("423101041", var_178_34)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_423101", "423101041", "story_v_out_423101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_423101", "423101041", "story_v_out_423101.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_35 = math.max(var_178_26, arg_175_1.talkMaxDuration)

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_35 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_25) / var_178_35

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_25 + var_178_35 and arg_175_1.time_ < var_178_25 + var_178_35 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423101042
		arg_179_1.duration_ = 14.8

		local var_179_0 = {
			zh = 9.7,
			ja = 14.8
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
				arg_179_0:Play423101043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10146"].transform
			local var_182_1 = 0.5

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10146 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10146", 3)

				local var_182_2 = var_182_0.childCount

				for iter_182_0 = 0, var_182_2 - 1 do
					local var_182_3 = var_182_0:GetChild(iter_182_0)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_4 then
				local var_182_5 = (arg_179_1.time_ - var_182_1) / var_182_4
				local var_182_6 = Vector3.New(0, -350, -320)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10146, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			local var_182_8 = 0.5

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_9 = 0
			local var_182_10 = 1

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_11 = arg_179_1:FormatText(StoryNameCfg[1338].name)

				arg_179_1.leftNameTxt_.text = var_182_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_12 = arg_179_1:GetWordFromCfg(423101042)
				local var_182_13 = arg_179_1:FormatText(var_182_12.content)

				arg_179_1.text_.text = var_182_13

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_14 = 40
				local var_182_15 = utf8.len(var_182_13)
				local var_182_16 = var_182_14 <= 0 and var_182_10 or var_182_10 * (var_182_15 / var_182_14)

				if var_182_16 > 0 and var_182_10 < var_182_16 then
					arg_179_1.talkMaxDuration = var_182_16

					if var_182_16 + var_182_9 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_9
					end
				end

				arg_179_1.text_.text = var_182_13
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101042", "story_v_out_423101.awb") ~= 0 then
					local var_182_17 = manager.audio:GetVoiceLength("story_v_out_423101", "423101042", "story_v_out_423101.awb") / 1000

					if var_182_17 + var_182_9 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_9
					end

					if var_182_12.prefab_name ~= "" and arg_179_1.actors_[var_182_12.prefab_name] ~= nil then
						local var_182_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_12.prefab_name].transform, "story_v_out_423101", "423101042", "story_v_out_423101.awb")

						arg_179_1:RecordAudio("423101042", var_182_18)
						arg_179_1:RecordAudio("423101042", var_182_18)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423101", "423101042", "story_v_out_423101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423101", "423101042", "story_v_out_423101.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_19 = math.max(var_182_10, arg_179_1.talkMaxDuration)

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_19 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_9) / var_182_19

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_9 + var_182_19 and arg_179_1.time_ < var_182_9 + var_182_19 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play423101043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423101043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423101044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10146"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10146 == nil then
				arg_183_1.var_.actorSpriteComps10146 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps10146 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 0.5, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10146 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10146 = nil
			end

			local var_186_8 = arg_183_1.actors_["10146"].transform
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.var_.moveOldPos10146 = var_186_8.localPosition
				var_186_8.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10146", 7)

				local var_186_10 = var_186_8.childCount

				for iter_186_4 = 0, var_186_10 - 1 do
					local var_186_11 = var_186_8:GetChild(iter_186_4)

					if var_186_11.name == "" or not string.find(var_186_11.name, "split") then
						var_186_11.gameObject:SetActive(true)
					else
						var_186_11.gameObject:SetActive(false)
					end
				end
			end

			local var_186_12 = 0.001

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_9) / var_186_12
				local var_186_14 = Vector3.New(0, -2000, 0)

				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10146, var_186_14, var_186_13)
			end

			if arg_183_1.time_ >= var_186_9 + var_186_12 and arg_183_1.time_ < var_186_9 + var_186_12 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_15 = 0
			local var_186_16 = 1.275

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_17 = arg_183_1:GetWordFromCfg(423101043)
				local var_186_18 = arg_183_1:FormatText(var_186_17.content)

				arg_183_1.text_.text = var_186_18

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 51
				local var_186_20 = utf8.len(var_186_18)
				local var_186_21 = var_186_19 <= 0 and var_186_16 or var_186_16 * (var_186_20 / var_186_19)

				if var_186_21 > 0 and var_186_16 < var_186_21 then
					arg_183_1.talkMaxDuration = var_186_21

					if var_186_21 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_21 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_18
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_22 and arg_183_1.time_ < var_186_15 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play423101044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423101044
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423101045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.05

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

				local var_190_2 = arg_187_1:GetWordFromCfg(423101044)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 42
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
	Play423101045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423101045
		arg_191_1.duration_ = 4.97

		local var_191_0 = {
			zh = 4.5,
			ja = 4.966
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
				arg_191_0:Play423101046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10146"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10146 == nil then
				arg_191_1.var_.actorSpriteComps10146 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps10146 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								local var_194_4 = Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, var_194_3)
								local var_194_5 = Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, var_194_3)
								local var_194_6 = Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, var_194_3)

								iter_194_1.color = Color.New(var_194_4, var_194_5, var_194_6)
							else
								local var_194_7 = Mathf.Lerp(iter_194_1.color.r, 1, var_194_3)

								iter_194_1.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10146 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10146 = nil
			end

			local var_194_8 = arg_191_1.actors_["10146"].transform
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.var_.moveOldPos10146 = var_194_8.localPosition
				var_194_8.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10146", 3)

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
				local var_194_14 = Vector3.New(0, -350, -320)

				var_194_8.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10146, var_194_14, var_194_13)
			end

			if arg_191_1.time_ >= var_194_9 + var_194_12 and arg_191_1.time_ < var_194_9 + var_194_12 + arg_194_0 then
				var_194_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_194_15 = 0
			local var_194_16 = 0.3

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[1338].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(423101045)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 12
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101045", "story_v_out_423101.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101045", "story_v_out_423101.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_423101", "423101045", "story_v_out_423101.awb")

						arg_191_1:RecordAudio("423101045", var_194_24)
						arg_191_1:RecordAudio("423101045", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_423101", "423101045", "story_v_out_423101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_423101", "423101045", "story_v_out_423101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423101046
		arg_195_1.duration_ = 7.23

		local var_195_0 = {
			zh = 6.5326667,
			ja = 7.2326667
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
				arg_195_0:Play423101047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = "STblack"

			if arg_195_1.bgs_[var_198_0] == nil then
				local var_198_1 = Object.Instantiate(arg_195_1.paintGo_)

				var_198_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_198_0)
				var_198_1.name = var_198_0
				var_198_1.transform.parent = arg_195_1.stage_.transform
				var_198_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.bgs_[var_198_0] = var_198_1
			end

			local var_198_2 = 0.5666667

			if var_198_2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				local var_198_3 = manager.ui.mainCamera.transform.localPosition
				local var_198_4 = Vector3.New(0, 0, 10) + Vector3.New(var_198_3.x, var_198_3.y, 0)
				local var_198_5 = arg_195_1.bgs_.STblack

				var_198_5.transform.localPosition = var_198_4
				var_198_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_6 = var_198_5:GetComponent("SpriteRenderer")

				if var_198_6 and var_198_6.sprite then
					local var_198_7 = (var_198_5.transform.localPosition - var_198_3).z
					local var_198_8 = manager.ui.mainCameraCom_
					local var_198_9 = 2 * var_198_7 * Mathf.Tan(var_198_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_198_10 = var_198_9 * var_198_8.aspect
					local var_198_11 = var_198_6.sprite.bounds.size.x
					local var_198_12 = var_198_6.sprite.bounds.size.y
					local var_198_13 = var_198_10 / var_198_11
					local var_198_14 = var_198_9 / var_198_12
					local var_198_15 = var_198_14 < var_198_13 and var_198_13 or var_198_14

					var_198_5.transform.localScale = Vector3.New(var_198_15, var_198_15, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "STblack" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_17 = 0.366666666666667

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17
				local var_198_19 = Color.New(1, 1, 1)

				var_198_19.a = Mathf.Lerp(1, 0, var_198_18)
				arg_195_1.mask_.color = var_198_19
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 then
				local var_198_20 = Color.New(1, 1, 1)
				local var_198_21 = 0

				arg_195_1.mask_.enabled = false
				var_198_20.a = var_198_21
				arg_195_1.mask_.color = var_198_20
			end

			local var_198_22 = 0.366666666666667

			if var_198_22 < arg_195_1.time_ and arg_195_1.time_ <= var_198_22 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_23 = 0.1

			if var_198_22 <= arg_195_1.time_ and arg_195_1.time_ < var_198_22 + var_198_23 then
				local var_198_24 = (arg_195_1.time_ - var_198_22) / var_198_23
				local var_198_25 = Color.New(1, 1, 1)

				var_198_25.a = Mathf.Lerp(1, 0, var_198_24)
				arg_195_1.mask_.color = var_198_25
			end

			if arg_195_1.time_ >= var_198_22 + var_198_23 and arg_195_1.time_ < var_198_22 + var_198_23 + arg_198_0 then
				local var_198_26 = Color.New(1, 1, 1)
				local var_198_27 = 0

				arg_195_1.mask_.enabled = false
				var_198_26.a = var_198_27
				arg_195_1.mask_.color = var_198_26
			end

			local var_198_28 = 0.5666667

			if var_198_28 < arg_195_1.time_ and arg_195_1.time_ <= var_198_28 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_29 = 0.1

			if var_198_28 <= arg_195_1.time_ and arg_195_1.time_ < var_198_28 + var_198_29 then
				local var_198_30 = (arg_195_1.time_ - var_198_28) / var_198_29
				local var_198_31 = Color.New(1, 1, 1)

				var_198_31.a = Mathf.Lerp(1, 0, var_198_30)
				arg_195_1.mask_.color = var_198_31
			end

			if arg_195_1.time_ >= var_198_28 + var_198_29 and arg_195_1.time_ < var_198_28 + var_198_29 + arg_198_0 then
				local var_198_32 = Color.New(1, 1, 1)
				local var_198_33 = 0

				arg_195_1.mask_.enabled = false
				var_198_32.a = var_198_33
				arg_195_1.mask_.color = var_198_32
			end

			local var_198_34 = arg_195_1.actors_["10146"].transform
			local var_198_35 = 0

			if var_198_35 < arg_195_1.time_ and arg_195_1.time_ <= var_198_35 + arg_198_0 then
				arg_195_1.var_.moveOldPos10146 = var_198_34.localPosition
				var_198_34.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10146", 7)

				local var_198_36 = var_198_34.childCount

				for iter_198_2 = 0, var_198_36 - 1 do
					local var_198_37 = var_198_34:GetChild(iter_198_2)

					if var_198_37.name == "" or not string.find(var_198_37.name, "split") then
						var_198_37.gameObject:SetActive(true)
					else
						var_198_37.gameObject:SetActive(false)
					end
				end
			end

			local var_198_38 = 0.001

			if var_198_35 <= arg_195_1.time_ and arg_195_1.time_ < var_198_35 + var_198_38 then
				local var_198_39 = (arg_195_1.time_ - var_198_35) / var_198_38
				local var_198_40 = Vector3.New(0, -2000, 0)

				var_198_34.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10146, var_198_40, var_198_39)
			end

			if arg_195_1.time_ >= var_198_35 + var_198_38 and arg_195_1.time_ < var_198_35 + var_198_38 + arg_198_0 then
				var_198_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_41 = 0

			if var_198_41 < arg_195_1.time_ and arg_195_1.time_ <= var_198_41 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			local var_198_42 = 0.833333333333333

			if arg_195_1.time_ >= var_198_41 + var_198_42 and arg_195_1.time_ < var_198_41 + var_198_42 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			local var_198_43 = 0
			local var_198_44 = 1

			if var_198_43 < arg_195_1.time_ and arg_195_1.time_ <= var_198_43 + arg_198_0 then
				local var_198_45 = "play"
				local var_198_46 = "effect"

				arg_195_1:AudioAction(var_198_45, var_198_46, "se_story_144", "se_story_144_metal02", "")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_47 = 0.6666667
			local var_198_48 = 0.35

			if var_198_47 < arg_195_1.time_ and arg_195_1.time_ <= var_198_47 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_49 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_49:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_50 = arg_195_1:FormatText(StoryNameCfg[1338].name)

				arg_195_1.leftNameTxt_.text = var_198_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10146_split_5")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_51 = arg_195_1:GetWordFromCfg(423101046)
				local var_198_52 = arg_195_1:FormatText(var_198_51.content)

				arg_195_1.text_.text = var_198_52

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_53 = 14
				local var_198_54 = utf8.len(var_198_52)
				local var_198_55 = var_198_53 <= 0 and var_198_48 or var_198_48 * (var_198_54 / var_198_53)

				if var_198_55 > 0 and var_198_48 < var_198_55 then
					arg_195_1.talkMaxDuration = var_198_55
					var_198_47 = var_198_47 + 0.3

					if var_198_55 + var_198_47 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_55 + var_198_47
					end
				end

				arg_195_1.text_.text = var_198_52
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101046", "story_v_out_423101.awb") ~= 0 then
					local var_198_56 = manager.audio:GetVoiceLength("story_v_out_423101", "423101046", "story_v_out_423101.awb") / 1000

					if var_198_56 + var_198_47 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_56 + var_198_47
					end

					if var_198_51.prefab_name ~= "" and arg_195_1.actors_[var_198_51.prefab_name] ~= nil then
						local var_198_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_51.prefab_name].transform, "story_v_out_423101", "423101046", "story_v_out_423101.awb")

						arg_195_1:RecordAudio("423101046", var_198_57)
						arg_195_1:RecordAudio("423101046", var_198_57)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_423101", "423101046", "story_v_out_423101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_423101", "423101046", "story_v_out_423101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_58 = var_198_47 + 0.3
			local var_198_59 = math.max(var_198_48, arg_195_1.talkMaxDuration)

			if var_198_58 <= arg_195_1.time_ and arg_195_1.time_ < var_198_58 + var_198_59 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_58) / var_198_59

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_58 + var_198_59 and arg_195_1.time_ < var_198_58 + var_198_59 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 423101047
		arg_201_1.duration_ = 6.33

		local var_201_0 = {
			zh = 5.433,
			ja = 6.333
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
				arg_201_0:Play423101048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.65

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[1338].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10146_split_3")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(423101047)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 26
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101047", "story_v_out_423101.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101047", "story_v_out_423101.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_423101", "423101047", "story_v_out_423101.awb")

						arg_201_1:RecordAudio("423101047", var_204_9)
						arg_201_1:RecordAudio("423101047", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_423101", "423101047", "story_v_out_423101.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_423101", "423101047", "story_v_out_423101.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play423101048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423101048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play423101049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.225

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(423101048)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 49
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play423101049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423101049
		arg_209_1.duration_ = 7.7

		local var_209_0 = {
			zh = 3.966,
			ja = 7.7
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play423101050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10146"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10146 == nil then
				arg_209_1.var_.actorSpriteComps10146 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10146 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 1, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10146 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10146 = nil
			end

			local var_212_8 = arg_209_1.actors_["10146"].transform
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.var_.moveOldPos10146 = var_212_8.localPosition
				var_212_8.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10146", 3)

				local var_212_10 = var_212_8.childCount

				for iter_212_4 = 0, var_212_10 - 1 do
					local var_212_11 = var_212_8:GetChild(iter_212_4)

					if var_212_11.name == "split_3" or not string.find(var_212_11.name, "split") then
						var_212_11.gameObject:SetActive(true)
					else
						var_212_11.gameObject:SetActive(false)
					end
				end
			end

			local var_212_12 = 0.001

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_9) / var_212_12
				local var_212_14 = Vector3.New(0, -350, -320)

				var_212_8.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10146, var_212_14, var_212_13)
			end

			if arg_209_1.time_ >= var_212_9 + var_212_12 and arg_209_1.time_ < var_212_9 + var_212_12 + arg_212_0 then
				var_212_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_212_15 = arg_209_1.actors_["10146"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				local var_212_17 = var_212_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_17 then
					arg_209_1.var_.alphaOldValue10146 = var_212_17.alpha
					arg_209_1.var_.characterEffect10146 = var_212_17
				end

				arg_209_1.var_.alphaOldValue10146 = 0
			end

			local var_212_18 = 0.5

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_18 then
				local var_212_19 = (arg_209_1.time_ - var_212_16) / var_212_18
				local var_212_20 = Mathf.Lerp(arg_209_1.var_.alphaOldValue10146, 1, var_212_19)

				if arg_209_1.var_.characterEffect10146 then
					arg_209_1.var_.characterEffect10146.alpha = var_212_20
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_18 and arg_209_1.time_ < var_212_16 + var_212_18 + arg_212_0 and arg_209_1.var_.characterEffect10146 then
				arg_209_1.var_.characterEffect10146.alpha = 1
			end

			local var_212_21 = 0
			local var_212_22 = 0.425

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_23 = arg_209_1:FormatText(StoryNameCfg[1338].name)

				arg_209_1.leftNameTxt_.text = var_212_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_24 = arg_209_1:GetWordFromCfg(423101049)
				local var_212_25 = arg_209_1:FormatText(var_212_24.content)

				arg_209_1.text_.text = var_212_25

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_26 = 17
				local var_212_27 = utf8.len(var_212_25)
				local var_212_28 = var_212_26 <= 0 and var_212_22 or var_212_22 * (var_212_27 / var_212_26)

				if var_212_28 > 0 and var_212_22 < var_212_28 then
					arg_209_1.talkMaxDuration = var_212_28

					if var_212_28 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_21
					end
				end

				arg_209_1.text_.text = var_212_25
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101049", "story_v_out_423101.awb") ~= 0 then
					local var_212_29 = manager.audio:GetVoiceLength("story_v_out_423101", "423101049", "story_v_out_423101.awb") / 1000

					if var_212_29 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_29 + var_212_21
					end

					if var_212_24.prefab_name ~= "" and arg_209_1.actors_[var_212_24.prefab_name] ~= nil then
						local var_212_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_24.prefab_name].transform, "story_v_out_423101", "423101049", "story_v_out_423101.awb")

						arg_209_1:RecordAudio("423101049", var_212_30)
						arg_209_1:RecordAudio("423101049", var_212_30)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_423101", "423101049", "story_v_out_423101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_423101", "423101049", "story_v_out_423101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_31 = math.max(var_212_22, arg_209_1.talkMaxDuration)

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_31 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_21) / var_212_31

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_21 + var_212_31 and arg_209_1.time_ < var_212_21 + var_212_31 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play423101050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423101050
		arg_213_1.duration_ = 7.77

		local var_213_0 = {
			zh = 7.366,
			ja = 7.766
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play423101051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.7

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1338].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(423101050)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 28
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101050", "story_v_out_423101.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101050", "story_v_out_423101.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_423101", "423101050", "story_v_out_423101.awb")

						arg_213_1:RecordAudio("423101050", var_216_9)
						arg_213_1:RecordAudio("423101050", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_423101", "423101050", "story_v_out_423101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_423101", "423101050", "story_v_out_423101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423101051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423101051
		arg_217_1.duration_ = 5.7

		local var_217_0 = {
			zh = 5.2,
			ja = 5.7
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play423101052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10146"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10146 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10146", 3)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_5" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(0, -350, -320)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10146, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_220_7 = manager.ui.mainCamera.transform
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.var_.shakeOldPos = var_220_7.localPosition
			end

			local var_220_9 = 0.6

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / 0.066
				local var_220_11, var_220_12 = math.modf(var_220_10)

				var_220_7.localPosition = Vector3.New(var_220_12 * 0.13, var_220_12 * 0.13, var_220_12 * 0.13) + arg_217_1.var_.shakeOldPos
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 then
				var_220_7.localPosition = arg_217_1.var_.shakeOldPos
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_14 = 0.6

			if arg_217_1.time_ >= var_220_13 + var_220_14 and arg_217_1.time_ < var_220_13 + var_220_14 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_15 = 0.034
			local var_220_16 = 1

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				local var_220_17 = "play"
				local var_220_18 = "effect"

				arg_217_1:AudioAction(var_220_17, var_220_18, "se_story_144", "se_story_144_saw", "")
			end

			local var_220_19 = 0
			local var_220_20 = 0.4

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_21 = arg_217_1:FormatText(StoryNameCfg[1338].name)

				arg_217_1.leftNameTxt_.text = var_220_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_22 = arg_217_1:GetWordFromCfg(423101051)
				local var_220_23 = arg_217_1:FormatText(var_220_22.content)

				arg_217_1.text_.text = var_220_23

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_24 = 16
				local var_220_25 = utf8.len(var_220_23)
				local var_220_26 = var_220_24 <= 0 and var_220_20 or var_220_20 * (var_220_25 / var_220_24)

				if var_220_26 > 0 and var_220_20 < var_220_26 then
					arg_217_1.talkMaxDuration = var_220_26

					if var_220_26 + var_220_19 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_26 + var_220_19
					end
				end

				arg_217_1.text_.text = var_220_23
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101051", "story_v_out_423101.awb") ~= 0 then
					local var_220_27 = manager.audio:GetVoiceLength("story_v_out_423101", "423101051", "story_v_out_423101.awb") / 1000

					if var_220_27 + var_220_19 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_27 + var_220_19
					end

					if var_220_22.prefab_name ~= "" and arg_217_1.actors_[var_220_22.prefab_name] ~= nil then
						local var_220_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_22.prefab_name].transform, "story_v_out_423101", "423101051", "story_v_out_423101.awb")

						arg_217_1:RecordAudio("423101051", var_220_28)
						arg_217_1:RecordAudio("423101051", var_220_28)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_423101", "423101051", "story_v_out_423101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_423101", "423101051", "story_v_out_423101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_29 = math.max(var_220_20, arg_217_1.talkMaxDuration)

			if var_220_19 <= arg_217_1.time_ and arg_217_1.time_ < var_220_19 + var_220_29 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_19) / var_220_29

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_19 + var_220_29 and arg_217_1.time_ < var_220_19 + var_220_29 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play423101052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423101052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play423101053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10146"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10146 == nil then
				arg_221_1.var_.actorSpriteComps10146 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10146 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10146 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10146 = nil
			end

			local var_224_8 = arg_221_1.actors_["10146"].transform
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.var_.moveOldPos10146 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10146", 7)

				local var_224_10 = var_224_8.childCount

				for iter_224_4 = 0, var_224_10 - 1 do
					local var_224_11 = var_224_8:GetChild(iter_224_4)

					if var_224_11.name == "" or not string.find(var_224_11.name, "split") then
						var_224_11.gameObject:SetActive(true)
					else
						var_224_11.gameObject:SetActive(false)
					end
				end
			end

			local var_224_12 = 0.001

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_9) / var_224_12
				local var_224_14 = Vector3.New(0, -2000, 0)

				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10146, var_224_14, var_224_13)
			end

			if arg_221_1.time_ >= var_224_9 + var_224_12 and arg_221_1.time_ < var_224_9 + var_224_12 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_224_15 = 0.866666666666667
			local var_224_16 = 1

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				local var_224_17 = "play"
				local var_224_18 = "effect"

				arg_221_1:AudioAction(var_224_17, var_224_18, "se_story_4", "se_story_4_arm_2", "")
			end

			local var_224_19 = 0
			local var_224_20 = 1.7

			if var_224_19 < arg_221_1.time_ and arg_221_1.time_ <= var_224_19 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_21 = arg_221_1:GetWordFromCfg(423101052)
				local var_224_22 = arg_221_1:FormatText(var_224_21.content)

				arg_221_1.text_.text = var_224_22

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_23 = 68
				local var_224_24 = utf8.len(var_224_22)
				local var_224_25 = var_224_23 <= 0 and var_224_20 or var_224_20 * (var_224_24 / var_224_23)

				if var_224_25 > 0 and var_224_20 < var_224_25 then
					arg_221_1.talkMaxDuration = var_224_25

					if var_224_25 + var_224_19 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_19
					end
				end

				arg_221_1.text_.text = var_224_22
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_26 = math.max(var_224_20, arg_221_1.talkMaxDuration)

			if var_224_19 <= arg_221_1.time_ and arg_221_1.time_ < var_224_19 + var_224_26 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_19) / var_224_26

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_19 + var_224_26 and arg_221_1.time_ < var_224_19 + var_224_26 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play423101053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423101053
		arg_225_1.duration_ = 15.67

		local var_225_0 = {
			zh = 11.6,
			ja = 15.666
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play423101054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10146"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10146 == nil then
				arg_225_1.var_.actorSpriteComps10146 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10146 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 1, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10146 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10146 = nil
			end

			local var_228_8 = arg_225_1.actors_["10146"].transform
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1.var_.moveOldPos10146 = var_228_8.localPosition
				var_228_8.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10146", 3)

				local var_228_10 = var_228_8.childCount

				for iter_228_4 = 0, var_228_10 - 1 do
					local var_228_11 = var_228_8:GetChild(iter_228_4)

					if var_228_11.name == "split_3" or not string.find(var_228_11.name, "split") then
						var_228_11.gameObject:SetActive(true)
					else
						var_228_11.gameObject:SetActive(false)
					end
				end
			end

			local var_228_12 = 0.001

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_9) / var_228_12
				local var_228_14 = Vector3.New(0, -350, -320)

				var_228_8.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10146, var_228_14, var_228_13)
			end

			if arg_225_1.time_ >= var_228_9 + var_228_12 and arg_225_1.time_ < var_228_9 + var_228_12 + arg_228_0 then
				var_228_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_228_15 = arg_225_1.actors_["10146"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				local var_228_17 = var_228_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_17 then
					arg_225_1.var_.alphaOldValue10146 = var_228_17.alpha
					arg_225_1.var_.characterEffect10146 = var_228_17
				end

				arg_225_1.var_.alphaOldValue10146 = 0
			end

			local var_228_18 = 1

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_18 then
				local var_228_19 = (arg_225_1.time_ - var_228_16) / var_228_18
				local var_228_20 = Mathf.Lerp(arg_225_1.var_.alphaOldValue10146, 1, var_228_19)

				if arg_225_1.var_.characterEffect10146 then
					arg_225_1.var_.characterEffect10146.alpha = var_228_20
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_18 and arg_225_1.time_ < var_228_16 + var_228_18 + arg_228_0 and arg_225_1.var_.characterEffect10146 then
				arg_225_1.var_.characterEffect10146.alpha = 1
			end

			local var_228_21 = 0.666666666666667
			local var_228_22 = 1

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				local var_228_23 = "play"
				local var_228_24 = "effect"

				arg_225_1:AudioAction(var_228_23, var_228_24, "se_story_144", "se_story_144_saw", "")
			end

			local var_228_25 = 0
			local var_228_26 = 0.875

			if var_228_25 < arg_225_1.time_ and arg_225_1.time_ <= var_228_25 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_27 = arg_225_1:FormatText(StoryNameCfg[1338].name)

				arg_225_1.leftNameTxt_.text = var_228_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_28 = arg_225_1:GetWordFromCfg(423101053)
				local var_228_29 = arg_225_1:FormatText(var_228_28.content)

				arg_225_1.text_.text = var_228_29

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_30 = 35
				local var_228_31 = utf8.len(var_228_29)
				local var_228_32 = var_228_30 <= 0 and var_228_26 or var_228_26 * (var_228_31 / var_228_30)

				if var_228_32 > 0 and var_228_26 < var_228_32 then
					arg_225_1.talkMaxDuration = var_228_32

					if var_228_32 + var_228_25 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_32 + var_228_25
					end
				end

				arg_225_1.text_.text = var_228_29
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101053", "story_v_out_423101.awb") ~= 0 then
					local var_228_33 = manager.audio:GetVoiceLength("story_v_out_423101", "423101053", "story_v_out_423101.awb") / 1000

					if var_228_33 + var_228_25 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_33 + var_228_25
					end

					if var_228_28.prefab_name ~= "" and arg_225_1.actors_[var_228_28.prefab_name] ~= nil then
						local var_228_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_28.prefab_name].transform, "story_v_out_423101", "423101053", "story_v_out_423101.awb")

						arg_225_1:RecordAudio("423101053", var_228_34)
						arg_225_1:RecordAudio("423101053", var_228_34)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423101", "423101053", "story_v_out_423101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423101", "423101053", "story_v_out_423101.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_35 = math.max(var_228_26, arg_225_1.talkMaxDuration)

			if var_228_25 <= arg_225_1.time_ and arg_225_1.time_ < var_228_25 + var_228_35 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_25) / var_228_35

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_25 + var_228_35 and arg_225_1.time_ < var_228_25 + var_228_35 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play423101054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423101054
		arg_229_1.duration_ = 10.93

		local var_229_0 = {
			zh = 7.9,
			ja = 10.933
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play423101055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10146"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10146 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10146", 3)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "split_3" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(0, -350, -320)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10146, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_232_7 = 0
			local var_232_8 = 0.8

			if var_232_7 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_9 = arg_229_1:FormatText(StoryNameCfg[1338].name)

				arg_229_1.leftNameTxt_.text = var_232_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(423101054)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_12 = 32
				local var_232_13 = utf8.len(var_232_11)
				local var_232_14 = var_232_12 <= 0 and var_232_8 or var_232_8 * (var_232_13 / var_232_12)

				if var_232_14 > 0 and var_232_8 < var_232_14 then
					arg_229_1.talkMaxDuration = var_232_14

					if var_232_14 + var_232_7 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_7
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101054", "story_v_out_423101.awb") ~= 0 then
					local var_232_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101054", "story_v_out_423101.awb") / 1000

					if var_232_15 + var_232_7 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_7
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_out_423101", "423101054", "story_v_out_423101.awb")

						arg_229_1:RecordAudio("423101054", var_232_16)
						arg_229_1:RecordAudio("423101054", var_232_16)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_423101", "423101054", "story_v_out_423101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_423101", "423101054", "story_v_out_423101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_17 = math.max(var_232_8, arg_229_1.talkMaxDuration)

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_17 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_7) / var_232_17

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_7 + var_232_17 and arg_229_1.time_ < var_232_7 + var_232_17 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play423101055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423101055
		arg_233_1.duration_ = 11.97

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play423101056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "SS2303a"

			if arg_233_1.bgs_[var_236_0] == nil then
				local var_236_1 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_0)
				var_236_1.name = var_236_0
				var_236_1.transform.parent = arg_233_1.stage_.transform
				var_236_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_0] = var_236_1
			end

			local var_236_2 = 1

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				local var_236_3 = manager.ui.mainCamera.transform.localPosition
				local var_236_4 = Vector3.New(0, 0, 10) + Vector3.New(var_236_3.x, var_236_3.y, 0)
				local var_236_5 = arg_233_1.bgs_.SS2303a

				var_236_5.transform.localPosition = var_236_4
				var_236_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_6 = var_236_5:GetComponent("SpriteRenderer")

				if var_236_6 and var_236_6.sprite then
					local var_236_7 = (var_236_5.transform.localPosition - var_236_3).z
					local var_236_8 = manager.ui.mainCameraCom_
					local var_236_9 = 2 * var_236_7 * Mathf.Tan(var_236_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_10 = var_236_9 * var_236_8.aspect
					local var_236_11 = var_236_6.sprite.bounds.size.x
					local var_236_12 = var_236_6.sprite.bounds.size.y
					local var_236_13 = var_236_10 / var_236_11
					local var_236_14 = var_236_9 / var_236_12
					local var_236_15 = var_236_14 < var_236_13 and var_236_13 or var_236_14

					var_236_5.transform.localScale = Vector3.New(var_236_15, var_236_15, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "SS2303a" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_16 = 3

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_17 = 0.3

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_18 = 0

			if var_236_18 < arg_233_1.time_ and arg_233_1.time_ <= var_236_18 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_19 = 1

			if var_236_18 <= arg_233_1.time_ and arg_233_1.time_ < var_236_18 + var_236_19 then
				local var_236_20 = (arg_233_1.time_ - var_236_18) / var_236_19
				local var_236_21 = Color.New(0, 0, 0)

				var_236_21.a = Mathf.Lerp(0, 1, var_236_20)
				arg_233_1.mask_.color = var_236_21
			end

			if arg_233_1.time_ >= var_236_18 + var_236_19 and arg_233_1.time_ < var_236_18 + var_236_19 + arg_236_0 then
				local var_236_22 = Color.New(0, 0, 0)

				var_236_22.a = 1
				arg_233_1.mask_.color = var_236_22
			end

			local var_236_23 = 1

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_24 = 2

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24
				local var_236_26 = Color.New(0, 0, 0)

				var_236_26.a = Mathf.Lerp(1, 0, var_236_25)
				arg_233_1.mask_.color = var_236_26
			end

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 then
				local var_236_27 = Color.New(0, 0, 0)
				local var_236_28 = 0

				arg_233_1.mask_.enabled = false
				var_236_27.a = var_236_28
				arg_233_1.mask_.color = var_236_27
			end

			local var_236_29 = arg_233_1.actors_["10146"]
			local var_236_30 = 0.966

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.actorSpriteComps10146 == nil then
				arg_233_1.var_.actorSpriteComps10146 = var_236_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_31 = 0.034

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_31 and not isNil(var_236_29) then
				local var_236_32 = (arg_233_1.time_ - var_236_30) / var_236_31

				if arg_233_1.var_.actorSpriteComps10146 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_236_3 then
							if arg_233_1.isInRecall_ then
								local var_236_33 = Mathf.Lerp(iter_236_3.color.r, arg_233_1.hightColor2.r, var_236_32)
								local var_236_34 = Mathf.Lerp(iter_236_3.color.g, arg_233_1.hightColor2.g, var_236_32)
								local var_236_35 = Mathf.Lerp(iter_236_3.color.b, arg_233_1.hightColor2.b, var_236_32)

								iter_236_3.color = Color.New(var_236_33, var_236_34, var_236_35)
							else
								local var_236_36 = Mathf.Lerp(iter_236_3.color.r, 0.5, var_236_32)

								iter_236_3.color = Color.New(var_236_36, var_236_36, var_236_36)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_30 + var_236_31 and arg_233_1.time_ < var_236_30 + var_236_31 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.actorSpriteComps10146 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_236_5 then
						if arg_233_1.isInRecall_ then
							iter_236_5.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10146 = nil
			end

			local var_236_37 = arg_233_1.actors_["10146"].transform
			local var_236_38 = 0.966

			if var_236_38 < arg_233_1.time_ and arg_233_1.time_ <= var_236_38 + arg_236_0 then
				arg_233_1.var_.moveOldPos10146 = var_236_37.localPosition
				var_236_37.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10146", 7)

				local var_236_39 = var_236_37.childCount

				for iter_236_6 = 0, var_236_39 - 1 do
					local var_236_40 = var_236_37:GetChild(iter_236_6)

					if var_236_40.name == "" or not string.find(var_236_40.name, "split") then
						var_236_40.gameObject:SetActive(true)
					else
						var_236_40.gameObject:SetActive(false)
					end
				end
			end

			local var_236_41 = 0.001

			if var_236_38 <= arg_233_1.time_ and arg_233_1.time_ < var_236_38 + var_236_41 then
				local var_236_42 = (arg_233_1.time_ - var_236_38) / var_236_41
				local var_236_43 = Vector3.New(0, -2000, 0)

				var_236_37.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10146, var_236_43, var_236_42)
			end

			if arg_233_1.time_ >= var_236_38 + var_236_41 and arg_233_1.time_ < var_236_38 + var_236_41 + arg_236_0 then
				var_236_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_236_44 = manager.ui.mainCamera.transform
			local var_236_45 = 1

			if var_236_45 < arg_233_1.time_ and arg_233_1.time_ <= var_236_45 + arg_236_0 then
				local var_236_46 = arg_233_1.var_.effectmatichentu1
				local var_236_47
				local var_236_48 = var_236_44

				if not var_236_46 then
					var_236_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_236_48)
					var_236_46.name = "matichentu1"
					arg_233_1.var_.effectmatichentu1 = var_236_46
				else
					var_236_46.transform:SetParent(var_236_48)
				end

				var_236_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_46.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_236_49 = manager.ui.mainCamera.transform
			local var_236_50 = 1

			if var_236_50 < arg_233_1.time_ and arg_233_1.time_ <= var_236_50 + arg_236_0 then
				local var_236_51 = arg_233_1.var_.effectmatichentu2
				local var_236_52
				local var_236_53 = var_236_49

				if not var_236_51 then
					var_236_51 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_236_53)
					var_236_51.name = "matichentu2"
					arg_233_1.var_.effectmatichentu2 = var_236_51
				else
					var_236_51.transform:SetParent(var_236_53)
				end

				var_236_51.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_51.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_236_54 = manager.ui.mainCamera.transform
			local var_236_55 = 1

			if var_236_55 < arg_233_1.time_ and arg_233_1.time_ <= var_236_55 + arg_236_0 then
				arg_233_1.var_.shakeOldPos = var_236_54.localPosition
			end

			local var_236_56 = 1

			if var_236_55 <= arg_233_1.time_ and arg_233_1.time_ < var_236_55 + var_236_56 then
				local var_236_57 = (arg_233_1.time_ - var_236_55) / 0.066
				local var_236_58, var_236_59 = math.modf(var_236_57)

				var_236_54.localPosition = Vector3.New(var_236_59 * 0.02, var_236_59 * 0.02, var_236_59 * 0.02) + arg_233_1.var_.shakeOldPos
			end

			if arg_233_1.time_ >= var_236_55 + var_236_56 and arg_233_1.time_ < var_236_55 + var_236_56 + arg_236_0 then
				var_236_54.localPosition = arg_233_1.var_.shakeOldPos
			end

			local var_236_60 = 1.1
			local var_236_61 = 1

			if var_236_60 < arg_233_1.time_ and arg_233_1.time_ <= var_236_60 + arg_236_0 then
				local var_236_62 = "play"
				local var_236_63 = "effect"

				arg_233_1:AudioAction(var_236_62, var_236_63, "se_story_side_1067", "se_story_1067_horse01", "")
			end

			local var_236_64 = 0.1
			local var_236_65 = 1

			if var_236_64 < arg_233_1.time_ and arg_233_1.time_ <= var_236_64 + arg_236_0 then
				local var_236_66 = "stop"
				local var_236_67 = "effect"

				arg_233_1:AudioAction(var_236_66, var_236_67, "se_story_140", "se_story_140_amb_drain", "")
			end

			local var_236_68 = 0.566666666666667
			local var_236_69 = 1

			if var_236_68 < arg_233_1.time_ and arg_233_1.time_ <= var_236_68 + arg_236_0 then
				local var_236_70 = "play"
				local var_236_71 = "effect"

				arg_233_1:AudioAction(var_236_70, var_236_71, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_236_72 = 0.566666666666667
			local var_236_73 = 1

			if var_236_72 < arg_233_1.time_ and arg_233_1.time_ <= var_236_72 + arg_236_0 then
				local var_236_74 = "play"
				local var_236_75 = "effect"

				arg_233_1:AudioAction(var_236_74, var_236_75, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_76 = 3
			local var_236_77 = 0.85

			if var_236_76 < arg_233_1.time_ and arg_233_1.time_ <= var_236_76 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_78 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_78:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_79 = arg_233_1:FormatText(StoryNameCfg[1326].name)

				arg_233_1.leftNameTxt_.text = var_236_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_80 = arg_233_1:GetWordFromCfg(423101055)
				local var_236_81 = arg_233_1:FormatText(var_236_80.content)

				arg_233_1.text_.text = var_236_81

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_82 = 34
				local var_236_83 = utf8.len(var_236_81)
				local var_236_84 = var_236_82 <= 0 and var_236_77 or var_236_77 * (var_236_83 / var_236_82)

				if var_236_84 > 0 and var_236_77 < var_236_84 then
					arg_233_1.talkMaxDuration = var_236_84
					var_236_76 = var_236_76 + 0.3

					if var_236_84 + var_236_76 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_84 + var_236_76
					end
				end

				arg_233_1.text_.text = var_236_81
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101055", "story_v_out_423101.awb") ~= 0 then
					local var_236_85 = manager.audio:GetVoiceLength("story_v_out_423101", "423101055", "story_v_out_423101.awb") / 1000

					if var_236_85 + var_236_76 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_85 + var_236_76
					end

					if var_236_80.prefab_name ~= "" and arg_233_1.actors_[var_236_80.prefab_name] ~= nil then
						local var_236_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_80.prefab_name].transform, "story_v_out_423101", "423101055", "story_v_out_423101.awb")

						arg_233_1:RecordAudio("423101055", var_236_86)
						arg_233_1:RecordAudio("423101055", var_236_86)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_423101", "423101055", "story_v_out_423101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_423101", "423101055", "story_v_out_423101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_87 = var_236_76 + 0.3
			local var_236_88 = math.max(var_236_77, arg_233_1.talkMaxDuration)

			if var_236_87 <= arg_233_1.time_ and arg_233_1.time_ < var_236_87 + var_236_88 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_87) / var_236_88

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_87 + var_236_88 and arg_233_1.time_ < var_236_87 + var_236_88 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play423101056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 423101056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play423101057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 2.025

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(423101056)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 81
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play423101057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 423101057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play423101058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.3

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(423101057)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 12
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
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play423101058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 423101058
		arg_247_1.duration_ = 11.3

		local var_247_0 = {
			zh = 7.266,
			ja = 11.3
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
				arg_247_0:Play423101059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.85

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[1331].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_1")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(423101058)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101058", "story_v_out_423101.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101058", "story_v_out_423101.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_423101", "423101058", "story_v_out_423101.awb")

						arg_247_1:RecordAudio("423101058", var_250_9)
						arg_247_1:RecordAudio("423101058", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_423101", "423101058", "story_v_out_423101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_423101", "423101058", "story_v_out_423101.awb")
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
	Play423101059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 423101059
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play423101060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10148"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10148 == nil then
				arg_251_1.var_.actorSpriteComps10148 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10148 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 0.5, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10148 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10148 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 0.7

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_10 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_11 = arg_251_1:GetWordFromCfg(423101059)
				local var_254_12 = arg_251_1:FormatText(var_254_11.content)

				arg_251_1.text_.text = var_254_12

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 28
				local var_254_14 = utf8.len(var_254_12)
				local var_254_15 = var_254_13 <= 0 and var_254_9 or var_254_9 * (var_254_14 / var_254_13)

				if var_254_15 > 0 and var_254_9 < var_254_15 then
					arg_251_1.talkMaxDuration = var_254_15

					if var_254_15 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_15 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_12
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play423101060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 423101060
		arg_255_1.duration_ = 16.73

		local var_255_0 = {
			zh = 10.866,
			ja = 16.733
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
				arg_255_0:Play423101061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 1.125

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1331].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_1")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(423101060)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101060", "story_v_out_423101.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101060", "story_v_out_423101.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_423101", "423101060", "story_v_out_423101.awb")

						arg_255_1:RecordAudio("423101060", var_258_9)
						arg_255_1:RecordAudio("423101060", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_423101", "423101060", "story_v_out_423101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_423101", "423101060", "story_v_out_423101.awb")
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
	Play423101061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 423101061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play423101062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10148"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10148 == nil then
				arg_259_1.var_.actorSpriteComps10148 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10148 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10148 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10148 = nil
			end

			local var_262_8 = 0
			local var_262_9 = 0.3

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_10 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_11 = arg_259_1:GetWordFromCfg(423101061)
				local var_262_12 = arg_259_1:FormatText(var_262_11.content)

				arg_259_1.text_.text = var_262_12

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 12
				local var_262_14 = utf8.len(var_262_12)
				local var_262_15 = var_262_13 <= 0 and var_262_9 or var_262_9 * (var_262_14 / var_262_13)

				if var_262_15 > 0 and var_262_9 < var_262_15 then
					arg_259_1.talkMaxDuration = var_262_15

					if var_262_15 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_15 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_12
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_16 and arg_259_1.time_ < var_262_8 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play423101062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 423101062
		arg_263_1.duration_ = 9

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play423101063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.999999999999

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_1 = manager.ui.mainCamera.transform.localPosition
				local var_266_2 = Vector3.New(0, 0, 10) + Vector3.New(var_266_1.x, var_266_1.y, 0)
				local var_266_3 = arg_263_1.bgs_.I25h

				var_266_3.transform.localPosition = var_266_2
				var_266_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_4 = var_266_3:GetComponent("SpriteRenderer")

				if var_266_4 and var_266_4.sprite then
					local var_266_5 = (var_266_3.transform.localPosition - var_266_1).z
					local var_266_6 = manager.ui.mainCameraCom_
					local var_266_7 = 2 * var_266_5 * Mathf.Tan(var_266_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_266_8 = var_266_7 * var_266_6.aspect
					local var_266_9 = var_266_4.sprite.bounds.size.x
					local var_266_10 = var_266_4.sprite.bounds.size.y
					local var_266_11 = var_266_8 / var_266_9
					local var_266_12 = var_266_7 / var_266_10
					local var_266_13 = var_266_12 < var_266_11 and var_266_11 or var_266_12

					var_266_3.transform.localScale = Vector3.New(var_266_13, var_266_13, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "I25h" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_14 = 4

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			local var_266_15 = 0.3

			if arg_263_1.time_ >= var_266_14 + var_266_15 and arg_263_1.time_ < var_266_14 + var_266_15 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_17 = 2

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_17 then
				local var_266_18 = (arg_263_1.time_ - var_266_16) / var_266_17
				local var_266_19 = Color.New(0, 0, 0)

				var_266_19.a = Mathf.Lerp(0, 1, var_266_18)
				arg_263_1.mask_.color = var_266_19
			end

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 then
				local var_266_20 = Color.New(0, 0, 0)

				var_266_20.a = 1
				arg_263_1.mask_.color = var_266_20
			end

			local var_266_21 = 2

			if var_266_21 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_22 = 2

			if var_266_21 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_22 then
				local var_266_23 = (arg_263_1.time_ - var_266_21) / var_266_22
				local var_266_24 = Color.New(0, 0, 0)

				var_266_24.a = Mathf.Lerp(1, 0, var_266_23)
				arg_263_1.mask_.color = var_266_24
			end

			if arg_263_1.time_ >= var_266_21 + var_266_22 and arg_263_1.time_ < var_266_21 + var_266_22 + arg_266_0 then
				local var_266_25 = Color.New(0, 0, 0)
				local var_266_26 = 0

				arg_263_1.mask_.enabled = false
				var_266_25.a = var_266_26
				arg_263_1.mask_.color = var_266_25
			end

			local var_266_27 = arg_263_1.actors_["10148"].transform
			local var_266_28 = 1.966

			if var_266_28 < arg_263_1.time_ and arg_263_1.time_ <= var_266_28 + arg_266_0 then
				arg_263_1.var_.moveOldPos10148 = var_266_27.localPosition
				var_266_27.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10148", 7)

				local var_266_29 = var_266_27.childCount

				for iter_266_2 = 0, var_266_29 - 1 do
					local var_266_30 = var_266_27:GetChild(iter_266_2)

					if var_266_30.name == "" or not string.find(var_266_30.name, "split") then
						var_266_30.gameObject:SetActive(true)
					else
						var_266_30.gameObject:SetActive(false)
					end
				end
			end

			local var_266_31 = 0.001

			if var_266_28 <= arg_263_1.time_ and arg_263_1.time_ < var_266_28 + var_266_31 then
				local var_266_32 = (arg_263_1.time_ - var_266_28) / var_266_31
				local var_266_33 = Vector3.New(0, -2000, 0)

				var_266_27.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10148, var_266_33, var_266_32)
			end

			if arg_263_1.time_ >= var_266_28 + var_266_31 and arg_263_1.time_ < var_266_28 + var_266_31 + arg_266_0 then
				var_266_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_34 = 4
			local var_266_35 = 1.55

			if var_266_34 < arg_263_1.time_ and arg_263_1.time_ <= var_266_34 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_36 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_36:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_37 = arg_263_1:GetWordFromCfg(423101062)
				local var_266_38 = arg_263_1:FormatText(var_266_37.content)

				arg_263_1.text_.text = var_266_38

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_39 = 62
				local var_266_40 = utf8.len(var_266_38)
				local var_266_41 = var_266_39 <= 0 and var_266_35 or var_266_35 * (var_266_40 / var_266_39)

				if var_266_41 > 0 and var_266_35 < var_266_41 then
					arg_263_1.talkMaxDuration = var_266_41
					var_266_34 = var_266_34 + 0.3

					if var_266_41 + var_266_34 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_41 + var_266_34
					end
				end

				arg_263_1.text_.text = var_266_38
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_42 = var_266_34 + 0.3
			local var_266_43 = math.max(var_266_35, arg_263_1.talkMaxDuration)

			if var_266_42 <= arg_263_1.time_ and arg_263_1.time_ < var_266_42 + var_266_43 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_42) / var_266_43

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_42 + var_266_43 and arg_263_1.time_ < var_266_42 + var_266_43 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play423101063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 423101063
		arg_269_1.duration_ = 1.63

		local var_269_0 = {
			zh = 1.633,
			ja = 1.433
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play423101064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1083"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1083 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1083", 2)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_6" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(-440, -345, -345)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1083, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_272_7 = arg_269_1.actors_["10148"].transform
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.var_.moveOldPos10148 = var_272_7.localPosition
				var_272_7.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10148", 4)

				local var_272_9 = var_272_7.childCount

				for iter_272_1 = 0, var_272_9 - 1 do
					local var_272_10 = var_272_7:GetChild(iter_272_1)

					if var_272_10.name == "split_5" or not string.find(var_272_10.name, "split") then
						var_272_10.gameObject:SetActive(true)
					else
						var_272_10.gameObject:SetActive(false)
					end
				end
			end

			local var_272_11 = 0.001

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_11 then
				local var_272_12 = (arg_269_1.time_ - var_272_8) / var_272_11
				local var_272_13 = Vector3.New(390, -350, -270)

				var_272_7.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10148, var_272_13, var_272_12)
			end

			if arg_269_1.time_ >= var_272_8 + var_272_11 and arg_269_1.time_ < var_272_8 + var_272_11 + arg_272_0 then
				var_272_7.localPosition = Vector3.New(390, -350, -270)
			end

			local var_272_14 = arg_269_1.actors_["1083"]
			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.actorSpriteComps1083 == nil then
				arg_269_1.var_.actorSpriteComps1083 = var_272_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_16 = 0.2

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_16 and not isNil(var_272_14) then
				local var_272_17 = (arg_269_1.time_ - var_272_15) / var_272_16

				if arg_269_1.var_.actorSpriteComps1083 then
					for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_272_3 then
							if arg_269_1.isInRecall_ then
								local var_272_18 = Mathf.Lerp(iter_272_3.color.r, arg_269_1.hightColor1.r, var_272_17)
								local var_272_19 = Mathf.Lerp(iter_272_3.color.g, arg_269_1.hightColor1.g, var_272_17)
								local var_272_20 = Mathf.Lerp(iter_272_3.color.b, arg_269_1.hightColor1.b, var_272_17)

								iter_272_3.color = Color.New(var_272_18, var_272_19, var_272_20)
							else
								local var_272_21 = Mathf.Lerp(iter_272_3.color.r, 1, var_272_17)

								iter_272_3.color = Color.New(var_272_21, var_272_21, var_272_21)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_15 + var_272_16 and arg_269_1.time_ < var_272_15 + var_272_16 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.actorSpriteComps1083 then
				for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_272_5 then
						if arg_269_1.isInRecall_ then
							iter_272_5.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1083 = nil
			end

			local var_272_22 = arg_269_1.actors_["10148"]
			local var_272_23 = 0

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 and not isNil(var_272_22) and arg_269_1.var_.actorSpriteComps10148 == nil then
				arg_269_1.var_.actorSpriteComps10148 = var_272_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_24 = 0.2

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_24 and not isNil(var_272_22) then
				local var_272_25 = (arg_269_1.time_ - var_272_23) / var_272_24

				if arg_269_1.var_.actorSpriteComps10148 then
					for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_272_7 then
							if arg_269_1.isInRecall_ then
								local var_272_26 = Mathf.Lerp(iter_272_7.color.r, arg_269_1.hightColor1.r, var_272_25)
								local var_272_27 = Mathf.Lerp(iter_272_7.color.g, arg_269_1.hightColor1.g, var_272_25)
								local var_272_28 = Mathf.Lerp(iter_272_7.color.b, arg_269_1.hightColor1.b, var_272_25)

								iter_272_7.color = Color.New(var_272_26, var_272_27, var_272_28)
							else
								local var_272_29 = Mathf.Lerp(iter_272_7.color.r, 1, var_272_25)

								iter_272_7.color = Color.New(var_272_29, var_272_29, var_272_29)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_23 + var_272_24 and arg_269_1.time_ < var_272_23 + var_272_24 + arg_272_0 and not isNil(var_272_22) and arg_269_1.var_.actorSpriteComps10148 then
				for iter_272_8, iter_272_9 in pairs(arg_269_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_272_9 then
						if arg_269_1.isInRecall_ then
							iter_272_9.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10148 = nil
			end

			local var_272_30 = manager.ui.mainCamera.transform
			local var_272_31 = 0

			if var_272_31 < arg_269_1.time_ and arg_269_1.time_ <= var_272_31 + arg_272_0 then
				arg_269_1.var_.shakeOldPos = var_272_30.localPosition
			end

			local var_272_32 = 0.6

			if var_272_31 <= arg_269_1.time_ and arg_269_1.time_ < var_272_31 + var_272_32 then
				local var_272_33 = (arg_269_1.time_ - var_272_31) / 0.066
				local var_272_34, var_272_35 = math.modf(var_272_33)

				var_272_30.localPosition = Vector3.New(var_272_35 * 0.02, var_272_35 * 0.02, var_272_35 * 0.02) + arg_269_1.var_.shakeOldPos
			end

			if arg_269_1.time_ >= var_272_31 + var_272_32 and arg_269_1.time_ < var_272_31 + var_272_32 + arg_272_0 then
				var_272_30.localPosition = arg_269_1.var_.shakeOldPos
			end

			local var_272_36 = 0
			local var_272_37 = 0.125

			if var_272_36 < arg_269_1.time_ and arg_269_1.time_ <= var_272_36 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_38 = arg_269_1:FormatText(StoryNameCfg[1347].name)

				arg_269_1.leftNameTxt_.text = var_272_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_39 = arg_269_1:GetWordFromCfg(423101063)
				local var_272_40 = arg_269_1:FormatText(var_272_39.content)

				arg_269_1.text_.text = var_272_40

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_41 = 5
				local var_272_42 = utf8.len(var_272_40)
				local var_272_43 = var_272_41 <= 0 and var_272_37 or var_272_37 * (var_272_42 / var_272_41)

				if var_272_43 > 0 and var_272_37 < var_272_43 then
					arg_269_1.talkMaxDuration = var_272_43

					if var_272_43 + var_272_36 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_43 + var_272_36
					end
				end

				arg_269_1.text_.text = var_272_40
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101063", "story_v_out_423101.awb") ~= 0 then
					local var_272_44 = manager.audio:GetVoiceLength("story_v_out_423101", "423101063", "story_v_out_423101.awb") / 1000

					if var_272_44 + var_272_36 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_44 + var_272_36
					end

					if var_272_39.prefab_name ~= "" and arg_269_1.actors_[var_272_39.prefab_name] ~= nil then
						local var_272_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_39.prefab_name].transform, "story_v_out_423101", "423101063", "story_v_out_423101.awb")

						arg_269_1:RecordAudio("423101063", var_272_45)
						arg_269_1:RecordAudio("423101063", var_272_45)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_423101", "423101063", "story_v_out_423101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_423101", "423101063", "story_v_out_423101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_46 = math.max(var_272_37, arg_269_1.talkMaxDuration)

			if var_272_36 <= arg_269_1.time_ and arg_269_1.time_ < var_272_36 + var_272_46 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_36) / var_272_46

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_36 + var_272_46 and arg_269_1.time_ < var_272_36 + var_272_46 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play423101064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 423101064
		arg_273_1.duration_ = 11.47

		local var_273_0 = {
			zh = 5.833,
			ja = 11.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play423101065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10148"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10148 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10148", 4)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_3" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(390, -350, -270)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10148, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(390, -350, -270)
			end

			local var_276_7 = arg_273_1.actors_["1083"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1083 == nil then
				arg_273_1.var_.actorSpriteComps1083 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.2

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1083 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor2.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor2.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor2.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 0.5, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1083 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1083 = nil
			end

			local var_276_15 = 0.166666666666667
			local var_276_16 = 1

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				local var_276_17 = "play"
				local var_276_18 = "effect"

				arg_273_1:AudioAction(var_276_17, var_276_18, "se_story_144", "se_story_144_clap", "")
			end

			local var_276_19 = 0
			local var_276_20 = 0.675

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_21 = arg_273_1:FormatText(StoryNameCfg[1331].name)

				arg_273_1.leftNameTxt_.text = var_276_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_22 = arg_273_1:GetWordFromCfg(423101064)
				local var_276_23 = arg_273_1:FormatText(var_276_22.content)

				arg_273_1.text_.text = var_276_23

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_24 = 27
				local var_276_25 = utf8.len(var_276_23)
				local var_276_26 = var_276_24 <= 0 and var_276_20 or var_276_20 * (var_276_25 / var_276_24)

				if var_276_26 > 0 and var_276_20 < var_276_26 then
					arg_273_1.talkMaxDuration = var_276_26

					if var_276_26 + var_276_19 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_26 + var_276_19
					end
				end

				arg_273_1.text_.text = var_276_23
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101064", "story_v_out_423101.awb") ~= 0 then
					local var_276_27 = manager.audio:GetVoiceLength("story_v_out_423101", "423101064", "story_v_out_423101.awb") / 1000

					if var_276_27 + var_276_19 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_27 + var_276_19
					end

					if var_276_22.prefab_name ~= "" and arg_273_1.actors_[var_276_22.prefab_name] ~= nil then
						local var_276_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_22.prefab_name].transform, "story_v_out_423101", "423101064", "story_v_out_423101.awb")

						arg_273_1:RecordAudio("423101064", var_276_28)
						arg_273_1:RecordAudio("423101064", var_276_28)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_423101", "423101064", "story_v_out_423101.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_423101", "423101064", "story_v_out_423101.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_29 = math.max(var_276_20, arg_273_1.talkMaxDuration)

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_29 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_19) / var_276_29

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_19 + var_276_29 and arg_273_1.time_ < var_276_19 + var_276_29 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play423101065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423101065
		arg_277_1.duration_ = 7.97

		local var_277_0 = {
			zh = 6.533,
			ja = 7.966
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play423101066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10148"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10148 == nil then
				arg_277_1.var_.actorSpriteComps10148 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps10148 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 0.5, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10148 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10148 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.95

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_10 = arg_277_1:FormatText(StoryNameCfg[1327].name)

				arg_277_1.leftNameTxt_.text = var_280_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_11 = arg_277_1:GetWordFromCfg(423101065)
				local var_280_12 = arg_277_1:FormatText(var_280_11.content)

				arg_277_1.text_.text = var_280_12

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 38
				local var_280_14 = utf8.len(var_280_12)
				local var_280_15 = var_280_13 <= 0 and var_280_9 or var_280_9 * (var_280_14 / var_280_13)

				if var_280_15 > 0 and var_280_9 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_12
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101065", "story_v_out_423101.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101065", "story_v_out_423101.awb") / 1000

					if var_280_16 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_8
					end

					if var_280_11.prefab_name ~= "" and arg_277_1.actors_[var_280_11.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_11.prefab_name].transform, "story_v_out_423101", "423101065", "story_v_out_423101.awb")

						arg_277_1:RecordAudio("423101065", var_280_17)
						arg_277_1:RecordAudio("423101065", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_423101", "423101065", "story_v_out_423101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_423101", "423101065", "story_v_out_423101.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_18 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_18

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_18 and arg_277_1.time_ < var_280_8 + var_280_18 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play423101066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423101066
		arg_281_1.duration_ = 7.07

		local var_281_0 = {
			zh = 5.433,
			ja = 7.066
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play423101067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10148"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10148 == nil then
				arg_281_1.var_.actorSpriteComps10148 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps10148 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 0.5, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10148 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10148 = nil
			end

			local var_284_8 = 0
			local var_284_9 = 0.725

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_10 = arg_281_1:FormatText(StoryNameCfg[1327].name)

				arg_281_1.leftNameTxt_.text = var_284_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_11 = arg_281_1:GetWordFromCfg(423101066)
				local var_284_12 = arg_281_1:FormatText(var_284_11.content)

				arg_281_1.text_.text = var_284_12

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 29
				local var_284_14 = utf8.len(var_284_12)
				local var_284_15 = var_284_13 <= 0 and var_284_9 or var_284_9 * (var_284_14 / var_284_13)

				if var_284_15 > 0 and var_284_9 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_12
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101066", "story_v_out_423101.awb") ~= 0 then
					local var_284_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101066", "story_v_out_423101.awb") / 1000

					if var_284_16 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_16 + var_284_8
					end

					if var_284_11.prefab_name ~= "" and arg_281_1.actors_[var_284_11.prefab_name] ~= nil then
						local var_284_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_11.prefab_name].transform, "story_v_out_423101", "423101066", "story_v_out_423101.awb")

						arg_281_1:RecordAudio("423101066", var_284_17)
						arg_281_1:RecordAudio("423101066", var_284_17)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_423101", "423101066", "story_v_out_423101.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_423101", "423101066", "story_v_out_423101.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_18 and arg_281_1.time_ < var_284_8 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play423101067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423101067
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play423101068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10148"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10148 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10148", 7)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(0, -2000, 0)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10148, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_288_7 = arg_285_1.actors_["1083"].transform
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.var_.moveOldPos1083 = var_288_7.localPosition
				var_288_7.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1083", 7)

				local var_288_9 = var_288_7.childCount

				for iter_288_1 = 0, var_288_9 - 1 do
					local var_288_10 = var_288_7:GetChild(iter_288_1)

					if var_288_10.name == "" or not string.find(var_288_10.name, "split") then
						var_288_10.gameObject:SetActive(true)
					else
						var_288_10.gameObject:SetActive(false)
					end
				end
			end

			local var_288_11 = 0.001

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_8) / var_288_11
				local var_288_13 = Vector3.New(0, -2000, 0)

				var_288_7.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1083, var_288_13, var_288_12)
			end

			if arg_285_1.time_ >= var_288_8 + var_288_11 and arg_285_1.time_ < var_288_8 + var_288_11 + arg_288_0 then
				var_288_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_288_14 = 0
			local var_288_15 = 1.625

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_16 = arg_285_1:GetWordFromCfg(423101067)
				local var_288_17 = arg_285_1:FormatText(var_288_16.content)

				arg_285_1.text_.text = var_288_17

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_18 = 65
				local var_288_19 = utf8.len(var_288_17)
				local var_288_20 = var_288_18 <= 0 and var_288_15 or var_288_15 * (var_288_19 / var_288_18)

				if var_288_20 > 0 and var_288_15 < var_288_20 then
					arg_285_1.talkMaxDuration = var_288_20

					if var_288_20 + var_288_14 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_20 + var_288_14
					end
				end

				arg_285_1.text_.text = var_288_17
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_21 = math.max(var_288_15, arg_285_1.talkMaxDuration)

			if var_288_14 <= arg_285_1.time_ and arg_285_1.time_ < var_288_14 + var_288_21 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_14) / var_288_21

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_14 + var_288_21 and arg_285_1.time_ < var_288_14 + var_288_21 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play423101068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423101068
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play423101069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.575

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(423101068)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 23
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play423101069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423101069
		arg_293_1.duration_ = 2.57

		local var_293_0 = {
			zh = 1.7,
			ja = 2.566
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play423101070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1083"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1083 == nil then
				arg_293_1.var_.actorSpriteComps1083 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps1083 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1083 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1083 = nil
			end

			local var_296_8 = arg_293_1.actors_["1083"].transform
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.var_.moveOldPos1083 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1083", 3)

				local var_296_10 = var_296_8.childCount

				for iter_296_4 = 0, var_296_10 - 1 do
					local var_296_11 = var_296_8:GetChild(iter_296_4)

					if var_296_11.name == "split_7" or not string.find(var_296_11.name, "split") then
						var_296_11.gameObject:SetActive(true)
					else
						var_296_11.gameObject:SetActive(false)
					end
				end
			end

			local var_296_12 = 0.001

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_12 then
				local var_296_13 = (arg_293_1.time_ - var_296_9) / var_296_12
				local var_296_14 = Vector3.New(-50, -345, -345)

				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1083, var_296_14, var_296_13)
			end

			if arg_293_1.time_ >= var_296_9 + var_296_12 and arg_293_1.time_ < var_296_9 + var_296_12 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_296_15 = 0
			local var_296_16 = 0.25

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[1332].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(423101069)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 10
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101069", "story_v_out_423101.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101069", "story_v_out_423101.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_423101", "423101069", "story_v_out_423101.awb")

						arg_293_1:RecordAudio("423101069", var_296_24)
						arg_293_1:RecordAudio("423101069", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423101", "423101069", "story_v_out_423101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423101", "423101069", "story_v_out_423101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play423101070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423101070
		arg_297_1.duration_ = 3.93

		local var_297_0 = {
			zh = 3.933,
			ja = 3.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play423101071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1083"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1083 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1083", 3)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "split_7" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(-50, -345, -345)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1083, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_300_7 = 0
			local var_300_8 = 0.475

			if var_300_7 < arg_297_1.time_ and arg_297_1.time_ <= var_300_7 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_9 = arg_297_1:FormatText(StoryNameCfg[1332].name)

				arg_297_1.leftNameTxt_.text = var_300_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(423101070)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_12 = 19
				local var_300_13 = utf8.len(var_300_11)
				local var_300_14 = var_300_12 <= 0 and var_300_8 or var_300_8 * (var_300_13 / var_300_12)

				if var_300_14 > 0 and var_300_8 < var_300_14 then
					arg_297_1.talkMaxDuration = var_300_14

					if var_300_14 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_7
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101070", "story_v_out_423101.awb") ~= 0 then
					local var_300_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101070", "story_v_out_423101.awb") / 1000

					if var_300_15 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_15 + var_300_7
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_423101", "423101070", "story_v_out_423101.awb")

						arg_297_1:RecordAudio("423101070", var_300_16)
						arg_297_1:RecordAudio("423101070", var_300_16)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_423101", "423101070", "story_v_out_423101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_423101", "423101070", "story_v_out_423101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_17 = math.max(var_300_8, arg_297_1.talkMaxDuration)

			if var_300_7 <= arg_297_1.time_ and arg_297_1.time_ < var_300_7 + var_300_17 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_7) / var_300_17

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_7 + var_300_17 and arg_297_1.time_ < var_300_7 + var_300_17 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play423101071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 423101071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play423101072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1083"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1083 == nil then
				arg_301_1.var_.actorSpriteComps1083 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1083 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 0.5, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1083 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1083 = nil
			end

			local var_304_8 = arg_301_1.actors_["1083"].transform
			local var_304_9 = 0

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.var_.moveOldPos1083 = var_304_8.localPosition
				var_304_8.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1083", 7)

				local var_304_10 = var_304_8.childCount

				for iter_304_4 = 0, var_304_10 - 1 do
					local var_304_11 = var_304_8:GetChild(iter_304_4)

					if var_304_11.name == "" or not string.find(var_304_11.name, "split") then
						var_304_11.gameObject:SetActive(true)
					else
						var_304_11.gameObject:SetActive(false)
					end
				end
			end

			local var_304_12 = 0.001

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_12 then
				local var_304_13 = (arg_301_1.time_ - var_304_9) / var_304_12
				local var_304_14 = Vector3.New(0, -2000, 0)

				var_304_8.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1083, var_304_14, var_304_13)
			end

			if arg_301_1.time_ >= var_304_9 + var_304_12 and arg_301_1.time_ < var_304_9 + var_304_12 + arg_304_0 then
				var_304_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_304_15 = 0.466666666666667
			local var_304_16 = 1

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				local var_304_17 = "play"
				local var_304_18 = "effect"

				arg_301_1:AudioAction(var_304_17, var_304_18, "se_story_1310", "se_story_1310_motorcycle03", "")
			end

			local var_304_19 = 0
			local var_304_20 = 1.775

			if var_304_19 < arg_301_1.time_ and arg_301_1.time_ <= var_304_19 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_21 = arg_301_1:GetWordFromCfg(423101071)
				local var_304_22 = arg_301_1:FormatText(var_304_21.content)

				arg_301_1.text_.text = var_304_22

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_23 = 71
				local var_304_24 = utf8.len(var_304_22)
				local var_304_25 = var_304_23 <= 0 and var_304_20 or var_304_20 * (var_304_24 / var_304_23)

				if var_304_25 > 0 and var_304_20 < var_304_25 then
					arg_301_1.talkMaxDuration = var_304_25

					if var_304_25 + var_304_19 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_25 + var_304_19
					end
				end

				arg_301_1.text_.text = var_304_22
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_26 = math.max(var_304_20, arg_301_1.talkMaxDuration)

			if var_304_19 <= arg_301_1.time_ and arg_301_1.time_ < var_304_19 + var_304_26 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_19) / var_304_26

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_19 + var_304_26 and arg_301_1.time_ < var_304_19 + var_304_26 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play423101072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 423101072
		arg_305_1.duration_ = 8.1

		local var_305_0 = {
			zh = 5.932999999999,
			ja = 8.099999999999
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play423101073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = "ST0113"

			if arg_305_1.bgs_[var_308_0] == nil then
				local var_308_1 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_308_0)
				var_308_1.name = var_308_0
				var_308_1.transform.parent = arg_305_1.stage_.transform
				var_308_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_[var_308_0] = var_308_1
			end

			local var_308_2 = 2

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				local var_308_3 = manager.ui.mainCamera.transform.localPosition
				local var_308_4 = Vector3.New(0, 0, 10) + Vector3.New(var_308_3.x, var_308_3.y, 0)
				local var_308_5 = arg_305_1.bgs_.ST0113

				var_308_5.transform.localPosition = var_308_4
				var_308_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_6 = var_308_5:GetComponent("SpriteRenderer")

				if var_308_6 and var_308_6.sprite then
					local var_308_7 = (var_308_5.transform.localPosition - var_308_3).z
					local var_308_8 = manager.ui.mainCameraCom_
					local var_308_9 = 2 * var_308_7 * Mathf.Tan(var_308_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_308_10 = var_308_9 * var_308_8.aspect
					local var_308_11 = var_308_6.sprite.bounds.size.x
					local var_308_12 = var_308_6.sprite.bounds.size.y
					local var_308_13 = var_308_10 / var_308_11
					local var_308_14 = var_308_9 / var_308_12
					local var_308_15 = var_308_14 < var_308_13 and var_308_13 or var_308_14

					var_308_5.transform.localScale = Vector3.New(var_308_15, var_308_15, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "ST0113" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_16 = 3.999999999999

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			local var_308_17 = 0.3

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			local var_308_18 = 0

			if var_308_18 < arg_305_1.time_ and arg_305_1.time_ <= var_308_18 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_19 = 2

			if var_308_18 <= arg_305_1.time_ and arg_305_1.time_ < var_308_18 + var_308_19 then
				local var_308_20 = (arg_305_1.time_ - var_308_18) / var_308_19
				local var_308_21 = Color.New(0, 0, 0)

				var_308_21.a = Mathf.Lerp(0, 1, var_308_20)
				arg_305_1.mask_.color = var_308_21
			end

			if arg_305_1.time_ >= var_308_18 + var_308_19 and arg_305_1.time_ < var_308_18 + var_308_19 + arg_308_0 then
				local var_308_22 = Color.New(0, 0, 0)

				var_308_22.a = 1
				arg_305_1.mask_.color = var_308_22
			end

			local var_308_23 = 2

			if var_308_23 < arg_305_1.time_ and arg_305_1.time_ <= var_308_23 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_24 = 2

			if var_308_23 <= arg_305_1.time_ and arg_305_1.time_ < var_308_23 + var_308_24 then
				local var_308_25 = (arg_305_1.time_ - var_308_23) / var_308_24
				local var_308_26 = Color.New(0, 0, 0)

				var_308_26.a = Mathf.Lerp(1, 0, var_308_25)
				arg_305_1.mask_.color = var_308_26
			end

			if arg_305_1.time_ >= var_308_23 + var_308_24 and arg_305_1.time_ < var_308_23 + var_308_24 + arg_308_0 then
				local var_308_27 = Color.New(0, 0, 0)
				local var_308_28 = 0

				arg_305_1.mask_.enabled = false
				var_308_27.a = var_308_28
				arg_305_1.mask_.color = var_308_27
			end

			local var_308_29 = arg_305_1.actors_["1083"]
			local var_308_30 = 3.8

			if var_308_30 < arg_305_1.time_ and arg_305_1.time_ <= var_308_30 + arg_308_0 and not isNil(var_308_29) and arg_305_1.var_.actorSpriteComps1083 == nil then
				arg_305_1.var_.actorSpriteComps1083 = var_308_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_31 = 0.2

			if var_308_30 <= arg_305_1.time_ and arg_305_1.time_ < var_308_30 + var_308_31 and not isNil(var_308_29) then
				local var_308_32 = (arg_305_1.time_ - var_308_30) / var_308_31

				if arg_305_1.var_.actorSpriteComps1083 then
					for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_308_3 then
							if arg_305_1.isInRecall_ then
								local var_308_33 = Mathf.Lerp(iter_308_3.color.r, arg_305_1.hightColor1.r, var_308_32)
								local var_308_34 = Mathf.Lerp(iter_308_3.color.g, arg_305_1.hightColor1.g, var_308_32)
								local var_308_35 = Mathf.Lerp(iter_308_3.color.b, arg_305_1.hightColor1.b, var_308_32)

								iter_308_3.color = Color.New(var_308_33, var_308_34, var_308_35)
							else
								local var_308_36 = Mathf.Lerp(iter_308_3.color.r, 1, var_308_32)

								iter_308_3.color = Color.New(var_308_36, var_308_36, var_308_36)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_30 + var_308_31 and arg_305_1.time_ < var_308_30 + var_308_31 + arg_308_0 and not isNil(var_308_29) and arg_305_1.var_.actorSpriteComps1083 then
				for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_308_5 then
						if arg_305_1.isInRecall_ then
							iter_308_5.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1083 = nil
			end

			local var_308_37 = arg_305_1.actors_["1083"].transform
			local var_308_38 = 3.8

			if var_308_38 < arg_305_1.time_ and arg_305_1.time_ <= var_308_38 + arg_308_0 then
				arg_305_1.var_.moveOldPos1083 = var_308_37.localPosition
				var_308_37.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1083", 3)

				local var_308_39 = var_308_37.childCount

				for iter_308_6 = 0, var_308_39 - 1 do
					local var_308_40 = var_308_37:GetChild(iter_308_6)

					if var_308_40.name == "split_7" or not string.find(var_308_40.name, "split") then
						var_308_40.gameObject:SetActive(true)
					else
						var_308_40.gameObject:SetActive(false)
					end
				end
			end

			local var_308_41 = 0.001

			if var_308_38 <= arg_305_1.time_ and arg_305_1.time_ < var_308_38 + var_308_41 then
				local var_308_42 = (arg_305_1.time_ - var_308_38) / var_308_41
				local var_308_43 = Vector3.New(-50, -345, -345)

				var_308_37.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1083, var_308_43, var_308_42)
			end

			if arg_305_1.time_ >= var_308_38 + var_308_41 and arg_305_1.time_ < var_308_38 + var_308_41 + arg_308_0 then
				var_308_37.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_308_44 = manager.ui.mainCamera.transform
			local var_308_45 = 2

			if var_308_45 < arg_305_1.time_ and arg_305_1.time_ <= var_308_45 + arg_308_0 then
				local var_308_46 = arg_305_1.var_.effectaishimoturoche1
				local var_308_47
				local var_308_48 = var_308_44

				if not var_308_46 then
					var_308_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_308_48)
					var_308_46.name = "aishimoturoche1"
					arg_305_1.var_.effectaishimoturoche1 = var_308_46
				else
					var_308_46.transform:SetParent(var_308_48)
				end

				var_308_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_46.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_308_49 = arg_305_1.actors_["1083"]
			local var_308_50 = 3.8

			if var_308_50 < arg_305_1.time_ and arg_305_1.time_ <= var_308_50 + arg_308_0 then
				local var_308_51 = var_308_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_308_51 then
					arg_305_1.var_.alphaOldValue1083 = var_308_51.alpha
					arg_305_1.var_.characterEffect1083 = var_308_51
				end

				arg_305_1.var_.alphaOldValue1083 = 0
			end

			local var_308_52 = 0.5

			if var_308_50 <= arg_305_1.time_ and arg_305_1.time_ < var_308_50 + var_308_52 then
				local var_308_53 = (arg_305_1.time_ - var_308_50) / var_308_52
				local var_308_54 = Mathf.Lerp(arg_305_1.var_.alphaOldValue1083, 1, var_308_53)

				if arg_305_1.var_.characterEffect1083 then
					arg_305_1.var_.characterEffect1083.alpha = var_308_54
				end
			end

			if arg_305_1.time_ >= var_308_50 + var_308_52 and arg_305_1.time_ < var_308_50 + var_308_52 + arg_308_0 and arg_305_1.var_.characterEffect1083 then
				arg_305_1.var_.characterEffect1083.alpha = 1
			end

			local var_308_55 = 0.166666666666667
			local var_308_56 = 1

			if var_308_55 < arg_305_1.time_ and arg_305_1.time_ <= var_308_55 + arg_308_0 then
				local var_308_57 = "stop"
				local var_308_58 = "effect"

				arg_305_1:AudioAction(var_308_57, var_308_58, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			local var_308_59 = 1.53333333333333
			local var_308_60 = 1

			if var_308_59 < arg_305_1.time_ and arg_305_1.time_ <= var_308_59 + arg_308_0 then
				local var_308_61 = "play"
				local var_308_62 = "effect"

				arg_305_1:AudioAction(var_308_61, var_308_62, "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			local var_308_63 = 0.166666666666667
			local var_308_64 = 1

			if var_308_63 < arg_305_1.time_ and arg_305_1.time_ <= var_308_63 + arg_308_0 then
				local var_308_65 = "stop"
				local var_308_66 = "effect"

				arg_305_1:AudioAction(var_308_65, var_308_66, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_67 = 3.999999999999
			local var_308_68 = 0.225

			if var_308_67 < arg_305_1.time_ and arg_305_1.time_ <= var_308_67 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_69 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_69:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_70 = arg_305_1:FormatText(StoryNameCfg[1332].name)

				arg_305_1.leftNameTxt_.text = var_308_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_71 = arg_305_1:GetWordFromCfg(423101072)
				local var_308_72 = arg_305_1:FormatText(var_308_71.content)

				arg_305_1.text_.text = var_308_72

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_73 = 9
				local var_308_74 = utf8.len(var_308_72)
				local var_308_75 = var_308_73 <= 0 and var_308_68 or var_308_68 * (var_308_74 / var_308_73)

				if var_308_75 > 0 and var_308_68 < var_308_75 then
					arg_305_1.talkMaxDuration = var_308_75
					var_308_67 = var_308_67 + 0.3

					if var_308_75 + var_308_67 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_75 + var_308_67
					end
				end

				arg_305_1.text_.text = var_308_72
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101072", "story_v_out_423101.awb") ~= 0 then
					local var_308_76 = manager.audio:GetVoiceLength("story_v_out_423101", "423101072", "story_v_out_423101.awb") / 1000

					if var_308_76 + var_308_67 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_76 + var_308_67
					end

					if var_308_71.prefab_name ~= "" and arg_305_1.actors_[var_308_71.prefab_name] ~= nil then
						local var_308_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_71.prefab_name].transform, "story_v_out_423101", "423101072", "story_v_out_423101.awb")

						arg_305_1:RecordAudio("423101072", var_308_77)
						arg_305_1:RecordAudio("423101072", var_308_77)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_423101", "423101072", "story_v_out_423101.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_423101", "423101072", "story_v_out_423101.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_78 = var_308_67 + 0.3
			local var_308_79 = math.max(var_308_68, arg_305_1.talkMaxDuration)

			if var_308_78 <= arg_305_1.time_ and arg_305_1.time_ < var_308_78 + var_308_79 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_78) / var_308_79

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_78 + var_308_79 and arg_305_1.time_ < var_308_78 + var_308_79 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play423101073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 423101073
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play423101074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1083"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1083 == nil then
				arg_311_1.var_.actorSpriteComps1083 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1083 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 0.5, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1083 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1083 = nil
			end

			local var_314_8 = 0
			local var_314_9 = 0.65

			if var_314_8 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_10 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_11 = arg_311_1:GetWordFromCfg(423101073)
				local var_314_12 = arg_311_1:FormatText(var_314_11.content)

				arg_311_1.text_.text = var_314_12

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 26
				local var_314_14 = utf8.len(var_314_12)
				local var_314_15 = var_314_13 <= 0 and var_314_9 or var_314_9 * (var_314_14 / var_314_13)

				if var_314_15 > 0 and var_314_9 < var_314_15 then
					arg_311_1.talkMaxDuration = var_314_15

					if var_314_15 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_15 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_12
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_16 and arg_311_1.time_ < var_314_8 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play423101074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 423101074
		arg_315_1.duration_ = 4.6

		local var_315_0 = {
			zh = 2.8,
			ja = 4.6
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
				arg_315_0:Play423101075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1083"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1083 == nil then
				arg_315_1.var_.actorSpriteComps1083 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1083 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1083 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1083 = nil
			end

			local var_318_8 = arg_315_1.actors_["1083"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos1083 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1083", 3)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "split_2" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(-50, -345, -345)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1083, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_318_15 = 0
			local var_318_16 = 0.35

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_17 = arg_315_1:FormatText(StoryNameCfg[1332].name)

				arg_315_1.leftNameTxt_.text = var_318_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_18 = arg_315_1:GetWordFromCfg(423101074)
				local var_318_19 = arg_315_1:FormatText(var_318_18.content)

				arg_315_1.text_.text = var_318_19

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_20 = 14
				local var_318_21 = utf8.len(var_318_19)
				local var_318_22 = var_318_20 <= 0 and var_318_16 or var_318_16 * (var_318_21 / var_318_20)

				if var_318_22 > 0 and var_318_16 < var_318_22 then
					arg_315_1.talkMaxDuration = var_318_22

					if var_318_22 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_22 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_19
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101074", "story_v_out_423101.awb") ~= 0 then
					local var_318_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101074", "story_v_out_423101.awb") / 1000

					if var_318_23 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_15
					end

					if var_318_18.prefab_name ~= "" and arg_315_1.actors_[var_318_18.prefab_name] ~= nil then
						local var_318_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_18.prefab_name].transform, "story_v_out_423101", "423101074", "story_v_out_423101.awb")

						arg_315_1:RecordAudio("423101074", var_318_24)
						arg_315_1:RecordAudio("423101074", var_318_24)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_423101", "423101074", "story_v_out_423101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_423101", "423101074", "story_v_out_423101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_25 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 <= arg_315_1.time_ and arg_315_1.time_ < var_318_15 + var_318_25 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_15) / var_318_25

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_15 + var_318_25 and arg_315_1.time_ < var_318_15 + var_318_25 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play423101075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 423101075
		arg_319_1.duration_ = 13.2

		local var_319_0 = {
			zh = 8.9,
			ja = 13.2
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
				arg_319_0:Play423101076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1083"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1083 = var_322_0.localPosition
				var_322_0.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1083", 3)

				local var_322_2 = var_322_0.childCount

				for iter_322_0 = 0, var_322_2 - 1 do
					local var_322_3 = var_322_0:GetChild(iter_322_0)

					if var_322_3.name == "" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_4 then
				local var_322_5 = (arg_319_1.time_ - var_322_1) / var_322_4
				local var_322_6 = Vector3.New(-50, -345, -345)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1083, var_322_6, var_322_5)
			end

			if arg_319_1.time_ >= var_322_1 + var_322_4 and arg_319_1.time_ < var_322_1 + var_322_4 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_322_7 = 0
			local var_322_8 = 1.025

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_9 = arg_319_1:FormatText(StoryNameCfg[1332].name)

				arg_319_1.leftNameTxt_.text = var_322_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(423101075)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_12 = 41
				local var_322_13 = utf8.len(var_322_11)
				local var_322_14 = var_322_12 <= 0 and var_322_8 or var_322_8 * (var_322_13 / var_322_12)

				if var_322_14 > 0 and var_322_8 < var_322_14 then
					arg_319_1.talkMaxDuration = var_322_14

					if var_322_14 + var_322_7 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_7
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101075", "story_v_out_423101.awb") ~= 0 then
					local var_322_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101075", "story_v_out_423101.awb") / 1000

					if var_322_15 + var_322_7 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_7
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_423101", "423101075", "story_v_out_423101.awb")

						arg_319_1:RecordAudio("423101075", var_322_16)
						arg_319_1:RecordAudio("423101075", var_322_16)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_423101", "423101075", "story_v_out_423101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_423101", "423101075", "story_v_out_423101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_17 = math.max(var_322_8, arg_319_1.talkMaxDuration)

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_17 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_7) / var_322_17

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_7 + var_322_17 and arg_319_1.time_ < var_322_7 + var_322_17 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play423101076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 423101076
		arg_323_1.duration_ = 5.9

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play423101077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1083"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1083 == nil then
				arg_323_1.var_.actorSpriteComps1083 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps1083 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 0.5, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1083 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1083 = nil
			end

			local var_326_8 = arg_323_1.actors_["1083"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos1083 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1083", 7)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -2000, 0)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1083, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_326_15 = arg_323_1.bgs_.ST0113.transform
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.var_.moveOldPosST0113 = var_326_15.localPosition
			end

			local var_326_17 = 1.36666666666667

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17
				local var_326_19 = Vector3.New(0, 1, 9)

				var_326_15.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPosST0113, var_326_19, var_326_18)
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 then
				var_326_15.localPosition = Vector3.New(0, 1, 9)
			end

			local var_326_20 = 0.9
			local var_326_21 = 1.625

			if var_326_20 < arg_323_1.time_ and arg_323_1.time_ <= var_326_20 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_22 = arg_323_1:GetWordFromCfg(423101076)
				local var_326_23 = arg_323_1:FormatText(var_326_22.content)

				arg_323_1.text_.text = var_326_23

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_24 = 65
				local var_326_25 = utf8.len(var_326_23)
				local var_326_26 = var_326_24 <= 0 and var_326_21 or var_326_21 * (var_326_25 / var_326_24)

				if var_326_26 > 0 and var_326_21 < var_326_26 then
					arg_323_1.talkMaxDuration = var_326_26

					if var_326_26 + var_326_20 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_26 + var_326_20
					end
				end

				arg_323_1.text_.text = var_326_23
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_27 = math.max(var_326_21, arg_323_1.talkMaxDuration)

			if var_326_20 <= arg_323_1.time_ and arg_323_1.time_ < var_326_20 + var_326_27 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_20) / var_326_27

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_20 + var_326_27 and arg_323_1.time_ < var_326_20 + var_326_27 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0113",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.36666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeOutQuad
				}
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play423101077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 423101077
		arg_327_1.duration_ = 10.1

		local var_327_0 = {
			zh = 6.933,
			ja = 10.1
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play423101078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.725

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[1336].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(423101077)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 29
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101077", "story_v_out_423101.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101077", "story_v_out_423101.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_423101", "423101077", "story_v_out_423101.awb")

						arg_327_1:RecordAudio("423101077", var_330_9)
						arg_327_1:RecordAudio("423101077", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_423101", "423101077", "story_v_out_423101.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_423101", "423101077", "story_v_out_423101.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play423101078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 423101078
		arg_331_1.duration_ = 6.23

		local var_331_0 = {
			zh = 5,
			ja = 6.233
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play423101079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1083"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1083 == nil then
				arg_331_1.var_.actorSpriteComps1083 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps1083 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 1, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1083 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1083 = nil
			end

			local var_334_8 = arg_331_1.actors_["1083"].transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.moveOldPos1083 = var_334_8.localPosition
				var_334_8.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1083", 3)

				local var_334_10 = var_334_8.childCount

				for iter_334_4 = 0, var_334_10 - 1 do
					local var_334_11 = var_334_8:GetChild(iter_334_4)

					if var_334_11.name == "split_7" or not string.find(var_334_11.name, "split") then
						var_334_11.gameObject:SetActive(true)
					else
						var_334_11.gameObject:SetActive(false)
					end
				end
			end

			local var_334_12 = 0.001

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_12 then
				local var_334_13 = (arg_331_1.time_ - var_334_9) / var_334_12
				local var_334_14 = Vector3.New(-50, -345, -345)

				var_334_8.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1083, var_334_14, var_334_13)
			end

			if arg_331_1.time_ >= var_334_9 + var_334_12 and arg_331_1.time_ < var_334_9 + var_334_12 + arg_334_0 then
				var_334_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_334_15 = 0
			local var_334_16 = 0.675

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[1332].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(423101078)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 27
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101078", "story_v_out_423101.awb") ~= 0 then
					local var_334_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101078", "story_v_out_423101.awb") / 1000

					if var_334_23 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_15
					end

					if var_334_18.prefab_name ~= "" and arg_331_1.actors_[var_334_18.prefab_name] ~= nil then
						local var_334_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_18.prefab_name].transform, "story_v_out_423101", "423101078", "story_v_out_423101.awb")

						arg_331_1:RecordAudio("423101078", var_334_24)
						arg_331_1:RecordAudio("423101078", var_334_24)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_423101", "423101078", "story_v_out_423101.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_423101", "423101078", "story_v_out_423101.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_25 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_25 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_25

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_25 and arg_331_1.time_ < var_334_15 + var_334_25 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play423101079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 423101079
		arg_335_1.duration_ = 7.9

		local var_335_0 = {
			zh = 7.233,
			ja = 7.9
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
				arg_335_0:Play423101080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1083"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1083 == nil then
				arg_335_1.var_.actorSpriteComps1083 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps1083 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 0.5, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1083 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1083 = nil
			end

			local var_338_8 = 0.166666666666667
			local var_338_9 = 1

			if var_338_8 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				local var_338_10 = "play"
				local var_338_11 = "effect"

				arg_335_1:AudioAction(var_338_10, var_338_11, "se_story_140", "se_story_140_gun01", "")
			end

			local var_338_12 = 1.86666666666667
			local var_338_13 = 1

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 then
				local var_338_14 = "play"
				local var_338_15 = "effect"

				arg_335_1:AudioAction(var_338_14, var_338_15, "se_story_140", "se_story_140_gun01", "")
			end

			local var_338_16 = 0
			local var_338_17 = 0.925

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_18 = arg_335_1:FormatText(StoryNameCfg[1336].name)

				arg_335_1.leftNameTxt_.text = var_338_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_19 = arg_335_1:GetWordFromCfg(423101079)
				local var_338_20 = arg_335_1:FormatText(var_338_19.content)

				arg_335_1.text_.text = var_338_20

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_21 = 37
				local var_338_22 = utf8.len(var_338_20)
				local var_338_23 = var_338_21 <= 0 and var_338_17 or var_338_17 * (var_338_22 / var_338_21)

				if var_338_23 > 0 and var_338_17 < var_338_23 then
					arg_335_1.talkMaxDuration = var_338_23

					if var_338_23 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_16
					end
				end

				arg_335_1.text_.text = var_338_20
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101079", "story_v_out_423101.awb") ~= 0 then
					local var_338_24 = manager.audio:GetVoiceLength("story_v_out_423101", "423101079", "story_v_out_423101.awb") / 1000

					if var_338_24 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_24 + var_338_16
					end

					if var_338_19.prefab_name ~= "" and arg_335_1.actors_[var_338_19.prefab_name] ~= nil then
						local var_338_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_19.prefab_name].transform, "story_v_out_423101", "423101079", "story_v_out_423101.awb")

						arg_335_1:RecordAudio("423101079", var_338_25)
						arg_335_1:RecordAudio("423101079", var_338_25)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_423101", "423101079", "story_v_out_423101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_423101", "423101079", "story_v_out_423101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_26 = math.max(var_338_17, arg_335_1.talkMaxDuration)

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_26 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_16) / var_338_26

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_16 + var_338_26 and arg_335_1.time_ < var_338_16 + var_338_26 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play423101080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 423101080
		arg_339_1.duration_ = 9.23

		local var_339_0 = {
			zh = 5.666,
			ja = 9.233
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
				arg_339_0:Play423101081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.75

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[1336].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(423101080)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 30
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101080", "story_v_out_423101.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101080", "story_v_out_423101.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_423101", "423101080", "story_v_out_423101.awb")

						arg_339_1:RecordAudio("423101080", var_342_9)
						arg_339_1:RecordAudio("423101080", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_423101", "423101080", "story_v_out_423101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_423101", "423101080", "story_v_out_423101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play423101081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 423101081
		arg_343_1.duration_ = 4.37

		local var_343_0 = {
			zh = 4.366,
			ja = 3.933
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
				arg_343_0:Play423101082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1083"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1083 == nil then
				arg_343_1.var_.actorSpriteComps1083 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps1083 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1083 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1083 = nil
			end

			local var_346_8 = arg_343_1.actors_["1083"].transform
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.var_.moveOldPos1083 = var_346_8.localPosition
				var_346_8.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1083", 3)

				local var_346_10 = var_346_8.childCount

				for iter_346_4 = 0, var_346_10 - 1 do
					local var_346_11 = var_346_8:GetChild(iter_346_4)

					if var_346_11.name == "" or not string.find(var_346_11.name, "split") then
						var_346_11.gameObject:SetActive(true)
					else
						var_346_11.gameObject:SetActive(false)
					end
				end
			end

			local var_346_12 = 0.001

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_12 then
				local var_346_13 = (arg_343_1.time_ - var_346_9) / var_346_12
				local var_346_14 = Vector3.New(-50, -345, -345)

				var_346_8.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1083, var_346_14, var_346_13)
			end

			if arg_343_1.time_ >= var_346_9 + var_346_12 and arg_343_1.time_ < var_346_9 + var_346_12 + arg_346_0 then
				var_346_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_346_15 = 0
			local var_346_16 = 0.475

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_17 = arg_343_1:FormatText(StoryNameCfg[1332].name)

				arg_343_1.leftNameTxt_.text = var_346_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(423101081)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_20 = 19
				local var_346_21 = utf8.len(var_346_19)
				local var_346_22 = var_346_20 <= 0 and var_346_16 or var_346_16 * (var_346_21 / var_346_20)

				if var_346_22 > 0 and var_346_16 < var_346_22 then
					arg_343_1.talkMaxDuration = var_346_22

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101081", "story_v_out_423101.awb") ~= 0 then
					local var_346_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101081", "story_v_out_423101.awb") / 1000

					if var_346_23 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_15
					end

					if var_346_18.prefab_name ~= "" and arg_343_1.actors_[var_346_18.prefab_name] ~= nil then
						local var_346_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_18.prefab_name].transform, "story_v_out_423101", "423101081", "story_v_out_423101.awb")

						arg_343_1:RecordAudio("423101081", var_346_24)
						arg_343_1:RecordAudio("423101081", var_346_24)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_423101", "423101081", "story_v_out_423101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_423101", "423101081", "story_v_out_423101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_25 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_15) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_15 + var_346_25 and arg_343_1.time_ < var_346_15 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 423101082
		arg_347_1.duration_ = 2.6

		local var_347_0 = {
			zh = 2.6,
			ja = 2.566
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
				arg_347_0:Play423101083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1083"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps1083 == nil then
				arg_347_1.var_.actorSpriteComps1083 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps1083 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 0.5, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps1083 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps1083 = nil
			end

			local var_350_8 = 0
			local var_350_9 = 0.3

			if var_350_8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_10 = arg_347_1:FormatText(StoryNameCfg[1336].name)

				arg_347_1.leftNameTxt_.text = var_350_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_11 = arg_347_1:GetWordFromCfg(423101082)
				local var_350_12 = arg_347_1:FormatText(var_350_11.content)

				arg_347_1.text_.text = var_350_12

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 12
				local var_350_14 = utf8.len(var_350_12)
				local var_350_15 = var_350_13 <= 0 and var_350_9 or var_350_9 * (var_350_14 / var_350_13)

				if var_350_15 > 0 and var_350_9 < var_350_15 then
					arg_347_1.talkMaxDuration = var_350_15

					if var_350_15 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_8
					end
				end

				arg_347_1.text_.text = var_350_12
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101082", "story_v_out_423101.awb") ~= 0 then
					local var_350_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101082", "story_v_out_423101.awb") / 1000

					if var_350_16 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_16 + var_350_8
					end

					if var_350_11.prefab_name ~= "" and arg_347_1.actors_[var_350_11.prefab_name] ~= nil then
						local var_350_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_11.prefab_name].transform, "story_v_out_423101", "423101082", "story_v_out_423101.awb")

						arg_347_1:RecordAudio("423101082", var_350_17)
						arg_347_1:RecordAudio("423101082", var_350_17)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_423101", "423101082", "story_v_out_423101.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_423101", "423101082", "story_v_out_423101.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_18 = math.max(var_350_9, arg_347_1.talkMaxDuration)

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_18 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_8) / var_350_18

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_8 + var_350_18 and arg_347_1.time_ < var_350_8 + var_350_18 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play423101083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 423101083
		arg_351_1.duration_ = 7

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play423101084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				local var_354_1 = manager.ui.mainCamera.transform.localPosition
				local var_354_2 = Vector3.New(0, 0, 10) + Vector3.New(var_354_1.x, var_354_1.y, 0)
				local var_354_3 = arg_351_1.bgs_.I25h

				var_354_3.transform.localPosition = var_354_2
				var_354_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_4 = var_354_3:GetComponent("SpriteRenderer")

				if var_354_4 and var_354_4.sprite then
					local var_354_5 = (var_354_3.transform.localPosition - var_354_1).z
					local var_354_6 = manager.ui.mainCameraCom_
					local var_354_7 = 2 * var_354_5 * Mathf.Tan(var_354_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_354_8 = var_354_7 * var_354_6.aspect
					local var_354_9 = var_354_4.sprite.bounds.size.x
					local var_354_10 = var_354_4.sprite.bounds.size.y
					local var_354_11 = var_354_8 / var_354_9
					local var_354_12 = var_354_7 / var_354_10
					local var_354_13 = var_354_12 < var_354_11 and var_354_11 or var_354_12

					var_354_3.transform.localScale = Vector3.New(var_354_13, var_354_13, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "I25h" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_14 = 2

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			local var_354_15 = 0.3

			if arg_351_1.time_ >= var_354_14 + var_354_15 and arg_351_1.time_ < var_354_14 + var_354_15 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_16 = 0

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_17 = 0.4

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_17 then
				local var_354_18 = (arg_351_1.time_ - var_354_16) / var_354_17
				local var_354_19 = Color.New(1, 1, 1)

				var_354_19.a = Mathf.Lerp(1, 0, var_354_18)
				arg_351_1.mask_.color = var_354_19
			end

			if arg_351_1.time_ >= var_354_16 + var_354_17 and arg_351_1.time_ < var_354_16 + var_354_17 + arg_354_0 then
				local var_354_20 = Color.New(1, 1, 1)
				local var_354_21 = 0

				arg_351_1.mask_.enabled = false
				var_354_20.a = var_354_21
				arg_351_1.mask_.color = var_354_20
			end

			local var_354_22 = arg_351_1.actors_["1083"].transform
			local var_354_23 = 0

			if var_354_23 < arg_351_1.time_ and arg_351_1.time_ <= var_354_23 + arg_354_0 then
				arg_351_1.var_.moveOldPos1083 = var_354_22.localPosition
				var_354_22.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1083", 7)

				local var_354_24 = var_354_22.childCount

				for iter_354_2 = 0, var_354_24 - 1 do
					local var_354_25 = var_354_22:GetChild(iter_354_2)

					if var_354_25.name == "" or not string.find(var_354_25.name, "split") then
						var_354_25.gameObject:SetActive(true)
					else
						var_354_25.gameObject:SetActive(false)
					end
				end
			end

			local var_354_26 = 0.001

			if var_354_23 <= arg_351_1.time_ and arg_351_1.time_ < var_354_23 + var_354_26 then
				local var_354_27 = (arg_351_1.time_ - var_354_23) / var_354_26
				local var_354_28 = Vector3.New(0, -2000, 0)

				var_354_22.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1083, var_354_28, var_354_27)
			end

			if arg_351_1.time_ >= var_354_23 + var_354_26 and arg_351_1.time_ < var_354_23 + var_354_26 + arg_354_0 then
				var_354_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_354_29 = manager.ui.mainCamera.transform
			local var_354_30 = 0

			if var_354_30 < arg_351_1.time_ and arg_351_1.time_ <= var_354_30 + arg_354_0 then
				arg_351_1.var_.shakeOldPos = var_354_29.localPosition
			end

			local var_354_31 = 0.6

			if var_354_30 <= arg_351_1.time_ and arg_351_1.time_ < var_354_30 + var_354_31 then
				local var_354_32 = (arg_351_1.time_ - var_354_30) / 0.066
				local var_354_33, var_354_34 = math.modf(var_354_32)

				var_354_29.localPosition = Vector3.New(var_354_34 * 0.13, var_354_34 * 0.13, var_354_34 * 0.13) + arg_351_1.var_.shakeOldPos
			end

			if arg_351_1.time_ >= var_354_30 + var_354_31 and arg_351_1.time_ < var_354_30 + var_354_31 + arg_354_0 then
				var_354_29.localPosition = arg_351_1.var_.shakeOldPos
			end

			local var_354_35 = manager.ui.mainCamera.transform
			local var_354_36 = 0

			if var_354_36 < arg_351_1.time_ and arg_351_1.time_ <= var_354_36 + arg_354_0 then
				local var_354_37 = arg_351_1.var_.effectmotuozhuangche
				local var_354_38
				local var_354_39 = var_354_35

				if not var_354_37 then
					var_354_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_354_39)
					var_354_37.name = "motuozhuangche"
					arg_351_1.var_.effectmotuozhuangche = var_354_37
				else
					var_354_37.transform:SetParent(var_354_39)
				end

				var_354_37.transform.localPosition = Vector3.New(0, 0, 0)
				var_354_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_354_40 = manager.ui.mainCamera.transform
			local var_354_41 = 1.5

			if var_354_41 < arg_351_1.time_ and arg_351_1.time_ <= var_354_41 + arg_354_0 then
				local var_354_42 = arg_351_1.var_.effectmotuozhuangche

				if var_354_42 then
					Object.Destroy(var_354_42)

					arg_351_1.var_.effectmotuozhuangche = nil
				end
			end

			local var_354_43 = manager.ui.mainCamera.transform
			local var_354_44 = 0

			if var_354_44 < arg_351_1.time_ and arg_351_1.time_ <= var_354_44 + arg_354_0 then
				local var_354_45 = arg_351_1.var_.effectaishimoturoche1

				if var_354_45 then
					Object.Destroy(var_354_45)

					arg_351_1.var_.effectaishimoturoche1 = nil
				end
			end

			local var_354_46 = 0
			local var_354_47 = 1

			if var_354_46 < arg_351_1.time_ and arg_351_1.time_ <= var_354_46 + arg_354_0 then
				local var_354_48 = "play"
				local var_354_49 = "effect"

				arg_351_1:AudioAction(var_354_48, var_354_49, "se_story_144", "se_story_144_impact", "")
			end

			local var_354_50 = 0.034
			local var_354_51 = 1

			if var_354_50 < arg_351_1.time_ and arg_351_1.time_ <= var_354_50 + arg_354_0 then
				local var_354_52 = "stop"
				local var_354_53 = "effect"

				arg_351_1:AudioAction(var_354_52, var_354_53, "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			local var_354_54 = 0.294969900045544
			local var_354_55 = 1

			if var_354_54 < arg_351_1.time_ and arg_351_1.time_ <= var_354_54 + arg_354_0 then
				local var_354_56 = "play"
				local var_354_57 = "effect"

				arg_351_1:AudioAction(var_354_56, var_354_57, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_58 = 2
			local var_354_59 = 1.85

			if var_354_58 < arg_351_1.time_ and arg_351_1.time_ <= var_354_58 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_60 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_60:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_61 = arg_351_1:GetWordFromCfg(423101083)
				local var_354_62 = arg_351_1:FormatText(var_354_61.content)

				arg_351_1.text_.text = var_354_62

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_63 = 74
				local var_354_64 = utf8.len(var_354_62)
				local var_354_65 = var_354_63 <= 0 and var_354_59 or var_354_59 * (var_354_64 / var_354_63)

				if var_354_65 > 0 and var_354_59 < var_354_65 then
					arg_351_1.talkMaxDuration = var_354_65
					var_354_58 = var_354_58 + 0.3

					if var_354_65 + var_354_58 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_65 + var_354_58
					end
				end

				arg_351_1.text_.text = var_354_62
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_66 = var_354_58 + 0.3
			local var_354_67 = math.max(var_354_59, arg_351_1.talkMaxDuration)

			if var_354_66 <= arg_351_1.time_ and arg_351_1.time_ < var_354_66 + var_354_67 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_66) / var_354_67

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_66 + var_354_67 and arg_351_1.time_ < var_354_66 + var_354_67 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play423101084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 423101084
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play423101085(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 1.475

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(423101084)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 59
				local var_360_5 = utf8.len(var_360_3)
				local var_360_6 = var_360_4 <= 0 and var_360_1 or var_360_1 * (var_360_5 / var_360_4)

				if var_360_6 > 0 and var_360_1 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_7 and arg_357_1.time_ < var_360_0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play423101085 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 423101085
		arg_361_1.duration_ = 4.43

		local var_361_0 = {
			zh = 4.433,
			ja = 3.066
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play423101086(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.275

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[1336].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(423101085)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 11
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101085", "story_v_out_423101.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101085", "story_v_out_423101.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_423101", "423101085", "story_v_out_423101.awb")

						arg_361_1:RecordAudio("423101085", var_364_9)
						arg_361_1:RecordAudio("423101085", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_423101", "423101085", "story_v_out_423101.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_423101", "423101085", "story_v_out_423101.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_10 and arg_361_1.time_ < var_364_0 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play423101086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 423101086
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play423101087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.45

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(423101086)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 18
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play423101087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 423101087
		arg_369_1.duration_ = 7.93

		local var_369_0 = {
			zh = 7.933,
			ja = 5.366
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play423101088(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1083"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1083 == nil then
				arg_369_1.var_.actorSpriteComps1083 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps1083 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 1, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1083 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1083 = nil
			end

			local var_372_8 = arg_369_1.actors_["1083"].transform
			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.var_.moveOldPos1083 = var_372_8.localPosition
				var_372_8.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1083", 3)

				local var_372_10 = var_372_8.childCount

				for iter_372_4 = 0, var_372_10 - 1 do
					local var_372_11 = var_372_8:GetChild(iter_372_4)

					if var_372_11.name == "split_2" or not string.find(var_372_11.name, "split") then
						var_372_11.gameObject:SetActive(true)
					else
						var_372_11.gameObject:SetActive(false)
					end
				end
			end

			local var_372_12 = 0.001

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_12 then
				local var_372_13 = (arg_369_1.time_ - var_372_9) / var_372_12
				local var_372_14 = Vector3.New(-50, -345, -345)

				var_372_8.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1083, var_372_14, var_372_13)
			end

			if arg_369_1.time_ >= var_372_9 + var_372_12 and arg_369_1.time_ < var_372_9 + var_372_12 + arg_372_0 then
				var_372_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_372_15 = 0
			local var_372_16 = 0.9

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[1332].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(423101087)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 36
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_16 or var_372_16 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_16 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101087", "story_v_out_423101.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101087", "story_v_out_423101.awb") / 1000

					if var_372_23 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_15
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_423101", "423101087", "story_v_out_423101.awb")

						arg_369_1:RecordAudio("423101087", var_372_24)
						arg_369_1:RecordAudio("423101087", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_423101", "423101087", "story_v_out_423101.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_423101", "423101087", "story_v_out_423101.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_25 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_25

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_25 and arg_369_1.time_ < var_372_15 + var_372_25 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play423101088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 423101088
		arg_373_1.duration_ = 5.7

		local var_373_0 = {
			zh = 4.333,
			ja = 5.7
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
			arg_373_1.auto_ = false
		end

		function arg_373_1.playNext_(arg_375_0)
			arg_373_1.onStoryFinished_()
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1083"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1083 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1083", 3)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "split_7" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(-50, -345, -345)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1083, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_376_7 = 0
			local var_376_8 = 0.45

			if var_376_7 < arg_373_1.time_ and arg_373_1.time_ <= var_376_7 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_9 = arg_373_1:FormatText(StoryNameCfg[1332].name)

				arg_373_1.leftNameTxt_.text = var_376_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_10 = arg_373_1:GetWordFromCfg(423101088)
				local var_376_11 = arg_373_1:FormatText(var_376_10.content)

				arg_373_1.text_.text = var_376_11

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_12 = 18
				local var_376_13 = utf8.len(var_376_11)
				local var_376_14 = var_376_12 <= 0 and var_376_8 or var_376_8 * (var_376_13 / var_376_12)

				if var_376_14 > 0 and var_376_8 < var_376_14 then
					arg_373_1.talkMaxDuration = var_376_14

					if var_376_14 + var_376_7 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_7
					end
				end

				arg_373_1.text_.text = var_376_11
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101088", "story_v_out_423101.awb") ~= 0 then
					local var_376_15 = manager.audio:GetVoiceLength("story_v_out_423101", "423101088", "story_v_out_423101.awb") / 1000

					if var_376_15 + var_376_7 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_15 + var_376_7
					end

					if var_376_10.prefab_name ~= "" and arg_373_1.actors_[var_376_10.prefab_name] ~= nil then
						local var_376_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_10.prefab_name].transform, "story_v_out_423101", "423101088", "story_v_out_423101.awb")

						arg_373_1:RecordAudio("423101088", var_376_16)
						arg_373_1:RecordAudio("423101088", var_376_16)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_423101", "423101088", "story_v_out_423101.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_423101", "423101088", "story_v_out_423101.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_17 = math.max(var_376_8, arg_373_1.talkMaxDuration)

			if var_376_7 <= arg_373_1.time_ and arg_373_1.time_ < var_376_7 + var_376_17 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_7) / var_376_17

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_7 + var_376_17 and arg_373_1.time_ < var_376_7 + var_376_17 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/SS2303",
		"TextureConfig/Background/L08g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2303a",
		"TextureConfig/Background/ST0113"
	},
	voices = {
		"story_v_out_423101.awb"
	}
}
