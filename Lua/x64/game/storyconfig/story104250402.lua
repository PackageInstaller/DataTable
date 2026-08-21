return {
	Play425042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425042001
		arg_1_1.duration_ = 3.4

		local var_1_0 = {
			zh = 3.066,
			ja = 3.4
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
				arg_1_0:Play425042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07"

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
				local var_4_5 = arg_1_1.bgs_.I07

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
					if iter_4_0 ~= "I07" then
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

			local var_4_24 = "1012"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

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

			local var_4_28 = arg_1_1.actors_["1012"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1012 == nil then
				arg_1_1.var_.actorSpriteComps1012 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1012 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1012 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1012 = nil
			end

			local var_4_36 = arg_1_1.actors_["1012"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1012 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1012", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -465, 300)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1012, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -465, 300)
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

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

				arg_1_1:AudioAction(var_4_57, var_4_58, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.075

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[595].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(425042001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042001", "story_v_out_425042.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_425042", "425042001", "story_v_out_425042.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_425042", "425042001", "story_v_out_425042.awb")

						arg_1_1:RecordAudio("425042001", var_4_69)
						arg_1_1:RecordAudio("425042001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425042", "425042001", "story_v_out_425042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425042", "425042001", "story_v_out_425042.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425042002
		arg_9_1.duration_ = 8.6

		local var_9_0 = {
			zh = 5.1,
			ja = 8.6
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
				arg_9_0:Play425042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1012"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1012 == nil then
				arg_9_1.var_.actorSpriteComps1012 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1012 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1012 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1012 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.65

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[1430].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(425042002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 26
				local var_12_14 = utf8.len(var_12_12)
				local var_12_15 = var_12_13 <= 0 and var_12_9 or var_12_9 * (var_12_14 / var_12_13)

				if var_12_15 > 0 and var_12_9 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042002", "story_v_out_425042.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_425042", "425042002", "story_v_out_425042.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_425042", "425042002", "story_v_out_425042.awb")

						arg_9_1:RecordAudio("425042002", var_12_17)
						arg_9_1:RecordAudio("425042002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425042", "425042002", "story_v_out_425042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425042", "425042002", "story_v_out_425042.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_18 and arg_9_1.time_ < var_12_8 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play425042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425042003
		arg_13_1.duration_ = 4.8

		local var_13_0 = {
			zh = 4.433,
			ja = 4.8
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
				arg_13_0:Play425042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1012"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1012 == nil then
				arg_13_1.var_.actorSpriteComps1012 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1012 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1012 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1012 = nil
			end

			local var_16_8 = arg_13_1.actors_["1012"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1012 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1012", 3)

				local var_16_10 = var_16_8.childCount

				for iter_16_4 = 0, var_16_10 - 1 do
					local var_16_11 = var_16_8:GetChild(iter_16_4)

					if var_16_11.name == "" or not string.find(var_16_11.name, "split") then
						var_16_11.gameObject:SetActive(true)
					else
						var_16_11.gameObject:SetActive(false)
					end
				end
			end

			local var_16_12 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_12 then
				local var_16_13 = (arg_13_1.time_ - var_16_9) / var_16_12
				local var_16_14 = Vector3.New(0, -465, 300)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1012, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, -465, 300)
			end

			local var_16_15 = 0
			local var_16_16 = 0.45

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[595].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(425042003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 18
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042003", "story_v_out_425042.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042003", "story_v_out_425042.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_425042", "425042003", "story_v_out_425042.awb")

						arg_13_1:RecordAudio("425042003", var_16_24)
						arg_13_1:RecordAudio("425042003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425042", "425042003", "story_v_out_425042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425042", "425042003", "story_v_out_425042.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425042004
		arg_17_1.duration_ = 4.73

		local var_17_0 = {
			zh = 4.233,
			ja = 4.733
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
				arg_17_0:Play425042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1012"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1012 == nil then
				arg_17_1.var_.actorSpriteComps1012 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1012 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1012 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1012 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.425

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[1430].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(425042004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 17
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_9 or var_20_9 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_9 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042004", "story_v_out_425042.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_425042", "425042004", "story_v_out_425042.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_425042", "425042004", "story_v_out_425042.awb")

						arg_17_1:RecordAudio("425042004", var_20_17)
						arg_17_1:RecordAudio("425042004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425042", "425042004", "story_v_out_425042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425042", "425042004", "story_v_out_425042.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_18 and arg_17_1.time_ < var_20_8 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play425042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425042005
		arg_21_1.duration_ = 3.4

		local var_21_0 = {
			zh = 2.6,
			ja = 3.4
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
				arg_21_0:Play425042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1012"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1012 == nil then
				arg_21_1.var_.actorSpriteComps1012 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1012 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1012 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1012 = nil
			end

			local var_24_8 = arg_21_1.actors_["1012"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos1012 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1012", 3)

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
				local var_24_14 = Vector3.New(0, -465, 300)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1012, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -465, 300)
			end

			local var_24_15 = 0
			local var_24_16 = 0.2

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[595].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(425042005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042005", "story_v_out_425042.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042005", "story_v_out_425042.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_425042", "425042005", "story_v_out_425042.awb")

						arg_21_1:RecordAudio("425042005", var_24_24)
						arg_21_1:RecordAudio("425042005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425042", "425042005", "story_v_out_425042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425042", "425042005", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425042006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play425042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1012"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1012 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1012", 7)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -2000, 300)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1012, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_28_7 = 0
			local var_28_8 = 1.25

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(425042006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 50
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_8 or var_28_8 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_8 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_14 and arg_25_1.time_ < var_28_7 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play425042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425042007
		arg_29_1.duration_ = 7.87

		local var_29_0 = {
			zh = 6.1,
			ja = 7.866
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
				arg_29_0:Play425042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1012"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1012 == nil then
				arg_29_1.var_.actorSpriteComps1012 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1012 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1012 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1012 = nil
			end

			local var_32_8 = arg_29_1.actors_["1012"].transform
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.var_.moveOldPos1012 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1012", 3)

				local var_32_10 = var_32_8.childCount

				for iter_32_4 = 0, var_32_10 - 1 do
					local var_32_11 = var_32_8:GetChild(iter_32_4)

					if var_32_11.name == "" or not string.find(var_32_11.name, "split") then
						var_32_11.gameObject:SetActive(true)
					else
						var_32_11.gameObject:SetActive(false)
					end
				end
			end

			local var_32_12 = 0.001

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_12 then
				local var_32_13 = (arg_29_1.time_ - var_32_9) / var_32_12
				local var_32_14 = Vector3.New(0, -465, 300)

				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1012, var_32_14, var_32_13)
			end

			if arg_29_1.time_ >= var_32_9 + var_32_12 and arg_29_1.time_ < var_32_9 + var_32_12 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, -465, 300)
			end

			local var_32_15 = 0
			local var_32_16 = 0.775

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[595].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(425042007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 31
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042007", "story_v_out_425042.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042007", "story_v_out_425042.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_425042", "425042007", "story_v_out_425042.awb")

						arg_29_1:RecordAudio("425042007", var_32_24)
						arg_29_1:RecordAudio("425042007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425042", "425042007", "story_v_out_425042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425042", "425042007", "story_v_out_425042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425042008
		arg_33_1.duration_ = 13.53

		local var_33_0 = {
			zh = 5.8,
			ja = 13.533
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
				arg_33_0:Play425042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.7

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[595].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(425042008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042008", "story_v_out_425042.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042008", "story_v_out_425042.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_425042", "425042008", "story_v_out_425042.awb")

						arg_33_1:RecordAudio("425042008", var_36_9)
						arg_33_1:RecordAudio("425042008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425042", "425042008", "story_v_out_425042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425042", "425042008", "story_v_out_425042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play425042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425042009
		arg_37_1.duration_ = 12.5

		local var_37_0 = {
			zh = 9.366,
			ja = 12.5
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
				arg_37_0:Play425042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1012"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1012 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1012", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -465, 300)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1012, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -465, 300)
			end

			local var_40_7 = 0
			local var_40_8 = 0.95

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_9 = arg_37_1:FormatText(StoryNameCfg[595].name)

				arg_37_1.leftNameTxt_.text = var_40_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(425042009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042009", "story_v_out_425042.awb") ~= 0 then
					local var_40_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042009", "story_v_out_425042.awb") / 1000

					if var_40_15 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_7
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_425042", "425042009", "story_v_out_425042.awb")

						arg_37_1:RecordAudio("425042009", var_40_16)
						arg_37_1:RecordAudio("425042009", var_40_16)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425042", "425042009", "story_v_out_425042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425042", "425042009", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425042010
		arg_41_1.duration_ = 3.23

		local var_41_0 = {
			zh = 3.233,
			ja = 3.1
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
				arg_41_0:Play425042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "1137"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_44_1) then
					local var_44_2 = Object.Instantiate(var_44_1, arg_41_1.canvasGo_.transform)

					var_44_2.transform:SetSiblingIndex(1)

					var_44_2.name = var_44_0
					var_44_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_[var_44_0] = var_44_2

					local var_44_3 = var_44_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs(var_44_3) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_4 = arg_41_1.actors_["1137"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps1137 == nil then
				arg_41_1.var_.actorSpriteComps1137 = var_44_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.actorSpriteComps1137 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								local var_44_8 = Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, var_44_7)
								local var_44_9 = Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, var_44_7)
								local var_44_10 = Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, var_44_7)

								iter_44_3.color = Color.New(var_44_8, var_44_9, var_44_10)
							else
								local var_44_11 = Mathf.Lerp(iter_44_3.color.r, 1, var_44_7)

								iter_44_3.color = Color.New(var_44_11, var_44_11, var_44_11)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.actorSpriteComps1137 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1137 = nil
			end

			local var_44_12 = arg_41_1.actors_["1012"]
			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps1012 == nil then
				arg_41_1.var_.actorSpriteComps1012 = var_44_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_14 = 0.2

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_14 and not isNil(var_44_12) then
				local var_44_15 = (arg_41_1.time_ - var_44_13) / var_44_14

				if arg_41_1.var_.actorSpriteComps1012 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								local var_44_16 = Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, var_44_15)
								local var_44_17 = Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, var_44_15)
								local var_44_18 = Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, var_44_15)

								iter_44_7.color = Color.New(var_44_16, var_44_17, var_44_18)
							else
								local var_44_19 = Mathf.Lerp(iter_44_7.color.r, 0.5, var_44_15)

								iter_44_7.color = Color.New(var_44_19, var_44_19, var_44_19)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_13 + var_44_14 and arg_41_1.time_ < var_44_13 + var_44_14 + arg_44_0 and not isNil(var_44_12) and arg_41_1.var_.actorSpriteComps1012 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1012 = nil
			end

			local var_44_20 = arg_41_1.actors_["1137"].transform
			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.var_.moveOldPos1137 = var_44_20.localPosition
				var_44_20.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1137", 4)

				local var_44_22 = var_44_20.childCount

				for iter_44_10 = 0, var_44_22 - 1 do
					local var_44_23 = var_44_20:GetChild(iter_44_10)

					if var_44_23.name == "split_5" or not string.find(var_44_23.name, "split") then
						var_44_23.gameObject:SetActive(true)
					else
						var_44_23.gameObject:SetActive(false)
					end
				end
			end

			local var_44_24 = 0.001

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_24 then
				local var_44_25 = (arg_41_1.time_ - var_44_21) / var_44_24
				local var_44_26 = Vector3.New(390, -425, -200)

				var_44_20.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1137, var_44_26, var_44_25)
			end

			if arg_41_1.time_ >= var_44_21 + var_44_24 and arg_41_1.time_ < var_44_21 + var_44_24 + arg_44_0 then
				var_44_20.localPosition = Vector3.New(390, -425, -200)
			end

			local var_44_27 = arg_41_1.actors_["1012"].transform
			local var_44_28 = 0

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.var_.moveOldPos1012 = var_44_27.localPosition
				var_44_27.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1012", 2)

				local var_44_29 = var_44_27.childCount

				for iter_44_11 = 0, var_44_29 - 1 do
					local var_44_30 = var_44_27:GetChild(iter_44_11)

					if var_44_30.name == "" or not string.find(var_44_30.name, "split") then
						var_44_30.gameObject:SetActive(true)
					else
						var_44_30.gameObject:SetActive(false)
					end
				end
			end

			local var_44_31 = 0.001

			if var_44_28 <= arg_41_1.time_ and arg_41_1.time_ < var_44_28 + var_44_31 then
				local var_44_32 = (arg_41_1.time_ - var_44_28) / var_44_31
				local var_44_33 = Vector3.New(-390, -465, 300)

				var_44_27.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1012, var_44_33, var_44_32)
			end

			if arg_41_1.time_ >= var_44_28 + var_44_31 and arg_41_1.time_ < var_44_28 + var_44_31 + arg_44_0 then
				var_44_27.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_44_34 = 0
			local var_44_35 = 0.175

			if var_44_34 < arg_41_1.time_ and arg_41_1.time_ <= var_44_34 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_36 = arg_41_1:FormatText(StoryNameCfg[15].name)

				arg_41_1.leftNameTxt_.text = var_44_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_37 = arg_41_1:GetWordFromCfg(425042010)
				local var_44_38 = arg_41_1:FormatText(var_44_37.content)

				arg_41_1.text_.text = var_44_38

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_39 = 7
				local var_44_40 = utf8.len(var_44_38)
				local var_44_41 = var_44_39 <= 0 and var_44_35 or var_44_35 * (var_44_40 / var_44_39)

				if var_44_41 > 0 and var_44_35 < var_44_41 then
					arg_41_1.talkMaxDuration = var_44_41

					if var_44_41 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_41 + var_44_34
					end
				end

				arg_41_1.text_.text = var_44_38
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042010", "story_v_out_425042.awb") ~= 0 then
					local var_44_42 = manager.audio:GetVoiceLength("story_v_out_425042", "425042010", "story_v_out_425042.awb") / 1000

					if var_44_42 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_34
					end

					if var_44_37.prefab_name ~= "" and arg_41_1.actors_[var_44_37.prefab_name] ~= nil then
						local var_44_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_37.prefab_name].transform, "story_v_out_425042", "425042010", "story_v_out_425042.awb")

						arg_41_1:RecordAudio("425042010", var_44_43)
						arg_41_1:RecordAudio("425042010", var_44_43)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425042", "425042010", "story_v_out_425042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425042", "425042010", "story_v_out_425042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_44 = math.max(var_44_35, arg_41_1.talkMaxDuration)

			if var_44_34 <= arg_41_1.time_ and arg_41_1.time_ < var_44_34 + var_44_44 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_34) / var_44_44

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_34 + var_44_44 and arg_41_1.time_ < var_44_34 + var_44_44 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "1012",
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
	Play425042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425042011
		arg_45_1.duration_ = 20.97

		local var_45_0 = {
			zh = 12.066,
			ja = 20.966
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
				arg_45_0:Play425042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1012"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1012 == nil then
				arg_45_1.var_.actorSpriteComps1012 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1012 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1012 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1012 = nil
			end

			local var_48_8 = arg_45_1.actors_["1137"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1137 == nil then
				arg_45_1.var_.actorSpriteComps1137 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps1137 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor2.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor2.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor2.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 0.5, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1137 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1137 = nil
			end

			local var_48_16 = arg_45_1.actors_["1012"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos1012 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1012", 2)

				local var_48_18 = var_48_16.childCount

				for iter_48_8 = 0, var_48_18 - 1 do
					local var_48_19 = var_48_16:GetChild(iter_48_8)

					if var_48_19.name == "" or not string.find(var_48_19.name, "split") then
						var_48_19.gameObject:SetActive(true)
					else
						var_48_19.gameObject:SetActive(false)
					end
				end
			end

			local var_48_20 = 0.001

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_17) / var_48_20
				local var_48_22 = Vector3.New(-390, -465, 300)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1012, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_48_23 = 0
			local var_48_24 = 1.45

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[595].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(425042011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 58
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042011", "story_v_out_425042.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042011", "story_v_out_425042.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_425042", "425042011", "story_v_out_425042.awb")

						arg_45_1:RecordAudio("425042011", var_48_32)
						arg_45_1:RecordAudio("425042011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425042", "425042011", "story_v_out_425042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425042", "425042011", "story_v_out_425042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425042012
		arg_49_1.duration_ = 13.13

		local var_49_0 = {
			zh = 10.333,
			ja = 13.133
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
				arg_49_0:Play425042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1012"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1012 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1012", 2)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(-390, -465, 300)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1012, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_52_7 = 0
			local var_52_8 = 1.4

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_9 = arg_49_1:FormatText(StoryNameCfg[595].name)

				arg_49_1.leftNameTxt_.text = var_52_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(425042012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 56
				local var_52_13 = utf8.len(var_52_11)
				local var_52_14 = var_52_12 <= 0 and var_52_8 or var_52_8 * (var_52_13 / var_52_12)

				if var_52_14 > 0 and var_52_8 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14

					if var_52_14 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042012", "story_v_out_425042.awb") ~= 0 then
					local var_52_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042012", "story_v_out_425042.awb") / 1000

					if var_52_15 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_7
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_425042", "425042012", "story_v_out_425042.awb")

						arg_49_1:RecordAudio("425042012", var_52_16)
						arg_49_1:RecordAudio("425042012", var_52_16)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_425042", "425042012", "story_v_out_425042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_425042", "425042012", "story_v_out_425042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_17 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_17 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_17

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_17 and arg_49_1.time_ < var_52_7 + var_52_17 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play425042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425042013
		arg_53_1.duration_ = 5.7

		local var_53_0 = {
			zh = 4.466,
			ja = 5.7
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
				arg_53_0:Play425042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1012"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1012 == nil then
				arg_53_1.var_.actorSpriteComps1012 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1012 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1012 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1012 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.45

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_10 = arg_53_1:FormatText(StoryNameCfg[1430].name)

				arg_53_1.leftNameTxt_.text = var_56_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_11 = arg_53_1:GetWordFromCfg(425042013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 18
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_9 or var_56_9 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_9 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042013", "story_v_out_425042.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_425042", "425042013", "story_v_out_425042.awb") / 1000

					if var_56_16 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_8
					end

					if var_56_11.prefab_name ~= "" and arg_53_1.actors_[var_56_11.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_11.prefab_name].transform, "story_v_out_425042", "425042013", "story_v_out_425042.awb")

						arg_53_1:RecordAudio("425042013", var_56_17)
						arg_53_1:RecordAudio("425042013", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425042", "425042013", "story_v_out_425042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425042", "425042013", "story_v_out_425042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_18 and arg_53_1.time_ < var_56_8 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play425042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425042014
		arg_57_1.duration_ = 6.67

		local var_57_0 = {
			zh = 4.766,
			ja = 6.666
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
				arg_57_0:Play425042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1012"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1012 == nil then
				arg_57_1.var_.actorSpriteComps1012 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1012 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1012 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1012 = nil
			end

			local var_60_8 = arg_57_1.actors_["1012"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos1012 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1012", 2)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "split_4" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(-390, -465, 300)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1012, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_60_15 = 0
			local var_60_16 = 0.575

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[595].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(425042014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 23
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042014", "story_v_out_425042.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042014", "story_v_out_425042.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_425042", "425042014", "story_v_out_425042.awb")

						arg_57_1:RecordAudio("425042014", var_60_24)
						arg_57_1:RecordAudio("425042014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425042", "425042014", "story_v_out_425042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425042", "425042014", "story_v_out_425042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 425042015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play425042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1012"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1012 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1012", 7)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(0, -2000, 300)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1012, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_64_7 = arg_61_1.actors_["1137"].transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.moveOldPos1137 = var_64_7.localPosition
				var_64_7.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1137", 7)

				local var_64_9 = var_64_7.childCount

				for iter_64_1 = 0, var_64_9 - 1 do
					local var_64_10 = var_64_7:GetChild(iter_64_1)

					if var_64_10.name == "" or not string.find(var_64_10.name, "split") then
						var_64_10.gameObject:SetActive(true)
					else
						var_64_10.gameObject:SetActive(false)
					end
				end
			end

			local var_64_11 = 0.001

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_8) / var_64_11
				local var_64_13 = Vector3.New(0, -2000, 0)

				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1137, var_64_13, var_64_12)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_11 and arg_61_1.time_ < var_64_8 + var_64_11 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_14 = 0.1
			local var_64_15 = 1

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				local var_64_16 = "play"
				local var_64_17 = "effect"

				arg_61_1:AudioAction(var_64_16, var_64_17, "se_story_140", "se_story_140_surround", "")
			end

			local var_64_18 = 0
			local var_64_19 = 0.85

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:GetWordFromCfg(425042015)
				local var_64_21 = arg_61_1:FormatText(var_64_20.content)

				arg_61_1.text_.text = var_64_21

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 34
				local var_64_23 = utf8.len(var_64_21)
				local var_64_24 = var_64_22 <= 0 and var_64_19 or var_64_19 * (var_64_23 / var_64_22)

				if var_64_24 > 0 and var_64_19 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24

					if var_64_24 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_18
					end
				end

				arg_61_1.text_.text = var_64_21
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_19, arg_61_1.talkMaxDuration)

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_18) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_18 + var_64_25 and arg_61_1.time_ < var_64_18 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_61_1:InitPlayNodeList()
	end,
	Play425042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 425042016
		arg_65_1.duration_ = 3.73

		local var_65_0 = {
			zh = 2.3,
			ja = 3.733
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play425042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1012"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1012 == nil then
				arg_65_1.var_.actorSpriteComps1012 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1012 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1012 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1012 = nil
			end

			local var_68_8 = arg_65_1.actors_["1012"].transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPos1012 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1012", 2)

				local var_68_10 = var_68_8.childCount

				for iter_68_4 = 0, var_68_10 - 1 do
					local var_68_11 = var_68_8:GetChild(iter_68_4)

					if var_68_11.name == "" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_9) / var_68_12
				local var_68_14 = Vector3.New(-390, -465, 300)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1012, var_68_14, var_68_13)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_12 and arg_65_1.time_ < var_68_9 + var_68_12 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_68_15 = 0
			local var_68_16 = 0.3

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[595].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(425042016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 12
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042016", "story_v_out_425042.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042016", "story_v_out_425042.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_425042", "425042016", "story_v_out_425042.awb")

						arg_65_1:RecordAudio("425042016", var_68_24)
						arg_65_1:RecordAudio("425042016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_425042", "425042016", "story_v_out_425042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_425042", "425042016", "story_v_out_425042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play425042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 425042017
		arg_69_1.duration_ = 1.3

		local var_69_0 = {
			zh = 1.3,
			ja = 1
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
				arg_69_0:Play425042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1137"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1137 == nil then
				arg_69_1.var_.actorSpriteComps1137 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1137 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1137 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1137 = nil
			end

			local var_72_8 = arg_69_1.actors_["1012"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1012 == nil then
				arg_69_1.var_.actorSpriteComps1012 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps1012 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								local var_72_12 = Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, var_72_11)
								local var_72_13 = Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, var_72_11)
								local var_72_14 = Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, var_72_11)

								iter_72_5.color = Color.New(var_72_12, var_72_13, var_72_14)
							else
								local var_72_15 = Mathf.Lerp(iter_72_5.color.r, 0.5, var_72_11)

								iter_72_5.color = Color.New(var_72_15, var_72_15, var_72_15)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1012 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1012 = nil
			end

			local var_72_16 = arg_69_1.actors_["1137"].transform
			local var_72_17 = 0

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.var_.moveOldPos1137 = var_72_16.localPosition
				var_72_16.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1137", 4)

				local var_72_18 = var_72_16.childCount

				for iter_72_8 = 0, var_72_18 - 1 do
					local var_72_19 = var_72_16:GetChild(iter_72_8)

					if var_72_19.name == "split_5" or not string.find(var_72_19.name, "split") then
						var_72_19.gameObject:SetActive(true)
					else
						var_72_19.gameObject:SetActive(false)
					end
				end
			end

			local var_72_20 = 0.001

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_17) / var_72_20
				local var_72_22 = Vector3.New(390, -425, -200)

				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1137, var_72_22, var_72_21)
			end

			if arg_69_1.time_ >= var_72_17 + var_72_20 and arg_69_1.time_ < var_72_17 + var_72_20 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_72_23 = 0
			local var_72_24 = 0.125

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_25 = arg_69_1:FormatText(StoryNameCfg[15].name)

				arg_69_1.leftNameTxt_.text = var_72_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(425042017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 5
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_24 or var_72_24 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_24 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042017", "story_v_out_425042.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042017", "story_v_out_425042.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_425042", "425042017", "story_v_out_425042.awb")

						arg_69_1:RecordAudio("425042017", var_72_32)
						arg_69_1:RecordAudio("425042017", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_425042", "425042017", "story_v_out_425042.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_425042", "425042017", "story_v_out_425042.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_23) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_23 + var_72_33 and arg_69_1.time_ < var_72_23 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play425042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 425042018
		arg_73_1.duration_ = 7.37

		local var_73_0 = {
			zh = 3.933,
			ja = 7.366
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play425042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1012"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1012 == nil then
				arg_73_1.var_.actorSpriteComps1012 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1012 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1012 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1012 = nil
			end

			local var_76_8 = arg_73_1.actors_["1137"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1137 == nil then
				arg_73_1.var_.actorSpriteComps1137 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps1137 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 0.5, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1137 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1137 = nil
			end

			local var_76_16 = arg_73_1.actors_["1012"].transform
			local var_76_17 = 0

			if var_76_17 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012 = var_76_16.localPosition
				var_76_16.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1012", 2)

				local var_76_18 = var_76_16.childCount

				for iter_76_8 = 0, var_76_18 - 1 do
					local var_76_19 = var_76_16:GetChild(iter_76_8)

					if var_76_19.name == "" or not string.find(var_76_19.name, "split") then
						var_76_19.gameObject:SetActive(true)
					else
						var_76_19.gameObject:SetActive(false)
					end
				end
			end

			local var_76_20 = 0.001

			if var_76_17 <= arg_73_1.time_ and arg_73_1.time_ < var_76_17 + var_76_20 then
				local var_76_21 = (arg_73_1.time_ - var_76_17) / var_76_20
				local var_76_22 = Vector3.New(-390, -465, 300)

				var_76_16.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012, var_76_22, var_76_21)
			end

			if arg_73_1.time_ >= var_76_17 + var_76_20 and arg_73_1.time_ < var_76_17 + var_76_20 + arg_76_0 then
				var_76_16.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_76_23 = 0
			local var_76_24 = 0.575

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[595].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(425042018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 23
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_24 or var_76_24 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_24 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_23
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042018", "story_v_out_425042.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042018", "story_v_out_425042.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_425042", "425042018", "story_v_out_425042.awb")

						arg_73_1:RecordAudio("425042018", var_76_32)
						arg_73_1:RecordAudio("425042018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_425042", "425042018", "story_v_out_425042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_425042", "425042018", "story_v_out_425042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = math.max(var_76_24, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_33 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_33

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_33 and arg_73_1.time_ < var_76_23 + var_76_33 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play425042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 425042019
		arg_77_1.duration_ = 3.43

		local var_77_0 = {
			zh = 2.566,
			ja = 3.433
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
				arg_77_0:Play425042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1137"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1137 == nil then
				arg_77_1.var_.actorSpriteComps1137 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1137 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1137 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1137 = nil
			end

			local var_80_8 = arg_77_1.actors_["1012"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1012 == nil then
				arg_77_1.var_.actorSpriteComps1012 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps1012 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1012 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1012 = nil
			end

			local var_80_16 = arg_77_1.actors_["1137"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos1137 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1137", 4)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "split_4" then
						var_80_19:SetAsLastSibling()
						var_80_19.gameObject:SetActive(true)

						arg_77_1.var_.actorSpriteSplit1137 = var_80_19.gameObject:GetComponent(typeof(Image))

						arg_77_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_80_20 = 0.5

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(390, -425, -200)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1137, var_80_22, var_80_21)

				if arg_77_1.var_.actorSpriteSplit1137 ~= nil then
					arg_77_1.var_.actorSpriteSplit1137:SetAlpha(var_80_21)
				end
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(390, -425, -200)

				if arg_77_1.var_.actorSpriteSplit1137 ~= nil then
					arg_77_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_80_23 = 0
			local var_80_24 = 0.125

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[15].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(425042019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 5
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042019", "story_v_out_425042.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042019", "story_v_out_425042.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_425042", "425042019", "story_v_out_425042.awb")

						arg_77_1:RecordAudio("425042019", var_80_32)
						arg_77_1:RecordAudio("425042019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_425042", "425042019", "story_v_out_425042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_425042", "425042019", "story_v_out_425042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 425042020
		arg_81_1.duration_ = 7.13

		local var_81_0 = {
			zh = 4.5,
			ja = 7.133
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play425042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1012"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1012 == nil then
				arg_81_1.var_.actorSpriteComps1012 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1012 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1012 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1012 = nil
			end

			local var_84_8 = arg_81_1.actors_["1137"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1137 == nil then
				arg_81_1.var_.actorSpriteComps1137 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps1137 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 0.5, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1137 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1137 = nil
			end

			local var_84_16 = arg_81_1.actors_["1012"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos1012 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1012", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_1" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-390, -465, 300)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1012, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_84_23 = 0
			local var_84_24 = 0.6

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[595].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(425042020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 24
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042020", "story_v_out_425042.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042020", "story_v_out_425042.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_425042", "425042020", "story_v_out_425042.awb")

						arg_81_1:RecordAudio("425042020", var_84_32)
						arg_81_1:RecordAudio("425042020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_425042", "425042020", "story_v_out_425042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_425042", "425042020", "story_v_out_425042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_33 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_33

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_33 and arg_81_1.time_ < var_84_23 + var_84_33 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425042021
		arg_85_1.duration_ = 3.23

		local var_85_0 = {
			zh = 2.266,
			ja = 3.233
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
				arg_85_0:Play425042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1137"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1137 == nil then
				arg_85_1.var_.actorSpriteComps1137 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1137 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1137 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1137 = nil
			end

			local var_88_8 = arg_85_1.actors_["1012"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1012 == nil then
				arg_85_1.var_.actorSpriteComps1012 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps1012 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1012 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1012 = nil
			end

			local var_88_16 = arg_85_1.actors_["1137"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos1137 = var_88_16.localPosition
				var_88_16.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1137", 4)

				local var_88_18 = var_88_16.childCount

				for iter_88_8 = 0, var_88_18 - 1 do
					local var_88_19 = var_88_16:GetChild(iter_88_8)

					if var_88_19.name == "split_5" then
						var_88_19:SetAsLastSibling()
						var_88_19.gameObject:SetActive(true)

						arg_85_1.var_.actorSpriteSplit1137 = var_88_19.gameObject:GetComponent(typeof(Image))

						arg_85_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_88_20 = 0.2

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_17) / var_88_20
				local var_88_22 = Vector3.New(390, -425, -200)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1137, var_88_22, var_88_21)

				if arg_85_1.var_.actorSpriteSplit1137 ~= nil then
					arg_85_1.var_.actorSpriteSplit1137:SetAlpha(var_88_21)
				end
			end

			if arg_85_1.time_ >= var_88_17 + var_88_20 and arg_85_1.time_ < var_88_17 + var_88_20 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(390, -425, -200)

				if arg_85_1.var_.actorSpriteSplit1137 ~= nil then
					arg_85_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_88_23 = 0
			local var_88_24 = 0.25

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[15].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(425042021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 10
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042021", "story_v_out_425042.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042021", "story_v_out_425042.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_425042", "425042021", "story_v_out_425042.awb")

						arg_85_1:RecordAudio("425042021", var_88_32)
						arg_85_1:RecordAudio("425042021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425042", "425042021", "story_v_out_425042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425042", "425042021", "story_v_out_425042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play425042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425042022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play425042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1012"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1012 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1012", 7)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(0, -2000, 300)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1012, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_92_7 = arg_89_1.actors_["1137"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.moveOldPos1137 = var_92_7.localPosition
				var_92_7.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1137", 7)

				local var_92_9 = var_92_7.childCount

				for iter_92_1 = 0, var_92_9 - 1 do
					local var_92_10 = var_92_7:GetChild(iter_92_1)

					if var_92_10.name == "" or not string.find(var_92_10.name, "split") then
						var_92_10.gameObject:SetActive(true)
					else
						var_92_10.gameObject:SetActive(false)
					end
				end
			end

			local var_92_11 = 0.001

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_8) / var_92_11
				local var_92_13 = Vector3.New(0, -2000, 0)

				var_92_7.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1137, var_92_13, var_92_12)
			end

			if arg_89_1.time_ >= var_92_8 + var_92_11 and arg_89_1.time_ < var_92_8 + var_92_11 + arg_92_0 then
				var_92_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_14 = 0
			local var_92_15 = 1.175

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_16 = arg_89_1:GetWordFromCfg(425042022)
				local var_92_17 = arg_89_1:FormatText(var_92_16.content)

				arg_89_1.text_.text = var_92_17

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_18 = 47
				local var_92_19 = utf8.len(var_92_17)
				local var_92_20 = var_92_18 <= 0 and var_92_15 or var_92_15 * (var_92_19 / var_92_18)

				if var_92_20 > 0 and var_92_15 < var_92_20 then
					arg_89_1.talkMaxDuration = var_92_20

					if var_92_20 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_14
					end
				end

				arg_89_1.text_.text = var_92_17
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_15, arg_89_1.talkMaxDuration)

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_14) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_14 + var_92_21 and arg_89_1.time_ < var_92_14 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_89_1:InitPlayNodeList()
	end,
	Play425042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425042023
		arg_93_1.duration_ = 12.57

		local var_93_0 = {
			zh = 10.833,
			ja = 12.566
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play425042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1012"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1012 == nil then
				arg_93_1.var_.actorSpriteComps1012 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1012 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1012 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1012 = nil
			end

			local var_96_8 = arg_93_1.actors_["1012"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1012", 3)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "split_5" or not string.find(var_96_11.name, "split") then
						var_96_11.gameObject:SetActive(true)
					else
						var_96_11.gameObject:SetActive(false)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(0, -465, 300)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -465, 300)
			end

			local var_96_15 = 0
			local var_96_16 = 1

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[595].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(425042023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 40
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042023", "story_v_out_425042.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042023", "story_v_out_425042.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_425042", "425042023", "story_v_out_425042.awb")

						arg_93_1:RecordAudio("425042023", var_96_24)
						arg_93_1:RecordAudio("425042023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425042", "425042023", "story_v_out_425042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425042", "425042023", "story_v_out_425042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play425042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425042024
		arg_97_1.duration_ = 12.8

		local var_97_0 = {
			zh = 9,
			ja = 12.8
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play425042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.925

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[595].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(425042024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 37
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042024", "story_v_out_425042.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042024", "story_v_out_425042.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_425042", "425042024", "story_v_out_425042.awb")

						arg_97_1:RecordAudio("425042024", var_100_9)
						arg_97_1:RecordAudio("425042024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425042", "425042024", "story_v_out_425042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425042", "425042024", "story_v_out_425042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play425042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425042025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play425042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1012"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1012 == nil then
				arg_101_1.var_.actorSpriteComps1012 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps1012 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 0.5, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1012 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1012 = nil
			end

			local var_104_8 = arg_101_1.actors_["1012"].transform
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.var_.moveOldPos1012 = var_104_8.localPosition
				var_104_8.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1012", 7)

				local var_104_10 = var_104_8.childCount

				for iter_104_4 = 0, var_104_10 - 1 do
					local var_104_11 = var_104_8:GetChild(iter_104_4)

					if var_104_11.name == "" or not string.find(var_104_11.name, "split") then
						var_104_11.gameObject:SetActive(true)
					else
						var_104_11.gameObject:SetActive(false)
					end
				end
			end

			local var_104_12 = 0.001

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_9) / var_104_12
				local var_104_14 = Vector3.New(0, -2000, 300)

				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1012, var_104_14, var_104_13)
			end

			if arg_101_1.time_ >= var_104_9 + var_104_12 and arg_101_1.time_ < var_104_9 + var_104_12 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_104_15 = 0.1
			local var_104_16 = 1

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				local var_104_17 = "play"
				local var_104_18 = "effect"

				arg_101_1:AudioAction(var_104_17, var_104_18, "se_story_147", "se_story_147_clap", "")
			end

			local var_104_19 = 0
			local var_104_20 = 1.05

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_21 = arg_101_1:GetWordFromCfg(425042025)
				local var_104_22 = arg_101_1:FormatText(var_104_21.content)

				arg_101_1.text_.text = var_104_22

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_23 = 42
				local var_104_24 = utf8.len(var_104_22)
				local var_104_25 = var_104_23 <= 0 and var_104_20 or var_104_20 * (var_104_24 / var_104_23)

				if var_104_25 > 0 and var_104_20 < var_104_25 then
					arg_101_1.talkMaxDuration = var_104_25

					if var_104_25 + var_104_19 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_25 + var_104_19
					end
				end

				arg_101_1.text_.text = var_104_22
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_26 = math.max(var_104_20, arg_101_1.talkMaxDuration)

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_26 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_19) / var_104_26

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_19 + var_104_26 and arg_101_1.time_ < var_104_19 + var_104_26 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play425042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425042026
		arg_105_1.duration_ = 13.27

		local var_105_0 = {
			zh = 9.066,
			ja = 13.266
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
				arg_105_0:Play425042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1012"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1012 == nil then
				arg_105_1.var_.actorSpriteComps1012 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1012 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1012 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1012 = nil
			end

			local var_108_8 = arg_105_1.actors_["1012"].transform
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.var_.moveOldPos1012 = var_108_8.localPosition
				var_108_8.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1012", 3)

				local var_108_10 = var_108_8.childCount

				for iter_108_4 = 0, var_108_10 - 1 do
					local var_108_11 = var_108_8:GetChild(iter_108_4)

					if var_108_11.name == "split_3" or not string.find(var_108_11.name, "split") then
						var_108_11.gameObject:SetActive(true)
					else
						var_108_11.gameObject:SetActive(false)
					end
				end
			end

			local var_108_12 = 0.001

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_9) / var_108_12
				local var_108_14 = Vector3.New(0, -465, 300)

				var_108_8.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1012, var_108_14, var_108_13)
			end

			if arg_105_1.time_ >= var_108_9 + var_108_12 and arg_105_1.time_ < var_108_9 + var_108_12 + arg_108_0 then
				var_108_8.localPosition = Vector3.New(0, -465, 300)
			end

			local var_108_15 = 0
			local var_108_16 = 1.05

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[595].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(425042026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 42
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042026", "story_v_out_425042.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042026", "story_v_out_425042.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_425042", "425042026", "story_v_out_425042.awb")

						arg_105_1:RecordAudio("425042026", var_108_24)
						arg_105_1:RecordAudio("425042026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425042", "425042026", "story_v_out_425042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425042", "425042026", "story_v_out_425042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play425042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 425042027
		arg_109_1.duration_ = 19.97

		local var_109_0 = {
			zh = 13.433667,
			ja = 19.966667
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
				arg_109_0:Play425042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1012"].transform
			local var_112_1 = 0.966666666666667

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1012 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1012", 7)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -2000, 300)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1012, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_112_7 = "1033"

			if arg_109_1.actors_[var_112_7] == nil then
				local var_112_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_112_8) then
					local var_112_9 = Object.Instantiate(var_112_8, arg_109_1.canvasGo_.transform)

					var_112_9.transform:SetSiblingIndex(1)

					var_112_9.name = var_112_7
					var_112_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_109_1.actors_[var_112_7] = var_112_9

					local var_112_10 = var_112_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_109_1.isInRecall_ then
						for iter_112_1, iter_112_2 in ipairs(var_112_10) do
							iter_112_2.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_112_11 = arg_109_1.actors_["1033"]
			local var_112_12 = 4.200667

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 and not isNil(var_112_11) and arg_109_1.var_.actorSpriteComps1033 == nil then
				arg_109_1.var_.actorSpriteComps1033 = var_112_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_13 = 0.2

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_13 and not isNil(var_112_11) then
				local var_112_14 = (arg_109_1.time_ - var_112_12) / var_112_13

				if arg_109_1.var_.actorSpriteComps1033 then
					for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_112_4 then
							if arg_109_1.isInRecall_ then
								local var_112_15 = Mathf.Lerp(iter_112_4.color.r, arg_109_1.hightColor1.r, var_112_14)
								local var_112_16 = Mathf.Lerp(iter_112_4.color.g, arg_109_1.hightColor1.g, var_112_14)
								local var_112_17 = Mathf.Lerp(iter_112_4.color.b, arg_109_1.hightColor1.b, var_112_14)

								iter_112_4.color = Color.New(var_112_15, var_112_16, var_112_17)
							else
								local var_112_18 = Mathf.Lerp(iter_112_4.color.r, 1, var_112_14)

								iter_112_4.color = Color.New(var_112_18, var_112_18, var_112_18)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_12 + var_112_13 and arg_109_1.time_ < var_112_12 + var_112_13 + arg_112_0 and not isNil(var_112_11) and arg_109_1.var_.actorSpriteComps1033 then
				for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_112_6 then
						if arg_109_1.isInRecall_ then
							iter_112_6.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1033 = nil
			end

			local var_112_19 = 1.00066666666667

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_20 = 0.999333333333332

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_19) / var_112_20
				local var_112_22 = Color.New(0, 0, 0)

				var_112_22.a = Mathf.Lerp(1, 0, var_112_21)
				arg_109_1.mask_.color = var_112_22
			end

			if arg_109_1.time_ >= var_112_19 + var_112_20 and arg_109_1.time_ < var_112_19 + var_112_20 + arg_112_0 then
				local var_112_23 = Color.New(0, 0, 0)
				local var_112_24 = 0

				arg_109_1.mask_.enabled = false
				var_112_23.a = var_112_24
				arg_109_1.mask_.color = var_112_23
			end

			local var_112_25 = arg_109_1.actors_["1033"].transform
			local var_112_26 = 4.200667

			if var_112_26 < arg_109_1.time_ and arg_109_1.time_ <= var_112_26 + arg_112_0 then
				arg_109_1.var_.moveOldPos1033 = var_112_25.localPosition
				var_112_25.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1033", 3)

				local var_112_27 = var_112_25.childCount

				for iter_112_7 = 0, var_112_27 - 1 do
					local var_112_28 = var_112_25:GetChild(iter_112_7)

					if var_112_28.name == "split_6" or not string.find(var_112_28.name, "split") then
						var_112_28.gameObject:SetActive(true)
					else
						var_112_28.gameObject:SetActive(false)
					end
				end
			end

			local var_112_29 = 0.001

			if var_112_26 <= arg_109_1.time_ and arg_109_1.time_ < var_112_26 + var_112_29 then
				local var_112_30 = (arg_109_1.time_ - var_112_26) / var_112_29
				local var_112_31 = Vector3.New(0, -420, 0)

				var_112_25.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1033, var_112_31, var_112_30)
			end

			if arg_109_1.time_ >= var_112_26 + var_112_29 and arg_109_1.time_ < var_112_26 + var_112_29 + arg_112_0 then
				var_112_25.localPosition = Vector3.New(0, -420, 0)
			end

			local var_112_32 = 0

			if var_112_32 < arg_109_1.time_ and arg_109_1.time_ <= var_112_32 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_33 = 1

			if var_112_32 <= arg_109_1.time_ and arg_109_1.time_ < var_112_32 + var_112_33 then
				local var_112_34 = (arg_109_1.time_ - var_112_32) / var_112_33
				local var_112_35 = Color.New(0, 0, 0)

				var_112_35.a = Mathf.Lerp(0, 1, var_112_34)
				arg_109_1.mask_.color = var_112_35
			end

			if arg_109_1.time_ >= var_112_32 + var_112_33 and arg_109_1.time_ < var_112_32 + var_112_33 + arg_112_0 then
				local var_112_36 = Color.New(0, 0, 0)

				var_112_36.a = 1
				arg_109_1.mask_.color = var_112_36
			end

			local var_112_37 = 1.00066666666667
			local var_112_38 = 1.999999999999
			local var_112_39 = "ST10"

			if var_112_37 < arg_109_1.time_ and arg_109_1.time_ <= var_112_37 + arg_112_0 then
				arg_109_1.timestampController_:SetSelectedState("show")
				arg_109_1.timestampAni_:Play("in")

				arg_109_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_39)

				arg_109_1.timestampColorController_:SetSelectedState("cold")
				arg_109_1.timeColdImg_:SetAlpha(0.031)

				local var_112_40 = arg_109_1:GetWordFromCfg(501100)
				local var_112_41 = arg_109_1:FormatText(var_112_40.content)

				arg_109_1.text_timeText_.text = var_112_41

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_timeText_)

				local var_112_42 = arg_109_1:GetWordFromCfg(501101)
				local var_112_43 = arg_109_1:FormatText(var_112_42.content)

				arg_109_1.text_siteText_.text = var_112_43

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_siteText_)
			end

			if arg_109_1.time_ >= var_112_37 + var_112_38 and arg_109_1.time_ < var_112_37 + var_112_38 + arg_112_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_109_1.timestampAni_, "out", function()
					arg_109_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_112_44 = 3.000667

			if var_112_44 < arg_109_1.time_ and arg_109_1.time_ <= var_112_44 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_45 = 1.2

			if var_112_44 <= arg_109_1.time_ and arg_109_1.time_ < var_112_44 + var_112_45 then
				local var_112_46 = (arg_109_1.time_ - var_112_44) / var_112_45
				local var_112_47 = Color.New(0, 0, 0)

				var_112_47.a = Mathf.Lerp(0, 1, var_112_46)
				arg_109_1.mask_.color = var_112_47
			end

			if arg_109_1.time_ >= var_112_44 + var_112_45 and arg_109_1.time_ < var_112_44 + var_112_45 + arg_112_0 then
				local var_112_48 = Color.New(0, 0, 0)

				var_112_48.a = 1
				arg_109_1.mask_.color = var_112_48
			end

			local var_112_49 = 4.200667

			if var_112_49 < arg_109_1.time_ and arg_109_1.time_ <= var_112_49 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_50 = 1.2

			if var_112_49 <= arg_109_1.time_ and arg_109_1.time_ < var_112_49 + var_112_50 then
				local var_112_51 = (arg_109_1.time_ - var_112_49) / var_112_50
				local var_112_52 = Color.New(0, 0, 0)

				var_112_52.a = Mathf.Lerp(1, 0, var_112_51)
				arg_109_1.mask_.color = var_112_52
			end

			if arg_109_1.time_ >= var_112_49 + var_112_50 and arg_109_1.time_ < var_112_49 + var_112_50 + arg_112_0 then
				local var_112_53 = Color.New(0, 0, 0)
				local var_112_54 = 0

				arg_109_1.mask_.enabled = false
				var_112_53.a = var_112_54
				arg_109_1.mask_.color = var_112_53
			end

			local var_112_55 = "ST10"

			if arg_109_1.bgs_[var_112_55] == nil then
				local var_112_56 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_56:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_55)
				var_112_56.name = var_112_55
				var_112_56.transform.parent = arg_109_1.stage_.transform
				var_112_56.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_55] = var_112_56
			end

			local var_112_57 = 1.00066666666667

			if var_112_57 < arg_109_1.time_ and arg_109_1.time_ <= var_112_57 + arg_112_0 then
				local var_112_58 = manager.ui.mainCamera.transform.localPosition
				local var_112_59 = Vector3.New(0, 0, 10) + Vector3.New(var_112_58.x, var_112_58.y, 0)
				local var_112_60 = arg_109_1.bgs_.ST10

				var_112_60.transform.localPosition = var_112_59
				var_112_60.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_61 = var_112_60:GetComponent("SpriteRenderer")

				if var_112_61 and var_112_61.sprite then
					local var_112_62 = (var_112_60.transform.localPosition - var_112_58).z
					local var_112_63 = manager.ui.mainCameraCom_
					local var_112_64 = 2 * var_112_62 * Mathf.Tan(var_112_63.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_65 = var_112_64 * var_112_63.aspect
					local var_112_66 = var_112_61.sprite.bounds.size.x
					local var_112_67 = var_112_61.sprite.bounds.size.y
					local var_112_68 = var_112_65 / var_112_66
					local var_112_69 = var_112_64 / var_112_67
					local var_112_70 = var_112_69 < var_112_68 and var_112_68 or var_112_69

					var_112_60.transform.localScale = Vector3.New(var_112_70, var_112_70, 0)
				end

				for iter_112_8, iter_112_9 in pairs(arg_109_1.bgs_) do
					if iter_112_8 ~= "ST10" then
						iter_112_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_71 = 0.366666666666667
			local var_112_72 = 1

			if var_112_71 < arg_109_1.time_ and arg_109_1.time_ <= var_112_71 + arg_112_0 then
				local var_112_73 = "stop"
				local var_112_74 = "effect"

				arg_109_1:AudioAction(var_112_73, var_112_74, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_112_75 = 3.9
			local var_112_76 = 1

			if var_112_75 < arg_109_1.time_ and arg_109_1.time_ <= var_112_75 + arg_112_0 then
				local var_112_77 = "play"
				local var_112_78 = "effect"

				arg_109_1:AudioAction(var_112_77, var_112_78, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_79 = 5.400667
			local var_112_80 = 1.075

			if var_112_79 < arg_109_1.time_ and arg_109_1.time_ <= var_112_79 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_81 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_81:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_109_1.dialogCg_.alpha = arg_114_0
				end))
				var_112_81:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_81:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_82 = arg_109_1:FormatText(StoryNameCfg[236].name)

				arg_109_1.leftNameTxt_.text = var_112_82

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_83 = arg_109_1:GetWordFromCfg(425042027)
				local var_112_84 = arg_109_1:FormatText(var_112_83.content)

				arg_109_1.text_.text = var_112_84

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_85 = 43
				local var_112_86 = utf8.len(var_112_84)
				local var_112_87 = var_112_85 <= 0 and var_112_80 or var_112_80 * (var_112_86 / var_112_85)

				if var_112_87 > 0 and var_112_80 < var_112_87 then
					arg_109_1.talkMaxDuration = var_112_87
					var_112_79 = var_112_79 + 0.3

					if var_112_87 + var_112_79 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_87 + var_112_79
					end
				end

				arg_109_1.text_.text = var_112_84
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042027", "story_v_out_425042.awb") ~= 0 then
					local var_112_88 = manager.audio:GetVoiceLength("story_v_out_425042", "425042027", "story_v_out_425042.awb") / 1000

					if var_112_88 + var_112_79 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_88 + var_112_79
					end

					if var_112_83.prefab_name ~= "" and arg_109_1.actors_[var_112_83.prefab_name] ~= nil then
						local var_112_89 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_83.prefab_name].transform, "story_v_out_425042", "425042027", "story_v_out_425042.awb")

						arg_109_1:RecordAudio("425042027", var_112_89)
						arg_109_1:RecordAudio("425042027", var_112_89)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_425042", "425042027", "story_v_out_425042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_425042", "425042027", "story_v_out_425042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_90 = var_112_79 + 0.3
			local var_112_91 = math.max(var_112_80, arg_109_1.talkMaxDuration)

			if var_112_90 <= arg_109_1.time_ and arg_109_1.time_ < var_112_90 + var_112_91 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_90) / var_112_91

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_90 + var_112_91 and arg_109_1.time_ < var_112_90 + var_112_91 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.200667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play425042028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425042028
		arg_116_1.duration_ = 12.2

		local var_116_0 = {
			zh = 9.333,
			ja = 12.2
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
				arg_116_0:Play425042029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.15

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[236].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(425042028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 46
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042028", "story_v_out_425042.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042028", "story_v_out_425042.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_425042", "425042028", "story_v_out_425042.awb")

						arg_116_1:RecordAudio("425042028", var_119_9)
						arg_116_1:RecordAudio("425042028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425042", "425042028", "story_v_out_425042.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425042", "425042028", "story_v_out_425042.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425042029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425042029
		arg_120_1.duration_ = 12.43

		local var_120_0 = {
			zh = 8.8,
			ja = 12.433
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
				arg_120_0:Play425042030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[236].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(425042029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 44
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042029", "story_v_out_425042.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042029", "story_v_out_425042.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_425042", "425042029", "story_v_out_425042.awb")

						arg_120_1:RecordAudio("425042029", var_123_9)
						arg_120_1:RecordAudio("425042029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_425042", "425042029", "story_v_out_425042.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_425042", "425042029", "story_v_out_425042.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play425042030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425042030
		arg_124_1.duration_ = 13

		local var_124_0 = {
			zh = 9.8,
			ja = 13
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
				arg_124_0:Play425042031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.2

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[236].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(425042030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 48
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042030", "story_v_out_425042.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042030", "story_v_out_425042.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_425042", "425042030", "story_v_out_425042.awb")

						arg_124_1:RecordAudio("425042030", var_127_9)
						arg_124_1:RecordAudio("425042030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_425042", "425042030", "story_v_out_425042.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_425042", "425042030", "story_v_out_425042.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play425042031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425042031
		arg_128_1.duration_ = 5.4

		local var_128_0 = {
			zh = 3.2,
			ja = 5.4
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
				arg_128_0:Play425042032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.475

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[236].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(425042031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 19
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042031", "story_v_out_425042.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042031", "story_v_out_425042.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_425042", "425042031", "story_v_out_425042.awb")

						arg_128_1:RecordAudio("425042031", var_131_9)
						arg_128_1:RecordAudio("425042031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425042", "425042031", "story_v_out_425042.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425042", "425042031", "story_v_out_425042.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play425042032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425042032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play425042033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1033"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1033 = var_135_0.localPosition
				var_135_0.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1033", 7)

				local var_135_2 = var_135_0.childCount

				for iter_135_0 = 0, var_135_2 - 1 do
					local var_135_3 = var_135_0:GetChild(iter_135_0)

					if var_135_3.name == "" or not string.find(var_135_3.name, "split") then
						var_135_3.gameObject:SetActive(true)
					else
						var_135_3.gameObject:SetActive(false)
					end
				end
			end

			local var_135_4 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_4 then
				local var_135_5 = (arg_132_1.time_ - var_135_1) / var_135_4
				local var_135_6 = Vector3.New(0, -2000, 0)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1033, var_135_6, var_135_5)
			end

			if arg_132_1.time_ >= var_135_1 + var_135_4 and arg_132_1.time_ < var_135_1 + var_135_4 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_7 = 0
			local var_135_8 = 1.725

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_9 = arg_132_1:GetWordFromCfg(425042032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 69
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_8 or var_135_8 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_8 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_7 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_7
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_8, arg_132_1.talkMaxDuration)

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_7) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_7 + var_135_14 and arg_132_1.time_ < var_135_7 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425042033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425042033
		arg_136_1.duration_ = 5.07

		local var_136_0 = {
			zh = 4.033,
			ja = 5.066
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
				arg_136_0:Play425042034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.45

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[1432].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Eden")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(425042033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 18
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042033", "story_v_out_425042.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042033", "story_v_out_425042.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_425042", "425042033", "story_v_out_425042.awb")

						arg_136_1:RecordAudio("425042033", var_139_9)
						arg_136_1:RecordAudio("425042033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425042", "425042033", "story_v_out_425042.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425042", "425042033", "story_v_out_425042.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play425042034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425042034
		arg_140_1.duration_ = 1.07

		local var_140_0 = {
			zh = 1.066,
			ja = 0.999999999999
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
				arg_140_0:Play425042035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = "1066"

			if arg_140_1.actors_[var_143_0] == nil then
				local var_143_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_143_1) then
					local var_143_2 = Object.Instantiate(var_143_1, arg_140_1.canvasGo_.transform)

					var_143_2.transform:SetSiblingIndex(1)

					var_143_2.name = var_143_0
					var_143_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_140_1.actors_[var_143_0] = var_143_2

					local var_143_3 = var_143_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_140_1.isInRecall_ then
						for iter_143_0, iter_143_1 in ipairs(var_143_3) do
							iter_143_1.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_143_4 = arg_140_1.actors_["1066"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.actorSpriteComps1066 == nil then
				arg_140_1.var_.actorSpriteComps1066 = var_143_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_6 = 0.2

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.actorSpriteComps1066 then
					for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_143_3 then
							if arg_140_1.isInRecall_ then
								local var_143_8 = Mathf.Lerp(iter_143_3.color.r, arg_140_1.hightColor1.r, var_143_7)
								local var_143_9 = Mathf.Lerp(iter_143_3.color.g, arg_140_1.hightColor1.g, var_143_7)
								local var_143_10 = Mathf.Lerp(iter_143_3.color.b, arg_140_1.hightColor1.b, var_143_7)

								iter_143_3.color = Color.New(var_143_8, var_143_9, var_143_10)
							else
								local var_143_11 = Mathf.Lerp(iter_143_3.color.r, 1, var_143_7)

								iter_143_3.color = Color.New(var_143_11, var_143_11, var_143_11)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.actorSpriteComps1066 then
				for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_143_5 then
						if arg_140_1.isInRecall_ then
							iter_143_5.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1066 = nil
			end

			local var_143_12 = arg_140_1.actors_["1066"].transform
			local var_143_13 = 0

			if var_143_13 < arg_140_1.time_ and arg_140_1.time_ <= var_143_13 + arg_143_0 then
				arg_140_1.var_.moveOldPos1066 = var_143_12.localPosition
				var_143_12.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1066", 3)

				local var_143_14 = var_143_12.childCount

				for iter_143_6 = 0, var_143_14 - 1 do
					local var_143_15 = var_143_12:GetChild(iter_143_6)

					if var_143_15.name == "split_4" or not string.find(var_143_15.name, "split") then
						var_143_15.gameObject:SetActive(true)
					else
						var_143_15.gameObject:SetActive(false)
					end
				end
			end

			local var_143_16 = 0.001

			if var_143_13 <= arg_140_1.time_ and arg_140_1.time_ < var_143_13 + var_143_16 then
				local var_143_17 = (arg_140_1.time_ - var_143_13) / var_143_16
				local var_143_18 = Vector3.New(-77.5, -399.1, -303.3)

				var_143_12.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1066, var_143_18, var_143_17)
			end

			if arg_140_1.time_ >= var_143_13 + var_143_16 and arg_140_1.time_ < var_143_13 + var_143_16 + arg_143_0 then
				var_143_12.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_143_19 = 0
			local var_143_20 = 0.075

			if var_143_19 < arg_140_1.time_ and arg_140_1.time_ <= var_143_19 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_21 = arg_140_1:FormatText(StoryNameCfg[32].name)

				arg_140_1.leftNameTxt_.text = var_143_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_22 = arg_140_1:GetWordFromCfg(425042034)
				local var_143_23 = arg_140_1:FormatText(var_143_22.content)

				arg_140_1.text_.text = var_143_23

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_24 = 3
				local var_143_25 = utf8.len(var_143_23)
				local var_143_26 = var_143_24 <= 0 and var_143_20 or var_143_20 * (var_143_25 / var_143_24)

				if var_143_26 > 0 and var_143_20 < var_143_26 then
					arg_140_1.talkMaxDuration = var_143_26

					if var_143_26 + var_143_19 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_26 + var_143_19
					end
				end

				arg_140_1.text_.text = var_143_23
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042034", "story_v_out_425042.awb") ~= 0 then
					local var_143_27 = manager.audio:GetVoiceLength("story_v_out_425042", "425042034", "story_v_out_425042.awb") / 1000

					if var_143_27 + var_143_19 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_27 + var_143_19
					end

					if var_143_22.prefab_name ~= "" and arg_140_1.actors_[var_143_22.prefab_name] ~= nil then
						local var_143_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_22.prefab_name].transform, "story_v_out_425042", "425042034", "story_v_out_425042.awb")

						arg_140_1:RecordAudio("425042034", var_143_28)
						arg_140_1:RecordAudio("425042034", var_143_28)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425042", "425042034", "story_v_out_425042.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425042", "425042034", "story_v_out_425042.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_29 = math.max(var_143_20, arg_140_1.talkMaxDuration)

			if var_143_19 <= arg_140_1.time_ and arg_140_1.time_ < var_143_19 + var_143_29 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_19) / var_143_29

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_19 + var_143_29 and arg_140_1.time_ < var_143_19 + var_143_29 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play425042035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425042035
		arg_144_1.duration_ = 3.43

		local var_144_0 = {
			zh = 2.6,
			ja = 3.433
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
				arg_144_0:Play425042036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1066"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1066 == nil then
				arg_144_1.var_.actorSpriteComps1066 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps1066 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 0.5, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1066 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1066 = nil
			end

			local var_147_8 = 0
			local var_147_9 = 0.3

			if var_147_8 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_10 = arg_144_1:FormatText(StoryNameCfg[1432].name)

				arg_144_1.leftNameTxt_.text = var_147_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Eden")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_11 = arg_144_1:GetWordFromCfg(425042035)
				local var_147_12 = arg_144_1:FormatText(var_147_11.content)

				arg_144_1.text_.text = var_147_12

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 12
				local var_147_14 = utf8.len(var_147_12)
				local var_147_15 = var_147_13 <= 0 and var_147_9 or var_147_9 * (var_147_14 / var_147_13)

				if var_147_15 > 0 and var_147_9 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15

					if var_147_15 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_12
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042035", "story_v_out_425042.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_425042", "425042035", "story_v_out_425042.awb") / 1000

					if var_147_16 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_8
					end

					if var_147_11.prefab_name ~= "" and arg_144_1.actors_[var_147_11.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_11.prefab_name].transform, "story_v_out_425042", "425042035", "story_v_out_425042.awb")

						arg_144_1:RecordAudio("425042035", var_147_17)
						arg_144_1:RecordAudio("425042035", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_425042", "425042035", "story_v_out_425042.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_425042", "425042035", "story_v_out_425042.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_18 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_18 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_18

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_18 and arg_144_1.time_ < var_147_8 + var_147_18 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play425042036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425042036
		arg_148_1.duration_ = 8.93

		local var_148_0 = {
			zh = 8.933,
			ja = 8.3
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
				arg_148_0:Play425042037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1066"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1066 == nil then
				arg_148_1.var_.actorSpriteComps1066 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1066 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1066 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1066 = nil
			end

			local var_151_8 = arg_148_1.actors_["1066"].transform
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.var_.moveOldPos1066 = var_151_8.localPosition
				var_151_8.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1066", 3)

				local var_151_10 = var_151_8.childCount

				for iter_151_4 = 0, var_151_10 - 1 do
					local var_151_11 = var_151_8:GetChild(iter_151_4)

					if var_151_11.name == "split_4" or not string.find(var_151_11.name, "split") then
						var_151_11.gameObject:SetActive(true)
					else
						var_151_11.gameObject:SetActive(false)
					end
				end
			end

			local var_151_12 = 0.001

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_9) / var_151_12
				local var_151_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_151_8.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1066, var_151_14, var_151_13)
			end

			if arg_148_1.time_ >= var_151_9 + var_151_12 and arg_148_1.time_ < var_151_9 + var_151_12 + arg_151_0 then
				var_151_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_151_15 = 0
			local var_151_16 = 0.925

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[32].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(425042036)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 37
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042036", "story_v_out_425042.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042036", "story_v_out_425042.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_425042", "425042036", "story_v_out_425042.awb")

						arg_148_1:RecordAudio("425042036", var_151_24)
						arg_148_1:RecordAudio("425042036", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425042", "425042036", "story_v_out_425042.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425042", "425042036", "story_v_out_425042.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425042037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 425042037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play425042038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1066"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1066 = var_155_0.localPosition
				var_155_0.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1066", 7)

				local var_155_2 = var_155_0.childCount

				for iter_155_0 = 0, var_155_2 - 1 do
					local var_155_3 = var_155_0:GetChild(iter_155_0)

					if var_155_3.name == "" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_4 then
				local var_155_5 = (arg_152_1.time_ - var_155_1) / var_155_4
				local var_155_6 = Vector3.New(0, -2000, 0)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1066, var_155_6, var_155_5)
			end

			if arg_152_1.time_ >= var_155_1 + var_155_4 and arg_152_1.time_ < var_155_1 + var_155_4 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_155_7 = 0
			local var_155_8 = 0.75

			if var_155_7 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_9 = arg_152_1:GetWordFromCfg(425042037)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 30
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_8 or var_155_8 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_8 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_7 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_7
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_8, arg_152_1.talkMaxDuration)

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_7) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_7 + var_155_14 and arg_152_1.time_ < var_155_7 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425042038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 425042038
		arg_156_1.duration_ = 9.47

		local var_156_0 = {
			zh = 9.066,
			ja = 9.466
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
				arg_156_0:Play425042039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "10156"

			if arg_156_1.actors_[var_159_0] == nil then
				local var_159_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10156")

				if not isNil(var_159_1) then
					local var_159_2 = Object.Instantiate(var_159_1, arg_156_1.canvasGo_.transform)

					var_159_2.transform:SetSiblingIndex(1)

					var_159_2.name = var_159_0
					var_159_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_156_1.actors_[var_159_0] = var_159_2

					local var_159_3 = var_159_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_156_1.isInRecall_ then
						for iter_159_0, iter_159_1 in ipairs(var_159_3) do
							iter_159_1.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_159_4 = arg_156_1.actors_["10156"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.actorSpriteComps10156 == nil then
				arg_156_1.var_.actorSpriteComps10156 = var_159_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_6 = 0.2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.actorSpriteComps10156 then
					for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_159_3 then
							if arg_156_1.isInRecall_ then
								local var_159_8 = Mathf.Lerp(iter_159_3.color.r, arg_156_1.hightColor1.r, var_159_7)
								local var_159_9 = Mathf.Lerp(iter_159_3.color.g, arg_156_1.hightColor1.g, var_159_7)
								local var_159_10 = Mathf.Lerp(iter_159_3.color.b, arg_156_1.hightColor1.b, var_159_7)

								iter_159_3.color = Color.New(var_159_8, var_159_9, var_159_10)
							else
								local var_159_11 = Mathf.Lerp(iter_159_3.color.r, 1, var_159_7)

								iter_159_3.color = Color.New(var_159_11, var_159_11, var_159_11)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.actorSpriteComps10156 then
				for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_159_5 then
						if arg_156_1.isInRecall_ then
							iter_159_5.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps10156 = nil
			end

			local var_159_12 = arg_156_1.actors_["10156"].transform
			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1.var_.moveOldPos10156 = var_159_12.localPosition
				var_159_12.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10156", 3)

				local var_159_14 = var_159_12.childCount

				for iter_159_6 = 0, var_159_14 - 1 do
					local var_159_15 = var_159_12:GetChild(iter_159_6)

					if var_159_15.name == "" or not string.find(var_159_15.name, "split") then
						var_159_15.gameObject:SetActive(true)
					else
						var_159_15.gameObject:SetActive(false)
					end
				end
			end

			local var_159_16 = 0.001

			if var_159_13 <= arg_156_1.time_ and arg_156_1.time_ < var_159_13 + var_159_16 then
				local var_159_17 = (arg_156_1.time_ - var_159_13) / var_159_16
				local var_159_18 = Vector3.New(0, -390, -210)

				var_159_12.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10156, var_159_18, var_159_17)
			end

			if arg_156_1.time_ >= var_159_13 + var_159_16 and arg_156_1.time_ < var_159_13 + var_159_16 + arg_159_0 then
				var_159_12.localPosition = Vector3.New(0, -390, -210)
			end

			local var_159_19 = 0
			local var_159_20 = 1.025

			if var_159_19 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_21 = arg_156_1:FormatText(StoryNameCfg[1433].name)

				arg_156_1.leftNameTxt_.text = var_159_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_22 = arg_156_1:GetWordFromCfg(425042038)
				local var_159_23 = arg_156_1:FormatText(var_159_22.content)

				arg_156_1.text_.text = var_159_23

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_24 = 41
				local var_159_25 = utf8.len(var_159_23)
				local var_159_26 = var_159_24 <= 0 and var_159_20 or var_159_20 * (var_159_25 / var_159_24)

				if var_159_26 > 0 and var_159_20 < var_159_26 then
					arg_156_1.talkMaxDuration = var_159_26

					if var_159_26 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_26 + var_159_19
					end
				end

				arg_156_1.text_.text = var_159_23
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042038", "story_v_out_425042.awb") ~= 0 then
					local var_159_27 = manager.audio:GetVoiceLength("story_v_out_425042", "425042038", "story_v_out_425042.awb") / 1000

					if var_159_27 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_27 + var_159_19
					end

					if var_159_22.prefab_name ~= "" and arg_156_1.actors_[var_159_22.prefab_name] ~= nil then
						local var_159_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_22.prefab_name].transform, "story_v_out_425042", "425042038", "story_v_out_425042.awb")

						arg_156_1:RecordAudio("425042038", var_159_28)
						arg_156_1:RecordAudio("425042038", var_159_28)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_425042", "425042038", "story_v_out_425042.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_425042", "425042038", "story_v_out_425042.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_29 = math.max(var_159_20, arg_156_1.talkMaxDuration)

			if var_159_19 <= arg_156_1.time_ and arg_156_1.time_ < var_159_19 + var_159_29 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_19) / var_159_29

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_19 + var_159_29 and arg_156_1.time_ < var_159_19 + var_159_29 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play425042039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 425042039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play425042040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10156"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps10156 == nil then
				arg_160_1.var_.actorSpriteComps10156 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps10156 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								local var_163_4 = Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor2.r, var_163_3)
								local var_163_5 = Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor2.g, var_163_3)
								local var_163_6 = Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor2.b, var_163_3)

								iter_163_1.color = Color.New(var_163_4, var_163_5, var_163_6)
							else
								local var_163_7 = Mathf.Lerp(iter_163_1.color.r, 0.5, var_163_3)

								iter_163_1.color = Color.New(var_163_7, var_163_7, var_163_7)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps10156 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10156 = nil
			end

			local var_163_8 = arg_160_1.actors_["10156"].transform
			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.var_.moveOldPos10156 = var_163_8.localPosition
				var_163_8.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10156", 7)

				local var_163_10 = var_163_8.childCount

				for iter_163_4 = 0, var_163_10 - 1 do
					local var_163_11 = var_163_8:GetChild(iter_163_4)

					if var_163_11.name == "" or not string.find(var_163_11.name, "split") then
						var_163_11.gameObject:SetActive(true)
					else
						var_163_11.gameObject:SetActive(false)
					end
				end
			end

			local var_163_12 = 0.001

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_9) / var_163_12
				local var_163_14 = Vector3.New(0, -2000, 0)

				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10156, var_163_14, var_163_13)
			end

			if arg_160_1.time_ >= var_163_9 + var_163_12 and arg_160_1.time_ < var_163_9 + var_163_12 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_15 = 0
			local var_163_16 = 1.225

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_17 = arg_160_1:GetWordFromCfg(425042039)
				local var_163_18 = arg_160_1:FormatText(var_163_17.content)

				arg_160_1.text_.text = var_163_18

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_19 = 49
				local var_163_20 = utf8.len(var_163_18)
				local var_163_21 = var_163_19 <= 0 and var_163_16 or var_163_16 * (var_163_20 / var_163_19)

				if var_163_21 > 0 and var_163_16 < var_163_21 then
					arg_160_1.talkMaxDuration = var_163_21

					if var_163_21 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_21 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_18
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_15) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_15 + var_163_22 and arg_160_1.time_ < var_163_15 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play425042040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 425042040
		arg_164_1.duration_ = 14.13

		local var_164_0 = {
			zh = 8.366,
			ja = 14.133
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
				arg_164_0:Play425042041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1033"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps1033 == nil then
				arg_164_1.var_.actorSpriteComps1033 = var_167_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.actorSpriteComps1033 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								local var_167_4 = Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, var_167_3)
								local var_167_5 = Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, var_167_3)
								local var_167_6 = Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, var_167_3)

								iter_167_1.color = Color.New(var_167_4, var_167_5, var_167_6)
							else
								local var_167_7 = Mathf.Lerp(iter_167_1.color.r, 1, var_167_3)

								iter_167_1.color = Color.New(var_167_7, var_167_7, var_167_7)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps1033 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_167_3 then
						if arg_164_1.isInRecall_ then
							iter_167_3.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_167_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_164_1.var_.actorSpriteComps1033 = nil
			end

			local var_167_8 = arg_164_1.actors_["1033"].transform
			local var_167_9 = 0

			if var_167_9 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.var_.moveOldPos1033 = var_167_8.localPosition
				var_167_8.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("1033", 3)

				local var_167_10 = var_167_8.childCount

				for iter_167_4 = 0, var_167_10 - 1 do
					local var_167_11 = var_167_8:GetChild(iter_167_4)

					if var_167_11.name == "" or not string.find(var_167_11.name, "split") then
						var_167_11.gameObject:SetActive(true)
					else
						var_167_11.gameObject:SetActive(false)
					end
				end
			end

			local var_167_12 = 0.001

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_12 then
				local var_167_13 = (arg_164_1.time_ - var_167_9) / var_167_12
				local var_167_14 = Vector3.New(0, -420, 0)

				var_167_8.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1033, var_167_14, var_167_13)
			end

			if arg_164_1.time_ >= var_167_9 + var_167_12 and arg_164_1.time_ < var_167_9 + var_167_12 + arg_167_0 then
				var_167_8.localPosition = Vector3.New(0, -420, 0)
			end

			local var_167_15 = 0
			local var_167_16 = 1.1

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[236].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(425042040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 44
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042040", "story_v_out_425042.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042040", "story_v_out_425042.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_425042", "425042040", "story_v_out_425042.awb")

						arg_164_1:RecordAudio("425042040", var_167_24)
						arg_164_1:RecordAudio("425042040", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_425042", "425042040", "story_v_out_425042.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_425042", "425042040", "story_v_out_425042.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 425042041
		arg_168_1.duration_ = 12.17

		local var_168_0 = {
			zh = 7.866,
			ja = 12.166
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play425042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.075

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[236].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:GetWordFromCfg(425042041)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 43
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042041", "story_v_out_425042.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042041", "story_v_out_425042.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_425042", "425042041", "story_v_out_425042.awb")

						arg_168_1:RecordAudio("425042041", var_171_9)
						arg_168_1:RecordAudio("425042041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_425042", "425042041", "story_v_out_425042.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_425042", "425042041", "story_v_out_425042.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play425042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 425042042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play425042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1033"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1033 == nil then
				arg_172_1.var_.actorSpriteComps1033 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps1033 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								local var_175_4 = Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor2.r, var_175_3)
								local var_175_5 = Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor2.g, var_175_3)
								local var_175_6 = Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor2.b, var_175_3)

								iter_175_1.color = Color.New(var_175_4, var_175_5, var_175_6)
							else
								local var_175_7 = Mathf.Lerp(iter_175_1.color.r, 0.5, var_175_3)

								iter_175_1.color = Color.New(var_175_7, var_175_7, var_175_7)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1033 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1033 = nil
			end

			local var_175_8 = 0
			local var_175_9 = 0.425

			if var_175_8 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_10 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_11 = arg_172_1:GetWordFromCfg(425042042)
				local var_175_12 = arg_172_1:FormatText(var_175_11.content)

				arg_172_1.text_.text = var_175_12

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_13 = 17
				local var_175_14 = utf8.len(var_175_12)
				local var_175_15 = var_175_13 <= 0 and var_175_9 or var_175_9 * (var_175_14 / var_175_13)

				if var_175_15 > 0 and var_175_9 < var_175_15 then
					arg_172_1.talkMaxDuration = var_175_15

					if var_175_15 + var_175_8 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_15 + var_175_8
					end
				end

				arg_172_1.text_.text = var_175_12
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_16 = math.max(var_175_9, arg_172_1.talkMaxDuration)

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_16 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_8) / var_175_16

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_8 + var_175_16 and arg_172_1.time_ < var_175_8 + var_175_16 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play425042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 425042043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play425042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 1.15

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:GetWordFromCfg(425042043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 69
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_8 and arg_176_1.time_ < var_179_0 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play425042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 425042044
		arg_180_1.duration_ = 4.8

		local var_180_0 = {
			zh = 2.833,
			ja = 4.8
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
				arg_180_0:Play425042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10156"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10156 == nil then
				arg_180_1.var_.actorSpriteComps10156 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10156 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10156:ToTable()) do
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

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10156 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10156 = nil
			end

			local var_183_8 = arg_180_1.actors_["1033"].transform
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.var_.moveOldPos1033 = var_183_8.localPosition
				var_183_8.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1033", 7)

				local var_183_10 = var_183_8.childCount

				for iter_183_4 = 0, var_183_10 - 1 do
					local var_183_11 = var_183_8:GetChild(iter_183_4)

					if var_183_11.name == "" or not string.find(var_183_11.name, "split") then
						var_183_11.gameObject:SetActive(true)
					else
						var_183_11.gameObject:SetActive(false)
					end
				end
			end

			local var_183_12 = 0.001

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_12 then
				local var_183_13 = (arg_180_1.time_ - var_183_9) / var_183_12
				local var_183_14 = Vector3.New(0, -2000, 0)

				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1033, var_183_14, var_183_13)
			end

			if arg_180_1.time_ >= var_183_9 + var_183_12 and arg_180_1.time_ < var_183_9 + var_183_12 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_183_15 = arg_180_1.actors_["10156"].transform
			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.var_.moveOldPos10156 = var_183_15.localPosition
				var_183_15.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10156", 3)

				local var_183_17 = var_183_15.childCount

				for iter_183_5 = 0, var_183_17 - 1 do
					local var_183_18 = var_183_15:GetChild(iter_183_5)

					if var_183_18.name == "" or not string.find(var_183_18.name, "split") then
						var_183_18.gameObject:SetActive(true)
					else
						var_183_18.gameObject:SetActive(false)
					end
				end
			end

			local var_183_19 = 0.001

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_19 then
				local var_183_20 = (arg_180_1.time_ - var_183_16) / var_183_19
				local var_183_21 = Vector3.New(0, -390, -210)

				var_183_15.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10156, var_183_21, var_183_20)
			end

			if arg_180_1.time_ >= var_183_16 + var_183_19 and arg_180_1.time_ < var_183_16 + var_183_19 + arg_183_0 then
				var_183_15.localPosition = Vector3.New(0, -390, -210)
			end

			local var_183_22 = 0
			local var_183_23 = 0.3

			if var_183_22 < arg_180_1.time_ and arg_180_1.time_ <= var_183_22 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_24 = arg_180_1:FormatText(StoryNameCfg[1433].name)

				arg_180_1.leftNameTxt_.text = var_183_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_25 = arg_180_1:GetWordFromCfg(425042044)
				local var_183_26 = arg_180_1:FormatText(var_183_25.content)

				arg_180_1.text_.text = var_183_26

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_27 = 12
				local var_183_28 = utf8.len(var_183_26)
				local var_183_29 = var_183_27 <= 0 and var_183_23 or var_183_23 * (var_183_28 / var_183_27)

				if var_183_29 > 0 and var_183_23 < var_183_29 then
					arg_180_1.talkMaxDuration = var_183_29

					if var_183_29 + var_183_22 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_29 + var_183_22
					end
				end

				arg_180_1.text_.text = var_183_26
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042044", "story_v_out_425042.awb") ~= 0 then
					local var_183_30 = manager.audio:GetVoiceLength("story_v_out_425042", "425042044", "story_v_out_425042.awb") / 1000

					if var_183_30 + var_183_22 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_30 + var_183_22
					end

					if var_183_25.prefab_name ~= "" and arg_180_1.actors_[var_183_25.prefab_name] ~= nil then
						local var_183_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_25.prefab_name].transform, "story_v_out_425042", "425042044", "story_v_out_425042.awb")

						arg_180_1:RecordAudio("425042044", var_183_31)
						arg_180_1:RecordAudio("425042044", var_183_31)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_425042", "425042044", "story_v_out_425042.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_425042", "425042044", "story_v_out_425042.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_32 = math.max(var_183_23, arg_180_1.talkMaxDuration)

			if var_183_22 <= arg_180_1.time_ and arg_180_1.time_ < var_183_22 + var_183_32 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_22) / var_183_32

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_22 + var_183_32 and arg_180_1.time_ < var_183_22 + var_183_32 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play425042045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 425042045
		arg_184_1.duration_ = 5.53

		local var_184_0 = {
			zh = 5.533,
			ja = 5.233
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
				arg_184_0:Play425042046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10156"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10156 = var_187_0.localPosition
				var_187_0.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10156", 3)

				local var_187_2 = var_187_0.childCount

				for iter_187_0 = 0, var_187_2 - 1 do
					local var_187_3 = var_187_0:GetChild(iter_187_0)

					if var_187_3.name == "" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_4 then
				local var_187_5 = (arg_184_1.time_ - var_187_1) / var_187_4
				local var_187_6 = Vector3.New(0, -390, -210)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10156, var_187_6, var_187_5)
			end

			if arg_184_1.time_ >= var_187_1 + var_187_4 and arg_184_1.time_ < var_187_1 + var_187_4 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, -390, -210)
			end

			local var_187_7 = 0
			local var_187_8 = 0.625

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_9 = arg_184_1:FormatText(StoryNameCfg[1433].name)

				arg_184_1.leftNameTxt_.text = var_187_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(425042045)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_12 = 25
				local var_187_13 = utf8.len(var_187_11)
				local var_187_14 = var_187_12 <= 0 and var_187_8 or var_187_8 * (var_187_13 / var_187_12)

				if var_187_14 > 0 and var_187_8 < var_187_14 then
					arg_184_1.talkMaxDuration = var_187_14

					if var_187_14 + var_187_7 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_7
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042045", "story_v_out_425042.awb") ~= 0 then
					local var_187_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042045", "story_v_out_425042.awb") / 1000

					if var_187_15 + var_187_7 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_15 + var_187_7
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_out_425042", "425042045", "story_v_out_425042.awb")

						arg_184_1:RecordAudio("425042045", var_187_16)
						arg_184_1:RecordAudio("425042045", var_187_16)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_425042", "425042045", "story_v_out_425042.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_425042", "425042045", "story_v_out_425042.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_17 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_17 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_7) / var_187_17

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_7 + var_187_17 and arg_184_1.time_ < var_187_7 + var_187_17 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play425042046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 425042046
		arg_188_1.duration_ = 10.93

		local var_188_0 = {
			zh = 7.866,
			ja = 10.933
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
				arg_188_0:Play425042047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = "1037"

			if arg_188_1.actors_[var_191_0] == nil then
				local var_191_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_191_1) then
					local var_191_2 = Object.Instantiate(var_191_1, arg_188_1.canvasGo_.transform)

					var_191_2.transform:SetSiblingIndex(1)

					var_191_2.name = var_191_0
					var_191_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_188_1.actors_[var_191_0] = var_191_2

					local var_191_3 = var_191_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_188_1.isInRecall_ then
						for iter_191_0, iter_191_1 in ipairs(var_191_3) do
							iter_191_1.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_191_4 = arg_188_1.actors_["1037"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.actorSpriteComps1037 == nil then
				arg_188_1.var_.actorSpriteComps1037 = var_191_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_6 = 0.2

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.actorSpriteComps1037 then
					for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_191_3 then
							if arg_188_1.isInRecall_ then
								local var_191_8 = Mathf.Lerp(iter_191_3.color.r, arg_188_1.hightColor1.r, var_191_7)
								local var_191_9 = Mathf.Lerp(iter_191_3.color.g, arg_188_1.hightColor1.g, var_191_7)
								local var_191_10 = Mathf.Lerp(iter_191_3.color.b, arg_188_1.hightColor1.b, var_191_7)

								iter_191_3.color = Color.New(var_191_8, var_191_9, var_191_10)
							else
								local var_191_11 = Mathf.Lerp(iter_191_3.color.r, 1, var_191_7)

								iter_191_3.color = Color.New(var_191_11, var_191_11, var_191_11)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.actorSpriteComps1037 then
				for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_191_5 then
						if arg_188_1.isInRecall_ then
							iter_191_5.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1037 = nil
			end

			local var_191_12 = arg_188_1.actors_["10156"]
			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 and not isNil(var_191_12) and arg_188_1.var_.actorSpriteComps10156 == nil then
				arg_188_1.var_.actorSpriteComps10156 = var_191_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_14 = 0.2

			if var_191_13 <= arg_188_1.time_ and arg_188_1.time_ < var_191_13 + var_191_14 and not isNil(var_191_12) then
				local var_191_15 = (arg_188_1.time_ - var_191_13) / var_191_14

				if arg_188_1.var_.actorSpriteComps10156 then
					for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_191_7 then
							if arg_188_1.isInRecall_ then
								local var_191_16 = Mathf.Lerp(iter_191_7.color.r, arg_188_1.hightColor2.r, var_191_15)
								local var_191_17 = Mathf.Lerp(iter_191_7.color.g, arg_188_1.hightColor2.g, var_191_15)
								local var_191_18 = Mathf.Lerp(iter_191_7.color.b, arg_188_1.hightColor2.b, var_191_15)

								iter_191_7.color = Color.New(var_191_16, var_191_17, var_191_18)
							else
								local var_191_19 = Mathf.Lerp(iter_191_7.color.r, 0.5, var_191_15)

								iter_191_7.color = Color.New(var_191_19, var_191_19, var_191_19)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_13 + var_191_14 and arg_188_1.time_ < var_191_13 + var_191_14 + arg_191_0 and not isNil(var_191_12) and arg_188_1.var_.actorSpriteComps10156 then
				for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_191_9 then
						if arg_188_1.isInRecall_ then
							iter_191_9.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10156 = nil
			end

			local var_191_20 = arg_188_1.actors_["1037"].transform
			local var_191_21 = 0

			if var_191_21 < arg_188_1.time_ and arg_188_1.time_ <= var_191_21 + arg_191_0 then
				arg_188_1.var_.moveOldPos1037 = var_191_20.localPosition
				var_191_20.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1037", 4)

				local var_191_22 = var_191_20.childCount

				for iter_191_10 = 0, var_191_22 - 1 do
					local var_191_23 = var_191_20:GetChild(iter_191_10)

					if var_191_23.name == "" or not string.find(var_191_23.name, "split") then
						var_191_23.gameObject:SetActive(true)
					else
						var_191_23.gameObject:SetActive(false)
					end
				end
			end

			local var_191_24 = 0.001

			if var_191_21 <= arg_188_1.time_ and arg_188_1.time_ < var_191_21 + var_191_24 then
				local var_191_25 = (arg_188_1.time_ - var_191_21) / var_191_24
				local var_191_26 = Vector3.New(390, -430, -55)

				var_191_20.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1037, var_191_26, var_191_25)
			end

			if arg_188_1.time_ >= var_191_21 + var_191_24 and arg_188_1.time_ < var_191_21 + var_191_24 + arg_191_0 then
				var_191_20.localPosition = Vector3.New(390, -430, -55)
			end

			local var_191_27 = arg_188_1.actors_["10156"].transform
			local var_191_28 = 0

			if var_191_28 < arg_188_1.time_ and arg_188_1.time_ <= var_191_28 + arg_191_0 then
				arg_188_1.var_.moveOldPos10156 = var_191_27.localPosition
				var_191_27.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10156", 2)

				local var_191_29 = var_191_27.childCount

				for iter_191_11 = 0, var_191_29 - 1 do
					local var_191_30 = var_191_27:GetChild(iter_191_11)

					if var_191_30.name == "" or not string.find(var_191_30.name, "split") then
						var_191_30.gameObject:SetActive(true)
					else
						var_191_30.gameObject:SetActive(false)
					end
				end
			end

			local var_191_31 = 0.001

			if var_191_28 <= arg_188_1.time_ and arg_188_1.time_ < var_191_28 + var_191_31 then
				local var_191_32 = (arg_188_1.time_ - var_191_28) / var_191_31
				local var_191_33 = Vector3.New(-390, -390, -210)

				var_191_27.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10156, var_191_33, var_191_32)
			end

			if arg_188_1.time_ >= var_191_28 + var_191_31 and arg_188_1.time_ < var_191_28 + var_191_31 + arg_191_0 then
				var_191_27.localPosition = Vector3.New(-390, -390, -210)
			end

			local var_191_34 = 0
			local var_191_35 = 1.025

			if var_191_34 < arg_188_1.time_ and arg_188_1.time_ <= var_191_34 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_36 = arg_188_1:FormatText(StoryNameCfg[15].name)

				arg_188_1.leftNameTxt_.text = var_191_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_37 = arg_188_1:GetWordFromCfg(425042046)
				local var_191_38 = arg_188_1:FormatText(var_191_37.content)

				arg_188_1.text_.text = var_191_38

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_39 = 41
				local var_191_40 = utf8.len(var_191_38)
				local var_191_41 = var_191_39 <= 0 and var_191_35 or var_191_35 * (var_191_40 / var_191_39)

				if var_191_41 > 0 and var_191_35 < var_191_41 then
					arg_188_1.talkMaxDuration = var_191_41

					if var_191_41 + var_191_34 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_41 + var_191_34
					end
				end

				arg_188_1.text_.text = var_191_38
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042046", "story_v_out_425042.awb") ~= 0 then
					local var_191_42 = manager.audio:GetVoiceLength("story_v_out_425042", "425042046", "story_v_out_425042.awb") / 1000

					if var_191_42 + var_191_34 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_42 + var_191_34
					end

					if var_191_37.prefab_name ~= "" and arg_188_1.actors_[var_191_37.prefab_name] ~= nil then
						local var_191_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_37.prefab_name].transform, "story_v_out_425042", "425042046", "story_v_out_425042.awb")

						arg_188_1:RecordAudio("425042046", var_191_43)
						arg_188_1:RecordAudio("425042046", var_191_43)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_425042", "425042046", "story_v_out_425042.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_425042", "425042046", "story_v_out_425042.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_44 = math.max(var_191_35, arg_188_1.talkMaxDuration)

			if var_191_34 <= arg_188_1.time_ and arg_188_1.time_ < var_191_34 + var_191_44 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_34) / var_191_44

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_34 + var_191_44 and arg_188_1.time_ < var_191_34 + var_191_44 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
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
	Play425042047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 425042047
		arg_192_1.duration_ = 10.27

		local var_192_0 = {
			zh = 8.2,
			ja = 10.266
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
				arg_192_0:Play425042048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.975

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[15].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(425042047)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 39
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042047", "story_v_out_425042.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042047", "story_v_out_425042.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_425042", "425042047", "story_v_out_425042.awb")

						arg_192_1:RecordAudio("425042047", var_195_9)
						arg_192_1:RecordAudio("425042047", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_425042", "425042047", "story_v_out_425042.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_425042", "425042047", "story_v_out_425042.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play425042048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 425042048
		arg_196_1.duration_ = 10.37

		local var_196_0 = {
			zh = 7.2,
			ja = 10.366
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play425042049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1037"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1037 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1037", 4)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "split_6" then
						var_199_3:SetAsLastSibling()
						var_199_3.gameObject:SetActive(true)

						arg_196_1.var_.actorSpriteSplit1037 = var_199_3.gameObject:GetComponent(typeof(Image))

						arg_196_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_199_4 = 0.5

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(390, -430, -55)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1037, var_199_6, var_199_5)

				if arg_196_1.var_.actorSpriteSplit1037 ~= nil then
					arg_196_1.var_.actorSpriteSplit1037:SetAlpha(var_199_5)
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(390, -430, -55)

				if arg_196_1.var_.actorSpriteSplit1037 ~= nil then
					arg_196_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_199_7 = 0
			local var_199_8 = 0.925

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_9 = arg_196_1:FormatText(StoryNameCfg[15].name)

				arg_196_1.leftNameTxt_.text = var_199_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(425042048)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_12 = 37
				local var_199_13 = utf8.len(var_199_11)
				local var_199_14 = var_199_12 <= 0 and var_199_8 or var_199_8 * (var_199_13 / var_199_12)

				if var_199_14 > 0 and var_199_8 < var_199_14 then
					arg_196_1.talkMaxDuration = var_199_14

					if var_199_14 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042048", "story_v_out_425042.awb") ~= 0 then
					local var_199_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042048", "story_v_out_425042.awb") / 1000

					if var_199_15 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_15 + var_199_7
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_425042", "425042048", "story_v_out_425042.awb")

						arg_196_1:RecordAudio("425042048", var_199_16)
						arg_196_1:RecordAudio("425042048", var_199_16)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_425042", "425042048", "story_v_out_425042.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_425042", "425042048", "story_v_out_425042.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_17 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_17 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_17

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_17 and arg_196_1.time_ < var_199_7 + var_199_17 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play425042049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 425042049
		arg_200_1.duration_ = 8.97

		local var_200_0 = {
			zh = 7.166,
			ja = 8.966
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play425042050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10156"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10156 == nil then
				arg_200_1.var_.actorSpriteComps10156 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps10156 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 1, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10156 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10156 = nil
			end

			local var_203_8 = arg_200_1.actors_["1037"]
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps1037 == nil then
				arg_200_1.var_.actorSpriteComps1037 = var_203_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_10 = 0.2

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_10 and not isNil(var_203_8) then
				local var_203_11 = (arg_200_1.time_ - var_203_9) / var_203_10

				if arg_200_1.var_.actorSpriteComps1037 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								local var_203_12 = Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, var_203_11)
								local var_203_13 = Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, var_203_11)
								local var_203_14 = Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, var_203_11)

								iter_203_5.color = Color.New(var_203_12, var_203_13, var_203_14)
							else
								local var_203_15 = Mathf.Lerp(iter_203_5.color.r, 0.5, var_203_11)

								iter_203_5.color = Color.New(var_203_15, var_203_15, var_203_15)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_9 + var_203_10 and arg_200_1.time_ < var_203_9 + var_203_10 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps1037 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_203_7 then
						if arg_200_1.isInRecall_ then
							iter_203_7.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1037 = nil
			end

			local var_203_16 = arg_200_1.actors_["10156"].transform
			local var_203_17 = 0

			if var_203_17 < arg_200_1.time_ and arg_200_1.time_ <= var_203_17 + arg_203_0 then
				arg_200_1.var_.moveOldPos10156 = var_203_16.localPosition
				var_203_16.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10156", 2)

				local var_203_18 = var_203_16.childCount

				for iter_203_8 = 0, var_203_18 - 1 do
					local var_203_19 = var_203_16:GetChild(iter_203_8)

					if var_203_19.name == "split_3" then
						var_203_19:SetAsLastSibling()
						var_203_19.gameObject:SetActive(true)

						arg_200_1.var_.actorSpriteSplit10156 = var_203_19.gameObject:GetComponent(typeof(Image))

						arg_200_1.var_.actorSpriteSplit10156:SetAlpha(0)
					end
				end
			end

			local var_203_20 = 0.5

			if var_203_17 <= arg_200_1.time_ and arg_200_1.time_ < var_203_17 + var_203_20 then
				local var_203_21 = (arg_200_1.time_ - var_203_17) / var_203_20
				local var_203_22 = Vector3.New(-390, -390, -210)

				var_203_16.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10156, var_203_22, var_203_21)

				if arg_200_1.var_.actorSpriteSplit10156 ~= nil then
					arg_200_1.var_.actorSpriteSplit10156:SetAlpha(var_203_21)
				end
			end

			if arg_200_1.time_ >= var_203_17 + var_203_20 and arg_200_1.time_ < var_203_17 + var_203_20 + arg_203_0 then
				var_203_16.localPosition = Vector3.New(-390, -390, -210)

				if arg_200_1.var_.actorSpriteSplit10156 ~= nil then
					arg_200_1.var_.actorSpriteSplit10156:SetAlpha(1)
				end
			end

			local var_203_23 = arg_200_1.actors_["1037"].transform
			local var_203_24 = 0

			if var_203_24 < arg_200_1.time_ and arg_200_1.time_ <= var_203_24 + arg_203_0 then
				arg_200_1.var_.moveOldPos1037 = var_203_23.localPosition
				var_203_23.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1037", 4)

				local var_203_25 = var_203_23.childCount

				for iter_203_9 = 0, var_203_25 - 1 do
					local var_203_26 = var_203_23:GetChild(iter_203_9)

					if var_203_26.name == "split_1" then
						var_203_26:SetAsLastSibling()
						var_203_26.gameObject:SetActive(true)

						arg_200_1.var_.actorSpriteSplit1037 = var_203_26.gameObject:GetComponent(typeof(Image))

						arg_200_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_203_27 = 0.2

			if var_203_24 <= arg_200_1.time_ and arg_200_1.time_ < var_203_24 + var_203_27 then
				local var_203_28 = (arg_200_1.time_ - var_203_24) / var_203_27
				local var_203_29 = Vector3.New(390, -430, -55)

				var_203_23.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1037, var_203_29, var_203_28)

				if arg_200_1.var_.actorSpriteSplit1037 ~= nil then
					arg_200_1.var_.actorSpriteSplit1037:SetAlpha(var_203_28)
				end
			end

			if arg_200_1.time_ >= var_203_24 + var_203_27 and arg_200_1.time_ < var_203_24 + var_203_27 + arg_203_0 then
				var_203_23.localPosition = Vector3.New(390, -430, -55)

				if arg_200_1.var_.actorSpriteSplit1037 ~= nil then
					arg_200_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_203_30 = 0
			local var_203_31 = 0.825

			if var_203_30 < arg_200_1.time_ and arg_200_1.time_ <= var_203_30 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_32 = arg_200_1:FormatText(StoryNameCfg[1433].name)

				arg_200_1.leftNameTxt_.text = var_203_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_33 = arg_200_1:GetWordFromCfg(425042049)
				local var_203_34 = arg_200_1:FormatText(var_203_33.content)

				arg_200_1.text_.text = var_203_34

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_35 = 33
				local var_203_36 = utf8.len(var_203_34)
				local var_203_37 = var_203_35 <= 0 and var_203_31 or var_203_31 * (var_203_36 / var_203_35)

				if var_203_37 > 0 and var_203_31 < var_203_37 then
					arg_200_1.talkMaxDuration = var_203_37

					if var_203_37 + var_203_30 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_37 + var_203_30
					end
				end

				arg_200_1.text_.text = var_203_34
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042049", "story_v_out_425042.awb") ~= 0 then
					local var_203_38 = manager.audio:GetVoiceLength("story_v_out_425042", "425042049", "story_v_out_425042.awb") / 1000

					if var_203_38 + var_203_30 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_38 + var_203_30
					end

					if var_203_33.prefab_name ~= "" and arg_200_1.actors_[var_203_33.prefab_name] ~= nil then
						local var_203_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_33.prefab_name].transform, "story_v_out_425042", "425042049", "story_v_out_425042.awb")

						arg_200_1:RecordAudio("425042049", var_203_39)
						arg_200_1:RecordAudio("425042049", var_203_39)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_425042", "425042049", "story_v_out_425042.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_425042", "425042049", "story_v_out_425042.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_40 = math.max(var_203_31, arg_200_1.talkMaxDuration)

			if var_203_30 <= arg_200_1.time_ and arg_200_1.time_ < var_203_30 + var_203_40 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_30) / var_203_40

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_30 + var_203_40 and arg_200_1.time_ < var_203_30 + var_203_40 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play425042050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 425042050
		arg_204_1.duration_ = 9.9

		local var_204_0 = {
			zh = 8.133,
			ja = 9.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play425042051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.975

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[1433].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(425042050)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 39
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042050", "story_v_out_425042.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042050", "story_v_out_425042.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_425042", "425042050", "story_v_out_425042.awb")

						arg_204_1:RecordAudio("425042050", var_207_9)
						arg_204_1:RecordAudio("425042050", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_425042", "425042050", "story_v_out_425042.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_425042", "425042050", "story_v_out_425042.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play425042051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 425042051
		arg_208_1.duration_ = 13.4

		local var_208_0 = {
			zh = 12.366,
			ja = 13.4
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play425042052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.425

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[1433].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(425042051)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 57
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042051", "story_v_out_425042.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042051", "story_v_out_425042.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_425042", "425042051", "story_v_out_425042.awb")

						arg_208_1:RecordAudio("425042051", var_211_9)
						arg_208_1:RecordAudio("425042051", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_425042", "425042051", "story_v_out_425042.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_425042", "425042051", "story_v_out_425042.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play425042052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 425042052
		arg_212_1.duration_ = 3.9

		local var_212_0 = {
			zh = 2.466,
			ja = 3.9
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
				arg_212_0:Play425042053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10156"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10156 = var_215_0.localPosition
				var_215_0.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10156", 2)

				local var_215_2 = var_215_0.childCount

				for iter_215_0 = 0, var_215_2 - 1 do
					local var_215_3 = var_215_0:GetChild(iter_215_0)

					if var_215_3.name == "" then
						var_215_3:SetAsLastSibling()
						var_215_3.gameObject:SetActive(true)

						arg_212_1.var_.actorSpriteSplit10156 = var_215_3.gameObject:GetComponent(typeof(Image))

						arg_212_1.var_.actorSpriteSplit10156:SetAlpha(0)
					end
				end
			end

			local var_215_4 = 0.5

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_4 then
				local var_215_5 = (arg_212_1.time_ - var_215_1) / var_215_4
				local var_215_6 = Vector3.New(-390, -390, -210)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10156, var_215_6, var_215_5)

				if arg_212_1.var_.actorSpriteSplit10156 ~= nil then
					arg_212_1.var_.actorSpriteSplit10156:SetAlpha(var_215_5)
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_4 and arg_212_1.time_ < var_215_1 + var_215_4 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(-390, -390, -210)

				if arg_212_1.var_.actorSpriteSplit10156 ~= nil then
					arg_212_1.var_.actorSpriteSplit10156:SetAlpha(1)
				end
			end

			local var_215_7 = 0
			local var_215_8 = 0.35

			if var_215_7 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_9 = arg_212_1:FormatText(StoryNameCfg[1433].name)

				arg_212_1.leftNameTxt_.text = var_215_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(425042052)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_12 = 14
				local var_215_13 = utf8.len(var_215_11)
				local var_215_14 = var_215_12 <= 0 and var_215_8 or var_215_8 * (var_215_13 / var_215_12)

				if var_215_14 > 0 and var_215_8 < var_215_14 then
					arg_212_1.talkMaxDuration = var_215_14

					if var_215_14 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_7
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042052", "story_v_out_425042.awb") ~= 0 then
					local var_215_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042052", "story_v_out_425042.awb") / 1000

					if var_215_15 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_15 + var_215_7
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_425042", "425042052", "story_v_out_425042.awb")

						arg_212_1:RecordAudio("425042052", var_215_16)
						arg_212_1:RecordAudio("425042052", var_215_16)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_425042", "425042052", "story_v_out_425042.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_425042", "425042052", "story_v_out_425042.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_17 = math.max(var_215_8, arg_212_1.talkMaxDuration)

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_17 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_7) / var_215_17

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_7 + var_215_17 and arg_212_1.time_ < var_215_7 + var_215_17 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play425042053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 425042053
		arg_216_1.duration_ = 19.17

		local var_216_0 = {
			zh = 13.199999999999,
			ja = 19.165999999999
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play425042054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 5.399999999999

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.allBtn_.enabled = false
			end

			local var_219_1 = 0.3

			if arg_216_1.time_ >= var_219_0 + var_219_1 and arg_216_1.time_ < var_219_0 + var_219_1 + arg_219_0 then
				arg_216_1.allBtn_.enabled = true
			end

			local var_219_2 = "10127"

			if arg_216_1.actors_[var_219_2] == nil then
				local var_219_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_219_3) then
					local var_219_4 = Object.Instantiate(var_219_3, arg_216_1.canvasGo_.transform)

					var_219_4.transform:SetSiblingIndex(1)

					var_219_4.name = var_219_2
					var_219_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_216_1.actors_[var_219_2] = var_219_4

					local var_219_5 = var_219_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_216_1.isInRecall_ then
						for iter_219_0, iter_219_1 in ipairs(var_219_5) do
							iter_219_1.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_219_6 = arg_216_1.actors_["10127"]
			local var_219_7 = 5.199999999999

			if var_219_7 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.actorSpriteComps10127 == nil then
				arg_216_1.var_.actorSpriteComps10127 = var_219_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_8 = 0.2

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_8 and not isNil(var_219_6) then
				local var_219_9 = (arg_216_1.time_ - var_219_7) / var_219_8

				if arg_216_1.var_.actorSpriteComps10127 then
					for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_219_3 then
							if arg_216_1.isInRecall_ then
								local var_219_10 = Mathf.Lerp(iter_219_3.color.r, arg_216_1.hightColor1.r, var_219_9)
								local var_219_11 = Mathf.Lerp(iter_219_3.color.g, arg_216_1.hightColor1.g, var_219_9)
								local var_219_12 = Mathf.Lerp(iter_219_3.color.b, arg_216_1.hightColor1.b, var_219_9)

								iter_219_3.color = Color.New(var_219_10, var_219_11, var_219_12)
							else
								local var_219_13 = Mathf.Lerp(iter_219_3.color.r, 1, var_219_9)

								iter_219_3.color = Color.New(var_219_13, var_219_13, var_219_13)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_7 + var_219_8 and arg_216_1.time_ < var_219_7 + var_219_8 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.actorSpriteComps10127 then
				for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_219_5 then
						if arg_216_1.isInRecall_ then
							iter_219_5.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10127 = nil
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_15 = 1

			if var_219_14 <= arg_216_1.time_ and arg_216_1.time_ < var_219_14 + var_219_15 then
				local var_219_16 = (arg_216_1.time_ - var_219_14) / var_219_15
				local var_219_17 = Color.New(0, 0, 0)

				var_219_17.a = Mathf.Lerp(0, 1, var_219_16)
				arg_216_1.mask_.color = var_219_17
			end

			if arg_216_1.time_ >= var_219_14 + var_219_15 and arg_216_1.time_ < var_219_14 + var_219_15 + arg_219_0 then
				local var_219_18 = Color.New(0, 0, 0)

				var_219_18.a = 1
				arg_216_1.mask_.color = var_219_18
			end

			local var_219_19 = 1

			if var_219_19 < arg_216_1.time_ and arg_216_1.time_ <= var_219_19 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_20 = 0.999999999999996

			if var_219_19 <= arg_216_1.time_ and arg_216_1.time_ < var_219_19 + var_219_20 then
				local var_219_21 = (arg_216_1.time_ - var_219_19) / var_219_20
				local var_219_22 = Color.New(0, 0, 0)

				var_219_22.a = Mathf.Lerp(1, 0, var_219_21)
				arg_216_1.mask_.color = var_219_22
			end

			if arg_216_1.time_ >= var_219_19 + var_219_20 and arg_216_1.time_ < var_219_19 + var_219_20 + arg_219_0 then
				local var_219_23 = Color.New(0, 0, 0)
				local var_219_24 = 0

				arg_216_1.mask_.enabled = false
				var_219_23.a = var_219_24
				arg_216_1.mask_.color = var_219_23
			end

			local var_219_25 = arg_216_1.actors_["10127"].transform
			local var_219_26 = 5.199999999999

			if var_219_26 < arg_216_1.time_ and arg_216_1.time_ <= var_219_26 + arg_219_0 then
				arg_216_1.var_.moveOldPos10127 = var_219_25.localPosition
				var_219_25.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10127", 3)

				local var_219_27 = var_219_25.childCount

				for iter_219_6 = 0, var_219_27 - 1 do
					local var_219_28 = var_219_25:GetChild(iter_219_6)

					if var_219_28.name == "split_1" or not string.find(var_219_28.name, "split") then
						var_219_28.gameObject:SetActive(true)
					else
						var_219_28.gameObject:SetActive(false)
					end
				end
			end

			local var_219_29 = 0.001

			if var_219_26 <= arg_216_1.time_ and arg_216_1.time_ < var_219_26 + var_219_29 then
				local var_219_30 = (arg_216_1.time_ - var_219_26) / var_219_29
				local var_219_31 = Vector3.New(0, -387.4, -316.5)

				var_219_25.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10127, var_219_31, var_219_30)
			end

			if arg_216_1.time_ >= var_219_26 + var_219_29 and arg_216_1.time_ < var_219_26 + var_219_29 + arg_219_0 then
				var_219_25.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_219_32 = arg_216_1.actors_["10156"].transform
			local var_219_33 = 1

			if var_219_33 < arg_216_1.time_ and arg_216_1.time_ <= var_219_33 + arg_219_0 then
				arg_216_1.var_.moveOldPos10156 = var_219_32.localPosition
				var_219_32.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10156", 7)

				local var_219_34 = var_219_32.childCount

				for iter_219_7 = 0, var_219_34 - 1 do
					local var_219_35 = var_219_32:GetChild(iter_219_7)

					if var_219_35.name == "" or not string.find(var_219_35.name, "split") then
						var_219_35.gameObject:SetActive(true)
					else
						var_219_35.gameObject:SetActive(false)
					end
				end
			end

			local var_219_36 = 0.001

			if var_219_33 <= arg_216_1.time_ and arg_216_1.time_ < var_219_33 + var_219_36 then
				local var_219_37 = (arg_216_1.time_ - var_219_33) / var_219_36
				local var_219_38 = Vector3.New(0, -2000, 0)

				var_219_32.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10156, var_219_38, var_219_37)
			end

			if arg_216_1.time_ >= var_219_33 + var_219_36 and arg_216_1.time_ < var_219_33 + var_219_36 + arg_219_0 then
				var_219_32.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_219_39 = arg_216_1.actors_["1037"].transform
			local var_219_40 = 1

			if var_219_40 < arg_216_1.time_ and arg_216_1.time_ <= var_219_40 + arg_219_0 then
				arg_216_1.var_.moveOldPos1037 = var_219_39.localPosition
				var_219_39.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1037", 7)

				local var_219_41 = var_219_39.childCount

				for iter_219_8 = 0, var_219_41 - 1 do
					local var_219_42 = var_219_39:GetChild(iter_219_8)

					if var_219_42.name == "" or not string.find(var_219_42.name, "split") then
						var_219_42.gameObject:SetActive(true)
					else
						var_219_42.gameObject:SetActive(false)
					end
				end
			end

			local var_219_43 = 0.001

			if var_219_40 <= arg_216_1.time_ and arg_216_1.time_ < var_219_40 + var_219_43 then
				local var_219_44 = (arg_216_1.time_ - var_219_40) / var_219_43
				local var_219_45 = Vector3.New(1500, -2000, 0)

				var_219_39.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1037, var_219_45, var_219_44)
			end

			if arg_216_1.time_ >= var_219_40 + var_219_43 and arg_216_1.time_ < var_219_40 + var_219_43 + arg_219_0 then
				var_219_39.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_219_46 = 1
			local var_219_47 = 1.999999999999
			local var_219_48 = "ST18"

			if var_219_46 < arg_216_1.time_ and arg_216_1.time_ <= var_219_46 + arg_219_0 then
				arg_216_1.timestampController_:SetSelectedState("show")
				arg_216_1.timestampAni_:Play("in")

				arg_216_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_48)

				arg_216_1.timestampColorController_:SetSelectedState("hot")
				arg_216_1.timeColdImg_:SetAlpha(0.031)

				local var_219_49 = arg_216_1:GetWordFromCfg(501108)
				local var_219_50 = arg_216_1:FormatText(var_219_49.content)

				arg_216_1.text_timeText_.text = var_219_50

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_timeText_)

				local var_219_51 = arg_216_1:GetWordFromCfg(501118)
				local var_219_52 = arg_216_1:FormatText(var_219_51.content)

				arg_216_1.text_siteText_.text = var_219_52

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_siteText_)
			end

			if arg_216_1.time_ >= var_219_46 + var_219_47 and arg_216_1.time_ < var_219_46 + var_219_47 + arg_219_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_216_1.timestampAni_, "out", function()
					arg_216_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_219_53 = 2.999999999999

			if var_219_53 < arg_216_1.time_ and arg_216_1.time_ <= var_219_53 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_54 = 1.2

			if var_219_53 <= arg_216_1.time_ and arg_216_1.time_ < var_219_53 + var_219_54 then
				local var_219_55 = (arg_216_1.time_ - var_219_53) / var_219_54
				local var_219_56 = Color.New(0, 0, 0)

				var_219_56.a = Mathf.Lerp(0, 1, var_219_55)
				arg_216_1.mask_.color = var_219_56
			end

			if arg_216_1.time_ >= var_219_53 + var_219_54 and arg_216_1.time_ < var_219_53 + var_219_54 + arg_219_0 then
				local var_219_57 = Color.New(0, 0, 0)

				var_219_57.a = 1
				arg_216_1.mask_.color = var_219_57
			end

			local var_219_58 = 4.199999999999

			if var_219_58 < arg_216_1.time_ and arg_216_1.time_ <= var_219_58 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_59 = 1.2

			if var_219_58 <= arg_216_1.time_ and arg_216_1.time_ < var_219_58 + var_219_59 then
				local var_219_60 = (arg_216_1.time_ - var_219_58) / var_219_59
				local var_219_61 = Color.New(0, 0, 0)

				var_219_61.a = Mathf.Lerp(1, 0, var_219_60)
				arg_216_1.mask_.color = var_219_61
			end

			if arg_216_1.time_ >= var_219_58 + var_219_59 and arg_216_1.time_ < var_219_58 + var_219_59 + arg_219_0 then
				local var_219_62 = Color.New(0, 0, 0)
				local var_219_63 = 0

				arg_216_1.mask_.enabled = false
				var_219_62.a = var_219_63
				arg_216_1.mask_.color = var_219_62
			end

			local var_219_64 = "ST18"

			if arg_216_1.bgs_[var_219_64] == nil then
				local var_219_65 = Object.Instantiate(arg_216_1.paintGo_)

				var_219_65:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_64)
				var_219_65.name = var_219_64
				var_219_65.transform.parent = arg_216_1.stage_.transform
				var_219_65.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_[var_219_64] = var_219_65
			end

			local var_219_66 = 1

			if var_219_66 < arg_216_1.time_ and arg_216_1.time_ <= var_219_66 + arg_219_0 then
				local var_219_67 = manager.ui.mainCamera.transform.localPosition
				local var_219_68 = Vector3.New(0, 0, 10) + Vector3.New(var_219_67.x, var_219_67.y, 0)
				local var_219_69 = arg_216_1.bgs_.ST18

				var_219_69.transform.localPosition = var_219_68
				var_219_69.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_70 = var_219_69:GetComponent("SpriteRenderer")

				if var_219_70 and var_219_70.sprite then
					local var_219_71 = (var_219_69.transform.localPosition - var_219_67).z
					local var_219_72 = manager.ui.mainCameraCom_
					local var_219_73 = 2 * var_219_71 * Mathf.Tan(var_219_72.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_219_74 = var_219_73 * var_219_72.aspect
					local var_219_75 = var_219_70.sprite.bounds.size.x
					local var_219_76 = var_219_70.sprite.bounds.size.y
					local var_219_77 = var_219_74 / var_219_75
					local var_219_78 = var_219_73 / var_219_76
					local var_219_79 = var_219_78 < var_219_77 and var_219_77 or var_219_78

					var_219_69.transform.localScale = Vector3.New(var_219_79, var_219_79, 0)
				end

				for iter_219_9, iter_219_10 in pairs(arg_216_1.bgs_) do
					if iter_219_9 ~= "ST18" then
						iter_219_10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_219_80 = arg_216_1.actors_["10127"]
			local var_219_81 = 4.199999999999

			if var_219_81 < arg_216_1.time_ and arg_216_1.time_ <= var_219_81 + arg_219_0 then
				local var_219_82 = var_219_80:GetComponentInChildren(typeof(CanvasGroup))

				if var_219_82 then
					arg_216_1.var_.alphaOldValue10127 = var_219_82.alpha
					arg_216_1.var_.characterEffect10127 = var_219_82
				end

				arg_216_1.var_.alphaOldValue10127 = 0
			end

			local var_219_83 = 1.2

			if var_219_81 <= arg_216_1.time_ and arg_216_1.time_ < var_219_81 + var_219_83 then
				local var_219_84 = (arg_216_1.time_ - var_219_81) / var_219_83
				local var_219_85 = Mathf.Lerp(arg_216_1.var_.alphaOldValue10127, 1, var_219_84)

				if arg_216_1.var_.characterEffect10127 then
					arg_216_1.var_.characterEffect10127.alpha = var_219_85
				end
			end

			if arg_216_1.time_ >= var_219_81 + var_219_83 and arg_216_1.time_ < var_219_81 + var_219_83 + arg_219_0 and arg_216_1.var_.characterEffect10127 then
				arg_216_1.var_.characterEffect10127.alpha = 1
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_86 = 5.399999999999
			local var_219_87 = 0.9

			if var_219_86 < arg_216_1.time_ and arg_216_1.time_ <= var_219_86 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_88 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_88:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_216_1.dialogCg_.alpha = arg_221_0
				end))
				var_219_88:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_88:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_89 = arg_216_1:FormatText(StoryNameCfg[236].name)

				arg_216_1.leftNameTxt_.text = var_219_89

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_90 = arg_216_1:GetWordFromCfg(425042053)
				local var_219_91 = arg_216_1:FormatText(var_219_90.content)

				arg_216_1.text_.text = var_219_91

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_92 = 36
				local var_219_93 = utf8.len(var_219_91)
				local var_219_94 = var_219_92 <= 0 and var_219_87 or var_219_87 * (var_219_93 / var_219_92)

				if var_219_94 > 0 and var_219_87 < var_219_94 then
					arg_216_1.talkMaxDuration = var_219_94
					var_219_86 = var_219_86 + 0.3

					if var_219_94 + var_219_86 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_94 + var_219_86
					end
				end

				arg_216_1.text_.text = var_219_91
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042053", "story_v_out_425042.awb") ~= 0 then
					local var_219_95 = manager.audio:GetVoiceLength("story_v_out_425042", "425042053", "story_v_out_425042.awb") / 1000

					if var_219_95 + var_219_86 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_95 + var_219_86
					end

					if var_219_90.prefab_name ~= "" and arg_216_1.actors_[var_219_90.prefab_name] ~= nil then
						local var_219_96 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_90.prefab_name].transform, "story_v_out_425042", "425042053", "story_v_out_425042.awb")

						arg_216_1:RecordAudio("425042053", var_219_96)
						arg_216_1:RecordAudio("425042053", var_219_96)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_425042", "425042053", "story_v_out_425042.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_425042", "425042053", "story_v_out_425042.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_97 = var_219_86 + 0.3
			local var_219_98 = math.max(var_219_87, arg_216_1.talkMaxDuration)

			if var_219_97 <= arg_216_1.time_ and arg_216_1.time_ < var_219_97 + var_219_98 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_97) / var_219_98

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_97 + var_219_98 and arg_216_1.time_ < var_219_97 + var_219_98 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.199999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play425042054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 425042054
		arg_223_1.duration_ = 9.77

		local var_223_0 = {
			zh = 5.766,
			ja = 9.766
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
				arg_223_0:Play425042055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.75

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[236].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(425042054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 30
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042054", "story_v_out_425042.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042054", "story_v_out_425042.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_425042", "425042054", "story_v_out_425042.awb")

						arg_223_1:RecordAudio("425042054", var_226_9)
						arg_223_1:RecordAudio("425042054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_425042", "425042054", "story_v_out_425042.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_425042", "425042054", "story_v_out_425042.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play425042055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 425042055
		arg_227_1.duration_ = 12.87

		local var_227_0 = {
			zh = 7.766,
			ja = 12.866
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
				arg_227_0:Play425042056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1137"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1137 == nil then
				arg_227_1.var_.actorSpriteComps1137 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1137 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1137 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1137 = nil
			end

			local var_230_8 = arg_227_1.actors_["10127"]
			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps10127 == nil then
				arg_227_1.var_.actorSpriteComps10127 = var_230_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_10 = 0.2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 and not isNil(var_230_8) then
				local var_230_11 = (arg_227_1.time_ - var_230_9) / var_230_10

				if arg_227_1.var_.actorSpriteComps10127 then
					for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps10127 then
				for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_230_7 then
						if arg_227_1.isInRecall_ then
							iter_230_7.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10127 = nil
			end

			local var_230_16 = arg_227_1.actors_["1137"].transform
			local var_230_17 = 0

			if var_230_17 < arg_227_1.time_ and arg_227_1.time_ <= var_230_17 + arg_230_0 then
				arg_227_1.var_.moveOldPos1137 = var_230_16.localPosition
				var_230_16.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1137", 4)

				local var_230_18 = var_230_16.childCount

				for iter_230_8 = 0, var_230_18 - 1 do
					local var_230_19 = var_230_16:GetChild(iter_230_8)

					if var_230_19.name == "split_4" or not string.find(var_230_19.name, "split") then
						var_230_19.gameObject:SetActive(true)
					else
						var_230_19.gameObject:SetActive(false)
					end
				end
			end

			local var_230_20 = 0.001

			if var_230_17 <= arg_227_1.time_ and arg_227_1.time_ < var_230_17 + var_230_20 then
				local var_230_21 = (arg_227_1.time_ - var_230_17) / var_230_20
				local var_230_22 = Vector3.New(390, -425, -200)

				var_230_16.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1137, var_230_22, var_230_21)
			end

			if arg_227_1.time_ >= var_230_17 + var_230_20 and arg_227_1.time_ < var_230_17 + var_230_20 + arg_230_0 then
				var_230_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_230_23 = arg_227_1.actors_["10127"].transform
			local var_230_24 = 0

			if var_230_24 < arg_227_1.time_ and arg_227_1.time_ <= var_230_24 + arg_230_0 then
				arg_227_1.var_.moveOldPos10127 = var_230_23.localPosition
				var_230_23.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10127", 2)

				local var_230_25 = var_230_23.childCount

				for iter_230_9 = 0, var_230_25 - 1 do
					local var_230_26 = var_230_23:GetChild(iter_230_9)

					if var_230_26.name == "split_1" or not string.find(var_230_26.name, "split") then
						var_230_26.gameObject:SetActive(true)
					else
						var_230_26.gameObject:SetActive(false)
					end
				end
			end

			local var_230_27 = 0.001

			if var_230_24 <= arg_227_1.time_ and arg_227_1.time_ < var_230_24 + var_230_27 then
				local var_230_28 = (arg_227_1.time_ - var_230_24) / var_230_27
				local var_230_29 = Vector3.New(-390, -387.4, -316.5)

				var_230_23.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10127, var_230_29, var_230_28)
			end

			if arg_227_1.time_ >= var_230_24 + var_230_27 and arg_227_1.time_ < var_230_24 + var_230_27 + arg_230_0 then
				var_230_23.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_230_30 = 0
			local var_230_31 = 0.925

			if var_230_30 < arg_227_1.time_ and arg_227_1.time_ <= var_230_30 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_32 = arg_227_1:FormatText(StoryNameCfg[15].name)

				arg_227_1.leftNameTxt_.text = var_230_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_33 = arg_227_1:GetWordFromCfg(425042055)
				local var_230_34 = arg_227_1:FormatText(var_230_33.content)

				arg_227_1.text_.text = var_230_34

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_35 = 37
				local var_230_36 = utf8.len(var_230_34)
				local var_230_37 = var_230_35 <= 0 and var_230_31 or var_230_31 * (var_230_36 / var_230_35)

				if var_230_37 > 0 and var_230_31 < var_230_37 then
					arg_227_1.talkMaxDuration = var_230_37

					if var_230_37 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_37 + var_230_30
					end
				end

				arg_227_1.text_.text = var_230_34
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042055", "story_v_out_425042.awb") ~= 0 then
					local var_230_38 = manager.audio:GetVoiceLength("story_v_out_425042", "425042055", "story_v_out_425042.awb") / 1000

					if var_230_38 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_38 + var_230_30
					end

					if var_230_33.prefab_name ~= "" and arg_227_1.actors_[var_230_33.prefab_name] ~= nil then
						local var_230_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_33.prefab_name].transform, "story_v_out_425042", "425042055", "story_v_out_425042.awb")

						arg_227_1:RecordAudio("425042055", var_230_39)
						arg_227_1:RecordAudio("425042055", var_230_39)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_425042", "425042055", "story_v_out_425042.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_425042", "425042055", "story_v_out_425042.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_40 = math.max(var_230_31, arg_227_1.talkMaxDuration)

			if var_230_30 <= arg_227_1.time_ and arg_227_1.time_ < var_230_30 + var_230_40 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_30) / var_230_40

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_30 + var_230_40 and arg_227_1.time_ < var_230_30 + var_230_40 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play425042056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 425042056
		arg_231_1.duration_ = 6.93

		local var_231_0 = {
			zh = 3.666,
			ja = 6.933
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
				arg_231_0:Play425042057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10127"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10127 == nil then
				arg_231_1.var_.actorSpriteComps10127 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10127 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10127 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10127 = nil
			end

			local var_234_8 = arg_231_1.actors_["1137"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1137 == nil then
				arg_231_1.var_.actorSpriteComps1137 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1137 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1137 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1137 = nil
			end

			local var_234_16 = arg_231_1.actors_["10127"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos10127 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10127", 2)

				local var_234_18 = var_234_16.childCount

				for iter_234_8 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_8)

					if var_234_19.name == "split_6" then
						var_234_19:SetAsLastSibling()
						var_234_19.gameObject:SetActive(true)

						arg_231_1.var_.actorSpriteSplit10127 = var_234_19.gameObject:GetComponent(typeof(Image))

						arg_231_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_234_20 = 0.2

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-390, -387.4, -316.5)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10127, var_234_22, var_234_21)

				if arg_231_1.var_.actorSpriteSplit10127 ~= nil then
					arg_231_1.var_.actorSpriteSplit10127:SetAlpha(var_234_21)
				end
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_231_1.var_.actorSpriteSplit10127 ~= nil then
					arg_231_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_234_23 = 0
			local var_234_24 = 0.45

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[236].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(425042056)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042056", "story_v_out_425042.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042056", "story_v_out_425042.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_425042", "425042056", "story_v_out_425042.awb")

						arg_231_1:RecordAudio("425042056", var_234_32)
						arg_231_1:RecordAudio("425042056", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_425042", "425042056", "story_v_out_425042.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_425042", "425042056", "story_v_out_425042.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play425042057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 425042057
		arg_235_1.duration_ = 14.83

		local var_235_0 = {
			zh = 9.066,
			ja = 14.833
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play425042058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.275

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[236].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:GetWordFromCfg(425042057)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 51
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042057", "story_v_out_425042.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042057", "story_v_out_425042.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_425042", "425042057", "story_v_out_425042.awb")

						arg_235_1:RecordAudio("425042057", var_238_9)
						arg_235_1:RecordAudio("425042057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_425042", "425042057", "story_v_out_425042.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_425042", "425042057", "story_v_out_425042.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play425042058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 425042058
		arg_239_1.duration_ = 5.73

		local var_239_0 = {
			zh = 4.166,
			ja = 5.733
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
				arg_239_0:Play425042059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.45

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[236].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(425042058)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042058", "story_v_out_425042.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042058", "story_v_out_425042.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_425042", "425042058", "story_v_out_425042.awb")

						arg_239_1:RecordAudio("425042058", var_242_9)
						arg_239_1:RecordAudio("425042058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_425042", "425042058", "story_v_out_425042.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_425042", "425042058", "story_v_out_425042.awb")
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
	Play425042059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 425042059
		arg_243_1.duration_ = 10.17

		local var_243_0 = {
			zh = 6.1,
			ja = 10.166
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
				arg_243_0:Play425042060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1137"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1137 == nil then
				arg_243_1.var_.actorSpriteComps1137 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1137 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1137 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1137 = nil
			end

			local var_246_8 = arg_243_1.actors_["10127"]
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps10127 == nil then
				arg_243_1.var_.actorSpriteComps10127 = var_246_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_10 = 0.2

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 and not isNil(var_246_8) then
				local var_246_11 = (arg_243_1.time_ - var_246_9) / var_246_10

				if arg_243_1.var_.actorSpriteComps10127 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps10127 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_246_7 then
						if arg_243_1.isInRecall_ then
							iter_246_7.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10127 = nil
			end

			local var_246_16 = arg_243_1.actors_["1137"].transform
			local var_246_17 = 0

			if var_246_17 < arg_243_1.time_ and arg_243_1.time_ <= var_246_17 + arg_246_0 then
				arg_243_1.var_.moveOldPos1137 = var_246_16.localPosition
				var_246_16.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1137", 4)

				local var_246_18 = var_246_16.childCount

				for iter_246_8 = 0, var_246_18 - 1 do
					local var_246_19 = var_246_16:GetChild(iter_246_8)

					if var_246_19.name == "split_4" or not string.find(var_246_19.name, "split") then
						var_246_19.gameObject:SetActive(true)
					else
						var_246_19.gameObject:SetActive(false)
					end
				end
			end

			local var_246_20 = 0.001

			if var_246_17 <= arg_243_1.time_ and arg_243_1.time_ < var_246_17 + var_246_20 then
				local var_246_21 = (arg_243_1.time_ - var_246_17) / var_246_20
				local var_246_22 = Vector3.New(390, -425, -200)

				var_246_16.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1137, var_246_22, var_246_21)
			end

			if arg_243_1.time_ >= var_246_17 + var_246_20 and arg_243_1.time_ < var_246_17 + var_246_20 + arg_246_0 then
				var_246_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_246_23 = 0
			local var_246_24 = 0.55

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_25 = arg_243_1:FormatText(StoryNameCfg[15].name)

				arg_243_1.leftNameTxt_.text = var_246_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_26 = arg_243_1:GetWordFromCfg(425042059)
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042059", "story_v_out_425042.awb") ~= 0 then
					local var_246_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042059", "story_v_out_425042.awb") / 1000

					if var_246_31 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_31 + var_246_23
					end

					if var_246_26.prefab_name ~= "" and arg_243_1.actors_[var_246_26.prefab_name] ~= nil then
						local var_246_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_26.prefab_name].transform, "story_v_out_425042", "425042059", "story_v_out_425042.awb")

						arg_243_1:RecordAudio("425042059", var_246_32)
						arg_243_1:RecordAudio("425042059", var_246_32)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_425042", "425042059", "story_v_out_425042.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_425042", "425042059", "story_v_out_425042.awb")
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play425042060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 425042060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play425042061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1137"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1137 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1137", 7)

				local var_250_2 = var_250_0.childCount

				for iter_250_0 = 0, var_250_2 - 1 do
					local var_250_3 = var_250_0:GetChild(iter_250_0)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_4 then
				local var_250_5 = (arg_247_1.time_ - var_250_1) / var_250_4
				local var_250_6 = Vector3.New(0, -2000, 0)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1137, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_7 = arg_247_1.actors_["10127"].transform
			local var_250_8 = 0

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.var_.moveOldPos10127 = var_250_7.localPosition
				var_250_7.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10127", 7)

				local var_250_9 = var_250_7.childCount

				for iter_250_1 = 0, var_250_9 - 1 do
					local var_250_10 = var_250_7:GetChild(iter_250_1)

					if var_250_10.name == "" or not string.find(var_250_10.name, "split") then
						var_250_10.gameObject:SetActive(true)
					else
						var_250_10.gameObject:SetActive(false)
					end
				end
			end

			local var_250_11 = 0.001

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_11 then
				local var_250_12 = (arg_247_1.time_ - var_250_8) / var_250_11
				local var_250_13 = Vector3.New(0, -2000, 0)

				var_250_7.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10127, var_250_13, var_250_12)
			end

			if arg_247_1.time_ >= var_250_8 + var_250_11 and arg_247_1.time_ < var_250_8 + var_250_11 + arg_250_0 then
				var_250_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_14 = 0
			local var_250_15 = 0.825

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_16 = arg_247_1:GetWordFromCfg(425042060)
				local var_250_17 = arg_247_1:FormatText(var_250_16.content)

				arg_247_1.text_.text = var_250_17

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_18 = 33
				local var_250_19 = utf8.len(var_250_17)
				local var_250_20 = var_250_18 <= 0 and var_250_15 or var_250_15 * (var_250_19 / var_250_18)

				if var_250_20 > 0 and var_250_15 < var_250_20 then
					arg_247_1.talkMaxDuration = var_250_20

					if var_250_20 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_20 + var_250_14
					end
				end

				arg_247_1.text_.text = var_250_17
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_21 = math.max(var_250_15, arg_247_1.talkMaxDuration)

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_21 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_14) / var_250_21

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_14 + var_250_21 and arg_247_1.time_ < var_250_14 + var_250_21 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play425042061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 425042061
		arg_251_1.duration_ = 14.07

		local var_251_0 = {
			zh = 7.966,
			ja = 14.066
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
				arg_251_0:Play425042062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10127"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10127 == nil then
				arg_251_1.var_.actorSpriteComps10127 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10127 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10127 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10127 = nil
			end

			local var_254_8 = arg_251_1.actors_["10127"].transform
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				arg_251_1.var_.moveOldPos10127 = var_254_8.localPosition
				var_254_8.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10127", 2)

				local var_254_10 = var_254_8.childCount

				for iter_254_4 = 0, var_254_10 - 1 do
					local var_254_11 = var_254_8:GetChild(iter_254_4)

					if var_254_11.name == "split_2" or not string.find(var_254_11.name, "split") then
						var_254_11.gameObject:SetActive(true)
					else
						var_254_11.gameObject:SetActive(false)
					end
				end
			end

			local var_254_12 = 0.001

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_12 then
				local var_254_13 = (arg_251_1.time_ - var_254_9) / var_254_12
				local var_254_14 = Vector3.New(-390, -387.4, -316.5)

				var_254_8.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10127, var_254_14, var_254_13)
			end

			if arg_251_1.time_ >= var_254_9 + var_254_12 and arg_251_1.time_ < var_254_9 + var_254_12 + arg_254_0 then
				var_254_8.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_254_15 = 0
			local var_254_16 = 1.075

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[236].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(425042061)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 43
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_16 or var_254_16 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_16 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042061", "story_v_out_425042.awb") ~= 0 then
					local var_254_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042061", "story_v_out_425042.awb") / 1000

					if var_254_23 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_23 + var_254_15
					end

					if var_254_18.prefab_name ~= "" and arg_251_1.actors_[var_254_18.prefab_name] ~= nil then
						local var_254_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_18.prefab_name].transform, "story_v_out_425042", "425042061", "story_v_out_425042.awb")

						arg_251_1:RecordAudio("425042061", var_254_24)
						arg_251_1:RecordAudio("425042061", var_254_24)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_425042", "425042061", "story_v_out_425042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_425042", "425042061", "story_v_out_425042.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_25 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_25 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_25

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_25 and arg_251_1.time_ < var_254_15 + var_254_25 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play425042062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 425042062
		arg_255_1.duration_ = 2.53

		local var_255_0 = {
			zh = 2.466,
			ja = 2.533
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
				arg_255_0:Play425042063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1137"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1137 == nil then
				arg_255_1.var_.actorSpriteComps1137 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps1137 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1137 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1137 = nil
			end

			local var_258_8 = arg_255_1.actors_["10127"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps10127 == nil then
				arg_255_1.var_.actorSpriteComps10127 = var_258_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_10 = 0.2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.actorSpriteComps10127 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								local var_258_12 = Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, var_258_11)
								local var_258_13 = Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, var_258_11)
								local var_258_14 = Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, var_258_11)

								iter_258_5.color = Color.New(var_258_12, var_258_13, var_258_14)
							else
								local var_258_15 = Mathf.Lerp(iter_258_5.color.r, 0.5, var_258_11)

								iter_258_5.color = Color.New(var_258_15, var_258_15, var_258_15)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps10127 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10127 = nil
			end

			local var_258_16 = arg_255_1.actors_["1137"].transform
			local var_258_17 = 0

			if var_258_17 < arg_255_1.time_ and arg_255_1.time_ <= var_258_17 + arg_258_0 then
				arg_255_1.var_.moveOldPos1137 = var_258_16.localPosition
				var_258_16.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1137", 4)

				local var_258_18 = var_258_16.childCount

				for iter_258_8 = 0, var_258_18 - 1 do
					local var_258_19 = var_258_16:GetChild(iter_258_8)

					if var_258_19.name == "split_5" or not string.find(var_258_19.name, "split") then
						var_258_19.gameObject:SetActive(true)
					else
						var_258_19.gameObject:SetActive(false)
					end
				end
			end

			local var_258_20 = 0.001

			if var_258_17 <= arg_255_1.time_ and arg_255_1.time_ < var_258_17 + var_258_20 then
				local var_258_21 = (arg_255_1.time_ - var_258_17) / var_258_20
				local var_258_22 = Vector3.New(390, -425, -200)

				var_258_16.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1137, var_258_22, var_258_21)
			end

			if arg_255_1.time_ >= var_258_17 + var_258_20 and arg_255_1.time_ < var_258_17 + var_258_20 + arg_258_0 then
				var_258_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_258_23 = 0
			local var_258_24 = 0.175

			if var_258_23 < arg_255_1.time_ and arg_255_1.time_ <= var_258_23 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_25 = arg_255_1:FormatText(StoryNameCfg[15].name)

				arg_255_1.leftNameTxt_.text = var_258_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_26 = arg_255_1:GetWordFromCfg(425042062)
				local var_258_27 = arg_255_1:FormatText(var_258_26.content)

				arg_255_1.text_.text = var_258_27

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_28 = 7
				local var_258_29 = utf8.len(var_258_27)
				local var_258_30 = var_258_28 <= 0 and var_258_24 or var_258_24 * (var_258_29 / var_258_28)

				if var_258_30 > 0 and var_258_24 < var_258_30 then
					arg_255_1.talkMaxDuration = var_258_30

					if var_258_30 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_30 + var_258_23
					end
				end

				arg_255_1.text_.text = var_258_27
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042062", "story_v_out_425042.awb") ~= 0 then
					local var_258_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042062", "story_v_out_425042.awb") / 1000

					if var_258_31 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_31 + var_258_23
					end

					if var_258_26.prefab_name ~= "" and arg_255_1.actors_[var_258_26.prefab_name] ~= nil then
						local var_258_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_26.prefab_name].transform, "story_v_out_425042", "425042062", "story_v_out_425042.awb")

						arg_255_1:RecordAudio("425042062", var_258_32)
						arg_255_1:RecordAudio("425042062", var_258_32)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_425042", "425042062", "story_v_out_425042.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_425042", "425042062", "story_v_out_425042.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_33 = math.max(var_258_24, arg_255_1.talkMaxDuration)

			if var_258_23 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_33 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_23) / var_258_33

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_23 + var_258_33 and arg_255_1.time_ < var_258_23 + var_258_33 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play425042063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 425042063
		arg_259_1.duration_ = 11.27

		local var_259_0 = {
			zh = 6.266,
			ja = 11.266
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
				arg_259_0:Play425042064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10127"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10127 == nil then
				arg_259_1.var_.actorSpriteComps10127 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10127 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10127 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10127 = nil
			end

			local var_262_8 = arg_259_1.actors_["1137"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1137 == nil then
				arg_259_1.var_.actorSpriteComps1137 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps1137 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1137 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1137 = nil
			end

			local var_262_16 = 0
			local var_262_17 = 0.9

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_18 = arg_259_1:FormatText(StoryNameCfg[236].name)

				arg_259_1.leftNameTxt_.text = var_262_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_19 = arg_259_1:GetWordFromCfg(425042063)
				local var_262_20 = arg_259_1:FormatText(var_262_19.content)

				arg_259_1.text_.text = var_262_20

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_21 = 36
				local var_262_22 = utf8.len(var_262_20)
				local var_262_23 = var_262_21 <= 0 and var_262_17 or var_262_17 * (var_262_22 / var_262_21)

				if var_262_23 > 0 and var_262_17 < var_262_23 then
					arg_259_1.talkMaxDuration = var_262_23

					if var_262_23 + var_262_16 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_16
					end
				end

				arg_259_1.text_.text = var_262_20
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042063", "story_v_out_425042.awb") ~= 0 then
					local var_262_24 = manager.audio:GetVoiceLength("story_v_out_425042", "425042063", "story_v_out_425042.awb") / 1000

					if var_262_24 + var_262_16 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_24 + var_262_16
					end

					if var_262_19.prefab_name ~= "" and arg_259_1.actors_[var_262_19.prefab_name] ~= nil then
						local var_262_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_19.prefab_name].transform, "story_v_out_425042", "425042063", "story_v_out_425042.awb")

						arg_259_1:RecordAudio("425042063", var_262_25)
						arg_259_1:RecordAudio("425042063", var_262_25)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_425042", "425042063", "story_v_out_425042.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_425042", "425042063", "story_v_out_425042.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_26 = math.max(var_262_17, arg_259_1.talkMaxDuration)

			if var_262_16 <= arg_259_1.time_ and arg_259_1.time_ < var_262_16 + var_262_26 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_16) / var_262_26

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_16 + var_262_26 and arg_259_1.time_ < var_262_16 + var_262_26 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play425042064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 425042064
		arg_263_1.duration_ = 12.97

		local var_263_0 = {
			zh = 12.966,
			ja = 12.266
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
				arg_263_0:Play425042065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10127"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos10127 = var_266_0.localPosition
				var_266_0.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10127", 2)

				local var_266_2 = var_266_0.childCount

				for iter_266_0 = 0, var_266_2 - 1 do
					local var_266_3 = var_266_0:GetChild(iter_266_0)

					if var_266_3.name == "split_6" then
						var_266_3:SetAsLastSibling()
						var_266_3.gameObject:SetActive(true)

						arg_263_1.var_.actorSpriteSplit10127 = var_266_3.gameObject:GetComponent(typeof(Image))

						arg_263_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_266_4 = 0.5

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_4 then
				local var_266_5 = (arg_263_1.time_ - var_266_1) / var_266_4
				local var_266_6 = Vector3.New(-390, -387.4, -316.5)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10127, var_266_6, var_266_5)

				if arg_263_1.var_.actorSpriteSplit10127 ~= nil then
					arg_263_1.var_.actorSpriteSplit10127:SetAlpha(var_266_5)
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_4 and arg_263_1.time_ < var_266_1 + var_266_4 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_263_1.var_.actorSpriteSplit10127 ~= nil then
					arg_263_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_266_7 = 0
			local var_266_8 = 1.35

			if var_266_7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_9 = arg_263_1:FormatText(StoryNameCfg[236].name)

				arg_263_1.leftNameTxt_.text = var_266_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:GetWordFromCfg(425042064)
				local var_266_11 = arg_263_1:FormatText(var_266_10.content)

				arg_263_1.text_.text = var_266_11

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_12 = 54
				local var_266_13 = utf8.len(var_266_11)
				local var_266_14 = var_266_12 <= 0 and var_266_8 or var_266_8 * (var_266_13 / var_266_12)

				if var_266_14 > 0 and var_266_8 < var_266_14 then
					arg_263_1.talkMaxDuration = var_266_14

					if var_266_14 + var_266_7 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_14 + var_266_7
					end
				end

				arg_263_1.text_.text = var_266_11
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042064", "story_v_out_425042.awb") ~= 0 then
					local var_266_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042064", "story_v_out_425042.awb") / 1000

					if var_266_15 + var_266_7 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_7
					end

					if var_266_10.prefab_name ~= "" and arg_263_1.actors_[var_266_10.prefab_name] ~= nil then
						local var_266_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_10.prefab_name].transform, "story_v_out_425042", "425042064", "story_v_out_425042.awb")

						arg_263_1:RecordAudio("425042064", var_266_16)
						arg_263_1:RecordAudio("425042064", var_266_16)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_425042", "425042064", "story_v_out_425042.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_425042", "425042064", "story_v_out_425042.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_17 = math.max(var_266_8, arg_263_1.talkMaxDuration)

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_17 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_7) / var_266_17

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_7 + var_266_17 and arg_263_1.time_ < var_266_7 + var_266_17 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play425042065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 425042065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play425042066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1137"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1137 = var_270_0.localPosition
				var_270_0.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1137", 7)

				local var_270_2 = var_270_0.childCount

				for iter_270_0 = 0, var_270_2 - 1 do
					local var_270_3 = var_270_0:GetChild(iter_270_0)

					if var_270_3.name == "" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_4 then
				local var_270_5 = (arg_267_1.time_ - var_270_1) / var_270_4
				local var_270_6 = Vector3.New(0, -2000, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1137, var_270_6, var_270_5)
			end

			if arg_267_1.time_ >= var_270_1 + var_270_4 and arg_267_1.time_ < var_270_1 + var_270_4 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_7 = arg_267_1.actors_["10127"].transform
			local var_270_8 = 0

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.var_.moveOldPos10127 = var_270_7.localPosition
				var_270_7.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10127", 7)

				local var_270_9 = var_270_7.childCount

				for iter_270_1 = 0, var_270_9 - 1 do
					local var_270_10 = var_270_7:GetChild(iter_270_1)

					if var_270_10.name == "" or not string.find(var_270_10.name, "split") then
						var_270_10.gameObject:SetActive(true)
					else
						var_270_10.gameObject:SetActive(false)
					end
				end
			end

			local var_270_11 = 0.001

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_11 then
				local var_270_12 = (arg_267_1.time_ - var_270_8) / var_270_11
				local var_270_13 = Vector3.New(0, -2000, 0)

				var_270_7.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10127, var_270_13, var_270_12)
			end

			if arg_267_1.time_ >= var_270_8 + var_270_11 and arg_267_1.time_ < var_270_8 + var_270_11 + arg_270_0 then
				var_270_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_14 = 0
			local var_270_15 = 1.225

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_16 = arg_267_1:GetWordFromCfg(425042065)
				local var_270_17 = arg_267_1:FormatText(var_270_16.content)

				arg_267_1.text_.text = var_270_17

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_18 = 49
				local var_270_19 = utf8.len(var_270_17)
				local var_270_20 = var_270_18 <= 0 and var_270_15 or var_270_15 * (var_270_19 / var_270_18)

				if var_270_20 > 0 and var_270_15 < var_270_20 then
					arg_267_1.talkMaxDuration = var_270_20

					if var_270_20 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_14
					end
				end

				arg_267_1.text_.text = var_270_17
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_21 = math.max(var_270_15, arg_267_1.talkMaxDuration)

			if var_270_14 <= arg_267_1.time_ and arg_267_1.time_ < var_270_14 + var_270_21 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_14) / var_270_21

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_14 + var_270_21 and arg_267_1.time_ < var_270_14 + var_270_21 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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
				actorName = "10127",
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
	Play425042066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425042066
		arg_271_1.duration_ = 10.57

		local var_271_0 = {
			zh = 3.8,
			ja = 10.566
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
				arg_271_0:Play425042067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1137"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1137 == nil then
				arg_271_1.var_.actorSpriteComps1137 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1137 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1137 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1137 = nil
			end

			local var_274_8 = arg_271_1.actors_["1137"].transform
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.var_.moveOldPos1137 = var_274_8.localPosition
				var_274_8.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1137", 4)

				local var_274_10 = var_274_8.childCount

				for iter_274_4 = 0, var_274_10 - 1 do
					local var_274_11 = var_274_8:GetChild(iter_274_4)

					if var_274_11.name == "split_6" or not string.find(var_274_11.name, "split") then
						var_274_11.gameObject:SetActive(true)
					else
						var_274_11.gameObject:SetActive(false)
					end
				end
			end

			local var_274_12 = 0.001

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_12 then
				local var_274_13 = (arg_271_1.time_ - var_274_9) / var_274_12
				local var_274_14 = Vector3.New(390, -425, -200)

				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1137, var_274_14, var_274_13)
			end

			if arg_271_1.time_ >= var_274_9 + var_274_12 and arg_271_1.time_ < var_274_9 + var_274_12 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(390, -425, -200)
			end

			local var_274_15 = 0
			local var_274_16 = 0.35

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[15].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(425042066)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042066", "story_v_out_425042.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042066", "story_v_out_425042.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_425042", "425042066", "story_v_out_425042.awb")

						arg_271_1:RecordAudio("425042066", var_274_24)
						arg_271_1:RecordAudio("425042066", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_425042", "425042066", "story_v_out_425042.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_425042", "425042066", "story_v_out_425042.awb")
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play425042067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425042067
		arg_275_1.duration_ = 3.17

		local var_275_0 = {
			zh = 2.9,
			ja = 3.166
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
				arg_275_0:Play425042068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10127"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10127 == nil then
				arg_275_1.var_.actorSpriteComps10127 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10127 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10127 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10127 = nil
			end

			local var_278_8 = arg_275_1.actors_["1137"]
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1137 == nil then
				arg_275_1.var_.actorSpriteComps1137 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_10 = 0.2

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 and not isNil(var_278_8) then
				local var_278_11 = (arg_275_1.time_ - var_278_9) / var_278_10

				if arg_275_1.var_.actorSpriteComps1137 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								local var_278_12 = Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, var_278_11)
								local var_278_13 = Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, var_278_11)
								local var_278_14 = Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, var_278_11)

								iter_278_5.color = Color.New(var_278_12, var_278_13, var_278_14)
							else
								local var_278_15 = Mathf.Lerp(iter_278_5.color.r, 0.5, var_278_11)

								iter_278_5.color = Color.New(var_278_15, var_278_15, var_278_15)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1137 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_278_7 then
						if arg_275_1.isInRecall_ then
							iter_278_7.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1137 = nil
			end

			local var_278_16 = arg_275_1.actors_["10127"].transform
			local var_278_17 = 0

			if var_278_17 < arg_275_1.time_ and arg_275_1.time_ <= var_278_17 + arg_278_0 then
				arg_275_1.var_.moveOldPos10127 = var_278_16.localPosition
				var_278_16.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10127", 2)

				local var_278_18 = var_278_16.childCount

				for iter_278_8 = 0, var_278_18 - 1 do
					local var_278_19 = var_278_16:GetChild(iter_278_8)

					if var_278_19.name == "split_1" or not string.find(var_278_19.name, "split") then
						var_278_19.gameObject:SetActive(true)
					else
						var_278_19.gameObject:SetActive(false)
					end
				end
			end

			local var_278_20 = 0.001

			if var_278_17 <= arg_275_1.time_ and arg_275_1.time_ < var_278_17 + var_278_20 then
				local var_278_21 = (arg_275_1.time_ - var_278_17) / var_278_20
				local var_278_22 = Vector3.New(-390, -387.4, -316.5)

				var_278_16.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10127, var_278_22, var_278_21)
			end

			if arg_275_1.time_ >= var_278_17 + var_278_20 and arg_275_1.time_ < var_278_17 + var_278_20 + arg_278_0 then
				var_278_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_278_23 = 0
			local var_278_24 = 0.25

			if var_278_23 < arg_275_1.time_ and arg_275_1.time_ <= var_278_23 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_25 = arg_275_1:FormatText(StoryNameCfg[236].name)

				arg_275_1.leftNameTxt_.text = var_278_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_26 = arg_275_1:GetWordFromCfg(425042067)
				local var_278_27 = arg_275_1:FormatText(var_278_26.content)

				arg_275_1.text_.text = var_278_27

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_28 = 10
				local var_278_29 = utf8.len(var_278_27)
				local var_278_30 = var_278_28 <= 0 and var_278_24 or var_278_24 * (var_278_29 / var_278_28)

				if var_278_30 > 0 and var_278_24 < var_278_30 then
					arg_275_1.talkMaxDuration = var_278_30

					if var_278_30 + var_278_23 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_30 + var_278_23
					end
				end

				arg_275_1.text_.text = var_278_27
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042067", "story_v_out_425042.awb") ~= 0 then
					local var_278_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042067", "story_v_out_425042.awb") / 1000

					if var_278_31 + var_278_23 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_31 + var_278_23
					end

					if var_278_26.prefab_name ~= "" and arg_275_1.actors_[var_278_26.prefab_name] ~= nil then
						local var_278_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_26.prefab_name].transform, "story_v_out_425042", "425042067", "story_v_out_425042.awb")

						arg_275_1:RecordAudio("425042067", var_278_32)
						arg_275_1:RecordAudio("425042067", var_278_32)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_425042", "425042067", "story_v_out_425042.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_425042", "425042067", "story_v_out_425042.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_33 = math.max(var_278_24, arg_275_1.talkMaxDuration)

			if var_278_23 <= arg_275_1.time_ and arg_275_1.time_ < var_278_23 + var_278_33 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_23) / var_278_33

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_23 + var_278_33 and arg_275_1.time_ < var_278_23 + var_278_33 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play425042068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 425042068
		arg_279_1.duration_ = 16.23

		local var_279_0 = {
			zh = 10.633,
			ja = 16.233
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
				arg_279_0:Play425042069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 1.4

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_2 = arg_279_1:FormatText(StoryNameCfg[236].name)

				arg_279_1.leftNameTxt_.text = var_282_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:GetWordFromCfg(425042068)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042068", "story_v_out_425042.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042068", "story_v_out_425042.awb") / 1000

					if var_282_8 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_0
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_425042", "425042068", "story_v_out_425042.awb")

						arg_279_1:RecordAudio("425042068", var_282_9)
						arg_279_1:RecordAudio("425042068", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_425042", "425042068", "story_v_out_425042.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_425042", "425042068", "story_v_out_425042.awb")
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
	Play425042069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 425042069
		arg_283_1.duration_ = 9.37

		local var_283_0 = {
			zh = 9.366,
			ja = 8.666
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
				arg_283_0:Play425042070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 1.275

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[236].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(425042069)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 51
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042069", "story_v_out_425042.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042069", "story_v_out_425042.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_425042", "425042069", "story_v_out_425042.awb")

						arg_283_1:RecordAudio("425042069", var_286_9)
						arg_283_1:RecordAudio("425042069", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_425042", "425042069", "story_v_out_425042.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_425042", "425042069", "story_v_out_425042.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play425042070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 425042070
		arg_287_1.duration_ = 3.7

		local var_287_0 = {
			zh = 3.633,
			ja = 3.7
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
				arg_287_0:Play425042071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10127"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10127 = var_290_0.localPosition
				var_290_0.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10127", 2)

				local var_290_2 = var_290_0.childCount

				for iter_290_0 = 0, var_290_2 - 1 do
					local var_290_3 = var_290_0:GetChild(iter_290_0)

					if var_290_3.name == "split_6" then
						var_290_3:SetAsLastSibling()
						var_290_3.gameObject:SetActive(true)

						arg_287_1.var_.actorSpriteSplit10127 = var_290_3.gameObject:GetComponent(typeof(Image))

						arg_287_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_290_4 = 0.5

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_4 then
				local var_290_5 = (arg_287_1.time_ - var_290_1) / var_290_4
				local var_290_6 = Vector3.New(-390, -387.4, -316.5)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10127, var_290_6, var_290_5)

				if arg_287_1.var_.actorSpriteSplit10127 ~= nil then
					arg_287_1.var_.actorSpriteSplit10127:SetAlpha(var_290_5)
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_4 and arg_287_1.time_ < var_290_1 + var_290_4 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_287_1.var_.actorSpriteSplit10127 ~= nil then
					arg_287_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_290_7 = 0
			local var_290_8 = 0.475

			if var_290_7 < arg_287_1.time_ and arg_287_1.time_ <= var_290_7 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_9 = arg_287_1:FormatText(StoryNameCfg[236].name)

				arg_287_1.leftNameTxt_.text = var_290_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:GetWordFromCfg(425042070)
				local var_290_11 = arg_287_1:FormatText(var_290_10.content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_12 = 19
				local var_290_13 = utf8.len(var_290_11)
				local var_290_14 = var_290_12 <= 0 and var_290_8 or var_290_8 * (var_290_13 / var_290_12)

				if var_290_14 > 0 and var_290_8 < var_290_14 then
					arg_287_1.talkMaxDuration = var_290_14

					if var_290_14 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_7
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042070", "story_v_out_425042.awb") ~= 0 then
					local var_290_15 = manager.audio:GetVoiceLength("story_v_out_425042", "425042070", "story_v_out_425042.awb") / 1000

					if var_290_15 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_15 + var_290_7
					end

					if var_290_10.prefab_name ~= "" and arg_287_1.actors_[var_290_10.prefab_name] ~= nil then
						local var_290_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_10.prefab_name].transform, "story_v_out_425042", "425042070", "story_v_out_425042.awb")

						arg_287_1:RecordAudio("425042070", var_290_16)
						arg_287_1:RecordAudio("425042070", var_290_16)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_425042", "425042070", "story_v_out_425042.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_425042", "425042070", "story_v_out_425042.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_17 = math.max(var_290_8, arg_287_1.talkMaxDuration)

			if var_290_7 <= arg_287_1.time_ and arg_287_1.time_ < var_290_7 + var_290_17 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_7) / var_290_17

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_7 + var_290_17 and arg_287_1.time_ < var_290_7 + var_290_17 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play425042071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 425042071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play425042072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10127"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10127 == nil then
				arg_291_1.var_.actorSpriteComps10127 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps10127 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10127 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10127 = nil
			end

			local var_294_8 = arg_291_1.actors_["1137"].transform
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.var_.moveOldPos1137 = var_294_8.localPosition
				var_294_8.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1137", 7)

				local var_294_10 = var_294_8.childCount

				for iter_294_4 = 0, var_294_10 - 1 do
					local var_294_11 = var_294_8:GetChild(iter_294_4)

					if var_294_11.name == "" or not string.find(var_294_11.name, "split") then
						var_294_11.gameObject:SetActive(true)
					else
						var_294_11.gameObject:SetActive(false)
					end
				end
			end

			local var_294_12 = 0.001

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_9) / var_294_12
				local var_294_14 = Vector3.New(0, -2000, 0)

				var_294_8.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1137, var_294_14, var_294_13)
			end

			if arg_291_1.time_ >= var_294_9 + var_294_12 and arg_291_1.time_ < var_294_9 + var_294_12 + arg_294_0 then
				var_294_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_15 = arg_291_1.actors_["10127"].transform
			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.var_.moveOldPos10127 = var_294_15.localPosition
				var_294_15.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10127", 7)

				local var_294_17 = var_294_15.childCount

				for iter_294_5 = 0, var_294_17 - 1 do
					local var_294_18 = var_294_15:GetChild(iter_294_5)

					if var_294_18.name == "split_6" or not string.find(var_294_18.name, "split") then
						var_294_18.gameObject:SetActive(true)
					else
						var_294_18.gameObject:SetActive(false)
					end
				end
			end

			local var_294_19 = 0.001

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_19 then
				local var_294_20 = (arg_291_1.time_ - var_294_16) / var_294_19
				local var_294_21 = Vector3.New(0, -2000, 0)

				var_294_15.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10127, var_294_21, var_294_20)
			end

			if arg_291_1.time_ >= var_294_16 + var_294_19 and arg_291_1.time_ < var_294_16 + var_294_19 + arg_294_0 then
				var_294_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_22 = 0
			local var_294_23 = 0.6

			if var_294_22 < arg_291_1.time_ and arg_291_1.time_ <= var_294_22 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_24 = arg_291_1:GetWordFromCfg(425042071)
				local var_294_25 = arg_291_1:FormatText(var_294_24.content)

				arg_291_1.text_.text = var_294_25

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_26 = 24
				local var_294_27 = utf8.len(var_294_25)
				local var_294_28 = var_294_26 <= 0 and var_294_23 or var_294_23 * (var_294_27 / var_294_26)

				if var_294_28 > 0 and var_294_23 < var_294_28 then
					arg_291_1.talkMaxDuration = var_294_28

					if var_294_28 + var_294_22 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_28 + var_294_22
					end
				end

				arg_291_1.text_.text = var_294_25
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_29 = math.max(var_294_23, arg_291_1.talkMaxDuration)

			if var_294_22 <= arg_291_1.time_ and arg_291_1.time_ < var_294_22 + var_294_29 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_22) / var_294_29

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_22 + var_294_29 and arg_291_1.time_ < var_294_22 + var_294_29 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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
				actorName = "10127",
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
	Play425042072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 425042072
		arg_295_1.duration_ = 12.57

		local var_295_0 = {
			zh = 8.166,
			ja = 12.566
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
				arg_295_0:Play425042073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10127"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10127 == nil then
				arg_295_1.var_.actorSpriteComps10127 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10127 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10127 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10127 = nil
			end

			local var_298_8 = arg_295_1.actors_["10127"].transform
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.var_.moveOldPos10127 = var_298_8.localPosition
				var_298_8.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10127", 3)

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
				local var_298_14 = Vector3.New(0, -387.4, -316.5)

				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10127, var_298_14, var_298_13)
			end

			if arg_295_1.time_ >= var_298_9 + var_298_12 and arg_295_1.time_ < var_298_9 + var_298_12 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_298_15 = 0
			local var_298_16 = 1.025

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_17 = arg_295_1:FormatText(StoryNameCfg[236].name)

				arg_295_1.leftNameTxt_.text = var_298_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:GetWordFromCfg(425042072)
				local var_298_19 = arg_295_1:FormatText(var_298_18.content)

				arg_295_1.text_.text = var_298_19

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042072", "story_v_out_425042.awb") ~= 0 then
					local var_298_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042072", "story_v_out_425042.awb") / 1000

					if var_298_23 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_15
					end

					if var_298_18.prefab_name ~= "" and arg_295_1.actors_[var_298_18.prefab_name] ~= nil then
						local var_298_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_18.prefab_name].transform, "story_v_out_425042", "425042072", "story_v_out_425042.awb")

						arg_295_1:RecordAudio("425042072", var_298_24)
						arg_295_1:RecordAudio("425042072", var_298_24)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_425042", "425042072", "story_v_out_425042.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_425042", "425042072", "story_v_out_425042.awb")
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
				actorName = "10127",
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
	Play425042073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425042073
		arg_299_1.duration_ = 16.73

		local var_299_0 = {
			zh = 11.6,
			ja = 16.733
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
				arg_299_0:Play425042074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 1.4

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[236].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(425042073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 56
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042073", "story_v_out_425042.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042073", "story_v_out_425042.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_425042", "425042073", "story_v_out_425042.awb")

						arg_299_1:RecordAudio("425042073", var_302_9)
						arg_299_1:RecordAudio("425042073", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_425042", "425042073", "story_v_out_425042.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_425042", "425042073", "story_v_out_425042.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425042074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425042074
		arg_303_1.duration_ = 13.7

		local var_303_0 = {
			zh = 11.033,
			ja = 13.7
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
				arg_303_0:Play425042075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 1.45

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[236].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(425042074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 58
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042074", "story_v_out_425042.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042074", "story_v_out_425042.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_425042", "425042074", "story_v_out_425042.awb")

						arg_303_1:RecordAudio("425042074", var_306_9)
						arg_303_1:RecordAudio("425042074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_425042", "425042074", "story_v_out_425042.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_425042", "425042074", "story_v_out_425042.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play425042075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425042075
		arg_307_1.duration_ = 2.07

		local var_307_0 = {
			zh = 2.066,
			ja = 2
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
				arg_307_0:Play425042076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1137"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1137 == nil then
				arg_307_1.var_.actorSpriteComps1137 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps1137 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								local var_310_4 = Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor1.r, var_310_3)
								local var_310_5 = Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor1.g, var_310_3)
								local var_310_6 = Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor1.b, var_310_3)

								iter_310_1.color = Color.New(var_310_4, var_310_5, var_310_6)
							else
								local var_310_7 = Mathf.Lerp(iter_310_1.color.r, 1, var_310_3)

								iter_310_1.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1137 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1137 = nil
			end

			local var_310_8 = arg_307_1.actors_["10127"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10127 == nil then
				arg_307_1.var_.actorSpriteComps10127 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 0.2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps10127 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								local var_310_12 = Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor2.r, var_310_11)
								local var_310_13 = Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor2.g, var_310_11)
								local var_310_14 = Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor2.b, var_310_11)

								iter_310_5.color = Color.New(var_310_12, var_310_13, var_310_14)
							else
								local var_310_15 = Mathf.Lerp(iter_310_5.color.r, 0.5, var_310_11)

								iter_310_5.color = Color.New(var_310_15, var_310_15, var_310_15)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10127 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10127 = nil
			end

			local var_310_16 = arg_307_1.actors_["10127"].transform
			local var_310_17 = 0

			if var_310_17 < arg_307_1.time_ and arg_307_1.time_ <= var_310_17 + arg_310_0 then
				arg_307_1.var_.moveOldPos10127 = var_310_16.localPosition
				var_310_16.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10127", 2)

				local var_310_18 = var_310_16.childCount

				for iter_310_8 = 0, var_310_18 - 1 do
					local var_310_19 = var_310_16:GetChild(iter_310_8)

					if var_310_19.name == "split_6" or not string.find(var_310_19.name, "split") then
						var_310_19.gameObject:SetActive(true)
					else
						var_310_19.gameObject:SetActive(false)
					end
				end
			end

			local var_310_20 = 0.001

			if var_310_17 <= arg_307_1.time_ and arg_307_1.time_ < var_310_17 + var_310_20 then
				local var_310_21 = (arg_307_1.time_ - var_310_17) / var_310_20
				local var_310_22 = Vector3.New(-390, -387.4, -316.5)

				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10127, var_310_22, var_310_21)
			end

			if arg_307_1.time_ >= var_310_17 + var_310_20 and arg_307_1.time_ < var_310_17 + var_310_20 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_310_23 = arg_307_1.actors_["1137"].transform
			local var_310_24 = 0

			if var_310_24 < arg_307_1.time_ and arg_307_1.time_ <= var_310_24 + arg_310_0 then
				arg_307_1.var_.moveOldPos1137 = var_310_23.localPosition
				var_310_23.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1137", 4)

				local var_310_25 = var_310_23.childCount

				for iter_310_9 = 0, var_310_25 - 1 do
					local var_310_26 = var_310_23:GetChild(iter_310_9)

					if var_310_26.name == "split_4" or not string.find(var_310_26.name, "split") then
						var_310_26.gameObject:SetActive(true)
					else
						var_310_26.gameObject:SetActive(false)
					end
				end
			end

			local var_310_27 = 0.001

			if var_310_24 <= arg_307_1.time_ and arg_307_1.time_ < var_310_24 + var_310_27 then
				local var_310_28 = (arg_307_1.time_ - var_310_24) / var_310_27
				local var_310_29 = Vector3.New(390, -425, -200)

				var_310_23.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1137, var_310_29, var_310_28)
			end

			if arg_307_1.time_ >= var_310_24 + var_310_27 and arg_307_1.time_ < var_310_24 + var_310_27 + arg_310_0 then
				var_310_23.localPosition = Vector3.New(390, -425, -200)
			end

			local var_310_30 = 0
			local var_310_31 = 0.05

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_32 = arg_307_1:FormatText(StoryNameCfg[15].name)

				arg_307_1.leftNameTxt_.text = var_310_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_33 = arg_307_1:GetWordFromCfg(425042075)
				local var_310_34 = arg_307_1:FormatText(var_310_33.content)

				arg_307_1.text_.text = var_310_34

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_35 = 2
				local var_310_36 = utf8.len(var_310_34)
				local var_310_37 = var_310_35 <= 0 and var_310_31 or var_310_31 * (var_310_36 / var_310_35)

				if var_310_37 > 0 and var_310_31 < var_310_37 then
					arg_307_1.talkMaxDuration = var_310_37

					if var_310_37 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_37 + var_310_30
					end
				end

				arg_307_1.text_.text = var_310_34
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042075", "story_v_out_425042.awb") ~= 0 then
					local var_310_38 = manager.audio:GetVoiceLength("story_v_out_425042", "425042075", "story_v_out_425042.awb") / 1000

					if var_310_38 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_38 + var_310_30
					end

					if var_310_33.prefab_name ~= "" and arg_307_1.actors_[var_310_33.prefab_name] ~= nil then
						local var_310_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_33.prefab_name].transform, "story_v_out_425042", "425042075", "story_v_out_425042.awb")

						arg_307_1:RecordAudio("425042075", var_310_39)
						arg_307_1:RecordAudio("425042075", var_310_39)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_425042", "425042075", "story_v_out_425042.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_425042", "425042075", "story_v_out_425042.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_40 = math.max(var_310_31, arg_307_1.talkMaxDuration)

			if var_310_30 <= arg_307_1.time_ and arg_307_1.time_ < var_310_30 + var_310_40 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_30) / var_310_40

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_30 + var_310_40 and arg_307_1.time_ < var_310_30 + var_310_40 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_307_1:InitPlayNodeList()
	end,
	Play425042076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 425042076
		arg_311_1.duration_ = 7.1

		local var_311_0 = {
			zh = 3.766,
			ja = 7.1
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play425042077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10127"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10127 == nil then
				arg_311_1.var_.actorSpriteComps10127 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps10127 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 1, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10127 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10127 = nil
			end

			local var_314_8 = arg_311_1.actors_["1137"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1137 == nil then
				arg_311_1.var_.actorSpriteComps1137 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps1137 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 0.5, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1137 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1137 = nil
			end

			local var_314_16 = arg_311_1.actors_["10127"].transform
			local var_314_17 = 0

			if var_314_17 < arg_311_1.time_ and arg_311_1.time_ <= var_314_17 + arg_314_0 then
				arg_311_1.var_.moveOldPos10127 = var_314_16.localPosition
				var_314_16.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10127", 2)

				local var_314_18 = var_314_16.childCount

				for iter_314_8 = 0, var_314_18 - 1 do
					local var_314_19 = var_314_16:GetChild(iter_314_8)

					if var_314_19.name == "split_1" then
						var_314_19:SetAsLastSibling()
						var_314_19.gameObject:SetActive(true)

						arg_311_1.var_.actorSpriteSplit10127 = var_314_19.gameObject:GetComponent(typeof(Image))

						arg_311_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_314_20 = 0.5

			if var_314_17 <= arg_311_1.time_ and arg_311_1.time_ < var_314_17 + var_314_20 then
				local var_314_21 = (arg_311_1.time_ - var_314_17) / var_314_20
				local var_314_22 = Vector3.New(-390, -387.4, -316.5)

				var_314_16.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10127, var_314_22, var_314_21)

				if arg_311_1.var_.actorSpriteSplit10127 ~= nil then
					arg_311_1.var_.actorSpriteSplit10127:SetAlpha(var_314_21)
				end
			end

			if arg_311_1.time_ >= var_314_17 + var_314_20 and arg_311_1.time_ < var_314_17 + var_314_20 + arg_314_0 then
				var_314_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_311_1.var_.actorSpriteSplit10127 ~= nil then
					arg_311_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_314_23 = 0
			local var_314_24 = 0.425

			if var_314_23 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_25 = arg_311_1:FormatText(StoryNameCfg[236].name)

				arg_311_1.leftNameTxt_.text = var_314_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_26 = arg_311_1:GetWordFromCfg(425042076)
				local var_314_27 = arg_311_1:FormatText(var_314_26.content)

				arg_311_1.text_.text = var_314_27

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_28 = 17
				local var_314_29 = utf8.len(var_314_27)
				local var_314_30 = var_314_28 <= 0 and var_314_24 or var_314_24 * (var_314_29 / var_314_28)

				if var_314_30 > 0 and var_314_24 < var_314_30 then
					arg_311_1.talkMaxDuration = var_314_30

					if var_314_30 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_30 + var_314_23
					end
				end

				arg_311_1.text_.text = var_314_27
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042076", "story_v_out_425042.awb") ~= 0 then
					local var_314_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042076", "story_v_out_425042.awb") / 1000

					if var_314_31 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_31 + var_314_23
					end

					if var_314_26.prefab_name ~= "" and arg_311_1.actors_[var_314_26.prefab_name] ~= nil then
						local var_314_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_26.prefab_name].transform, "story_v_out_425042", "425042076", "story_v_out_425042.awb")

						arg_311_1:RecordAudio("425042076", var_314_32)
						arg_311_1:RecordAudio("425042076", var_314_32)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_425042", "425042076", "story_v_out_425042.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_425042", "425042076", "story_v_out_425042.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_33 = math.max(var_314_24, arg_311_1.talkMaxDuration)

			if var_314_23 <= arg_311_1.time_ and arg_311_1.time_ < var_314_23 + var_314_33 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_23) / var_314_33

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_23 + var_314_33 and arg_311_1.time_ < var_314_23 + var_314_33 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play425042077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 425042077
		arg_315_1.duration_ = 15.1

		local var_315_0 = {
			zh = 7.7,
			ja = 15.1
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
				arg_315_0:Play425042078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1137"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1137 == nil then
				arg_315_1.var_.actorSpriteComps1137 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1137 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1137 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1137 = nil
			end

			local var_318_8 = arg_315_1.actors_["10127"]
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10127 == nil then
				arg_315_1.var_.actorSpriteComps10127 = var_318_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_10 = 0.2

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_10 and not isNil(var_318_8) then
				local var_318_11 = (arg_315_1.time_ - var_318_9) / var_318_10

				if arg_315_1.var_.actorSpriteComps10127 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								local var_318_12 = Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, var_318_11)
								local var_318_13 = Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, var_318_11)
								local var_318_14 = Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, var_318_11)

								iter_318_5.color = Color.New(var_318_12, var_318_13, var_318_14)
							else
								local var_318_15 = Mathf.Lerp(iter_318_5.color.r, 0.5, var_318_11)

								iter_318_5.color = Color.New(var_318_15, var_318_15, var_318_15)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_9 + var_318_10 and arg_315_1.time_ < var_318_9 + var_318_10 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10127 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_318_7 then
						if arg_315_1.isInRecall_ then
							iter_318_7.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10127 = nil
			end

			local var_318_16 = arg_315_1.actors_["1137"].transform
			local var_318_17 = 0

			if var_318_17 < arg_315_1.time_ and arg_315_1.time_ <= var_318_17 + arg_318_0 then
				arg_315_1.var_.moveOldPos1137 = var_318_16.localPosition
				var_318_16.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1137", 4)

				local var_318_18 = var_318_16.childCount

				for iter_318_8 = 0, var_318_18 - 1 do
					local var_318_19 = var_318_16:GetChild(iter_318_8)

					if var_318_19.name == "split_4" or not string.find(var_318_19.name, "split") then
						var_318_19.gameObject:SetActive(true)
					else
						var_318_19.gameObject:SetActive(false)
					end
				end
			end

			local var_318_20 = 0.001

			if var_318_17 <= arg_315_1.time_ and arg_315_1.time_ < var_318_17 + var_318_20 then
				local var_318_21 = (arg_315_1.time_ - var_318_17) / var_318_20
				local var_318_22 = Vector3.New(390, -425, -200)

				var_318_16.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1137, var_318_22, var_318_21)
			end

			if arg_315_1.time_ >= var_318_17 + var_318_20 and arg_315_1.time_ < var_318_17 + var_318_20 + arg_318_0 then
				var_318_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_318_23 = 0
			local var_318_24 = 0.875

			if var_318_23 < arg_315_1.time_ and arg_315_1.time_ <= var_318_23 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_25 = arg_315_1:FormatText(StoryNameCfg[15].name)

				arg_315_1.leftNameTxt_.text = var_318_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_26 = arg_315_1:GetWordFromCfg(425042077)
				local var_318_27 = arg_315_1:FormatText(var_318_26.content)

				arg_315_1.text_.text = var_318_27

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_28 = 33
				local var_318_29 = utf8.len(var_318_27)
				local var_318_30 = var_318_28 <= 0 and var_318_24 or var_318_24 * (var_318_29 / var_318_28)

				if var_318_30 > 0 and var_318_24 < var_318_30 then
					arg_315_1.talkMaxDuration = var_318_30

					if var_318_30 + var_318_23 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_30 + var_318_23
					end
				end

				arg_315_1.text_.text = var_318_27
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042077", "story_v_out_425042.awb") ~= 0 then
					local var_318_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042077", "story_v_out_425042.awb") / 1000

					if var_318_31 + var_318_23 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_31 + var_318_23
					end

					if var_318_26.prefab_name ~= "" and arg_315_1.actors_[var_318_26.prefab_name] ~= nil then
						local var_318_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_26.prefab_name].transform, "story_v_out_425042", "425042077", "story_v_out_425042.awb")

						arg_315_1:RecordAudio("425042077", var_318_32)
						arg_315_1:RecordAudio("425042077", var_318_32)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_425042", "425042077", "story_v_out_425042.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_425042", "425042077", "story_v_out_425042.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_33 = math.max(var_318_24, arg_315_1.talkMaxDuration)

			if var_318_23 <= arg_315_1.time_ and arg_315_1.time_ < var_318_23 + var_318_33 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_23) / var_318_33

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_23 + var_318_33 and arg_315_1.time_ < var_318_23 + var_318_33 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play425042078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 425042078
		arg_319_1.duration_ = 6.97

		local var_319_0 = {
			zh = 4.7,
			ja = 6.966
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
				arg_319_0:Play425042079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.6

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[15].name)

				arg_319_1.leftNameTxt_.text = var_322_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_3 = arg_319_1:GetWordFromCfg(425042078)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042078", "story_v_out_425042.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042078", "story_v_out_425042.awb") / 1000

					if var_322_8 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_0
					end

					if var_322_3.prefab_name ~= "" and arg_319_1.actors_[var_322_3.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_3.prefab_name].transform, "story_v_out_425042", "425042078", "story_v_out_425042.awb")

						arg_319_1:RecordAudio("425042078", var_322_9)
						arg_319_1:RecordAudio("425042078", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_425042", "425042078", "story_v_out_425042.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_425042", "425042078", "story_v_out_425042.awb")
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
	Play425042079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 425042079
		arg_323_1.duration_ = 1.23

		local var_323_0 = {
			zh = 1.233,
			ja = 1.2
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
				arg_323_0:Play425042080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10127"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10127 == nil then
				arg_323_1.var_.actorSpriteComps10127 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10127 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10127 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10127 = nil
			end

			local var_326_8 = arg_323_1.actors_["1137"]
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps1137 == nil then
				arg_323_1.var_.actorSpriteComps1137 = var_326_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_10 = 0.2

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_10 and not isNil(var_326_8) then
				local var_326_11 = (arg_323_1.time_ - var_326_9) / var_326_10

				if arg_323_1.var_.actorSpriteComps1137 then
					for iter_326_4, iter_326_5 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_326_5 then
							if arg_323_1.isInRecall_ then
								local var_326_12 = Mathf.Lerp(iter_326_5.color.r, arg_323_1.hightColor2.r, var_326_11)
								local var_326_13 = Mathf.Lerp(iter_326_5.color.g, arg_323_1.hightColor2.g, var_326_11)
								local var_326_14 = Mathf.Lerp(iter_326_5.color.b, arg_323_1.hightColor2.b, var_326_11)

								iter_326_5.color = Color.New(var_326_12, var_326_13, var_326_14)
							else
								local var_326_15 = Mathf.Lerp(iter_326_5.color.r, 0.5, var_326_11)

								iter_326_5.color = Color.New(var_326_15, var_326_15, var_326_15)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_9 + var_326_10 and arg_323_1.time_ < var_326_9 + var_326_10 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps1137 then
				for iter_326_6, iter_326_7 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_326_7 then
						if arg_323_1.isInRecall_ then
							iter_326_7.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1137 = nil
			end

			local var_326_16 = arg_323_1.actors_["10127"].transform
			local var_326_17 = 0

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1.var_.moveOldPos10127 = var_326_16.localPosition
				var_326_16.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10127", 2)

				local var_326_18 = var_326_16.childCount

				for iter_326_8 = 0, var_326_18 - 1 do
					local var_326_19 = var_326_16:GetChild(iter_326_8)

					if var_326_19.name == "split_5" then
						var_326_19:SetAsLastSibling()
						var_326_19.gameObject:SetActive(true)

						arg_323_1.var_.actorSpriteSplit10127 = var_326_19.gameObject:GetComponent(typeof(Image))

						arg_323_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_326_20 = 0.2

			if var_326_17 <= arg_323_1.time_ and arg_323_1.time_ < var_326_17 + var_326_20 then
				local var_326_21 = (arg_323_1.time_ - var_326_17) / var_326_20
				local var_326_22 = Vector3.New(-390, -387.4, -316.5)

				var_326_16.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10127, var_326_22, var_326_21)

				if arg_323_1.var_.actorSpriteSplit10127 ~= nil then
					arg_323_1.var_.actorSpriteSplit10127:SetAlpha(var_326_21)
				end
			end

			if arg_323_1.time_ >= var_326_17 + var_326_20 and arg_323_1.time_ < var_326_17 + var_326_20 + arg_326_0 then
				var_326_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_323_1.var_.actorSpriteSplit10127 ~= nil then
					arg_323_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_326_23 = 0
			local var_326_24 = 0.05

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_25 = arg_323_1:FormatText(StoryNameCfg[236].name)

				arg_323_1.leftNameTxt_.text = var_326_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_26 = arg_323_1:GetWordFromCfg(425042079)
				local var_326_27 = arg_323_1:FormatText(var_326_26.content)

				arg_323_1.text_.text = var_326_27

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_28 = 2
				local var_326_29 = utf8.len(var_326_27)
				local var_326_30 = var_326_28 <= 0 and var_326_24 or var_326_24 * (var_326_29 / var_326_28)

				if var_326_30 > 0 and var_326_24 < var_326_30 then
					arg_323_1.talkMaxDuration = var_326_30

					if var_326_30 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_23
					end
				end

				arg_323_1.text_.text = var_326_27
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042079", "story_v_out_425042.awb") ~= 0 then
					local var_326_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042079", "story_v_out_425042.awb") / 1000

					if var_326_31 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_31 + var_326_23
					end

					if var_326_26.prefab_name ~= "" and arg_323_1.actors_[var_326_26.prefab_name] ~= nil then
						local var_326_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_26.prefab_name].transform, "story_v_out_425042", "425042079", "story_v_out_425042.awb")

						arg_323_1:RecordAudio("425042079", var_326_32)
						arg_323_1:RecordAudio("425042079", var_326_32)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_425042", "425042079", "story_v_out_425042.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_425042", "425042079", "story_v_out_425042.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_33 = math.max(var_326_24, arg_323_1.talkMaxDuration)

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_33 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_33

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_33 and arg_323_1.time_ < var_326_23 + var_326_33 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play425042080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 425042080
		arg_327_1.duration_ = 10.67

		local var_327_0 = {
			zh = 9.3,
			ja = 10.666
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
				arg_327_0:Play425042081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1137"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps1137 == nil then
				arg_327_1.var_.actorSpriteComps1137 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps1137 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 1, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps1137 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps1137 = nil
			end

			local var_330_8 = arg_327_1.actors_["10127"]
			local var_330_9 = 0

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 and not isNil(var_330_8) and arg_327_1.var_.actorSpriteComps10127 == nil then
				arg_327_1.var_.actorSpriteComps10127 = var_330_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_10 = 0.2

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_10 and not isNil(var_330_8) then
				local var_330_11 = (arg_327_1.time_ - var_330_9) / var_330_10

				if arg_327_1.var_.actorSpriteComps10127 then
					for iter_330_4, iter_330_5 in pairs(arg_327_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_330_5 then
							if arg_327_1.isInRecall_ then
								local var_330_12 = Mathf.Lerp(iter_330_5.color.r, arg_327_1.hightColor2.r, var_330_11)
								local var_330_13 = Mathf.Lerp(iter_330_5.color.g, arg_327_1.hightColor2.g, var_330_11)
								local var_330_14 = Mathf.Lerp(iter_330_5.color.b, arg_327_1.hightColor2.b, var_330_11)

								iter_330_5.color = Color.New(var_330_12, var_330_13, var_330_14)
							else
								local var_330_15 = Mathf.Lerp(iter_330_5.color.r, 0.5, var_330_11)

								iter_330_5.color = Color.New(var_330_15, var_330_15, var_330_15)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_9 + var_330_10 and arg_327_1.time_ < var_330_9 + var_330_10 + arg_330_0 and not isNil(var_330_8) and arg_327_1.var_.actorSpriteComps10127 then
				for iter_330_6, iter_330_7 in pairs(arg_327_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_330_7 then
						if arg_327_1.isInRecall_ then
							iter_330_7.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10127 = nil
			end

			local var_330_16 = arg_327_1.actors_["1137"].transform
			local var_330_17 = 0

			if var_330_17 < arg_327_1.time_ and arg_327_1.time_ <= var_330_17 + arg_330_0 then
				arg_327_1.var_.moveOldPos1137 = var_330_16.localPosition
				var_330_16.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1137", 4)

				local var_330_18 = var_330_16.childCount

				for iter_330_8 = 0, var_330_18 - 1 do
					local var_330_19 = var_330_16:GetChild(iter_330_8)

					if var_330_19.name == "split_4" or not string.find(var_330_19.name, "split") then
						var_330_19.gameObject:SetActive(true)
					else
						var_330_19.gameObject:SetActive(false)
					end
				end
			end

			local var_330_20 = 0.001

			if var_330_17 <= arg_327_1.time_ and arg_327_1.time_ < var_330_17 + var_330_20 then
				local var_330_21 = (arg_327_1.time_ - var_330_17) / var_330_20
				local var_330_22 = Vector3.New(390, -425, -200)

				var_330_16.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1137, var_330_22, var_330_21)
			end

			if arg_327_1.time_ >= var_330_17 + var_330_20 and arg_327_1.time_ < var_330_17 + var_330_20 + arg_330_0 then
				var_330_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_330_23 = 0
			local var_330_24 = 1

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_25 = arg_327_1:FormatText(StoryNameCfg[15].name)

				arg_327_1.leftNameTxt_.text = var_330_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_26 = arg_327_1:GetWordFromCfg(425042080)
				local var_330_27 = arg_327_1:FormatText(var_330_26.content)

				arg_327_1.text_.text = var_330_27

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_28 = 40
				local var_330_29 = utf8.len(var_330_27)
				local var_330_30 = var_330_28 <= 0 and var_330_24 or var_330_24 * (var_330_29 / var_330_28)

				if var_330_30 > 0 and var_330_24 < var_330_30 then
					arg_327_1.talkMaxDuration = var_330_30

					if var_330_30 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_30 + var_330_23
					end
				end

				arg_327_1.text_.text = var_330_27
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042080", "story_v_out_425042.awb") ~= 0 then
					local var_330_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042080", "story_v_out_425042.awb") / 1000

					if var_330_31 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_31 + var_330_23
					end

					if var_330_26.prefab_name ~= "" and arg_327_1.actors_[var_330_26.prefab_name] ~= nil then
						local var_330_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_26.prefab_name].transform, "story_v_out_425042", "425042080", "story_v_out_425042.awb")

						arg_327_1:RecordAudio("425042080", var_330_32)
						arg_327_1:RecordAudio("425042080", var_330_32)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_425042", "425042080", "story_v_out_425042.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_425042", "425042080", "story_v_out_425042.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_33 = math.max(var_330_24, arg_327_1.talkMaxDuration)

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_33 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_23) / var_330_33

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_23 + var_330_33 and arg_327_1.time_ < var_330_23 + var_330_33 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play425042081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 425042081
		arg_331_1.duration_ = 9.4

		local var_331_0 = {
			zh = 5.033,
			ja = 9.4
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
				arg_331_0:Play425042082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10127"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10127 == nil then
				arg_331_1.var_.actorSpriteComps10127 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps10127 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10127 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10127 = nil
			end

			local var_334_8 = arg_331_1.actors_["1137"]
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps1137 == nil then
				arg_331_1.var_.actorSpriteComps1137 = var_334_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_10 = 0.2

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_10 and not isNil(var_334_8) then
				local var_334_11 = (arg_331_1.time_ - var_334_9) / var_334_10

				if arg_331_1.var_.actorSpriteComps1137 then
					for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_334_5 then
							if arg_331_1.isInRecall_ then
								local var_334_12 = Mathf.Lerp(iter_334_5.color.r, arg_331_1.hightColor2.r, var_334_11)
								local var_334_13 = Mathf.Lerp(iter_334_5.color.g, arg_331_1.hightColor2.g, var_334_11)
								local var_334_14 = Mathf.Lerp(iter_334_5.color.b, arg_331_1.hightColor2.b, var_334_11)

								iter_334_5.color = Color.New(var_334_12, var_334_13, var_334_14)
							else
								local var_334_15 = Mathf.Lerp(iter_334_5.color.r, 0.5, var_334_11)

								iter_334_5.color = Color.New(var_334_15, var_334_15, var_334_15)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_9 + var_334_10 and arg_331_1.time_ < var_334_9 + var_334_10 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps1137 then
				for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_334_7 then
						if arg_331_1.isInRecall_ then
							iter_334_7.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1137 = nil
			end

			local var_334_16 = arg_331_1.actors_["10127"].transform
			local var_334_17 = 0

			if var_334_17 < arg_331_1.time_ and arg_331_1.time_ <= var_334_17 + arg_334_0 then
				arg_331_1.var_.moveOldPos10127 = var_334_16.localPosition
				var_334_16.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10127", 2)

				local var_334_18 = var_334_16.childCount

				for iter_334_8 = 0, var_334_18 - 1 do
					local var_334_19 = var_334_16:GetChild(iter_334_8)

					if var_334_19.name == "split_1" then
						var_334_19:SetAsLastSibling()
						var_334_19.gameObject:SetActive(true)

						arg_331_1.var_.actorSpriteSplit10127 = var_334_19.gameObject:GetComponent(typeof(Image))

						arg_331_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_334_20 = 0.333333333333333

			if var_334_17 <= arg_331_1.time_ and arg_331_1.time_ < var_334_17 + var_334_20 then
				local var_334_21 = (arg_331_1.time_ - var_334_17) / var_334_20
				local var_334_22 = Vector3.New(-390, -387.4, -316.5)

				var_334_16.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10127, var_334_22, var_334_21)

				if arg_331_1.var_.actorSpriteSplit10127 ~= nil then
					arg_331_1.var_.actorSpriteSplit10127:SetAlpha(var_334_21)
				end
			end

			if arg_331_1.time_ >= var_334_17 + var_334_20 and arg_331_1.time_ < var_334_17 + var_334_20 + arg_334_0 then
				var_334_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_331_1.var_.actorSpriteSplit10127 ~= nil then
					arg_331_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_334_23 = 0
			local var_334_24 = 0.575

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_25 = arg_331_1:FormatText(StoryNameCfg[236].name)

				arg_331_1.leftNameTxt_.text = var_334_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_26 = arg_331_1:GetWordFromCfg(425042081)
				local var_334_27 = arg_331_1:FormatText(var_334_26.content)

				arg_331_1.text_.text = var_334_27

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_28 = 23
				local var_334_29 = utf8.len(var_334_27)
				local var_334_30 = var_334_28 <= 0 and var_334_24 or var_334_24 * (var_334_29 / var_334_28)

				if var_334_30 > 0 and var_334_24 < var_334_30 then
					arg_331_1.talkMaxDuration = var_334_30

					if var_334_30 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_30 + var_334_23
					end
				end

				arg_331_1.text_.text = var_334_27
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042081", "story_v_out_425042.awb") ~= 0 then
					local var_334_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042081", "story_v_out_425042.awb") / 1000

					if var_334_31 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_31 + var_334_23
					end

					if var_334_26.prefab_name ~= "" and arg_331_1.actors_[var_334_26.prefab_name] ~= nil then
						local var_334_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_26.prefab_name].transform, "story_v_out_425042", "425042081", "story_v_out_425042.awb")

						arg_331_1:RecordAudio("425042081", var_334_32)
						arg_331_1:RecordAudio("425042081", var_334_32)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_425042", "425042081", "story_v_out_425042.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_425042", "425042081", "story_v_out_425042.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_33 = math.max(var_334_24, arg_331_1.talkMaxDuration)

			if var_334_23 <= arg_331_1.time_ and arg_331_1.time_ < var_334_23 + var_334_33 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_23) / var_334_33

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_23 + var_334_33 and arg_331_1.time_ < var_334_23 + var_334_33 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play425042082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 425042082
		arg_335_1.duration_ = 12.07

		local var_335_0 = {
			zh = 6.833,
			ja = 12.066
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
				arg_335_0:Play425042083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1137"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1137 == nil then
				arg_335_1.var_.actorSpriteComps1137 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps1137 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 1, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1137 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1137 = nil
			end

			local var_338_8 = arg_335_1.actors_["10127"]
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10127 == nil then
				arg_335_1.var_.actorSpriteComps10127 = var_338_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_10 = 0.2

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_10 and not isNil(var_338_8) then
				local var_338_11 = (arg_335_1.time_ - var_338_9) / var_338_10

				if arg_335_1.var_.actorSpriteComps10127 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								local var_338_12 = Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor2.r, var_338_11)
								local var_338_13 = Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor2.g, var_338_11)
								local var_338_14 = Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor2.b, var_338_11)

								iter_338_5.color = Color.New(var_338_12, var_338_13, var_338_14)
							else
								local var_338_15 = Mathf.Lerp(iter_338_5.color.r, 0.5, var_338_11)

								iter_338_5.color = Color.New(var_338_15, var_338_15, var_338_15)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_9 + var_338_10 and arg_335_1.time_ < var_338_9 + var_338_10 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10127 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_338_7 then
						if arg_335_1.isInRecall_ then
							iter_338_7.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10127 = nil
			end

			local var_338_16 = arg_335_1.actors_["1137"].transform
			local var_338_17 = 0

			if var_338_17 < arg_335_1.time_ and arg_335_1.time_ <= var_338_17 + arg_338_0 then
				arg_335_1.var_.moveOldPos1137 = var_338_16.localPosition
				var_338_16.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1137", 4)

				local var_338_18 = var_338_16.childCount

				for iter_338_8 = 0, var_338_18 - 1 do
					local var_338_19 = var_338_16:GetChild(iter_338_8)

					if var_338_19.name == "split_4" or not string.find(var_338_19.name, "split") then
						var_338_19.gameObject:SetActive(true)
					else
						var_338_19.gameObject:SetActive(false)
					end
				end
			end

			local var_338_20 = 0.001

			if var_338_17 <= arg_335_1.time_ and arg_335_1.time_ < var_338_17 + var_338_20 then
				local var_338_21 = (arg_335_1.time_ - var_338_17) / var_338_20
				local var_338_22 = Vector3.New(390, -425, -200)

				var_338_16.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1137, var_338_22, var_338_21)
			end

			if arg_335_1.time_ >= var_338_17 + var_338_20 and arg_335_1.time_ < var_338_17 + var_338_20 + arg_338_0 then
				var_338_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_338_23 = 0
			local var_338_24 = 0.775

			if var_338_23 < arg_335_1.time_ and arg_335_1.time_ <= var_338_23 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_25 = arg_335_1:FormatText(StoryNameCfg[15].name)

				arg_335_1.leftNameTxt_.text = var_338_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_26 = arg_335_1:GetWordFromCfg(425042082)
				local var_338_27 = arg_335_1:FormatText(var_338_26.content)

				arg_335_1.text_.text = var_338_27

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_28 = 31
				local var_338_29 = utf8.len(var_338_27)
				local var_338_30 = var_338_28 <= 0 and var_338_24 or var_338_24 * (var_338_29 / var_338_28)

				if var_338_30 > 0 and var_338_24 < var_338_30 then
					arg_335_1.talkMaxDuration = var_338_30

					if var_338_30 + var_338_23 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_30 + var_338_23
					end
				end

				arg_335_1.text_.text = var_338_27
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042082", "story_v_out_425042.awb") ~= 0 then
					local var_338_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042082", "story_v_out_425042.awb") / 1000

					if var_338_31 + var_338_23 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_31 + var_338_23
					end

					if var_338_26.prefab_name ~= "" and arg_335_1.actors_[var_338_26.prefab_name] ~= nil then
						local var_338_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_26.prefab_name].transform, "story_v_out_425042", "425042082", "story_v_out_425042.awb")

						arg_335_1:RecordAudio("425042082", var_338_32)
						arg_335_1:RecordAudio("425042082", var_338_32)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_425042", "425042082", "story_v_out_425042.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_425042", "425042082", "story_v_out_425042.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_33 = math.max(var_338_24, arg_335_1.talkMaxDuration)

			if var_338_23 <= arg_335_1.time_ and arg_335_1.time_ < var_338_23 + var_338_33 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_23) / var_338_33

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_23 + var_338_33 and arg_335_1.time_ < var_338_23 + var_338_33 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play425042083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 425042083
		arg_339_1.duration_ = 2.07

		local var_339_0 = {
			zh = 1.633,
			ja = 2.066
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
				arg_339_0:Play425042084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10127"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10127 == nil then
				arg_339_1.var_.actorSpriteComps10127 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps10127 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10127 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10127 = nil
			end

			local var_342_8 = arg_339_1.actors_["1137"]
			local var_342_9 = 0

			if var_342_9 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps1137 == nil then
				arg_339_1.var_.actorSpriteComps1137 = var_342_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_10 = 0.2

			if var_342_9 <= arg_339_1.time_ and arg_339_1.time_ < var_342_9 + var_342_10 and not isNil(var_342_8) then
				local var_342_11 = (arg_339_1.time_ - var_342_9) / var_342_10

				if arg_339_1.var_.actorSpriteComps1137 then
					for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_342_5 then
							if arg_339_1.isInRecall_ then
								local var_342_12 = Mathf.Lerp(iter_342_5.color.r, arg_339_1.hightColor2.r, var_342_11)
								local var_342_13 = Mathf.Lerp(iter_342_5.color.g, arg_339_1.hightColor2.g, var_342_11)
								local var_342_14 = Mathf.Lerp(iter_342_5.color.b, arg_339_1.hightColor2.b, var_342_11)

								iter_342_5.color = Color.New(var_342_12, var_342_13, var_342_14)
							else
								local var_342_15 = Mathf.Lerp(iter_342_5.color.r, 0.5, var_342_11)

								iter_342_5.color = Color.New(var_342_15, var_342_15, var_342_15)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_9 + var_342_10 and arg_339_1.time_ < var_342_9 + var_342_10 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps1137 then
				for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_342_7 then
						if arg_339_1.isInRecall_ then
							iter_342_7.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1137 = nil
			end

			local var_342_16 = arg_339_1.actors_["10127"].transform
			local var_342_17 = 0

			if var_342_17 < arg_339_1.time_ and arg_339_1.time_ <= var_342_17 + arg_342_0 then
				arg_339_1.var_.moveOldPos10127 = var_342_16.localPosition
				var_342_16.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10127", 2)

				local var_342_18 = var_342_16.childCount

				for iter_342_8 = 0, var_342_18 - 1 do
					local var_342_19 = var_342_16:GetChild(iter_342_8)

					if var_342_19.name == "split_6" then
						var_342_19:SetAsLastSibling()
						var_342_19.gameObject:SetActive(true)

						arg_339_1.var_.actorSpriteSplit10127 = var_342_19.gameObject:GetComponent(typeof(Image))

						arg_339_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_342_20 = 0.3

			if var_342_17 <= arg_339_1.time_ and arg_339_1.time_ < var_342_17 + var_342_20 then
				local var_342_21 = (arg_339_1.time_ - var_342_17) / var_342_20
				local var_342_22 = Vector3.New(-390, -387.4, -316.5)

				var_342_16.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10127, var_342_22, var_342_21)

				if arg_339_1.var_.actorSpriteSplit10127 ~= nil then
					arg_339_1.var_.actorSpriteSplit10127:SetAlpha(var_342_21)
				end
			end

			if arg_339_1.time_ >= var_342_17 + var_342_20 and arg_339_1.time_ < var_342_17 + var_342_20 + arg_342_0 then
				var_342_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_339_1.var_.actorSpriteSplit10127 ~= nil then
					arg_339_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_342_23 = 0
			local var_342_24 = 0.2

			if var_342_23 < arg_339_1.time_ and arg_339_1.time_ <= var_342_23 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_25 = arg_339_1:FormatText(StoryNameCfg[236].name)

				arg_339_1.leftNameTxt_.text = var_342_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_26 = arg_339_1:GetWordFromCfg(425042083)
				local var_342_27 = arg_339_1:FormatText(var_342_26.content)

				arg_339_1.text_.text = var_342_27

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_28 = 8
				local var_342_29 = utf8.len(var_342_27)
				local var_342_30 = var_342_28 <= 0 and var_342_24 or var_342_24 * (var_342_29 / var_342_28)

				if var_342_30 > 0 and var_342_24 < var_342_30 then
					arg_339_1.talkMaxDuration = var_342_30

					if var_342_30 + var_342_23 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_30 + var_342_23
					end
				end

				arg_339_1.text_.text = var_342_27
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042083", "story_v_out_425042.awb") ~= 0 then
					local var_342_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042083", "story_v_out_425042.awb") / 1000

					if var_342_31 + var_342_23 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_31 + var_342_23
					end

					if var_342_26.prefab_name ~= "" and arg_339_1.actors_[var_342_26.prefab_name] ~= nil then
						local var_342_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_26.prefab_name].transform, "story_v_out_425042", "425042083", "story_v_out_425042.awb")

						arg_339_1:RecordAudio("425042083", var_342_32)
						arg_339_1:RecordAudio("425042083", var_342_32)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_425042", "425042083", "story_v_out_425042.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_425042", "425042083", "story_v_out_425042.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_33 = math.max(var_342_24, arg_339_1.talkMaxDuration)

			if var_342_23 <= arg_339_1.time_ and arg_339_1.time_ < var_342_23 + var_342_33 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_23) / var_342_33

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_23 + var_342_33 and arg_339_1.time_ < var_342_23 + var_342_33 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play425042084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 425042084
		arg_343_1.duration_ = 13.03

		local var_343_0 = {
			zh = 5.1,
			ja = 13.033
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
				arg_343_0:Play425042085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1137"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1137 == nil then
				arg_343_1.var_.actorSpriteComps1137 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps1137 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1137 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1137 = nil
			end

			local var_346_8 = arg_343_1.actors_["10127"]
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10127 == nil then
				arg_343_1.var_.actorSpriteComps10127 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_10 = 0.2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 and not isNil(var_346_8) then
				local var_346_11 = (arg_343_1.time_ - var_346_9) / var_346_10

				if arg_343_1.var_.actorSpriteComps10127 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10127 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_346_7 then
						if arg_343_1.isInRecall_ then
							iter_346_7.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10127 = nil
			end

			local var_346_16 = arg_343_1.actors_["1137"].transform
			local var_346_17 = 0

			if var_346_17 < arg_343_1.time_ and arg_343_1.time_ <= var_346_17 + arg_346_0 then
				arg_343_1.var_.moveOldPos1137 = var_346_16.localPosition
				var_346_16.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1137", 4)

				local var_346_18 = var_346_16.childCount

				for iter_346_8 = 0, var_346_18 - 1 do
					local var_346_19 = var_346_16:GetChild(iter_346_8)

					if var_346_19.name == "split_4" or not string.find(var_346_19.name, "split") then
						var_346_19.gameObject:SetActive(true)
					else
						var_346_19.gameObject:SetActive(false)
					end
				end
			end

			local var_346_20 = 0.001

			if var_346_17 <= arg_343_1.time_ and arg_343_1.time_ < var_346_17 + var_346_20 then
				local var_346_21 = (arg_343_1.time_ - var_346_17) / var_346_20
				local var_346_22 = Vector3.New(390, -425, -200)

				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1137, var_346_22, var_346_21)
			end

			if arg_343_1.time_ >= var_346_17 + var_346_20 and arg_343_1.time_ < var_346_17 + var_346_20 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_346_23 = 0
			local var_346_24 = 0.6

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_25 = arg_343_1:FormatText(StoryNameCfg[15].name)

				arg_343_1.leftNameTxt_.text = var_346_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_26 = arg_343_1:GetWordFromCfg(425042084)
				local var_346_27 = arg_343_1:FormatText(var_346_26.content)

				arg_343_1.text_.text = var_346_27

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_28 = 25
				local var_346_29 = utf8.len(var_346_27)
				local var_346_30 = var_346_28 <= 0 and var_346_24 or var_346_24 * (var_346_29 / var_346_28)

				if var_346_30 > 0 and var_346_24 < var_346_30 then
					arg_343_1.talkMaxDuration = var_346_30

					if var_346_30 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_30 + var_346_23
					end
				end

				arg_343_1.text_.text = var_346_27
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042084", "story_v_out_425042.awb") ~= 0 then
					local var_346_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042084", "story_v_out_425042.awb") / 1000

					if var_346_31 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_31 + var_346_23
					end

					if var_346_26.prefab_name ~= "" and arg_343_1.actors_[var_346_26.prefab_name] ~= nil then
						local var_346_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_26.prefab_name].transform, "story_v_out_425042", "425042084", "story_v_out_425042.awb")

						arg_343_1:RecordAudio("425042084", var_346_32)
						arg_343_1:RecordAudio("425042084", var_346_32)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_425042", "425042084", "story_v_out_425042.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_425042", "425042084", "story_v_out_425042.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_33 = math.max(var_346_24, arg_343_1.talkMaxDuration)

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_33 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_23) / var_346_33

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_23 + var_346_33 and arg_343_1.time_ < var_346_23 + var_346_33 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play425042085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 425042085
		arg_347_1.duration_ = 2.77

		local var_347_0 = {
			zh = 1,
			ja = 2.766
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
				arg_347_0:Play425042086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10127"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10127 == nil then
				arg_347_1.var_.actorSpriteComps10127 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10127 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10127 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10127 = nil
			end

			local var_350_8 = arg_347_1.actors_["1137"]
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps1137 == nil then
				arg_347_1.var_.actorSpriteComps1137 = var_350_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_10 = 0.2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 and not isNil(var_350_8) then
				local var_350_11 = (arg_347_1.time_ - var_350_9) / var_350_10

				if arg_347_1.var_.actorSpriteComps1137 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps1137 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_350_7 then
						if arg_347_1.isInRecall_ then
							iter_350_7.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps1137 = nil
			end

			local var_350_16 = 0
			local var_350_17 = 0.075

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_18 = arg_347_1:FormatText(StoryNameCfg[236].name)

				arg_347_1.leftNameTxt_.text = var_350_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_19 = arg_347_1:GetWordFromCfg(425042085)
				local var_350_20 = arg_347_1:FormatText(var_350_19.content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_21 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042085", "story_v_out_425042.awb") ~= 0 then
					local var_350_24 = manager.audio:GetVoiceLength("story_v_out_425042", "425042085", "story_v_out_425042.awb") / 1000

					if var_350_24 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_16
					end

					if var_350_19.prefab_name ~= "" and arg_347_1.actors_[var_350_19.prefab_name] ~= nil then
						local var_350_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_19.prefab_name].transform, "story_v_out_425042", "425042085", "story_v_out_425042.awb")

						arg_347_1:RecordAudio("425042085", var_350_25)
						arg_347_1:RecordAudio("425042085", var_350_25)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_425042", "425042085", "story_v_out_425042.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_425042", "425042085", "story_v_out_425042.awb")
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
	Play425042086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 425042086
		arg_351_1.duration_ = 2.07

		local var_351_0 = {
			zh = 2.066,
			ja = 1.733
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play425042087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1137"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps1137 == nil then
				arg_351_1.var_.actorSpriteComps1137 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps1137 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 1, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps1137 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_354_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps1137 = nil
			end

			local var_354_8 = arg_351_1.actors_["10127"]
			local var_354_9 = 0

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps10127 == nil then
				arg_351_1.var_.actorSpriteComps10127 = var_354_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_10 = 0.2

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_10 and not isNil(var_354_8) then
				local var_354_11 = (arg_351_1.time_ - var_354_9) / var_354_10

				if arg_351_1.var_.actorSpriteComps10127 then
					for iter_354_4, iter_354_5 in pairs(arg_351_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_354_5 then
							if arg_351_1.isInRecall_ then
								local var_354_12 = Mathf.Lerp(iter_354_5.color.r, arg_351_1.hightColor2.r, var_354_11)
								local var_354_13 = Mathf.Lerp(iter_354_5.color.g, arg_351_1.hightColor2.g, var_354_11)
								local var_354_14 = Mathf.Lerp(iter_354_5.color.b, arg_351_1.hightColor2.b, var_354_11)

								iter_354_5.color = Color.New(var_354_12, var_354_13, var_354_14)
							else
								local var_354_15 = Mathf.Lerp(iter_354_5.color.r, 0.5, var_354_11)

								iter_354_5.color = Color.New(var_354_15, var_354_15, var_354_15)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_9 + var_354_10 and arg_351_1.time_ < var_354_9 + var_354_10 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps10127 then
				for iter_354_6, iter_354_7 in pairs(arg_351_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_354_7 then
						if arg_351_1.isInRecall_ then
							iter_354_7.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10127 = nil
			end

			local var_354_16 = 0
			local var_354_17 = 0.05

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_18 = arg_351_1:FormatText(StoryNameCfg[15].name)

				arg_351_1.leftNameTxt_.text = var_354_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_19 = arg_351_1:GetWordFromCfg(425042086)
				local var_354_20 = arg_351_1:FormatText(var_354_19.content)

				arg_351_1.text_.text = var_354_20

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_21 = 2
				local var_354_22 = utf8.len(var_354_20)
				local var_354_23 = var_354_21 <= 0 and var_354_17 or var_354_17 * (var_354_22 / var_354_21)

				if var_354_23 > 0 and var_354_17 < var_354_23 then
					arg_351_1.talkMaxDuration = var_354_23

					if var_354_23 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_23 + var_354_16
					end
				end

				arg_351_1.text_.text = var_354_20
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042086", "story_v_out_425042.awb") ~= 0 then
					local var_354_24 = manager.audio:GetVoiceLength("story_v_out_425042", "425042086", "story_v_out_425042.awb") / 1000

					if var_354_24 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_24 + var_354_16
					end

					if var_354_19.prefab_name ~= "" and arg_351_1.actors_[var_354_19.prefab_name] ~= nil then
						local var_354_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_19.prefab_name].transform, "story_v_out_425042", "425042086", "story_v_out_425042.awb")

						arg_351_1:RecordAudio("425042086", var_354_25)
						arg_351_1:RecordAudio("425042086", var_354_25)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_425042", "425042086", "story_v_out_425042.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_425042", "425042086", "story_v_out_425042.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_26 = math.max(var_354_17, arg_351_1.talkMaxDuration)

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_26 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_16) / var_354_26

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_16 + var_354_26 and arg_351_1.time_ < var_354_16 + var_354_26 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play425042087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 425042087
		arg_355_1.duration_ = 9.77

		local var_355_0 = {
			zh = 8.2,
			ja = 9.766
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
				arg_355_0:Play425042088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10127"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10127 == nil then
				arg_355_1.var_.actorSpriteComps10127 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps10127 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10127 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_358_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10127 = nil
			end

			local var_358_8 = arg_355_1.actors_["1137"]
			local var_358_9 = 0

			if var_358_9 < arg_355_1.time_ and arg_355_1.time_ <= var_358_9 + arg_358_0 and not isNil(var_358_8) and arg_355_1.var_.actorSpriteComps1137 == nil then
				arg_355_1.var_.actorSpriteComps1137 = var_358_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_10 = 0.2

			if var_358_9 <= arg_355_1.time_ and arg_355_1.time_ < var_358_9 + var_358_10 and not isNil(var_358_8) then
				local var_358_11 = (arg_355_1.time_ - var_358_9) / var_358_10

				if arg_355_1.var_.actorSpriteComps1137 then
					for iter_358_4, iter_358_5 in pairs(arg_355_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_358_5 then
							if arg_355_1.isInRecall_ then
								local var_358_12 = Mathf.Lerp(iter_358_5.color.r, arg_355_1.hightColor2.r, var_358_11)
								local var_358_13 = Mathf.Lerp(iter_358_5.color.g, arg_355_1.hightColor2.g, var_358_11)
								local var_358_14 = Mathf.Lerp(iter_358_5.color.b, arg_355_1.hightColor2.b, var_358_11)

								iter_358_5.color = Color.New(var_358_12, var_358_13, var_358_14)
							else
								local var_358_15 = Mathf.Lerp(iter_358_5.color.r, 0.5, var_358_11)

								iter_358_5.color = Color.New(var_358_15, var_358_15, var_358_15)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_9 + var_358_10 and arg_355_1.time_ < var_358_9 + var_358_10 + arg_358_0 and not isNil(var_358_8) and arg_355_1.var_.actorSpriteComps1137 then
				for iter_358_6, iter_358_7 in pairs(arg_355_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_358_7 then
						if arg_355_1.isInRecall_ then
							iter_358_7.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps1137 = nil
			end

			local var_358_16 = 0
			local var_358_17 = 1

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_18 = arg_355_1:FormatText(StoryNameCfg[236].name)

				arg_355_1.leftNameTxt_.text = var_358_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_19 = arg_355_1:GetWordFromCfg(425042087)
				local var_358_20 = arg_355_1:FormatText(var_358_19.content)

				arg_355_1.text_.text = var_358_20

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_21 = 40
				local var_358_22 = utf8.len(var_358_20)
				local var_358_23 = var_358_21 <= 0 and var_358_17 or var_358_17 * (var_358_22 / var_358_21)

				if var_358_23 > 0 and var_358_17 < var_358_23 then
					arg_355_1.talkMaxDuration = var_358_23

					if var_358_23 + var_358_16 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_16
					end
				end

				arg_355_1.text_.text = var_358_20
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042087", "story_v_out_425042.awb") ~= 0 then
					local var_358_24 = manager.audio:GetVoiceLength("story_v_out_425042", "425042087", "story_v_out_425042.awb") / 1000

					if var_358_24 + var_358_16 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_24 + var_358_16
					end

					if var_358_19.prefab_name ~= "" and arg_355_1.actors_[var_358_19.prefab_name] ~= nil then
						local var_358_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_19.prefab_name].transform, "story_v_out_425042", "425042087", "story_v_out_425042.awb")

						arg_355_1:RecordAudio("425042087", var_358_25)
						arg_355_1:RecordAudio("425042087", var_358_25)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_425042", "425042087", "story_v_out_425042.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_425042", "425042087", "story_v_out_425042.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_26 = math.max(var_358_17, arg_355_1.talkMaxDuration)

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_26 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_16) / var_358_26

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_16 + var_358_26 and arg_355_1.time_ < var_358_16 + var_358_26 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play425042088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 425042088
		arg_359_1.duration_ = 8.4

		local var_359_0 = {
			zh = 6.533,
			ja = 8.4
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
				arg_359_0:Play425042089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.725

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[236].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(425042088)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042088", "story_v_out_425042.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042088", "story_v_out_425042.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_425042", "425042088", "story_v_out_425042.awb")

						arg_359_1:RecordAudio("425042088", var_362_9)
						arg_359_1:RecordAudio("425042088", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_425042", "425042088", "story_v_out_425042.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_425042", "425042088", "story_v_out_425042.awb")
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
	Play425042089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 425042089
		arg_363_1.duration_ = 3.2

		local var_363_0 = {
			zh = 3.2,
			ja = 1.7
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play425042090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1137"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1137 == nil then
				arg_363_1.var_.actorSpriteComps1137 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps1137 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 1, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1137 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps1137 = nil
			end

			local var_366_8 = arg_363_1.actors_["10127"]
			local var_366_9 = 0

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps10127 == nil then
				arg_363_1.var_.actorSpriteComps10127 = var_366_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_10 = 0.2

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_10 and not isNil(var_366_8) then
				local var_366_11 = (arg_363_1.time_ - var_366_9) / var_366_10

				if arg_363_1.var_.actorSpriteComps10127 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								local var_366_12 = Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor2.r, var_366_11)
								local var_366_13 = Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor2.g, var_366_11)
								local var_366_14 = Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor2.b, var_366_11)

								iter_366_5.color = Color.New(var_366_12, var_366_13, var_366_14)
							else
								local var_366_15 = Mathf.Lerp(iter_366_5.color.r, 0.5, var_366_11)

								iter_366_5.color = Color.New(var_366_15, var_366_15, var_366_15)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_9 + var_366_10 and arg_363_1.time_ < var_366_9 + var_366_10 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps10127 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_366_7 then
						if arg_363_1.isInRecall_ then
							iter_366_7.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10127 = nil
			end

			local var_366_16 = arg_363_1.actors_["1137"].transform
			local var_366_17 = 0

			if var_366_17 < arg_363_1.time_ and arg_363_1.time_ <= var_366_17 + arg_366_0 then
				arg_363_1.var_.moveOldPos1137 = var_366_16.localPosition
				var_366_16.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1137", 4)

				local var_366_18 = var_366_16.childCount

				for iter_366_8 = 0, var_366_18 - 1 do
					local var_366_19 = var_366_16:GetChild(iter_366_8)

					if var_366_19.name == "split_4" or not string.find(var_366_19.name, "split") then
						var_366_19.gameObject:SetActive(true)
					else
						var_366_19.gameObject:SetActive(false)
					end
				end
			end

			local var_366_20 = 0.001

			if var_366_17 <= arg_363_1.time_ and arg_363_1.time_ < var_366_17 + var_366_20 then
				local var_366_21 = (arg_363_1.time_ - var_366_17) / var_366_20
				local var_366_22 = Vector3.New(390, -425, -200)

				var_366_16.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1137, var_366_22, var_366_21)
			end

			if arg_363_1.time_ >= var_366_17 + var_366_20 and arg_363_1.time_ < var_366_17 + var_366_20 + arg_366_0 then
				var_366_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_366_23 = 0
			local var_366_24 = 0.175

			if var_366_23 < arg_363_1.time_ and arg_363_1.time_ <= var_366_23 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_25 = arg_363_1:FormatText(StoryNameCfg[15].name)

				arg_363_1.leftNameTxt_.text = var_366_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_26 = arg_363_1:GetWordFromCfg(425042089)
				local var_366_27 = arg_363_1:FormatText(var_366_26.content)

				arg_363_1.text_.text = var_366_27

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_28 = 7
				local var_366_29 = utf8.len(var_366_27)
				local var_366_30 = var_366_28 <= 0 and var_366_24 or var_366_24 * (var_366_29 / var_366_28)

				if var_366_30 > 0 and var_366_24 < var_366_30 then
					arg_363_1.talkMaxDuration = var_366_30

					if var_366_30 + var_366_23 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_30 + var_366_23
					end
				end

				arg_363_1.text_.text = var_366_27
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042089", "story_v_out_425042.awb") ~= 0 then
					local var_366_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042089", "story_v_out_425042.awb") / 1000

					if var_366_31 + var_366_23 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_31 + var_366_23
					end

					if var_366_26.prefab_name ~= "" and arg_363_1.actors_[var_366_26.prefab_name] ~= nil then
						local var_366_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_26.prefab_name].transform, "story_v_out_425042", "425042089", "story_v_out_425042.awb")

						arg_363_1:RecordAudio("425042089", var_366_32)
						arg_363_1:RecordAudio("425042089", var_366_32)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_425042", "425042089", "story_v_out_425042.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_425042", "425042089", "story_v_out_425042.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_33 = math.max(var_366_24, arg_363_1.talkMaxDuration)

			if var_366_23 <= arg_363_1.time_ and arg_363_1.time_ < var_366_23 + var_366_33 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_23) / var_366_33

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_23 + var_366_33 and arg_363_1.time_ < var_366_23 + var_366_33 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play425042090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 425042090
		arg_367_1.duration_ = 16.7

		local var_367_0 = {
			zh = 12.9,
			ja = 16.7
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play425042091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10127"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10127 == nil then
				arg_367_1.var_.actorSpriteComps10127 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps10127 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 1, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10127 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10127 = nil
			end

			local var_370_8 = arg_367_1.actors_["1137"]
			local var_370_9 = 0

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 and not isNil(var_370_8) and arg_367_1.var_.actorSpriteComps1137 == nil then
				arg_367_1.var_.actorSpriteComps1137 = var_370_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_10 = 0.2

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_10 and not isNil(var_370_8) then
				local var_370_11 = (arg_367_1.time_ - var_370_9) / var_370_10

				if arg_367_1.var_.actorSpriteComps1137 then
					for iter_370_4, iter_370_5 in pairs(arg_367_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_370_5 then
							if arg_367_1.isInRecall_ then
								local var_370_12 = Mathf.Lerp(iter_370_5.color.r, arg_367_1.hightColor2.r, var_370_11)
								local var_370_13 = Mathf.Lerp(iter_370_5.color.g, arg_367_1.hightColor2.g, var_370_11)
								local var_370_14 = Mathf.Lerp(iter_370_5.color.b, arg_367_1.hightColor2.b, var_370_11)

								iter_370_5.color = Color.New(var_370_12, var_370_13, var_370_14)
							else
								local var_370_15 = Mathf.Lerp(iter_370_5.color.r, 0.5, var_370_11)

								iter_370_5.color = Color.New(var_370_15, var_370_15, var_370_15)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_9 + var_370_10 and arg_367_1.time_ < var_370_9 + var_370_10 + arg_370_0 and not isNil(var_370_8) and arg_367_1.var_.actorSpriteComps1137 then
				for iter_370_6, iter_370_7 in pairs(arg_367_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_370_7 then
						if arg_367_1.isInRecall_ then
							iter_370_7.color = arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_370_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps1137 = nil
			end

			local var_370_16 = arg_367_1.actors_["10127"].transform
			local var_370_17 = 0

			if var_370_17 < arg_367_1.time_ and arg_367_1.time_ <= var_370_17 + arg_370_0 then
				arg_367_1.var_.moveOldPos10127 = var_370_16.localPosition
				var_370_16.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10127", 2)

				local var_370_18 = var_370_16.childCount

				for iter_370_8 = 0, var_370_18 - 1 do
					local var_370_19 = var_370_16:GetChild(iter_370_8)

					if var_370_19.name == "split_6" or not string.find(var_370_19.name, "split") then
						var_370_19.gameObject:SetActive(true)
					else
						var_370_19.gameObject:SetActive(false)
					end
				end
			end

			local var_370_20 = 0.001

			if var_370_17 <= arg_367_1.time_ and arg_367_1.time_ < var_370_17 + var_370_20 then
				local var_370_21 = (arg_367_1.time_ - var_370_17) / var_370_20
				local var_370_22 = Vector3.New(-390, -387.4, -316.5)

				var_370_16.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10127, var_370_22, var_370_21)
			end

			if arg_367_1.time_ >= var_370_17 + var_370_20 and arg_367_1.time_ < var_370_17 + var_370_20 + arg_370_0 then
				var_370_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_370_23 = 0
			local var_370_24 = 1.55

			if var_370_23 < arg_367_1.time_ and arg_367_1.time_ <= var_370_23 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_25 = arg_367_1:FormatText(StoryNameCfg[236].name)

				arg_367_1.leftNameTxt_.text = var_370_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_26 = arg_367_1:GetWordFromCfg(425042090)
				local var_370_27 = arg_367_1:FormatText(var_370_26.content)

				arg_367_1.text_.text = var_370_27

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_28 = 62
				local var_370_29 = utf8.len(var_370_27)
				local var_370_30 = var_370_28 <= 0 and var_370_24 or var_370_24 * (var_370_29 / var_370_28)

				if var_370_30 > 0 and var_370_24 < var_370_30 then
					arg_367_1.talkMaxDuration = var_370_30

					if var_370_30 + var_370_23 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_30 + var_370_23
					end
				end

				arg_367_1.text_.text = var_370_27
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042090", "story_v_out_425042.awb") ~= 0 then
					local var_370_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042090", "story_v_out_425042.awb") / 1000

					if var_370_31 + var_370_23 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_31 + var_370_23
					end

					if var_370_26.prefab_name ~= "" and arg_367_1.actors_[var_370_26.prefab_name] ~= nil then
						local var_370_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_26.prefab_name].transform, "story_v_out_425042", "425042090", "story_v_out_425042.awb")

						arg_367_1:RecordAudio("425042090", var_370_32)
						arg_367_1:RecordAudio("425042090", var_370_32)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_425042", "425042090", "story_v_out_425042.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_425042", "425042090", "story_v_out_425042.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_33 = math.max(var_370_24, arg_367_1.talkMaxDuration)

			if var_370_23 <= arg_367_1.time_ and arg_367_1.time_ < var_370_23 + var_370_33 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_23) / var_370_33

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_23 + var_370_33 and arg_367_1.time_ < var_370_23 + var_370_33 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play425042091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 425042091
		arg_371_1.duration_ = 14.23

		local var_371_0 = {
			zh = 9.533,
			ja = 14.233
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play425042092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 1.275

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[236].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:GetWordFromCfg(425042091)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 51
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042091", "story_v_out_425042.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042091", "story_v_out_425042.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_425042", "425042091", "story_v_out_425042.awb")

						arg_371_1:RecordAudio("425042091", var_374_9)
						arg_371_1:RecordAudio("425042091", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_425042", "425042091", "story_v_out_425042.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_425042", "425042091", "story_v_out_425042.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_10 and arg_371_1.time_ < var_374_0 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play425042092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 425042092
		arg_375_1.duration_ = 3.67

		local var_375_0 = {
			zh = 1.366,
			ja = 3.666
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play425042093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1137"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1137 == nil then
				arg_375_1.var_.actorSpriteComps1137 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps1137 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 1, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1137 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps1137 = nil
			end

			local var_378_8 = arg_375_1.actors_["10127"]
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 and not isNil(var_378_8) and arg_375_1.var_.actorSpriteComps10127 == nil then
				arg_375_1.var_.actorSpriteComps10127 = var_378_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_10 = 0.2

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_10 and not isNil(var_378_8) then
				local var_378_11 = (arg_375_1.time_ - var_378_9) / var_378_10

				if arg_375_1.var_.actorSpriteComps10127 then
					for iter_378_4, iter_378_5 in pairs(arg_375_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_378_5 then
							if arg_375_1.isInRecall_ then
								local var_378_12 = Mathf.Lerp(iter_378_5.color.r, arg_375_1.hightColor2.r, var_378_11)
								local var_378_13 = Mathf.Lerp(iter_378_5.color.g, arg_375_1.hightColor2.g, var_378_11)
								local var_378_14 = Mathf.Lerp(iter_378_5.color.b, arg_375_1.hightColor2.b, var_378_11)

								iter_378_5.color = Color.New(var_378_12, var_378_13, var_378_14)
							else
								local var_378_15 = Mathf.Lerp(iter_378_5.color.r, 0.5, var_378_11)

								iter_378_5.color = Color.New(var_378_15, var_378_15, var_378_15)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_9 + var_378_10 and arg_375_1.time_ < var_378_9 + var_378_10 + arg_378_0 and not isNil(var_378_8) and arg_375_1.var_.actorSpriteComps10127 then
				for iter_378_6, iter_378_7 in pairs(arg_375_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_378_7 then
						if arg_375_1.isInRecall_ then
							iter_378_7.color = arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_378_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10127 = nil
			end

			local var_378_16 = arg_375_1.actors_["1137"].transform
			local var_378_17 = 0

			if var_378_17 < arg_375_1.time_ and arg_375_1.time_ <= var_378_17 + arg_378_0 then
				arg_375_1.var_.moveOldPos1137 = var_378_16.localPosition
				var_378_16.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1137", 4)

				local var_378_18 = var_378_16.childCount

				for iter_378_8 = 0, var_378_18 - 1 do
					local var_378_19 = var_378_16:GetChild(iter_378_8)

					if var_378_19.name == "" then
						var_378_19:SetAsLastSibling()
						var_378_19.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit1137 = var_378_19.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_378_20 = 0.1

			if var_378_17 <= arg_375_1.time_ and arg_375_1.time_ < var_378_17 + var_378_20 then
				local var_378_21 = (arg_375_1.time_ - var_378_17) / var_378_20
				local var_378_22 = Vector3.New(390, -425, -200)

				var_378_16.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1137, var_378_22, var_378_21)

				if arg_375_1.var_.actorSpriteSplit1137 ~= nil then
					arg_375_1.var_.actorSpriteSplit1137:SetAlpha(var_378_21)
				end
			end

			if arg_375_1.time_ >= var_378_17 + var_378_20 and arg_375_1.time_ < var_378_17 + var_378_20 + arg_378_0 then
				var_378_16.localPosition = Vector3.New(390, -425, -200)

				if arg_375_1.var_.actorSpriteSplit1137 ~= nil then
					arg_375_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_378_23 = 0
			local var_378_24 = 0.125

			if var_378_23 < arg_375_1.time_ and arg_375_1.time_ <= var_378_23 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_25 = arg_375_1:FormatText(StoryNameCfg[15].name)

				arg_375_1.leftNameTxt_.text = var_378_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_26 = arg_375_1:GetWordFromCfg(425042092)
				local var_378_27 = arg_375_1:FormatText(var_378_26.content)

				arg_375_1.text_.text = var_378_27

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_28 = 5
				local var_378_29 = utf8.len(var_378_27)
				local var_378_30 = var_378_28 <= 0 and var_378_24 or var_378_24 * (var_378_29 / var_378_28)

				if var_378_30 > 0 and var_378_24 < var_378_30 then
					arg_375_1.talkMaxDuration = var_378_30

					if var_378_30 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_30 + var_378_23
					end
				end

				arg_375_1.text_.text = var_378_27
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042092", "story_v_out_425042.awb") ~= 0 then
					local var_378_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042092", "story_v_out_425042.awb") / 1000

					if var_378_31 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_31 + var_378_23
					end

					if var_378_26.prefab_name ~= "" and arg_375_1.actors_[var_378_26.prefab_name] ~= nil then
						local var_378_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_26.prefab_name].transform, "story_v_out_425042", "425042092", "story_v_out_425042.awb")

						arg_375_1:RecordAudio("425042092", var_378_32)
						arg_375_1:RecordAudio("425042092", var_378_32)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_425042", "425042092", "story_v_out_425042.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_425042", "425042092", "story_v_out_425042.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_33 = math.max(var_378_24, arg_375_1.talkMaxDuration)

			if var_378_23 <= arg_375_1.time_ and arg_375_1.time_ < var_378_23 + var_378_33 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_23) / var_378_33

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_23 + var_378_33 and arg_375_1.time_ < var_378_23 + var_378_33 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play425042093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 425042093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play425042094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1137"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1137 = var_382_0.localPosition
				var_382_0.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("1137", 7)

				local var_382_2 = var_382_0.childCount

				for iter_382_0 = 0, var_382_2 - 1 do
					local var_382_3 = var_382_0:GetChild(iter_382_0)

					if var_382_3.name == "" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_4 then
				local var_382_5 = (arg_379_1.time_ - var_382_1) / var_382_4
				local var_382_6 = Vector3.New(0, -2000, 0)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1137, var_382_6, var_382_5)
			end

			if arg_379_1.time_ >= var_382_1 + var_382_4 and arg_379_1.time_ < var_382_1 + var_382_4 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_7 = arg_379_1.actors_["10127"].transform
			local var_382_8 = 0

			if var_382_8 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.var_.moveOldPos10127 = var_382_7.localPosition
				var_382_7.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10127", 7)

				local var_382_9 = var_382_7.childCount

				for iter_382_1 = 0, var_382_9 - 1 do
					local var_382_10 = var_382_7:GetChild(iter_382_1)

					if var_382_10.name == "" or not string.find(var_382_10.name, "split") then
						var_382_10.gameObject:SetActive(true)
					else
						var_382_10.gameObject:SetActive(false)
					end
				end
			end

			local var_382_11 = 0.001

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_11 then
				local var_382_12 = (arg_379_1.time_ - var_382_8) / var_382_11
				local var_382_13 = Vector3.New(0, -2000, 0)

				var_382_7.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10127, var_382_13, var_382_12)
			end

			if arg_379_1.time_ >= var_382_8 + var_382_11 and arg_379_1.time_ < var_382_8 + var_382_11 + arg_382_0 then
				var_382_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_14 = 0
			local var_382_15 = 0.45

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_16 = arg_379_1:GetWordFromCfg(425042093)
				local var_382_17 = arg_379_1:FormatText(var_382_16.content)

				arg_379_1.text_.text = var_382_17

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_18 = 18
				local var_382_19 = utf8.len(var_382_17)
				local var_382_20 = var_382_18 <= 0 and var_382_15 or var_382_15 * (var_382_19 / var_382_18)

				if var_382_20 > 0 and var_382_15 < var_382_20 then
					arg_379_1.talkMaxDuration = var_382_20

					if var_382_20 + var_382_14 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_14
					end
				end

				arg_379_1.text_.text = var_382_17
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_21 = math.max(var_382_15, arg_379_1.talkMaxDuration)

			if var_382_14 <= arg_379_1.time_ and arg_379_1.time_ < var_382_14 + var_382_21 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_14) / var_382_21

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_14 + var_382_21 and arg_379_1.time_ < var_382_14 + var_382_21 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play425042094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 425042094
		arg_383_1.duration_ = 5.53

		local var_383_0 = {
			zh = 2.7,
			ja = 5.533
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play425042095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1137"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps1137 == nil then
				arg_383_1.var_.actorSpriteComps1137 = var_386_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.actorSpriteComps1137 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								local var_386_4 = Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, var_386_3)
								local var_386_5 = Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, var_386_3)
								local var_386_6 = Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, var_386_3)

								iter_386_1.color = Color.New(var_386_4, var_386_5, var_386_6)
							else
								local var_386_7 = Mathf.Lerp(iter_386_1.color.r, 1, var_386_3)

								iter_386_1.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps1137 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_386_3 then
						if arg_383_1.isInRecall_ then
							iter_386_3.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps1137 = nil
			end

			local var_386_8 = arg_383_1.actors_["1137"].transform
			local var_386_9 = 0

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 then
				arg_383_1.var_.moveOldPos1137 = var_386_8.localPosition
				var_386_8.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1137", 4)

				local var_386_10 = var_386_8.childCount

				for iter_386_4 = 0, var_386_10 - 1 do
					local var_386_11 = var_386_8:GetChild(iter_386_4)

					if var_386_11.name == "split_4" or not string.find(var_386_11.name, "split") then
						var_386_11.gameObject:SetActive(true)
					else
						var_386_11.gameObject:SetActive(false)
					end
				end
			end

			local var_386_12 = 0.001

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_12 then
				local var_386_13 = (arg_383_1.time_ - var_386_9) / var_386_12
				local var_386_14 = Vector3.New(390, -425, -200)

				var_386_8.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1137, var_386_14, var_386_13)
			end

			if arg_383_1.time_ >= var_386_9 + var_386_12 and arg_383_1.time_ < var_386_9 + var_386_12 + arg_386_0 then
				var_386_8.localPosition = Vector3.New(390, -425, -200)
			end

			local var_386_15 = 0
			local var_386_16 = 0.35

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[15].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_18 = arg_383_1:GetWordFromCfg(425042094)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 14
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_16 or var_386_16 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_16 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22

					if var_386_22 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042094", "story_v_out_425042.awb") ~= 0 then
					local var_386_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042094", "story_v_out_425042.awb") / 1000

					if var_386_23 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_23 + var_386_15
					end

					if var_386_18.prefab_name ~= "" and arg_383_1.actors_[var_386_18.prefab_name] ~= nil then
						local var_386_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_18.prefab_name].transform, "story_v_out_425042", "425042094", "story_v_out_425042.awb")

						arg_383_1:RecordAudio("425042094", var_386_24)
						arg_383_1:RecordAudio("425042094", var_386_24)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_425042", "425042094", "story_v_out_425042.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_425042", "425042094", "story_v_out_425042.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_25 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_25 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_25

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_25 and arg_383_1.time_ < var_386_15 + var_386_25 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play425042095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 425042095
		arg_387_1.duration_ = 5.47

		local var_387_0 = {
			zh = 3.8,
			ja = 5.466
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play425042096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["10127"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10127 == nil then
				arg_387_1.var_.actorSpriteComps10127 = var_390_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_2 = 0.2

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.actorSpriteComps10127 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								local var_390_4 = Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor1.r, var_390_3)
								local var_390_5 = Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor1.g, var_390_3)
								local var_390_6 = Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor1.b, var_390_3)

								iter_390_1.color = Color.New(var_390_4, var_390_5, var_390_6)
							else
								local var_390_7 = Mathf.Lerp(iter_390_1.color.r, 1, var_390_3)

								iter_390_1.color = Color.New(var_390_7, var_390_7, var_390_7)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10127 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_390_3 then
						if arg_387_1.isInRecall_ then
							iter_390_3.color = arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_390_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10127 = nil
			end

			local var_390_8 = arg_387_1.actors_["1137"]
			local var_390_9 = 0

			if var_390_9 < arg_387_1.time_ and arg_387_1.time_ <= var_390_9 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps1137 == nil then
				arg_387_1.var_.actorSpriteComps1137 = var_390_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_10 = 0.2

			if var_390_9 <= arg_387_1.time_ and arg_387_1.time_ < var_390_9 + var_390_10 and not isNil(var_390_8) then
				local var_390_11 = (arg_387_1.time_ - var_390_9) / var_390_10

				if arg_387_1.var_.actorSpriteComps1137 then
					for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_390_5 then
							if arg_387_1.isInRecall_ then
								local var_390_12 = Mathf.Lerp(iter_390_5.color.r, arg_387_1.hightColor2.r, var_390_11)
								local var_390_13 = Mathf.Lerp(iter_390_5.color.g, arg_387_1.hightColor2.g, var_390_11)
								local var_390_14 = Mathf.Lerp(iter_390_5.color.b, arg_387_1.hightColor2.b, var_390_11)

								iter_390_5.color = Color.New(var_390_12, var_390_13, var_390_14)
							else
								local var_390_15 = Mathf.Lerp(iter_390_5.color.r, 0.5, var_390_11)

								iter_390_5.color = Color.New(var_390_15, var_390_15, var_390_15)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_9 + var_390_10 and arg_387_1.time_ < var_390_9 + var_390_10 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps1137 then
				for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_390_7 then
						if arg_387_1.isInRecall_ then
							iter_390_7.color = arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_390_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps1137 = nil
			end

			local var_390_16 = arg_387_1.actors_["10127"].transform
			local var_390_17 = 0

			if var_390_17 < arg_387_1.time_ and arg_387_1.time_ <= var_390_17 + arg_390_0 then
				arg_387_1.var_.moveOldPos10127 = var_390_16.localPosition
				var_390_16.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10127", 2)

				local var_390_18 = var_390_16.childCount

				for iter_390_8 = 0, var_390_18 - 1 do
					local var_390_19 = var_390_16:GetChild(iter_390_8)

					if var_390_19.name == "split_1" or not string.find(var_390_19.name, "split") then
						var_390_19.gameObject:SetActive(true)
					else
						var_390_19.gameObject:SetActive(false)
					end
				end
			end

			local var_390_20 = 0.001

			if var_390_17 <= arg_387_1.time_ and arg_387_1.time_ < var_390_17 + var_390_20 then
				local var_390_21 = (arg_387_1.time_ - var_390_17) / var_390_20
				local var_390_22 = Vector3.New(-390, -387.4, -316.5)

				var_390_16.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10127, var_390_22, var_390_21)
			end

			if arg_387_1.time_ >= var_390_17 + var_390_20 and arg_387_1.time_ < var_390_17 + var_390_20 + arg_390_0 then
				var_390_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_390_23 = 0
			local var_390_24 = 0.55

			if var_390_23 < arg_387_1.time_ and arg_387_1.time_ <= var_390_23 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_25 = arg_387_1:FormatText(StoryNameCfg[236].name)

				arg_387_1.leftNameTxt_.text = var_390_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_26 = arg_387_1:GetWordFromCfg(425042095)
				local var_390_27 = arg_387_1:FormatText(var_390_26.content)

				arg_387_1.text_.text = var_390_27

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_28 = 22
				local var_390_29 = utf8.len(var_390_27)
				local var_390_30 = var_390_28 <= 0 and var_390_24 or var_390_24 * (var_390_29 / var_390_28)

				if var_390_30 > 0 and var_390_24 < var_390_30 then
					arg_387_1.talkMaxDuration = var_390_30

					if var_390_30 + var_390_23 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_30 + var_390_23
					end
				end

				arg_387_1.text_.text = var_390_27
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042095", "story_v_out_425042.awb") ~= 0 then
					local var_390_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042095", "story_v_out_425042.awb") / 1000

					if var_390_31 + var_390_23 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_31 + var_390_23
					end

					if var_390_26.prefab_name ~= "" and arg_387_1.actors_[var_390_26.prefab_name] ~= nil then
						local var_390_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_26.prefab_name].transform, "story_v_out_425042", "425042095", "story_v_out_425042.awb")

						arg_387_1:RecordAudio("425042095", var_390_32)
						arg_387_1:RecordAudio("425042095", var_390_32)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_425042", "425042095", "story_v_out_425042.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_425042", "425042095", "story_v_out_425042.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_33 = math.max(var_390_24, arg_387_1.talkMaxDuration)

			if var_390_23 <= arg_387_1.time_ and arg_387_1.time_ < var_390_23 + var_390_33 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_23) / var_390_33

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_23 + var_390_33 and arg_387_1.time_ < var_390_23 + var_390_33 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play425042096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 425042096
		arg_391_1.duration_ = 11.53

		local var_391_0 = {
			zh = 7.633,
			ja = 11.533
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play425042097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.9

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[236].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(425042096)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 36
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042096", "story_v_out_425042.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042096", "story_v_out_425042.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_425042", "425042096", "story_v_out_425042.awb")

						arg_391_1:RecordAudio("425042096", var_394_9)
						arg_391_1:RecordAudio("425042096", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_425042", "425042096", "story_v_out_425042.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_425042", "425042096", "story_v_out_425042.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play425042097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 425042097
		arg_395_1.duration_ = 9.17

		local var_395_0 = {
			zh = 6.033,
			ja = 9.166
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play425042098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.725

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[236].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:GetWordFromCfg(425042097)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 29
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042097", "story_v_out_425042.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042097", "story_v_out_425042.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_425042", "425042097", "story_v_out_425042.awb")

						arg_395_1:RecordAudio("425042097", var_398_9)
						arg_395_1:RecordAudio("425042097", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_425042", "425042097", "story_v_out_425042.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_425042", "425042097", "story_v_out_425042.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play425042098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 425042098
		arg_399_1.duration_ = 6.2

		local var_399_0 = {
			zh = 6,
			ja = 6.2
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play425042099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1137"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps1137 == nil then
				arg_399_1.var_.actorSpriteComps1137 = var_402_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.actorSpriteComps1137 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								local var_402_4 = Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, var_402_3)
								local var_402_5 = Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, var_402_3)
								local var_402_6 = Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, var_402_3)

								iter_402_1.color = Color.New(var_402_4, var_402_5, var_402_6)
							else
								local var_402_7 = Mathf.Lerp(iter_402_1.color.r, 1, var_402_3)

								iter_402_1.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps1137 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_402_3 then
						if arg_399_1.isInRecall_ then
							iter_402_3.color = arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_402_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps1137 = nil
			end

			local var_402_8 = arg_399_1.actors_["10127"]
			local var_402_9 = 0

			if var_402_9 < arg_399_1.time_ and arg_399_1.time_ <= var_402_9 + arg_402_0 and not isNil(var_402_8) and arg_399_1.var_.actorSpriteComps10127 == nil then
				arg_399_1.var_.actorSpriteComps10127 = var_402_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_10 = 0.2

			if var_402_9 <= arg_399_1.time_ and arg_399_1.time_ < var_402_9 + var_402_10 and not isNil(var_402_8) then
				local var_402_11 = (arg_399_1.time_ - var_402_9) / var_402_10

				if arg_399_1.var_.actorSpriteComps10127 then
					for iter_402_4, iter_402_5 in pairs(arg_399_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_402_5 then
							if arg_399_1.isInRecall_ then
								local var_402_12 = Mathf.Lerp(iter_402_5.color.r, arg_399_1.hightColor2.r, var_402_11)
								local var_402_13 = Mathf.Lerp(iter_402_5.color.g, arg_399_1.hightColor2.g, var_402_11)
								local var_402_14 = Mathf.Lerp(iter_402_5.color.b, arg_399_1.hightColor2.b, var_402_11)

								iter_402_5.color = Color.New(var_402_12, var_402_13, var_402_14)
							else
								local var_402_15 = Mathf.Lerp(iter_402_5.color.r, 0.5, var_402_11)

								iter_402_5.color = Color.New(var_402_15, var_402_15, var_402_15)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_9 + var_402_10 and arg_399_1.time_ < var_402_9 + var_402_10 + arg_402_0 and not isNil(var_402_8) and arg_399_1.var_.actorSpriteComps10127 then
				for iter_402_6, iter_402_7 in pairs(arg_399_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_402_7 then
						if arg_399_1.isInRecall_ then
							iter_402_7.color = arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_402_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps10127 = nil
			end

			local var_402_16 = 0
			local var_402_17 = 0.475

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_18 = arg_399_1:FormatText(StoryNameCfg[15].name)

				arg_399_1.leftNameTxt_.text = var_402_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_19 = arg_399_1:GetWordFromCfg(425042098)
				local var_402_20 = arg_399_1:FormatText(var_402_19.content)

				arg_399_1.text_.text = var_402_20

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_21 = 19
				local var_402_22 = utf8.len(var_402_20)
				local var_402_23 = var_402_21 <= 0 and var_402_17 or var_402_17 * (var_402_22 / var_402_21)

				if var_402_23 > 0 and var_402_17 < var_402_23 then
					arg_399_1.talkMaxDuration = var_402_23

					if var_402_23 + var_402_16 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_23 + var_402_16
					end
				end

				arg_399_1.text_.text = var_402_20
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042098", "story_v_out_425042.awb") ~= 0 then
					local var_402_24 = manager.audio:GetVoiceLength("story_v_out_425042", "425042098", "story_v_out_425042.awb") / 1000

					if var_402_24 + var_402_16 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_24 + var_402_16
					end

					if var_402_19.prefab_name ~= "" and arg_399_1.actors_[var_402_19.prefab_name] ~= nil then
						local var_402_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_19.prefab_name].transform, "story_v_out_425042", "425042098", "story_v_out_425042.awb")

						arg_399_1:RecordAudio("425042098", var_402_25)
						arg_399_1:RecordAudio("425042098", var_402_25)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_425042", "425042098", "story_v_out_425042.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_425042", "425042098", "story_v_out_425042.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_26 = math.max(var_402_17, arg_399_1.talkMaxDuration)

			if var_402_16 <= arg_399_1.time_ and arg_399_1.time_ < var_402_16 + var_402_26 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_16) / var_402_26

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_16 + var_402_26 and arg_399_1.time_ < var_402_16 + var_402_26 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play425042099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 425042099
		arg_403_1.duration_ = 7.47

		local var_403_0 = {
			zh = 6.466,
			ja = 7.466
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play425042100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10127"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10127 == nil then
				arg_403_1.var_.actorSpriteComps10127 = var_406_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_2 = 0.2

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.actorSpriteComps10127 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								local var_406_4 = Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, var_406_3)
								local var_406_5 = Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, var_406_3)
								local var_406_6 = Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, var_406_3)

								iter_406_1.color = Color.New(var_406_4, var_406_5, var_406_6)
							else
								local var_406_7 = Mathf.Lerp(iter_406_1.color.r, 1, var_406_3)

								iter_406_1.color = Color.New(var_406_7, var_406_7, var_406_7)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10127 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_406_3 then
						if arg_403_1.isInRecall_ then
							iter_406_3.color = arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_406_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10127 = nil
			end

			local var_406_8 = arg_403_1.actors_["1137"]
			local var_406_9 = 0

			if var_406_9 < arg_403_1.time_ and arg_403_1.time_ <= var_406_9 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps1137 == nil then
				arg_403_1.var_.actorSpriteComps1137 = var_406_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_10 = 0.2

			if var_406_9 <= arg_403_1.time_ and arg_403_1.time_ < var_406_9 + var_406_10 and not isNil(var_406_8) then
				local var_406_11 = (arg_403_1.time_ - var_406_9) / var_406_10

				if arg_403_1.var_.actorSpriteComps1137 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_406_5 then
							if arg_403_1.isInRecall_ then
								local var_406_12 = Mathf.Lerp(iter_406_5.color.r, arg_403_1.hightColor2.r, var_406_11)
								local var_406_13 = Mathf.Lerp(iter_406_5.color.g, arg_403_1.hightColor2.g, var_406_11)
								local var_406_14 = Mathf.Lerp(iter_406_5.color.b, arg_403_1.hightColor2.b, var_406_11)

								iter_406_5.color = Color.New(var_406_12, var_406_13, var_406_14)
							else
								local var_406_15 = Mathf.Lerp(iter_406_5.color.r, 0.5, var_406_11)

								iter_406_5.color = Color.New(var_406_15, var_406_15, var_406_15)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_9 + var_406_10 and arg_403_1.time_ < var_406_9 + var_406_10 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps1137 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_406_7 then
						if arg_403_1.isInRecall_ then
							iter_406_7.color = arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_406_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps1137 = nil
			end

			local var_406_16 = arg_403_1.actors_["10127"].transform
			local var_406_17 = 0

			if var_406_17 < arg_403_1.time_ and arg_403_1.time_ <= var_406_17 + arg_406_0 then
				arg_403_1.var_.moveOldPos10127 = var_406_16.localPosition
				var_406_16.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10127", 2)

				local var_406_18 = var_406_16.childCount

				for iter_406_8 = 0, var_406_18 - 1 do
					local var_406_19 = var_406_16:GetChild(iter_406_8)

					if var_406_19.name == "split_6" then
						var_406_19:SetAsLastSibling()
						var_406_19.gameObject:SetActive(true)

						arg_403_1.var_.actorSpriteSplit10127 = var_406_19.gameObject:GetComponent(typeof(Image))

						arg_403_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_406_20 = 0.2

			if var_406_17 <= arg_403_1.time_ and arg_403_1.time_ < var_406_17 + var_406_20 then
				local var_406_21 = (arg_403_1.time_ - var_406_17) / var_406_20
				local var_406_22 = Vector3.New(-390, -387.4, -316.5)

				var_406_16.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10127, var_406_22, var_406_21)

				if arg_403_1.var_.actorSpriteSplit10127 ~= nil then
					arg_403_1.var_.actorSpriteSplit10127:SetAlpha(var_406_21)
				end
			end

			if arg_403_1.time_ >= var_406_17 + var_406_20 and arg_403_1.time_ < var_406_17 + var_406_20 + arg_406_0 then
				var_406_16.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_403_1.var_.actorSpriteSplit10127 ~= nil then
					arg_403_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_406_23 = 0
			local var_406_24 = 0.675

			if var_406_23 < arg_403_1.time_ and arg_403_1.time_ <= var_406_23 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_25 = arg_403_1:FormatText(StoryNameCfg[236].name)

				arg_403_1.leftNameTxt_.text = var_406_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_26 = arg_403_1:GetWordFromCfg(425042099)
				local var_406_27 = arg_403_1:FormatText(var_406_26.content)

				arg_403_1.text_.text = var_406_27

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_28 = 27
				local var_406_29 = utf8.len(var_406_27)
				local var_406_30 = var_406_28 <= 0 and var_406_24 or var_406_24 * (var_406_29 / var_406_28)

				if var_406_30 > 0 and var_406_24 < var_406_30 then
					arg_403_1.talkMaxDuration = var_406_30

					if var_406_30 + var_406_23 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_30 + var_406_23
					end
				end

				arg_403_1.text_.text = var_406_27
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042099", "story_v_out_425042.awb") ~= 0 then
					local var_406_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042099", "story_v_out_425042.awb") / 1000

					if var_406_31 + var_406_23 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_31 + var_406_23
					end

					if var_406_26.prefab_name ~= "" and arg_403_1.actors_[var_406_26.prefab_name] ~= nil then
						local var_406_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_26.prefab_name].transform, "story_v_out_425042", "425042099", "story_v_out_425042.awb")

						arg_403_1:RecordAudio("425042099", var_406_32)
						arg_403_1:RecordAudio("425042099", var_406_32)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_425042", "425042099", "story_v_out_425042.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_425042", "425042099", "story_v_out_425042.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_33 = math.max(var_406_24, arg_403_1.talkMaxDuration)

			if var_406_23 <= arg_403_1.time_ and arg_403_1.time_ < var_406_23 + var_406_33 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_23) / var_406_33

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_23 + var_406_33 and arg_403_1.time_ < var_406_23 + var_406_33 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play425042100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 425042100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play425042101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["10127"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos10127 = var_410_0.localPosition
				var_410_0.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10127", 7)

				local var_410_2 = var_410_0.childCount

				for iter_410_0 = 0, var_410_2 - 1 do
					local var_410_3 = var_410_0:GetChild(iter_410_0)

					if var_410_3.name == "split_6" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_4 then
				local var_410_5 = (arg_407_1.time_ - var_410_1) / var_410_4
				local var_410_6 = Vector3.New(0, -2000, 0)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10127, var_410_6, var_410_5)
			end

			if arg_407_1.time_ >= var_410_1 + var_410_4 and arg_407_1.time_ < var_410_1 + var_410_4 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_7 = arg_407_1.actors_["1137"].transform
			local var_410_8 = 0

			if var_410_8 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.var_.moveOldPos1137 = var_410_7.localPosition
				var_410_7.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1137", 7)

				local var_410_9 = var_410_7.childCount

				for iter_410_1 = 0, var_410_9 - 1 do
					local var_410_10 = var_410_7:GetChild(iter_410_1)

					if var_410_10.name == "split_4" or not string.find(var_410_10.name, "split") then
						var_410_10.gameObject:SetActive(true)
					else
						var_410_10.gameObject:SetActive(false)
					end
				end
			end

			local var_410_11 = 0.001

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_11 then
				local var_410_12 = (arg_407_1.time_ - var_410_8) / var_410_11
				local var_410_13 = Vector3.New(0, -2000, 0)

				var_410_7.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1137, var_410_13, var_410_12)
			end

			if arg_407_1.time_ >= var_410_8 + var_410_11 and arg_407_1.time_ < var_410_8 + var_410_11 + arg_410_0 then
				var_410_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_14 = 0
			local var_410_15 = 0.775

			if var_410_14 < arg_407_1.time_ and arg_407_1.time_ <= var_410_14 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_16 = arg_407_1:GetWordFromCfg(425042100)
				local var_410_17 = arg_407_1:FormatText(var_410_16.content)

				arg_407_1.text_.text = var_410_17

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_18 = 31
				local var_410_19 = utf8.len(var_410_17)
				local var_410_20 = var_410_18 <= 0 and var_410_15 or var_410_15 * (var_410_19 / var_410_18)

				if var_410_20 > 0 and var_410_15 < var_410_20 then
					arg_407_1.talkMaxDuration = var_410_20

					if var_410_20 + var_410_14 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_20 + var_410_14
					end
				end

				arg_407_1.text_.text = var_410_17
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_21 = math.max(var_410_15, arg_407_1.talkMaxDuration)

			if var_410_14 <= arg_407_1.time_ and arg_407_1.time_ < var_410_14 + var_410_21 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_14) / var_410_21

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_14 + var_410_21 and arg_407_1.time_ < var_410_14 + var_410_21 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_407_1:InitPlayNodeList()
	end,
	Play425042101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 425042101
		arg_411_1.duration_ = 5.57

		local var_411_0 = {
			zh = 3.166,
			ja = 5.566
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play425042102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1137"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1137 == nil then
				arg_411_1.var_.actorSpriteComps1137 = var_414_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.actorSpriteComps1137 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								local var_414_4 = Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor1.r, var_414_3)
								local var_414_5 = Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor1.g, var_414_3)
								local var_414_6 = Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor1.b, var_414_3)

								iter_414_1.color = Color.New(var_414_4, var_414_5, var_414_6)
							else
								local var_414_7 = Mathf.Lerp(iter_414_1.color.r, 1, var_414_3)

								iter_414_1.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1137 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_414_3 then
						if arg_411_1.isInRecall_ then
							iter_414_3.color = arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_414_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps1137 = nil
			end

			local var_414_8 = arg_411_1.actors_["1137"].transform
			local var_414_9 = 0

			if var_414_9 < arg_411_1.time_ and arg_411_1.time_ <= var_414_9 + arg_414_0 then
				arg_411_1.var_.moveOldPos1137 = var_414_8.localPosition
				var_414_8.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("1137", 4)

				local var_414_10 = var_414_8.childCount

				for iter_414_4 = 0, var_414_10 - 1 do
					local var_414_11 = var_414_8:GetChild(iter_414_4)

					if var_414_11.name == "split_5" or not string.find(var_414_11.name, "split") then
						var_414_11.gameObject:SetActive(true)
					else
						var_414_11.gameObject:SetActive(false)
					end
				end
			end

			local var_414_12 = 0.001

			if var_414_9 <= arg_411_1.time_ and arg_411_1.time_ < var_414_9 + var_414_12 then
				local var_414_13 = (arg_411_1.time_ - var_414_9) / var_414_12
				local var_414_14 = Vector3.New(390, -425, -200)

				var_414_8.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1137, var_414_14, var_414_13)
			end

			if arg_411_1.time_ >= var_414_9 + var_414_12 and arg_411_1.time_ < var_414_9 + var_414_12 + arg_414_0 then
				var_414_8.localPosition = Vector3.New(390, -425, -200)
			end

			local var_414_15 = 0
			local var_414_16 = 0.225

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_17 = arg_411_1:FormatText(StoryNameCfg[15].name)

				arg_411_1.leftNameTxt_.text = var_414_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_18 = arg_411_1:GetWordFromCfg(425042101)
				local var_414_19 = arg_411_1:FormatText(var_414_18.content)

				arg_411_1.text_.text = var_414_19

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_20 = 9
				local var_414_21 = utf8.len(var_414_19)
				local var_414_22 = var_414_20 <= 0 and var_414_16 or var_414_16 * (var_414_21 / var_414_20)

				if var_414_22 > 0 and var_414_16 < var_414_22 then
					arg_411_1.talkMaxDuration = var_414_22

					if var_414_22 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_22 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_19
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042101", "story_v_out_425042.awb") ~= 0 then
					local var_414_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042101", "story_v_out_425042.awb") / 1000

					if var_414_23 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_15
					end

					if var_414_18.prefab_name ~= "" and arg_411_1.actors_[var_414_18.prefab_name] ~= nil then
						local var_414_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_18.prefab_name].transform, "story_v_out_425042", "425042101", "story_v_out_425042.awb")

						arg_411_1:RecordAudio("425042101", var_414_24)
						arg_411_1:RecordAudio("425042101", var_414_24)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_425042", "425042101", "story_v_out_425042.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_425042", "425042101", "story_v_out_425042.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_25 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_25 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_25

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_25 and arg_411_1.time_ < var_414_15 + var_414_25 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
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

		arg_411_1:InitPlayNodeList()
	end,
	Play425042102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 425042102
		arg_415_1.duration_ = 11.17

		local var_415_0 = {
			zh = 5.333,
			ja = 11.166
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play425042103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["10127"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps10127 == nil then
				arg_415_1.var_.actorSpriteComps10127 = var_418_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.actorSpriteComps10127 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								local var_418_4 = Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, var_418_3)
								local var_418_5 = Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, var_418_3)
								local var_418_6 = Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, var_418_3)

								iter_418_1.color = Color.New(var_418_4, var_418_5, var_418_6)
							else
								local var_418_7 = Mathf.Lerp(iter_418_1.color.r, 1, var_418_3)

								iter_418_1.color = Color.New(var_418_7, var_418_7, var_418_7)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps10127 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_418_3 then
						if arg_415_1.isInRecall_ then
							iter_418_3.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps10127 = nil
			end

			local var_418_8 = arg_415_1.actors_["1137"]
			local var_418_9 = 0

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 and not isNil(var_418_8) and arg_415_1.var_.actorSpriteComps1137 == nil then
				arg_415_1.var_.actorSpriteComps1137 = var_418_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_10 = 0.2

			if var_418_9 <= arg_415_1.time_ and arg_415_1.time_ < var_418_9 + var_418_10 and not isNil(var_418_8) then
				local var_418_11 = (arg_415_1.time_ - var_418_9) / var_418_10

				if arg_415_1.var_.actorSpriteComps1137 then
					for iter_418_4, iter_418_5 in pairs(arg_415_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_418_5 then
							if arg_415_1.isInRecall_ then
								local var_418_12 = Mathf.Lerp(iter_418_5.color.r, arg_415_1.hightColor2.r, var_418_11)
								local var_418_13 = Mathf.Lerp(iter_418_5.color.g, arg_415_1.hightColor2.g, var_418_11)
								local var_418_14 = Mathf.Lerp(iter_418_5.color.b, arg_415_1.hightColor2.b, var_418_11)

								iter_418_5.color = Color.New(var_418_12, var_418_13, var_418_14)
							else
								local var_418_15 = Mathf.Lerp(iter_418_5.color.r, 0.5, var_418_11)

								iter_418_5.color = Color.New(var_418_15, var_418_15, var_418_15)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_9 + var_418_10 and arg_415_1.time_ < var_418_9 + var_418_10 + arg_418_0 and not isNil(var_418_8) and arg_415_1.var_.actorSpriteComps1137 then
				for iter_418_6, iter_418_7 in pairs(arg_415_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_418_7 then
						if arg_415_1.isInRecall_ then
							iter_418_7.color = arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_418_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps1137 = nil
			end

			local var_418_16 = arg_415_1.actors_["10127"].transform
			local var_418_17 = 0

			if var_418_17 < arg_415_1.time_ and arg_415_1.time_ <= var_418_17 + arg_418_0 then
				arg_415_1.var_.moveOldPos10127 = var_418_16.localPosition
				var_418_16.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10127", 2)

				local var_418_18 = var_418_16.childCount

				for iter_418_8 = 0, var_418_18 - 1 do
					local var_418_19 = var_418_16:GetChild(iter_418_8)

					if var_418_19.name == "split_4" or not string.find(var_418_19.name, "split") then
						var_418_19.gameObject:SetActive(true)
					else
						var_418_19.gameObject:SetActive(false)
					end
				end
			end

			local var_418_20 = 0.001

			if var_418_17 <= arg_415_1.time_ and arg_415_1.time_ < var_418_17 + var_418_20 then
				local var_418_21 = (arg_415_1.time_ - var_418_17) / var_418_20
				local var_418_22 = Vector3.New(-390, -387.4, -316.5)

				var_418_16.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10127, var_418_22, var_418_21)
			end

			if arg_415_1.time_ >= var_418_17 + var_418_20 and arg_415_1.time_ < var_418_17 + var_418_20 + arg_418_0 then
				var_418_16.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_418_23 = 0
			local var_418_24 = 0.525

			if var_418_23 < arg_415_1.time_ and arg_415_1.time_ <= var_418_23 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_25 = arg_415_1:FormatText(StoryNameCfg[236].name)

				arg_415_1.leftNameTxt_.text = var_418_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_26 = arg_415_1:GetWordFromCfg(425042102)
				local var_418_27 = arg_415_1:FormatText(var_418_26.content)

				arg_415_1.text_.text = var_418_27

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_28 = 21
				local var_418_29 = utf8.len(var_418_27)
				local var_418_30 = var_418_28 <= 0 and var_418_24 or var_418_24 * (var_418_29 / var_418_28)

				if var_418_30 > 0 and var_418_24 < var_418_30 then
					arg_415_1.talkMaxDuration = var_418_30

					if var_418_30 + var_418_23 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_30 + var_418_23
					end
				end

				arg_415_1.text_.text = var_418_27
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042102", "story_v_out_425042.awb") ~= 0 then
					local var_418_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042102", "story_v_out_425042.awb") / 1000

					if var_418_31 + var_418_23 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_31 + var_418_23
					end

					if var_418_26.prefab_name ~= "" and arg_415_1.actors_[var_418_26.prefab_name] ~= nil then
						local var_418_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_26.prefab_name].transform, "story_v_out_425042", "425042102", "story_v_out_425042.awb")

						arg_415_1:RecordAudio("425042102", var_418_32)
						arg_415_1:RecordAudio("425042102", var_418_32)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_425042", "425042102", "story_v_out_425042.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_425042", "425042102", "story_v_out_425042.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_33 = math.max(var_418_24, arg_415_1.talkMaxDuration)

			if var_418_23 <= arg_415_1.time_ and arg_415_1.time_ < var_418_23 + var_418_33 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_23) / var_418_33

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_23 + var_418_33 and arg_415_1.time_ < var_418_23 + var_418_33 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play425042103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 425042103
		arg_419_1.duration_ = 5.8

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play425042104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1137"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1137 = var_422_0.localPosition
				var_422_0.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("1137", 7)

				local var_422_2 = var_422_0.childCount

				for iter_422_0 = 0, var_422_2 - 1 do
					local var_422_3 = var_422_0:GetChild(iter_422_0)

					if var_422_3.name == "" or not string.find(var_422_3.name, "split") then
						var_422_3.gameObject:SetActive(true)
					else
						var_422_3.gameObject:SetActive(false)
					end
				end
			end

			local var_422_4 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_4 then
				local var_422_5 = (arg_419_1.time_ - var_422_1) / var_422_4
				local var_422_6 = Vector3.New(0, -2000, 0)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1137, var_422_6, var_422_5)
			end

			if arg_419_1.time_ >= var_422_1 + var_422_4 and arg_419_1.time_ < var_422_1 + var_422_4 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_422_7 = arg_419_1.actors_["10127"].transform
			local var_422_8 = 0

			if var_422_8 < arg_419_1.time_ and arg_419_1.time_ <= var_422_8 + arg_422_0 then
				arg_419_1.var_.moveOldPos10127 = var_422_7.localPosition
				var_422_7.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("10127", 7)

				local var_422_9 = var_422_7.childCount

				for iter_422_1 = 0, var_422_9 - 1 do
					local var_422_10 = var_422_7:GetChild(iter_422_1)

					if var_422_10.name == "" or not string.find(var_422_10.name, "split") then
						var_422_10.gameObject:SetActive(true)
					else
						var_422_10.gameObject:SetActive(false)
					end
				end
			end

			local var_422_11 = 0.001

			if var_422_8 <= arg_419_1.time_ and arg_419_1.time_ < var_422_8 + var_422_11 then
				local var_422_12 = (arg_419_1.time_ - var_422_8) / var_422_11
				local var_422_13 = Vector3.New(0, -2000, 0)

				var_422_7.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10127, var_422_13, var_422_12)
			end

			if arg_419_1.time_ >= var_422_8 + var_422_11 and arg_419_1.time_ < var_422_8 + var_422_11 + arg_422_0 then
				var_422_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_422_14 = manager.ui.mainCamera.transform
			local var_422_15 = 0.366666666666667

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				local var_422_16 = arg_419_1.var_.effect10091009
				local var_422_17
				local var_422_18 = var_422_14

				if not var_422_16 then
					var_422_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_422_18)
					var_422_16.name = "1009"
					arg_419_1.var_.effect10091009 = var_422_16
				else
					var_422_16.transform:SetParent(var_422_18)
				end

				var_422_16.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_422_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_422_19 = manager.ui.mainCamera.transform
			local var_422_20 = 4.7

			if var_422_20 < arg_419_1.time_ and arg_419_1.time_ <= var_422_20 + arg_422_0 then
				local var_422_21 = arg_419_1.var_.effect10091009

				if var_422_21 then
					Object.Destroy(var_422_21)

					arg_419_1.var_.effect10091009 = nil
				end
			end

			local var_422_22 = manager.ui.mainCamera.transform
			local var_422_23 = 0.366666666666667

			if var_422_23 < arg_419_1.time_ and arg_419_1.time_ <= var_422_23 + arg_422_0 then
				arg_419_1.var_.shakeOldPos = var_422_22.localPosition
			end

			local var_422_24 = 0.633333333333333

			if var_422_23 <= arg_419_1.time_ and arg_419_1.time_ < var_422_23 + var_422_24 then
				local var_422_25 = (arg_419_1.time_ - var_422_23) / 0.066
				local var_422_26, var_422_27 = math.modf(var_422_25)

				var_422_22.localPosition = Vector3.New(var_422_27 * 0.13, var_422_27 * 0.13, var_422_27 * 0.13) + arg_419_1.var_.shakeOldPos
			end

			if arg_419_1.time_ >= var_422_23 + var_422_24 and arg_419_1.time_ < var_422_23 + var_422_24 + arg_422_0 then
				var_422_22.localPosition = arg_419_1.var_.shakeOldPos
			end

			local var_422_28
			local var_422_29 = 1

			if var_422_29 < arg_419_1.time_ and arg_419_1.time_ <= var_422_29 + arg_422_0 then
				local var_422_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_30 then
					var_422_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_30.radialBlurScale = 0.3
					var_422_30.radialBlurGradient = 1
					var_422_30.radialBlurIntensity = 0.4

					if var_422_28 then
						var_422_30.radialBlurTarget = var_422_28.transform
					end
				end
			end

			local var_422_31 = 2.174999999998

			if var_422_29 <= arg_419_1.time_ and arg_419_1.time_ < var_422_29 + var_422_31 then
				local var_422_32 = (arg_419_1.time_ - var_422_29) / var_422_31
				local var_422_33 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_33 then
					var_422_33.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_33.radialBlurScale = Mathf.Lerp(0.3, 0.8, var_422_32)
					var_422_33.radialBlurGradient = Mathf.Lerp(1, 1, var_422_32)
					var_422_33.radialBlurIntensity = Mathf.Lerp(0.4, 0.8, var_422_32)
				end
			end

			if arg_419_1.time_ >= var_422_29 + var_422_31 and arg_419_1.time_ < var_422_29 + var_422_31 + arg_422_0 then
				local var_422_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_34 then
					var_422_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_34.radialBlurScale = 0.8
					var_422_34.radialBlurGradient = 1
					var_422_34.radialBlurIntensity = 0.8
				end
			end

			local var_422_35 = 0.212537501240149
			local var_422_36 = 1

			if var_422_35 < arg_419_1.time_ and arg_419_1.time_ <= var_422_35 + arg_422_0 then
				local var_422_37 = "play"
				local var_422_38 = "effect"

				arg_419_1:AudioAction(var_422_37, var_422_38, "se_story_147", "se_story_147_electric_shock_01", "")
			end

			local var_422_39 = 0.5
			local var_422_40 = 1

			if var_422_39 < arg_419_1.time_ and arg_419_1.time_ <= var_422_39 + arg_422_0 then
				local var_422_41 = "play"
				local var_422_42 = "effect"

				arg_419_1:AudioAction(var_422_41, var_422_42, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_422_43 = 0.366666666666667
			local var_422_44 = 1

			if var_422_43 < arg_419_1.time_ and arg_419_1.time_ <= var_422_43 + arg_422_0 then
				local var_422_45 = "stop"
				local var_422_46 = "effect"

				arg_419_1:AudioAction(var_422_45, var_422_46, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_422_47 = 0
			local var_422_48 = 1.125

			if var_422_47 < arg_419_1.time_ and arg_419_1.time_ <= var_422_47 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_49 = arg_419_1:GetWordFromCfg(425042103)
				local var_422_50 = arg_419_1:FormatText(var_422_49.content)

				arg_419_1.text_.text = var_422_50

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_51 = 45
				local var_422_52 = utf8.len(var_422_50)
				local var_422_53 = var_422_51 <= 0 and var_422_48 or var_422_48 * (var_422_52 / var_422_51)

				if var_422_53 > 0 and var_422_48 < var_422_53 then
					arg_419_1.talkMaxDuration = var_422_53

					if var_422_53 + var_422_47 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_53 + var_422_47
					end
				end

				arg_419_1.text_.text = var_422_50
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_54 = math.max(var_422_48, arg_419_1.talkMaxDuration)

			if var_422_47 <= arg_419_1.time_ and arg_419_1.time_ < var_422_47 + var_422_54 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_47) / var_422_54

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_47 + var_422_54 and arg_419_1.time_ < var_422_47 + var_422_54 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play425042104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 425042104
		arg_423_1.duration_ = 10.6

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play425042105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_1 = 1.2

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_1 then
				local var_426_2 = (arg_423_1.time_ - var_426_0) / var_426_1
				local var_426_3 = Color.New(0, 0, 0)

				var_426_3.a = Mathf.Lerp(0, 1, var_426_2)
				arg_423_1.mask_.color = var_426_3
			end

			if arg_423_1.time_ >= var_426_0 + var_426_1 and arg_423_1.time_ < var_426_0 + var_426_1 + arg_426_0 then
				local var_426_4 = Color.New(0, 0, 0)

				var_426_4.a = 1
				arg_423_1.mask_.color = var_426_4
			end

			local var_426_5 = 1.2

			if var_426_5 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_6 = 1.2

			if var_426_5 <= arg_423_1.time_ and arg_423_1.time_ < var_426_5 + var_426_6 then
				local var_426_7 = (arg_423_1.time_ - var_426_5) / var_426_6
				local var_426_8 = Color.New(0, 0, 0)

				var_426_8.a = Mathf.Lerp(1, 0, var_426_7)
				arg_423_1.mask_.color = var_426_8
			end

			if arg_423_1.time_ >= var_426_5 + var_426_6 and arg_423_1.time_ < var_426_5 + var_426_6 + arg_426_0 then
				local var_426_9 = Color.New(0, 0, 0)
				local var_426_10 = 0

				arg_423_1.mask_.enabled = false
				var_426_9.a = var_426_10
				arg_423_1.mask_.color = var_426_9
			end

			local var_426_11 = 5.60000033333333

			if var_426_11 < arg_423_1.time_ and arg_423_1.time_ <= var_426_11 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			local var_426_12 = 0.3

			if arg_423_1.time_ >= var_426_11 + var_426_12 and arg_423_1.time_ < var_426_11 + var_426_12 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_13 = 1.2
			local var_426_14 = 1.999999999999
			local var_426_15 = "ST2402"

			if var_426_13 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1.timestampController_:SetSelectedState("show")
				arg_423_1.timestampAni_:Play("in")

				arg_423_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_426_15)

				arg_423_1.timestampColorController_:SetSelectedState("cold")
				arg_423_1.timeColdImg_:SetAlpha(0.031)

				local var_426_16 = arg_423_1:GetWordFromCfg(501106)
				local var_426_17 = arg_423_1:FormatText(var_426_16.content)

				arg_423_1.text_timeText_.text = var_426_17

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_timeText_)

				local var_426_18 = arg_423_1:GetWordFromCfg(501107)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_siteText_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_siteText_)
			end

			if arg_423_1.time_ >= var_426_13 + var_426_14 and arg_423_1.time_ < var_426_13 + var_426_14 + arg_426_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_423_1.timestampAni_, "out", function()
					arg_423_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_426_20 = 3.20000033333333

			if var_426_20 < arg_423_1.time_ and arg_423_1.time_ <= var_426_20 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_21 = 1.2

			if var_426_20 <= arg_423_1.time_ and arg_423_1.time_ < var_426_20 + var_426_21 then
				local var_426_22 = (arg_423_1.time_ - var_426_20) / var_426_21
				local var_426_23 = Color.New(0, 0, 0)

				var_426_23.a = Mathf.Lerp(0, 1, var_426_22)
				arg_423_1.mask_.color = var_426_23
			end

			if arg_423_1.time_ >= var_426_20 + var_426_21 and arg_423_1.time_ < var_426_20 + var_426_21 + arg_426_0 then
				local var_426_24 = Color.New(0, 0, 0)

				var_426_24.a = 1
				arg_423_1.mask_.color = var_426_24
			end

			local var_426_25 = 4.40000033333333

			if var_426_25 < arg_423_1.time_ and arg_423_1.time_ <= var_426_25 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_26 = 1.2

			if var_426_25 <= arg_423_1.time_ and arg_423_1.time_ < var_426_25 + var_426_26 then
				local var_426_27 = (arg_423_1.time_ - var_426_25) / var_426_26
				local var_426_28 = Color.New(0, 0, 0)

				var_426_28.a = Mathf.Lerp(1, 0, var_426_27)
				arg_423_1.mask_.color = var_426_28
			end

			if arg_423_1.time_ >= var_426_25 + var_426_26 and arg_423_1.time_ < var_426_25 + var_426_26 + arg_426_0 then
				local var_426_29 = Color.New(0, 0, 0)
				local var_426_30 = 0

				arg_423_1.mask_.enabled = false
				var_426_29.a = var_426_30
				arg_423_1.mask_.color = var_426_29
			end

			local var_426_31 = "ST2402"

			if arg_423_1.bgs_[var_426_31] == nil then
				local var_426_32 = Object.Instantiate(arg_423_1.paintGo_)

				var_426_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_426_31)
				var_426_32.name = var_426_31
				var_426_32.transform.parent = arg_423_1.stage_.transform
				var_426_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.bgs_[var_426_31] = var_426_32
			end

			local var_426_33 = 1.2

			if var_426_33 < arg_423_1.time_ and arg_423_1.time_ <= var_426_33 + arg_426_0 then
				local var_426_34 = manager.ui.mainCamera.transform.localPosition
				local var_426_35 = Vector3.New(0, 0, 10) + Vector3.New(var_426_34.x, var_426_34.y, 0)
				local var_426_36 = arg_423_1.bgs_.ST2402

				var_426_36.transform.localPosition = var_426_35
				var_426_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_37 = var_426_36:GetComponent("SpriteRenderer")

				if var_426_37 and var_426_37.sprite then
					local var_426_38 = (var_426_36.transform.localPosition - var_426_34).z
					local var_426_39 = manager.ui.mainCameraCom_
					local var_426_40 = 2 * var_426_38 * Mathf.Tan(var_426_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_426_41 = var_426_40 * var_426_39.aspect
					local var_426_42 = var_426_37.sprite.bounds.size.x
					local var_426_43 = var_426_37.sprite.bounds.size.y
					local var_426_44 = var_426_41 / var_426_42
					local var_426_45 = var_426_40 / var_426_43
					local var_426_46 = var_426_45 < var_426_44 and var_426_44 or var_426_45

					var_426_36.transform.localScale = Vector3.New(var_426_46, var_426_46, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST2402" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_47 = 0
			local var_426_48 = 1

			if var_426_47 < arg_423_1.time_ and arg_423_1.time_ <= var_426_47 + arg_426_0 then
				local var_426_49 = "play"
				local var_426_50 = "effect"

				arg_423_1:AudioAction(var_426_49, var_426_50, "se_story_141", "se_story_141_unreal", "")
			end

			local var_426_51 = 4.3
			local var_426_52 = 1

			if var_426_51 < arg_423_1.time_ and arg_423_1.time_ <= var_426_51 + arg_426_0 then
				local var_426_53 = "play"
				local var_426_54 = "effect"

				arg_423_1:AudioAction(var_426_53, var_426_54, "se_story_140", "se_story_140_amb_unreal", "")
			end

			local var_426_55 = 0
			local var_426_56 = 1

			if var_426_55 < arg_423_1.time_ and arg_423_1.time_ <= var_426_55 + arg_426_0 then
				local var_426_57 = "stop"
				local var_426_58 = "effect"

				arg_423_1:AudioAction(var_426_57, var_426_58, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_59 = 5.60000033333333
			local var_426_60 = 1.1

			if var_426_59 < arg_423_1.time_ and arg_423_1.time_ <= var_426_59 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_61 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_61:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_423_1.dialogCg_.alpha = arg_428_0
				end))
				var_426_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_62 = arg_423_1:GetWordFromCfg(425042104)
				local var_426_63 = arg_423_1:FormatText(var_426_62.content)

				arg_423_1.text_.text = var_426_63

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_64 = 44
				local var_426_65 = utf8.len(var_426_63)
				local var_426_66 = var_426_64 <= 0 and var_426_60 or var_426_60 * (var_426_65 / var_426_64)

				if var_426_66 > 0 and var_426_60 < var_426_66 then
					arg_423_1.talkMaxDuration = var_426_66
					var_426_59 = var_426_59 + 0.3

					if var_426_66 + var_426_59 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_66 + var_426_59
					end
				end

				arg_423_1.text_.text = var_426_63
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_67 = var_426_59 + 0.3
			local var_426_68 = math.max(var_426_60, arg_423_1.talkMaxDuration)

			if var_426_67 <= arg_423_1.time_ and arg_423_1.time_ < var_426_67 + var_426_68 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_67) / var_426_68

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_67 + var_426_68 and arg_423_1.time_ < var_426_67 + var_426_68 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play425042105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 425042105
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play425042106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				local var_433_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_2 then
					var_433_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_2.radialBlurScale = 0.8
					var_433_2.radialBlurGradient = 1
					var_433_2.radialBlurIntensity = 0.8

					if var_433_0 then
						var_433_2.radialBlurTarget = var_433_0.transform
					end
				end
			end

			local var_433_3 = 1

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_3 then
				local var_433_4 = (arg_430_1.time_ - var_433_1) / var_433_3
				local var_433_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_5 then
					var_433_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_5.radialBlurScale = Mathf.Lerp(0.8, 0, var_433_4)
					var_433_5.radialBlurGradient = Mathf.Lerp(1, 1, var_433_4)
					var_433_5.radialBlurIntensity = Mathf.Lerp(0.8, 0, var_433_4)
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_3 and arg_430_1.time_ < var_433_1 + var_433_3 + arg_433_0 then
				local var_433_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_6 then
					var_433_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_6.radialBlurScale = 0
					var_433_6.radialBlurGradient = 1
					var_433_6.radialBlurIntensity = 0
				end
			end

			local var_433_7 = 0
			local var_433_8 = 1

			if var_433_7 < arg_430_1.time_ and arg_430_1.time_ <= var_433_7 + arg_433_0 then
				local var_433_9 = "stop"
				local var_433_10 = "effect"

				arg_430_1:AudioAction(var_433_9, var_433_10, "se_story_140", "se_story_140_amb_unreal", "")
			end

			local var_433_11 = 0.1
			local var_433_12 = 1

			if var_433_11 < arg_430_1.time_ and arg_430_1.time_ <= var_433_11 + arg_433_0 then
				local var_433_13 = "play"
				local var_433_14 = "effect"

				arg_430_1:AudioAction(var_433_13, var_433_14, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_433_15 = 0
			local var_433_16 = 1.125

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_17 = arg_430_1:GetWordFromCfg(425042105)
				local var_433_18 = arg_430_1:FormatText(var_433_17.content)

				arg_430_1.text_.text = var_433_18

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_19 = 45
				local var_433_20 = utf8.len(var_433_18)
				local var_433_21 = var_433_19 <= 0 and var_433_16 or var_433_16 * (var_433_20 / var_433_19)

				if var_433_21 > 0 and var_433_16 < var_433_21 then
					arg_430_1.talkMaxDuration = var_433_21

					if var_433_21 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_21 + var_433_15
					end
				end

				arg_430_1.text_.text = var_433_18
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_22 = math.max(var_433_16, arg_430_1.talkMaxDuration)

			if var_433_15 <= arg_430_1.time_ and arg_430_1.time_ < var_433_15 + var_433_22 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_15) / var_433_22

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_15 + var_433_22 and arg_430_1.time_ < var_433_15 + var_433_22 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play425042106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 425042106
		arg_434_1.duration_ = 1.77

		local var_434_0 = {
			zh = 1.333,
			ja = 1.766
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
				arg_434_0:Play425042107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1137"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.actorSpriteComps1137 == nil then
				arg_434_1.var_.actorSpriteComps1137 = var_437_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_2 = 0.2

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.actorSpriteComps1137 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.actorSpriteComps1137 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_437_3 then
						if arg_434_1.isInRecall_ then
							iter_437_3.color = arg_434_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_437_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_434_1.var_.actorSpriteComps1137 = nil
			end

			local var_437_8 = arg_434_1.actors_["1137"].transform
			local var_437_9 = 0

			if var_437_9 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 then
				arg_434_1.var_.moveOldPos1137 = var_437_8.localPosition
				var_437_8.localScale = Vector3.New(1, 1, 1)

				arg_434_1:CheckSpriteTmpPos("1137", 3)

				local var_437_10 = var_437_8.childCount

				for iter_437_4 = 0, var_437_10 - 1 do
					local var_437_11 = var_437_8:GetChild(iter_437_4)

					if var_437_11.name == "split_5" or not string.find(var_437_11.name, "split") then
						var_437_11.gameObject:SetActive(true)
					else
						var_437_11.gameObject:SetActive(false)
					end
				end
			end

			local var_437_12 = 0.001

			if var_437_9 <= arg_434_1.time_ and arg_434_1.time_ < var_437_9 + var_437_12 then
				local var_437_13 = (arg_434_1.time_ - var_437_9) / var_437_12
				local var_437_14 = Vector3.New(0, -425, -200)

				var_437_8.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1137, var_437_14, var_437_13)
			end

			if arg_434_1.time_ >= var_437_9 + var_437_12 and arg_434_1.time_ < var_437_9 + var_437_12 + arg_437_0 then
				var_437_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_437_15 = 0
			local var_437_16 = 0.1

			if var_437_15 < arg_434_1.time_ and arg_434_1.time_ <= var_437_15 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_17 = arg_434_1:FormatText(StoryNameCfg[15].name)

				arg_434_1.leftNameTxt_.text = var_437_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_18 = arg_434_1:GetWordFromCfg(425042106)
				local var_437_19 = arg_434_1:FormatText(var_437_18.content)

				arg_434_1.text_.text = var_437_19

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_20 = 4
				local var_437_21 = utf8.len(var_437_19)
				local var_437_22 = var_437_20 <= 0 and var_437_16 or var_437_16 * (var_437_21 / var_437_20)

				if var_437_22 > 0 and var_437_16 < var_437_22 then
					arg_434_1.talkMaxDuration = var_437_22

					if var_437_22 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_22 + var_437_15
					end
				end

				arg_434_1.text_.text = var_437_19
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042106", "story_v_out_425042.awb") ~= 0 then
					local var_437_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042106", "story_v_out_425042.awb") / 1000

					if var_437_23 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_23 + var_437_15
					end

					if var_437_18.prefab_name ~= "" and arg_434_1.actors_[var_437_18.prefab_name] ~= nil then
						local var_437_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_18.prefab_name].transform, "story_v_out_425042", "425042106", "story_v_out_425042.awb")

						arg_434_1:RecordAudio("425042106", var_437_24)
						arg_434_1:RecordAudio("425042106", var_437_24)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_425042", "425042106", "story_v_out_425042.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_425042", "425042106", "story_v_out_425042.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_25 = math.max(var_437_16, arg_434_1.talkMaxDuration)

			if var_437_15 <= arg_434_1.time_ and arg_434_1.time_ < var_437_15 + var_437_25 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_15) / var_437_25

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_15 + var_437_25 and arg_434_1.time_ < var_437_15 + var_437_25 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
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

		arg_434_1:InitPlayNodeList()
	end,
	Play425042107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 425042107
		arg_438_1.duration_ = 4.03

		local var_438_0 = {
			zh = 3.4,
			ja = 4.033
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play425042108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = "10157"

			if arg_438_1.actors_[var_441_0] == nil then
				local var_441_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10157")

				if not isNil(var_441_1) then
					local var_441_2 = Object.Instantiate(var_441_1, arg_438_1.canvasGo_.transform)

					var_441_2.transform:SetSiblingIndex(1)

					var_441_2.name = var_441_0
					var_441_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_438_1.actors_[var_441_0] = var_441_2

					local var_441_3 = var_441_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_438_1.isInRecall_ then
						for iter_441_0, iter_441_1 in ipairs(var_441_3) do
							iter_441_1.color = arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_441_4 = arg_438_1.actors_["10157"]
			local var_441_5 = 0

			if var_441_5 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.actorSpriteComps10157 == nil then
				arg_438_1.var_.actorSpriteComps10157 = var_441_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_6 = 0.2

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_6 and not isNil(var_441_4) then
				local var_441_7 = (arg_438_1.time_ - var_441_5) / var_441_6

				if arg_438_1.var_.actorSpriteComps10157 then
					for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_441_3 then
							if arg_438_1.isInRecall_ then
								local var_441_8 = Mathf.Lerp(iter_441_3.color.r, arg_438_1.hightColor1.r, var_441_7)
								local var_441_9 = Mathf.Lerp(iter_441_3.color.g, arg_438_1.hightColor1.g, var_441_7)
								local var_441_10 = Mathf.Lerp(iter_441_3.color.b, arg_438_1.hightColor1.b, var_441_7)

								iter_441_3.color = Color.New(var_441_8, var_441_9, var_441_10)
							else
								local var_441_11 = Mathf.Lerp(iter_441_3.color.r, 1, var_441_7)

								iter_441_3.color = Color.New(var_441_11, var_441_11, var_441_11)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= var_441_5 + var_441_6 and arg_438_1.time_ < var_441_5 + var_441_6 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.actorSpriteComps10157 then
				for iter_441_4, iter_441_5 in pairs(arg_438_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_441_5 then
						if arg_438_1.isInRecall_ then
							iter_441_5.color = arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_441_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_438_1.var_.actorSpriteComps10157 = nil
			end

			local var_441_12 = arg_438_1.actors_["1137"]
			local var_441_13 = 0

			if var_441_13 < arg_438_1.time_ and arg_438_1.time_ <= var_441_13 + arg_441_0 and not isNil(var_441_12) and arg_438_1.var_.actorSpriteComps1137 == nil then
				arg_438_1.var_.actorSpriteComps1137 = var_441_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_14 = 0.2

			if var_441_13 <= arg_438_1.time_ and arg_438_1.time_ < var_441_13 + var_441_14 and not isNil(var_441_12) then
				local var_441_15 = (arg_438_1.time_ - var_441_13) / var_441_14

				if arg_438_1.var_.actorSpriteComps1137 then
					for iter_441_6, iter_441_7 in pairs(arg_438_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_441_7 then
							if arg_438_1.isInRecall_ then
								local var_441_16 = Mathf.Lerp(iter_441_7.color.r, arg_438_1.hightColor2.r, var_441_15)
								local var_441_17 = Mathf.Lerp(iter_441_7.color.g, arg_438_1.hightColor2.g, var_441_15)
								local var_441_18 = Mathf.Lerp(iter_441_7.color.b, arg_438_1.hightColor2.b, var_441_15)

								iter_441_7.color = Color.New(var_441_16, var_441_17, var_441_18)
							else
								local var_441_19 = Mathf.Lerp(iter_441_7.color.r, 0.5, var_441_15)

								iter_441_7.color = Color.New(var_441_19, var_441_19, var_441_19)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= var_441_13 + var_441_14 and arg_438_1.time_ < var_441_13 + var_441_14 + arg_441_0 and not isNil(var_441_12) and arg_438_1.var_.actorSpriteComps1137 then
				for iter_441_8, iter_441_9 in pairs(arg_438_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_441_9 then
						if arg_438_1.isInRecall_ then
							iter_441_9.color = arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_441_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_438_1.var_.actorSpriteComps1137 = nil
			end

			local var_441_20 = arg_438_1.actors_["10157"].transform
			local var_441_21 = 0

			if var_441_21 < arg_438_1.time_ and arg_438_1.time_ <= var_441_21 + arg_441_0 then
				arg_438_1.var_.moveOldPos10157 = var_441_20.localPosition
				var_441_20.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("10157", 4)

				local var_441_22 = var_441_20.childCount

				for iter_441_10 = 0, var_441_22 - 1 do
					local var_441_23 = var_441_20:GetChild(iter_441_10)

					if var_441_23.name == "" or not string.find(var_441_23.name, "split") then
						var_441_23.gameObject:SetActive(true)
					else
						var_441_23.gameObject:SetActive(false)
					end
				end
			end

			local var_441_24 = 0.001

			if var_441_21 <= arg_438_1.time_ and arg_438_1.time_ < var_441_21 + var_441_24 then
				local var_441_25 = (arg_438_1.time_ - var_441_21) / var_441_24
				local var_441_26 = Vector3.New(390, -408, 115)

				var_441_20.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos10157, var_441_26, var_441_25)
			end

			if arg_438_1.time_ >= var_441_21 + var_441_24 and arg_438_1.time_ < var_441_21 + var_441_24 + arg_441_0 then
				var_441_20.localPosition = Vector3.New(390, -408, 115)
			end

			local var_441_27 = arg_438_1.actors_["1137"].transform
			local var_441_28 = 0

			if var_441_28 < arg_438_1.time_ and arg_438_1.time_ <= var_441_28 + arg_441_0 then
				arg_438_1.var_.moveOldPos1137 = var_441_27.localPosition
				var_441_27.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("1137", 2)

				local var_441_29 = var_441_27.childCount

				for iter_441_11 = 0, var_441_29 - 1 do
					local var_441_30 = var_441_27:GetChild(iter_441_11)

					if var_441_30.name == "split_5" or not string.find(var_441_30.name, "split") then
						var_441_30.gameObject:SetActive(true)
					else
						var_441_30.gameObject:SetActive(false)
					end
				end
			end

			local var_441_31 = 0.001

			if var_441_28 <= arg_438_1.time_ and arg_438_1.time_ < var_441_28 + var_441_31 then
				local var_441_32 = (arg_438_1.time_ - var_441_28) / var_441_31
				local var_441_33 = Vector3.New(-390, -425, -200)

				var_441_27.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1137, var_441_33, var_441_32)
			end

			if arg_438_1.time_ >= var_441_28 + var_441_31 and arg_438_1.time_ < var_441_28 + var_441_31 + arg_441_0 then
				var_441_27.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_441_34 = 0
			local var_441_35 = 0.3

			if var_441_34 < arg_438_1.time_ and arg_438_1.time_ <= var_441_34 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_36 = arg_438_1:FormatText(StoryNameCfg[1434].name)

				arg_438_1.leftNameTxt_.text = var_441_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_37 = arg_438_1:GetWordFromCfg(425042107)
				local var_441_38 = arg_438_1:FormatText(var_441_37.content)

				arg_438_1.text_.text = var_441_38

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_39 = 12
				local var_441_40 = utf8.len(var_441_38)
				local var_441_41 = var_441_39 <= 0 and var_441_35 or var_441_35 * (var_441_40 / var_441_39)

				if var_441_41 > 0 and var_441_35 < var_441_41 then
					arg_438_1.talkMaxDuration = var_441_41

					if var_441_41 + var_441_34 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_41 + var_441_34
					end
				end

				arg_438_1.text_.text = var_441_38
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042107", "story_v_out_425042.awb") ~= 0 then
					local var_441_42 = manager.audio:GetVoiceLength("story_v_out_425042", "425042107", "story_v_out_425042.awb") / 1000

					if var_441_42 + var_441_34 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_42 + var_441_34
					end

					if var_441_37.prefab_name ~= "" and arg_438_1.actors_[var_441_37.prefab_name] ~= nil then
						local var_441_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_37.prefab_name].transform, "story_v_out_425042", "425042107", "story_v_out_425042.awb")

						arg_438_1:RecordAudio("425042107", var_441_43)
						arg_438_1:RecordAudio("425042107", var_441_43)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_425042", "425042107", "story_v_out_425042.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_425042", "425042107", "story_v_out_425042.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_44 = math.max(var_441_35, arg_438_1.talkMaxDuration)

			if var_441_34 <= arg_438_1.time_ and arg_438_1.time_ < var_441_34 + var_441_44 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_34) / var_441_44

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_34 + var_441_44 and arg_438_1.time_ < var_441_34 + var_441_44 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_438_1:InitPlayNodeList()
	end,
	Play425042108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 425042108
		arg_442_1.duration_ = 4.1

		local var_442_0 = {
			zh = 2.4,
			ja = 4.1
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
				arg_442_0:Play425042109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1137"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1137 == nil then
				arg_442_1.var_.actorSpriteComps1137 = var_445_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_2 = 0.2

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.actorSpriteComps1137 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1137 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_445_3 then
						if arg_442_1.isInRecall_ then
							iter_445_3.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_445_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps1137 = nil
			end

			local var_445_8 = arg_442_1.actors_["10157"]
			local var_445_9 = 0

			if var_445_9 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 and not isNil(var_445_8) and arg_442_1.var_.actorSpriteComps10157 == nil then
				arg_442_1.var_.actorSpriteComps10157 = var_445_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_10 = 0.2

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_10 and not isNil(var_445_8) then
				local var_445_11 = (arg_442_1.time_ - var_445_9) / var_445_10

				if arg_442_1.var_.actorSpriteComps10157 then
					for iter_445_4, iter_445_5 in pairs(arg_442_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_445_5 then
							if arg_442_1.isInRecall_ then
								local var_445_12 = Mathf.Lerp(iter_445_5.color.r, arg_442_1.hightColor2.r, var_445_11)
								local var_445_13 = Mathf.Lerp(iter_445_5.color.g, arg_442_1.hightColor2.g, var_445_11)
								local var_445_14 = Mathf.Lerp(iter_445_5.color.b, arg_442_1.hightColor2.b, var_445_11)

								iter_445_5.color = Color.New(var_445_12, var_445_13, var_445_14)
							else
								local var_445_15 = Mathf.Lerp(iter_445_5.color.r, 0.5, var_445_11)

								iter_445_5.color = Color.New(var_445_15, var_445_15, var_445_15)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_9 + var_445_10 and arg_442_1.time_ < var_445_9 + var_445_10 + arg_445_0 and not isNil(var_445_8) and arg_442_1.var_.actorSpriteComps10157 then
				for iter_445_6, iter_445_7 in pairs(arg_442_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_445_7 then
						if arg_442_1.isInRecall_ then
							iter_445_7.color = arg_442_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_445_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps10157 = nil
			end

			local var_445_16 = arg_442_1.actors_["1137"].transform
			local var_445_17 = 0

			if var_445_17 < arg_442_1.time_ and arg_442_1.time_ <= var_445_17 + arg_445_0 then
				arg_442_1.var_.moveOldPos1137 = var_445_16.localPosition
				var_445_16.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1137", 2)

				local var_445_18 = var_445_16.childCount

				for iter_445_8 = 0, var_445_18 - 1 do
					local var_445_19 = var_445_16:GetChild(iter_445_8)

					if var_445_19.name == "split_5" or not string.find(var_445_19.name, "split") then
						var_445_19.gameObject:SetActive(true)
					else
						var_445_19.gameObject:SetActive(false)
					end
				end
			end

			local var_445_20 = 0.001

			if var_445_17 <= arg_442_1.time_ and arg_442_1.time_ < var_445_17 + var_445_20 then
				local var_445_21 = (arg_442_1.time_ - var_445_17) / var_445_20
				local var_445_22 = Vector3.New(-390, -425, -200)

				var_445_16.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1137, var_445_22, var_445_21)
			end

			if arg_442_1.time_ >= var_445_17 + var_445_20 and arg_442_1.time_ < var_445_17 + var_445_20 + arg_445_0 then
				var_445_16.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_445_23 = 0
			local var_445_24 = 0.175

			if var_445_23 < arg_442_1.time_ and arg_442_1.time_ <= var_445_23 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_25 = arg_442_1:FormatText(StoryNameCfg[15].name)

				arg_442_1.leftNameTxt_.text = var_445_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_26 = arg_442_1:GetWordFromCfg(425042108)
				local var_445_27 = arg_442_1:FormatText(var_445_26.content)

				arg_442_1.text_.text = var_445_27

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_28 = 7
				local var_445_29 = utf8.len(var_445_27)
				local var_445_30 = var_445_28 <= 0 and var_445_24 or var_445_24 * (var_445_29 / var_445_28)

				if var_445_30 > 0 and var_445_24 < var_445_30 then
					arg_442_1.talkMaxDuration = var_445_30

					if var_445_30 + var_445_23 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_30 + var_445_23
					end
				end

				arg_442_1.text_.text = var_445_27
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042108", "story_v_out_425042.awb") ~= 0 then
					local var_445_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042108", "story_v_out_425042.awb") / 1000

					if var_445_31 + var_445_23 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_31 + var_445_23
					end

					if var_445_26.prefab_name ~= "" and arg_442_1.actors_[var_445_26.prefab_name] ~= nil then
						local var_445_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_26.prefab_name].transform, "story_v_out_425042", "425042108", "story_v_out_425042.awb")

						arg_442_1:RecordAudio("425042108", var_445_32)
						arg_442_1:RecordAudio("425042108", var_445_32)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_425042", "425042108", "story_v_out_425042.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_425042", "425042108", "story_v_out_425042.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_33 = math.max(var_445_24, arg_442_1.talkMaxDuration)

			if var_445_23 <= arg_442_1.time_ and arg_442_1.time_ < var_445_23 + var_445_33 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_23) / var_445_33

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_23 + var_445_33 and arg_442_1.time_ < var_445_23 + var_445_33 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
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

		arg_442_1:InitPlayNodeList()
	end,
	Play425042109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 425042109
		arg_446_1.duration_ = 10.9

		local var_446_0 = {
			zh = 4.933,
			ja = 10.9
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
				arg_446_0:Play425042110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["10157"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps10157 == nil then
				arg_446_1.var_.actorSpriteComps10157 = var_449_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_2 = 0.2

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.actorSpriteComps10157 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps10157 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_449_3 then
						if arg_446_1.isInRecall_ then
							iter_449_3.color = arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_449_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps10157 = nil
			end

			local var_449_8 = arg_446_1.actors_["1137"]
			local var_449_9 = 0

			if var_449_9 < arg_446_1.time_ and arg_446_1.time_ <= var_449_9 + arg_449_0 and not isNil(var_449_8) and arg_446_1.var_.actorSpriteComps1137 == nil then
				arg_446_1.var_.actorSpriteComps1137 = var_449_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_10 = 0.2

			if var_449_9 <= arg_446_1.time_ and arg_446_1.time_ < var_449_9 + var_449_10 and not isNil(var_449_8) then
				local var_449_11 = (arg_446_1.time_ - var_449_9) / var_449_10

				if arg_446_1.var_.actorSpriteComps1137 then
					for iter_449_4, iter_449_5 in pairs(arg_446_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_446_1.time_ >= var_449_9 + var_449_10 and arg_446_1.time_ < var_449_9 + var_449_10 + arg_449_0 and not isNil(var_449_8) and arg_446_1.var_.actorSpriteComps1137 then
				for iter_449_6, iter_449_7 in pairs(arg_446_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_449_7 then
						if arg_446_1.isInRecall_ then
							iter_449_7.color = arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_449_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps1137 = nil
			end

			local var_449_16 = arg_446_1.actors_["10157"].transform
			local var_449_17 = 0

			if var_449_17 < arg_446_1.time_ and arg_446_1.time_ <= var_449_17 + arg_449_0 then
				arg_446_1.var_.moveOldPos10157 = var_449_16.localPosition
				var_449_16.localScale = Vector3.New(1, 1, 1)

				arg_446_1:CheckSpriteTmpPos("10157", 4)

				local var_449_18 = var_449_16.childCount

				for iter_449_8 = 0, var_449_18 - 1 do
					local var_449_19 = var_449_16:GetChild(iter_449_8)

					if var_449_19.name == "split_4" or not string.find(var_449_19.name, "split") then
						var_449_19.gameObject:SetActive(true)
					else
						var_449_19.gameObject:SetActive(false)
					end
				end
			end

			local var_449_20 = 0.001

			if var_449_17 <= arg_446_1.time_ and arg_446_1.time_ < var_449_17 + var_449_20 then
				local var_449_21 = (arg_446_1.time_ - var_449_17) / var_449_20
				local var_449_22 = Vector3.New(390, -408, 115)

				var_449_16.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10157, var_449_22, var_449_21)
			end

			if arg_446_1.time_ >= var_449_17 + var_449_20 and arg_446_1.time_ < var_449_17 + var_449_20 + arg_449_0 then
				var_449_16.localPosition = Vector3.New(390, -408, 115)
			end

			local var_449_23 = 0
			local var_449_24 = 0.425

			if var_449_23 < arg_446_1.time_ and arg_446_1.time_ <= var_449_23 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_25 = arg_446_1:FormatText(StoryNameCfg[1434].name)

				arg_446_1.leftNameTxt_.text = var_449_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_26 = arg_446_1:GetWordFromCfg(425042109)
				local var_449_27 = arg_446_1:FormatText(var_449_26.content)

				arg_446_1.text_.text = var_449_27

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_28 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042109", "story_v_out_425042.awb") ~= 0 then
					local var_449_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042109", "story_v_out_425042.awb") / 1000

					if var_449_31 + var_449_23 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_31 + var_449_23
					end

					if var_449_26.prefab_name ~= "" and arg_446_1.actors_[var_449_26.prefab_name] ~= nil then
						local var_449_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_26.prefab_name].transform, "story_v_out_425042", "425042109", "story_v_out_425042.awb")

						arg_446_1:RecordAudio("425042109", var_449_32)
						arg_446_1:RecordAudio("425042109", var_449_32)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_425042", "425042109", "story_v_out_425042.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_425042", "425042109", "story_v_out_425042.awb")
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
				actorName = "10157",
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
	Play425042110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 425042110
		arg_450_1.duration_ = 5.57

		local var_450_0 = {
			zh = 5.333,
			ja = 5.566
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
				arg_450_0:Play425042111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1137"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1137 == nil then
				arg_450_1.var_.actorSpriteComps1137 = var_453_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_2 = 0.2

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.actorSpriteComps1137 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1137 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_453_3 then
						if arg_450_1.isInRecall_ then
							iter_453_3.color = arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_453_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps1137 = nil
			end

			local var_453_8 = arg_450_1.actors_["10157"]
			local var_453_9 = 0

			if var_453_9 < arg_450_1.time_ and arg_450_1.time_ <= var_453_9 + arg_453_0 and not isNil(var_453_8) and arg_450_1.var_.actorSpriteComps10157 == nil then
				arg_450_1.var_.actorSpriteComps10157 = var_453_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_10 = 0.2

			if var_453_9 <= arg_450_1.time_ and arg_450_1.time_ < var_453_9 + var_453_10 and not isNil(var_453_8) then
				local var_453_11 = (arg_450_1.time_ - var_453_9) / var_453_10

				if arg_450_1.var_.actorSpriteComps10157 then
					for iter_453_4, iter_453_5 in pairs(arg_450_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_450_1.time_ >= var_453_9 + var_453_10 and arg_450_1.time_ < var_453_9 + var_453_10 + arg_453_0 and not isNil(var_453_8) and arg_450_1.var_.actorSpriteComps10157 then
				for iter_453_6, iter_453_7 in pairs(arg_450_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_453_7 then
						if arg_450_1.isInRecall_ then
							iter_453_7.color = arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_453_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps10157 = nil
			end

			local var_453_16 = arg_450_1.actors_["1137"].transform
			local var_453_17 = 0

			if var_453_17 < arg_450_1.time_ and arg_450_1.time_ <= var_453_17 + arg_453_0 then
				arg_450_1.var_.moveOldPos1137 = var_453_16.localPosition
				var_453_16.localScale = Vector3.New(1, 1, 1)

				arg_450_1:CheckSpriteTmpPos("1137", 2)

				local var_453_18 = var_453_16.childCount

				for iter_453_8 = 0, var_453_18 - 1 do
					local var_453_19 = var_453_16:GetChild(iter_453_8)

					if var_453_19.name == "split_4" then
						var_453_19:SetAsLastSibling()
						var_453_19.gameObject:SetActive(true)

						arg_450_1.var_.actorSpriteSplit1137 = var_453_19.gameObject:GetComponent(typeof(Image))

						arg_450_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_453_20 = 0.5

			if var_453_17 <= arg_450_1.time_ and arg_450_1.time_ < var_453_17 + var_453_20 then
				local var_453_21 = (arg_450_1.time_ - var_453_17) / var_453_20
				local var_453_22 = Vector3.New(-390, -425, -200)

				var_453_16.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1137, var_453_22, var_453_21)

				if arg_450_1.var_.actorSpriteSplit1137 ~= nil then
					arg_450_1.var_.actorSpriteSplit1137:SetAlpha(var_453_21)
				end
			end

			if arg_450_1.time_ >= var_453_17 + var_453_20 and arg_450_1.time_ < var_453_17 + var_453_20 + arg_453_0 then
				var_453_16.localPosition = Vector3.New(-390, -425, -200)

				if arg_450_1.var_.actorSpriteSplit1137 ~= nil then
					arg_450_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_453_23 = 0
			local var_453_24 = 0.425

			if var_453_23 < arg_450_1.time_ and arg_450_1.time_ <= var_453_23 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_25 = arg_450_1:FormatText(StoryNameCfg[15].name)

				arg_450_1.leftNameTxt_.text = var_453_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_26 = arg_450_1:GetWordFromCfg(425042110)
				local var_453_27 = arg_450_1:FormatText(var_453_26.content)

				arg_450_1.text_.text = var_453_27

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_28 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042110", "story_v_out_425042.awb") ~= 0 then
					local var_453_31 = manager.audio:GetVoiceLength("story_v_out_425042", "425042110", "story_v_out_425042.awb") / 1000

					if var_453_31 + var_453_23 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_31 + var_453_23
					end

					if var_453_26.prefab_name ~= "" and arg_450_1.actors_[var_453_26.prefab_name] ~= nil then
						local var_453_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_26.prefab_name].transform, "story_v_out_425042", "425042110", "story_v_out_425042.awb")

						arg_450_1:RecordAudio("425042110", var_453_32)
						arg_450_1:RecordAudio("425042110", var_453_32)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_425042", "425042110", "story_v_out_425042.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_425042", "425042110", "story_v_out_425042.awb")
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play425042111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 425042111
		arg_454_1.duration_ = 4.9

		local var_454_0 = {
			zh = 3.533,
			ja = 4.9
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
				arg_454_0:Play425042112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.25

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[15].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_3 = arg_454_1:GetWordFromCfg(425042111)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 10
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042111", "story_v_out_425042.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042111", "story_v_out_425042.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_425042", "425042111", "story_v_out_425042.awb")

						arg_454_1:RecordAudio("425042111", var_457_9)
						arg_454_1:RecordAudio("425042111", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_425042", "425042111", "story_v_out_425042.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_425042", "425042111", "story_v_out_425042.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play425042112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 425042112
		arg_458_1.duration_ = 7

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play425042113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 1

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				local var_461_1 = manager.ui.mainCamera.transform.localPosition
				local var_461_2 = Vector3.New(0, 0, 10) + Vector3.New(var_461_1.x, var_461_1.y, 0)
				local var_461_3 = arg_458_1.bgs_.ST2402

				var_461_3.transform.localPosition = var_461_2
				var_461_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_461_4 = var_461_3:GetComponent("SpriteRenderer")

				if var_461_4 and var_461_4.sprite then
					local var_461_5 = (var_461_3.transform.localPosition - var_461_1).z
					local var_461_6 = manager.ui.mainCameraCom_
					local var_461_7 = 2 * var_461_5 * Mathf.Tan(var_461_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_461_8 = var_461_7 * var_461_6.aspect
					local var_461_9 = var_461_4.sprite.bounds.size.x
					local var_461_10 = var_461_4.sprite.bounds.size.y
					local var_461_11 = var_461_8 / var_461_9
					local var_461_12 = var_461_7 / var_461_10
					local var_461_13 = var_461_12 < var_461_11 and var_461_11 or var_461_12

					var_461_3.transform.localScale = Vector3.New(var_461_13, var_461_13, 0)
				end

				for iter_461_0, iter_461_1 in pairs(arg_458_1.bgs_) do
					if iter_461_0 ~= "ST2402" then
						iter_461_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_461_14 = 2

			if var_461_14 < arg_458_1.time_ and arg_458_1.time_ <= var_461_14 + arg_461_0 then
				arg_458_1.allBtn_.enabled = false
			end

			local var_461_15 = 0.3

			if arg_458_1.time_ >= var_461_14 + var_461_15 and arg_458_1.time_ < var_461_14 + var_461_15 + arg_461_0 then
				arg_458_1.allBtn_.enabled = true
			end

			local var_461_16 = 0

			if var_461_16 < arg_458_1.time_ and arg_458_1.time_ <= var_461_16 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_17 = 1

			if var_461_16 <= arg_458_1.time_ and arg_458_1.time_ < var_461_16 + var_461_17 then
				local var_461_18 = (arg_458_1.time_ - var_461_16) / var_461_17
				local var_461_19 = Color.New(0, 0, 0)

				var_461_19.a = Mathf.Lerp(0, 1, var_461_18)
				arg_458_1.mask_.color = var_461_19
			end

			if arg_458_1.time_ >= var_461_16 + var_461_17 and arg_458_1.time_ < var_461_16 + var_461_17 + arg_461_0 then
				local var_461_20 = Color.New(0, 0, 0)

				var_461_20.a = 1
				arg_458_1.mask_.color = var_461_20
			end

			local var_461_21 = 1

			if var_461_21 < arg_458_1.time_ and arg_458_1.time_ <= var_461_21 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_22 = 1

			if var_461_21 <= arg_458_1.time_ and arg_458_1.time_ < var_461_21 + var_461_22 then
				local var_461_23 = (arg_458_1.time_ - var_461_21) / var_461_22
				local var_461_24 = Color.New(0, 0, 0)

				var_461_24.a = Mathf.Lerp(1, 0, var_461_23)
				arg_458_1.mask_.color = var_461_24
			end

			if arg_458_1.time_ >= var_461_21 + var_461_22 and arg_458_1.time_ < var_461_21 + var_461_22 + arg_461_0 then
				local var_461_25 = Color.New(0, 0, 0)
				local var_461_26 = 0

				arg_458_1.mask_.enabled = false
				var_461_25.a = var_461_26
				arg_458_1.mask_.color = var_461_25
			end

			local var_461_27 = arg_458_1.actors_["10157"].transform
			local var_461_28 = 1

			if var_461_28 < arg_458_1.time_ and arg_458_1.time_ <= var_461_28 + arg_461_0 then
				arg_458_1.var_.moveOldPos10157 = var_461_27.localPosition
				var_461_27.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("10157", 7)

				local var_461_29 = var_461_27.childCount

				for iter_461_2 = 0, var_461_29 - 1 do
					local var_461_30 = var_461_27:GetChild(iter_461_2)

					if var_461_30.name == "" or not string.find(var_461_30.name, "split") then
						var_461_30.gameObject:SetActive(true)
					else
						var_461_30.gameObject:SetActive(false)
					end
				end
			end

			local var_461_31 = 0.001

			if var_461_28 <= arg_458_1.time_ and arg_458_1.time_ < var_461_28 + var_461_31 then
				local var_461_32 = (arg_458_1.time_ - var_461_28) / var_461_31
				local var_461_33 = Vector3.New(0, -2000, 0)

				var_461_27.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos10157, var_461_33, var_461_32)
			end

			if arg_458_1.time_ >= var_461_28 + var_461_31 and arg_458_1.time_ < var_461_28 + var_461_31 + arg_461_0 then
				var_461_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_461_34 = arg_458_1.actors_["1137"].transform
			local var_461_35 = 1

			if var_461_35 < arg_458_1.time_ and arg_458_1.time_ <= var_461_35 + arg_461_0 then
				arg_458_1.var_.moveOldPos1137 = var_461_34.localPosition
				var_461_34.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1137", 7)

				local var_461_36 = var_461_34.childCount

				for iter_461_3 = 0, var_461_36 - 1 do
					local var_461_37 = var_461_34:GetChild(iter_461_3)

					if var_461_37.name == "" or not string.find(var_461_37.name, "split") then
						var_461_37.gameObject:SetActive(true)
					else
						var_461_37.gameObject:SetActive(false)
					end
				end
			end

			local var_461_38 = 0.001

			if var_461_35 <= arg_458_1.time_ and arg_458_1.time_ < var_461_35 + var_461_38 then
				local var_461_39 = (arg_458_1.time_ - var_461_35) / var_461_38
				local var_461_40 = Vector3.New(0, -2000, 0)

				var_461_34.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1137, var_461_40, var_461_39)
			end

			if arg_458_1.time_ >= var_461_35 + var_461_38 and arg_458_1.time_ < var_461_35 + var_461_38 + arg_461_0 then
				var_461_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_458_1.frameCnt_ <= 1 then
				arg_458_1.dialog_:SetActive(false)
			end

			local var_461_41 = 2
			local var_461_42 = 0.325

			if var_461_41 < arg_458_1.time_ and arg_458_1.time_ <= var_461_41 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				arg_458_1.dialog_:SetActive(true)

				arg_458_1.dialogCg_.alpha = 0

				local var_461_43 = LeanTween.value(arg_458_1.dialog_, 0, 1, 0.3)

				var_461_43:setOnUpdate(LuaHelper.FloatAction(function(arg_462_0)
					arg_458_1.dialogCg_.alpha = arg_462_0
				end))
				var_461_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_458_1.dialog_)
					var_461_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_458_1.duration_ = arg_458_1.duration_ + 0.3

				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_44 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_45 = arg_458_1:GetWordFromCfg(425042112)
				local var_461_46 = arg_458_1:FormatText(var_461_45.content)

				arg_458_1.text_.text = var_461_46

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_47 = 13
				local var_461_48 = utf8.len(var_461_46)
				local var_461_49 = var_461_47 <= 0 and var_461_42 or var_461_42 * (var_461_48 / var_461_47)

				if var_461_49 > 0 and var_461_42 < var_461_49 then
					arg_458_1.talkMaxDuration = var_461_49
					var_461_41 = var_461_41 + 0.3

					if var_461_49 + var_461_41 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_49 + var_461_41
					end
				end

				arg_458_1.text_.text = var_461_46
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_50 = var_461_41 + 0.3
			local var_461_51 = math.max(var_461_42, arg_458_1.talkMaxDuration)

			if var_461_50 <= arg_458_1.time_ and arg_458_1.time_ < var_461_50 + var_461_51 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_50) / var_461_51

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_50 + var_461_51 and arg_458_1.time_ < var_461_50 + var_461_51 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play425042113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 425042113
		arg_464_1.duration_ = 5.3

		local var_464_0 = {
			zh = 4.7,
			ja = 5.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play425042114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1137"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps1137 == nil then
				arg_464_1.var_.actorSpriteComps1137 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps1137 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								local var_467_4 = Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor1.r, var_467_3)
								local var_467_5 = Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor1.g, var_467_3)
								local var_467_6 = Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor1.b, var_467_3)

								iter_467_1.color = Color.New(var_467_4, var_467_5, var_467_6)
							else
								local var_467_7 = Mathf.Lerp(iter_467_1.color.r, 1, var_467_3)

								iter_467_1.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps1137 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_467_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps1137 = nil
			end

			local var_467_8 = arg_464_1.actors_["1137"].transform
			local var_467_9 = 0

			if var_467_9 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 then
				arg_464_1.var_.moveOldPos1137 = var_467_8.localPosition
				var_467_8.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("1137", 3)

				local var_467_10 = var_467_8.childCount

				for iter_467_4 = 0, var_467_10 - 1 do
					local var_467_11 = var_467_8:GetChild(iter_467_4)

					if var_467_11.name == "split_4" or not string.find(var_467_11.name, "split") then
						var_467_11.gameObject:SetActive(true)
					else
						var_467_11.gameObject:SetActive(false)
					end
				end
			end

			local var_467_12 = 0.001

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_12 then
				local var_467_13 = (arg_464_1.time_ - var_467_9) / var_467_12
				local var_467_14 = Vector3.New(0, -425, -200)

				var_467_8.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1137, var_467_14, var_467_13)
			end

			if arg_464_1.time_ >= var_467_9 + var_467_12 and arg_464_1.time_ < var_467_9 + var_467_12 + arg_467_0 then
				var_467_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_467_15 = 0
			local var_467_16 = 0.4

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_17 = arg_464_1:FormatText(StoryNameCfg[15].name)

				arg_464_1.leftNameTxt_.text = var_467_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_18 = arg_464_1:GetWordFromCfg(425042113)
				local var_467_19 = arg_464_1:FormatText(var_467_18.content)

				arg_464_1.text_.text = var_467_19

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_20 = 16
				local var_467_21 = utf8.len(var_467_19)
				local var_467_22 = var_467_20 <= 0 and var_467_16 or var_467_16 * (var_467_21 / var_467_20)

				if var_467_22 > 0 and var_467_16 < var_467_22 then
					arg_464_1.talkMaxDuration = var_467_22

					if var_467_22 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_22 + var_467_15
					end
				end

				arg_464_1.text_.text = var_467_19
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042113", "story_v_out_425042.awb") ~= 0 then
					local var_467_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042113", "story_v_out_425042.awb") / 1000

					if var_467_23 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_23 + var_467_15
					end

					if var_467_18.prefab_name ~= "" and arg_464_1.actors_[var_467_18.prefab_name] ~= nil then
						local var_467_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_18.prefab_name].transform, "story_v_out_425042", "425042113", "story_v_out_425042.awb")

						arg_464_1:RecordAudio("425042113", var_467_24)
						arg_464_1:RecordAudio("425042113", var_467_24)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_425042", "425042113", "story_v_out_425042.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_425042", "425042113", "story_v_out_425042.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_25 = math.max(var_467_16, arg_464_1.talkMaxDuration)

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_25 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_15) / var_467_25

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_15 + var_467_25 and arg_464_1.time_ < var_467_15 + var_467_25 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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

		arg_464_1:InitPlayNodeList()
	end,
	Play425042114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 425042114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play425042115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1137"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps1137 == nil then
				arg_468_1.var_.actorSpriteComps1137 = var_471_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_2 = 0.2

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.actorSpriteComps1137 then
					for iter_471_0, iter_471_1 in pairs(arg_468_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_471_1 then
							if arg_468_1.isInRecall_ then
								local var_471_4 = Mathf.Lerp(iter_471_1.color.r, arg_468_1.hightColor2.r, var_471_3)
								local var_471_5 = Mathf.Lerp(iter_471_1.color.g, arg_468_1.hightColor2.g, var_471_3)
								local var_471_6 = Mathf.Lerp(iter_471_1.color.b, arg_468_1.hightColor2.b, var_471_3)

								iter_471_1.color = Color.New(var_471_4, var_471_5, var_471_6)
							else
								local var_471_7 = Mathf.Lerp(iter_471_1.color.r, 0.5, var_471_3)

								iter_471_1.color = Color.New(var_471_7, var_471_7, var_471_7)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps1137 then
				for iter_471_2, iter_471_3 in pairs(arg_468_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_471_3 then
						if arg_468_1.isInRecall_ then
							iter_471_3.color = arg_468_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_471_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_468_1.var_.actorSpriteComps1137 = nil
			end

			local var_471_8 = 0
			local var_471_9 = 0.375

			if var_471_8 < arg_468_1.time_ and arg_468_1.time_ <= var_471_8 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_10 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_11 = arg_468_1:GetWordFromCfg(425042114)
				local var_471_12 = arg_468_1:FormatText(var_471_11.content)

				arg_468_1.text_.text = var_471_12

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_13 = 15
				local var_471_14 = utf8.len(var_471_12)
				local var_471_15 = var_471_13 <= 0 and var_471_9 or var_471_9 * (var_471_14 / var_471_13)

				if var_471_15 > 0 and var_471_9 < var_471_15 then
					arg_468_1.talkMaxDuration = var_471_15

					if var_471_15 + var_471_8 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_15 + var_471_8
					end
				end

				arg_468_1.text_.text = var_471_12
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_16 = math.max(var_471_9, arg_468_1.talkMaxDuration)

			if var_471_8 <= arg_468_1.time_ and arg_468_1.time_ < var_471_8 + var_471_16 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_8) / var_471_16

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_8 + var_471_16 and arg_468_1.time_ < var_471_8 + var_471_16 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play425042115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 425042115
		arg_472_1.duration_ = 9.37

		local var_472_0 = {
			zh = 5.1,
			ja = 9.366
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
				arg_472_0:Play425042116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1137"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps1137 == nil then
				arg_472_1.var_.actorSpriteComps1137 = var_475_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_2 = 0.2

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.actorSpriteComps1137 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								local var_475_4 = Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, var_475_3)
								local var_475_5 = Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, var_475_3)
								local var_475_6 = Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, var_475_3)

								iter_475_1.color = Color.New(var_475_4, var_475_5, var_475_6)
							else
								local var_475_7 = Mathf.Lerp(iter_475_1.color.r, 1, var_475_3)

								iter_475_1.color = Color.New(var_475_7, var_475_7, var_475_7)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps1137 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_475_3 then
						if arg_472_1.isInRecall_ then
							iter_475_3.color = arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_475_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_472_1.var_.actorSpriteComps1137 = nil
			end

			local var_475_8 = 0
			local var_475_9 = 0.45

			if var_475_8 < arg_472_1.time_ and arg_472_1.time_ <= var_475_8 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_10 = arg_472_1:FormatText(StoryNameCfg[15].name)

				arg_472_1.leftNameTxt_.text = var_475_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_11 = arg_472_1:GetWordFromCfg(425042115)
				local var_475_12 = arg_472_1:FormatText(var_475_11.content)

				arg_472_1.text_.text = var_475_12

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_13 = 18
				local var_475_14 = utf8.len(var_475_12)
				local var_475_15 = var_475_13 <= 0 and var_475_9 or var_475_9 * (var_475_14 / var_475_13)

				if var_475_15 > 0 and var_475_9 < var_475_15 then
					arg_472_1.talkMaxDuration = var_475_15

					if var_475_15 + var_475_8 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_15 + var_475_8
					end
				end

				arg_472_1.text_.text = var_475_12
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042115", "story_v_out_425042.awb") ~= 0 then
					local var_475_16 = manager.audio:GetVoiceLength("story_v_out_425042", "425042115", "story_v_out_425042.awb") / 1000

					if var_475_16 + var_475_8 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_16 + var_475_8
					end

					if var_475_11.prefab_name ~= "" and arg_472_1.actors_[var_475_11.prefab_name] ~= nil then
						local var_475_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_11.prefab_name].transform, "story_v_out_425042", "425042115", "story_v_out_425042.awb")

						arg_472_1:RecordAudio("425042115", var_475_17)
						arg_472_1:RecordAudio("425042115", var_475_17)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_425042", "425042115", "story_v_out_425042.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_425042", "425042115", "story_v_out_425042.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_18 = math.max(var_475_9, arg_472_1.talkMaxDuration)

			if var_475_8 <= arg_472_1.time_ and arg_472_1.time_ < var_475_8 + var_475_18 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_8) / var_475_18

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_8 + var_475_18 and arg_472_1.time_ < var_475_8 + var_475_18 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play425042116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 425042116
		arg_476_1.duration_ = 5.5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play425042117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1137"].transform
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.var_.moveOldPos1137 = var_479_0.localPosition
				var_479_0.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("1137", 7)

				local var_479_2 = var_479_0.childCount

				for iter_479_0 = 0, var_479_2 - 1 do
					local var_479_3 = var_479_0:GetChild(iter_479_0)

					if var_479_3.name == "" or not string.find(var_479_3.name, "split") then
						var_479_3.gameObject:SetActive(true)
					else
						var_479_3.gameObject:SetActive(false)
					end
				end
			end

			local var_479_4 = 0.001

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_4 then
				local var_479_5 = (arg_476_1.time_ - var_479_1) / var_479_4
				local var_479_6 = Vector3.New(0, -2000, 0)

				var_479_0.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1137, var_479_6, var_479_5)
			end

			if arg_476_1.time_ >= var_479_1 + var_479_4 and arg_476_1.time_ < var_479_1 + var_479_4 + arg_479_0 then
				var_479_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_479_7 = manager.ui.mainCamera.transform
			local var_479_8 = 0

			if var_479_8 < arg_476_1.time_ and arg_476_1.time_ <= var_479_8 + arg_479_0 then
				local var_479_9 = arg_476_1.var_.effect10092116
				local var_479_10
				local var_479_11 = var_479_7

				if not var_479_9 then
					var_479_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_479_11)
					var_479_9.name = "2116"
					arg_476_1.var_.effect10092116 = var_479_9
				else
					var_479_9.transform:SetParent(var_479_11)
				end

				var_479_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_479_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_479_12 = manager.ui.mainCamera.transform
			local var_479_13 = 1.43333333333333

			if var_479_13 < arg_476_1.time_ and arg_476_1.time_ <= var_479_13 + arg_479_0 then
				local var_479_14 = arg_476_1.var_.effect10092116

				if var_479_14 then
					Object.Destroy(var_479_14)

					arg_476_1.var_.effect10092116 = nil
				end
			end

			if arg_476_1.frameCnt_ <= 1 then
				arg_476_1.dialog_:SetActive(false)
			end

			local var_479_15 = 0.5
			local var_479_16 = 1.3

			if var_479_15 < arg_476_1.time_ and arg_476_1.time_ <= var_479_15 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0

				arg_476_1.dialog_:SetActive(true)

				arg_476_1.dialogCg_.alpha = 0

				local var_479_17 = LeanTween.value(arg_476_1.dialog_, 0, 1, 0.3)

				var_479_17:setOnUpdate(LuaHelper.FloatAction(function(arg_480_0)
					arg_476_1.dialogCg_.alpha = arg_480_0
				end))
				var_479_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_476_1.dialog_)
					var_479_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_476_1.duration_ = arg_476_1.duration_ + 0.3

				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_18 = arg_476_1:GetWordFromCfg(425042116)
				local var_479_19 = arg_476_1:FormatText(var_479_18.content)

				arg_476_1.text_.text = var_479_19

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_20 = 52
				local var_479_21 = utf8.len(var_479_19)
				local var_479_22 = var_479_20 <= 0 and var_479_16 or var_479_16 * (var_479_21 / var_479_20)

				if var_479_22 > 0 and var_479_16 < var_479_22 then
					arg_476_1.talkMaxDuration = var_479_22
					var_479_15 = var_479_15 + 0.3

					if var_479_22 + var_479_15 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_22 + var_479_15
					end
				end

				arg_476_1.text_.text = var_479_19
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_23 = var_479_15 + 0.3
			local var_479_24 = math.max(var_479_16, arg_476_1.talkMaxDuration)

			if var_479_23 <= arg_476_1.time_ and arg_476_1.time_ < var_479_23 + var_479_24 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_23) / var_479_24

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_23 + var_479_24 and arg_476_1.time_ < var_479_23 + var_479_24 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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

		arg_476_1:InitPlayNodeList()
	end,
	Play425042117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 425042117
		arg_482_1.duration_ = 14.13

		local var_482_0 = {
			zh = 9.933,
			ja = 14.133
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
				arg_482_0:Play425042118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 1

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				local var_485_1 = manager.ui.mainCamera.transform.localPosition
				local var_485_2 = Vector3.New(0, 0, 10) + Vector3.New(var_485_1.x, var_485_1.y, 0)
				local var_485_3 = arg_482_1.bgs_.ST2402

				var_485_3.transform.localPosition = var_485_2
				var_485_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_4 = var_485_3:GetComponent("SpriteRenderer")

				if var_485_4 and var_485_4.sprite then
					local var_485_5 = (var_485_3.transform.localPosition - var_485_1).z
					local var_485_6 = manager.ui.mainCameraCom_
					local var_485_7 = 2 * var_485_5 * Mathf.Tan(var_485_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_485_8 = var_485_7 * var_485_6.aspect
					local var_485_9 = var_485_4.sprite.bounds.size.x
					local var_485_10 = var_485_4.sprite.bounds.size.y
					local var_485_11 = var_485_8 / var_485_9
					local var_485_12 = var_485_7 / var_485_10
					local var_485_13 = var_485_12 < var_485_11 and var_485_11 or var_485_12

					var_485_3.transform.localScale = Vector3.New(var_485_13, var_485_13, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "ST2402" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_485_14 = 3

			if var_485_14 < arg_482_1.time_ and arg_482_1.time_ <= var_485_14 + arg_485_0 then
				arg_482_1.allBtn_.enabled = false
			end

			local var_485_15 = 0.3

			if arg_482_1.time_ >= var_485_14 + var_485_15 and arg_482_1.time_ < var_485_14 + var_485_15 + arg_485_0 then
				arg_482_1.allBtn_.enabled = true
			end

			local var_485_16 = 0

			if var_485_16 < arg_482_1.time_ and arg_482_1.time_ <= var_485_16 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_17 = 1

			if var_485_16 <= arg_482_1.time_ and arg_482_1.time_ < var_485_16 + var_485_17 then
				local var_485_18 = (arg_482_1.time_ - var_485_16) / var_485_17
				local var_485_19 = Color.New(0, 0, 0)

				var_485_19.a = Mathf.Lerp(0, 1, var_485_18)
				arg_482_1.mask_.color = var_485_19
			end

			if arg_482_1.time_ >= var_485_16 + var_485_17 and arg_482_1.time_ < var_485_16 + var_485_17 + arg_485_0 then
				local var_485_20 = Color.New(0, 0, 0)

				var_485_20.a = 1
				arg_482_1.mask_.color = var_485_20
			end

			local var_485_21 = 1

			if var_485_21 < arg_482_1.time_ and arg_482_1.time_ <= var_485_21 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_22 = 2

			if var_485_21 <= arg_482_1.time_ and arg_482_1.time_ < var_485_21 + var_485_22 then
				local var_485_23 = (arg_482_1.time_ - var_485_21) / var_485_22
				local var_485_24 = Color.New(0, 0, 0)

				var_485_24.a = Mathf.Lerp(1, 0, var_485_23)
				arg_482_1.mask_.color = var_485_24
			end

			if arg_482_1.time_ >= var_485_21 + var_485_22 and arg_482_1.time_ < var_485_21 + var_485_22 + arg_485_0 then
				local var_485_25 = Color.New(0, 0, 0)
				local var_485_26 = 0

				arg_482_1.mask_.enabled = false
				var_485_25.a = var_485_26
				arg_482_1.mask_.color = var_485_25
			end

			local var_485_27 = arg_482_1.actors_["10157"]
			local var_485_28 = 2.8

			if var_485_28 < arg_482_1.time_ and arg_482_1.time_ <= var_485_28 + arg_485_0 and not isNil(var_485_27) and arg_482_1.var_.actorSpriteComps10157 == nil then
				arg_482_1.var_.actorSpriteComps10157 = var_485_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_29 = 0.2

			if var_485_28 <= arg_482_1.time_ and arg_482_1.time_ < var_485_28 + var_485_29 and not isNil(var_485_27) then
				local var_485_30 = (arg_482_1.time_ - var_485_28) / var_485_29

				if arg_482_1.var_.actorSpriteComps10157 then
					for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_485_3 then
							if arg_482_1.isInRecall_ then
								local var_485_31 = Mathf.Lerp(iter_485_3.color.r, arg_482_1.hightColor1.r, var_485_30)
								local var_485_32 = Mathf.Lerp(iter_485_3.color.g, arg_482_1.hightColor1.g, var_485_30)
								local var_485_33 = Mathf.Lerp(iter_485_3.color.b, arg_482_1.hightColor1.b, var_485_30)

								iter_485_3.color = Color.New(var_485_31, var_485_32, var_485_33)
							else
								local var_485_34 = Mathf.Lerp(iter_485_3.color.r, 1, var_485_30)

								iter_485_3.color = Color.New(var_485_34, var_485_34, var_485_34)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= var_485_28 + var_485_29 and arg_482_1.time_ < var_485_28 + var_485_29 + arg_485_0 and not isNil(var_485_27) and arg_482_1.var_.actorSpriteComps10157 then
				for iter_485_4, iter_485_5 in pairs(arg_482_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_485_5 then
						if arg_482_1.isInRecall_ then
							iter_485_5.color = arg_482_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_485_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_482_1.var_.actorSpriteComps10157 = nil
			end

			local var_485_35 = arg_482_1.actors_["10157"].transform
			local var_485_36 = 2.8

			if var_485_36 < arg_482_1.time_ and arg_482_1.time_ <= var_485_36 + arg_485_0 then
				arg_482_1.var_.moveOldPos10157 = var_485_35.localPosition
				var_485_35.localScale = Vector3.New(1, 1, 1)

				arg_482_1:CheckSpriteTmpPos("10157", 3)

				local var_485_37 = var_485_35.childCount

				for iter_485_6 = 0, var_485_37 - 1 do
					local var_485_38 = var_485_35:GetChild(iter_485_6)

					if var_485_38.name == "split_4" or not string.find(var_485_38.name, "split") then
						var_485_38.gameObject:SetActive(true)
					else
						var_485_38.gameObject:SetActive(false)
					end
				end
			end

			local var_485_39 = 0.001

			if var_485_36 <= arg_482_1.time_ and arg_482_1.time_ < var_485_36 + var_485_39 then
				local var_485_40 = (arg_482_1.time_ - var_485_36) / var_485_39
				local var_485_41 = Vector3.New(0, -408, 115)

				var_485_35.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos10157, var_485_41, var_485_40)
			end

			if arg_482_1.time_ >= var_485_36 + var_485_39 and arg_482_1.time_ < var_485_36 + var_485_39 + arg_485_0 then
				var_485_35.localPosition = Vector3.New(0, -408, 115)
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_42 = 3
			local var_485_43 = 0.7

			if var_485_42 < arg_482_1.time_ and arg_482_1.time_ <= var_485_42 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_44 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_44:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_45 = arg_482_1:FormatText(StoryNameCfg[1434].name)

				arg_482_1.leftNameTxt_.text = var_485_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_46 = arg_482_1:GetWordFromCfg(425042117)
				local var_485_47 = arg_482_1:FormatText(var_485_46.content)

				arg_482_1.text_.text = var_485_47

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_48 = 28
				local var_485_49 = utf8.len(var_485_47)
				local var_485_50 = var_485_48 <= 0 and var_485_43 or var_485_43 * (var_485_49 / var_485_48)

				if var_485_50 > 0 and var_485_43 < var_485_50 then
					arg_482_1.talkMaxDuration = var_485_50
					var_485_42 = var_485_42 + 0.3

					if var_485_50 + var_485_42 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_50 + var_485_42
					end
				end

				arg_482_1.text_.text = var_485_47
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042117", "story_v_out_425042.awb") ~= 0 then
					local var_485_51 = manager.audio:GetVoiceLength("story_v_out_425042", "425042117", "story_v_out_425042.awb") / 1000

					if var_485_51 + var_485_42 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_51 + var_485_42
					end

					if var_485_46.prefab_name ~= "" and arg_482_1.actors_[var_485_46.prefab_name] ~= nil then
						local var_485_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_46.prefab_name].transform, "story_v_out_425042", "425042117", "story_v_out_425042.awb")

						arg_482_1:RecordAudio("425042117", var_485_52)
						arg_482_1:RecordAudio("425042117", var_485_52)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_425042", "425042117", "story_v_out_425042.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_425042", "425042117", "story_v_out_425042.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_53 = var_485_42 + 0.3
			local var_485_54 = math.max(var_485_43, arg_482_1.talkMaxDuration)

			if var_485_53 <= arg_482_1.time_ and arg_482_1.time_ < var_485_53 + var_485_54 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_53) / var_485_54

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_53 + var_485_54 and arg_482_1.time_ < var_485_53 + var_485_54 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play425042118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 425042118
		arg_488_1.duration_ = 15.97

		local var_488_0 = {
			zh = 10.3,
			ja = 15.966
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
				arg_488_0:Play425042119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 1.075

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[1434].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_3 = arg_488_1:GetWordFromCfg(425042118)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 43
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042118", "story_v_out_425042.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042118", "story_v_out_425042.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_425042", "425042118", "story_v_out_425042.awb")

						arg_488_1:RecordAudio("425042118", var_491_9)
						arg_488_1:RecordAudio("425042118", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_425042", "425042118", "story_v_out_425042.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_425042", "425042118", "story_v_out_425042.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play425042119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 425042119
		arg_492_1.duration_ = 4.73

		local var_492_0 = {
			zh = 4.333,
			ja = 4.733
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play425042120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1137"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps1137 == nil then
				arg_492_1.var_.actorSpriteComps1137 = var_495_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_2 = 0.2

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.actorSpriteComps1137 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								local var_495_4 = Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor1.r, var_495_3)
								local var_495_5 = Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor1.g, var_495_3)
								local var_495_6 = Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor1.b, var_495_3)

								iter_495_1.color = Color.New(var_495_4, var_495_5, var_495_6)
							else
								local var_495_7 = Mathf.Lerp(iter_495_1.color.r, 1, var_495_3)

								iter_495_1.color = Color.New(var_495_7, var_495_7, var_495_7)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps1137 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_495_3 then
						if arg_492_1.isInRecall_ then
							iter_495_3.color = arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_495_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_492_1.var_.actorSpriteComps1137 = nil
			end

			local var_495_8 = arg_492_1.actors_["1137"].transform
			local var_495_9 = 0

			if var_495_9 < arg_492_1.time_ and arg_492_1.time_ <= var_495_9 + arg_495_0 then
				arg_492_1.var_.moveOldPos1137 = var_495_8.localPosition
				var_495_8.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("1137", 3)

				local var_495_10 = var_495_8.childCount

				for iter_495_4 = 0, var_495_10 - 1 do
					local var_495_11 = var_495_8:GetChild(iter_495_4)

					if var_495_11.name == "split_4" or not string.find(var_495_11.name, "split") then
						var_495_11.gameObject:SetActive(true)
					else
						var_495_11.gameObject:SetActive(false)
					end
				end
			end

			local var_495_12 = 0.001

			if var_495_9 <= arg_492_1.time_ and arg_492_1.time_ < var_495_9 + var_495_12 then
				local var_495_13 = (arg_492_1.time_ - var_495_9) / var_495_12
				local var_495_14 = Vector3.New(0, -425, -200)

				var_495_8.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1137, var_495_14, var_495_13)
			end

			if arg_492_1.time_ >= var_495_9 + var_495_12 and arg_492_1.time_ < var_495_9 + var_495_12 + arg_495_0 then
				var_495_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_495_15 = arg_492_1.actors_["10157"].transform
			local var_495_16 = 0

			if var_495_16 < arg_492_1.time_ and arg_492_1.time_ <= var_495_16 + arg_495_0 then
				arg_492_1.var_.moveOldPos10157 = var_495_15.localPosition
				var_495_15.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10157", 7)

				local var_495_17 = var_495_15.childCount

				for iter_495_5 = 0, var_495_17 - 1 do
					local var_495_18 = var_495_15:GetChild(iter_495_5)

					if var_495_18.name == "" or not string.find(var_495_18.name, "split") then
						var_495_18.gameObject:SetActive(true)
					else
						var_495_18.gameObject:SetActive(false)
					end
				end
			end

			local var_495_19 = 0.001

			if var_495_16 <= arg_492_1.time_ and arg_492_1.time_ < var_495_16 + var_495_19 then
				local var_495_20 = (arg_492_1.time_ - var_495_16) / var_495_19
				local var_495_21 = Vector3.New(0, -2000, 0)

				var_495_15.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10157, var_495_21, var_495_20)
			end

			if arg_492_1.time_ >= var_495_16 + var_495_19 and arg_492_1.time_ < var_495_16 + var_495_19 + arg_495_0 then
				var_495_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_495_22 = 0
			local var_495_23 = 0.325

			if var_495_22 < arg_492_1.time_ and arg_492_1.time_ <= var_495_22 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_24 = arg_492_1:FormatText(StoryNameCfg[15].name)

				arg_492_1.leftNameTxt_.text = var_495_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_25 = arg_492_1:GetWordFromCfg(425042119)
				local var_495_26 = arg_492_1:FormatText(var_495_25.content)

				arg_492_1.text_.text = var_495_26

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_27 = 13
				local var_495_28 = utf8.len(var_495_26)
				local var_495_29 = var_495_27 <= 0 and var_495_23 or var_495_23 * (var_495_28 / var_495_27)

				if var_495_29 > 0 and var_495_23 < var_495_29 then
					arg_492_1.talkMaxDuration = var_495_29

					if var_495_29 + var_495_22 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_29 + var_495_22
					end
				end

				arg_492_1.text_.text = var_495_26
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042119", "story_v_out_425042.awb") ~= 0 then
					local var_495_30 = manager.audio:GetVoiceLength("story_v_out_425042", "425042119", "story_v_out_425042.awb") / 1000

					if var_495_30 + var_495_22 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_30 + var_495_22
					end

					if var_495_25.prefab_name ~= "" and arg_492_1.actors_[var_495_25.prefab_name] ~= nil then
						local var_495_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_25.prefab_name].transform, "story_v_out_425042", "425042119", "story_v_out_425042.awb")

						arg_492_1:RecordAudio("425042119", var_495_31)
						arg_492_1:RecordAudio("425042119", var_495_31)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_425042", "425042119", "story_v_out_425042.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_425042", "425042119", "story_v_out_425042.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_32 = math.max(var_495_23, arg_492_1.talkMaxDuration)

			if var_495_22 <= arg_492_1.time_ and arg_492_1.time_ < var_495_22 + var_495_32 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_22) / var_495_32

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_22 + var_495_32 and arg_492_1.time_ < var_495_22 + var_495_32 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
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
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play425042120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 425042120
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play425042121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1137"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps1137 == nil then
				arg_496_1.var_.actorSpriteComps1137 = var_499_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_2 = 0.2

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.actorSpriteComps1137 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps1137 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_499_3 then
						if arg_496_1.isInRecall_ then
							iter_499_3.color = arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_499_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps1137 = nil
			end

			local var_499_8 = 0
			local var_499_9 = 1.2

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

				local var_499_10 = arg_496_1:GetWordFromCfg(425042120)
				local var_499_11 = arg_496_1:FormatText(var_499_10.content)

				arg_496_1.text_.text = var_499_11

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_12 = 48
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
	Play425042121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 425042121
		arg_500_1.duration_ = 11.4

		local var_500_0 = {
			zh = 7.3,
			ja = 11.4
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
			arg_500_1.auto_ = false
		end

		function arg_500_1.playNext_(arg_502_0)
			arg_500_1.onStoryFinished_()
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1137"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps1137 == nil then
				arg_500_1.var_.actorSpriteComps1137 = var_503_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.actorSpriteComps1137 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								local var_503_4 = Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, var_503_3)
								local var_503_5 = Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, var_503_3)
								local var_503_6 = Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, var_503_3)

								iter_503_1.color = Color.New(var_503_4, var_503_5, var_503_6)
							else
								local var_503_7 = Mathf.Lerp(iter_503_1.color.r, 1, var_503_3)

								iter_503_1.color = Color.New(var_503_7, var_503_7, var_503_7)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps1137 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_503_3 then
						if arg_500_1.isInRecall_ then
							iter_503_3.color = arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_503_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_500_1.var_.actorSpriteComps1137 = nil
			end

			local var_503_8 = arg_500_1.actors_["1137"].transform
			local var_503_9 = 0

			if var_503_9 < arg_500_1.time_ and arg_500_1.time_ <= var_503_9 + arg_503_0 then
				arg_500_1.var_.moveOldPos1137 = var_503_8.localPosition
				var_503_8.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("1137", 3)

				local var_503_10 = var_503_8.childCount

				for iter_503_4 = 0, var_503_10 - 1 do
					local var_503_11 = var_503_8:GetChild(iter_503_4)

					if var_503_11.name == "split_6" or not string.find(var_503_11.name, "split") then
						var_503_11.gameObject:SetActive(true)
					else
						var_503_11.gameObject:SetActive(false)
					end
				end
			end

			local var_503_12 = 0.001

			if var_503_9 <= arg_500_1.time_ and arg_500_1.time_ < var_503_9 + var_503_12 then
				local var_503_13 = (arg_500_1.time_ - var_503_9) / var_503_12
				local var_503_14 = Vector3.New(0, -425, -200)

				var_503_8.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos1137, var_503_14, var_503_13)
			end

			if arg_500_1.time_ >= var_503_9 + var_503_12 and arg_500_1.time_ < var_503_9 + var_503_12 + arg_503_0 then
				var_503_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_503_15 = 0
			local var_503_16 = 0.675

			if var_503_15 < arg_500_1.time_ and arg_500_1.time_ <= var_503_15 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_17 = arg_500_1:FormatText(StoryNameCfg[15].name)

				arg_500_1.leftNameTxt_.text = var_503_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_18 = arg_500_1:GetWordFromCfg(425042121)
				local var_503_19 = arg_500_1:FormatText(var_503_18.content)

				arg_500_1.text_.text = var_503_19

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_20 = 27
				local var_503_21 = utf8.len(var_503_19)
				local var_503_22 = var_503_20 <= 0 and var_503_16 or var_503_16 * (var_503_21 / var_503_20)

				if var_503_22 > 0 and var_503_16 < var_503_22 then
					arg_500_1.talkMaxDuration = var_503_22

					if var_503_22 + var_503_15 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_22 + var_503_15
					end
				end

				arg_500_1.text_.text = var_503_19
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042121", "story_v_out_425042.awb") ~= 0 then
					local var_503_23 = manager.audio:GetVoiceLength("story_v_out_425042", "425042121", "story_v_out_425042.awb") / 1000

					if var_503_23 + var_503_15 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_23 + var_503_15
					end

					if var_503_18.prefab_name ~= "" and arg_500_1.actors_[var_503_18.prefab_name] ~= nil then
						local var_503_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_18.prefab_name].transform, "story_v_out_425042", "425042121", "story_v_out_425042.awb")

						arg_500_1:RecordAudio("425042121", var_503_24)
						arg_500_1:RecordAudio("425042121", var_503_24)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_425042", "425042121", "story_v_out_425042.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_425042", "425042121", "story_v_out_425042.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_25 = math.max(var_503_16, arg_500_1.talkMaxDuration)

			if var_503_15 <= arg_500_1.time_ and arg_500_1.time_ < var_503_15 + var_503_25 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_15) / var_503_25

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_15 + var_503_25 and arg_500_1.time_ < var_503_15 + var_503_25 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
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

		arg_500_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/ST2402"
	},
	voices = {
		"story_v_out_425042.awb"
	}
}
